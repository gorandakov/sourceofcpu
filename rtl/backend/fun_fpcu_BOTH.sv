`include "../struct.sv"
`include "../fpoperations.sv"
`include "../csrss_no.sv"

module fun_fpuH(
  clk,
  rst,
  u1_A0,u1_B0,u1_A1,u1_B1,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_ret,u1_flg,
  u2_A0,u2_B0,u2_A1,u2_B1,u2_en,u2_op,
  u2_fufwd_A,u2_fuufwd_A,u2_fufwd_B,u2_fuufwd_B,
  u2_ret,
  u3_A0,u3_B0,u3_A1,u3_B1,u3_en,u3_op,
  u3_fufwd_A,u3_fuufwd_A,u3_fufwd_B,u3_fuufwd_B,
  u3_ret,u3_flg,
  u4_A0,u4_B0,u4_A1,u4_B1,u4_en,u4_op,
  u4_fufwd_A,u4_fuufwd_A,u4_fufwd_B,u4_fuufwd_B,
  u4_ret,
  u5_A0,u5_B0,u5_A1,u5_B1,u5_en,u5_op,
  u5_fufwd_A,u5_fuufwd_A,u5_fufwd_B,u5_fuufwd_B,
  u5_ret,u5_flg,
  u6_A0,u6_B0,u6_A1,u6_B1,u6_en,u6_op,
  u6_fufwd_A,u6_fuufwd_A,u6_fufwd_B,u6_fuufwd_B,
  u6_ret,
  FUFH0,FUFH1,FUFH2,
  FUFH3,FUFH4,FUFH5,
  FUFH6,FUFH7,FUFH8,
  FUFH9,
  FUFL0,FUFL1,FUFL2,
  FUFL3,FUFL4,FUFL5,
  FUFL6,FUFL7,FUFL8,
  FUFL9,
  ALTDATAH0,ALTDATAH1,
  ALTDATAL0,ALTDATAL1,
  ALT_INP
  );
  localparam [0:0] H=1'b1;
  localparam SIMD_WIDTH=68; //half width
  input clk;
  input rst;
  input [16+67:0] u1_A0;
  input [16+67:0] u1_B0;
  input [67:0]    u1_A1;
  input [67:0]    u1_B1;
  input [3:0] u1_en;
  input [12:0] u1_op;
  input [3:0] u1_fufwd_A;
  input [3:0] u1_fuufwd_A;
  input [3:0] u1_fufwd_B;
  input [3:0] u1_fuufwd_B;
  output [13:0] u1_ret;
  output [5:0] u1_flg;

  input [16+67:0] u2_A0;
  input [16+67:0] u2_B0;
  input [67:0]    u2_A1;
  input [67:0]    u2_B1;
  input [3:0] u2_en;
  input [12:0] u2_op;
  input [3:0] u2_fufwd_A;
  input [3:0] u2_fuufwd_A;
  input [3:0] u2_fufwd_B;
  input [3:0] u2_fuufwd_B;
  output [13:0] u2_ret;
 
  input [16+67:0] u3_A0;
  input [16+67:0] u3_B0;
  input [67:0]    u3_A1;
  input [67:0]    u3_B1;
  input [3:0] u3_en;
  input [12:0] u3_op;
  input [3:0] u3_fufwd_A;
  input [3:0] u3_fuufwd_A;
  input [3:0] u3_fufwd_B;
  input [3:0] u3_fuufwd_B;
  output [13:0] u3_ret;
  output [5:0] u3_flg;

  input [16+67:0] u4_A0;
  input [16+67:0] u4_B0;
  input [67:0]    u4_A1;
  input [67:0]    u4_B1;
  input [3:0] u4_en;
  input [12:0] u4_op;
  input [3:0] u4_fufwd_A;
  input [3:0] u4_fuufwd_A;
  input [3:0] u4_fufwd_B;
  input [3:0] u4_fuufwd_B;
  output [13:0] u4_ret;
 
  input [16+67:0] u5_A0;
  input [16+67:0] u5_B0;
  input [67:0]    u5_A1;
  input [67:0]    u5_B1;
  input [3:0] u5_en;
  input [12:0] u5_op;
  input [3:0] u5_fufwd_A;
  input [3:0] u5_fuufwd_A;
  input [3:0] u5_fufwd_B;
  input [3:0] u5_fuufwd_B;
  output [13:0] u5_ret;
  output [5:0] u5_flg;

  input [16+67:0] u6_A0;
  input [16+67:0] u6_B0;
  input [67:0]    u6_A1;
  input [67:0]    u6_B1;
  input [3:0] u6_en;
  input [12:0] u6_op;
  input [3:0] u6_fufwd_A;
  input [3:0] u6_fuufwd_A;
  input [3:0] u6_fufwd_B;
  input [3:0] u6_fuufwd_B;
  output [13:0] u6_ret;
 

  input [67:0] FUFH0;
  input [67:0] FUFH1;
  input [67:0] FUFH2;
  input [67:0] FUFH3;
  inout [67:0] FUFH4;
  inout [67:0] FUFH5;
  inout [67:0] FUFH6;
  inout [67:0] FUFH7;
  inout [67:0] FUFH8;
  inout [67:0] FUFH9;
  
  input [16+67:0] FUFL0;
  input [16+67:0] FUFL1;
  input [16+67:0] FUFL2;
  input [16+67:0] FUFL3;
  inout [16+67:0] FUFL4;
  inout [16+67:0] FUFL5;
  inout [16+67:0] FUFL6;
  inout [16+67:0] FUFL7;
  inout [16+67:0] FUFL8;
  inout [16+67:0] FUFL9;
  input [1:0] ALT_INP;
  input [16+67:0] ALTDATAL0;
  input [16+67:0] ALTDATAL1;
  input [16+67:0] ALTDATAH0;
  input [16+67:0] ALTDATAH1;

  wire [67:0] u1_Ax;
  wire [67:0] u1_Bx;
  wire [67:0] u2_Ax;
  wire [67:0] u2_Bx;
  wire [67:0] u3_Ax;
  wire [67:0] u3_Bx;
  wire [67:0] u4_Ax;
  wire [67:0] u4_Bx;
  wire [67:0] u5_Ax;
  wire [67:0] u5_Bx;
  wire [67:0] u6_Ax;
  wire [67:0] u6_Bx;

  fun_fpuH hf_mod(
  clk,
  rst,
  u1_A1,u1_B1,u1_Ax,u1_Bx,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_ret,u1_flg,
  u2_A1,u2_B1,u2_Ax,u2_Bx,u2_en,u2_op,
  u2_fufwd_A,u2_fuufwd_A,u2_fufwd_B,u2_fuufwd_B,
  u2_ret,
  u3_A1,u3_B1,u3_Ax,u3_Bx,u3_en,u3_op,
  u3_fufwd_A,u3_fuufwd_A,u3_fufwd_B,u3_fuufwd_B,
  u3_ret,u3_flg,
  u4_A1,u4_B1,u4_Ax,u4_Bx,u4_en,u4_op,
  u4_fufwd_A,u4_fuufwd_A,u4_fufwd_B,u4_fuufwd_B,
  u4_ret,
  u5_A1,u5_B1,u5_Ax,u5_Bx,u5_en,u5_op,
  u5_fufwd_A,u5_fuufwd_A,u5_fufwd_B,u5_fuufwd_B,
  u5_ret,u5_flg,
  u6_A1,u6_B1,u6_Ax,u6_Bx,u6_en,u6_op,
  u6_fufwd_A,u6_fuufwd_A,u6_fufwd_B,u6_fuufwd_B,
  u6_ret,
  FUFH0,FUFH1,FUFH2,
  FUFH3,FUFH4,FUFH5,
  FUFH6,FUFH7,FUFH8,
  FUFH9,
  ALTDATAH0,ALTDATAH1,
  ALT_INP
  );

  fun_fpuL lfpc_mod(
  clk,
  rst,
  u1_A0,u1_B0,u1_Bx,u1_Ax,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_ret,u1_flg,
  u2_A0,u2_B0,u2_Bx,u2_Ax,u2_en,u2_op,
  u2_fufwd_A,u2_fuufwd_A,u2_fufwd_B,u2_fuufwd_B,
  u2_ret,
  u3_A0,u3_B0,u3_Bx,u3_Ax,u3_en,u3_op,
  u3_fufwd_A,u3_fuufwd_A,u3_fufwd_B,u3_fuufwd_B,
  u3_ret,u3_flg,
  u4_A0,u4_B0,u4_Bx,u4_Ax,u4_en,u4_op,
  u4_fufwd_A,u4_fuufwd_A,u4_fufwd_B,u4_fuufwd_B,
  u4_ret,
  u5_A0,u5_B0,u5_Bx,u5_Ax,u5_en,u5_op,
  u5_fufwd_A,u5_fuufwd_A,u5_fufwd_B,u5_fuufwd_B,
  u5_ret,u5_flg,
  u6_A0,u6_B0,u6_Bx,u6_Ax,u6_en,u6_op,
  u6_fufwd_A,u6_fuufwd_A,u6_fufwd_B,u6_fuufwd_B,
  u6_ret,
  FUFL0,FUFL1,FUFL2,
  FUFL3,FUFL4,FUFL5,
  FUFL6,FUFL7,FUFL8,
  FUFL9,
  ALTDATAL0,ALTDATAL1,
  ALT_INP
  );

endmodule
