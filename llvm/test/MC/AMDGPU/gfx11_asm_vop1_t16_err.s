// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=+wavefrontsize32,-wavefrontsize64 -show-encoding %s 2>&1 | FileCheck --check-prefix=GFX11 --implicit-check-not=error %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1100 -mattr=-wavefrontsize32,+wavefrontsize64 -show-encoding %s 2>&1 | FileCheck --check-prefix=GFX11 --implicit-check-not=error %s

v_ceil_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_ceil_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_ceil_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v128.l, 0xaf123456
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v255.l, v255.l
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_cvt_f32_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_cvt_i32_i16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_cvt_u32_u16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_sat_pk_u8_i16_e32 v199.l, v5.l
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v128.l, 0xfe0b
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v255.l, v1.l
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v5.l, v199.l
// GFX11: error: invalid operand for instruction

v_ceil_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ceil_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v128.l, 0xaf123456 quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v255.l, v255.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f32_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_i32_i16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_u32_u16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sat_pk_u8_i16_e32 v199.l, v5.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v255.l, v1.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v5.l, v199.l quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ceil_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ceil_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v128.l, 0xaf123456 dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v255.l, v255.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f32_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_i32_i16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_u32_u16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sat_pk_u8_i16_e32 v199.l, v5.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v255.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v5.l, v199.l dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ceil_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_ceil_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_ceil_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v128.h, 0xaf123456
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v255.h, v255.h
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_cvt_f32_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_cvt_i32_i16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_cvt_u32_u16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_sat_pk_u8_i16_e32 v199.h, v5.h
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v128.h, 0xfe0b
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v255.h, v1.h
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v5.h, v199.h
// GFX11: error: invalid operand for instruction

v_ceil_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ceil_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v128.h, 0xaf123456 quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v255.h, v255.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f32_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_i32_i16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_u32_u16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sat_pk_u8_i16_e32 v199.h, v5.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v255.h, v1.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v5.h, v199.h quad_perm:[3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ceil_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_ceil_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cos_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v128.h, 0xaf123456 dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_f32_e32 v255.h, v255.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_i16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f16_u16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_f32_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_i16_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_i32_i16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_i16_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_norm_u16_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_u16_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_cvt_u32_u16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_exp_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_floor_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_fract_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_exp_i16_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_frexp_mant_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_log_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_not_b16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rcp_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rndne_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_rsq_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sat_pk_u8_i16_e32 v199.h, v5.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sin_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_sqrt_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v255.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

v_trunc_f16_e32 v5.h, v199.h dpp8:[7,6,5,4,3,2,1,0]
// GFX11: error: invalid operand for instruction

