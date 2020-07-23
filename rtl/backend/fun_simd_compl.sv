`include "../struct.sv"
`include "../operations.sv"

module fu_alu_compl(
  clk,
  rst,
  except,
  u1_A,u1_B,u1_op,u1_clkEn,
    u1_A_fufwd,u1_A_fuufwd,u1_B_fufwd,u1_B_fuufwd,
  u2_A,u2_B,u2_op,u2_clkEn,
    u2_A_fufwd,u2_A_fuufwd,u2_B_fufwd,u2_B_fuufwd,
  u3_A,u3_B,u3_op,u3_clkEn,
    u3_A_fufwd,u3_A_fuufwd,u3_B_fufwd,u3_B_fuufwd,
  FU0, FU1,  FU2,  FU3,
  FU4, FU5,  FU6,  FU7,
  FU8, FU9,
  //fxFRT_alten_reg,
  //fcvtout,
  //DataAlt
  );

  input clk;
  input rst;
  input except;

  input [63:0]          u1_A;
  input [63:0]          u1_B;
  input [12:0]          u1_op;
  input                 u1_clkEn;
  input [3:0]           u1_A_fufwd;
  input [3:0]           u1_A_fuufwd;
  input [3:0]           u1_B_fufwd;
  input [3:0]           u1_B_fuufwd;

  input [63:0]          u2_A;
  input [63:0]          u2_B;
  input [12:0]          u2_op;
  input                 u2_clkEn;
  input [3:0]           u2_A_fufwd;
  input [3:0]           u2_A_fuufwd;
  input [3:0]           u2_B_fufwd;
  input [3:0]           u2_B_fuufwd;

  input [63:0]          u3_A;
  input [63:0]          u3_B;
  input [12:0]          u3_op;
  input                 u3_clkEn;
  input [3:0]           u3_A_fufwd;
  input [3:0]           u3_A_fuufwd;
  input [3:0]           u3_B_fufwd;
  input [3:0]           u3_B_fuufwd;


  input [63:0] FU0;
  input [63:0] FU1;
  input [63:0] FU2;
  input [63:0] FU3;
  inout [63:0] FU4;
  inout [63:0] FU5;
  inout [63:0] FU6;
  inout [63:0] FU7;
  inout [63:0] FU8;
  inout [63:0] FU9;


//  input fxFRT_alten_reg;

//  output [83:0] fcvtout;
//  output [1:0] DataAlt;

  reg [1:0] nDataAlt;
  reg [1:0] nDataAlt_reg;
  reg u5_nDataAlt_reg;
  reg [63:0] FU0_reg;
  reg [63:0] FU1_reg;
  reg [63:0] FU2_reg;
  reg [63:0] FU3_reg;
  reg [63:0] FU4_reg;
  reg [63:0] FU5_reg;
  reg [63:0] FU6_reg;
  reg [63:0] FU7_reg;
  reg [63:0] FU8_reg;
  reg [63:0] FU9_reg;
  
  wire [63:0] uu_A1;
  wire [63:0] uu_B1;
  wire [63:0] uu_A2;
  wire [63:0] uu_B2;
  wire [63:0] uu_A3;
  wire [63:0] uu_B3;


  reg fxFRT_alten_reg2;
  reg fxFRT_alten_reg3;

  reg [12:0] u1_op_reg;
  reg [12:0] u2_op_reg;
  reg [12:0] u3_op_reg;

  reg u1_clkEn_reg;
  reg u2_clkEn_reg;
  reg u3_clkEn_reg;


  rs_write_forward #(64) u1_A_fwd(
  clk,rst,
  ~u1_clkEn,
  u1_A,uu_A1,
  u1_A_fufwd,u1_A_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(64) u1_B_fwd(
  clk,rst,
  ~u1_clkEn,
  u1_B,uu_B1,
  u1_B_fufwd,u1_B_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  
  rs_write_forward #(64) u2_A_fwd(
  clk,rst,
  ~u2_clkEn,
  u2_A,uu_A2,
  u2_A_fufwd,u2_A_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(64) u2_B_fwd(
  clk,rst,
  ~u2_clkEn,
  u2_B,uu_B2,
  u2_B_fufwd,u2_B_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  
  rs_write_forward #(64) u3_A_fwd(
  clk,rst,
  ~u3_clkEn,
  u3_A,uu_A3,
  u3_A_fufwd,u3_A_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(64) u3_B_fwd(
  clk,rst,
  ~u3_clkEn,
  u3_B,uu_B3,
  u3_B_fufwd,u3_B_fuufwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  
  simd_sasquach scalu0(
  clk, rst, u1_op_reg,
  uu_A1,uu_B1,FU7
  );
  simd_sasquach scalu1(
  clk, rst, u2_op_reg,
  uu_A2,uu_B2,FU8
  );
  simd_sasquach scalu2(
  clk, rst, u3_op_reg,
  uu_A3,uu_B3,FU9
  );

//  assign fcvtout={FUCVT2_0[81:66],FUTYPE_0,FUCVT2_0[65:0]};
 
//  assign FU6=(~&nDataAlt) ? FUMUL : 64'bz;
//  assign u5_ret=(~u5_nDataAlt_reg|(~nDataAlt_reg[1])) ? {6'b0,1'b0,2'd2} : 
//    9'bz; 
//  assign u5_ret=u5_nDataAlt_reg&~nDataAlt_reg[0] ? {MULFL,~u6_op_reg4[12],
//    2'd2} : 9'bz; 
//  assign u5_rten=(~u5_nDataAlt_reg|(~&nDataAlt_reg)) ? nDataAlt_reg[1] : 
//    1'bz; 

  always @(posedge clk) begin

      FU0_reg<=FU0;
      FU1_reg<=FU1;
      FU2_reg<=FU2;
      FU3_reg<=FU3;
      FU4_reg<=FU4;
      FU5_reg<=FU5;
      FU6_reg<=FU6;
      FU7_reg<=FU7;
      FU8_reg<=FU8;
      FU9_reg<=FU9;
      

      u1_clkEn_reg<=u1_clkEn;
      u2_clkEn_reg<=u2_clkEn;
      u3_clkEn_reg<=u3_clkEn;

      u1_op_reg<=u1_op;
      u2_op_reg<=u2_op;
      u3_op_reg<=u3_op;


//      fxFRT_alten_reg2<=fxFRT_alten_reg;
//      fxFRT_alten_reg3<=fxFRT_alten_reg2;
//      nDataAlt<=~DataAlt;
//      nDataAlt_reg<=nDataAlt;
//      u5_nDataAlt_reg<=u5_nDataAlt;
  end
endmodule

