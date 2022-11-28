// RUN: llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=+wavefrontsize32,-wavefrontsize64 -show-encoding %s 2>&1 | FileCheck --check-prefix=GFX11 --implicit-check-not=_e32 %s
// RUN: llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=-wavefrontsize32,+wavefrontsize64 -show-encoding %s 2>&1 | FileCheck --check-prefix=GFX11 --implicit-check-not=_e32 %s

v_add_f16 v255.l, v1.l, v2.l
// GFX11: v_add_f16_e64

v_fmac_f16 v255.l, v1.l, v2.l
// GFX11: v_fmac_f16_e64

v_ldexp_f16 v255.l, v1.l, v2.l
// GFX11: v_ldexp_f16_e64

v_max_f16 v255.l, v1.l, v2.l
// GFX11: v_max_f16_e64

v_min_f16 v255.l, v1.l, v2.l
// GFX11: v_min_f16_e64

v_mul_f16 v255.l, v1.l, v2.l
// GFX11: v_mul_f16_e64

v_sub_f16 v255.l, v1.l, v2.l
// GFX11: v_sub_f16_e64

v_subrev_f16 v255.l, v1.l, v2.l
// GFX11: v_subrev_f16_e64

v_add_f16 v5.l, v255.l, v2.l
// GFX11: v_add_f16_e64

v_fmac_f16 v5.l, v255.l, v2.l
// GFX11: v_fmac_f16_e64

v_ldexp_f16 v5.l, v255.l, v2.l
// GFX11: v_ldexp_f16_e64

v_max_f16 v5.l, v255.l, v2.l
// GFX11: v_max_f16_e64

v_min_f16 v5.l, v255.l, v2.l
// GFX11: v_min_f16_e64

v_mul_f16 v5.l, v255.l, v2.l
// GFX11: v_mul_f16_e64

v_sub_f16 v5.l, v255.l, v2.l
// GFX11: v_sub_f16_e64

v_subrev_f16 v5.l, v255.l, v2.l
// GFX11: v_subrev_f16_e64

v_add_f16 v5.l, v1.l, v255.l
// GFX11: v_add_f16_e64

v_fmac_f16 v5.l, v1.l, v255.l
// GFX11: v_fmac_f16_e64

v_ldexp_f16 v5.l, v1.l, v255.l
// GFX11: v_ldexp_f16_e64

v_max_f16 v5.l, v1.l, v255.l
// GFX11: v_max_f16_e64

v_min_f16 v5.l, v1.l, v255.l
// GFX11: v_min_f16_e64

v_mul_f16 v5.l, v1.l, v255.l
// GFX11: v_mul_f16_e64

v_sub_f16 v5.l, v1.l, v255.l
// GFX11: v_sub_f16_e64

v_subrev_f16 v5.l, v1.l, v255.l
// GFX11: v_subrev_f16_e64

v_add_f16 v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_add_f16_e64

v_ldexp_f16 v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_ldexp_f16_e64

v_max_f16 v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_max_f16_e64

v_min_f16 v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_min_f16_e64

v_mul_f16 v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_mul_f16_e64

v_sub_f16 v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_sub_f16_e64

v_subrev_f16 v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_subrev_f16_e64

v_add_f16 v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_add_f16_e64

v_ldexp_f16 v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_ldexp_f16_e64

v_max_f16 v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_max_f16_e64

v_min_f16 v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_min_f16_e64

v_mul_f16 v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_mul_f16_e64

v_sub_f16 v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_sub_f16_e64

v_subrev_f16 v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: v_subrev_f16_e64

v_add_f16 v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: v_add_f16_e64

v_ldexp_f16 v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: v_ldexp_f16_e64

v_max_f16 v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: v_max_f16_e64

v_min_f16 v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: v_min_f16_e64

v_mul_f16 v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: v_mul_f16_e64

v_sub_f16 v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: v_sub_f16_e64

v_subrev_f16 v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: v_subrev_f16_e64

v_add_f16 v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_add_f16_e64

v_ldexp_f16 v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_ldexp_f16_e64

v_max_f16 v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_max_f16_e64

v_min_f16 v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_min_f16_e64

v_mul_f16 v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_mul_f16_e64

v_sub_f16 v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_sub_f16_e64

v_subrev_f16 v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_subrev_f16_e64

v_add_f16 v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_add_f16_e64

v_ldexp_f16 v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_ldexp_f16_e64

v_max_f16 v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_max_f16_e64

v_min_f16 v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_min_f16_e64

v_mul_f16 v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_mul_f16_e64

v_sub_f16 v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_sub_f16_e64

v_subrev_f16 v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_subrev_f16_e64

v_add_f16 v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_add_f16_e64

v_ldexp_f16 v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_ldexp_f16_e64

v_max_f16 v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_max_f16_e64

v_min_f16 v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_min_f16_e64

v_mul_f16 v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_mul_f16_e64

v_sub_f16 v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_sub_f16_e64

v_subrev_f16 v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_subrev_f16_e64

v_add_f16 v255.h, v1.h, v2.h
// GFX11: v_add_f16_e64

v_fmac_f16 v255.h, v1.h, v2.h
// GFX11: v_fmac_f16_e64

v_ldexp_f16 v255.h, v1.h, v2.h
// GFX11: v_ldexp_f16_e64

v_max_f16 v255.h, v1.h, v2.h
// GFX11: v_max_f16_e64

v_min_f16 v255.h, v1.h, v2.h
// GFX11: v_min_f16_e64

v_mul_f16 v255.h, v1.h, v2.h
// GFX11: v_mul_f16_e64

v_sub_f16 v255.h, v1.h, v2.h
// GFX11: v_sub_f16_e64

v_subrev_f16 v255.h, v1.h, v2.h
// GFX11: v_subrev_f16_e64

v_add_f16 v5.h, v255.h, v2.h
// GFX11: v_add_f16_e64

v_fmac_f16 v5.h, v255.h, v2.h
// GFX11: v_fmac_f16_e64

v_ldexp_f16 v5.h, v255.h, v2.h
// GFX11: v_ldexp_f16_e64

v_max_f16 v5.h, v255.h, v2.h
// GFX11: v_max_f16_e64

v_min_f16 v5.h, v255.h, v2.h
// GFX11: v_min_f16_e64

v_mul_f16 v5.h, v255.h, v2.h
// GFX11: v_mul_f16_e64

v_sub_f16 v5.h, v255.h, v2.h
// GFX11: v_sub_f16_e64

v_subrev_f16 v5.h, v255.h, v2.h
// GFX11: v_subrev_f16_e64

v_add_f16 v5.h, v1.h, v255.h
// GFX11: v_add_f16_e64

v_fmac_f16 v5.h, v1.h, v255.h
// GFX11: v_fmac_f16_e64

v_ldexp_f16 v5.h, v1.h, v255.h
// GFX11: v_ldexp_f16_e64

v_max_f16 v5.h, v1.h, v255.h
// GFX11: v_max_f16_e64

v_min_f16 v5.h, v1.h, v255.h
// GFX11: v_min_f16_e64

v_mul_f16 v5.h, v1.h, v255.h
// GFX11: v_mul_f16_e64

v_sub_f16 v5.h, v1.h, v255.h
// GFX11: v_sub_f16_e64

v_subrev_f16 v5.h, v1.h, v255.h
// GFX11: v_subrev_f16_e64

v_add_f16 v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_add_f16_e64

v_ldexp_f16 v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_ldexp_f16_e64

v_max_f16 v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_max_f16_e64

v_min_f16 v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_min_f16_e64

v_mul_f16 v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_mul_f16_e64

v_sub_f16 v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_sub_f16_e64

v_subrev_f16 v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_subrev_f16_e64

v_add_f16 v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_add_f16_e64

v_ldexp_f16 v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_ldexp_f16_e64

v_max_f16 v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_max_f16_e64

v_min_f16 v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_min_f16_e64

v_mul_f16 v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_mul_f16_e64

v_sub_f16 v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_sub_f16_e64

v_subrev_f16 v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: v_subrev_f16_e64

v_add_f16 v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: v_add_f16_e64

v_ldexp_f16 v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: v_ldexp_f16_e64

v_max_f16 v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: v_max_f16_e64

v_min_f16 v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: v_min_f16_e64

v_mul_f16 v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: v_mul_f16_e64

v_sub_f16 v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: v_sub_f16_e64

v_subrev_f16 v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: v_subrev_f16_e64

v_add_f16 v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_add_f16_e64

v_ldexp_f16 v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_ldexp_f16_e64

v_max_f16 v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_max_f16_e64

v_min_f16 v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_min_f16_e64

v_mul_f16 v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_mul_f16_e64

v_sub_f16 v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_sub_f16_e64

v_subrev_f16 v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_subrev_f16_e64

v_add_f16 v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_add_f16_e64

v_ldexp_f16 v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_ldexp_f16_e64

v_max_f16 v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_max_f16_e64

v_min_f16 v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_min_f16_e64

v_mul_f16 v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_mul_f16_e64

v_sub_f16 v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_sub_f16_e64

v_subrev_f16 v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_subrev_f16_e64

v_add_f16 v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_add_f16_e64

v_ldexp_f16 v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_ldexp_f16_e64

v_max_f16 v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_max_f16_e64

v_min_f16 v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_min_f16_e64

v_mul_f16 v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_mul_f16_e64

v_sub_f16 v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_sub_f16_e64

v_subrev_f16 v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: v_subrev_f16_e64

