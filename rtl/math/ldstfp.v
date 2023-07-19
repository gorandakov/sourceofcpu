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

//exponent in ext is 16'b8011111...exp
module ldD2nativeD(
  A,Ax,
  en,
  to_dbl,to_ext,
  res);
  input [63:0] A;
  input [63:0] Ax;
  input en;
  input to_dbl;
  input to_ext;
  output [80:0] res;

  wire [51:0] denor;
  wire [51:0] last;
  wire [6:0] lastB;
  wire hasB,has;
  wire [11:0] exp;
  wire [64:0] resX;
  wire [80:0] resY;
  wire A_z;
  bit_find_last_bit #(52) last_mod(A[51:0],last,has);
  bit_find_last_bit #(7) lastB_mod({|A[51:48],|A[47:40],|A[39:32],|A[31:24],|A[23:16],|A[15:8],|A[7:0]},lastB,hasB);
  generate
      genvar l,l1;
      for(l=0;l<7;l=l+1) begin
              wire [51:0] denorK;
	      wire [11:0] expK;
              for(l1=0;l1<((l==6) ? 4 : 8);l1=l1+1) begin
	          wire [11:0] natExp=12'h3ff-l*8-l1;
		  //verilator lint_off WIDTH
                  assign denorK=last[l*8+l1] ? A[l*8+l1:0]<<(52-(l*8+l1)) : 52'bz;
		  //verilator lint_on WIDTH
		  assign expK=last[l*8+l1]? natExp : 12'bz;
	      end
	      assign denorK=lastB[l] ? 52'bz :  52'b0;
	      assign denor=lastB[l] ? denorK : 52'bz;
	      assign expK=lastB[l] ? 12'bz :  12'b0;
	      assign exp=lastB[l] ? expK : 12'bz;
      end
      assign denor=has ? 52'bz : 52'b0;
      assign exp=has ? 12'bz : 12'b0;
  endgenerate

  assign A_z=A[51:0]==52'b0;
  assign resX=(A[63:53]==0 && ~A_z) ? {exp[11],A[52],exp[10:0],denor} :  65'bz;
  assign resX=(A[63:53]!=0 && A[63:53]!=11'h7ff) ? {A[63],A[52],~A[63],A[61:0]} : 65'bz;
  assign resX=(A[63:53]==11'h7ff && A_z) ? {A[63],A[52],A[63:54],~A_z,A[51:0]} : 65'bz;
  assign resX=(A[63:53]==0 && A_z) ? {1'b0,A[52],11'b0,denor} :  65'bz;
  assign resY=(A[63:53]==0 && ~A_z) ? {exp[11],A[52],{4{~exp[11]}},exp[10:0],1'b0,denor,11'b0} :  81'bz;
  assign resY=(A[63:53]!=0 && A[63:53]!=11'h7ff) ? {A[63],A[52],{5{~A[63]}},A[62:53],1'b1,A[51:0],11'b0} : 81'bz;
  assign resY=(A[63:53]==11'h7ff) ? {A[63],A[52],{5{A[63]}},A[62:54],~A_z,1'b1,A[51:0],11'b0} : 81'bz;
  assign resY=(A[63:53]==0 && A_z) ? {1'b0,A[52],15'b0,1'b0,denor,11'b0} :  81'bz;

  assign res[64:0]=(en&to_dbl) ? resX : 65'bz;
  assign {res[64],res[80:65],res[63:0]}=(en&to_ext) ? resY : 81'bz;
  
endmodule

module ldS2nativeS(
  A,Ax,
  en,
  to_sngl,
  to_dbl,
  to_ext,
  res);
  input [31:0] A;
  input [31:0] Ax;
  input en;
  input to_sngl;
  input to_dbl;
  input to_ext;
  output [81:0] res;

  wire [22:0] denor;
  wire [22:0] last;
  wire [2:0] lastB;
  wire hasB,has;
  wire [11:0] exp;
  wire [32:0] resX;
  wire [64:0] resY;
  wire [80:0] resZ;
  wire A_z;

  bit_find_last_bit #(23) last_mod(A[22:0],last,has);
  bit_find_last_bit #(3) lastB_mod({|A[22:16],|A[15:8],|A[7:0]},lastB,hasB);
  generate
      genvar l,l1;
      for(l=0;l<3;l=l+1) begin
              wire [22:0] denorK;
	      wire [11:0] expK;
              for(l1=0;l1<((l==2) ? 7 : 8);l1=l1+1) begin
	          wire [11:0] natExp=12'h3ff-l*8-l1;
		  //verilator lint_off WIDTH
                  assign denorK=last[l*8+l1] ? A[l*8+l1:0]<<(23-(l*8+l1)) : 23'bz;
		  //verilator lint_on WIDTH
		  assign expK=last[l*8+l1]? natExp : 12'bz;
	      end
	      assign denorK=lastB[l] ? 23'bz :  23'b0;
	      assign denor=lastB[l] ? denorK : 23'bz;
	      assign expK=lastB[l] ? 12'bz :  12'b0;
	      assign exp=lastB[l] ? expK : 12'bz;
      end
      assign denor=has ? 23'bz : 23'b0;
      assign exp=has ? 12'bz : 12'b0;
  endgenerate

  assign A_z=A[22:0]==23'b0;
  assign resX=(A[31:24]==0 && ~A_z) ? {exp[8],A[23],exp[7:0],denor} :  33'bz;
  assign resX=(A[31:24]!=0 && A[31:24]!=8'hff) ? {A[31],A[23],~A[31],A[30:24],A[22:0]} : 33'bz;
  assign resX=(A[31:24]==8'hff) ? {A[31],A[23],A[31:25],~A_z,A[22:0]} : 33'bz;
  assign resX=(A[31:24]==0 && A_z) ? {1'b0,A[23],8'b0,denor} :  33'bz;
  assign resY=(A[31:24]==0 && ~A_z) ? {exp[8],A[23],{3{~exp[8]}},exp[7:0],denor,29'b0} :  65'bz;
  assign resY=(A[31:24]!=0 && A[31:24]!=8'hff) ? {A[31],A[23],{4{~A[31]}},A[30:24],A[22:0],29'b0} : 65'bz;
  assign resY=(A[31:24]==8'hff) ? {A[31],A[23],{4{A[31]}},A[30:25],~A_z,A[22:0],29'b0} : 65'bz;
  assign resY=(A[31:24]==0 && A_z) ? {1'b0,A[23],11'b0,denor,29'b0} :  65'bz;
  assign resZ=(A[31:24]==0 && ~A_z) ? {exp[8],A[23],{7{~exp[8]}},exp[7:0],1'b0,denor,40'b0} :  81'bz;
  assign resZ=(A[31:24]!=0 && A[31:24]!=8'hff)  ? {A[31],A[23],{8{~A[31]}},A[30:24],1'b1,A[22:0],40'b0} : 81'bz;
  assign resZ=(A[31:24]==8'hff) ? {A[31],A[23],{8{A[31]}},A[30:25],~A_z,1'b1,A[22:0],40'b0} : 81'bz;
  assign resZ=(A[31:24]==0 && A_z) ? {1'b0,A[23],15'b0,1'b0,denor,40'b0} :  81'bz;
  assign res[32:0]=(en&to_sngl) ? resX : 33'bz;
  assign res[65:0]=(en&to_dbl) ? {resY[64:32],1'b0,resY[31:0]} : 66'bz;
  assign res[81:0]=(en&to_ext) ? {resZ[80:65],resZ[64],resZ[63:32],1'b0,resZ[31:0]} : 82'bz;
endmodule

module stNativeD2D(A,en,from_dbl,from_ext,res);
  localparam DEN=16'he400;
  localparam OVFL=16'h83fe;
  input [80:0] A;
  input en; 
  input from_dbl;
  input from_ext;
  output [63:0] res;

  wire [15:0] expA=from_dbl ? {A[64],{4{~A[64]}},A[62:52]} : {A[64],A[79:65]};
  wire [15:0] expOff;
  wire [15:0] expOff1;
  wire is_den;
  wire is_zero;
  wire is_overflow;
  wire is_nan;
  wire [51:0] shf0;
  wire [51:0] shf1;
  wire [51:0] A_1=from_dbl ? A[51:0] : A[62:11];
  wire sgn=from_dbl ? A[63] : A[80];

  adder #(16) expAddD_mod(DEN,~expA,expOff,1'b1,1'b1,is_den,,,);
  adder #(16) expAddZ_mod(DEN-16'd51,~expA,expOff1,1'b1,1'b1,is_zero,,,);
  adder #(16) expAddO_mod(expA,~OVFL,,1'b1,1'b1,is_overflow,,,);

  assign is_nan=&expA;
  assign res=(~is_zero && ~ is_overflow && ~is_den && en) ? {A[64],expA[9:0],sgn,A_1[51:0]} : 64'bz;
  assign res=(is_den && ~is_zero && en) ? {11'b0,sgn,shf1} : 64'bz;
  assign res=(is_zero && en) ? {11'b0,sgn,52'b0} : 64'bz;
  assign res=(is_overflow && ~is_nan && en) ? {11'h7ff,sgn,52'b0} : 64'bz; 
  assign res=(is_nan && en) ? {11'h7ff,sgn,A_1[51:0]} : 64'bz;
  generate
    genvar k;
    for(k=0;k<8;k=k+1) begin : shifker_gen
	//verilator lint_off WIDTH
        assign shf0=(expOff[5:3]==k) ? {1'b1,A_1[51:0]}>>(k*8) : 52'bz; 
	//verilator lint_on WIDTH
	assign shf1=(expOff[2:0]==k) ? shf0>>k : 52'bz;
    end
  endgenerate
endmodule

module stNativeS2S(A,en,from_sngl,from_dbl,from_ext,res);
  localparam DEN=16'h4000;
  localparam OVFL=16'h807e;
  input [81:0] A;
  input en;
  input from_sngl;
  input from_dbl;
  input from_ext;
  output [31:0] res;

  wire [15:0] expA;
  wire [15:0] expOff;
  wire [15:0] expOff1;
  wire sgn;
  wire is_den;
  wire is_zero;
  wire is_overflow;
  wire is_nan;
  wire [22:0] A_1;
  wire [22:0] shf0;
  wire [22:0] shf1;
  
  
  assign expA=from_dbl ? {A[64],{4{~A[64]}},A[62:52]} : 16'bz;
  assign expA=from_ext ? {A[64],A[79:65]} : 16'bz;
  assign expA=from_sngl ? {A[32],{7{~A[32]}},A[30:23]} : 16'bz;
  
  assign A_1=from_dbl ? A[51:29] : 23'bz;
  assign A_1=from_ext?  A[62:40] : 23'bz;
  assign A_1=from_sngl ? A[22:0] : 23'bz;

  assign sgn=from_dbl ? A[63] : 1'bz;
  assign sgn=from_ext ? A[80] : 1'bz;
  assign sgn=from_sngl? A[31] : 1'bz;

  adder #(16) expAddD_mod(DEN,~expA,expOff,1'b1,1'b1,is_den,,,);
  adder #(16) expAddZ_mod(DEN-16'd22,~expA,expOff1,1'b1,1'b1,is_zero,,,);
  adder #(16) expAddO_mod(expA,~OVFL,,1'b1,1'b1,is_overflow,,,);

  assign is_nan=&expA;
  assign res=(~is_zero && ~ is_overflow && ~is_den && en) ? {expA[15],expA[6:0],sgn,A_1[22:0]} : 32'bz;
  assign res=(is_den && ~is_zero && en) ? {8'b0,sgn,shf1} : 32'bz;
  assign res=(is_zero && en) ? {8'b0,sgn,23'b0} : 32'bz;
  assign res=(is_overflow && ~is_nan && en) ? {8'hff,sgn,23'b0} : 32'bz; 
  assign res=(is_nan && en) ? {8'hff,sgn,A[22:0]|23'b1} : 32'bz;
  generate
    genvar k;
    for(k=0;k<8;k=k+1) begin : shifker_gen
	//verilator lint_off WIDTH
        assign shf0=(expOff[5:3]==k) ? {1'b1,A_1[22:0]}>>(k*8) : 23'bz; 
	//verilator lint_on WIDTH
	assign shf1=(expOff[2:0]==k) ? shf0>>k : 23'bz;
    end
  endgenerate
endmodule

