`include "../struct.sv"
`include "../fpoperations.sv"
`include "../csrss_no.sv"

module fun_fpusqr(
  clk,
  rst,
  except,
  fpcsr,
  ul_A,ul_B,ul_Av,ul_Bv,
  uh_A,uh_B,uh_Av,uh_Bv,
  u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
//  u1_ret,u1_ret_en,
  u1_regNo,u1_II,
  en_early,op_early,
  outEn,
  outII,
  outOp,
  FUreg,
  FUwen,
  outAltData,
  FUFH0,FUFH1,FUFH2,
  FUFH3,FUFH4,FUFH5,
  FUFH6,FUFH7,FUFH8,
  FUFH9,
  FUVH0,FUVH1,FUVH2,
  FUVH3,FUVH4,FUVH5,
  FUVH6,FUVH7,FUVH8,
  FUVH9,
  FUFL0,FUFL1,FUFL2,
  FUFL3,FUFL4,FUFL5,
  FUFL6,FUFL7,FUFL8,
  FUFL9,
  FUVL0,FUVL1,FUVL2,
  FUVL3,FUVL4,FUVL5,
  FUVL6,FUVL7,FUVL8,
  FUVL9,
  fxFRT_alten,
  fxFRT_pause
  );
  parameter [1:0] INDEX=2'd2;
  parameter [0:0] H=1'b0;
  localparam SIMD_WIDTH=68; //half width
  localparam  S={27'b0,~H,4'b0};
  input clk;
  input rst;
  input except;
  input [31:0] fpcsr;
  input [S+67:0] ul_A;
  input [S+67:0] ul_B;
  input [67:0] ul_Av;
  input [67:0] ul_Bv;
  input [67:0] uh_A;
  input [67:0] uh_B;
  input [67:0] uh_Av;
  input [67:0] uh_Bv;
  input [3:0] u1_en;
  input [12:0] u1_op;
  input [3:0] u1_fufwd_A;
  input [3:0] u1_fuufwd_A;
  input [3:0] u1_fufwd_B;
  input [3:0] u1_fuufwd_B;
//  output [13:0] u1_ret;
//  output u1_ret_en;
  input [8:0] u1_regNo;
  input [9:0] u1_II;
  input [3:0] en_early;
  input [12:0] op_early;
  output [3:0] outEn;
  output [9:0] outII;
  output [12:0] outOp;
  output [8:0] FUreg;
  output FUwen;
  output [2*SIMD_WIDTH-1:0] outAltData;

  input [67:0] FUVH0;
  input [67:0] FUVH1;
  input [67:0] FUVH2;
  input [67:0] FUVH3;
  input [67:0] FUVH4;
  input [67:0] FUVH5;
  inout [67:0] FUVH6;
  input [67:0] FUVH7;
  input [67:0] FUVH8;
  input [67:0] FUVH9;

  input [67:0] FUVL0;
  input [67:0] FUVL1;
  input [67:0] FUVL2;
  input [67:0] FUVL3;
  input [67:0] FUVL4;
  input [67:0] FUVL5;
  inout [67:0] FUVL6;
  input [67:0] FUVL7;
  input [67:0] FUVL8;
  input [67:0] FUVL9;

  input [67:0] FUFH0;
  input [67:0] FUFH1;
  input [67:0] FUFH2;
  input [67:0] FUFH3;
  input [67:0] FUFH4;
  input [67:0] FUFH5;
  inout [67:0] FUFH6;
  input [67:0] FUFH7;
  input [67:0] FUFH8;
  input [67:0] FUFH9;

  input [S+67:0] FUFL0;
  input [S+67:0] FUFL1;
  input [S+67:0] FUFL2;
  input [S+67:0] FUFL3;
  input [S+67:0] FUFL4;
  input [S+67:0] FUFL5;
  inout [S+67:0] FUFL6;
  input [S+67:0] FUFL7;
  input [S+67:0] FUFL8;
  input [S+67:0] FUFL9;
  
  output [3:0] fxFRT_alten;
  output [3:0]      fxFRT_pause;

  wire [1:0][10:0] fxFCADD_raise;
  reg [10:0] fxFCADD_raise_reg[1:0];
  reg [10:0] fxFCADD_raise_s_reg[1:0];
  wire [1:0][10:0] fxFADD_raise;
  reg [10:0] fxFADD_raise_reg[1:0];
  reg [10:0] fxFADD_raise_s_reg[1:0];
  wire [10:0] fraise2;
  wire [10:0] fraise3;
  wire [10:0] fmask2;
  wire [10:0] fmask3;
  //wire [15:0] u1_Bx=u1_BH[15:0];
  //wire [15:0] u2_Bx=u2_BH[15:0];
  integer k;

  reg [1:0] ALT_INP_reg;

  wire [67:0] u1_Bxo;
  wire [67:0] u1_Bx;

  wire [2*SIMD_WIDTH-1:0] outAltDataL;
  wire [2*SIMD_WIDTH-1:0] outAltDataH;

  /*assign fraise2[m]=fxFCADD_sn_reg5[m] ?
    (fxFCADD_raise_s_reg[0]|fxFCADD_raise_s_reg[1])&fpcsr[21:11] :
    (fxFCADD_raise_reg)&fpcsr[21:11];
  assign fmask2[m]=fxFCADD_sn_reg5[m] ?
    (fxFCADD_raise_s_reg[0]|fxFCADD_raise_s_reg[1]) :
    (fxFCADD_raise_reg);
  fexcpt fexcpt2_mod(fraise2_reg,{5'b0,FUS_alu1,ex_alu1},
    fmaks2_reg,|outEn_reg6[2][3:2],u2_ret,u2_ret_en);
  assign fraise3[m]=fxFADD_sn_reg5[m] ?
    (fxFADD_raise_s_reg2[0]|fxFADD_raise_s_reg2[1])&fpcsr[21:11] :
    (fxFADD_raise_reg)&fpcsr[21:11];
  assign fmask3[m]=fxFADD_sn_reg5[m] ?
    (fxFADD_raise_s_reg[0]|fxFADD_raise_s_reg[1]) :
    (fxFADD_raise_reg);
  fexcpt fexcpt3_mod(fraise3_reg,{5'b0,FUS_alu0,ex_alu0},
    fmaks3_reg,|outEn_reg6[1][3:2],u1_ret,u1_ret_en);*/
/*module fexcpt(
  mask,
  in,
  in_mask,
  in_en,
  no,
  en);
*/
  assign outAltData=outOp==`fop_sqrtDH || outOp==`fop_divDH ? outAltDataH : outAltDataL;

  fun_fpusqr0 sqr_low(
  clk,
  rst,except,
  fpcsr,
  ul_A,ul_B,ul_Av,ul_Bv,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  ,,u1_regNo,u1_II,
  en_early,op_early,
  u1_Bx,u1_Bxo,
  outEn,
  outII,
  outOp,
  FUreg,
  FUwen,
  outAltDataL,
  FUFL0,FUFL1,FUFL2,
  FUFL3,FUFL4,FUFL5,
  FUFL6,FUFL7,FUFL8,
  FUFL9,
  FUVL0,FUVL1,FUVL2,
  FUVL3,FUVL4,FUVL5,
  FUVL6,FUVL7,FUVL8,
  FUVL9,
  fxFRT_alten,
  fxFRT_pause
  );
  fun_fpusqr0 #(1) sqr_hi(
  clk,
  rst,except,
  fpcsr,
  uh_A,uh_B,uh_Av,uh_Bv,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  ,,u1_regNo,u1_II,
  en_early,op_early,
  u1_Bxo,u1_Bx,
  ,//En
  ,//II
  ,//Op
  ,//FUreg
  ,//FUwen
  outAltDataH,
  FUFH0,FUFH1,FUFH2,
  FUFH3,FUFH4,FUFH5,
  FUFH6,FUFH7,FUFH8,
  FUFH9,
  FUVH0,FUVH1,FUVH2,
  FUVH3,FUVH4,FUVH5,
  FUVH6,FUVH7,FUVH8,
  FUVH9,
  ,
  
  );
  
  always @(posedge clk) begin
  end

endmodule
