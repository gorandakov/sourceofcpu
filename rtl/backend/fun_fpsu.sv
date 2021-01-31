`include "../struct.sv"
`include "../fpoperations.sv"
`include "../csrss_no.sv"

module fun_fpsu(
  clk,
  rst,
  u1_A,u1_B,u1_Ax,u1_Bx,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_ret,u1_ret_en,
  u2_A,u2_B,u2_Ax,u2_Bx,u2_en,u2_op,
  u2_fufwd_A,u2_fuufwd_A,u2_fufwd_B,u2_fuufwd_B,
  u2_ret,u2_ret_en,
  FUF0,FUF1,FUF2,
  FUF3,FUF4,FUF5,
  FUF6,FUF7,FUF8,
  FUF9,
  ALTDATA0,ALTDATA1,
  ALT_INP
  );
  parameter [1:0] INDEX=2'd2;
  parameter [0:0] H=1'b0;
  localparam SIMD_WIDTH=68; //half width
  localparam [4:0] S=5'd0;
  input clk;
  input rst;
  input [S+67:0] u1_A;
  input [S+67:0] u1_B;
  input [67:0] u1_Bx;
  input [3:0] u1_en;
  input [12:0] u1_op;
  input [3:0] u1_fufwd_A;
  input [3:0] u1_fuufwd_A;
  input [3:0] u1_fufwd_B;
  input [3:0] u1_fuufwd_B;
  output [13:0] u1_ret;
  output u1_ret_en;

  input [S+67:0] u2_A;
  input [S+67:0] u2_B;
  input [67:0] u2_Bx;
  input [3:0] u2_en;
  input [12:0] u2_op;
  input [3:0] u2_fufwd_A;
  input [3:0] u2_fuufwd_A;
  input [3:0] u2_fufwd_B;
  input [3:0] u2_fuufwd_B;
  output [13:0] u2_ret;
  output u2_ret_en;
 

  input [S+67:0] FUF0;
  input [S+67:0] FUF1;
  input [S+67:0] FUF2;
  input [S+67:0] FUF3;
  inout [S+67:0] FUF4;
  inout [S+67:0] FUF5;
  inout [S+67:0] FUF6;
  inout [S+67:0] FUF7;
  inout [S+67:0] FUF8;
  inout [S+67:0] FUF9;
  input [1:0] ALT_INP;
  input [S+67:0] ALTDATA0;
  input [S+67:0] ALTDATA1;

  reg  gxFADD_hi;
  reg  gxFADD_en;
  reg  gxFADD_en_reg;
  reg  gxFADD_en_reg2;
  reg  gxFADD_dbl;
  reg  gxFADD_ext;
  reg  gxFADD_sn;
  reg  gxFADD_sin;
  reg  gxFADD_ord;
  reg  gxFADD_pkdS;
  reg  gxFADD_pkdD;
/*  wire fxAlt1;
  wire fxAlt2;
  reg fxAlt1_reg;
  reg fxAlt1_reg2;
  reg [2:0] fxAlt1_reg3;
  reg fxAlt2_reg;
  reg fxAlt2_reg2;
  reg fxAlt2_reg3;*/
  reg  fxFADD_dbl;
  reg  fxFADD_ext;
  reg  fxFADD_sin;
  reg  fxFADD_dblext;
  reg [1:0] fxFADD_sub;
  reg  fxFADD_rsub;
  reg [1:0] fxFADD_copyA;
  reg [3:0] fxFADD_copySA[1:0];
  reg [1:0] fxFADD_com;
  reg  fxFADD_pswp;
  reg  fxFADD_dupl;
  reg  fxFADD_pcmp;
  reg  fxFADD_lo;
  reg [3:0] fxFADD_loSel;
  reg  fxFCADD_dbl;
  reg  fxFCADD_ext;
  reg  fxFCADD_sn;
  reg  fxFCADD_dblext;
  reg [1:0] fxFCADD_copyA;
  reg [3:0] fxFCADD_copyASN[1:0];
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
  ~u2_en[3],
  u2_A,uu_A2,
  u2_fufwd_A,u2_fuufwd_A,
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
  ~u2_en[3],
  u2_B,uu_B2,
  u2_fufwd_B,u2_fuufwd_B,
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
  
  
  fadds fadd1H_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAXL_reg[0][65],fxDataAXL_reg[0][64:33]}),
  .A_alt({fxDataAFL_REG[0][65],fxDataAFL_REG[0][64:33]}),
  .B({gxDataBXL_reg[1][65],gxDataBFL_reg[1][64:33]}),
  .isSub(fxFADD_sub[H]),
  .isRSub(fxFADD_rsub),
  .invExcpt(fpcsr[`csrfpu_inv_excpt]),
  .raise(fxFADD_raise[0]),
  .fpcsr(fpcsr[31:0]),
  .rmode(fpcsr[`csrfpu_rmode]),
  .copyA(fxFADD_copyA[H]),
  .logic_en(fxFADD_lo),
  .logic_sel(fxFADD_loSel),
  .en(H? gxFADD_sn:gxFADD_sin),
  .res(FOOF[0][65:33])
  );
  
  fadds fadd1L_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAXL_reg[0][32],fxDataAXL_reg[0][31:0]}),
  .A_alt({fxDataAFL_REG[0][32],fxDataAFL_REG[0][31:0]}),
  .B({gxDataBXL_reg[1][32],gxDataBFL_reg[1][31:0]}),
  .isSub(fxFADD_sub[H]),
  .isRSub(fxFADD_rsub),
  .invExcpt(fpcsr[`csrfpu_inv_excpt]),
  .raise(fxFADD_raise[1]),
  .fpcsr(fpcsr[31:0]),
  .rmode(fpcsr[`csrfpu_rmode]),
  .copyA(fxFADD_copyA[H]),
  .logic_en(fxFADD_lo),
  .logic_sel(fxFADD_loSel),
  .en(H? gxFADD_sn:gxFADD_sin),
  .res(FOOF[0][32:0])
  );
  
  simd_socialiste simd_mod(
  .clk(clk),
  .rst(rst),
  .en(),
  .operation(u1_op_reg),
  .A(fxDataAXL_reg[0]),
  .B(gxDataBFL_reg[1]),
  .res(FOOF[0])
  );
  
  fperm fperm1H_mod(
  .clk(clk),
  .rst(rst),
  .en(~(H? fxFADD_dbl:fxFADD_dblext)&~fxFADD_sin&~fxFADD_pcmp&~fxFADD_int),
  .copyA(H? fxFADD_com==2'b01 : ~fxFADD_com[0]),
  .swpSngl(fxFADD_pswp),
  .dupSngl(fxFADD_dupl),
  .A(fxDataAXL_reg[0]),.B(gxDataBXL_reg[1]),
  .res(FOOF[0]));
  
  
  fcmpd fcmpL_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAXL[0][65],fxDataAXL[0][31:0]}),
  .B({gxDataBXL[1][65],gxDataBXL[1][31:0]}),
  .ord(gxFADD_ord),.invExcpt(fpcsr[`csrfpu_inv_excpt]),
  .isExt(H ? 1'b0: gxFADD_ext),.isDbl(gxFADD_dbl),.isSng(H? gxFADD_sn:gxFADD_sin),
  .afm(1'b0),.flags(FOOSH),
  .paired(gxFADD_pkdS),
  .vec(gxFADD_pkdD),
  .jumpType(5'b0),
  .cmod(u1_op_reg[1:0]),
  .res_pkd(FOOF[0])
  );

  //assign FOOS=gxFADD_hi ? FOOSH[m] : FOOSL[m];

  assign fraise2[m]=fxFCADD_sn_reg5[m] ?
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
    fmaks3_reg,|outEn_reg6[1][3:2],u1_ret,u1_ret_en);
/*module fexcpt(
  mask,
  in,
  in_mask,
  in_en,
  no,
  en);
*/
  
  fpucadd cadd2H_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAXL_reg[1][65],fxDataAXL_reg[1][64:33]}),
  .A_alt({fxDataAFL_REG[1][65],fxDataAFL_REG[1][64:33]}),
  .B({gxDataBXL_reg[0][65],gxDataBFL_reg[0][64:33]}),
  .copyA(fxFCADD_copyA[H]),
  .en(fxFCADD_sn),
  .rmode(fpcsr[`csrfpu_rmode]),
  .res(FOOF[1][65:33]),
  .raise(fxFCADD_raise[0]),
  .fpcsr(fpcsr[31:0])
  );
  
  
  fpucadd cadd2L_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAXL_reg[1][32],fxDataAXL_reg[1][31:0]}),
  .A_alt({fxDataAFL_REG[1][32],fxDataAFL_REG[1][31:0]}),
  .B({gxDataBXL_reg[0][32],gxDataBFL_reg[0][31:0]}),
  .copyA(fxFCADD_copyA[H]),
  .en(fxFCADD_sn),
  .rmode(fpcsr[`csrfpu_rmode]),
  .res(FOOF[1][32:0]),
  .raise(fxFCADD_raise[1]),
  .fpcsr(fpcsr[31:0])
  );
  
  fperm #(1) fperm1CL_mod(
  .clk(clk),
  .rst(rst),
  .en(~fxFCADD_sn),
  .copyA(H? fxFCADD_com==2'b01 : ~fxFCADD_com[0]),
  .swpSngl(fxFCADD_pswp),
  .dupSngl(fxFCADD_dupl),
  .A(fxDataAXL_reg[1]),.B(gxDataBXL_reg[0]),
  .res(FOOF[1]));
 
  generate
      if (H) assign gxDataBFL[1]=u1_op_reg[9] ? u1_Bx : uu_B1;
      else assign gxDataBFL[1]=u1_op_reg[8] ? {uu_B1[68+15:68],u1_Bx} : uu_B1;
      if (H) assign gxDataBFL[0]=u2_op_reg[9] ? u2_Bx : uu_B2;
      else assign gxDataBFL[0]=u2_op_reg[8] ? {uu_B2[68+15:68],u2_Bx} : uu_B2;
      if (INDEX=0) begin
	      assign FUF4=FOOF_reg[0];
	      assign FUF7=FOOF_reg[1];
      end
      if (INDEX=1) begin
	      assign FUF5=FOOF_reg[0];
	      assign FUF8=FOOF_reg[1];
      end
      if (INDEX=2) begin
	      assign FUF6=|ALT_INP_reg ? {16*~H+SIMD_WIDTH{1'BZ}} : FOOF_reg[0];
	      assign FUF6=ALT_INP_reg[0] ? ALTDATA0 : {16*~H+SIMD_WIDTH{1'BZ}};
	      assign FUF6=ALT_INP_reg[1] ? ALTDATA1 : {16*~H+SIMD_WIDTH{1'BZ}};
	      FUF9=FOOF_reg[1];
      end
  endgenerate

//  if (m!=2) assign FUFL[4+m]=FOOFL_reg[2*m+0];
//  else assign FUFL[4+m]=fxFRT_alten_reg5[2]||~nDataAlt_reg5[2][2] ? {SIMD_WIDTH{1'BZ}} : FOOFL_reg[2*m+0];
//  assign FUFL[7+m]=FOOFL_reg[2*m+1];

  always @(negedge clk) begin
    if (rst) begin
	  fxFADD_dbl=3'b111;
	  fxFADD_dblext=3'b111;
	  fxFADD_ext=3'b000;
	  fxFADD_sub=6'b000000;
	  fxFADD_rsub=3'b0;
	  fxFADD_copyA=6'b0;
	  fxFADD_com[0]<=2'b0;
	  fxFADD_com[1]<=2'b0;
	  fxFADD_com[2]<=2'b0;
	  fxFADD_dupl<=3'b0;
	  fxFCADD_dupl<=3'b0;
	  fxFADD_pswp<=3'b0;
	  fxFADD_pcmp<=3'b0;
	  fxFCADD_dbl=3'b111;
	  fxFCADD_dblext=3'b111;
	  fxFCADD_ext=3'b000;
	  fxFCADD_copyA=6'b0;
	  fxFCADD_com[0]<=2'b0;
	  fxFCADD_com[1]<=2'b0;
	  fxFCADD_com[2]<=2'b0;
	  fxFCADD_pswp<=3'b0;
	  fxFADD_sin=3'b0;
          fxFADD_copySA[0]=4'b0;
          fxFADD_copySA[1]=4'b0;
          fxFADD_copySA[2]=4'b0;
	  fxFCADD_sn=3'b0;
	  fxFCADD_copyASN[0]=4'b0;
	  fxFCADD_copyASN[1]=4'b0;
	  fxFCADD_copyASN[2]=4'b0;
	  fxFADD_lo=3'b0;
	  fxFADD_loSel[0]=4'b0;
	  fxFADD_loSel[1]=4'b0;
	  fxFADD_loSel[2]=4'b0;
	  fxFCADD_rndD<=3'b0;
	  fxFCADD_rndS<=3'b0;
          for (k=0;k<2;k=k+1) begin
	      fxDataAFL_reg[k]<={16*~H+SIMD_WIDTH{1'B0}};
	      gxDataBFL_reg[k]<={16*~H+SIMD_WIDTH{1'B0}};
	      fxDataAFL_REG[k]<={16*~H+SIMD_WIDTH{1'B0}};
	      fxDataAXL_reg[k]<={16*~H+SIMD_WIDTH{1'B0}};
	      gxDataBXL_reg[k]<={16*~H+SIMD_WIDTH{1'B0}};
	  end
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
              fxFADD_dblext=fxFADD_dbl[k]||fxFADD_ext[k];
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
              fxFADD_pcmp<=gxFADD_pkdS | gxFADD_pkdD;
	      {fxFADD_pswp,fxFADD_com}<=u1_op_reg[10:8];
	      {fxFCADD_pswp,fxFCADD_com}<=u2_op_reg[10:8];
              fxFADD_dupl<=u1_op_reg[12];
              fxFCADD_dupl<=u2_op_reg[12];
	      
	      fxFCADD_dbl=u2_op_reg[7:0]==`fop_mulDL ||
	        u2_op_reg[7:0]==`fop_mulDH ||
	        u2_op_reg[7:0]==`fop_mulDP || u2_op_reg[7:0]==`fop_rndDSP;
              fxFCADD_ext=u2_op_reg[7:0]==`fop_mulEE || u2_op_reg[7:0]==`fop_rndES ||
	        u2_op_reg[7:0]==`fop_rndED;
              fxFCADD_dblext=fxFCADD_dbl[k]||fxFCADD_ext[k];
	      fxFCADD_copyA[1]=u2_op_reg[7:0]==`fop_mulDL;
	      fxFCADD_copyA[0]=u2_op_reg[7:0]==`fop_mulDH;
	     
	      fxFCADD_rndD=u2_op_reg[7:0]==`fop_rndED;
	      fxFCADD_rndS=u2_op_reg[7:0]==`fop_rndES ||
	        u2_op_reg[7:0]==`fop_rndDSP;

	      fxFADD_sin=u1_op_reg[7:0]==`fop_addS || u1_op_reg[7:0]==`fop_addSP ||
                  u1_op_reg[7:0]==`fop_subS || u1_op_reg[7:0]==`fop_subSP;
              fxFADD_copySA=(u1_op_reg==`fop_addSP || u1_op_reg[7:0]==`fop_subSP ||
	          {u1_op_reg[7:2],2'b0}==`fop_logic) ?
		  {u1_op_reg[10],3'b0}:{2'b11,u1_op_reg[10],1'b0}; 
	      fxFCADD_sn=u2_op_reg[7:0]==`fop_mulS || u2_op_reg[7:0]==`fop_mulSP;
              fxFCADD_copyASN[k]=(u2_op_reg==`fop_mulSP) ?
		  {u2_op_reg[10],3'b0}:{2'b11,u2_op_reg[10],1'b0}; 
	      if (fxFADD_dblext) begin
	          if (~fxFADD_copyA[0]) fxDataAFL_reg[0]<=uu_A1;
	          if (~fxFADD_copyA[0]) gxDataBFL_reg[1]<=gxDataBFL[1];
	          fxDataAFL_REG[0]<=uu_A1;
	      end
	      if (fxFCADD_dblext) begin
	          if (~fxFCADD_copyA[0]) fxDataAFL_reg[1]<=uu_A2;
	          if (~fxFCADD_copyA[0]) gxDataBFL_reg[0]<=gxDataBFL[0];
	          fxDataAFL_REG[1]<=uu_A2;
	      end
	      if (~fxFADD_dblext) begin
	          fxDataAXL_reg[0]<=uu_A1;
	          gxDataBXL_reg[1]<=gxDataBFL[1];
	      end
	      if (~fxFCADD_dblext) begin
	          fxDataAXL_reg[1]<=uu_A2;
	          gxDataBXL_reg[0]<=gxDataBFL[0];
	      end
    end
    for(k=0;k<2;k=k+1) begin
        FOOF_reg[k]<=FOOF[k];
        FOOFH_reg[k]<=FOOFH[k];
        fxFCADD_raise_reg[k]<=fxFCADD_raise[k];
        fxFADD_raise_reg[k]<=fxFADD_raise[k];
        fxFCADD_raise_s_reg[k]<=fxFCADD_s_raise[k];
        fxFADD_raise_s_reg[k]<=fxFADD_s_raise[k];
    end
  end

  always @(posedge clk) begin
      ALT_INP_reg<=ALT_INP;
      gxFADD_en=u1_op[0] && u1_clkEn && u1_op[7:0]==`fop_cmpDH || u1_op[7:0]==`fop_cmpDL || u1_op[7:0]==`fop_cmpE || u1_op[7:0]==`fop_cmpS;
      gxFADD_ord=u1_op[10];
      gxFADD_hi=u1_op[7:0]==`fop_cmpDH;
      gxFADD_ext=u1_op[7:0]==`fop_cmpE;
      gxFADD_dbl=u1_op[7:0]==`fop_cmpDH || u1_op[7:0]==`fop_cmpDL;
      gxFADD_sn=~gxFADD_ext & ~gxFADD_dbl;
      gxFADD_sin=~gxFADD_dbl; 
      gxFADD_pkdS<={u1_op[7:2],2'b0}==`fop_pcmplt && u1_op[10];
      gxFADD_pkdD<={u1_op[7:2],2'b0}==`fop_pcmplt && ~u1_op[10];
      gxFADD_en_reg[k]<=gxFADD_en[k];
      gxFADD_en_reg2[k]<=gxFADD_en_reg[k];

  end

endmodule
