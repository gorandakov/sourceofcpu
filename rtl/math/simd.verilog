/*
Copyright 2022-2024 Goran Dakov, see additional restriction in copying.txt

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
`include "../intop.v"

module add_sat(
  A,B,res,is_sign,is_sat,is_min,is_max,is_sub,is_simpl,is_subcmp,is_cmp,jump_type);
  parameter WIDTH=16;
  input [WIDTH-1:0] A;
  input [WIDTH-1:0] B;
  output [WIDTH-1:0] res;
  input is_sign,is_sat,is_min,is_max,is_sub,is_simpl,is_subcmp,is_cmp;
  input [3:0] jump_type;

  wire [WIDTH-1:0] res_X;
  assign res=res_X;

  wire [WIDTH-1:0] Bx;
  wire [WIDTH-1:0] res1;
  wire en,cout,ovfl_A,ovfl_S,min0,do_jmp;
  wire [5:0] flags;
  assign Bx=is_subcmp ?~B :B;
  adder2o #(WIDTH) add_mod(A,Bx,res,res1,is_subcmp,en,1'b1,cout,,,);
  assign en=is_simpl || is_sat&~is_sign&~is_sub&~cout||is_sat&~is_sign&is_sub&cout||
  is_sat&is_sign&~ovfl_A||is_sat&is_sign&~ovfl_S;
  assign res_X=(is_sat&~is_sign&~is_sub&cout) ? {WIDTH{1'B1}} : 'z;
  assign res_X=(is_sat&~is_sign&is_sub&~cout) ? {WIDTH{1'B0}} : 'z;
  assign res_X=(is_sat&is_sign&ovfl_A) ? {WIDTH{1'B1}} : 'z;
  assign res_X=(is_sat&is_sign&ovfl_S) ? {WIDTH{1'B0}} : 'z;
  assign min0=(is_sign && res1[WIDTH-1] ^ (ovfl_A|ovfl_S)) ||
      (~is_sign & ~cout);
  assign res_X=(is_min&min0 ||is_max&~min0) ? A : 'z;
  assign res_X=(is_min&min0 ||is_max&~min0) ? A : 'z;
  assign ovfl_S=A[WIDTH-1] & Bx[WIDTH-1] & ~res1[WIDTH-1];
  assign ovfl_A=~A[WIDTH-1] & ~Bx[WIDTH-1] & res1[WIDTH-1];

  assign flags={cout,ovfl_A|ovfl_S,1'b0,res1[WIDTH-1],A==B,1'b0};

  except_jump_cmp jcmp_mod(flags,{1'b0,jump_type},do_jmp);

  assign res_X=is_cmp ? {WIDTH{do_jmp}}:'z;

endmodule


module simd_non_socialiste(
  clk,
  rst,
  en,
  operation,
  A,
  B,
  res
  );
  input clk;
  input rst;
  input en;
  input [12:0] operation;
  input [67:0] A;
  input [67:0] B;
  output [67:0] res;
  
  wire [67:0] res_X;
  assign res=res_X;

  reg out8,out16,out32,out64,outL;
  wire [4:1][63:0] resD;
  reg  [4:1][63:0] resD_reg;
  reg is_sign,is_sat,is_min,is_max,is_sub,is_simpl,is_subcmp,is_cmp;
  reg [3:0] jump_type;
  reg[63:0] A_reg;
  reg[63:0] B_reg;
  reg [63:0] resL;
  reg [12:0] operation_reg;
  reg shSH_reg;
  wire shSH;
  reg [63:0] resSH_reg;
  wire [63:0] resSH;
  reg en_reg;
  reg en_reg2;
  wire [63:0] resh;

  assign resh=out8&~outL&~shSH_reg ? resD_reg[1] : 64'bz;
  assign resh=out16&~outL&~shSH_reg ? resD_reg[2] : 64'bz;
  assign resh=out32&~outL&~shSH_reg ? resD_reg[3] : 64'bz;
  assign resh=out64&outL&~shSH_reg ? resD_reg[4] : 64'bz;
  assign resh=outL&~shSH_reg ? resL : 64'bz;
  assign resh=shSH_reg ? resSH_reg : 64'bz; 
  
  simd_sasquach_shift sh_mod(
  clk,
  rst,
  operation,
  {A[64:33],A[31:0]},
  {B[64:33],B[31:0]},
  resSH,
  shSH
  );

  assign res_X=en_reg2 ? {2'd`ptype_int,1'b0,resh[63:32],1'b0,resh[31:0]} : 68'bz;
  generate
      genvar d;
      for(d=0;d<8;d=d+1) begin
          add_sat #(8) add8_mod(A_reg[d*8+:8],B_reg[d*8+:8],resD[1][d*8+:8],is_sign,is_sat,is_min,is_max,is_sub,
	    is_simpl,is_subcmp,is_cmp,jump_type);
          if (d<4)
              add_sat #(16) add16_mod(A_reg[d*16+:16],B_reg[d*16+:16],resD[2][d*16+:16],is_sign,is_sat,is_min,is_max,
	        is_sub,is_simpl,is_subcmp,is_cmp,jump_type);
          if (d<2)
              add_sat #(32) add32_mod(A_reg[d*32+:32],B_reg[d*32+:32],resD[3][d*32+:32],is_sign,is_sat,is_min,is_max,
	        is_sub,is_simpl,is_subcmp,is_cmp,jump_type);
          if (d<1)
              add_sat #(64) add64_mod(A_reg[d*64+:64],B_reg[d*64+:64],resD[4][d*64+:64],is_sign,is_sat,is_min,is_max,
	        is_sub,is_simpl,is_subcmp,is_cmp,jump_type);
      end
  endgenerate
  `ifndef swapedge
  always @(negedge clk) begin
  `else
  always @(posedge clk) begin
  `endif
      A_reg<={A[64:33],A[31:0]};
      B_reg<={B[64:33],B[31:0]};
      is_sign<=operation[5:0]==`simd_paddsats ||operation[5:0]==`simd_psubsats||operation[5:0]==`simd_pmins||
        operation[5:0]==`simd_pmaxs;
      is_sat<=operation[5:0]==`simd_paddsats || operation[5:0]==`simd_psubsats ||operation[5:0]==`simd_paddsat||
        operation[5:0]==`simd_psubsat;
      is_min<=operation[5:0]==`simd_pmins || operation[5:0]==`simd_pmin;
      is_max<=operation[5:0]==`simd_pmaxs || operation[5:0]==`simd_pmax;
      is_sub<=operation[5:0]==`simd_psubsats ||operation[5:0]==`simd_psubsat|| operation[5:0]==`simd_psub;
      is_simpl<=operation[5:0]==`simd_psub || operation[5:0]==`simd_padd;
      is_subcmp=operation[5:0]==`simd_psub || operation[5:0]==`simd_cmp || operation[5:0]==`simd_psubsats ||
        operation[5:0]==`simd_psubsat || operation[5:0]==`simd_pmins ||operation[5:0]==`simd_pmaxs||operation[5:0]
	==`simd_pmin||operation[5:0]==`simd_pmax;
      is_cmp<=operation[5:0]==`simd_cmp;
      jump_type<={operation[12],operation[9:8],1'b0};
      resD_reg[1]<=resD[1];
      resD_reg[2]<=resD[2];
      resD_reg[3]<=resD[3];
      resD_reg[4]<=resD[4];
      operation_reg<=operation;
      out8<=operation_reg[7:6]==2'd0;
      out16<=operation_reg[7:6]==2'd2;
      out32<=operation_reg[7:6]==2'd1;
      out64<=operation_reg[7:6]==2'd3;
      outL<=1'b1;
      shSH_reg<=shSH;
      resSH_reg<=resSH;
      if (rst) begin
	  en_reg<=1'b0;
	  en_reg2<=1'b0;
      end else begin
          en_reg<=en;
          en_reg2<=en_reg;
      end
      case(operation_reg[7:0])
      `simd_pand: resL<=A_reg & B_reg;
      `simd_por: resL<=A_reg | B_reg;
      `simd_pxor: resL<=A_reg ^ B_reg;
      `simd_pnand: resL<=A_reg & ~B_reg;
      `simd_pnor: resL<=~(A_reg | B_reg);
      `simd_pnxor: resL<=A_reg ~^ B_reg;
      `simd_pmov,8'hff: resL<=B_reg;
      `simd_pnot:resL<=~B_reg;
      default: outL<=1'b0;
      endcase
  end
endmodule


module simd_sasquach_shift(
  clk,
  rst,
  operation,
  A,
  B,
  res,
  sh
  );
  input clk;
  input rst;
  input [12:0] operation;
  input [63:0] A;
  input [63:0] B;
  output [63:0] res;
  output reg sh;
  reg dir;
  wire [63:0] shf8;
  wire [63:0] shf16;
  reg [63:0] A_reg;
  reg [63:0] B_reg;
  reg [63:0] shf;
  reg [7:0] fill8;
  reg [3:0] fill16;
  reg [12:0] operation_reg;

  generate
      genvar k;
      for(k=0;k<8;k=k+1) begin
          //verilator lint_off WIDTH  
          assign shf8[k*8+:8]=(B_reg[k*8+:3]==k & dir) ? {{8{fill8[k]}},A_reg[k*8+:8]}>>k : 8'bz;
          assign shf8[k*8+:8]=(B_reg[k*8+:3]==k & ~dir) ? A_reg[k*8+:8]<<k : 8'bz;
          if (k<4) assign shf16[k*16+:16]=(B_reg[k*16+:4]==k & dir) ? {{16{fill16[k]}},A_reg[k*16+:16]}>>k : 16'bz;
          if (k<4) assign shf16[k*16+:16]=(B_reg[k*16+:4]==k & ~dir) ? A_reg[k*16+:16]>>k : 16'bz;
          //verilator lint_on WIDTH  
      end
  endgenerate

  assign res=operation_reg[7:6]!=2'b0 ? shf16 : shf8;

  `ifndef swapedge
  always @(negedge clk) begin
  `else
  always @(posedge clk) begin
  `endif
      A_reg<=A;
      B_reg<=B;
      dir<=operation[5:0]==`simd_shr || operation[5:0]==`simd_sar;
      fill16<={4{operation[5:0]==`simd_sar}} & {A[63],A[47],A[31],A[15]};
      fill8<={8{operation[5:0]==`simd_sar}} & {A[63],A[55],A[47],A[39],A[31],A[23],A[15],A[7]};
      shf<=operation[6] ? shf16 : shf8;
      sh<=operation[5:0]==`simd_sar || operation[5:0]==`simd_shr || operation[5:0]==`simd_shl;
  end
endmodule

