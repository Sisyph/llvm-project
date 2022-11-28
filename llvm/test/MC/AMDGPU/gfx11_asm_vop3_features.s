// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=+wavefrontsize32,-wavefrontsize64 -show-encoding %s | FileCheck --check-prefixes=GFX11,W32 %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=-wavefrontsize32,+wavefrontsize64 -show-encoding %s | FileCheck --check-prefixes=GFX11,W64 %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=+wavefrontsize32,-wavefrontsize64 %s 2>&1 | FileCheck --check-prefixes=W32-ERR,GFX11-ERR --implicit-check-not=error: %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=-wavefrontsize32,+wavefrontsize64 %s 2>&1 | FileCheck --check-prefixes=W64-ERR,GFX11-ERR --implicit-check-not=error: %s

//===----------------------------------------------------------------------===//
// HW does not correctly handles fp inline constants for src2 (they have u16 type).
// Check that inline constants are converted to literals.
//===----------------------------------------------------------------------===//

v_alignbit_b32 v5, v1, v2, 0.5
// GFX11: [0x05,0x00,0x16,0xd6,0x01,0x05,0xfe,0x03,0x00,0x38,0x00,0x00]

v_alignbyte_b32 v5, v1, v2, 0.5
// GFX11: [0x05,0x00,0x17,0xd6,0x01,0x05,0xfe,0x03,0x00,0x38,0x00,0x00]

//===----------------------------------------------------------------------===//
// HW correctly handles fp inline constants for src2 (they have f16 type).
// Check that inline constants are not converted to literals.
//===----------------------------------------------------------------------===//

v_cmp_class_f16_e64 s[10:11], v1.l, 0.5
// W64: [0x0a,0x00,0x7d,0xd4,0x01,0xe1,0x01,0x00]
// W32-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: invalid operand for instruction

v_cmp_class_f16_e64 s10, v1.l, 0.5
// W32: [0x0a,0x00,0x7d,0xd4,0x01,0xe1,0x01,0x00]
// W64-ERR: :[[@LINE-2]]:{{[0-9]+}}: error: invalid operand for instruction

v_cmpx_class_f16_e64 v1.l, 0.5
// GFX11: [0x7e,0x00,0xfd,0xd4,0x01,0xe1,0x01,0x00]

//===----------------------------------------------------------------------===//
// src0 and src2 are packed operands.
// Check that op_sel is not allowed with these operands.
//===----------------------------------------------------------------------===//

v_dot2_f16_f16_e64 v0.l, v1.h, v2, v3.l
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error:

v_dot2_f16_f16_e64_dpp v0.l, v1, v2.h, v3.l dpp8:[0,1,2,3,4,4,4,4]
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error:

v_dot2_f16_f16_e64_dpp v0.l, v1.h, v2, v3.l quad_perm:[0,1,2,3] row_mask:0x0 bank_mask:0x0 fi:1
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error:

v_dot2_bf16_bf16_e64 v0.l, v1, v2.h, v3.l
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error:

v_dot2_bf16_bf16_e64_dpp v0.l, v1.h, v2, v3.l dpp8:[0,1,2,3,4,4,4,4]
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error:

v_dot2_bf16_bf16_e64_dpp v0.l, v1, v2.h, v3.l quad_perm:[0,1,2,3] row_mask:0x0 bank_mask:0x0 fi:1
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error:

//===----------------------------------------------------------------------===//
// src0 and src1 are vector operands.
// Check that SGPRs are not allowed for these operands.
//===----------------------------------------------------------------------===//

v_dot2_f16_f16_e64_dpp v0.l, s1, v2, v3.l dpp8:[0,1,2,3,4,4,4,4]
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

v_dot2_f16_f16_e64_dpp v0.l, v1, s2, v3.l dpp8:[0,1,2,3,4,4,4,4]
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

v_dot2_f16_f16_e64_dpp v0.l, s1, v2, v3.l quad_perm:[0,1,2,3] row_mask:0x0 bank_mask:0x0 fi:1
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

v_dot2_f16_f16_e64_dpp v0.l, v1, s2, v3.l quad_perm:[0,1,2,3] row_mask:0x0 bank_mask:0x0 fi:1
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

v_dot2_bf16_bf16_e64_dpp v0.l, s1, v2, v3.l dpp8:[0,1,2,3,4,4,4,4]
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

v_dot2_bf16_bf16_e64_dpp v0.l, v1, s2, v3.l dpp8:[0,1,2,3,4,4,4,4]
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

v_dot2_bf16_bf16_e64_dpp v0.l, s1, v2, v3.l quad_perm:[0,1,2,3] row_mask:0x0 bank_mask:0x0
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction

v_dot2_bf16_bf16_e64_dpp v0.l, v1, s2, v3.l quad_perm:[0,1,2,3] row_mask:0x0 bank_mask:0x0
// GFX11-ERR: :[[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction
