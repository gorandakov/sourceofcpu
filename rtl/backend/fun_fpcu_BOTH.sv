`include "../struct.sv"
`include "../fpoperations.sv"
`include "../csrss_no.sv"

module fun_fpu_BOTH(
  clk,
  rst,
  fpcsr,
  u1_A0,u1_B0,u1_A1,u1_B1,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_ret,u1_ret_en,
  u2_A0,u2_B0,u2_A1,u2_B1,u2_en,u2_op,
  u2_fufwd_A,u2_fuufwd_A,u2_fufwd_B,u2_fuufwd_B,
  u2_ret,u2_ret_en,
  u3_A0,u3_B0,u3_A1,u3_B1,u3_en,u3_op,
  u3_fufwd_A,u3_fuufwd_A,u3_fufwd_B,u3_fuufwd_B,
  u3_ret,u3_ret_en,
  u4_A0,u4_B0,u4_A1,u4_B1,u4_en,u4_op,
  u4_fufwd_A,u4_fuufwd_A,u4_fufwd_B,u4_fuufwd_B,
  u4_ret,u4_ret_en,
  u5_A0,u5_B0,u5_A1,u5_B1,u5_en,u5_op,
  u5_fufwd_A,u5_fuufwd_A,u5_fufwd_B,u5_fuufwd_B,
  u5_ret,u5_ret_en,
  u6_A0,u6_B0,u6_A1,u6_B1,u6_en,u6_op,
  u6_fufwd_A,u6_fuufwd_A,u6_fufwd_B,u6_fuufwd_B,
  u6_ret,u6_ret_en,
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
  ALT_INP,
  FUS_alu0,FUS_alu1,
  FUS_alu2,FUS_alu3,
  FUS_alu4,FUS_alu5,
  ex_alu0,ex_alu1,
  ex_alu2,ex_alu3,
  ex_alu4,ex_alu5,
  fxFADD0_raise_s,
  fxFCADD1_raise_s,
  fxFADD2_raise_s,
  fxFCADD3_raise_s,
  fxFADD4_raise_s,
  fxFCADD5_raise_s,
  FUS0,FUS1,FUS2,
  FOOSL0,FOOSL1,FOOSL2
  );
  localparam [0:0] H=1'b1;
  localparam SIMD_WIDTH=68; //half width
  input clk;
  input rst;
  input [31:0] fpcsr;
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
  output u1_ret_en;

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
  output u2_ret_en;
 
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
  output u3_ret_en;

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
  output u4_ret_en;
 
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
  output u5_ret_en;

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
  output u6_ret_en;
 

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

  input [5:0] FUS_alu0;
  input [5:0] FUS_alu1;
  input [5:0] FUS_alu2;
  input [5:0] FUS_alu3;
  input [5:0] FUS_alu4;
  input [5:0] FUS_alu5;
  input [2:0] ex_alu0;
  input [2:0] ex_alu1;
  input [2:0] ex_alu2;
  input [2:0] ex_alu3;
  input [2:0] ex_alu4;
  input [2:0] ex_alu5;
  input [10:0] fxFADD0_raise_s;
  input [10:0] fxFCADD1_raise_s;
  input [10:0] fxFADD2_raise_s;
  input [10:0] fxFCADD3_raise_s;
  input [10:0] fxFADD4_raise_s;
  input [10:0] fxFCADD5_raise_s;

  output [5:0] FUS0;
  output [5:0] FUS1;
  output [5:0] FUS2;

  input [5:0] FOOSL0;
  input [5:0] FOOSL1;
  input [5:0] FOOSL2;
  
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

  wire [13:0] u1_retH;
  wire u1_ret_enH;
  wire [13:0] u2_retH;
  wire u2_ret_enH;
  wire [13:0] u3_retH;
  wire u3_ret_enH;
  wire [13:0] u4_retH;
  wire u4_ret_enH;
  wire [13:0] u5_retH;
  wire u5_ret_enH;
  wire [13:0] u6_retH;
  wire u6_ret_enH;
  wire [13:0] u1_retL;
  wire u1_ret_enL;
  wire [13:0] u2_retL;
  wire u2_ret_enL;
  wire [13:0] u3_retL;
  wire u3_ret_enL;
  wire [13:0] u4_retL;
  wire u4_ret_enL;
  wire [13:0] u5_retL;
  wire u5_ret_enL;
  wire [13:0] u6_retL;
  wire u6_ret_enL;

  assign u1_ret=u1_retL|u1_retH;
  assign u1_ret_en=u1_ret_enL| u1_ret_enH;
  assign u2_ret=u2_retL|u2_retH;
  assign u2_ret_en=u2_ret_enL| u2_ret_enH;
  assign u3_ret=u3_retL|u3_retH;
  assign u3_ret_en=u3_ret_enL| u3_ret_enH;
  assign u4_ret=u4_retL|u4_retH;
  assign u4_ret_en=u4_ret_enL| u4_ret_enH;
  assign u5_ret=u5_retL|u5_retH;
  assign u5_ret_en=u5_ret_enL| u5_ret_enH;
  assign u6_ret=u6_retL|u6_retH;
  assign u6_ret_en=u6_ret_enL| u6_ret_enH;

  fun_fpuH hf_mod(
  clk,
  rst,
  fpcsr,
  u1_A1,u1_B1,u1_Ax,u1_Bx,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_retH,u1_ret_enH,
  u2_A1,u2_B1,u2_Ax,u2_Bx,u2_en,u2_op,
  u2_fufwd_A,u2_fuufwd_A,u2_fufwd_B,u2_fuufwd_B,
  u2_retH,u2_ret_enH,
  u3_A1,u3_B1,u3_Ax,u3_Bx,u3_en,u3_op,
  u3_fufwd_A,u3_fuufwd_A,u3_fufwd_B,u3_fuufwd_B,
  u3_retH,u3_ret_enH,
  u4_A1,u4_B1,u4_Ax,u4_Bx,u4_en,u4_op,
  u4_fufwd_A,u4_fuufwd_A,u4_fufwd_B,u4_fuufwd_B,
  u4_retH,u4_ret_enH,
  u5_A1,u5_B1,u5_Ax,u5_Bx,u5_en,u5_op,
  u5_fufwd_A,u5_fuufwd_A,u5_fufwd_B,u5_fuufwd_B,
  u5_retH,u5_ret_enH,
  u6_A1,u6_B1,u6_Ax,u6_Bx,u6_en,u6_op,
  u6_fufwd_A,u6_fuufwd_A,u6_fufwd_B,u6_fuufwd_B,
  u6_retH,u6_ret_enH,
  FUFH0,FUFH1,FUFH2,
  FUFH3,FUFH4,FUFH5,
  FUFH6,FUFH7,FUFH8,
  FUFH9,
  ALTDATAH0,ALTDATAH1,
  ALT_INP,
  FUS_alu0,FUS_alu1,
  FUS_alu2,FUS_alu3,
  FUS_alu4,FUS_alu5,
  ex_alu0,ex_alu1,
  ex_alu2,ex_alu3,
  ex_alu4,ex_alu5,
  fxFADD0_raise_s,
  fxFCADD1_raise_s,
  fxFADD2_raise_s,
  fxFCADD3_raise_s,
  fxFADD4_raise_s,
  fxFCADD5_raise_s,
  FOOSL0_reg, HFOOSH0,
  FOOSL1_reg, HFOOSH1,
  FOOSL2_reg, HFOOSH2
  ); 

  fun_fpuL lfpc_mod(
  clk,
  rst,
  fpcsr,
  u1_A0,u1_B0,u1_Bx,u1_Ax,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_retL,u1_ret_enL,
  u2_A0,u2_B0,u2_Bx,u2_Ax,u2_en,u2_op,
  u2_fufwd_A,u2_fuufwd_A,u2_fufwd_B,u2_fuufwd_B,
  u2_retL,u2_ret_enL,
  u3_A0,u3_B0,u3_Bx,u3_Ax,u3_en,u3_op,
  u3_fufwd_A,u3_fuufwd_A,u3_fufwd_B,u3_fuufwd_B,
  u3_retL,u3_ret_enL,
  u4_A0,u4_B0,u4_Bx,u4_Ax,u4_en,u4_op,
  u4_fufwd_A,u4_fuufwd_A,u4_fufwd_B,u4_fuufwd_B,
  u4_retL,u4_ret_enL,
  u5_A0,u5_B0,u5_Bx,u5_Ax,u5_en,u5_op,
  u5_fufwd_A,u5_fuufwd_A,u5_fufwd_B,u5_fuufwd_B,
  u5_retL,u5_ret_enL,
  u6_A0,u6_B0,u6_Bx,u6_Ax,u6_en,u6_op,
  u6_fufwd_A,u6_fuufwd_A,u6_fufwd_B,u6_fuufwd_B,
  u6_retL,u6_ret_enL,
  FUFL0,FUFL1,FUFL2,
  FUFL3,FUFL4,FUFL5,
  FUFL6,FUFL7,FUFL8,
  FUFL9,
  ALTDATAL0,ALTDATAL1,
  ALT_INP,
  FUS_alu0,FUS_alu1,
  FUS_alu2,FUS_alu3,
  FUS_alu4,FUS_alu5,
  ex_alu0,ex_alu1,
  ex_alu2,ex_alu3,
  ex_alu4,ex_alu5,
  fxFADD0_raise_s,
  fxFCADD1_raise_s,
  fxFADD2_raise_s,
  fxFCADD3_raise_s,
  fxFADD4_raise_s,
  fxFCADD5_raise_s,
  FOOSL0_reg, LFOOSH0,
  FOOSL1_reg, LFOOSH1,
  FOOSL2_reg, LFOOSH2
  );

  assign FUS0=u1_op_reg4[7:0]==`fop_cmpDH  ? HFOOSH0 : LFOOSH0; 
  assign FUS1=u3_op_reg4[7:0]==`fop_cmpDH  ? HFOOSH1 : LFOOSH1; 
  assign FUS2=u5_op_reg4[7:0]==`fop_cmpDH  ? HFOOSH2 : LFOOSH2; 

endmodule
