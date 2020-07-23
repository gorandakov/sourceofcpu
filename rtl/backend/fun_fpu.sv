`include "../struct.sv"
`include "../fpoperations.sv"
`include "../csrss_no.sv"

module fun_fpu(
  clk,
  rst,
  u1_A,u1_B,u1_Ax,u1_Bx,u1_en,u1_op,
  u1_fufwd_A,u1_fuufwd_A,u1_fufwd_B,u1_fuufwd_B,
  u1_ret,u1_flg,
  u2_A,u2_B,u2_Ax,u2_Bx,u2_en,u2_op,
  u2_fufwd_A,u2_fuufwd_A,u2_fufwd_B,u2_fuufwd_B,
  u2_ret,
  u3_A,u3_B,u3_Ax,u3_Bx,u3_en,u3_op,
  u3_fufwd_A,u3_fuufwd_A,u3_fufwd_B,u3_fuufwd_B,
  u3_xdata,u3_xdata_en,u3_xdata_ret,
  u3_ret,
  FUF0,FUF1,FUF2,
  FUF3,FUF4,FUF5,
  FUF6,FUF7,FUF8,
  FUF9
  );
  parameter [1:0] INDEX=2'd0;
  parameter [0:0] H=1'b0;
  localparam SIMD_WIDTH=68; //half width
  input clk;
  input rst;
  input [67:0] u1_A;
  input [67:0] u1_B;
  input [15:0] u1_Ax;
  input [15:0] u1_Bx;
  input [3:0] u1_en;
  input [12:0] u1_op;
  input [3:0] u1_fufwd_A;
  input [3:0] u1_fuufwd_A;
  input [3:0] u1_fufwd_B;
  input [3:0] u1_fuufwd_B;
  output [13:0] u1_ret;
  output [5:0] u1_flg;

  input [67:0] u2_A;
  input [67:0] u2_B;
  input [15:0] u2_Ax;
  input [15:0] u2_Bx;
  input [3:0] u2_en;
  input [12:0] u2_op;
  input [3:0] u2_fufwd_A;
  input [3:0] u2_fuufwd_A;
  input [3:0] u2_fufwd_B;
  input [3:0] u2_fuufwd_B;
  output [13:0] u2_ret;
 
  input [67:0] u3_A;
  input [67:0] u3_B;
  input [15:0] u3_Ax;
  input [15:0] u3_Bx;
  input [3:0] u3_en;
  input [12:0] u3_op;
  input [3:0] u3_fufwd_A;
  input [3:0] u3_fuufwd_A;
  input [3:0] u3_fufwd_B;
  input [3:0] u3_fuufwd_B;
  input [67:0] u3_xdata;
  input u3_xdata_en;
  input [13:0] u3_xdata_ret;
  output [13:0] u3_ret;
  output [5:0] u3_flg;

  input [67:0] FUF0;
  input [67:0] FUF1;
  input [67:0] FUF2;
  input [67:0] FUF3;
  input [67:0] FUF4;
  input [67:0] FUF5;
  input [67:0] FUF6;
  input [67:0] FUF7;
  input [67:0] FUF8;
  input [67:0] FUF9;

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
  wire [10:0] fraise2;
  wire [10:0] fraise3;
  wire [10:0] fmask2;
  wire [10:0] fmask3;
  //wire [15:0] u1_Bx=u1_BH[15:0];
  //wire [15:0] u2_Bx=u2_BH[15:0];
  integer k;

  rs_write_forward #(68) u1_A_fwd(
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
  
  rs_write_forward #(68) u1_B_fwd(
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
  
  rs_write_forward #(68) u2_A_fwd(
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
  
  rs_write_forward #(68) u2_B_fwd(
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
  
  
  fadd fadd1H_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAFL_reg[0][65],fxDataAFH_reg[0][15:0],fxDataAFL_reg[0][64:33],
    fxDataAFL_reg[0][31:0]}),
  .A_alt({fxDataAFL_REG[0][65],fxDataAFL_REG[0][64:33],
    fxDataAFL_REG[0][31:0]}),
  .B({gxDataBFL_reg[1][65],gxDataBFH_reg[1][15:0],gxDataBFL_reg[1][64:33],
    gxDataBFL_reg[1][31:0]}),
  .isDBL(1'b1),
  .isSub(fxFADD_sub[H]),
  .isRSub(fxFADD_rsub),
  .invExcpt(fpcsr[`csrfpu_inv_excpt]),
  .raise(fxFADD_raise),
  .fpcsr(fpcsr[31:0]),
  .rmode(fpcsr[`csrfpu_rmode]),
  .copyA(fxFADD_copyA[H]),
  .en(H? fxFADD_dbl&~xdata_en_reg2:fxFADD_dblext&~xdata_en_reg2),
  .res(FOOF[0]),
  .res_hi(FOOFH[0])
  );
  
 
  fperm fperm1H_mod(
  .clk(clk),
  .rst(rst),
  .en(~(H? fxFADD_dbl:fxFADD_dblext)&~fxFADD_sin&~fxFADD_pcmp&~xdata_en_reg2),
  .copyA(H? fxFADD_com==2'b01 : ~fxFADD_com[0]),
  .swpSngl(fxFADD_pswp),
  .dupSngl(fxFADD_dupl),
  .A(fxDataAXH_reg[0]),.B(gxDataBXH_reg[1]),
  .res(FOOF[0]));
  
  
  fcmpd fcmpL_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAFL[0][65],fxDataAFH[0][15:0],fxDataAFL[0][64:32],
    fxDataAFL[0][31:0]}),
  .B({gxDataBFL[1][65],gxDataBFH[1][15:0],gxDataBFL[1][64:32],
    gxDataBFL[1][31:0]}),
  .ord(gxFADD_ord),.invExcpt(fpcsr[`csrfpu_inv_excpt]),
  .isExt(H ? 1'b0: gxFADD_ext),.isDbl(gxFADD_dbl),.isSng(H? gxFADD_sn:gxFADD_sin),
  .afm(1'b0),.flags(FOOSH),
  .paired(gxFADD_pkdS&~xdata_en_reg2),
  .vec(gxFADD_pkdD&~xdata_en_reg2),
  .jumpType(5'b0),
  .cmod(outOp_reg3[1][1:0]),
  .res_pkd(FOOF[0])
  );

  //assign FOOS=gxFADD_hi ? FOOSH[m] : FOOSL[m];

  assign fraise2[m]=fxFCADD_sn_reg5[m] ?
    (fxFCADD_raise_s_reg[0]|fxFCADD_raise_s_reg[1])&fpcsr[21:11] :
    (fxFCADD_raise_reg)&fpcsr[21:11];
  assign fmask2[m]=fxFCADD_sn_reg5[m] ?
    (fxFCADD_raise_s_reg[0]|fxFCADD_raise_s_reg[1]) :
    (fxFCADD_raise_reg);
  fexcpt fexcpt2_mod(fraise2_reg,{5'b0,FUS_alu[1],ex_alu[1]},
    fmaks2_reg,|outEn_reg6[2][3:2],fexcpt2_no,fexcpt2_en);
  assign fraise3[m]=fxFADD_sn_reg5[m] ?
    (fxFADD_raise_s_reg[0]|fxFADD_raise_s_reg[1])&fpcsr[21:11] :
    (fxFADD_raise_reg)&fpcsr[21:11];
  assign fmask3[m]=fxFADD_sn_reg5[m] ?
    (fxFADD_raise_s_reg[0]|fxFADD_raise_s_reg[1]) :
    (fxFADD_raise_reg);
  fexcpt fexcpt3_mod(fraise3_reg,{5'b0,FUS_alu[1],ex_alu[1]},
    fmaks3_reg,|outEn_reg6[1][3:2],fexcpt3_no,fexcpt3_en);
/*module fexcpt(
  mask,
  in,
  in_mask,
  in_en,
  no,
  en);
*/
  
  fpucadd cadd2L_mod(
  .clk(clk),
  .rst(rst),
  .A({fxDataAFL_reg[1][65],fxDataAFH_reg[1][15:0],
    fxDataAFL_reg[1][64:33],fxDataAFL_reg[1][31:0]}),
  .A_alt({fxDataAFL_REG[1][65],
    fxDataAFL_REG[1][64:33],fxDataAFL_REG[1][31:0]}),
  .B({gxDataBFL_reg[0][65],gxDataBFH_reg[0][15:0],
    gxDataBFL_reg[0][64:33],gxDataBFL_reg[0][31:0]}),
  .and1(H? 1'b0 : fxFCADD_ext),
  .or1(H? 1'b1 : fxFCADD_dbl),
  .copyA(fxFCADD_copyA[H]),
  .en(H? fxFCADD_dbl : fxFCADD_dblext),
  .rmode(fxFCADD_dbl|H ? fpcsr[`csrfpu_rmode] : fpcsr[`csrfpu_rmodeE]),
  .res(FOOF[1]),
  .res_hi(FOOFH[1]),
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
  .A(fxDataAXL_reg[1]),.B(gxDataBXL_reg[0]),
  .res(FOOF[1]));
 
  assign gxDataBFL[1]=uu_B1;
  assign gxDataBFL[0]=uu_B2;

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
	      fxDataAFH_reg[k]<=16'B0;
	      fxDataAFL_reg[k]<={SIMD_WIDTH{1'B0}};
	      gxDataBFH_reg[k]<=16'B0;
	      gxDataBFL_reg[k]<={SIMD_WIDTH{1'B0}};
	      fxDataAFH_REG[k]<=16'B0;
	      fxDataAFL_REG[k]<={SIMD_WIDTH{1'B0}};
	      fxDataAXH_reg[k]<=16'B0;
	      fxDataAXL_reg[k]<={SIMD_WIDTH{1'B0}};
	      gxDataBXH_reg[k]<=16'B0;
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
		  if (~fxFADD_copyA[1]) fxDataAFH_reg[0]<=u1_Ax;
	          if (~fxFADD_copyA[0]) fxDataAFL_reg[0]<=uu_A1;
	          if (~fxFADD_copyA[1]) gxDataBFH_reg[1]<=u1_Bx;
	          if (~fxFADD_copyA[0]) gxDataBFL_reg[1]<=gxDataBFL[1];
		  fxDataAFH_REG[0]<=u1_Ax;
	          fxDataAFL_REG[0]<=uu_A1;
	      end
	      if (fxFCADD_dblext) begin
		  if (~fxFCADD_copyA[1]) fxDataAFH_reg[1]<=u2_Ax;
	          if (~fxFCADD_copyA[0]) fxDataAFL_reg[1]<=uu_A2;
	          if (~fxFCADD_copyA[1]) gxDataBFH_reg[0]<=u2_Bx;
	          if (~fxFCADD_copyA[0]) gxDataBFL_reg[0]<=gxDataBFL[0];
		  fxDataAFH_REG[1]<=u2_Ax;
	          fxDataAFL_REG[1]<=uu_A2;
	      end
	      if (~fxFADD_dblext) begin
		  fxDataAXH_reg[0]<=u1_Ax;
	          fxDataAXL_reg[0]<=uu_A1;
	          gxDataBXL_reg[1]<=gxDataBFL[1];
	      end
	      if (~fxFCADD_dblext) begin
		  fxDataAXH_reg[1]<=u2_Ax;
	          fxDataAXL_reg[1]<=uu_A2;
	          gxDataBXL_reg[0]<=gxDataBFL[0];
	      end
          end
    end
    for(k=0;k<2;k=k+1) begin
        FOOF_reg[k1]<=FOOF[k1];
        FOOFH_reg[k1]<=FOOFH[k1];
        fxFCADD_raise_reg[k1]<=fxFCADD_raise[k1];
        fxFADD_raise_reg[k1]<=fxFADD_raise[k1];
    end
  end


endmodule
