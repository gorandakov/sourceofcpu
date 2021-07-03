`include "../struct.sv"
`include "../operations.sv"
`include "../memop.sv"
`include "../fpoperations.sv"
`include "../intop.sv"


module smallInstr_decoder(
  clk,
  rst,
  mode64,
  instrQ,
  instr,
  operation,
  opchain,
  can_jump_csr,
  rA,rA_use,
  rB,rB_use,useBConst,cxEn,
  rC,rC_use,
  constant,
//  smallConst,
  rT,rT_use,
  port,port2,
  useRs,
  rA_useF,rB_useF,rT_useF,rC_useF,maskOp,
  rA_isV,rB_isV,rT_isV,
  rBT_copyV,
  chain,
  flags_use,
  flags_write,
  instr_fsimd,//choose simd-like over extended instr
  halt,
  
  isJump,
  jumpTaken,
  jumpType,
  jumpBtbHit,
  jumpIndir,
  isIPRel,
  rAlloc,
  reor_en,
  reor_val,
  reor_en_out,
  reor_val_out,
  error
  );
  
  localparam INSTR_WIDTH=32;
  localparam INSTRQ_WIDTH=`instrQ_width;
  localparam EXTRACONST_WIDTH=`extraconst_width;
  localparam OPERATION_WIDTH=`operation_width;
  localparam REG_WIDTH=6;
  localparam IP_WIDTH=48;
  localparam REG_BP=5;
  localparam REG_SP=4;
  localparam PORT_LOAD=4'd1;
  localparam PORT_STORE=4'd2;
  localparam PORT_SHIFT=4'd3;
  localparam PORT_ALU=4'd4;
  localparam PORT_MUL=4'd5;
  localparam PORT_FADD=4'd6;
  localparam PORT_FMUL=4'd7;
  localparam PORT_FANY=4'd8;
  localparam PORT_VADD=4'd9;
  localparam PORT_VCMP=4'd10;
  localparam PORT_VANY=4'd11;
  localparam REOR_WIDTH=24; 
  localparam TRICNT_TOP=40;//really 38; 2 redundant
  input clk;
  input rst;
  
  input [INSTRQ_WIDTH-1:0] instrQ;

  input [INSTR_WIDTH-1:0] instr;
  
  output [OPERATION_WIDTH-1:0] operation;
  output [OPERATION_WIDTH-1:0] opchain;
  input can_jump_csr;
  output [REG_WIDTH-1:0] rA;
  output rA_use;
  output [REG_WIDTH-1:0] rB;
  output rB_use;
  output [REG_WIDTH-1:0] rC;
  output rC_use;
  output useCRet;
  output useBConst;
  output cxEn;
//  output reg useBSmall;//small constant use; used for call/pop/push
  output [63:0] constant;
//  output reg [3:0] smallConst; //signed
  output [REG_WIDTH-1:0] rT;
  output rT_use;
  output [3:0] port;
  output [3:0] port2;
  output useRs;
  output rA_useF,rB_useF,rT_useF,rC_useF,maskOp;
  output rA_isV,rB_isV,rT_isV,rBT_copyV;
  output chain;
  output flags_use;
  output flags_write;
  output instr_fsimd;
  output halt;
  
  output isJump;
  output jumpTaken;
  output [4:0] jumpType;
  output jumpBtbHit;
  output jumpIndir;
  
  output isIPRel;
  output isIPRelB;
  output rAlloc;
  input reor_en;
  input [15:0] reor_val;
  output reor_en_out;
  output [15:0] reor_val_out;
  output wire error;
  //7:0 free 15:8 unfree 39:16 fxch/pop/push 
  wire [3:0] magic;
  wire [11:0] srcIPOff;
//  wire isAvx;
  wire [7:0] opcode_main;

  reg [15:0] fpu_reor;

  reg [5:0] rS1;
  reg [5:0] rS2;
  reg [5:0] rD;
  reg reor_error;

  
  reg keep2instr;
  
  wire [31:0] constantDef;

  wire [12:0] class_;

  wire [5:0] opcode_sub;

  reg isBigConst;
  
  wire flags_wrFPU;

  reg [OPERATION_WIDTH-1:0] poperation[TRICNT_TOP-1:0];
  reg [OPERATION_WIDTH-1:0] popchain[TRICNT_TOP-1:0];
  reg [REG_WIDTH-2:0] prA[TRICNT_TOP-1:0];
  reg prA_use[TRICNT_TOP-1:0];
  reg [REG_WIDTH-2:0] prB[TRICNT_TOP-1:0];
  reg prB_use[TRICNT_TOP-1:0];
  reg [REG_WIDTH-2:0] prC[TRICNT_TOP-1:0];
  reg prC_use[TRICNT_TOP-1:0];
  reg puseCRet[TRICNT_TOP-1:0];
  reg puseBConst[TRICNT_TOP-1:0];
  reg cxEn[TRICNT_TOP-1:0];
//  output reg useBSmall;//small constant use; used for call/pop/push
  reg [63:0] pconstant[TRICNT_TOP-1:0];
//  output reg [3:0] smallConst; //signed
  reg [REG_WIDTH-1:0] prT[TRICNT_TOP-1:0];
  reg prT_use[TRICNT_TOP-1:0];
  reg [3:0] pport[TRICNT_TOP-1:0];
  reg [3:0] pport2[TRICNT_TOP-1:0];
  reg puseRs[TRICNT_TOP-1:0];
  reg prA_useF[TRICNT_TOP-1:0];
  reg prB_useF[TRICNT_TOP-1:0];
  reg prT_useF[TRICNT_TOP-1:0];
  reg prC_useF[TRICNT_TOP-1:0];
  reg pmaskOp[TRICNT_TOP-1:0];
  reg prA_isV[TRICNT_TOP-1:0];
  reg prB_isV[TRICNT_TOP-1:0];
  reg prT_isV[TRICNT_TOP-1:0];
  reg prBT_copyV[TRICNT_TOP-1:0];
  reg pchain[TRICNT_TOP-1:0];
  reg pflags_use[TRICNT_TOP-1:0];
  reg pflags_write[TRICNT_TOP-1:0];
  reg pflags_wrFPU[TRICNT_TOP-1:0];
  reg pinstr_fsimd[TRICNT_TOP-1:0];
  reg phalt[TRICNT_TOP-1:0];
  
  wire [63:0] qconstant[11:0];
  wire [11:0] qtrien;
  
  reg [4:0] pjumpType[TRICNT_TOP-1:0];
  
  reg pisIPRel[TRICNT_TOP-1:0];
  reg pisIPRelB[TRICNT_TOP-1:0];
  reg prAlloc[TRICNT_TOP-1:0];
  reg [TRICNT_TOP-1:0] trien;
  reg perror[TRICNT_TOP-1:0];

  wire subIsBasicLDST;
  wire subIsStackLDST;
  
  wire subIsBasicImmAluReg5;
  wire subIs2xReg5Alu;
  wire subIsReg3Alu;
  wire subIsJMP;
  wire subIsAddI4;


  wire isLoad;
  wire isStore;
  wire isBasicALU;
  wire isBasicALU32;
  wire isAdvALUorJump;
  wire isOpFp;
  wire isFpFma;
  wire isJump;
  wire isSys;
  wire isExtImm;
  wire isExtALU;
  wire isAMO;
  integer tt;

  assign magic=instrQ[`instrQ_magic];
  assign jumpBtbHit=~instrQ[`instrQ_btbMiss];
  assign jumpIndir=class_[`iclass_indir];
  assign isJump=class_[`iclass_jump] || class_[`iclass_indir];
  assign srcIPOff=instrQ[`instrQ_srcIPOff];
 // assign isAvx=instrQ[`instrQ_avx];

  assign class_=instrQ[`instrQ_class];
          
  assign opcode_main=instr[7:0];
  assign opcode_sub=instr[5:0];
  
  assign constantDef={52{instr[31],instr[31:20]};
 
  assign reor_en_out=isReor&&~reor_error;
  assign reor_val_out=isReorCall ? {1'b1,instr[24:20],instr[19:15],instr[11:7]} : {1'b0,5'd10,5'd9,5'd8};

  assign isReor=isAMO||(isBasicALU|isBasicALU32 && instr[31:25]==7'b1 && instr[14])||
	  (isSys&&instr[13:12]!=2'b0);
  assign isReorCall=isAMO||(isBasicALU|isBasicALU32 && instr[31:25]==7'b1 && instr[14])||
	  (isSys&&instr[13:12]!=2'b0); 

  assign subIsBasicLDST=instr[14:13]!=2'b0 && instr[1:0]==2'b0;
  assign subIsStackLDST=instr[14:13]!=2'b0 && instr[1:0]==2'b10 && !(intr[15:14]==2'b01 && instr[11:7]==5'b0);
  
  assign subIsBasicImmAluReg5=(instr[1:0]==2'b01 && (instr[15:13]==3'b0 || (instr[15:13]==3'b1 &&
   instr[11:7]!=5'b0) || (instr[15:14]==2'b1 && instr[11:7]!=5'b0 && 
   instr[12]| |instr[6:2] |~instr[13])))||(instr[1:0]==2'b10 && instr[15:13]==3'b0 && instr[11:7]!=5'b0);  
  assign subIs2xReg5Alu=instr[1:0]==2'b10 && instr[15:13]==3'b100;
  assign subIsReg3Alu=instr[1:0]==2'b1 && instr[15:13]==3'b100 && !(instr[12:10]==3'b111 && instr[6]);
  assign subIsJMP=instr[1:0]==2'b1 && (instr[15:13]==3'b101 || instr[15:14]==2'b11);
  assign subIsAddI4=instr[15:13]==3'b0 && instr[1:0]==2'b0 && instr[12:5]!=8'b0;


  assign isLoad=opcode_main[6:3]==4'b0 && opcode_main[1:0]==2'b11;
  assign isStore=opcode_main[6:3]==4'b0100 && opcode_main[1:0]==2'b11;
  assign isBasicALU=!opcode_main[6] && opcode_main[4:2]==3'b100 && opcode_main[1:0]==2'b11;
  assign isBasicALU32=!opcode_main[6] && opcode_main[4:2]==3'b110 && opcode_main[1:0]==2'b11;
  assign isAdvALUorJump=(instr[6:5]==2'b11 && !instr[4] && instr[2] && !(!instr[3] && instr[14:12]!=3'b0)) |
	  (!instr[6] && instr[4:2]==3'b101) && opcode_main[1:0]==2'b11;
  assign isOpFp=instr[6:2]==5'b10100 && opcode_main[1:0]==2'b11;
  assign isFpFma=opcode_main[6:4]==2'b100 && opcode_main[1:0]==2'b11;
  assign isJump=opcode_main[6:0]==7'b1100011;
  assign isSys=opcode_main[6:0]==7'b1110011;
  assign isExtImm=opcode_main[6:0]==7'b1011011;
  assign isExtALU=opcode_main[6:0]==7'b1111011;
  assign isAMO=instr[6:2]==5'b01011 && instr[1:0]==2'b11;
  
  assign qconstant[1]=pconstant[3];//??
  assign qtrien   [1]=trien    [3];//??
  assign qconstant[2]=pconstant[8];
  assign qtrien   [2]=trien    [8];
  assign qconstant[3]=pconstant[9];
  assign qtrien   [3]=trien    [9];
  assign qconstant[4]=pconstant[10];
  assign qtrien   [4]=trien    [10];
  assign qconstant[5]=pconstant[18];
  assign qtrien   [5]=trien    [18];
  assign qconstant[6]=pconstant[20];
  assign qtrien   [6]=trien    [20];
  assign qconstant[7]=pconstant[25];
  assign qtrien   [7]=trien    [25];
  assign qconstant[8]=pconstant[26];
  assign qtrien   [8]=trien    [26];
  assign qconstant[9]=pconstant[30];
  assign qtrien   [9]=trien    [30];
  assign qconstant[10]=pconstant[35];
  assign qtrien   [10]=trien    [35];
  assign qconstant[11]=pconstant[13];
  assign qtrien   [11]=trien    [13];
  assign qconstant[0]=pconstant[0];
  assign qtrien   [0]=qtrien[11:1]==11'b0;
  
  //triens that set const
  //3,8,9,10,13,18,20,25,26,30, 35
 
  generate
      genvar p,q,m;
      for(m=0;m<12;m=m+1) begin : triconst_gen
	  assign constant=qtrien[m] ? qconstant[m] : 64'bz;
      end
      for(p=0;p<5;p=p+1) begin
          wire [OPERATION_WIDTH-1:0] koperation;
          wire [OPERATION_WIDTH-1:0] kopchain;
          wire [REG_WIDTH-2:0] krA;
          wire krA_use;
          wire [REG_WIDTH-2:0] krB;
          wire krB_use;
          wire [REG_WIDTH-2:0] krC;
          wire krC_use;
          wire kuseCRet;
          wire kuseBConst;
          wire kcxEn;
    //  output reg useBSmall;//small constant use; used for call/pop/push
          wire [63:0] kconstant;
    //  output reg [3:0] smallConst; //signed
          wire [REG_WIDTH-2:0] krT;
          wire krT_use;
          wire [3:0] kport;
          wire [3:0] kport2;
          wire kuseRs;
          wire krA_useF;
          wire krB_useF;
          wire krT_useF;
          wire krC_useF;
          wire kmaskOp;
          wire krA_isV;
          wire krB_isV;
          wire krT_isV;
          wire krBT_copyV;
          wire kclr64;
          wire kclr128;
          wire kchain;
          wire kflags_use;
          wire kflags_write;
          wire kinstr_fsimd;
          wire khalt;
          wire krAlloc;
          wire kthisSpecLoad;
          wire kisIPRel;
          wire kisIPRelB;
          wire kflags_wrFPU;
          wire kerror;
          wire [4:0] kjumpType;
	  for(q=0;q<8;q=q+1) begin : tri_gen
	      assign krA=trien[p*8+q] ? prA[p*8+q] : 5'bz;
	      assign krB=trien[p*8+q] ? prB[p*8+q] : 5'bz;
	      assign krC=trien[p*8+q] ? prC[p*8+q] : 5'bz;
	      assign krT=trien[p*8+q] ? prT[p*8+q] : 5'bz;
	      assign krA_use=trien[p*8+q] ? prA_use[p*8+q] : 1'bz;
	      assign krB_use=trien[p*8+q] ? prB_use[p*8+q] : 1'bz;
	      assign krC_use=trien[p*8+q] ? prC_use[p*8+q] : 1'bz;
	      assign krT_use=trien[p*8+q] ? prT_use[p*8+q] : 1'bz;
	      assign krA_useF=trien[p*8+q] ? prA_useF[p*8+q] : 1'bz;
	      assign krB_useF=trien[p*8+q] ? prB_useF[p*8+q] : 1'bz;
	      assign krC_useF=trien[p*8+q] ? prC_useF[p*8+q] : 1'bz;
	      assign kmaskOp=trien[p*8+q] ? pmaskOp[p*8+q] : 1'bz;
	      assign krT_useF=trien[p*8+q] ? prT_useF[p*8+q] : 1'bz;
	      assign krA_isV=trien[p*8+q] ? prA_isV[p*8+q] : 1'bz;
	      assign krB_isV=trien[p*8+q] ? prB_isV[p*8+q] : 1'bz;
	    //  assign krC_isV=trien[p*8+q] ? prC_isV[p*8+q] : 1'bz;
	      assign krT_isV=trien[p*8+q] ? prT_isV[p*8+q] : 1'bz;
	      assign kuseRs=trien[p*8+q] ? puseRs[p*8+q] : 1'bz;
	      assign krAlloc=trien[p*8+q] ? prAlloc[p*8+q] : 1'bz;
	      assign kuseBConst=trien[p*8+q] ? puseBConst[p*8+q] : 1'bz;
	      assign kcxEn=trien[p*8+q] ? pcxEn[p*8+q] : 1'bz;
	      assign kthisSpecLoad=trien[p*8+q] ? pthisSpecLoad[p*8+q] : 1'bz;
	      assign kisIPRel=trien[p*8+q] ? pisIPRel[p*8+q] : 1'bz;
	      assign kisIPRelB=trien[p*8+q] ? pisIPRelB[p*8+q] : 1'bz;
	      assign kflags_use=trien[p*8+q] ? pflags_use[p*8+q] : 1'bz;
	      assign kflags_write=trien[p*8+q] ? pflags_write[p*8+q] : 1'bz;
	      assign kflags_wrFPU=trien[p*8+q] ? pflags_wrFPU[p*8+q] : 1'bz;
	      assign krBT_copyV=trien[p*8+q] ? prBT_copyV[p*8+q] : 1'bz;
	      assign kinstr_fsimd=trien[p*8+q] ? pinstr_fsimd[p*8+q] : 1'bz;
	      assign kerror=trien[p*8+q] ? perror[p*8+q] : 1'bz;
	      assign kport=trien[p*8+q] ? pport[p*8+q] : 4'bz;
	      assign kport2=trien[p*8+q] ? pport2[p*8+q] : 4'bz;
	      assign kjumpType=trien[p*8+q] ? pjumpType[p*8+q] : 5'bz;
	      assign koperation=trien[p*8+q] ? poperation[p*8+q] : 13'bz;
	      assign kopchain=trien[p*8+q] ? popchain[p*8+q] : 13'bz;
	  end
	  assign krA=(~|trien[p*8+:8]) ? 5'b0 : 5'bz;
	  assign krB=(~|trien[p*8+:8]) ? 5'b0 : 5'bz;
	  assign krC=(~|trien[p*8+:8]) ? 5'b0 : 5'bz;
	  assign krT=(~|trien[p*8+:8]) ? 5'b0 : 5'bz;
	  assign krA_use=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krB_use=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krC_use=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krT_use=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krA_useF=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krB_useF=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krC_useF=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kmaskOp=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krT_useF=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krA_isV=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krB_isV=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
//	  assign krC_isV=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krT_isV=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kuseRs=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krAlloc=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kuseBConst=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kcxEn=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kisIPRel=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kisIPRelB=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kflags_use=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kflags_write=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kflags_wrFPU=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krBT_copyV=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kinstr_fsimd=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kerror=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kport=(~|trien[p*8+:8]) ? 4'b0 : 4'bz;
	  assign kport2=(~|trien[p*8+:8]) ? 4'b0 : 4'bz;
	  assign kjumpType=(~|trien[p*8+:8]) ? 5'b10000 : 5'bz;
	  assign koperation=(~|trien[p*8+:8]) ? 13'b0 : 13'bz;
	  assign kopchain=(~|trien[p*8+:8]) ? 13'b0 : 13'bz;
	      
	  assign rA=(|trien[p*8+:8]) ? {1'b0,krA} : 6'bz;
	  assign rB=(|trien[p*8+:8]) ? {1'b0,krB} : 6'bz;
	  assign rC=(|trien[p*8+:8]) ? {1'b0,krC} : 6'bz;
	  assign rT=(|trien[p*8+:8]) ? {1'b0,krT} : 6'bz;
	  assign rA_use=(|trien[p*8+:8]) ? krA_use : 1'bz;
	  assign rB_use=(|trien[p*8+:8]) ? krB_use : 1'bz;
	  assign rC_use=(|trien[p*8+:8]) ? krC_use : 1'bz;
	  assign rT_use=(|trien[p*8+:8]) ? krT_use : 1'bz;
	  assign rA_useF=(|trien[p*8+:8]) ? krA_useF : 1'bz;
	  assign rB_useF=(|trien[p*8+:8]) ? krB_useF : 1'bz;
	  assign rC_useF=(|trien[p*8+:8]) ? krC_useF : 1'bz;
	  assign maskOp=(|trien[p*8+:8]) ? kmaskOp : 1'bz;
	  assign rT_useF=(|trien[p*8+:8]) ? krT_useF : 1'bz;
	  assign rA_isV=(|trien[p*8+:8]) ? krA_isV : 1'bz;
	  assign rB_isV=(|trien[p*8+:8]) ? krB_isV : 1'bz;
	//  assign rC_isV=(|trien[p*8+:8]) ? krC_isV : 1'bz;
	  assign rT_isV=(|trien[p*8+:8]) ? krT_isV : 1'bz;
	  assign useRs=(|trien[p*8+:8]) ? kuseRs : 1'bz;
	  assign rAlloc=(|trien[p*8+:8]) ? krAlloc : 1'bz;
	  assign useBConst=(|trien[p*8+:8]) ? kuseBConst : 1'bz;
	  assign cxEn=(|trien[p*8+:8]) ? kcxEn : 1'bz;
//	  assign thisSpecLoad=(|trien[p*8+:8]) ? kthisSpecLoad : 1'bz;
	  assign isIPRel=(|trien[p*8+:8]) ? kisIPRel : 1'bz;
	  assign isIPRelB=(|trien[p*8+:8]) ? kisIPRelB : 1'bz;
	  assign flags_use=(|trien[p*8+:8]) ? kflags_use : 1'bz;
	  assign flags_write=(|trien[p*8+:8]) ? kflags_write : 1'bz;
	  assign flags_wrFPU=(|trien[p*8+:8]) ? kflags_wrFPU : 1'bz;
	  assign rBT_copyV=(|trien[p*8+:8]) ? krBT_copyV : 1'bz;
	  assign instr_fsimd=(|trien[p*8+:8]) ? kinstr_fsimd : 1'bz;
	  assign error=(|trien[p*8+:8]) ? kerror : 1'bz;
	  assign port=(|trien[p*8+:8]) ? kport : 4'bz;
	  assign port2=(|trien[p*8+:8]) ? kport2 : 4'bz;
	  assign jumpType=(|trien[p*8+:8]) ? kjumpType : 5'bz;
	  assign operation=(|trien[p*8+:8]) ? koperation : 13'bz;
	  assign opchain=(|trien[p*8+:8]) ? kopchain : 13'bz;
      end

  endgenerate 
  
  assign rA=(~|trien) ? 6'b0 : 6'bz;
  assign rB=(~|trien) ? 6'b0 : 6'bz;
  assign rC=(~|trien) ? 6'b0 : 6'bz;
  assign rT=(~|trien) ? 6'b0 : 6'bz;
  assign rA_use=(~|trien) ? 1'b0 : 1'bz;
  assign rB_use=(~|trien) ? 1'b0 : 1'bz;
  assign rC_use=(~|trien) ? 1'b0 : 1'bz;
  assign rT_use=(~|trien) ? 1'b0 : 1'bz;
  assign rA_useF=(~|trien) ? 1'b0 : 1'bz;
  assign rB_useF=(~|trien) ? 1'b0 : 1'bz;
  assign rC_useF=(~|trien) ? 1'b0 : 1'bz;
  assign maskOp=(~|trien) ? 1'b0 : 1'bz;
  assign rT_useF=(~|trien) ? 1'b0 : 1'bz;
  assign rA_isV=(~|trien) ? 1'b0 : 1'bz;
  assign rB_isV=(~|trien) ? 1'b0 : 1'bz;
//  assign rC_isV=(~|trien) ? 1'b0 : 1'bz;
  assign rT_isV=(~|trien) ? 1'b0 : 1'bz;
  assign useRs=(~|trien) ? 1'b0 : 1'bz;
  assign rAlloc=(~|trien) ? 1'b0 : 1'bz;
  assign useBConst=(~|trien) ? 1'b0 : 1'bz;
  assign cxEn=(~|trien) ? 1'b0 : 1'bz;
//  assign thisSpecLoad=(~|trien) ? 1'b0 : 1'bz;
  assign isIPRel=(~|trien) ? 1'b0 : 1'bz;
  assign isIPRelB=(~|trien) ? 1'b0 : 1'bz;
  assign flags_use=(~|trien) ? 1'b0 : 1'bz;
  assign flags_write=(~|trien) ? 1'b0 : 1'bz;
  assign flags_wrFPU=(~|trien) ? 1'b0 : 1'bz;
  assign rBT_copyV=(~|trien) ? 1'b0 : 1'bz;
  assign instr_fsimd=(~|trien) ? 1'b0 : 1'bz;
  assign error=(~|trien) ? 1'b1 : 1'bz;
  assign port=(~|trien) ? PORT_LOAD : 4'bz;
  assign port2=(~|trien) ? PORT_ALU : 4'bz;
  assign jumpType=(~|trien) ? 5'b10000 : 5'bz;
  assign operation=(~|trien) ? 13'hff : 13'bz;
  assign opchain=(~|trien) ? 13'hff : 13'bz;
  
  always @(posedge clk) begin
    if (rst) fpu_reor<=32'b111110101100011010001000;
    else if (reor_en) begin
        fpu_reor[2:0]<=fpu_reor[3*reor_val[2:0]+:3];
        fpu_reor[5:3]<=fpu_reor[3*reor_val[5:3]+:3];
        fpu_reor[8:6]<=fpu_reor[3*reor_val[8:6]+:3];
        fpu_reor[11:9]<=fpu_reor[3*reor_val[11:9]+:3];
        fpu_reor[14:12]<=fpu_reor[3*reor_val[14:12]+:3];
        fpu_reor[17:15]<=fpu_reor[3*reor_val[17:15]+:3];
        fpu_reor[20:18]<=fpu_reor[3*reor_val[20:18]+:3];
        fpu_reor[23:21]<=fpu_reor[3*reor_val[23:21]+:3];
    end
  end

  always @*
  begin
      reor_error=1'b0;
      for(tt=0;tt<TRICNT_TOP;tt=tt+1) begin 
          poperation[tt]=13'b0;
          popchain[tt]=13'b0;
          puseBConst[tt]=1'b0;
          puseRs[tt]=1'b0;
          prA[tt]=5'd0;
          prB[tt]=5'd0;
          prC[tt]=5'd0;
          prT[tt]=5'd0;
          prA_use[tt]=1'b0;
          prB_use[tt]=1'b0;
          prT_use[tt]=1'b0;
          prC_use[tt]=1'b0;
          pport[tt]=4'b0;
          pport2[tt]=PORT_ALU;
          pconstant[tt][31:0]=constantDef;
          pconstant[tt][63:32]={32{constant[31]}};
     //     pisBigConst[tt]=magic[2:0]==3'b111;
          pthisSpecLoad[tt]=1'b0;    
          pisIPRel[tt]=1'b0;
          puseCRet[tt]=1'b0;
          prA_useF[tt]=1'b0;
          prB_useF[tt]=1'b0;
          prT_useF[tt]=1'b0;
          prC_useF[tt]=1'b0;
          pchain[tt]=1'b0;
          perror[tt]=(|magic[3:2])&(&magic[1:0]); 
          pflags_use[tt]=1'b0;
          pflags_write[tt]=1'b0;
          pclr64[tt]=1'b0;
          pclr128[tt]=1'b0;
        //  pkeep2instr[tt]=1'b0;
          pjumpType[tt]=5'b10000;
          prAlloc[tt]=1'b0;
          pflags_wrFPU[tt]=1'b0;
          phalt[tt]=1'b0;
      //smallConst=4'h8;
      //useBSmall=1'b0;
          prA_isV[tt]=1'b0;
          prB_isV[tt]=1'b0;
          prT_isV[tt]=1'b0;
          prBT_copyV[tt]=1'b0;
          pinstr_fsimd[tt]=1'b1;
	  pmaskOp[tt]=1'b0;
	  trien[tt]=1'b0;
	  pcxEn[tt]=1'b0;
	  pisIPRelB[tt]=1'b0;
	  if (tt<8) begin
	      reor_error=reor_error||(reor_val_out[2:0]!=tt[2:0]&&reor_val_out[5:3]!=tt[2:0]&&
	      reor_val_out[8:6]!=tt[2:0]&&reor_val_out[11:9]!=tt[2:0]&&reor_val_out[14:12]!=tt[2:0]&&
	      reor_val_out[17:15]!=tt[2:0]&&reor_val_out[20:18]!=tt[2:0]&&reor_val_out[23:21]!=tt[2:0]);   
	  end
      end
      
      if (instr[11:7]==5'd8)       rD={1'b0,reor_val[4:0]};
      else if (instr[11:7]==5'd9)  rD={1'b0,reor_val[9:5]};
      else if (instr[11:7]==5'd10) rD={1'b0,reor_val[14:0]};
      else if (!instr[11])         rD={reor_val[15],instr[11:7]};
      else                         rD={1'b0,instr[11:7]};
      if (instr[19:15]==5'd8)       rS1={1'b0,reor_val[4:0]};
      else if (instr[19:15]==5'd9)  rS1={1'b0,reor_val[9:5]};
      else if (instr[19:15]==5'd10) rS1={1'b0,reor_val[14:0]};
      else if (!instr[19])          rS1={reor_val[15],instr[19:15]};
      else                          rS1={1'b0,instr[19:15]};
      if (instr[24:20]==5'd8)       rS2={1'b0,reor_val[4:0]};
      else if (instr[24:20]==5'd9)  rS2={1'b0,reor_val[9:5]};
      else if (instr[24:20]==5'd10) rS2={1'b0,reor_val[14:0]};
      else if (!instr[24])          rS2={reor_val[15],instr[24:20]};
      else                          rS2={1'b0,instr[24:20]};
      
      trien[0]=subIsBasicLDST;
      poperation[0]=instr[14] ? {10'h1,instr[14],instr[15]} : {8'b0,~instr[15],instr[15],2'b1,instr[15]};
      prA_use[0]=1'b0;
      prB_use[0]=1'b1;
      prT_use[0]=~instr[15] && instr[14];
      prC_use[0]=instr[15] && instr[14];
      prT_useF[0]=~instr[15] && ~instr[14];
      prC_useF[0]=instr[15] && ~instr[14];
      puseRs[0]=1'b1;
      prAlloc[0]=1'b1;
      puseBConst[0]=1'b0;
      pport[0]=instr[15] ? PORT_STORE : PORT_LOAD;
      prB[0]={3'b1,instr[4:2]};
      prC[0]={3'b1,instr[7:6]};
      prT[0]={3'b1,instr[7:6]};
      pconstant[0]=instr[14:13]==2'b10 ? {26'b0,instr[5],instr[12:10],instr[6],2'b0} :
	  {25'b0,instr[6:5],instr[12:10],3'b0};

      trien[1]=subIsStackLDST;
      poperation[1]=instr[14] ? {10'h1,instr[14],instr[15]} : {8'b0,~instr[15],instr[15],2'b1,instr[15]};
      prA_use[1]=1'b0;
      prB_use[1]=1'b1;
      prT_use[1]=~instr[15] && instr[14];
      prC_use[1]=instr[15] && instr[14];
      prT_useF[1]=~instr[15] && ~instr[14];
      prC_useF[1]=instr[15] && ~instr[14];
      puseRs[1]=1'b1;
      prAlloc[1]=1'b1;
      puseBConst[1]=1'b0;
      pport[1]=instr[15] ? PORT_STORE : PORT_LOAD;
      prB[1]=6'd2;
      prC[1]={1'b0,instr[6:2]};
      prT[1]={1'b0,instr[11:7]};
      if (!instr[15])
	  pconstant[1]=instr[14:13]==2'b10 ? {24'b0,instr[3:2],instr[12],instr[6:4],2'b0} :
	     {23'b0,instr[4:2],instr[12],instr[6:5],3'b0};
      else
	  pconstant[1]=instr[14:13]==2'b10 ? {24'b0,instr[8:7],instr[12:9],2'b0} :
	     {23'b0,instr[9:7],instr[12:10],3'b0};

      trien[2]=subIsBasicImmAluReg5;
      puseBConst[2]=1'b1;
      prA_use[2]=instr[15:13]!=2'b10 && !(instr[15:13]==2'b11 && instr[11:7]!=2);
      prB_use[2]=1'b1;
      prT_use[2]=1'b1;
      puseRs[2]=1'b1;
      prAlloc[2]=1'b1;
      pport[2]=instr[1:0]==2'b10 ? PORT_SHIFT : PORT_ALU;
      pflags_write[2]=!(instr[15:13]!=2'b10 && !(instr[15:13]==2'b11 && instr[11:7]!=2));
      poperation[2][12]=instr[15:13]!=2'b10 && !(instr[15:13]==2'b11 && instr[11:7]!=2);
      prA[2]=instr[11:7];
      prT[2]=instr[11:7];
      if (instr[15:13]!=3'b11) pconstant[2]=instr[1:0]!=2'b10 ? {{27{instr[12]}},instr[6:2]} :
	  {26'b0,instr[12],instr[6:2]};
      else pconstant[2]=instr[11:7]==5'd2 ? {{23{instr[12]}},instr[4:3],instr[5],instr[2],instr[6],4'b0} :
	  {{15{instr[12]}},instr[6:2],12'b0};
      case({instr[1:0]==2'b10,instr[15:13]})
	  case 4'b0: poperation[2][7:0]=`op_add64;
	  case 4'b1: poperation[2][7:0]=`op_add32S;
	  case 4'b10: poperation[2][7:0]=`op_mov64;
	  case 4'b11: poperation[2][7:0]=instr[11:7]==5'd2 ? op_add64 : op_mov64;
	  case 4'b1000: poperation[2][7:0]=`op_shl64;
      endcase

      trien[3]=subIs2xReg5Alu;
      prT_use[3]=instr[6:2]!=0;
      prA_use[3]=instr[12] || instr[11:7]==0; //EBREAK might wait unnecesaryly but so what
      prB_use[3]=!(!instr[12] && instr[11:7]==0) ;
      prAlloc[3]=instr[12] || instr[11:7]!=0; 
      puseRs[3]=1'b1;
      casex({instr[12],instr[11:7]!=0,instr[6:2]!=0})
	  3'b010: begin
	      jump_type[3]=5'h11;
	      is_jump[3]=1'b1;
	      rB[3]={1'b0,instr[11:7]};
	      pcxEn[3]=1'b1;
	      poperation[3]=`op_add64|4096;
	      pport[3]=PORT_MUL;
	  end
	  3'b110: begin
	      jump_type[3]=5'h11;
	      is_jump[3]=1'b1;
	      prB[3]={1'b0,instr[11:7]};
	      pcxEn[3]=1'b1;
	      pconstant[3]={32'b0,32'd2};
	      pIPRel[3]=1'b1;
	      prT[3]=6'd1;
	      poperation[3]=`op_add64|4096;
	      pport[3]=PORT_MUL;
	  end
	  3'b0x1: begin
	      prA[3]={1'b0,instr[11:7]};
	      prB[3]={1'b0,instr[6:2]};
	      prT[3]={1'b0,instr[11:7]};
	      poperation[3]=`op_mov64|4096;
	      pport[3]=PORT_ALU;
	  end
	  3'b1x1: begin
	      prA={1'b0,instr[11:7]};
	      prB={1'b0,instr[6:2]};
	      prT={1'b0,instr[11:7]};
	      poperation[7:0]=`op_add64;
	      pport=PORT_ALU;
	      pflags_write[3]=1'b1;
	  end
	  3'b100: begin
	      poperation[3]=`op_break|4096;
	      pport[3]=PORT_ALU;
	  end
      endcase
      //need to add rA output from mul port of ALU

      trien[4]=subIs3RegAlu;
      puseBConst[4]=~instr[11] | ~instr[10];
      prA_use[4]=1'b1;
      prB_use[4]=1'b1;
      prT_use[4]=1'b1;
      prA[4]={3'b1,instr[9:7]};
      prT[4]={3'b1,instr[9:7]};
      prB[4]={3'b1,instr[4:2]};
      puseRs[4]=1'b1;
      pflags_write[4]=1'b1;
      prAlloc[4]=1'b1;
      pconstant[4]=instr[11] ? {{27{instr[12]}},instr[6:2]} : {26'b0,instr[12],instr[6:2]};
      casex({instr[12:10],instr[6:5]})
	  5'bx00xx: begin poperation[4]=`op_shr64; pport[4]=PORT_SHIFT; end
	  5'bx01xx: begin poperation[4]=`op_sar64; pport[4]=PORT_SHIFT; end
	  5'bx10xx: begin poperation[4]=`op_and64; pport[4]=PORT_ALU; end
	  5'b01100: begin poperation[4]=`op_sub64; pport[4]=PORT_ALU; end
	  5'b01101: begin poperation[4]=`op_xor64; pport[4]=PORT_ALU; end
	  5'b01110: begin poperation[4]=`op_or64; pport[4]=PORT_ALU; end
	  5'b01111: begin poperation[4]=`op_and64; pport[4]=PORT_ALU; end
	  5'b11100: begin poperation[4]=`op_sub32S; pport[4]=PORT_ALU; end
	  5'b11101: begin poperation[4]=`op_add32S; pport[4]=PORT_ALU; end
      endcase

      trien[5]=subIsAddI4 | subIsJmp;
      if (instr[15:14]==2'b11) begin
	  poperation[5]=`op_and64;
	  prA[5]={3'b1,instr[9:7]};
	  prB[5]={3'b1,instr[9:7]};
	  prA_use[5]=1'b1;
	  prB_use[5]=1'b1;
	  puseRs[5]=1'b1;
	  pflags_write[5]=1'b1;
	  prAlloc[5]=1'b1;
	  pjump_type[5]={4'b0,instr[13]};
	  pis_jump=1'b1;
      end else if (instr[15:14]) begin
	  pis_jump[5]=1'b1;
	  pjump_type[5]=5'h10;
      end else begin
	  poperation[5]=`op_add64;
	  prA[5]=6'd2;
	  prT[5]={3'b1,instr[9:7]};
	  prA_use[5]=1'b1;
	  prB_use[5]=1'b1;
	  prT_use[5]=1'b1;
	  puseBConst[5]=1'b1;
	  puseRs[5]=1'b1;
	  pflags_write[5]=1'b1;
	  prAlloc[5]=1'b1;
	  pconstant[5]={54'b0,instr[10:7],instr[12:11],instr[5],instr[6],2'b0};
      end

      trien[6]=isAdvALUorJump;
      puseBConst[6]=!(instr[6:2]==5'b11001);
      pcxEn[6]=instr[6:2]==5'b11001;
      prT[6]={rD};
      prT_use[6]=!(instr[6:2]==5'b11011 && prT[6]==6'd0);
      puseRs[6]=prT_use[6];
      case(instr[6:2])
	  5'b01101,00101: begin
	  pconstant[6]={{32{instr[31]},instr[31:12],12'b0};
	  poperation[6]=op_add64;
	  pIPRel[6]=!instr[5];
	  pport[6]=PORT_ALU;
	  end
	  5'b11011: begin
	  pconstant[6]=64'd4;
	  poperation[6]=op_add64;
	  pIPRel[6]=1'b1;
	  puseBConst[6]=1'b1;
	  prB_use=1'b1;
	  pis_jump[6]=1'b1;
	  pjump_type[6]=5'b10000;
	  pport[6]=PORT_ALU;
	  end
	  5'b11001: begin
	  pconstant[6]={{12{instr[31]},instr[31:12],32'd4};
	  poperation[6]=op_add64;
	  pisIPRel[6]=1'b1;
	  pisIPRelB[6]=1'b1;
	  pis_jump[6]=1'b1;
	  pjump_type[6]=5'b11000;
	  pport[6]=PORT_MUL;
	  //puseBConst[6]=1'b1;
	  pcxEn[6]=1'b1;
	  prB[6]=rS1;
	  prB_use[6]=1'b1;
	  end
      endcase

      trien[7]=isJump;
      poperation[7]=`op_sub64;
      prA[7]=rS1;
      prB[7]=rS2;
      prA_use[7]=1'b1;
      prB_use[7]=1'b1;      
      prAlloc[7]=1'b1;
      pflags_write[7]=1'b1;
      puseRs[7]=1'b1;
      pis_jump[7]=1'b1;
      pport[7]=PORT_ALU;
     // pconstant[7]={instr[31],instr[7],instr[30:25],instr[11:8],1'b0}
      casex(instr[14:12])
          3'b00x: pjumptype[7]={4'b0,instr[12]};
	  3'b100: pjumptype[7]=5'd11;
	  3'b101: pjumptype[7]=5'd10;
	  3'b110: pjumptype[7]=5'd7;
	  3'b111: pjumptype[7]=5'd6;
	  default: perror[7]=1'b1;
      endcase

      trien[8]=isLoad&!instr[2];
      prT[8]=rD;
      prB[8]=rS1;
      prT_use[8]=1'b1;
      prB_use[8]=1'b1;
      pconstant[8]={{52{instr[31]}},instr[31:20]};
      prAlloc[8]=1'b1;
      puseRs[8]=1'b1;
      pport[8]=PORT_LOAD;
      casex(instr[14:12])
          3'b100,3'b101,3'b110,3'b011: poperation[8][7:0]={5'b100,instr[13:12],1'b0};
	  3'b000: begin
		  pchain[8]=1'b1;
		  poperation[8][7:0]={5'b100,instr[13:12],1'b0};
		  popchain[8]=`op_sxt8_64|4096;
	      end

	  3'b001: begin
		  pchain[8]=1'b1;
		  poperation[8][7:0]={5'b100,instr[13:12],1'b0};
		  popchain[8]=`op_sxt16_64|4096;
	      end
	  3'b010: begin
		  pchain[8]=1'b1;
		  poperation[8][7:0]={5'b100,instr[13:12],1'b0};
		  popchain[8]=`op_sxt32_64|4096;
	      end
	  3'b111: perror[8]=1'b1;
      endcase

      trien[9]=isStore&!instr[2];
      prC[9]=rS2;
      prB[9]=rS1;
      prC_use[9]=1'b1;
      prB_use[9]=1'b1;
      pconstant[9]={{52{instr[31]}},instr[31:25],rD};
      prAlloc[9]=1'b0;
      puseRs[9]=1'b1;
      pport[9]=PORT_STORE;
      poperation[9][7:0]={5'b100,instr[13:12],1'b1};
      perror[9]=instr[14];
      
     
      trien[10]=isBasicALU && instr[6:5]==2'b0 && instr[13:12]!=2'b01;//non shift immediate
      prT[10]=rD;
      prA[10]=rS1;
      prT_use[10]=1'b1;
      prA_use[10]=1'b1;
      prB_use[10]=1'b1;
      puseBConst[10]=1'b1;
      puseRs[10]=1'b1;
      pflags_write[10]=1'b1;
      pconstant[10]={{52{instr[31]}},instr[31:20]}
      pport[10]=PORT_ALU;
      prAlloc[10]=1'b1;
      case(instr[14:12])
	  3'b000: poperation[10]=`op_add64;
	  3'b010: begin poperation[10]=`op_sub64; pchain[10]=1'b1; prT_use[10]=1'b1; popchain[10]=`op_csetn|13'b10100000000|4096; end//uxuss
	  3'b011: begin poperation[10]=`op_sub64; pchain[10]=1'b1; prT_use[10]=1'b1; popchain[10]=`op_csetn|13'b01100000000|4096; end//suxuss
	  3'b100: poperation[10]=`op_xor64;
	  3'b110: poperation[10]=`op_or64;
	  3'b111: poperation[10]=`op_and64;
      endcase
       
      trien[11]=isBasicALU && instr[6:5]==2'b0 && instr[13:12]==2'b01 && !instr[31] && instr[29:26]==4'b0;//shift immediate
      prT[11]=rD;
      prA[11]=rS1;
      prT_use[11]=1'b1;
      prA_use[11]=1'b1;
      prB_use[11]=1'b1;
      puseBConst[11]=1'b1;
      puseRs[11]=1'b1;
      pflags_write[11]=1'b1;
      pconstant[11]={58'b0,instr[25:20]}
      pport[11]=PORT_SHIFT;
      prAlloc[11]=1'b1;
      casex({instr[14],instr[30])
	  2'b0x: begin 
	          poperation[11]=`op_shl64;
	          if (instr[30]) perror[11]=1'b1;
              end
	  2'b10: poperation[11]=`op_shr64;
	  2'b11: poperation[11]=`op_sar64;
      endcase
      
      trien[12]=isBasicALU32 && instr[6:5]==2'b0 && instr[13:12]!=2'b01 && instr[14:12]==3'b0;//non shift immediate
      prT[12]=rD;
      prA[12]=rS1;
      prT_use[12]=1'b1;
      prA_use[12]=1'b1;
      prB_use[12]=1'b1;
      puseBConst[12]=1'b1;
      puseRs[12]=1'b1;
      pflags_write[12]=1'b1;
      pconstant[12]={{52{instr[31]}},instr[31:20]}
      pport[12]=PORT_ALU;
      prAlloc[12]=1'b1;
      case(instr[14:12])
	  3'b000: poperation[12]=`op_add32S;
      endcase
       
      trien[13]=isBasicALU32 && instr[6:5]==2'b0 && instr[13:12]==2'b01 && !instr[31] && instr[29:25]==5'b0;//shift immediate
      prT[13]=rD;
      prA[13]=rS1;
      prT_use[13]=1'b1;
      prA_use[13]=1'b1;
      prB_use[13]=1'b1;
      puseBConst[13]=1'b1;
      puseRs[13]=1'b1;
      pflags_write[13]=1'b1;
      pconstant[13]={58'b0,instr[25:20]}
      pport[13]=PORT_SHIFT;
      prAlloc[13]=1'b1;
      casex({instr[14],instr[30])
	  2'b0x: begin 
	          poperation[13]=`op_shl32;
	          if (instr[30]) perror[13]=1'b1;
              end
	  2'b10: poperation[13]=`op_shr32;
	  2'b11: poperation[13]=`op_sar32;
      endcase
      
      trien[14]=isBasicALU && instr[6:5]!=2'b0 && instr[13:12]!=2'b01 && !instr[31] && instr[29:25]==5'b0;//non shift reg
      prT[14]=rD;
      prA[14]=rS1;
      prB[14]=rS2;
      prT_use[14]=1'b1;
      prA_use[14]=1'b1;
      prB_use[14]=1'b1;
      puseRs[14]=1'b1;
      pflags_write[14]=1'b1;
      pport[14]=PORT_ALU;
      prAlloc[14]=1'b1;
      case({instr[30],instr[14:12]})
	  4'b0000: poperation[14]=`op_add64;
	  4'b1000: poperation[14]=`op_sub64;
	  4'b010: begin poperation[14]=`op_sub64; pchain[10]=1'b1; prT_use[10]=1'b1; popchain[10]=`op_csetn|13'b10100000000|4096; end//uxuss
	  4'b011: begin poperation[14]=`op_sub64; pchain[10]=1'b1; prT_use[10]=1'b1; popchain[10]=`op_csetn|13'b01100000000|4096; end//suxuss
	  4'b100: poperation[14]=`op_xor64;
	  4'b110: poperation[14]=`op_or64;
	  4'b111: poperation[14]=`op_and64;
      endcase
       
      trien[15]=isBasicALU && instr[6:5]!=2'b0 && instr[13:12]==2'b01 && !instr[31] && instr[29:25]==5'b0;//shift reg
      prT[15]=rD;
      prA[15]=rS1;
      prB[15]=rS2;
      prT_use[15]=1'b1;
      prA_use[15]=1'b1;
      prB_use[15]=1'b1;
      puseRs[15]=1'b1;
      pflags_write[15]=1'b1;
      pport[15]=PORT_SHIFT;
      prAlloc[15]=1'b1;
      casex({instr[14],instr[30])
	  2'b0x: begin 
	          poperation[15]=`op_shl64;
	          if (instr[30]) perror[11]=1'b1;
              end
	  2'b10: poperation[15]=`op_shr64;
	  2'b11: poperation[15]=`op_sar64;
      endcase
      
      trien[16]=isBasicALU32 && instr[6:5]!=2'b0 && instr[14:12]==3'b0 && !instr[31] && instr[29:25]==5'b0;//non shift reg
      prT[16]=rD;
      prA[16]=rS1;
      prB[16]=rS2;
      prT_use[16]=1'b1;
      prA_use[16]=1'b1;
      prB_use[16]=1'b1;
      puseRs[16]=1'b1;
      pflags_write[16]=1'b1;
      pport[16]=PORT_ALU;
      prAlloc[16]=1'b1;
      case({instr[30],instr[14:12]})
	  4'b0000: poperation[16]=`op_add32S;
	  4'b1000: poperation[16]=`op_sub32S;
      endcase
       
      trien[17]=isBasicALU32 && instr[6:5]!=2'b0 && instr[13:12]==2'b01 && !instr[31] && instr[29:25]==5'b0;//shift reg
      prT[17]=rD;
      prA[17]=rS1;
      prB[17]=rS2;
      prT_use[17]=1'b1;
      prA_use[17]=1'b1;
      prB_use[17]=1'b1;
      puseRs[17]=1'b1;
      pflags_write[17]=1'b1;
      pport[17]=PORT_SHIFT;
      prAlloc[17]=1'b1;
      pchain[17]=1'b1;
      popchain[17]=`op_sxt32_64|4096;
      casex({instr[14],instr[30])
	  2'b0x: begin 
	          poperation[17]=`op_shl32;
	          if (instr[30]) perror[11]=1'b1;
              end
	  2'b10: poperation[17]=`op_shr32;
	  2'b11: poperation[17]=`op_sar32;
      endcase
      
      trien[18]=isExtImm && instr[14:12]!=3'b001;//non shift immediate
      prT[18]=rD;
      prA[18]=rS1;
      prT_use[18]=1'b1;
      prA_use[18]=1'b1;
      prB_use[18]=1'b1;
      puseBConst[18]=1'b1;
      puseRs[18]=1'b1;
      pflags_write[18]=1'b1;
      pconstant[18]={{52{instr[31]}},instr[31:20]}
      pport[18]=PORT_ALU;
      prAlloc[18]=1'b1;
      case(instr[14:12])
	  3'b000: poperation[18]=`op_add32;
	  3'b010: poperation[18]=`op_sub32; 
	  3'b011: begin poperation[18]=`op_mul64|2048; pport[18]=PORT_MUL;  end//suxuss
	  3'b100: poperation[18]=`op_xor32;
	  3'b110: poperation[18]=`op_or32;
	  3'b111: poperation[18]=`op_and32;
	  3'b101: poperation[18]=`op_sub64;
      endcase
       
      trien[19]=isExtImm && instr[14:12]==3'b001 && instr[31:27]==5'b0;//shift immediate
      prT[19]=rD;
      prA[19]=rS1;
      prT_use[19]=1'b1;
      prA_use[19]=1'b1;
      prB_use[19]=1'b1;
      puseBConst[19]=1'b1;
      puseRs[19]=1'b1;
      pflags_write[19]=1'b1;
      pconstant[19]={59'b0,instr[24:20]}
      pport[19]=PORT_SHIFT;
      prAlloc[19]=1'b1;
      case(instr[26:25])
	  2'b00: poperation[19]=`op_shl32;
	  2'b10: poperation[19]=`op_shr32; 
	  2'b11: begin perror[19]=1'b1;  end//suxuss
	  2'b01: poperation[19]=`op_sar32;
      endcase
       
      trien[20]=isExtALU && !instr[14];//mul immediate
      prT[20]=rD;
      prA[20]=rS1;
      prT_use[20]=1'b1;
      prA_use[20]=1'b1;
      prB_use[20]=1'b1;
      puseBConst[20]=1'b1;
      puseRs[20]=1'b1;
      pflags_write[20]=1'b1;
      pconstant[20]={{52{instr[31]}},instr[31:20]}
      pport[20]=PORT_ALU;
      prAlloc[20]=1'b1;
      case(instr[14:12])
	  3'b000: begin poperation[20]=`op_mul32|2048; pport[20]=PORT_MUL;  end//suxuss
	  3'b010: begin poperation[20]=`op_lmul64|2048; pport[20]=PORT_MUL;  end//suxuss
	  3'b001: begin poperation[20]=`op_lHSmul64|2048; pport[20]=PORT_MUL;  end//suxuss
	  3'b011: begin poperation[20]=`op_limul64|2048; pport[20]=PORT_MUL;  end//suxuss
      endcase
       
      trien[21]=isExtImm && (instr[31:27]==5'b1 || instr[31:27]==5'b10);//non shift reg
      prT[21]=rD;
      prA[21]=rS1;
      prB[21]=rS2;
      prT_use[21]=1'b1;
      prA_use[21]=1'b1;
      prB_use[21]=1'b1;
      puseRs[21]=1'b1;
      pflags_write[21]=1'b1;
      pport[21]=PORT_ALU;
      prAlloc[21]=1'b1;
      case(instr[27:25])
	  3'b000: poperation[21]=`op_add32;
	  3'b001: poperation[21]=`op_sub32;
	  3'b010: poperation[21]=`op_xor32;
	  3'b011: poperation[21]=`op_or32;
	  3'b100: poperation[21]=`op_and32;
	  default: perror[21]=1'b1;
      endcase
      
      trien[22]=isExtImm && instr[31:27]==5'b11;//shift reg
      prT[22]=rD;
      prA[22]=rS1;
      prB[22]=rS2;
      prT_use[22]=1'b1;
      prA_use[22]=1'b1;
      prB_use[22]=1'b1;
      puseRs[22]=1'b1;
      pflags_write[22]=1'b1;
      pport[22]=PORT_SHIFT;
      prAlloc[22]=1'b1;
      case(instr[26:25])
	  2'b000: poperation[22]=`op_shl32;
	  2'b001: poperation[22]=`op_shr32;
	  2'b010: poperation[22]=`op_sar32;
	  2'b011: perror[22]=1'b1;
      endcase
      
      trien[23]=isExtImm && instr[31:29]==3'b1;//non shift reg
      prT[23]=rD;
      prA[23]=rS1;
      prB[23]=rS2;
      prT_use[23]=1'b1;
      prA_use[23]=1'b1;
      prB_use[23]=1'b1;
      puseRs[23]=1'b1;
      pflags_write[23]=1'b0;
      pport[23]=PORT_ALU;
      prAlloc[23]=1'b1;
      case(instr[28])
	  1'b0: poperation[23]=`op_sadd|{2'b10,instr[27:25],8'b0};
	  1'b1: poperation[23]=`op_saddn|{2'b10,instr[27:25],8'b0};
      endcase

      trien[24]=isBasicALU|isBasicALU32 && instr[31:25]==7'b1 && !instr[14];
      prT[24]=rD;
      prA[24]=rS1;
      prB[24]=rS2;
      prT_use[24]=1'b1;
      prA_use[24]=1'b1;
      prB_use[24]=1'b1;
      puseRs[24]=1'b1;
      pflags_write[24]=1'b0;
      pport[24]=PORT_MUL;
      prAlloc[24]=1'b1;
      case({isBasicALU,instr[14:12]})
	  4'b1000: poperation[24]=`op_mul64;
	  4'b1001: poperation[24]=`op_limul64;
	  4'b1010: poperation[24]=`op_lHSmul64;
	  4'b1011: poperation[24]=`op_lmul64;
	  4'b0000: poperation[24]=`op_mul32;
          default: perror[24]=1'b1;
      endcase
      
      trien[25]=isLoad&instr[2];
      prT[25]=rD;
      prB[25]=rS1;
      prT_use[25]=1'b1;
      prB_use[25]=1'b1;
      pconstant[25]={{52{instr[31]}},instr[31:20]};
      prAlloc[25]=1'b1;
      puseRs[25]=1'b1;
      pport[25]=PORT_LOAD;
      casex(instr[14:12])
          3'b010: poperation[8][7:0]={7'd5,1'b0};
          3'b011: poperation[8][7:0]={7'd9,1'b0};
	  default: perror[25]=1'b1;
      endcase

      trien[26]=isStore&instr[2];
      prC[26]=rS2;
      prB[26]=rS1;
      prC_use[26]=1'b1;
      prB_use[26]=1'b1;
      pconstant[26]={{52{instr[31]}},instr[31:25],rD};
      prAlloc[26]=1'b0;
      puseRs[26]=1'b1;
      pport[26]=PORT_STORE;
      casex(instr[14:12])
          3'b010: poperation[8][7:0]={7'd8,1'b1};
          3'b011: poperation[8][7:0]={7'd5,1'b1};
	  default: perror[26]=1'b1;
      endcase
      //perror[9]=instr[14];
      
      trien[27]=isFpFma;//non shift reg
      prT[27]=rD;
      prA[27]=rS1;
      prB[27]=rS2;
      prC[27]=instr[31:27];
      prT_useF[27]=instr[25];
      prA_useF[27]=instr[25];
      prB_useF[27]=instr[25];
      prC_useF[27]=instr[25];
      prT_useV[27]=~instr[25];
      prA_useV[27]=~instr[25];
      prB_useV[27]=~instr[25];
      prC_useV[27]=~instr[25];
      prmode[27]=instr[14:12];
      pchain[27]=1'b1;
      pport2[27]=PORT_FADD;
      pport[27]=PORT_FMUL;
      puseRs[27]=1'b1;
      pflags_write[27]=1'b0;
      prAlloc[27]=1'b1;
      case({instr[3:2],instr[26:25]})
          4'b0000: begin poperation[27]=`fop_mulXS; popchain[27]=`fop_addXS; end
          4'b1000: begin poperation[27]=`fop_nmulXS; popchain[27]=`fop_addXS; end
          4'b0100: begin poperation[27]=`fop_mulXS; popchain[27]=`fop_subXS; end
          4'b1100: begin poperation[27]=`fop_nmulXS; popchain[27]=`fop_subXS; end
          4'b0001: begin poperation[27]=`fop_mulXD; popchain[27]=`fop_addXD; end
          4'b1001: begin poperation[27]=`fop_nmulXD; popchain[27]=`fop_addXD; end
          4'b0101: begin poperation[27]=`fop_mulXD; popchain[27]=`fop_subXD; end
          4'b1101: begin poperation[27]=`fop_nmulXD; popchain[27]=`fop_subXD; end
	  default: perror[27]=1'b1;
      endcase
      
  end


endmodule

