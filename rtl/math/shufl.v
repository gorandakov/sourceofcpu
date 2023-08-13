/*
Copyright 2022 Goran Dakov

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/


`include "../struct.sv"


module fperm(
  clk,
  rst,
  en,
  copyA,
//  copyB,
  swpSngl,
  dupSngl,
  is_sqrt,
  is_div,
  tbl_read,
  tbl_write,
  xtra,
  A,B,
  res);
  parameter C=1'b0;
  input clk;
  input rst;
  input en;
  input copyA;
  input swpSngl;
  input dupSngl;
  input is_sqrt;
  input is_div;
  input tbl_read;
  input tbl_write;
  input [2:0] xtra;
  input [67:0] A;
  input [67:0] B;
  output [67:0] res;

  localparam [11:0] BIAS_D=12'd2047;
  localparam [8:0] BIAS_S=9'd255;

  wire [67:0] resX;
  wire [67:0] resY;
  wire [67:0] res0;
  reg [67:0] res0_reg;
  reg [67:0] res0_reg2;
  reg [67:0] res0_reg3;
  reg en_reg,en_reg2,en_reg3;

  wire [11:0] exp_D;
  wire [8:0] exp_X1;
  wire [8:0] exp_X;

  generate
    if (!C) begin
        assign res=en_reg? res0_reg : 68'bz;
    end else begin
        assign res=en_reg2? res0_reg2 : 68'bz;
        tblD tbl_mod(
        clk,
        rst,
        A,
        B,
        xtra,
        tbl_read,
        tbl_write,
        resY);
    end
  endgenerate
  
  adder #(12) add_dbla(BIAS_D,~{B[65],B[63:53]},exp_D,1'b1,is_sqrt,,,,);
  adder #(12) add_dblb(BIAS_D,~{1'b0,B[65],B[63:54]},exp_D,1'b1,~is_sqrt,,,,);
  adder #(9) add_snga(BIAS_S,~{B[65],B[63:56]},exp_X,1'b1,is_sqrt,,,,);
  adder #(9) add_sngb(BIAS_S,~{1'b0,B[65],B[63:57]},exp_X,1'b1,~is_sqrt,,,,);
  adder #(9) add_sngc(BIAS_S,~{B[32],B[30:23]},exp_X1,1'b1,is_sqrt,,,,);
  adder #(9) add_sngd(BIAS_S,~{1'b0,B[32],B[30:24]},exp_X1,1'b1,~is_sqrt,,,,);

  assign resY=A[67:66]==`ftype_dbl && ~tbl_read ? {B[67:66],exp_D[11],B[63],exp_D[10:0],53'b0} : 68'bz;
  assign resY=A[67:66]!=`ftype_dbl && ~tbl_read ? {B[67:66],exp_X[8],B[63],exp_X[7:0],23'b0,
    exp_X1[8],B[31],exp_X1[7:0],23'b0};

  assign resX=(copyA & ~swpSngl) ? A : 68'bz;
  assign resX=(~copyA & ~swpSngl) ? B : 68'bz;
  assign resX=(copyA & swpSngl) ? {A[67:66],A[32:0],A[65:33]} : 68'bz;
  assign resX=(~copyA & swpSngl) ? {B[67:66],B[32:0],B[65:33]} : 68'bz;
  assign res0=dupSngl ?{resX[67:66],resX[32:0],resX[32:0]} : is_sqrt|is_div ? resY : resX; 
  `ifndef swapedge
  always @(negedge clk) begin
  `else
  always @(posedge clk) begin
  `endif
    res0_reg<=res0;
    res0_reg2<=res0_reg;
    res0_reg3<=res0_reg2;
    if (rst) en_reg<=1'b0; else en_reg<=en;
    if (rst) en_reg2<=1'b0; else en_reg2<=en_reg;
    if (rst) en_reg3<=1'b0; else en_reg3<=en_reg2;
  end

endmodule
