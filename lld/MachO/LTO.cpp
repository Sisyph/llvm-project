//===- LTO.cpp ------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "LTO.h"
#include "Config.h"
#include "Driver.h"
#include "InputFiles.h"
#include "Symbols.h"
#include "Target.h"

#include "lld/Common/Args.h"
#include "lld/Common/CommonLinkerContext.h"
#include "lld/Common/Strings.h"
#include "lld/Common/TargetOptionsCommandFlags.h"
#include "llvm/LTO/Config.h"
#include "llvm/LTO/LTO.h"
#include "llvm/Support/Caching.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/ObjCARC.h"

using namespace lld;
using namespace lld::macho;
using namespace llvm;
using namespace llvm::MachO;
using namespace llvm::sys;

static lto::Config createConfig() {
  lto::Config c;
  c.Options = initTargetOptionsFromCodeGenFlags();
  c.Options.EmitAddrsig = config->icfLevel == ICFLevel::safe;
  for (StringRef C : config->mllvmOpts)
    c.MllvmArgs.emplace_back(C.str());
  c.CodeModel = getCodeModelFromCMModel();
  c.CPU = getCPUStr();
  c.MAttrs = getMAttrs();
  c.DiagHandler = diagnosticHandler;
  c.PreCodeGenPassesHook = [](legacy::PassManager &pm) {
    pm.add(createObjCARCContractPass());
  };
  c.TimeTraceEnabled = config->timeTraceEnabled;
  c.TimeTraceGranularity = config->timeTraceGranularity;
  c.OptLevel = config->ltoo;
  c.CGOptLevel = args::getCGOptLevel(config->ltoo);
  if (config->saveTemps)
    checkError(c.addSaveTemps(config->outputFile.str() + ".",
                              /*UseInputModulePath=*/true));
  return c;
}

// If `originalPath` exists, hardlinks `path` to `originalPath`. If that fails,
// or `originalPath` is not set, saves `buffer` to `path`.
static void saveOrHardlinkBuffer(StringRef buffer, const Twine &path,
                                 Optional<StringRef> originalPath) {
  if (originalPath) {
    auto err = fs::create_hard_link(*originalPath, path);
    if (!err)
      return;
  }
  saveBuffer(buffer, path);
}

BitcodeCompiler::BitcodeCompiler() {
  lto::ThinBackend backend = lto::createInProcessThinBackend(
      heavyweight_hardware_concurrency(config->thinLTOJobs));
  ltoObj = std::make_unique<lto::LTO>(createConfig(), backend);
}

void BitcodeCompiler::add(BitcodeFile &f) {
  ArrayRef<lto::InputFile::Symbol> objSyms = f.obj->symbols();
  std::vector<lto::SymbolResolution> resols;
  resols.reserve(objSyms.size());

  // Provide a resolution to the LTO API for each symbol.
  bool exportDynamic =
      config->outputType != MH_EXECUTE || config->exportDynamic;
  auto symIt = f.symbols.begin();
  for (const lto::InputFile::Symbol &objSym : objSyms) {
    resols.emplace_back();
    lto::SymbolResolution &r = resols.back();
    Symbol *sym = *symIt++;

    // Ideally we shouldn't check for SF_Undefined but currently IRObjectFile
    // reports two symbols for module ASM defined. Without this check, lld
    // flags an undefined in IR with a definition in ASM as prevailing.
    // Once IRObjectFile is fixed to report only one symbol this hack can
    // be removed.
    r.Prevailing = !objSym.isUndefined() && sym->getFile() == &f;

    if (const auto *defined = dyn_cast<Defined>(sym)) {
      r.ExportDynamic =
          defined->isExternal() && !defined->privateExtern && exportDynamic;
      r.FinalDefinitionInLinkageUnit =
          !defined->isExternalWeakDef() && !defined->interposable;
    } else if (const auto *common = dyn_cast<CommonSymbol>(sym)) {
      r.ExportDynamic = !common->privateExtern && exportDynamic;
      r.FinalDefinitionInLinkageUnit = true;
    }

    r.VisibleToRegularObj =
        sym->isUsedInRegularObj || (r.Prevailing && r.ExportDynamic);

    // Un-define the symbol so that we don't get duplicate symbol errors when we
    // load the ObjFile emitted by LTO compilation.
    if (r.Prevailing)
      replaceSymbol<Undefined>(sym, sym->getName(), sym->getFile(),
                               RefState::Strong, /*wasBitcodeSymbol=*/true);

    // TODO: set the other resolution configs properly
  }
  checkError(ltoObj->add(std::move(f.obj), resols));
}

// Merge all the bitcode files we have seen, codegen the result
// and return the resulting ObjectFile(s).
std::vector<ObjFile *> BitcodeCompiler::compile() {
  unsigned maxTasks = ltoObj->getMaxTasks();
  buf.resize(maxTasks);
  files.resize(maxTasks);

  // The -cache_path_lto option specifies the path to a directory in which
  // to cache native object files for ThinLTO incremental builds. If a path was
  // specified, configure LTO to use it as the cache directory.
  FileCache cache;
  if (!config->thinLTOCacheDir.empty())
    cache = check(localCache("ThinLTO", "Thin", config->thinLTOCacheDir,
                             [&](size_t task, const Twine &moduleName,
                                 std::unique_ptr<MemoryBuffer> mb) {
                               files[task] = std::move(mb);
                             }));

  checkError(ltoObj->run(
      [&](size_t task, const Twine &moduleName) {
        return std::make_unique<CachedFileStream>(
            std::make_unique<raw_svector_ostream>(buf[task]));
      },
      cache));

  if (!config->thinLTOCacheDir.empty())
    pruneCache(config->thinLTOCacheDir, config->thinLTOCachePolicy, files);

  // In ThinLTO mode, Clang passes a temporary directory in -object_path_lto,
  // while the argument is a single file in FullLTO mode.
  bool objPathIsDir = true;
  if (!config->ltoObjPath.empty()) {
    if (std::error_code ec = fs::create_directories(config->ltoObjPath))
      fatal("cannot create LTO object path " + config->ltoObjPath + ": " +
            ec.message());

    if (!fs::is_directory(config->ltoObjPath)) {
      objPathIsDir = false;
      unsigned objCount =
          count_if(buf, [](const SmallString<0> &b) { return !b.empty(); });
      if (objCount > 1)
        fatal("-object_path_lto must specify a directory when using ThinLTO");
    }
  }

  std::vector<ObjFile *> ret;
  for (unsigned i = 0; i < maxTasks; ++i) {
    // Get the native object contents either from the cache or from memory.  Do
    // not use the cached MemoryBuffer directly to ensure dsymutil does not
    // race with the cache pruner.
    StringRef objBuf;
    Optional<StringRef> cachePath = llvm::None;
    if (files[i]) {
      objBuf = files[i]->getBuffer();
      cachePath = files[i]->getBufferIdentifier();
    } else {
      objBuf = buf[i];
    }
    if (objBuf.empty())
      continue;

    // FIXME: should `saveTemps` and `ltoObjPath` use the same file name?
    if (config->saveTemps)
      saveBuffer(objBuf,
                 config->outputFile + ((i == 0) ? "" : Twine(i)) + ".lto.o");

    SmallString<261> filePath("/tmp/lto.tmp");
    uint32_t modTime = 0;
    if (!config->ltoObjPath.empty()) {
      filePath = config->ltoObjPath;
      if (objPathIsDir)
        path::append(filePath, Twine(i) + "." +
                                   getArchitectureName(config->arch()) +
                                   ".lto.o");
      saveOrHardlinkBuffer(objBuf, filePath, cachePath);
      modTime = getModTime(filePath);
    }
    ret.push_back(make<ObjFile>(
        MemoryBufferRef(objBuf, saver().save(filePath.str())), modTime, ""));
  }

  return ret;
}
