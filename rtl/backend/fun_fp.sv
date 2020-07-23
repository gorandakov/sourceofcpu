`include "../struct.sv"
`include "../fpoperations.sv"
`include "../csrss_no.sv"

module funit_fp(
  clk,
  rst,
  u1_A,u1_B,u1_Ax,u1_Bx,u1_en,u1_op,
  u1_fufwdA,u1_fuufwdA,u1_fufwdB,u1_fuufwdB,
  u1_xdata,u1_xdata_en,u1_xdata_ret,
  u1_ret,u1_flg,
  u2_A,u2_B,u2_Ax,u2_Bx,u2_en,u2_op,
  u2_fufwdA,u2_fuufwdA,u2_fufwdB,u2_fuufwdB,
  u2_ret,
  FUF0,FUF1,FUF2,
  FUF3,FUF4,FUF5,
  FUF6,FUF7,FUF8,
  FUF9
  );
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
  
  fadd fadd1H_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAFH_reg[2*m+0][65],16'b0,fxDataAFH_reg[2*m+0][64:33],
    fxDataAFH_reg[2*m+0][31:0]}),
  .A_alt({fxDataAFH_REG[2*m+0][65],fxDataAFH_REG[2*m+0][64:33],
    fxDataAFH_REG[2*m+0][31:0]}),
  .B({gxDataBFH_reg[2*m+1][65],16'b0,gxDataBFH_reg[2*m+1][64:33],
    gxDataBFH_reg[2*m+1][31:0]}),
  .isDBL(1'b1),
  .isSub(fxFADD_sub[2*m+1]),
  .isRSub(fxFADD_rsub[m]),
  .invExcpt(fpcsr[`csrfpu_inv_excpt]),
  .rmode(fpcsr[`csrfpu_rmode]),
  .copyA(fxFADD_copyA[2*m+1]),
  .en(fxFADD_dbl[m]),
  .res(FOOFH[2*m+0]),
  .res_hi()
  );
  
  fadd fadd1L_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAFL_reg[2*m+0][65],fxDataAFH_reg[2*m+0][15:0],fxDataAFL_reg[2*m+0][64:33],
    fxDataAFL_reg[2*m+0][31:0]}),
  .A_alt({fxDataAFL_REG[2*m+0][65],fxDataAFL_REG[2*m+0][64:33],
    fxDataAFL_REG[2*m+0][31:0]}),
  .B({gxDataBFL_reg[2*m+1][65],gxDataBFH_reg[2*m+1][15:0],gxDataBFL_reg[2*m+1][64:33],
    gxDataBFL_reg[2*m+1][31:0]}),
  .isDBL(fxFADD_dbl[m]),
  .isSub(fxFADD_sub[2*m]),
  .isRSub(1'b0),
  .invExcpt(fpcsr[`csrfpu_inv_excpt]),
  .rmode(fxFADD_dbl[m] ? fpcsr[`csrfpu_rmode] : fpcsr[`csrfpu_rmodeE]),
  .copyA(fxFADD_copyA[2*m+0]),
  .en(fxFADD_dblext[m]),
  .res(FOOFL[2*m+0]),
  .res_hi(FOOFH[2*m+0][15:0])
  );
 
  fperm fperm1H_mod(
  .clk(clk),
  .rst(rst),
  .en(~fxFADD_dbl[m]&~fxFADD_sin[m]&~fxFADD_pcmp[m]),
  .copyA(fxFADD_com[m]==2'b01),
  .swpSngl(fxFADD_pswp[m]),
  .dupSngl(fxFADD_dupl[m]),
  .A(fxDataAXH_reg[2*m+0]),.B(gxDataBXH_reg[2*m+1]),
  .res(FOOFH[2*m+0]));
  
  fperm fperm1L_mod(
  .clk(clk),
  .rst(rst),
  .en(~fxFADD_dblext[m]&~fxFADD_sin[m]&~fxFADD_pcmp[m]),
  .copyA(~fxFADD_com[m][0]),
  .swpSngl(fxFADD_pswp[m]),
  .dupSngl(fxFADD_dupl[m]),
  .A(fxDataAXH_reg[2*m+0]),.B(gxDataBXH_reg[2*m+1]),
  .res(FOOFL[2*m+0]));
  
  fcmpd fcmpH_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAFH[2*m+0][65],16'b0,fxDataAFH[2*m+0][64:32],
    fxDataAFH[2*m+0][31:0]}),
  .B({gxDataBFH[2*m+1][65],16'b0,gxDataBFH[2*m+1][64:32],
    gxDataBFH[2*m+1][31:0]}),
  .ord(gxFADD_ord[m]),.invExcpt(fpcsr[`csrfpu_inv_excpt]),
  .isExt(1'b0),.isDbl(gxFADD_dbl[m]),.isSng(gxFADD_sn[m]),
  .afm(1'b0),.flags(FOOSH[m]),
  .paired(gxFADD_pkdS[m]),
  .vec(gxFADD_pkdD[m]),
  .jumpType(5'b0),
  .cmod(outOp_reg3[3*m+1][1:0]),
  .res_pkd(FOOFH[2*m+0])
  );
  
  fcmpd fcmpL_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAFL[2*m+0][65],fxDataAFH[2*m+0][15:0],fxDataAFL[2*m+0][64:32],
    fxDataAFL[2*m+0][31:0]}),
  .B({gxDataBFL[2*m+1][65],gxDataBFH[2*m+1][15:0],gxDataBFL[2*m+1][64:32],
    gxDataBFL[2*m+1][31:0]}),
  .ord(gxFADD_ord[m]),.invExcpt(fpcsr[`csrfpu_inv_excpt]),
  .isExt(gxFADD_ext[m]),.isDbl(gxFADD_dbl[m]),.isSng(gxFADD_sin[m]),
  .afm(1'b0),.flags(FOOSL[m]),
  .paired(gxFADD_pkdS[m]),
  .vec(gxFADD_pkdD[m]),
  .jumpType(5'b0),
  .cmod(outOp_reg3[3*m+1][1:0]),
  .res_pkd(FOOFL[2*m+0])
  );

  assign FOOS[m]=gxFADD_hi[m] ? FOOSH[m] : FOOSL[m];

  assign fraise2[m]=fxFCADD_sn_reg5[m] ?
    (fxFCADD_raise_s_reg[4*m+0]|fxFCADD_raise_s_reg[4*m+1]|
    fxFCADD_raise_s_reg[4*m+2]|fxFCADD_raise_s_reg[4*m+3])&fpcsr[21:11] :
    (fxFCADD_raise_reg[2*m+0]|fxFCADD_raise_reg[2*m+1])&fpcsr[21:11];
  assign fmask2[m]=fxFCADD_sn_reg5[m] ?
    (fxFCADD_raise_s_reg[4*m+0]|fxFCADD_raise_s_reg[4*m+1]|
    fxFCADD_raise_s_reg[4*m+2]|fxFCADD_raise_s_reg[4*m+3]) :
    (fxFCADD_raise_reg[2*m+0]|fxFCADD_raise_reg[2*m+1]);
  fexcpt fexcpt2_mod(fraise2_reg[m],{5'b0,FUS_alu[2*m+1],ex_alu[2*m+1]},
    fmaks2_reg[m],|outEn_reg6[3*m+2][3:2],fexcpt2_no[m],fexcpt2_en[m]);
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
  .A({fxDataAFH_reg[2*m+1][65],16'b0,fxDataAFH_reg[2*m+1][64:33],
    fxDataAFH_reg[2*m+1][31:0]}),
  .A_alt({fxDataAFH_REG[2*m+1][65],fxDataAFH_REG[2*m+1][64:33],
    fxDataAFH_REG[2*m+1][31:0]}),
  .B({gxDataBFH_reg[2*m+0][65],16'b0,gxDataBFH_reg[2*m+0][64:33],
    gxDataBFH_reg[2*m+0][31:0]}),
  .and1(1'b0),
  .or1(1'b1),
  .copyA(fxFCADD_copyA[2*m+1]),
  .en(fxFCADD_dbl[m]),
  .rmode(fpcsr[`csrfpu_rmode]),
  .res(FOOFH[2*m+1]),
  .res_hi(),
  .isDBL(1'b1),
  .raise(fxFCADD_raise[2*m+1]),
  .fpcsr(fpcsr[31:0]),
  .is_rndD(fxFCADD_rndD[m]),
  .is_rndS(fxFCADD_rndS[m])
  );
  
  fpucadd cadd2L_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAFL_reg[2*m+1][65],fxDataAFH_reg[2*m+1][15:0],
    fxDataAFL_reg[2*m+1][64:33],fxDataAFL_reg[2*m+1][31:0]}),
  .A_alt({fxDataAFL_REG[2*m+1][65],
    fxDataAFL_REG[2*m+1][64:33],fxDataAFL_REG[2*m+1][31:0]}),
  .B({gxDataBFL_reg[2*m+0][65],gxDataBFH_reg[2*m+0][15:0],
    gxDataBFL_reg[2*m+0][64:33],gxDataBFL_reg[2*m+0][31:0]}),
  .and1(fxFCADD_ext[m]),
  .or1(fxFCADD_dbl[m]),
  .copyA(fxFCADD_copyA[2*m+0]),
  .en(fxFCADD_dblext[m]),
  .rmode(fxFCADD_dbl[m] ? fpcsr[`csrfpu_rmode] : fpcsr[`csrfpu_rmodeE]),
  .res(FOOFL[2*m+1]),
  .res_hi(FOOFH[2*m+1][15:0]),
  .isDBL(fxFCADD_dbl[m]),
  .raise(fxFCADD_raise[2*m+0]),
  .fpcsr(fpcsr[31:0]),
  .is_rndD(fxFCADD_rndD[m]),
  .is_rndS(fxFCADD_rndS[m])
  );
  
  fperm #(1) fperm1HC_mod(
  .clk(clk),
  .rst(rst),
  .en(~fxFCADD_dbl[m]&~fxFCADD_sn[m]),
  .copyA(fxFCADD_com[m]==2'b01),
  .swpSngl(fxFCADD_pswp[m]),
  .dupSngl(fxFCADD_dupl[m]),
  .A(fxDataAXH_reg[2*m+1]),.B(gxDataBXH_reg[2*m+0]),
  .res(FOOFH[2*m+1]));
  
  fperm #(1) fperm1CL_mod(
  .clk(clk),
  .rst(rst),
  .en(~fxFCADD_dblext[m]&~fxFCADD_sn[m]),
  .copyA(~fxFCADD_com[m][0]),
  .swpSngl(fxFCADD_pswp[m]),
  .dupSngl(fxFCADD_dupl[m]),
  .A(fxDataAXH_reg[2*m+1]),.B(gxDataBXH_reg[2*m+0]),
  .res(FOOFL[2*m+1]));
  

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
          for (k=0;k<6;k=k+1) begin
	      fxDataAFH_reg[k]<={SIMD_WIDTH{1'B0}};
	      fxDataAFL_reg[k]<={SIMD_WIDTH{1'B0}};
	      gxDataBFH_reg[k]<={SIMD_WIDTH{1'B0}};
	      gxDataBFL_reg[k]<={SIMD_WIDTH{1'B0}};
	      fxDataAFH_REG[k]<={SIMD_WIDTH{1'B0}};
	      fxDataAFL_REG[k]<={SIMD_WIDTH{1'B0}};
	      fxDataAXH_reg[k]<={SIMD_WIDTH{1'B0}};
	      fxDataAXL_reg[k]<={SIMD_WIDTH{1'B0}};
	      gxDataBXH_reg[k]<={SIMD_WIDTH{1'B0}};
	      gxDataBXL_reg[k]<={SIMD_WIDTH{1'B0}};
	  end
    end else begin
          for (k=0;k<3;k=k+1) begin
	      fxFADD_dbl=u1_op_reg[7:0]==`fop_addDL ||
	        u1_op_reg[7:0]==`fop_addDH ||
	        u1_op_reg[7:0]==`fop_addDP ||
                u1_op_reg[7:0]==`fop_subDL ||
	        u1_op_reg[7:0]==`fop_subDH ||
                u1_op_reg[7:0]==`fop_subDP ||
                u1_op_reg[7:0]==`fop_addsubDP;
              fxFADD_ext=u1_op_reg[7:0]==`fop_addEE ||
                u1_op_reg[7:0]==`fop_subEE;
              fxFADD_dblext=fxFADD_dbl[k]||fxFADD_ext[k];
	      fxFADD_sub[0]=u1_op_reg[7:0]==`fop_subDL ||
	        u1_op_reg[7:0]==`fop_subDH ||
                u1_op_reg[7:0]==`fop_subDP ||
	        u1_op_reg[7:0]==`fop_subEE ||
		u1_op_reg[7:0]==`fop_subS ||
		u1_op_reg[7:0]==`fop_subSP;
	      fxFADD_sub[1]=fxFADD_sub[0] || 
		u1_op_reg[7:0]==`fop_addsubDP;
	      fxFADD_rsub=fxFADD_sub[2*k+1] && u1_op_reg[12];
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
                  u1_op_reg[7:0]==`fop_subS || u1_op_reg[7:0]==`fop_subSP ||
		  {u1_op_reg[7:2],2'b0}==`fop_logic;
              fxFADD_copySA=(u1_op_reg==`fop_addSP || u1_op_reg[7:0]==`fop_subSP ||
	          {u1_op_reg[7:2],2'b0}==`fop_logic) ?
		  {u1_op_reg[10],3'b0}:{2'b11,u1_op_reg[10],1'b0}; 
	      fxFCADD_sn=u2_op_reg[7:0]==`fop_mulS || u2_op_reg[7:0]==`fop_mulSP;
              fxFCADD_copyASN[k]=(u2_op_reg==`fop_mulSP) ?
		  {u2_op_reg[10],3'b0}:{2'b11,u2_op_reg[10],1'b0}; 
	      if (fxFADD_dblext) begin
		  if (~fxFADD_copyA[1]) fxDataAFH_reg[0]<=fxDataAFH[0];
	          if (~fxFADD_copyA[0]) fxDataAFL_reg[0]<=fxDataAFL[0];
	          if (~fxFADD_copyA[1]) gxDataBFH_reg[1]<=gxDataBFH[1];
	          if (~fxFADD_copyA[0]) gxDataBFL_reg[1]<=gxDataBFL[1];
		  fxDataAFH_REG[0]<=fxDataAFH[0];
	          fxDataAFL_REG[0]<=fxDataAFL[0];
	      end
	      if (fxFCADD_dblext) begin
		  if (~fxFCADD_copyA[1]) fxDataAFH_reg[1]<=fxDataAFH[1];
	          if (~fxFCADD_copyA[0]) fxDataAFL_reg[1]<=fxDataAFL[1];
	          if (~fxFCADD_copyA[1]) gxDataBFH_reg[0]<=gxDataBFH[0];
	          if (~fxFCADD_copyA[0]) gxDataBFL_reg[0]<=gxDataBFL[0];
		  fxDataAFH_REG[1]<=fxDataAFH[1];
	          fxDataAFL_REG[1]<=fxDataAFL[1];
	      end
	      if (~fxFADD_dblext) begin
		  fxDataAXH_reg[0]<=fxDataAFH[0];
	          fxDataAXL_reg[0]<=fxDataAFL[0];
	          gxDataBXH_reg[1]<=gxDataBFH[1];
	          gxDataBXL_reg[1]<=gxDataBFL[1];
	      end
	      if (~fxFCADD_dblext) begin
		  fxDataAXH_reg[1]<=fxDataAFH[1];
	          fxDataAXL_reg[1]<=fxDataAFL[1];
	          gxDataBXH_reg[0]<=gxDataBFH[0];
	          gxDataBXL_reg[0]<=gxDataBFL[0];
	      end
          end
    end
    for(k1=0;k1<6;k1=k1+1) begin
        FOOFL_reg[k1]<=FOOFL[k1];
        FOOFH_reg[k1]<=FOOFH[k1];
        fxFCADD_raise_reg[k1]<=fxFCADD_raise[k1];
    end
  end 

endmodule
