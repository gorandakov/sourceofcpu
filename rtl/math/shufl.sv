`include "../struct.sv"


module fperm(
  clk,
  rst,
  en,
  copyA,
//  copyB,
  swpSngl,
  dupSngl,
  A,B,
  res);
  parameter C=1'b0;
  input clk;
  input rst;
  input en;
  input copyA;
  input swpSngl;
  input dupSngl;
  input [67:0] A;
  input [67:0] B;
  output [67:0] res;

  wire [67:0] resX;
  wire [67:0] res0;
  reg [67:0] res0_reg;
  reg [67:0] res0_reg2;
  reg [67:0] res0_reg3;
  reg en_reg,en_reg2,en_reg3;

  generate
    if (!C) begin
        assign res=en_reg? res0_reg : 68'bz;
    end else begin
        assign res=en_reg3? res0_reg3 : 68'bz;
    end
  endgenerate
  assign resX=(copyA & ~swpSngl) ? A : 68'bz;
  assign resX=(~copyA & ~swpSngl) ? B : 68'bz;
  assign resX=(copyA & swpSngl) ? {A[67:66],A[32:0],A[65:33]} : 68'bz;
  assign resX=(~copyA & swpSngl) ? {B[67:66],B[32:0],B[65:33]} : 68'bz;
  assign res0=dupSngl ?{resX[67:66],resX[32:0],resX[32:0]} : resX; 
  always @(negedge clk) begin
    res0_reg<=res0;
    res0_reg2<=res0_reg;
    res0_reg3<=res0_reg2;
    if (rst) en_reg<=1'b0; else en_reg<=en;
    if (rst) en_reg2<=1'b0; else en_reg2<=en_reg;
    if (rst) en_reg3<=1'b0; else en_reg3<=en_reg2;
  end

endmodule
