`include "../struct.sv"
`include "../fpoperations.sv"
`include "../csrss_no.sv"

module fun_fpuH(
  clk,
  rst,
  u1_A,u1_B,u1_Bx,u1_Bxo,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_ret,u1_flg,
  u2_A,u2_B,u2_Bx,u2_Bxo,u2_en,u2_op,
  u2_fufwd_A,u2_fuufwd_A,u2_fufwd_B,u2_fuufwd_B,
  u2_ret,
  u3_A,u3_B,u3_Bx,u3_Bxo,u3_en,u3_op,
  u3_fufwd_A,u3_fuufwd_A,u3_fufwd_B,u3_fuufwd_B,
  u3_ret,u3_flg,
  u4_A,u4_B,u4_Bx,u4_Bxo,u4_en,u4_op,
  u4_fufwd_A,u4_fuufwd_A,u4_fufwd_B,u4_fuufwd_B,
  u4_ret,
  u5_A,u5_B,u5_Bx,u5_Bxo,u5_en,u5_op,
  u5_fufwd_A,u5_fuufwd_A,u5_fufwd_B,u5_fuufwd_B,
  u5_ret,u5_flg,
  u6_A,u6_B,u6_Bx,u6_Bxo,u6_en,u6_op,
  u6_fufwd_A,u6_fuufwd_A,u6_fufwd_B,u6_fuufwd_B,
  u6_ret,
  FUF0,FUF1,FUF2,
  FUF3,FUF4,FUF5,
  FUF6,FUF7,FUF8,
  FUF9,
  ALTDATA0,ALTDATA1,
  ALT_INP
  );
  localparam [0:0] H=1'b1;
  localparam SIMD_WIDTH=68; //half width
  input clk;
  input rst;
  input [67:0] u1_A;
  input [67:0] u1_B;
  input [67:0] u1_Bx;
  output [67:0] u1_Bxo;
  input [3:0] u1_en;
  input [12:0] u1_op;
  input [3:0] u1_fufwd_A;
  input [3:0] u1_fuufwd_A;
  input [3:0] u1_fufwd_B;
  input [3:0] u1_fuufwd_B;
  output [13:0] u1_ret;
  output [5:0] u1_flg;

  input [67:0] u2_A;
  input [67:0] u2_B;
  input [67:0] u2_Bx;
  output [67:0] u2_Bxo;
  input [3:0] u2_en;
  input [12:0] u2_op;
  input [3:0] u2_fufwd_A;
  input [3:0] u2_fuufwd_A;
  input [3:0] u2_fufwd_B;
  input [3:0] u2_fuufwd_B;
  output [13:0] u2_ret;
 
  input [67:0] u3_A;
  input [67:0] u3_B;
  input [67:0] u3_Bx;
  output [67:0] u3_Bxo;
  input [3:0] u3_en;
  input [12:0] u3_op;
  input [3:0] u3_fufwd_A;
  input [3:0] u3_fuufwd_A;
  input [3:0] u3_fufwd_B;
  input [3:0] u3_fuufwd_B;
  output [13:0] u3_ret;
  output [5:0] u3_flg;

  input [67:0] u4_A;
  input [67:0] u4_B;
  input [67:0] u4_Bx;
  output [67:0] u4_Bxo;
  input [3:0] u4_en;
  input [12:0] u4_op;
  input [3:0] u4_fufwd_A;
  input [3:0] u4_fuufwd_A;
  input [3:0] u4_fufwd_B;
  input [3:0] u4_fuufwd_B;
  output [13:0] u4_ret;
 
  input [67:0] u5_A;
  input [67:0] u5_B;
  input [67:0] u5_Bx;
  output [67:0] u5_Bxo;
  input [3:0] u5_en;
  input [12:0] u5_op;
  input [3:0] u5_fufwd_A;
  input [3:0] u5_fuufwd_A;
  input [3:0] u5_fufwd_B;
  input [3:0] u5_fuufwd_B;
  output [13:0] u5_ret;
  output [5:0] u5_flg;

  input [67:0] u6_A;
  input [67:0] u6_B;
  input [67:0] u6_Bx;
  output [67:0] u6_Bxo;
  input [3:0] u6_en;
  input [12:0] u6_op;
  input [3:0] u6_fufwd_A;
  input [3:0] u6_fuufwd_A;
  input [3:0] u6_fufwd_B;
  input [3:0] u6_fuufwd_B;
  output [13:0] u6_ret;
 

  input [67:0] FUF0;
  input [67:0] FUF1;
  input [67:0] FUF2;
  input [67:0] FUF3;
  inout [67:0] FUF4;
  inout [67:0] FUF5;
  inout [67:0] FUF6;
  inout [67:0] FUF7;
  inout [67:0] FUF8;
  inout [67:0] FUF9;
  input [1:0] ALT_INP;
  input [67:0] ALTDATA0;
  input [67:0] ALTDATA1;

  fun_fpu #(0,1) fpu0_mod(
  clk,
  rst,
  u1_A,u1_B,u1_Bx,u1_Bxo,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_ret,u1_flg,
  u2_A,u2_B,u2_Ax,u2_Bx,u2_en,u2_op,
  u2_fufwd_A,u2_fuufwd_A,u2_fufwd_B,u2_fuufwd_B,
  u2_ret,
  FUF0,FUF1,FUF2,
  FUF3,FUF4,FUF5,
  FUF6,FUF7,FUF8,
  FUF9,
  68'b0,68'b0,
  2'b0
  );

  fun_fpu #(1,1) fpu1_mod(
  clk,
  rst,
  u3_A,u3_B,u3_Bx,u3_Bxo,u3_en,u3_op,
  u3_fufwd_A,u3_fuufwd_A,u3_fufwd_B,u3_fuufwd_B,
  u3_ret,u3_flg,
  u4_A,u4_B,u4_Ax,u4_Bx,u4_en,u4_op,
  u4_fufwd_A,u4_fuufwd_A,u4_fufwd_B,u4_fuufwd_B,
  u4_ret,
  FUF0,FUF1,FUF2,
  FUF3,FUF4,FUF5,
  FUF6,FUF7,FUF8,
  FUF9,
  68'b0,68'b0,
  2'b0
  );

  fun_fpu #(2,1) fpu2_mod(
  clk,
  rst,
  u5_A,u5_B,u5_Bx,u5_Bxo,u5_en,u5_op,
  u5_fufwd_A,u5_fuufwd_A,u5_fufwd_B,u5_fuufwd_B,
  u5_ret,u5_flg,
  u6_A,u6_B,u6_Ax,u6_Bx,u6_en,u6_op,
  u6_fufwd_A,u6_fuufwd_A,u6_fufwd_B,u6_fuufwd_B,
  u6_ret,
  FUF0,FUF1,FUF2,
  FUF3,FUF4,FUF5,
  FUF6,FUF7,FUF8,
  FUF9,
  ALTDATA0,ALTDATA1,
  ALT_INP
  );

endmodule
