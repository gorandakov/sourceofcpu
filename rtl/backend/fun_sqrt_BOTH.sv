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
//  u1_ret,u1_ret_en,
  u1_regNo,u1_II,
  en_early,op_early,
  outEn,
  outII,
  outOp,
  FUreg,
  FUSreg,
  FUwen,
  outAltDataF,
  outAltDataV,
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
  output [8:0] FUSreg;
  output FUwen;
  output [16+SIMD_WIDTH-1:0] outAltDataF;
  output [SIMD_WIDTH-1:0] outAltDataV;

  
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
  
  reg [67:0] ul_Av_reg;
  reg [67:0] ul_Bv_reg;
  reg [67:0] uh_Av_reg;
  reg [67:0] uh_Bv_reg;

  reg [1:0] ALT_INP_reg;

  wire [67:0] u1_Bxo;
  wire [67:0] u1_Bx;

  wire [2*SIMD_WIDTH-1:0] outAltDataL;
  wire [2*SIMD_WIDTH-1:0] outAltDataH;

  fun_fpusqr0 #(1) sqr_low(
  clk,
  rst,except,
  fpcsr,
  ul_A,ul_B,uh_A,uh_B,u1_en,u1_op,
  ,,u1_regNo,u1_II,
  en_early,op_early,
  outEn,
  outII,
  outOp,
  FUreg,
  FUSreg,
  FUwen,
  outAltDataF,
  fxFRT_alten,
  fxFRT_pause
  );
 
  fun_fpusqr0 #(0) sqr_hi(
  clk,
  rst,except,
  fpcsr,
  uh_Av_reg,uh_Bv_reg,ul_Av_reg,ul_Bv_reg,u1_en,u1_op,
  ,,u1_regNo,u1_II,
  en_early,op_early,
  ,//En
  ,//II
  ,//Op
  ,//FUreg
  ,//FUSreg
  ,//FUwen
  outAltDataV,
  ,
  
  );
  
  always @(posedge clk) begin
      ul_Av_reg<=ul_Av;
      uh_Av_reg<=uh_Av;
      ul_Bv_reg<=ul_Bv;
      uh_Bv_reg<=uh_Bv;
  end

endmodule
