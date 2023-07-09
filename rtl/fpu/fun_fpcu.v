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
`include "../fpoperations.sv"
`include "../csrss_no.sv"

module fun_fpu(
  clk,
  rst,
  fpcsr,
  u1_A,u1_B,u1_Bx,u1_Ax,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_ret,u1_ret_en,
  FUF0,FUF1,FUF2,
  FUF3,FUF4,FUF5,
  FUF6,FUF7,FUF8,
  FUF9,
  xtra,
  ALTDATA0,ALTDATA1,
  ALT_INP,
  FUS_alu0,FUS_alu1,
  ex_alu0,ex_alu1,
  fxFADD_raise_s,
  fxFCADD_raise_s,
  FOOSH_in,
  FOOSH_out,
  HH_data,
  outA,
  outB
  );
  parameter [1:0] INDEX=2'd2;
  parameter [0:0] H=1'b0;
  localparam SIMD_WIDTH=68; //half width
  localparam S={27'b0,~H,4'b0};
  input clk;
  input rst;
  input [31:0] fpcsr;
  input [S+67:0] u1_A;
  input [S+67:0] u1_B;
  input [67:0] u1_Bx;
  output [67:0] u1_Ax;
  input [3:0] u1_en;
  input [12:0] u1_op;
  input [3:0] u1_fufwd_A;
  input [3:0] u1_fuufwd_A;
  input [3:0] u1_fufwd_B;
  input [3:0] u1_fuufwd_B;
  output [13:0] u1_ret;
  output u1_ret_en;

  (* register equiload *) input [S+67:0] FUF0;
  (* register equiload *) input [S+67:0] FUF1;
  (* register equiload *) input [S+67:0] FUF2;
  (* register equiload *) input [S+67:0] FUF3;
  (* register equiload *) inout [S+67:0] FUF4;
  (* register equiload *) inout [S+67:0] FUF5;
  (* register equiload *) inout [S+67:0] FUF6;
  (* register equiload *) inout [S+67:0] FUF7;
  (* register equiload *) inout [S+67:0] FUF8;
  (* register equiload *) inout [S+67:0] FUF9;
  inout [67:0] xtra;
  input [1:0] ALT_INP;
  input [S+67:0] ALTDATA0;
  input [S+67:0] ALTDATA1;
  input [5:0] FUS_alu0;
  input [5:0] FUS_alu1;
  input [2:0] ex_alu0;
  input [2:0] ex_alu1;
  input [10:0] fxFADD_raise_s;
  input [10:0] fxFCADD_raise_s;
  (* register equiload *) input [5:0] FOOSH_in;
  (* register equiload *) output [5:0] FOOSH_out;
  output [S+67:0] HH_data;

  output [S+67:0] outA;
  output [S+67:0] outB;

  wire [1:0][16+67:0] FOOF;
  reg [1:0][S+67:0] FOOF_reg;
  wire [5:0] FOOSH;
  reg [5:0] FOOSH_reg;
  reg [5:0] FOOSH_reg2;
  reg  gfFADD_hi;
  reg  gfFADD_en;
  reg  gfFADD_en_reg;
  reg  gfFADD_en_reg2;
  reg  gfFADD_dbl;
  reg  gfFADD_ext;
  reg  gfFADD_sn;
  reg  gfFADD_sin;
  reg  gfFADD_ord;
  reg  gfFADD_pkdS;
  reg  gfFADD_pkdD;
  reg  gfFADD_pkdD_reg;
/*  wire fxAlt1;
  wire fxAlt2;
  reg fxAlt1_reg;
  reg fxAlt1_reg2;
  reg [2:0] fxAlt1_reg3;
  reg fxAlt2_reg;
  reg fxAlt2_reg2;
  reg fxAlt2_reg3;*/
  reg  fxFADD_dbl;
  reg  gfFADD_srch;
  reg [1:0] gfFADD_sz;
  reg  fxFADD_ext;
  reg  fxFADD_sin;
  reg  fxFADD_sn_reg;
  reg  fxFADD_sn_reg2;
  reg  fxFADD_dblext;
  reg [1:0] fxFADD_sub;
  reg  fxFADD_rsub;
  reg [1:0] fxFADD_copyA;
  reg [3:0] fxFADD_copySA;
  reg [1:0] fxFADD_com;
  reg  fxFADD_pswp;
  reg  fxFADD_dupl;
  reg  fxFADD_pcmp;
  reg  fxFADD_lo;
  reg [1:0] fxFADD_loSel;
  reg  fxFCADD_dbl;
  reg  fxFCADD_ext;
  reg  fxFCADD_sn;
  reg  fxFCADD_sn_reg;
  reg  fxFCADD_sn_reg2;
  reg  fxFCADD_sn_reg3;
  reg  fxFCADD_sn_reg4;
  reg  fxFCADD_sn_reg5;
  reg  fxFCADD_dblext;
  reg [1:0] fxFCADD_copyA;
  reg [3:0] fxFCADD_copyASN;
  reg [1:0] fxFCADD_com;
  reg  fxFCADD_pswp;
  reg  fxFCADD_dupl;
  reg  fxFCADD_rndD;
  reg  fxFCADD_rndS;
  reg  fxFADD_dbl_nreg;
  reg  fxFADD_ext_nreg;
  reg  fxFADD_dblext_nreg;
  reg [1:0] fxFADD_sub_nreg;
  reg  fxFADD_rsub_nreg;
  reg [1:0] fxFADD_copyA_nreg;
  reg [1:0] fxFADD_com_nreg;
  reg  fxFADD_pswp_nreg;
  reg  fxFCADD_dbl_nreg;
  reg  fxFCADD_ext_nreg;
  reg  fxFCADD_dblext_nreg;
  reg [1:0] fxFCADD_copyA_nreg;
  reg [1:0] fxFCADD_com_nreg;
  reg  fxFCADD_pswp_nreg;
  wire [10:0] fxFCADD_raise;
  reg [10:0] fxFCADD_raise_reg;
  reg [10:0] fxFCADD_raise_s_reg;
  wire [10:0] fxFADD_raise;
  reg [10:0] fxFADD_raise_reg;
  reg [10:0] fxFADD_raise_s_reg;
  wire [10:0] fraise2;
  wire [10:0] fraise3;
  wire [10:0] fmask2;
  wire [10:0] fmask3;
  reg [10:0] fraise2_reg;
  reg [10:0] fraise3_reg;
  reg [10:0] fmask2_reg;
  reg [10:0] fmask3_reg;
  reg isXTRA;
  reg isXTRA_reg;
  reg isXTRA_reg2;
  reg fxXTRA;
  //wire [15:0] u1_Bx=u1_BH[15:0];
  //wire [15:0] u1_Bx=u1_BH[15:0];
  integer k;
  wire [13:0] u1_retX;
  wire u1_retX_en;
  wire [13:0] u1_retY;
  wire u1_retY_en;
  reg  [13:0] u1_retX_reg;
  reg  u1_retX_en_reg;
  reg  [13:0] u1_retX_reg2;
  reg  u1_retX_en_reg2;
  reg  [13:0] u1_retX_reg3;
  reg  u1_retX_en_reg3;

  reg [1:0] ALT_INP_reg;

  wire [1:0][S+67:0] gfDataBFL;
  reg [1:0][16+67:0] gfDataBFL_reg;
  reg [1:0][16+67:0] fxDataAFL_reg;
  reg [1:0][S+67:0] gfDataBFL_REG;
  reg [1:0][S+67:0] fxDataAFL_REG;
  reg [1:0][S+67:0] gfDataBXL_reg;
  reg [1:0][S+67:0] fxDataAXL_reg;

  wire [S+67:0] uu_A1;
  wire [S+67:0] uu_A2;
  wire [S+67:0] uu_B1;
  wire [S+67:0] uu_B2;

  reg [67:0] xtra_reg;

  reg [S+67:0] FUF0_reg;
  reg [S+67:0] FUF1_reg;
  reg [S+67:0] FUF2_reg;
  reg [S+67:0] FUF3_reg;
  reg [S+67:0] FUF4_reg;
  reg [S+67:0] FUF5_reg;
  reg [S+67:0] FUF6_reg;
  reg [S+67:0] FUF7_reg;
  reg [S+67:0] FUF8_reg;
  reg [S+67:0] FUF9_reg;

  reg [3:0] u1_en_reg;
  reg [3:0] u2_en_reg;
  reg [12:0] u1_op_reg;
  reg [12:0] u1_op_reg2;
  reg [3:0] u1_en_reg2;
  reg [3:0] u1_en_reg3;
  reg [3:0] u1_en_reg4;
  reg [3:0] u1_en_reg5;
  reg [3:0] u1_en_reg6;
  reg [3:0] u1_en_reg7;

  rs_write_forward #(S+68) u1_A_fwd(
  clk,rst,
  ~u1_en[3],
  u1_A,uu_A1,
  u1_fufwd_A,u1_fuufwd_A,
  FUF0,FUF0_reg,
  FUF1,FUF1_reg,
  FUF2,FUF2_reg,
  FUF3,FUF3_reg,
  FUF4,FUF4_reg,
  FUF5,FUF5_reg,
  FUF6,FUF6_reg,
  FUF7,FUF7_reg,
  FUF8,FUF8_reg,
  FUF9,FUF9_reg
  );
  
  rs_write_forward #(S+68) u1_B_fwd(
  clk,rst,
  ~u1_en[3],
  u1_B,uu_B1,
  u1_fufwd_B,u1_fuufwd_B,
  FUF0,FUF0_reg,
  FUF1,FUF1_reg,
  FUF2,FUF2_reg,
  FUF3,FUF3_reg,
  FUF4,FUF4_reg,
  FUF5,FUF5_reg,
  FUF6,FUF6_reg,
  FUF7,FUF7_reg,
  FUF8,FUF8_reg,
  FUF9,FUF9_reg
  );
  
  rs_write_forward #(S+68) u2_A_fwd(
  clk,rst,
  ~u1_en[3],
  u1_A,uu_A2,
  u1_fufwd_A,u1_fuufwd_A,
  FUF0,FUF0_reg,
  FUF1,FUF1_reg,
  FUF2,FUF2_reg,
  FUF3,FUF3_reg,
  FUF4,FUF4_reg,
  FUF5,FUF5_reg,
  FUF6,FUF6_reg,
  FUF7,FUF7_reg,
  FUF8,FUF8_reg,
  FUF9,FUF9_reg
  );
  
  rs_write_forward #(S+68) u2_B_fwd(
  clk,rst,
  ~u1_en[3],
  u1_B,uu_B2,
  u1_fufwd_B,u1_fuufwd_B,
  FUF0,FUF0_reg,
  FUF1,FUF1_reg,
  FUF2,FUF2_reg,
  FUF3,FUF3_reg,
  FUF4,FUF4_reg,
  FUF5,FUF5_reg,
  FUF6,FUF6_reg,
  FUF7,FUF7_reg,
  FUF8,FUF8_reg,
  FUF9,FUF9_reg
  );
  
  
  fadd fadd1H_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAFL_reg[0][65],fxDataAFL_reg[0][15+68:68],fxDataAFL_reg[0][64:33],
    fxDataAFL_reg[0][31:0]}),
  .A_alt({fxDataAFL_REG[0][65],fxDataAFL_REG[0][64:33],
    fxDataAFL_REG[0][31:0]}),
  .B({gfDataBFL_reg[1][65],gfDataBFL_reg[1][15+68:68],gfDataBFL_reg[1][64:33],
    gfDataBFL_reg[1][31:0]}),
  .isDBL(fxFADD_dbl|H),
  //.isEXT(fxFADD_ext&!H),
  .isSub(fxFADD_sub[H]),
  .isRSub(fxFADD_rsub),
  //.invExcpt(fpcsr[`csrfpu_inv_excpt]),
  .raise(fxFADD_raise),
  .fpcsr(fpcsr[31:0]),
  .rmode(fpcsr[`csrfpu_rmode]),
  .copyA(fxFADD_copyA[H]),
  .logic_en(fxFADD_lo),
  .logic_sel(fxFADD_loSel),
  .en(H? fxFADD_dbl:fxFADD_dblext),
  .res(FOOF[0][67:0]),
  .res_hi(FOOF[0][68+15:68])
  );
  
 
  fperm fperm1H_mod(
  .clk(clk),
  .rst(rst),
  .en(~(H? fxFADD_dbl:fxFADD_dblext)&~fxFADD_sin&~fxFADD_pcmp),
  .copyA(H? fxFADD_com==2'b01 : ~fxFADD_com[0]),
  .swpSngl(fxFADD_pswp),
  .dupSngl(fxFADD_dupl),
  .A(fxDataAXL_reg[0][67:0]),.B(gxDataBXL_reg[1][67:0]),
  .res(FOOF[0][67:0]));
  
  
  fcmpd fcmpL_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAFL_reg[0][65],fxDataAFL_reg[0][15+68:68],fxDataAFL_reg[0][64:32],
    fxDataAFL_reg[0][31:0]}),
  .B({gfDataBFL_reg[1][65],gfDataBFL_reg[1][15+68:68],gfDataBFL_reg[1][64:32],
    gfDataBFL_reg[1][31:0]}),
  .ord(gfFADD_ord),.invExcpt(fpcsr[`csrfpu_inv_excpt]),
  .isExt(H ? 1'b0: gfFADD_ext),.isDbl(gfFADD_dbl),.isSng(H? gfFADD_sn:gfFADD_sin),
  .afm(1'b0),.flags(FOOSH),
  .paired(gfFADD_pkdS),
  .int_srch(gfFADD_srch),
  .srch_sz(gfFADD_sz),
  .vec(gfFADD_pkdD),
  .jumpType(5'b0),
  .cmod(u1_op_reg2[1:0]),
  .res_pkd(FOOF[0][67:0])
  );

  //assign FOOS=gfFADD_hi ? FOOSH[m] : FOOSL[m];

  assign fraise2=fxFCADD_sn_reg5 ?
    fxFCADD_raise_s_reg&fpcsr[21:11] :
    (fxFCADD_raise_reg)&fpcsr[21:11];
  assign fmask2=fxFCADD_sn_reg5 ?
    fxFCADD_raise_s_reg :
    (fxFCADD_raise_reg);
  fexcpt fexcpt2_mod(fraise2_reg,{6'b0,3'b0},
    fmask2_reg,|u1_en_reg7[3:2]&u1_en_reg7[0],u1_retY,u1_retY_en);
  assign fraise3=fxFADD_sn_reg2 ?
    fxFADD_raise_s_reg&fpcsr[21:11] :
    (fxFADD_raise_reg)&fpcsr[21:11];
  assign fmask3=fxFADD_sn_reg2 ?
    fxFADD_raise_s_reg :
    (fxFADD_raise_reg);
  fexcpt fexcpt3_mod(fraise3_reg,{6'b0,3'b0},
    fmask3_reg,|u1_en_reg4[3:2]&u1_en_reg4[0],u1_retX,u1_retX_en);

  assign u1_ret=u1_retY|u1_retX_reg3;
  assign u1_ret_en=u1_retY_en|u1_retX_en_reg3;

/*module fexcpt(
  mask,
  in,
  in_mask,
  in_en,
  no,
  en);
*/
  assign FOOSH_out=FOOSH_reg2;
  //verilator lint_off WIDTH
  assign HH_data=gfDataBFL_reg[0];
  //verilator lint_on WIDTH

  fpucadd cadd2L_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAFL_reg[1][65],fxDataAFL_reg[1][15+68:68],
    fxDataAFL_reg[1][64:33],fxDataAFL_reg[1][31:0]}),
  .A_alt({fxDataAFL_REG[1][65],
    fxDataAFL_REG[1][64:33],fxDataAFL_REG[1][31:0]}),
  .B({gfDataBFL_reg[0][65],gfDataBFL_reg[0][15+68:68],
    gfDataBFL_reg[0][64:33],gfDataBFL_reg[0][31:0]}),
  .and1(H? 1'b0 : fxFCADD_ext),
  .or1(H? 1'b1 : fxFCADD_dbl),
  .copyA(fxFCADD_copyA[H]),
  .en(H? fxFCADD_dbl : fxFCADD_dblext),
  .rmode(fxXTRA ? ROUND_TRUNC : fxFCADD_dbl|H ? fpcsr[`csrfpu_rmode] : fpcsr[`csrfpu_rmodeE]),
  .res(FOOF[1][67:0]),
  .res_hi(FOOF[1][68+15:68]),
  .xtra(xtra),
  .isDBL(fxFCADD_dbl|H),
  .raise(fxFCADD_raise),
  .fpcsr(fpcsr[31:0]),
  .is_rndD(fxFCADD_rndD),
  .is_rndS(fxFCADD_rndS)
  );
  
  
  fperm #(1) fperm1CL_mod(
  .clk(clk),
  .rst(rst),
  .en(~(H? fxFCADD_dbl:fxFCADD_dblext)&~fxFCADD_sn),
  .copyA(H? fxFCADD_com==2'b01 : ~fxFCADD_com[0]),
  .swpSngl(fxFCADD_pswp),
  .dupSngl(fxFCADD_dupl),
  .A(fxDataAXL_reg[1][67:0]),.B(gxDataBXL_reg[0][67:0]),
  .res(FOOF[1][67:0]));
 
  generate
      if (H) assign gfDataBFL[1]=u1_op_reg[9] ? u1_Bx : uu_B1;
      else assign gfDataBFL[1]=u1_op_reg[8] ? {uu_B1[68+15:68],u1_Bx} : uu_B1;
      if (H) assign gfDataBFL[0]=u1_op_reg[9] ? u1_Bx : uu_B2;
      else assign gfDataBFL[0]=u1_op_reg[8] ? {uu_B2[68+15:68],u1_Bx} : uu_B2;
      if (INDEX==0) begin
	      assign FUF4=FOOF_reg[0];
	      assign FUF7=isXTRA_reg2 ? xtra_reg : FOOF_reg[1];
      end
      if (INDEX==1) begin
	      assign FUF5=FOOF_reg[0];
	      assign FUF8=isXTRA_reg2 ? xtra_reg : FOOF_reg[1];
      end
      if (INDEX==2) begin
	      assign FUF6=|ALT_INP_reg ? {S+SIMD_WIDTH{1'BZ}} : FOOF_reg[0];
	      assign FUF6=ALT_INP_reg[0] ? ALTDATA0 : {S+SIMD_WIDTH{1'BZ}};
	      assign FUF6=ALT_INP_reg[1] ? ALTDATA1 : {S+SIMD_WIDTH{1'BZ}};
	      assign FUF9=isXTRA_reg2 ? xtra_reg : FOOF_reg[1];
	      assign outA=uu_A2;
	      assign outB=gfDataBFL[0][S+67:0];
      end
  endgenerate

//  if (m!=2) assign FUFL[4+m]=FOOFL_reg[2*m+0];
//  else assign FUFL[4+m]=fxFRT_alten_reg5[2]||~nDataAlt_reg5[2][2] ? 'z : FOOFL_reg[2*m+0];
//  assign FUFL[7+m]=FOOFL_reg[2*m+1];

  assign u1_Ax=uu_B1[67:0];
  assign u1_Ax=uu_B2[67:0];

  always @(negedge clk) begin
    fxFCADD_sn_reg<=fxFCADD_sn;
    fxFCADD_sn_reg2<=fxFCADD_sn_reg;
    fxFCADD_sn_reg3<=fxFCADD_sn_reg2;
    fxFCADD_sn_reg4<=fxFCADD_sn_reg3;
    fxFCADD_sn_reg5<=fxFCADD_sn_reg4;
    fxFADD_sn_reg<=fxFADD_sin;
    fxFADD_sn_reg2<=fxFADD_sn_reg;
    FOOSH_reg<=FOOSH;
    gfFADD_pkdD_reg<=H? !gfFADD_sn:!gfFADD_sin;
    gfFADD_sz<=u1_op_reg[1:0];
    if (rst) begin
	  fxFADD_dbl=1'b1;
	  fxFADD_dblext=1'b1;
	  fxFADD_ext=1'b0;
	  fxFADD_sub=2'b00;
	  fxFADD_rsub=1'b0;
	  fxFADD_copyA=2'b0;
	  fxFADD_com<=2'b0;
	  fxFADD_dupl<=1'b0;
	  fxFCADD_dupl<=1'b0;
	  fxFADD_pswp<=1'b0;
	  fxFADD_pcmp<=1'b0;
	  fxFCADD_dbl=1'b1;
	  fxFCADD_dblext=1'b1;
	  fxFCADD_ext=1'b0;
	  fxFCADD_copyA=2'b0;
	  fxFCADD_com<=2'b0;
	  fxFCADD_pswp<=1'b0;
	  fxFADD_sin=1'b0;
          fxFADD_copySA=4'b0;
	  fxFCADD_sn=1'b0;
	  fxFCADD_copyASN=4'b0;
	  fxFADD_lo=1'b0;
	  fxFADD_loSel=2'b0;
	  fxFCADD_rndD=1'b0;
	  fxFCADD_rndS=1'b0;
          fxXTRA=1'b0;
          for (k=0;k<2;k=k+1) begin
	      fxDataAFL_reg[k]<={16+SIMD_WIDTH{1'B0}};
	      gfDataBFL_reg[k]<={16+SIMD_WIDTH{1'B0}};
	      fxDataAFL_REG[k]<={S+SIMD_WIDTH{1'B0}};
	      fxDataAXL_reg[k]<={S+SIMD_WIDTH{1'B0}};
	      gfDataBXL_reg[k]<={S+SIMD_WIDTH{1'B0}};
	  end
	  gfFADD_srch<=1'b0;
    end else begin
	      fxFADD_dbl=u1_op_reg[7:0]==`fop_addDL ||
	        u1_op_reg[7:0]==`fop_addDH ||
	        u1_op_reg[7:0]==`fop_addDP ||
                u1_op_reg[7:0]==`fop_subDL ||
	        u1_op_reg[7:0]==`fop_subDH ||
                u1_op_reg[7:0]==`fop_subDP ||
                u1_op_reg[7:0]==`fop_addsubDP ||
                {u1_op_reg[7:2],2'b0}==`fop_logic;
             fxFADD_ext=u1_op_reg[7:0]==`fop_addEE ||
                u1_op_reg[7:0]==`fop_subEE;
              fxFADD_dblext=fxFADD_dbl||fxFADD_ext;
	      fxFADD_sub[0]=u1_op_reg[7:0]==`fop_subDL ||
	        u1_op_reg[7:0]==`fop_subDH ||
                u1_op_reg[7:0]==`fop_subDP ||
	        u1_op_reg[7:0]==`fop_subEE ||
		u1_op_reg[7:0]==`fop_subS ||
		u1_op_reg[7:0]==`fop_subSP ||
		u1_op_reg[7:0]==`fop_addsubDP;
	      fxFADD_sub[1]=fxFADD_sub[0] || 
		u1_op_reg[7:0]!=`fop_addsubDP;
	      fxFADD_rsub=fxFADD_sub[0] && u1_op_reg[12];
	      fxFADD_copyA[1]=u1_op_reg[7:0]==`fop_addDL ||
                u1_op_reg[7:0]==`fop_subDL;
	      fxFADD_copyA[0]=u1_op_reg[7:0]==`fop_addDH ||
                u1_op_reg[7:0]==`fop_subDH;
	      fxFADD_lo={u1_op_reg[7:2],2'b0}==`fop_logic;
	      fxFADD_loSel=u1_op_reg[1:0];
              fxFADD_pcmp<=gfFADD_pkdS | gfFADD_pkdD;
	      {fxFADD_pswp,fxFADD_com}<=u1_op_reg[10:8];
	      {fxFCADD_pswp,fxFCADD_com}<=u1_op_reg[10:8];
              fxFADD_dupl<=u1_op_reg[12];
              fxFCADD_dupl<=u1_op_reg[12];
	      
	      fxFCADD_dbl=u1_op_reg[7:0]==`fop_mulDL ||
	        u1_op_reg[7:0]==`fop_mulDH ||
	        u1_op_reg[7:0]==`fop_mulDP || u1_op_reg[7:0]==`fop_rndDSP;
              fxXTRA=u1_op_reg[7:0]==`fop_mulDL && u1_op_reg[10];
              fxFCADD_ext=u1_op_reg[7:0]==`fop_mulEE || u1_op_reg[7:0]==`fop_rndES ||
	        u1_op_reg[7:0]==`fop_rndED;
              fxFCADD_dblext=fxFCADD_dbl||fxFCADD_ext;
	      fxFCADD_copyA[1]=u1_op_reg[7:0]==`fop_mulDL;
	      fxFCADD_copyA[0]=u1_op_reg[7:0]==`fop_mulDH;
	     
	      fxFCADD_rndD=u1_op_reg[7:0]==`fop_rndED;
	      fxFCADD_rndS=u1_op_reg[7:0]==`fop_rndES ||
	        u1_op_reg[7:0]==`fop_rndDSP;

	      fxFADD_sin=u1_op_reg[7:0]==`fop_addS || u1_op_reg[7:0]==`fop_addSP ||
                  u1_op_reg[7:0]==`fop_subS || u1_op_reg[7:0]==`fop_subSP;
              fxFADD_copySA=(u1_op_reg==`fop_addSP || u1_op_reg[7:0]==`fop_subSP ||
	          {u1_op_reg[7:2],2'b0}==`fop_logic) ?
		  {u1_op_reg[10],3'b0} : {2'b11,u1_op_reg[10],1'b0}; 
	      fxFCADD_sn=u1_op_reg[7:0]==`fop_mulS || u1_op_reg[7:0]==`fop_mulSP;
              fxFCADD_copyASN=(u1_op_reg==`fop_mulSP) ?
		  {u1_op_reg[10],3'b0}:{2'b11,u1_op_reg[10],1'b0}; 
	      //verilator lint_off WIDTH
	      if (fxFADD_dblext) begin
	          if (~fxFADD_copyA[0]) fxDataAFL_reg[0]<=uu_A1; else fxDataAFL_reg[0]<='z;
	          if (~fxFADD_copyA[0]) gfDataBFL_reg[1]<=gfDataBFL[1]; else gfDataBFL_reg[1]<='z;
	          fxDataAFL_REG[0]<=uu_A1;
	      end
	      if (fxFCADD_dblext) begin
	          if (~fxFCADD_copyA[0]) fxDataAFL_reg[1]<=uu_A2; else fxDataAFL_reg[1]<='z;
	          if (~fxFCADD_copyA[0]) gfDataBFL_reg[0]<=gfDataBFL[0]; else gfDataBFL_reg[0]<='z;
	          fxDataAFL_REG[1]<=uu_A2;
	      end
	      if (~fxFADD_dblext) begin
	          fxDataAXL_reg[0]<=uu_A1; 
	          gfDataBXL_reg[1]<=gfDataBFL[1]; 
	      end else begin
	          fxDataAXL_reg[0]<='z; 
	          gfDataBXL_reg[1]<='z; 
              end
	      if (~fxFCADD_dblext) begin
	          fxDataAXL_reg[1]<=uu_A2;
	          gfDataBXL_reg[0]<=gfDataBFL[0];
	      end else begin
	          fxDataAXL_reg[1]<='z;
	          gfDataBXL_reg[0]<='z;
              end
	      //verilator lint_on WIDTH
    end
    for(k=0;k<2;k=k+1) begin
        FOOF_reg[k]<=FOOF[k][S+67:0];
    end
      fxFCADD_raise_reg<=fxFCADD_raise;
      fxFADD_raise_reg<=fxFADD_raise;
      fxFCADD_raise_s_reg<=fxFCADD_raise_s;
      fxFADD_raise_s_reg<=fxFADD_raise_s;
      gfFADD_en=u1_en_reg[0] && u1_en_reg[3] && u1_op_reg[7:0]==`fop_cmpDH || u1_op_reg[7:0]==`fop_cmpDL || u1_op_reg[7:0]==`fop_cmpE || 
	      u1_op_reg[7:0]==`fop_cmpS || {u1_op_reg[7:2],2'b0}==`fop_linsrch;
      gfFADD_srch<={u1_op_reg[7:2],2'b0}==`fop_linsrch;
      gfFADD_ord=u1_op_reg[10];
      gfFADD_hi=u1_op_reg[7:0]==`fop_cmpDH;
      gfFADD_ext=u1_op_reg[7:0]==`fop_cmpE;
      gfFADD_dbl=u1_op_reg[7:0]==`fop_cmpDH || u1_op_reg[7:0]==`fop_cmpDL;
      gfFADD_sn=~gfFADD_ext & ~gfFADD_dbl;
      gfFADD_sin=~gfFADD_dbl; 
      gfFADD_pkdS<={u1_op_reg[7:2],2'b0}==`fop_pcmplt && u1_op_reg[10];
      gfFADD_pkdD<={u1_op_reg[7:2],2'b0}==`fop_pcmplt && ~u1_op_reg[10];
      gfFADD_en_reg<=gfFADD_en;
      gfFADD_en_reg2<=gfFADD_en_reg;
      u1_op_reg2<=u1_op_reg;
      u1_en_reg2<=u1_en_reg;
      u1_en_reg3<=u1_en_reg2;
      u1_en_reg4<=u1_en_reg3;
      u1_en_reg5<=u1_en_reg4;
      u1_en_reg6<=u1_en_reg5;
      isXTRA<=fxXTRA;
      isXTRA_reg<=isXTRA;
      isXTRA_reg2<=isXTRA_reg;
      xtra_reg<=xtra;
  end

  always @(posedge clk) begin
      ALT_INP_reg<=ALT_INP;
      u1_op_reg<=u1_op;
      u1_en_reg<=u1_en;
      u1_en_reg7<=u1_en_reg6;
      u1_retX_en_reg<=u1_retX_en;
      u1_retX_en_reg2<=u1_retX_en_reg;
      u1_retX_en_reg3<=u1_retX_en_reg2;
      u1_retX_reg<=u1_retX;
      u1_retX_reg2<=u1_retX_reg;
      u1_retX_reg3<=u1_retX_reg2;
      FUF0_reg<=FUF0;
      FUF1_reg<=FUF1;
      FUF2_reg<=FUF2;
      FUF3_reg<=FUF3;
      FUF4_reg<=FUF4;
      FUF5_reg<=FUF5;
      FUF6_reg<=FUF6;
      FUF7_reg<=FUF7;
      FUF8_reg<=FUF8;
      FUF9_reg<=FUF9;
      FOOSH_reg2<=gfFADD_pkdD_reg ? FOOSH_reg : FOOSH_in;
      /*gfFADD_en=u1_op[0] && u1_clkEn && u1_op[7:0]==`fop_cmpDH || u1_op[7:0]==`fop_cmpDL || u1_op[7:0]==`fop_cmpE || u1_op[7:0]==`fop_cmpS;
      gfFADD_ord=u1_op[10];
      gfFADD_hi=u1_op[7:0]==`fop_cmpDH;
      gfFADD_ext=u1_op[7:0]==`fop_cmpE;
      gfFADD_dbl=u1_op[7:0]==`fop_cmpDH || u1_op[7:0]==`fop_cmpDL;
      gfFADD_sn=~gfFADD_ext & ~gfFADD_dbl;
      gfFADD_sin=~gfFADD_dbl; 
      gfFADD_pkdS<={u1_op[7:2],2'b0}==`fop_pcmplt && u1_op[10];
      gfFADD_pkdD<={u1_op[7:2],2'b0}==`fop_pcmplt && ~u1_op[10];
      gfFADD_en_reg[k]<=gfFADD_en[k];
      gfFADD_en_reg2[k]<=gfFADD_en_reg[k];
*/
  end

endmodule
