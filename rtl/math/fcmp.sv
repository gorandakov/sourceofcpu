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


module fcmpd(clk,rst,
  A,B,ord,invExcpt,isExt,isDbl,isSng,afm,flags,paired,vec,jumpType,
  cmod,res_pkd);
  input clk;
  input rst;
  input [81:0] A;
  input [81:0] B;
  input ord;
  input invExcpt;
  input isExt,isDbl,isSng;
  input afm; //alternative flag mode
  output [5:0] flags;
  input paired;
  input vec;
  input [4:0] jumpType;
  input [1:0] cmod;
  output [67:0] res_pkd;
  wire cmpC,x_cmpC;

  wire [15:0] extA;
  wire [15:0] extB;
  wire fEQl;
  wire A_s,B_s;
  wire [1:0] A_h,B_h;
  wire[15:0] emsk;

  wire res_unord;
  wire res_S,res_C,res_Z;
  wire COA,COB;
  wire [5:0] flags_other;

  wire [8:0] x_extA={A[65],A[63:56]};
  wire [8:0] x_extB={B[65],B[63:56]};
  wire x_fEQl;
  wire A_x_s,B_x_s;
  wire [1:0] A_x_h,B_x_h;

  wire res_x_unord;
  wire res_x_S,res_x_C,res_x_Z;
  wire x_COA,x_COB;

  wire A_zero,A_infty,A_nan,A_x_zero,A_x_infty,A_x_nan;
  wire B_zero,B_infty,B_nan,B_x_zero,B_x_infty,B_x_nan;
  wire [1:0] vres;
  wire vres1;
  reg [1:0] vres_reg;
  reg ven_reg;
  reg [1:0] vtype_reg;

  assign vres[0]=cmod==0 ? flags[5] : 1'bz;
  assign vres[0]=cmod==1 ? ~flags[5] : 1'bz;
  assign vres[0]=cmod==2 ? flags[1] : 1'bz;
  assign vres[0]=cmod==3 ? ~flags[1] : 1'bz;

  assign vres[1]=cmod==0 && ~paired ? flags[5] : 1'bz;
  assign vres[1]=cmod==1 && ~paired ? ~flags[5] : 1'bz;
  assign vres[1]=cmod==2 && ~paired ? flags[1] : 1'bz;
  assign vres[1]=cmod==3 && ~paired? ~flags[1] : 1'bz;
  assign vres1=cmod==0 ? flags_other[5] : 1'bz;
  assign vres1=cmod==1 ? ~flags_other[5] : 1'bz;
  assign vres1=cmod==2 ? flags_other[1] : 1'bz;
  assign vres1=cmod==3 ? ~flags_other[1] : 1'bz;
  assign vres[1]=paired ? vres1 : 1'bz;
  function [63:0] fracxfrm;
    input [63:0] d_in;
    input sngl;
    input dbl;
    input ext;
    begin
        fracxfrm[22:0]=d_in[22:0];
	fracxfrm[23]=d_in[23]|sngl;
	fracxfrm[51:24]=d_in[51:24]&{27'b0,~sngl};
	fracxfrm[52]=d_in[52]&~sngl||dbl;
	fracxfrm[63:53]=d_in[63:53]&{10'b0,~ext};
    end
  endfunction

  get_carry #(64) cmpM_mod(fracxfrm({A[64:33],A[31:0]},isSng,isDbl,isExt),
    ~fracxfrm({B[64:33],B[31:0]},isSng,isDbl,isExt),1'b1,cmpC);
  get_carry #(16) cmpA_mod(extA,~extB,1'b1,COA);
  get_carry #(16) cmpB_mod(~extA,extB,1'b1,COB);
  
  
  get_carry #(24) x_cmpM_mod({1'b1,A[55:33]},
    ~{1'b1,B[55:33]},1'b1,x_cmpC);
  get_carry #(9) x_cmpA_mod(x_extA,~x_extB,1'b1,x_COA);
  get_carry #(9) _xcmpB_mod(~x_extA,x_extB,1'b1,x_COB);

  assign x_fEQl=A[55:33]==B[55:33];
  assign A_x_s=A[64];
  assign B_x_s=B[64];

  assign fEQl=fracxfrm({A[64:33],A[31:0]},isSng,isDbl,isExt)==
    fracxfrm({B[64:33],B[31:0]},isSng,isDbl,isExt);
  assign extA=isExt ? {A[81],A[79:65]} : 16'bz;
  assign extA=isDbl ? {A[81],{4{~A[81]}},A[63:53]} : 16'bz;
  assign extA=(~isDbl&~isExt) ? {A[32],{7{~A[32]}},A[30:23]} : 16'bz;
  assign extB=isExt ? {B[81],B[79:65]} : 16'bz;
  assign extB=isDbl ? {B[81],{4{~B[81]}},B[63:53]} : 16'bz;
  assign extB=(~isDbl & ~isExt) ? {B[32],{7{~B[32]}},B[30:23]} : 16'bz;

  assign emsk=isExt ? 16'hffff : 16'bz;
  assign emsk=isDbl ? 16'h87ff : 16'bz;
  assign emsk=(~isDbl&~isExt) ? 16'h80ff : 16'bz;

  assign A_s=isExt ? A[80] : 1'bz;
  assign A_s=isDbl ? A[64] : 1'bz;
  assign A_s=(~isDbl & ~isExt) ? A[31] : 1'bz;
  assign B_s=isExt ? B[80] : 1'bz;
  assign B_s=isDbl ? B[64] : 1'bz;
  assign B_s=(~isDbl & ~isExt) ? B[31] : 1'bz;

  assign A_h=isExt ? {|A[61:0],A[62]} : 2'bz;
  assign A_h=isDbl ? {|A[50:0],A[51]} : 2'bz;
  assign A_h=(~isDbl & ~isExt) ? {|A[21:0],A[22]} : 2'bz;
  assign B_h=isExt ? {|B[61:0],B[62]} : 2'bz;
  assign B_h=isDbl ? {|B[50:0],B[51]} : 2'bz;
  assign B_h=(~isDbl & ~isExt) ? {|B[21:0],B[22]} : 2'bz;
  
//  assign A_x_h={|A[54:33],A[55]};
//  assign B_x_h={|B[54:33],B[55]};
  
  assign A_x_zero=x_extA==9'b0;
  assign A_x_infty=x_extA==9'h1fe;
  assign A_x_nan=x_extA==9'h1ff;
  
  assign B_x_zero=x_extB==9'b0;
  assign B_x_infty=x_extB==9'h1fe;
  assign B_x_nan=x_extB==9'h1ff;

  assign A_zero=(extA&emsk)==16'b0;
  assign A_infty=(extA|~emsk)==16'hfffe;
  assign A_nan=(extA|~emsk)==16'hffff;
  
  assign B_zero=(extB&emsk)==16'b0;
  assign B_infty=(extB|~emsk)==16'hfffe;
  assign B_nan=(extB|~emsk)==16'hffff;

  assign res_unord=A_nan || B_nan;
  assign res_C=res_unord || (A_s && ~B_s && ~A_zero|~B_zero) || (~A_s && ~B_s 
    && ~COA) || (A_s && B_s && ~COB) || (~A_s && ~B_s && COA && COB && ~cmpC) ||
    (A_s && B_s && COA && COB && cmpC|fEQl);
  assign res_S=~res_unord && (A_s && ~B_s && ~A_zero|~B_zero) | (~A_s && ~B_s 
    && ~COA) | (A_s && B_s && ~COB) | (~A_s && ~B_s && COA && COB && ~cmpC) |
    (A_s && B_s && COA && COB && cmpC|fEQl);
  assign res_Z=~res_unord && (A_zero&B_zero) | (extA==extB&&A_s==B_s&&fEQl|
    A_infty);
  
  assign res_x_unord=A_x_nan || B_x_nan;
  assign res_x_C=res_x_unord || (A_x_s && ~B_x_s && ~A_x_zero|~B_x_zero) || (~A_x_s && ~B_x_s 
    && ~x_COA) || (A_x_s && B_x_s && ~x_COB) || (~A_x_s && ~B_x_s && x_COA && x_COB && ~x_cmpC) ||
    (A_x_s && B_x_s && x_COA && x_COB && x_cmpC|x_fEQl);
  assign res_x_S=~res_x_unord && (A_x_s && ~B_x_s && ~A_x_zero|~B_x_zero) | (~A_x_s && ~B_x_s 
    && ~x_COA) | (A_x_s && B_x_s && ~x_COB) | (~A_x_s && ~B_x_s && x_COA && x_COB && ~x_cmpC) |
    (A_x_s && B_x_s && x_COA && x_COB && x_cmpC|x_fEQl);
  assign res_x_Z=~res_x_unord && (A_x_zero&B_x_zero) | (extA==extB&&A_x_s==B_x_s&&x_fEQl|
    A_x_infty);

  assign flags={~res_C,res_unord,1'b0,res_S,res_Z,res_unord};

  assign res_pkd[67:0]=ven_reg ? {vtype_reg,{33{vres_reg[1]}},{33{vres_reg[0]}}} : 68'bz; 
  always @(negedge clk) begin
    if (rst) vres_reg<=2'b0;
    else vres_reg<=vres;
    if (rst) ven_reg<=1'b0;
    else ven_reg<=paired|vec;
    vtype_reg<=vec ? `ptype_dbl : `ptype_sngl;
  end
endmodule
