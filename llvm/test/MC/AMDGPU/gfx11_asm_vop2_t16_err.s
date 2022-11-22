// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=+wavefrontsize32,-wavefrontsize64 -show-encoding %s 2>&1 | FileCheck --check-prefix=GFX11 --implicit-check-not=error %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=-wavefrontsize32,+wavefrontsize64 -show-encoding %s 2>&1 | FileCheck --check-prefix=GFX11 --implicit-check-not=error %s

v_add_f16_e32 v255.l, v1.l, v2.l
// GFX11: error: invalid operand for instruction

v_fmaak_f16_e32 v255.l, v1.l, v2.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_fmac_f16_e32 v255.l, v1.l, v2.l
// GFX11: error: invalid operand for instruction

v_fmamk_f16_e32 v255.l, v1.l, 0xfe0b, v3.l
// GFX11: error: invalid operand for instruction

v_ldexp_f16_e32 v255.l, v1.l, v2.l
// GFX11: error: invalid operand for instruction

v_max_f16_e32 v255.l, v1.l, v2.l
// GFX11: error: invalid operand for instruction

v_min_f16_e32 v255.l, v1.l, v2.l
// GFX11: error: invalid operand for instruction

v_mul_f16_e32 v255.l, v1.l, v2.l
// GFX11: error: invalid operand for instruction

v_sub_f16_e32 v255.l, v1.l, v2.l
// GFX11: error: invalid operand for instruction

v_subrev_f16_e32 v255.l, v1.l, v2.l
// GFX11: error: invalid operand for instruction

v_add_f16_e32 v5.l, v255.l, v2.l
// GFX11: error: invalid operand for instruction

v_fmaak_f16_e32 v5.l, v255.l, v2.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_fmac_f16_e32 v5.l, v255.l, v2.l
// GFX11: error: invalid operand for instruction

v_fmamk_f16_e32 v5.l, v255.l, 0xfe0b, v3.l
// GFX11: error: invalid operand for instruction

v_ldexp_f16_e32 v5.l, v255.l, v2.l
// GFX11: error: invalid operand for instruction

v_max_f16_e32 v5.l, v255.l, v2.l
// GFX11: error: invalid operand for instruction

v_min_f16_e32 v5.l, v255.l, v2.l
// GFX11: error: invalid operand for instruction

v_mul_f16_e32 v5.l, v255.l, v2.l
// GFX11: error: invalid operand for instruction

v_sub_f16_e32 v5.l, v255.l, v2.l
// GFX11: error: invalid operand for instruction

v_subrev_f16_e32 v5.l, v255.l, v2.l
// GFX11: error: invalid operand for instruction

v_add_f16_e32 v5.l, v1.l, v255.l
// GFX11: error: invalid operand for instruction

v_fmaak_f16_e32 v5.l, v1.l, v255.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_fmac_f16_e32 v5.l, v1.l, v255.l
// GFX11: error: invalid operand for instruction

v_fmamk_f16_e32 v5.l, v1.l, 0xfe0b, v255.l
// GFX11: error: invalid operand for instruction

v_ldexp_f16_e32 v5.l, v1.l, v255.l
// GFX11: error: invalid operand for instruction

v_max_f16_e32 v5.l, v1.l, v255.l
// GFX11: error: invalid operand for instruction

v_min_f16_e32 v5.l, v1.l, v255.l
// GFX11: error: invalid operand for instruction

v_mul_f16_e32 v5.l, v1.l, v255.l
// GFX11: error: invalid operand for instruction

v_sub_f16_e32 v5.l, v1.l, v255.l
// GFX11: error: invalid operand for instruction

v_subrev_f16_e32 v5.l, v1.l, v255.l
// GFX11: error: invalid operand for instruction

v_add_f16_dpp v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fmac_f16_dpp v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ldexp_f16_dpp v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_max_f16_dpp v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_min_f16_dpp v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_mul_f16_dpp v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sub_f16_dpp v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_subrev_f16_dpp v255.l, v1.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_add_f16_dpp v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fmac_f16_dpp v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ldexp_f16_dpp v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_max_f16_dpp v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_min_f16_dpp v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_mul_f16_dpp v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sub_f16_dpp v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_subrev_f16_dpp v5.l, v255.l, v2.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_add_f16_dpp v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fmac_f16_dpp v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ldexp_f16 v5.l, v1.l, v255 quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_max_f16_dpp v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_min_f16_dpp v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_mul_f16_dpp v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sub_f16_dpp v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_subrev_f16_dpp v5.l, v1.l, v255.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_add_f16_dpp v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fmac_f16_dpp v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ldexp_f16_dpp v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_max_f16_dpp v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_min_f16_dpp v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_mul_f16_dpp v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sub_f16_dpp v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_subrev_f16_dpp v255.l, v1.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_add_f16_dpp v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fmac_f16_dpp v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ldexp_f16_dpp v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_max_f16_dpp v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_min_f16_dpp v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_mul_f16_dpp v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sub_f16_dpp v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_subrev_f16_dpp v5.l, v255.l, v2.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_add_f16_dpp v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fmac_f16_dpp v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ldexp_f16 v5.l, v1.l, v255 dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_max_f16_dpp v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_min_f16_dpp v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_mul_f16_dpp v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sub_f16_dpp v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_subrev_f16_dpp v5.l, v1.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_add_f16_e32 v255.h, v1.h, v2.h
// GFX11: error: invalid operand for instruction

v_fmaak_f16_e32 v255.h, v1.h, v2.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_fmac_f16_e32 v255.h, v1.h, v2.h
// GFX11: error: invalid operand for instruction

v_fmamk_f16_e32 v255.h, v1.h, 0xfe0b, v3.h
// GFX11: error: invalid operand for instruction

v_ldexp_f16_e32 v255.h, v1.h, v2.h
// GFX11: error: invalid operand for instruction

v_max_f16_e32 v255.h, v1.h, v2.h
// GFX11: error: invalid operand for instruction

v_min_f16_e32 v255.h, v1.h, v2.h
// GFX11: error: invalid operand for instruction

v_mul_f16_e32 v255.h, v1.h, v2.h
// GFX11: error: invalid operand for instruction

v_sub_f16_e32 v255.h, v1.h, v2.h
// GFX11: error: invalid operand for instruction

v_subrev_f16_e32 v255.h, v1.h, v2.h
// GFX11: error: invalid operand for instruction

v_add_f16_e32 v5.h, v255.h, v2.h
// GFX11: error: invalid operand for instruction

v_fmaak_f16_e32 v5.h, v255.h, v2.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_fmac_f16_e32 v5.h, v255.h, v2.h
// GFX11: error: invalid operand for instruction

v_fmamk_f16_e32 v5.h, v255.h, 0xfe0b, v3.h
// GFX11: error: invalid operand for instruction

v_ldexp_f16_e32 v5.h, v255.h, v2.h
// GFX11: error: invalid operand for instruction

v_max_f16_e32 v5.h, v255.h, v2.h
// GFX11: error: invalid operand for instruction

v_min_f16_e32 v5.h, v255.h, v2.h
// GFX11: error: invalid operand for instruction

v_mul_f16_e32 v5.h, v255.h, v2.h
// GFX11: error: invalid operand for instruction

v_sub_f16_e32 v5.h, v255.h, v2.h
// GFX11: error: invalid operand for instruction

v_subrev_f16_e32 v5.h, v255.h, v2.h
// GFX11: error: invalid operand for instruction

v_add_f16_e32 v5.h, v1.h, v255.h
// GFX11: error: invalid operand for instruction

v_fmaak_f16_e32 v5.h, v1.h, v255.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_fmac_f16_e32 v5.h, v1.h, v255.h
// GFX11: error: invalid operand for instruction

v_fmamk_f16_e32 v5.h, v1.h, 0xfe0b, v255.h
// GFX11: error: invalid operand for instruction

v_ldexp_f16_e32 v5.h, v1.h, v255.h
// GFX11: error: invalid operand for instruction

v_max_f16_e32 v5.h, v1.h, v255.h
// GFX11: error: invalid operand for instruction

v_min_f16_e32 v5.h, v1.h, v255.h
// GFX11: error: invalid operand for instruction

v_mul_f16_e32 v5.h, v1.h, v255.h
// GFX11: error: invalid operand for instruction

v_sub_f16_e32 v5.h, v1.h, v255.h
// GFX11: error: invalid operand for instruction

v_subrev_f16_e32 v5.h, v1.h, v255.h
// GFX11: error: invalid operand for instruction

v_add_f16_dpp v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fmac_f16_dpp v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ldexp_f16_dpp v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_max_f16_dpp v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_min_f16_dpp v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_mul_f16_dpp v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sub_f16_dpp v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_subrev_f16_dpp v255.h, v1.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_add_f16_dpp v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fmac_f16_dpp v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ldexp_f16_dpp v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_max_f16_dpp v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_min_f16_dpp v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_mul_f16_dpp v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sub_f16_dpp v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_subrev_f16_dpp v5.h, v255.h, v2.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_add_f16_dpp v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fmac_f16_dpp v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ldexp_f16 v5.h, v1.h, v255 quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_max_f16_dpp v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_min_f16_dpp v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_mul_f16_dpp v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sub_f16_dpp v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_subrev_f16_dpp v5.h, v1.h, v255.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_add_f16_dpp v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fmac_f16_dpp v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ldexp_f16_dpp v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_max_f16_dpp v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_min_f16_dpp v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_mul_f16_dpp v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sub_f16_dpp v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_subrev_f16_dpp v255.h, v1.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_add_f16_dpp v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fmac_f16_dpp v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ldexp_f16_dpp v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_max_f16_dpp v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_min_f16_dpp v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_mul_f16_dpp v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sub_f16_dpp v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_subrev_f16_dpp v5.h, v255.h, v2.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_add_f16_dpp v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fmac_f16_dpp v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ldexp_f16 v5.h, v1.h, v255 dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_max_f16_dpp v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_min_f16_dpp v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_mul_f16_dpp v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sub_f16_dpp v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_subrev_f16_dpp v5.h, v1.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

