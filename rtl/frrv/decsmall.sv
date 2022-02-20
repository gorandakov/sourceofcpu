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
  can_jump_csr,
  rA,rA_use,
  rB,rB_use,useBConst,//useBSmall,
  rC,rC_use,useCRet,
  constant,
//  smallConst,
  rT,rT_use,
  port,
  useRs,
  rA_useF,rB_useF,rT_useF,rC_useF,maskOp,
  rA_isV,rB_isV,rT_isV,
  rBT_copyV,
  js_atom,
  clr64,clr128,
  chain,
  flags_use,
  flags_write,
  instr_fsimd,//choose simd-like over extended instr
  halt,
  
  pushCallStack,
  popCallStack,
  isJump,
  jumpTaken,
  jumpType,
  jumpBtbHit,
  jumpIndir,
  prevSpecLoad,
  thisSpecLoad,
  isIPRel,
  rAlloc,
  reor_en,
  reor_val,
  reor_en_out,
  reor_val_out,
  error
  );
  
  localparam INSTR_WIDTH=80;
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
  input mode64;
  
  input [INSTRQ_WIDTH-1:0] instrQ;

  input [INSTR_WIDTH-1:0] instr;
  
  output [OPERATION_WIDTH-1:0] operation;
  input can_jump_csr;
  output [REG_WIDTH-1:0] rA;
  output rA_use;
  output [REG_WIDTH-1:0] rB;
  output rB_use;
  output [REG_WIDTH-1:0] rC;
  output rC_use;
  output useCRet;
  output useBConst;
//  output reg useBSmall;//small constant use; used for call/pop/push
  output [63:0] constant;
//  output reg [3:0] smallConst; //signed
  output [REG_WIDTH-1:0] rT;
  output rT_use;
  output [3:0] port;
  output useRs;
  output rA_useF,rB_useF,rT_useF,rC_useF,maskOp;
  output rA_isV,rB_isV,rT_isV,rBT_copyV;
  output [15:0] js_atom;
  output clr64,clr128,chain;
  output flags_use;
  output flags_write;
  output instr_fsimd;
  output halt;
  
  output pushCallStack;
  output popCallStack;
  output isJump;
  output jumpTaken;
  output [4:0] jumpType;
  output jumpBtbHit;
  output jumpIndir;
  
  input prevSpecLoad;
  output thisSpecLoad;
  output isIPRel;
  output rAlloc;
  input reor_en;
  input [39:0] reor_val;
  output reor_en_out;
  output [39:0] reor_val_out;
  output wire error;
  //7:0 free 15:8 unfree 39:16 fxch/pop/push 
  wire [3:0] magic;
  wire [11:0] srcIPOff;
//  wire isAvx;
  wire [7:0] opcode_main;

  reg [31:0] fpu_reor;

  reg [3:0] rA_reor;
  reg [3:0] rB_reor;
  reg [4:0] rA_reor32;
  reg [4:0] rB_reor32;
  reg [4:0] rT_reor32;
  reg reor_error;

  wire isBasicALU;
  wire isBasicALUExcept;
  wire isBasicShift;
  wire isBasicShiftExcept;
  wire isBasicCmpTest;
  wire isCmpTestExtra;   
  
  wire isBaseLoadStore;
  wire isBaseIndexLoadStore;
  wire isBaseSpecLoad;
  wire isBaseIndexSpecLoad;
  wire isImmLoadStore;

  wire isBasicCJump;
 // wire isInvCJumpLong;
  wire isSelfTestCJump;
  wire isLongCondJump;
  wire isUncondJump;
  
  wire isIndirJump;
  wire isCall;
  wire isCallPrep;
  wire isRet;
  
  wire isMovOrExtA,isMovOrExtB;
  wire isMovOrExtExcept;
  wire isLeaIPRel;
  wire isCmov;
  wire isCSet;
  wire isBasicAddNoFl;
  wire isAddNoFlExtra;
  wire isShiftNoFl;
  
  wire isBasicMUL;
  wire isSimdInt;
  wire isFPUreor;
  wire isBasicFPUScalarA;
  wire isBasicFPUScalarB;
  wire isBasicFPUScalarC;
  wire isBasicFPUScalarCmp;
  wire isBasicFPUScalarCmp2;
  
  wire isBasicSysInstr;

  wire subIsBasicALU;
  wire subIsMovOrExt;
  wire subIsBasicShift;
  wire subIsCmpTest;
  wire subIsCJ;
  wire subIsFPUD;
  wire subIsFPUPD;
  wire subIsFPUE;
  wire subIsFPUSngl;
  wire subIsSIMD;
  wire subIsLinkRet;
  
  
  reg keep2instr;
  
  wire [31:0] constantDef;

  wire [12:0] class_;

  wire [5:0] opcode_sub;

  reg isBigConst;
  
  wire flags_wrFPU;

  reg [OPERATION_WIDTH-1:0] poperation[TRICNT_TOP-1:0];
  reg [REG_WIDTH-2:0] prA[TRICNT_TOP-1:0];
  reg prA_use[TRICNT_TOP-1:0];
  reg [REG_WIDTH-2:0] prB[TRICNT_TOP-1:0];
  reg prB_use[TRICNT_TOP-1:0];
  reg [REG_WIDTH-2:0] prC[TRICNT_TOP-1:0];
  reg prC_use[TRICNT_TOP-1:0];
  reg puseCRet[TRICNT_TOP-1:0];
  reg puseBConst[TRICNT_TOP-1:0];
//  output reg useBSmall;//small constant use; used for call/pop/push
  reg [63:0] pconstant[TRICNT_TOP-1:0];
//  output reg [3:0] smallConst; //signed
  reg [REG_WIDTH-1:0] prT[TRICNT_TOP-1:0];
  reg prT_use[TRICNT_TOP-1:0];
  reg [3:0] pport[TRICNT_TOP-1:0];
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
  reg pclr64[TRICNT_TOP-1:0];
  reg pclr128[TRICNT_TOP-1:0];
  reg pchain[TRICNT_TOP-1:0];
  reg pflags_use[TRICNT_TOP-1:0];
  reg pflags_write[TRICNT_TOP-1:0];
  reg pflags_wrFPU[TRICNT_TOP-1:0];
  reg pinstr_fsimd[TRICNT_TOP-1:0];
  reg phalt[TRICNT_TOP-1:0];
  
  wire [63:0] qconstant[11:0];
  wire [11:0] qtrien;
  
  reg [4:0] pjumpType[TRICNT_TOP-1:0];
  
  reg pthisSpecLoad[TRICNT_TOP-1:0];
  reg pisIPRel[TRICNT_TOP-1:0];
  reg prAlloc[TRICNT_TOP-1:0];
  reg [TRICNT_TOP-1:0] trien;
  reg perror[TRICNT_TOP-1:0];

  integer tt;

  function [0:0] fop_v;
    input [4:0] op;
    fop_v=op==5'b0 || op==5'h18 || op==5'he ||
      op==5'b1 || op==5'd19 || op==5'd21;
  endfunction 

  function [0:0] freg_vf;
    input [4:0] op;
    input [0:0] is_fp;
    freg_vf=is_fp && op!=5'd6 && op!=5'd8 && op!=5'd16 &&
	    op!=5'd7 && op!=5'd9 && op!=5'd13;
  endfunction 
  assign magic=instrQ[`instrQ_magic];
  assign jumpBtbHit=~instrQ[`instrQ_btbMiss];
  assign jumpIndir=class_[`iclass_indir];
  assign isJump=class_[`iclass_jump] || class_[`iclass_indir];
  assign srcIPOff=instrQ[`instrQ_srcIPOff];
 // assign isAvx=instrQ[`instrQ_avx];

  assign class_=instrQ[`instrQ_class];
          
  assign opcode_main=instr[7:0];
  assign opcode_sub=instr[5:0];
  
  assign constantDef=(magic[1:0]==2'b11) ? instr[47:16] : 32'bz;
  assign constantDef=(magic[1:0]==2'b01) ? {{18{instr[31]}},instr[31:18]} : 32'bz;
  assign constantDef=(~magic[0]) ? {26'b0,~instr[7] && instr[15:12]==4'b0,instr[7],instr[15:12]} : 32'bz;
 
  assign reor_en_out=isFPUreor&&~reor_error;
  assign reor_val_out=instr[47:8];
 

  assign subIsBasicLDST=instr[14:13]!=2'b0 && instr[1:0]==2'b0;
  assign subIsStackLDST=instr[14:13]!=2'b0 && instr[1:0]==2'b10 && !(intr[15:14]=2'b01 && instr[11:7]==5'b0);
  
  assign subIsBasicImmAluReg5=(instr[1:0]==2'b01 && (instr[15:13]==3'b0 || (instr[15:13]==3'b1 &&
   instr[11:7]!=5'b0) || (instr[15:14]==2'b1 && instr[11:7]!=5'b0 && 
   instr[12]| |instr[6:2] |~instr[13])))||(instr[1:0]==2'b10 && instr[15:13]==3'b0 && instr[11:7]!=5'b0);  
  assign subIs2xReg5Alu=instr[1:0]==2'b10 && instr[15:13]==3'b100;
  assign subIsReg3Alu=instr[1:0]==2'b1 && instr[15:13]==3'b100 && !(instr[12:10]==3'b111 && instr[6]);
  assign subIsJMP=instr[1:0]==2'b1 && (instr[15:13]==3'b101 || instr[15:14]==2'b11);

  assign isLoad=opcode_main[6:3]==4'b0 && opcode_main[1:0]==2'b11;
  assign isStore=opcode_main[6:3]==4'b0100 && opcode_main[1:0]==2'b11;
  assign isLoadEx=opcode_main[6:2]==5'b10 && opcode_main[1:0]==2'b11;
  assign isStoreEx=opcode_main[6:2]==5'b01010 && opcode_main[1:0]==2'b11;
  assign isBasicALU=!opcode_main[6] && opcode_main[4:2]==3'b100 && opcode_main[1:0]==2'b11;
  assign isBasicALU32=!opcode_main[6] && opcode_main[4:2]==3'b110 && opcode_main[1:0]==2'b11;
  assign isAdvALUorJump=(instr[6:5]==2'b11 && instr[4] && instr[2]) |
	  (instr[6] && instr[4:2]==3'b101) && opcode_main[1:0]==2'b11;
  assign isOpFp=instr[6:2]==5'b10100 && opcode_main[1:0]==2'b11;
  assign isFpFma=opcode_main[6:4]==2'b100 && opcode_main[1:0]==2'b11;

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
          wire [REG_WIDTH-2:0] krA;
          wire krA_use;
          wire [REG_WIDTH-2:0] krB;
          wire krB_use;
          wire [REG_WIDTH-2:0] krC;
          wire krC_use;
          wire kuseCRet;
          wire kuseBConst;
    //  output reg useBSmall;//small constant use; used for call/pop/push
          wire [63:0] kconstant;
    //  output reg [3:0] smallConst; //signed
          wire [REG_WIDTH-2:0] krT;
          wire krT_use;
          wire [3:0] kport;
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
	      assign kthisSpecLoad=trien[p*8+q] ? pthisSpecLoad[p*8+q] : 1'bz;
	      assign kisIPRel=trien[p*8+q] ? pisIPRel[p*8+q] : 1'bz;
	      assign kflags_use=trien[p*8+q] ? pflags_use[p*8+q] : 1'bz;
	      assign kflags_write=trien[p*8+q] ? pflags_write[p*8+q] : 1'bz;
	      assign kflags_wrFPU=trien[p*8+q] ? pflags_wrFPU[p*8+q] : 1'bz;
	      assign krBT_copyV=trien[p*8+q] ? prBT_copyV[p*8+q] : 1'bz;
	      assign kinstr_fsimd=trien[p*8+q] ? pinstr_fsimd[p*8+q] : 1'bz;
	      assign kerror=trien[p*8+q] ? perror[p*8+q] : 1'bz;
	      assign kport=trien[p*8+q] ? pport[p*8+q] : 4'bz;
	      assign kjumpType=trien[p*8+q] ? pjumpType[p*8+q] : 5'bz;
	      assign koperation=trien[p*8+q] ? poperation[p*8+q] : 13'bz;
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
	  assign kthisSpecLoad=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kisIPRel=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kflags_use=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kflags_write=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kflags_wrFPU=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krBT_copyV=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kinstr_fsimd=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kerror=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kport=(~|trien[p*8+:8]) ? 4'b0 : 4'bz;
	  assign kjumpType=(~|trien[p*8+:8]) ? 5'b10000 : 5'bz;
	  assign koperation=(~|trien[p*8+:8]) ? 13'b0 : 13'bz;
	      
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
//	  assign thisSpecLoad=(|trien[p*8+:8]) ? kthisSpecLoad : 1'bz;
	  assign isIPRel=(|trien[p*8+:8]) ? kisIPRel : 1'bz;
	  assign flags_use=(|trien[p*8+:8]) ? kflags_use : 1'bz;
	  assign flags_write=(|trien[p*8+:8]) ? kflags_write : 1'bz;
	  assign flags_wrFPU=(|trien[p*8+:8]) ? kflags_wrFPU : 1'bz;
	  assign rBT_copyV=(|trien[p*8+:8]) ? krBT_copyV : 1'bz;
	  assign instr_fsimd=(|trien[p*8+:8]) ? kinstr_fsimd : 1'bz;
	  assign error=(|trien[p*8+:8]) ? kerror : 1'bz;
	  assign port=(|trien[p*8+:8]) ? kport : 4'bz;
	  assign jumpType=(|trien[p*8+:8]) ? kjumpType : 5'bz;
	  assign operation=(|trien[p*8+:8]) ? koperation : 13'bz;
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
//  assign thisSpecLoad=(~|trien) ? 1'b0 : 1'bz;
  assign isIPRel=(~|trien) ? 1'b0 : 1'bz;
  assign flags_use=(~|trien) ? 1'b0 : 1'bz;
  assign flags_write=(~|trien) ? 1'b0 : 1'bz;
  assign flags_wrFPU=(~|trien) ? 1'b0 : 1'bz;
  assign rBT_copyV=(~|trien) ? 1'b0 : 1'bz;
  assign instr_fsimd=(~|trien) ? 1'b0 : 1'bz;
  assign error=(~|trien) ? 1'b1 : 1'bz;
  assign port=(~|trien) ? PORT_LOAD : 4'bz;
  assign jumpType=(~|trien) ? 5'b10000 : 5'bz;
  assign operation=(~|trien) ? 13'hff : 13'bz;
  
  assign thisSpecLoad=isBaseSpecLoad | isBaseIndexSpecLoad | (~opcode_main[0] &&
    opcode_main[7:1]==7'b1011000 && ~instr[10] && instr[15:12]==REG_SP && 
    (magic[1:0]!=2'b01 || ~instr[16]));
 
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
	  if (tt<8) begin
	      reor_error=reor_error||(reor_val_out[2:0]!=tt[2:0]&&reor_val_out[5:3]!=tt[2:0]&&
	      reor_val_out[8:6]!=tt[2:0]&&reor_val_out[11:9]!=tt[2:0]&&reor_val_out[14:12]!=tt[2:0]&&
	      reor_val_out[17:15]!=tt[2:0]&&reor_val_out[20:18]!=tt[2:0]&&reor_val_out[23:21]!=tt[2:0]);   
	  end
      end
      rA_reor=instr[11] ? instr[11:8] : {1'b0,fpu_reor[3*instr[10:8]+:3]};
      rB_reor=instr[15] ? instr[15:12] : {1'b0,fpu_reor[3*instr[14:12]+:3]};
      rA_reor32=instr[21:20]!=2'b0 ? instr[21:17] : {2'b0,fpu_reor[3*instr[19:17]+:3]};
      rB_reor32=instr[26:25]!=2'b0 ? instr[26:22] : {2'b0,fpu_reor[3*instr[24:22]+:3]};
      rT_reor32=instr[31:30]!=2'b0 ? instr[31:27] : {2'b0,fpu_reor[3*instr[29:27]+:3]};
      
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
	      pjump_type[3]=5'h11;
	      pis_jump[3]=1'b1;
	      prA[3]={1'b0,instr[11:7]};
	      poperation[3]=`op_mov64|4096;
	      pport[3]=PORT_MUL;
	      //JAR
	  end
	  3'b110: begin
	      pjump_type[3]=5'h11;
	      pis_jump[3]=1'b1;
	      prA[3]={1'b0,instr[11:7]};
	      puseBConst[3]=1'b1;
	      pconstant[3]=0;
	      pIPRel[3]=1'b1;
	      prT[3]=6'd1;
	      poperation[3]=`op_mov64|4096;
	      pport[3]=PORT_MUL;
	      //JALR zero offset
	  end
	  3'b0x1: begin
	      prA[3]={1'b0,instr[11:7]};
	      prB[3]={1'b0,instr[6:2]};
	      prT[3]={1'b0,instr[11:7]};
	      poperation[3]=`op_mov64|4096;
	      pport[3]=PORT_ALU;
	      //mov
	  end
	  3'b1x1: begin
	      prA={1'b0,instr[11:7]};
	      prB={1'b0,instr[6:2]};
	      prT={1'b0,instr[11:7]};
	      poperation[7:0]=`op_add64;
	      pport=PORT_ALU;
	      pflags_write[3]=1'b1;
	      //addq
	  end
	  3'b100: begin
	      poperation[3]=`op_break|4096;
	      pport[3]=PORT_ALU;
	  end
      endcase
      //need to add rA output from mul port of ALU

      ptrien[4]=subIs3RegAlu;
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
	  5'b01100: begin poperation[4]=`op_sub64; pport[4]=PORT_ALU; end//no imm
	  5'b01101: begin poperation[4]=`op_xor64; pport[4]=PORT_ALU; end//no imm
	  5'b01110: begin poperation[4]=`op_or64; pport[4]=PORT_ALU; end//no imm
	  5'b01111: begin poperation[4]=`op_and64; pport[4]=PORT_ALU; end//no imm
	  5'b11100: begin poperation[4]=`op_sub32S; pport[4]=PORT_ALU; end//no imm
	  5'b11101: begin poperation[4]=`op_add32S; pport[4]=PORT_ALU; end//no imm
      endcase
      
      ptrien[5]=subIsJmp;
      puseRs[5]=instr[15:14]==2'b11;
      pport[5]=PORT_ALU;
      casex(instr[15:13])
	  3'b101: begin
	  //pconstant[5]={instr[12],instr[8],instr[10:9],instr[6],instr[7],instr[2],instr[11],instr[5:3 ],1'b0};
	  //c.j
	  pis_jump[5]=1'b1;
	  pjump_type[5]=5'h10;
	  end
	  5'b11x: begin //c.b
	  //pconstant[5]={instr[12],instr[6:5],instr[2],instr[11:10],instr[4:3],1'b0};
	  prA_use[5]=1'b1;
	  prA[5]={2'b01,instr[9:7]};
	  poperation[5]=`op_sub64;
	  pis_jump[5]=1'b1;
	  pjump_type[5]={4'b0,instr[13]};
	  poperation[5]=`op_add64|4096;
	  pport[5]=PORT_ALU;
	  end
      endcase

      ptrien[6]=isAdvALUorJump;
      puseBConst[6]=!(instr[6:2]==5'b11001);
      puseBCxCross[6]=instr[6:2]==5'b11001;
      prT[6]=instr[11:7];
      prT_use[6]=!(instr[6:2]==5'b11011 && prT[6]==6'd0);
      puseRs[6]=prT_use[6];
      case(instr[6:2])
	  5'b01101,00101: begin//AUIPC/LUI
	  pconstant[6]={{32{instr[31]},instr[31:12],12'b0};
	  poperation[6]=op_add64;
	  pIPRel[6]=!instr[5];
	  pport[6]=PORT_ALU;
	  end
	  5'b11001: begin
	  pconstant[6]={{52{instr[31]}},instr[31:20]};//JALR
	  prB[6]=instr[19:15]; //cxcross register for link
	  prB_use[6]=1'b1;
	  pIPRel[6]=1'b1; //IP goes in A input
	  pis_jump[6]=1'b1;
	  pjump_type[6]=5'h11;
	  poperation[6]=`op_add64|4096;
	  pport[6]=PORT_MUL;
	  end
	  5'b11011: begin
	  pconstant[6]={{43{instr[31]}},instr[31],instr[20:12],instr[21],instr[30:22],1'b0};
	  prB_use[6]=1'b1;//no CxCross
	  pIPRel[6]=1'b1; //IP goes in A input
	  pis_jump[6]=1'b1;//JAL
	  pjump_type[6]=5'h11;
	  poperation[6]=`op_add64|4096;
	  pport[6]=PORT_ALU;
	  end
      endcase

      ptrien[7]=isLoad & ~instr[2] || isStore & ~instr[2];
      poperation[7]={8'b0,instr[14:12],instr[5]};
      pport[7]=isLoad ? PORT_LOAD : PORT_STORE;
      puseRs[7]=1'b1;
      prT_use[7]=isLoad;
      prC_use[7]=isStore;
      prT[7]=instr[11:7];
      prC[7]=instr[24:20];
      prB[7]=instr[19:15];
      prAlloc[7]=isLoad;
      pconstant[7]=isLoad ? {{42{instr[31}},instr[31:20} : {{42{instr[31]}},instr[31:25],instr[11:7]};
      
      ptrien[8]=isLoadEx & ~instr[15] || isStoreEx & ~instr[15];
      poperation[8]={8'b10,instr[14:12],instr[5]};
      pport[8]=isLoadEx ? PORT_LOAD : PORT_STORE;
      puseRs[8]=1'b1;
      prT_use[8]=isLoad;
      prC_use[8]=isStore;
      prA_use[8]=1'b1;
      prT[8]={2'b01,instr[9:7]};
      prC[8]={2'b01,instr[19:17];
      prB[8]={2'b01,instr[16],instr[11:10]};
      prA[8]=isLoadEx ? prC[8] : prT[8];
      prAlloc[7]=isLoadEx;
      pconstant[7]={{42{instr[31}},instr[31:20};
  end


endmodule

