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
`include "../operations.sv"
`include "../memop.sv"
`include "../fpoperations.sv"
`include "../intop.v"

//instruct compiler not to delete constantN
module smallInstr_decoder(
  clk,
  rst,
  mode64,
  riscmove,
  instrQ,
  instr,
  operation,
  can_jump_csr,
  can_read_csr,
  can_write_csr,
  rA,rA_use,
  rB,rB_use,useBConst,//useBSmall,
  rC,rC_use,useCRet,
  alucond,
  rndmode,
  constant,
  constantN,
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
  csrss_retIP_en,
  error,
  reor_en_out,
  reor_val_out,
  reor_en,
  reor_val
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
  parameter [5:0] INDEX=0;

  input clk;
  input rst;
  input mode64;
  input riscmove;
  
  input [INSTRQ_WIDTH-1:0] instrQ;

  input [INSTR_WIDTH-1:0] instr;
  
  output [OPERATION_WIDTH-1:0] operation;
  input can_jump_csr;
  input can_read_csr;
  input can_write_csr;
  output [REG_WIDTH-1:0] rA;
  output rA_use;
  output [REG_WIDTH-1:0] rB;
  output rB_use;
  output [REG_WIDTH-1:0] rC;
  output rC_use;
  output useCRet;
  output [4:0] alucond;
  output [2:0] rndmode;
  output useBConst;
//  output reg useBSmall;//small constant use; used for call/pop/push
  output [64:0] constant;
  output [64:0] constantN;
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
  output reg csrss_retIP_en;
  output [1:0] error;
  output reor_en_out;
  output [23:0] reor_val_out;
  input reor_en;
  input [23:0] reor_val;
  //7:0 free 15:8 unfree 39:16 fxch/pop/push 
  wire [3:0] magic;
  wire [7:0] srcIPOff;
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
 
  wire subIsBasicXOR;
  wire isBasicXOR;

  wire isMovOrExtA,isMovOrExtB;
  wire isMovOrExtExcept;
  wire isLeaIPRel;
  wire isCmov;
  wire isCSet;
  wire isBasicAddNoFl;
  wire isAddNoFlExtra;
  wire isShiftNoFl;
  wire isCexALU;

  wire isBasicMUL;
  wire isSimdInt;
  wire isFPUreor;
  wire isShlAddMulLike;
  wire isPtrSec;
  wire isJalR;
  wire isBasicFPUScalarA;
  wire isBasicFPUScalarB;
  wire isBasicFPUScalarC;
  wire isBasicFPUScalarCmp;
  wire isBasicFPUScalarCmp2;
  wire isBasicFPUScalarCmp3;
  
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
  
  wire [63:0] constantDef;

  wire [12:0] class_;

  wire [5:0] opcode_sub;

  reg isBigConst;
  
  wire flags_wrFPU;

  reg [OPERATION_WIDTH-1:0] poperation[TRICNT_TOP-1:0];
  reg [REG_WIDTH-2:0] prA[TRICNT_TOP-1:0];
  reg prA_use[TRICNT_TOP-1:0];
  reg [REG_WIDTH-2:0] prB[TRICNT_TOP-1:0];
  reg prBE[TRICNT_TOP-1:0];
  reg prAX[TRICNT_TOP-1:0];
  reg prTE[TRICNT_TOP-1:0];
  reg prB_use[TRICNT_TOP-1:0];
  reg [REG_WIDTH-2:0] prC[TRICNT_TOP-1:0];
  reg prC_use[TRICNT_TOP-1:0];
  reg puseCRet[TRICNT_TOP-1:0];
  reg [4:0] palucond[TRICNT_TOP-1:0];
  reg [2:0] rndmode[TRICNT_TOP-1:0];
  reg puseBConst[TRICNT_TOP-1:0];
//  output reg useBSmall;//small constant use; used for call/pop/push
  reg [63:0] pconstant[TRICNT_TOP-1:0];
//  output reg [3:0] smallConst; //signed
  reg [REG_WIDTH-2:0] prT[TRICNT_TOP-1:0];
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
  
  wire [64:0] qconstant[15:0];
  wire [15:0] qtrien;
  
  reg [4:0] pjumpType[TRICNT_TOP-1:0];
  
  reg pthisSpecLoad[TRICNT_TOP-1:0];
  reg pisIPRel[TRICNT_TOP-1:0];
  reg prAlloc[TRICNT_TOP-1:0];
  reg [TRICNT_TOP-1:0] trien;
  reg [1:0] perror[TRICNT_TOP-1:0];

  wire [5:0] dat;

  LFSR16_6(clk,rst,dat);

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
  
  assign constantDef=(magic==4'b1111) ? instr[79:16] : 64'bz;
  assign constantDef=(magic[1:0]==2'b11) ? {{32{instr[47]}},instr[47:16]} : 64'bz;
	assign constantDef=(magic[1:0]==2'b01) ? {{32{instr[31]}},{17{instr[31]}},instr[31],instr[31:18]} : 64'bz;
  assign constantDef=(~magic[0]) ? {32'b0,25'b0,~instr[7] && {instr[6],instr[11:8]}==5'b0,instr[7:6],instr[11:8]} : 64'bz;

  assign constantN=~constant;
 
  assign reor_en_out=isFPUreor&&~reor_error;
  assign reor_val_out=instr[31:8];
  assign thisSpecLoad=isBaseSpecLoad || isBaseIndexSpecLoad || ({instr[11],instr[15:12]}==5'd16 && 
      opcode_main[7:0]==8'b10110000 && !instr[10]) || ({instr[1],instr[15:12]}==5'd15 &&                      
      opcode_main[7:2]==6'd15 && !instr[0]);
  assign subIsBasicALU=opcode_sub[5:4]==2'b0 || opcode_sub[5:2]==4'b0100;
  assign subIsBasicXOR=opcode_sub[5:2]==4'b0100;//not a separate class
  assign subIsBasicShift=~opcode_sub[5] && ~subIsBasicALU && opcode_sub[0];
  assign subIsFPUE=opcode_sub==6'b010100 && ~magic[0]; 
  assign subIsFPUSngl=(opcode_sub==6'b010110 || opcode_sub==6'b011000) && opcode_main[7:6]!=2'b11;
  assign subIsLinkRet=(opcode_sub==6'b010110 || opcode_sub==6'b011000) && opcode_main[7:6]==2'b11;
  assign subIsSIMD=opcode_sub[5:3]==3'b011 && opcode_sub[2:1]!=2'b0 && ~opcode_sub[0];
  assign subIsMovOrExt=opcode_sub[5:3]==3'b100 || opcode_sub[5:1]==5'b10100;
  assign subIsCmpTest=opcode_sub[5:1]==5'b10101 || opcode_sub[5:2]==4'b1011;
  assign subIsCJ=opcode_sub[5:2]==4'b1100 && opcode_main[7:0]!=8'b11110010;
  assign subIsFPUD=(opcode_sub[5:2]==4'b1101 || opcode_sub[5:1]==5'b11100);
  assign subIsFPUPD=(opcode_sub[5:3]==3'b111 && opcode_sub[5:1]!=5'b11100);

  assign isBasicALU=(opcode_main[7:5]==3'b0 || opcode_main[7:3]==5'b00100) & ~opcode_main[2];
  assign isBasicXOR=(opcode_main[7:3]==5'b00100) & ~opcode_main[2];//not a seprarate class
  assign isBasicMUL=(opcode_main[7:5]==3'b0 || opcode_main[7:3]==5'b00100) & opcode_main[2];
  assign isBasicALUExcept=~opcode_main[0] && (magic[1:0]==2'b01 && instr[28:23]!=6'b0);  
  assign isBasicShift=opcode_main[7:1]==7'd20 || opcode_main[7:1]==7'd21 ||
      opcode_main[7:1]==7'd22;      
  assign isBasicShiftExcept=magic[1:0]==2'b01 && instr[29:25]!=5'b0;
  
  assign isBasicCmpTest=opcode_main[7:1]==7'd23 || opcode_main[7:2]==6'd12 ||
    opcode_main[7:1]==7'd26 || opcode_main[7:2]==6'd54;

  assign isBaseSpecLoad=opcode_main==8'd54 || opcode_main==8'd202;
  assign isBaseIndexSpecLoad=opcode_main==8'd55 || opcode_main==8'd203;
  
  assign isImmLoadStore=(opcode_main[7:2]==6'd15) || opcode_main[7:1]==7'b1011000;  
  assign isBaseLoadStore=(opcode_main[7:5]==3'b010) || opcode_main[7:4]==4'b0110;
  assign isBaseIndexLoadStore=(opcode_main[7:5]==3'b100) || opcode_main[7:4]==4'b0111;

  assign isBasicCJump=opcode_main[7:4]==4'b1010;
  //gap 176-177 for imm load.
  assign isSelfTestCJump=opcode_main==8'd178 || opcode_main==8'd179;
  assign isLongCondJump=opcode_main==8'd180;
  assign isUncondJump=opcode_main==8'd181;
  assign isIndirJump=opcode_main==8'd182 && instr[15:13]==3'd0;
  assign isCall=opcode_main==8'd182 && (instr[15:13]==3'd1 || instr[15:13]==3'd2);
  assign isRet=opcode_main==8'd182 && instr[15:13]==3'd3;
  assign isMovOrExtB=opcode_main==8'd183 || opcode_main[7:2]==6'b101110 || opcode_main[7:0]==8'd189;
  assign isMovOrExtA=opcode_main==8'd188 || opcode_main[7:1]==7'd95 || opcode_main[7:1]==7'd96;
  assign isMovOrExtExcept=magic[1:0]==2'b11 && opcode_main!=8'd183 && opcode_main[7:1]!=7'd92;
  assign isCSet=opcode_main==8'd194; 
  assign isBasicAddNoFl=opcode_main==8'd195 || opcode_main==8'd196;
  
  assign isLeaIPRel=opcode_main==8'd197;

  assign isCmov=opcode_main==198 && magic[1:0]==2'b01;
  assign isCallPrep=opcode_main==8'd199;
  
 
  assign isSimdInt=opcode_main==8'd200;
  assign isFPUreor=opcode_main==8'd201;
  //202,203 for spec load
  //204,205 for isBaseExtStore (future ext)
  //206,207 for isBaseIndexExtStore (future ext)
  //208,209 for isImmExtStore (future ext)

  assign isShlAddMulLike=opcode_main==8'd210 || opcode_main==8'd211;
  assign isPtrSec=opcode_main==8'd212;
  assign isJalR=opcode_main==8'd213 || opcode_main==8'd214 || opcode_main==8'd215 || opcode_main==8'd220 || opcode_main==8'd221;
  //216-219=cmp16,cmp8
  assign isCexALU=opcode_main==8'd222;

  assign isBasicFPUScalarA=opcode_main==8'hf0 && instr[13:12]==2'b0;
  assign isBasicFPUScalarB=opcode_main==8'hf0 && instr[13:12]==2'b1;
  assign isBasicFPUScalarC=opcode_main==8'hf0 && instr[15:12]==4'd2;
  assign isBasicFPUScalarCmp=opcode_main==8'hf0 && instr[15:12]==4'd6;
  assign isBasicFPUScalarCmp2=opcode_main==8'hf0 && instr[15:12]==4'd10;
  assign isBasicFPUScalarCmp3=opcode_main==8'hf0 && instr[15:12]==4'd12;
  
  assign isBasicSysInstr=opcode_main==8'hff;
  
  assign qconstant[1]={1'b0,pconstant[3]};//??
  assign qtrien   [1]=trien    [3];//??
  assign qconstant[2]={1'b0,pconstant[8]};
  assign qtrien   [2]=trien    [8];
  assign qconstant[3]={1'b0,pconstant[9]};
  assign qtrien   [3]=trien    [9];
  assign qconstant[4]={1'b0,pconstant[10]};
  assign qtrien   [4]=trien    [10];
  assign qconstant[5]={1'b0,pconstant[18]};
  assign qtrien   [5]=trien    [18];
  assign qconstant[6]={1'b0,pconstant[20]};
  assign qtrien   [6]=trien    [20];
  assign qconstant[7]={1'b0,pconstant[25]};
  assign qtrien   [7]=trien    [25];
  assign qconstant[8]={(magic[3:0]==4'hf && opcode_main==8'd183) & instr[15],pconstant[26]};
  assign qtrien   [8]=trien    [26];
  assign qconstant[9]={1'b0,pconstant[30]};
  assign qtrien   [9]=trien    [30];
  assign qconstant[10]={1'b0,pconstant[35]};
  assign qtrien   [10]=trien    [35];
  assign qconstant[11]={1'b0,pconstant[13]};
  assign qtrien   [11]=trien    [13];
  assign qconstant[12]={~pisIPRel[19],pconstant[19]};
  assign qtrien   [12]=trien[19];
  assign qconstant[13]={1'b0,pconstant[14]};
  assign qtrien   [13]=trien    [14];
  assign qconstant[14]={1'b0,pconstant[31]};
  assign qtrien   [14]=trien    [31];
  assign qconstant[15]={1'b0,pconstant[39]};
  assign qtrien   [15]=trien    [39];
  assign qconstant[0]={1'b0,pconstant[0]};
  assign qtrien   [0]=qtrien[11:1]==11'b0;
  
  //triens that set const
  //3,8,9,10,13,18,20,25,26,30, 35
 
  generate
      genvar p,q,m;
      for(m=0;m<16;m=m+1) begin : triconst_gen
	  assign constant=qtrien[m] ? qconstant[m] : 65'bz;
      end
      for(p=0;p<5;p=p+1) begin
          wire [OPERATION_WIDTH-1:0] koperation;
          wire [REG_WIDTH-1:0] krA;
          wire krA_use;
          wire [REG_WIDTH-1:0] krB;
          wire krB_use;
          wire [REG_WIDTH-2:0] krC;
          wire krC_use;
          wire kuseCRet;
	  wire [4:0] kalucond;
          wire kuseBConst;
          wire [2:0] krndmode;
    //  output reg useBSmall;//small constant use; used for call/pop/push
          wire [64:0] kconstant;
    //  output reg [3:0] smallConst; //signed
          wire [REG_WIDTH-1:0] krT;
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
          wire [1:0] kerror;
          wire [4:0] kjumpType;
	  for(q=0;q<8;q=q+1) begin : tri_gen
	      assign krA=trien[p*8+q] ? {prAX[p*8+q],prA[p*8+q]} : 6'bz;
	      assign krB=trien[p*8+q] ? {prBE[p*8+q],prB[p*8+q]} : 6'bz;
	      assign krC=trien[p*8+q] ? prC[p*8+q] : 5'bz;
	      assign krT=trien[p*8+q] ? {prTE[p*8+q],prT[p*8+q]} : 6'bz;
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
//	      assign kthisSpecLoad=trien[p*8+q] ? pthisSpecLoad[p*8+q] : 1'bz;
	      assign kisIPRel=trien[p*8+q] ? pisIPRel[p*8+q] : 1'bz;
	      assign kalucond=trien[p*8+q] ? palucond[p*8+q] : 5'bz;
	      assign krndmode=trien[p*8+q] ? prndmode[p*8+q] : 3'bz;
	      assign kflags_use=trien[p*8+q] ? pflags_use[p*8+q] : 1'bz;
	      assign kflags_write=trien[p*8+q] ? pflags_write[p*8+q] : 1'bz;
	      assign kflags_wrFPU=trien[p*8+q] ? pflags_wrFPU[p*8+q] : 1'bz;
	      assign krBT_copyV=trien[p*8+q] ? prBT_copyV[p*8+q] : 1'bz;
	      assign kinstr_fsimd=trien[p*8+q] ? pinstr_fsimd[p*8+q] : 1'bz;
	      assign kerror=trien[p*8+q] ? perror[p*8+q] : 2'bz;
	      assign kport=trien[p*8+q] ? pport[p*8+q] : 4'bz;
	      assign kjumpType=trien[p*8+q] ? pjumpType[p*8+q] : 5'bz;
	      assign koperation=trien[p*8+q] ? poperation[p*8+q] : 13'bz;
	  end
	  assign krA=(~|trien[p*8+:8]) ? 6'b0 : 6'bz;
	  assign krB=(~|trien[p*8+:8]) ? 6'b0 : 6'bz;
	  assign krC=(~|trien[p*8+:8]) ? 5'b0 : 5'bz;
	  assign krT=(~|trien[p*8+:8]) ? 6'b0 : 6'bz;
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
//	  assign kthisSpecLoad=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kisIPRel=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kalucond=(~|trien[p*8+:8]) ? 5'b0 : 5'bz;
	  assign kflags_use=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kflags_write=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krndmode=(~|trien[p*8+:8]) ? 3'b0 : 3'bz;
	  assign kflags_wrFPU=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign krBT_copyV=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kinstr_fsimd=(~|trien[p*8+:8]) ? 1'b0 : 1'bz;
	  assign kerror=(~|trien[p*8+:8]) ? 2'b0 : 2'bz;
	  assign kport=(~|trien[p*8+:8]) ? 4'b0 : 4'bz;
	  assign kjumpType=(~|trien[p*8+:8]) ? 5'b10000 : 5'bz;
	  assign koperation=(~|trien[p*8+:8]) ? 13'b0 : 13'bz;
	      
	  assign rA=(|trien[p*8+:8]) ? {krA} : 6'bz;
	  assign rB=(|trien[p*8+:8]) ? {krB} : 6'bz;
	  assign rC=(|trien[p*8+:8]) ? {1'b0,krC} : 6'bz;
	  assign rT=(|trien[p*8+:8]) ? {krT} : 6'bz;
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
	  assign alucond=(|trien[p*8+:8]) ? kalucond : 5'bz;
	  assign rndmode=(|trien[p*8+:8]) ? krndmode : 3'bz;
	  assign flags_use=(|trien[p*8+:8]) ? kflags_use : 1'bz;
	  assign flags_write=(|trien[p*8+:8]) ? kflags_write : 1'bz;
	  assign flags_wrFPU=(|trien[p*8+:8]) ? kflags_wrFPU : 1'bz;
	  assign rBT_copyV=(|trien[p*8+:8]) ? krBT_copyV : 1'bz;
	  assign instr_fsimd=(|trien[p*8+:8]) ? kinstr_fsimd : 1'bz;
	  assign error=(|trien[p*8+:8]) ? kerror||dat==INDEX : 2'bz;
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
  assign alucond=(~|trien) ? 5'b0 : 5'bz;
  assign rndmode=(~|trien) ? 3'b0 : 3'bz;
  assign flags_use=(~|trien) ? 1'b0 : 1'bz;
  assign flags_write=(~|trien) ? 1'b0 : 1'bz;
  assign flags_wrFPU=(~|trien) ? 1'b0 : 1'bz;
  assign rBT_copyV=(~|trien) ? 1'b0 : 1'bz;
  assign instr_fsimd=(~|trien) ? 1'b0 : 1'bz;
  assign error=(~|trien) ? 2'b1 : 2'bz;
  assign port=(~|trien) ? PORT_LOAD : 4'bz;
  assign jumpType=(~|trien) ? 5'b10000 : 5'bz;
  assign operation=(~|trien) ? 13'hff : 13'bz;
  
 
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
	  prBE[tt]=1'b0;
	  prTE[tt]=1'b0;
	  prAX[tt]=1'b0;
          prA_use[tt]=1'b0;
          prB_use[tt]=1'b0;
          prT_use[tt]=1'b0;
          prC_use[tt]=1'b0;
          pport[tt]=4'b0;
          pconstant[tt]=constantDef;
          //pconstant[tt][64]=1'b0;
     //     pisBigConst[tt]=magic[2:0]==3'b111;
          pthisSpecLoad[tt]=1'b0;    
          pisIPRel[tt]=1'b0;
	  palucond[tt]=5'b0;
	  prndmode[tt]=3'b111;
          puseCRet[tt]=1'b0;
          prA_useF[tt]=1'b0;
          prB_useF[tt]=1'b0;
          prT_useF[tt]=1'b0;
          prC_useF[tt]=1'b0;
          pchain[tt]=1'b0;
	      perror[tt]={1'b0,(|magic[3:2])&(&magic[1:0]) || &srcIPOff[3:0]}; 
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

      csrss_retIP_en=1'b0;
      
      trien[0]=~magic[0] && subIsBasicALU|subIsBasicShift;
      poperation[0]={8'b0,opcode_sub[4:2],1'b0,opcode_sub[1]};
      puseBConst[0]=opcode_sub[0]|subIsBasicShift;
      prA_use[0]=1'b1;
      prB_use[0]=1'b1;
      prT_use[0]=1'b1;
      puseRs[0]=1'b1;
      prAlloc[0]=1'b1;
      pport[0]=subIsBasicShift|subIsBasicXOR ? PORT_SHIFT : PORT_ALU;
      pflags_write[0]=1'b1;
      if (~prevSpecLoad && opcode_sub[0]|subIsBasicShift) begin
          prA[0]={1'b0,instr[11:8]};
          prT[0]={1'b0,instr[11:8]};
          prB[0]={instr[7],instr[15:12]};
      end else if (~prevSpecLoad) begin
          prA[0]={instr[6],instr[11:8]};
          prT[0]={instr[6],instr[11:8]};
          prB[0]={instr[7],instr[15:12]};
      end else if (opcode_sub[0]|subIsBasicShift) begin
          prA[0]=5'd16;
          prT[0]={1'b0,instr[11:8]};
      end else begin
          prA[0]={instr[6],instr[11:8]};
          prT[0]={instr[7],instr[15:12]};
          prB[0]=5'd16; 
      end

      trien[1]=~magic[0] & subIsMovOrExt;
      puseBConst[1]=opcode_sub==6'h29 || opcode_sub==6'h26 || opcode_sub==6'h27;
      prA_use[1]=1'b0;
      prB_use[1]=1'b1;
      prT_use[1]=1'b1;
      puseRs[1]=1'b1;
      prAlloc[1]=1'b1;
      pport[1]=PORT_ALU;
      poperation[1][12]=1'b1;
       //verilator lint_off CASEINCOMPLETE
      case(opcode_sub)
	6'h20,6'h29: poperation[1][7:0]=`op_mov64;
	6'h21: poperation[1][7:0]=`op_mov32;
	6'h22: begin poperation[1][7:0]=`op_add64; poperation[1][8]=1'b1; prA[1]={instr[7],instr[15:12]}; prA_use[1]=1'b1; end
	6'h23: begin poperation[1][7:0]=`op_sub64; poperation[1][8]=1'b1; prA[1]={instr[7],instr[15:12]}; prA_use[1]=1'b1; end
	6'h24: poperation[1][7:0]=`op_sxt8_32;
	6'h25: poperation[1][7:0]=`op_sxt16_32;
	6'h26: begin poperation[1][7:0]=`op_add64; poperation[1][8]=1'b1; prA[1]={1'b0,instr[15:12]}; prA_use[1]=1'b1; end
	6'h27: begin poperation[1][7:0]=`op_sub64; poperation[1][8]=1'b1; prA[1]={1'b0,instr[15:12]}; prA_use[1]=1'b1; end
	6'h28: poperation[1][7:0]=`op_sxt32_64;
       endcase
       //verilator lint_on CASEINCOMPLETE
       prB[1]={instr[6]&&!(opcode_sub==6'h29 || opcode_sub==6'h26 || opcode_sub==6'h27),instr[11:8]};
       prT[1]={instr[7]&&!(opcode_sub==6'h29 || opcode_sub==6'h26 || opcode_sub==6'h27),instr[15:12]};

       trien[2]=~magic[0] & subIsCmpTest;
       puseBConst[2]=opcode_sub[0] & ~(opcode_sub[2:1]==2'h3);
       prA_use[2]=1'b1;
       prB_use[2]=1'b1;
       prT_use[2]=1'b0;
       puseRs[2]=1'b1;
       prAlloc[2]=1'b0;
       pport[2]=PORT_ALU;
       pflags_write[2]=1'b1;
       prB[2]={instr[6],instr[11:8]};
       prA[2]={instr[7]&&!(opcode_sub[0] & ~(opcode_sub[2:1]==2'h3)),instr[15:12]};
       //verilator lint_off CASEINCOMPLETE
       case (opcode_sub[2:1])
         2'h1:  poperation[2]=`op_sub64;
         2'h2:  poperation[2]=`op_sub32;
         2'h3:  poperation[2]=opcode_sub[0] ? `op_and64 : `op_and32;
       endcase
       //verilator lint_on CASEINCOMPLETE
      
       trien[3]=1'b0;//~magic[0] & subIsCJ;
       pconstant[3]={{55{instr[15]}},instr[15:8],1'b0};
       pport[3]=0;
       pjumpType[3]=({instr[7:6],instr[1:0]}==4'hf) ? 5'h10 : 
         {1'b0,instr[7:6],instr[1:0]};
       
       trien[4]=~magic[0] & subIsFPUD;
       puseRs[4]=1'b1;
       prAlloc[4]=1'b1;
       poperation[4][12]=1'b0;//opcode_sub[5:1]!=5'b11100;
       poperation[4][8]=opcode_sub[0];
       poperation[4][9]=opcode_sub[0];
       if (~prevSpecLoad) begin
           prA[4]={1'b0,instr[11:8]};
           prT[4]={1'b0,instr[11:8]};
           prB[4]={instr[7],instr[15:12]};
       end else begin
           prB[4]=5'd15; //not a mistake; fpu spec instr is 15 rather than 16
           prT[4]={1'b0,instr[11:8]};
           prA[4]={instr[7],instr[15:12]};
       end
       prA_useF[4]=1'b1;
       prB_useF[4]=1'b1;
       prT_useF[4]=1'b1;
       if (opcode_sub[5:1]==5'b11100) begin
           pport[4]=PORT_FMUL;
           poperation[4][7:0]=instr[6] ? `fop_mulDH : `fop_mulDL;
       end else begin
	   pport[4]=PORT_FADD;
           if (opcode_sub[1]) begin
               poperation[4][7:0]=instr[6] ? `fop_subDH : `fop_subDL;
           end else begin
               poperation[4][7:0]=instr[6] ? `fop_addDH : `fop_addDL;
           end
       end
       
       trien[5]=~magic[0] & subIsFPUPD;
       puseRs[5]=1'b1;
       prAlloc[5]=1'b1;
       poperation[5][12]=opcode_sub[5:1]!=5'b11101 && opcode_sub[0] && opcode_main[6];
       poperation[5][8]=opcode_sub[0];
       poperation[5][9]=opcode_main[6];
       if (~prevSpecLoad) begin
           prA[5]={1'b0,instr[11:8]};
           prT[5]={1'b0,instr[11:8]};
           prB[5]={instr[7],instr[15:12]};
       end else begin
           prB[5]=5'd15; 
           prT[5]={1'b0,instr[11:8]};
           prA[5]={instr[7],instr[15:12]};
       end
       prA_useF[5]=1'b1;
       prB_useF[5]=1'b1;
       prT_useF[5]=1'b1;
       if (opcode_sub[5:1]==5'b11101) begin
           pport[5]=PORT_FMUL;
           poperation[5][7:0]=`fop_mulDP;
       end else begin
	   pport[5]=PORT_FADD;
           if (opcode_sub[1]) begin
               poperation[5][7:0]=`fop_subDP;
           end else begin
               poperation[5][7:0]=`fop_addDP;
           end
       end
       
       trien[6]=~magic[0] & subIsSIMD;
       puseRs[6]=1'b1;
       prAlloc[6]=1'b1;
       pport[6]=PORT_VADD;
       if (~prevSpecLoad) begin
           prA[6]={1'b0,instr[11:8]};
           prT[6]={1'b0,instr[11:8]};
           prB[6]={1'b0,instr[15:12]};
       end else begin
           prB[6]=5'd15;
           prT[6]={1'b0,instr[11:8]};
           prA[6]={1'b0,instr[15:12]};
       end
       prA_useF[6]={opcode_sub[2:1],opcode_main[7:6]}!=4'b0111;
       prB_useF[6]=1'b1;
       prT_useF[6]=1'b1;
       prA_isV[6]={opcode_sub[2:1],opcode_main[7:6]}!=4'b0111;
       prB_isV[6]=1'b1;
       prT_isV[6]=1'b1;
       //verilator lint_off CASEINCOMPLETE
       casex({opcode_sub[2:1],opcode_main[7:6]})
           4'b0100: poperation[6]=`simd_pxor;
           4'b0101: poperation[6]=`simd_por;
           4'b0110: poperation[6]=`simd_pand;
           4'b0111: poperation[6]=`simd_pnot;
           4'b10xx: poperation[6][7:0]={opcode_main[7:6],6'd`simd_padd};
           4'b11xx: poperation[6][7:0]={opcode_main[7:6],6'd`simd_psub};
       endcase              
       //verilator lint_on CASEINCOMPLETE
       trien[7]=~magic[0] & subIsFPUSngl;
       puseRs[7]=1'b1;
       prAlloc[7]=1'b1;
       if (~prevSpecLoad) begin
           prA[7]={1'b0,instr[11:8]};
           prT[7]={1'b0,instr[11:8]};
           prB[7]={1'b0,instr[15:12]};
       end else begin
           prB[7]=5'd15; 
           prT[7]={1'b0,instr[11:8]};
           prA[7]={1'b0,instr[15:12]};
       end
       prA_useF[7]=1'b1;
       prB_useF[7]=1'b1;
       prT_useF[7]=1'b1;
       //verilator lint_off CASEINCOMPLETE
       case({opcode_main[3],opcode_main[7:6]})
     3'd0: begin pport[7]=PORT_FMUL; poperation[7]=`fop_mulS; end
     3'd1: begin pport[7]=PORT_FADD; poperation[7]=`fop_addS; end
     3'd2: begin pport[7]=PORT_FADD; poperation[7]=`fop_subS; end
     3'd4: begin pport[7]=PORT_FMUL; poperation[7]=`fop_mulSP; end
     3'd5: begin pport[7]=PORT_FADD; poperation[7]=`fop_addSP; end
     3'd6: begin pport[7]=PORT_FADD; poperation[7]=`fop_subSP; end
       endcase
       //verilator lint_on CASEINCOMPLETE
       trien[8]=~magic[0] & subIsLinkRet;
       if (opcode_sub[1]) begin
           //inc dec neg
           pport[8]=PORT_ALU;
	   prA[8]=instr[12:8];
           prB[8]=instr[12:8];
           prT[8]=instr[12:8];
           poperation[8][2]=instr[13];
           poperation[8][0]=instr[14];
           poperation[8][8]=instr[15];
           poperation[8][9]=~instr[15];
           prA_use[8]=~instr[15];
           prB_use[8]=1'b1;
           puseBConst[8]=instr[15];
           pconstant[8]=64'd1;
           prT_use[8]=1'b1;
           puseRs[8]=1'b1;
           prAlloc[8]=1'b1;
           pflags_use[8]=1'b1;
           pflags_write[8]=1'b1;
           if (instr[15:13]==3'h7) perror[8]=2'b1;
       end else begin
           pport[8]=PORT_ALU;
           poperation[8][12]=1'b1;
           puseBConst[8]=1'b1;
           prB_use[8]=1'b1;
           prA_use[8]=1'b0;
           prT_use[8]=1'b1;
           pisIPRel[8]=1'b1;
           pconstant[8]={59'b0,instr[15:12],1'b0};
           prT[8]={1'b1,instr[11:8]};
           poperation[8][7:0]=mode64 ? `op_add64 : `op_add32;
           puseRs[8]=1'b1;
       end

       trien[9]=magic[0] & isBasicALU & ~isBasicALUExcept;
       puseBConst[9]=opcode_main[0]||magic[1:0]==2'b11;
       poperation[9][7:0]={3'b0,opcode_main[5:3],1'b0,opcode_main[1]};
       if (opcode_main[2]) perror[9]=1; //disable 8 and 16 bit insns
       pflags_write[9]=1'b1;
       if (magic[1:0]==2'b01) begin
           poperation[9][12]=instr[31];
           pflags_write[9]=~instr[31];
           pconstant[9]={{51{instr[30]}},instr[30:18]};
       end
          
       prA_use[9]=1'b1;
       prB_use[9]=1'b1;
       prT_use[9]=1'b1;
       puseRs[9]=1'b1;
       prAlloc[9]=1'b1;
       pport[9]=isBasicXOR ? PORT_SHIFT : PORT_ALU;
          
       if (opcode_main[0]||magic[1:0]==2'b11) begin
           if (magic[1:0]==2'b01) begin
               prA[9]={instr[17],instr[11:8]};
               prT[9]=instr[16:12];
               prB[9]=5'd31;
           end else if (magic[3:0]==4'b0111) begin
               prA[9]={instr[48],instr[11:8]};
               prT[9]={instr[49],instr[15:12]};
               prB[9]=5'd31;
               perror[9]=0;
	       if (~opcode_main[0]) pconstant[9]={32'b0,instr[47:16]};
           end else begin
               prA[9]={1'b0,instr[11:8]};
               prT[9]={1'b0,instr[15:12]};
               prB[9]=5'd31;
	       if (~opcode_main[0]) pconstant[9]={32'b0,instr[47:16]};
           end
       end else begin
           if (magic[1:0]==2'b01) begin
               prA[9]={instr[17],instr[11:8]};
               prT[9]=instr[16:12];
               prB[9]=instr[22:18];
           end else begin
               perror[9]=1;
           end
       end
        //  if (rT==6'd16) thisSpecAlu=1'b1;
      
       trien[10]=magic[0] & isBasicShift;
       prA_use[10]=1'b1;
       prB_use[10]=1'b1;
       prT_use[10]=1'b1;
       puseRs[10]=1'b1;
       prAlloc[10]=1'b1;
       pport[10]=PORT_SHIFT;
       case (opcode_main[7:0])
       40: poperation[10]=`op_shl64;
       41: poperation[10]=`op_sar64;
       42: poperation[10]=`op_shr64;
       43: poperation[10]=`op_shl32;
       44: poperation[10]=`op_sar32;
       45: poperation[10]=`op_shr32;
       endcase
            
       if (magic[1:0]==2'b01) begin
           if (instr[30]) begin
               prA[10]={instr[17],instr[11:8]};
               prT[10]=instr[16:12];
               prB[10]=5'd31;
               puseBConst[10]=1'b1;
               pconstant[10]={47'b0,instr[29:25],6'b0,instr[23:18]};
               pflags_use[10]=1'b0;
               pflags_write[10]=~instr[24];
               poperation[10][12]=instr[24];
           end else begin
               prA[10]={instr[17],instr[11:8]};
               prT[10]=instr[16:12];
               prB[10]=instr[22:18];
               puseBConst[10]=1'b0;
               pflags_use[10]=1'b0;
               pflags_write[10]=~instr[24];
               poperation[10][12]=instr[24];
           end
           poperation[10][12]=instr[24];              
       end else begin
           perror[10]=2'b1;
       end
//          if (rT==6'd16) thisSpecAlu=1'b1;
       trien[11]=~magic[0] & subIsFPUE;
       puseRs[11]=1'b1;
       prAlloc[11]=1'b1;
       if (~prevSpecLoad) begin
           prA[11]=(opcode_main[7:6]==2'd3) ? {1'b0,rB_reor} : {1'b0,rA_reor};
           prT[11]={1'b0,rA_reor};
           prB[11]=(opcode_main[7:6]==2'd3) ? {1'b0,rA_reor} : {1'b0,rB_reor};
       end else begin
           prA[11]=(opcode_main[7:6]==2'd3) ? 5'd15 : {1'b0,rA_reor};
           prT[11]={1'b0,rA_reor};
           prB[11]=(opcode_main[7:6]==2'd3) ? {1'b0,rA_reor} : 5'd15;
       end
       prA_useF[11]=1'b1;
       prB_useF[11]=1'b1;
       prT_useF[11]=1'b1;
       case(opcode_main[7:6])
     2'd0: begin pport[11]=PORT_FMUL; poperation[11]=`fop_mulEE; end
     2'd1: begin pport[11]=PORT_FADD; poperation[11]=`fop_addEE; end
     2'd2: begin pport[11]=PORT_FADD; poperation[11]=`fop_subEE; end
     2'd3: begin pport[11]=PORT_FADD; poperation[11]=`fop_subEE; end
       endcase

      trien[12]=magic[0] & isBaseLoadStore;
      poperation[12][5:0]=(opcode_main[5:3]==3'b101) ? 6'h22 : opcode_main[5:0];
      poperation[12][12:6]=7'b0;
      prA_use[12]=1'b0;
      prB_use[12]=1'b1;
      prT_use[12]=~opcode_main[0] & opcode_main[5] && opcode_main[5:3]!=3'b101;
      prC_use[12]=opcode_main[0] & opcode_main[5];
      prT_useF[12]=~opcode_main[0] & ~opcode_main[5];
      prC_useF[12]=opcode_main[0] & ~opcode_main[5];
      prT_isV[12]=~opcode_main[0] & ~opcode_main[5] & fop_v(opcode_main[4:0]);
      puseRs[12]=1'b1;
      prAlloc[12]=~opcode_main[0] && opcode_main[5:3]!=3'b101;
      puseBConst[12]=1'b0;
      pport[12]=opcode_main[0] ? PORT_STORE : PORT_LOAD;
      if (opcode_main[0]) begin //store
          if (magic[1:0]==2'b01) begin
              prB[12]={instr[17],instr[11:8]};
              prC[12]=instr[16:12];
          end else begin
              prC[12]={freg_vf(opcode_main[4:0],~opcode_main[5]),instr[11:8]};
	      if (opcode_main[5] && prC[12]==REG_SP) prC[12]=5'd16;
              prB[12]={freg_vf(opcode_main[4:0],~opcode_main[5]),instr[15:12]};
          end
      //        if (prevSpecAlu) rC=6'd16;
      end else begin
          if (magic[1:0]==2'b01) begin
              prB[12]={instr[17],instr[11:8]};
              prT[12]=instr[16:12];
          end else begin
              prT[12]={freg_vf(opcode_main[4:0],~opcode_main[5]),instr[11:8]};
              prB[12]={freg_vf(opcode_main[4:0],~opcode_main[5]),instr[15:12]};
          end
      end
      if (opcode_main[0] && opcode_main[5:3]==3'b101) perror[12]=2'b1;
     //     if (prevSpecAlu) rC=6'd16;
      trien[13]=magic[0] & isBaseIndexLoadStore;
      if (opcode_main[7:4]==4'b0111 && opcode_main[3])
          poperation[13][5:0]=6'd22;
      else
          poperation[13][5:0]=(opcode_main[7:4]==4'b0111) ? {2'b10,opcode_main[3:0]} : {1'b0,opcode_main[4:0]};
      poperation[13][7]=1'b0;
      poperation[13][6]=~(magic==4'b0111 && instr[57]);
      poperation[13][9:8]=magic[2:0]==3'b111 ? instr[53:52] : ( magic[1:0]==2'b01 ?
        instr[22:21] : instr[24:23]);
      poperation[13][12:10]=3'b0;
      prA_use[13]=~(magic==4'b0111 && instr[57]);
      prT_use[13]=~opcode_main[0] && opcode_main[7:4]==4'b0111 && ~opcode_main[3];
      prC_use[13]=opcode_main[0] && opcode_main[7:4]==4'b0111;
      prT_useF[13]=~opcode_main[0] && opcode_main[7:4]!=4'b0111;
      prT_isV[13]=~opcode_main[0] && opcode_main[7:4]!=4'b0111 && fop_v(opcode_main[4:0]);
      prC_useF[13]=opcode_main[0] && opcode_main[7:4]!=4'b0111;
      puseRs[13]=1'b1;
      prAlloc[13]=~opcode_main[0] && !(opcode_main[7:4]==4'b0111 && opcode_main[3]);// & opcode_main[7:4]==4'b0111;
      puseBConst[13]=magic==4'b0111 && instr[58];
      pport[13]=opcode_main[0] ? PORT_STORE : PORT_LOAD;
      if (magic[2:0]!=3'b111) pconstant[13]=(magic[1:0]==2'b11) ? {{9+32{instr[47]}},instr[47:25]} : {{23+32{instr[31]}},instr[31:23]};
      if (opcode_main[0]) begin //store
          if (magic==4'b0111) begin 
              prC[13]={instr[54],instr[11:8]};
              prB[13]={instr[55],instr[15:12]};
              prA[13]={instr[56],instr[51:48]};
              perror[13]=0;
          end else begin
              prC[13]={instr[20],instr[11:8]};
              prB[13]={instr[21]&&magic[1:0]!=2'b01,instr[15:12]};
              prA[13]={instr[22]&&magic[1:0]!=2'b01,instr[19:16]};
          end 
        //  if (prevSpecAlu) rC=6'd16;
      end else begin
          if (magic==4'b0111) begin 
              prT[13]={instr[54],instr[11:8]};
              prB[13]={instr[55],instr[15:12]};
              prA[13]={instr[56],instr[51:48]};
              perror[13]=0;
          end else begin
              prT[13]={instr[20],instr[11:8]};
              prB[13]={instr[21]&&magic[1:0]!=2'b01,instr[15:12]};
              prA[13]={instr[22]&&magic[1:0]!=2'b01,instr[19:16]};
          end
      end
      prB_use[13]=1'b1;
      prA_use[13]=~(magic==4'b0111 && instr[57]);
      pisIPRel[13]=1'b0;//magic==4'b0111 && instr[59];
      if (|poperation[13][9:8] && ~poperation[13][6]) perror[13]=1;
      if (magic[2:0]==3'b111 && instr[59] && ~instr[58]) perror[13]=1;
      if (magic[2:0]==3'b111 && instr[63:60]!=0) perror[13]=1;
      if (opcode_main[0] &&opcode_main[7:4]==4'b0111 && opcode_main[3])
          perror[13]=1;
      if (riscmove) perror[13]=1;
      
      trien[14]=magic[0] & isCmov;//
      prA[14]={instr[17],instr[11:8]};
      prT[14]=instr[16:12];
      prB[14]=instr[22:18];
      prA_use[14]=!instr[30];
      prB_use[14]=1'b1;
      prT_use[14]=1'b1;
      puseRs[14]=1'b1;
      prAlloc[14]=1'b1;
      pport[14]=PORT_ALU;
      pflags_use[14]=1'b1;
      poperation[14][12:11]=2'b10;
      puseBConst[14]=instr[29];
      pconstant[14]={63'b0,instr[30]};
      case(instr[28:26])
      0: begin poperation[14][7:0]=`op_clahf; prB_use[14]=1'b0; prT_use[14]=1'b0;
             pflags_write[14]=1'b1; pflags_use[14]=1'b1; poperation[14][12]=1'b0;  end
      1: begin poperation[14][7:0]=`op_clahfn; prB_use[14]=1'b0; prT_use[14]=1'b0;
             pflags_write[14]=1'b1; pflags_use[14]=1'b1;  poperation[14][12]=1'b0;end
      2: poperation[14][7:0]=`op_cmov64;
      3: poperation[14][7:0]=`op_cmovn64;
      4: poperation[14][7:0]=`op_cmov32;
      5: poperation[14][7:0]=`op_cmovn32;
      6: begin poperation[14][7:0]=`op_lahf; prB_use[14]=1'b0; prT_use[14]=1'b0; 
             pflags_write[14]=1'b1; pflags_use[14]=1'b0;  poperation[14][12]=1'b0;end
      7: begin poperation[14][7:0]=`op_sahf; prB_use[14]=1'b0; prA_use[14]=1'b0; end
      endcase
      poperation[14][10:8]=instr[25:23];
      
      trien[15]=magic[0] & isBasicCmpTest; 
	  //if there is magic, we assume immediate version
      puseBConst[15]=instr[31] || magic[1:0]!=2'b01;
      pport[15]=PORT_ALU;
      pflags_write[15]=1'b1;
      case(opcode_main)
      46,47: poperation[15]=`op_sub64;
      48,49: poperation[15]=`op_sub32;
      216,217: poperation[15]=`op_cmp16;
      218,219: poperation[15]=`op_cmp8;
      50,51: poperation[15]=`op_and64;
      52,53: poperation[15]=`op_and32;
      default: perror[15]=1;
      endcase
      prA_use[15]=1'b1;
      prB_use[15]=1'b1;
      prT_use[15]=1'b0;
      puseRs[15]=1'b1;
      prAlloc[15]=1'b1;
      prT[15]=5'd31;
	 
      if (magic[1:0]==2'b01) begin
          prA[15]={instr[16],instr[15:12]};
          prB[15]={instr[17],instr[11:8]};
          if (instr[28]) perror[15]=1;
      end else if (magic[2:0]==3'b011) begin
          prA[15]=instr[12:8];
          if (instr[15:13]!=0) perror[15]=1;
      end
    
      trien[16]=magic[0] && isShlAddMulLike|isPtrSec; 
      pport[16]=PORT_ALU;
      puseBConst[16]=1'b0;
      pflags_write[16]=isPtrSec || !instr[28];
      casex({instr[28],instr[29],instr[0],isPtrSec})
      4'b0x00: poperation[16]=`op_sadd_even|4096;
      4'b0x10: poperation[16]=`op_sadd_odd|4096;
      4'b1x00: begin poperation[16]=`op_cloop_even; pjumpType[16]={1'b0,3'h0,instr[23]}; end 
      4'b1x10: begin poperation[16]=`op_cloop_odd; pjumpType[16]={1'b0,3'h0,instr[23]}; end
      4'b00x1: begin poperation[16]=`op_sec64|4096; pport[16]=PORT_MUL; end
      4'b01x1: begin poperation[16]=`op_swp32|4096; pport[16]=PORT_MUL; end
      4'b11x1: begin poperation[16]=`op_swp64|4096; pport[16]=PORT_MUL; end
      default: begin perror[16]=2'b1; end
      endcase
      prA_use[16]=1'b1;
      prB_use[16]=1'b1;
      prT_use[16]=1'b1;
      puseRs[16]=1'b1;
      prAlloc[16]=1'b1;
      poperation[16][10:8]=instr[31:29];
      poperation[16][12]=1'b1;    
      prA[16]={instr[17],instr[11:8]};
      prB[16]=instr[16:12];
      if (instr[27:24]!=0) perror[16]=1;
      prA[16]={instr[17],instr[11:8]};
      prT[16]=instr[16:12];
      prB[16]=instr[22:18];
      if (magic[1:0]!=2'b01) perror[16]=2'b1;
      if (!isPtrSec && instr[28]) begin
	  prA[16]=5'd2;
	  puseBConst[16]=1'b1;
	  pconstant[16]=64'hffff_ffff_ffff_ffff;
	  prT[16]=5'd2;
	  perror[16]=2'b0;
	  //jump imm={instr[27:8],1'b0}
      end
    
      trien[17]=magic[0] & isBaseSpecLoad;
      pport[17]=PORT_LOAD;
      poperation[17][5:0]={opcode_main[7],instr[11:8],1'b0};
      poperation[17][12:6]=7'b0;
      prA_use[17]=1'b0;
      prB_use[17]=1'b1;
      prT_use[17]=opcode_main[7];
      prT_useF[17]=~opcode_main[7];
      prT_isV[17]=~opcode_main[7] & fop_v({instr[11:8],1'b0});
      puseRs[17]=1'b1;
      prAlloc[17]=1'b1;
      puseBConst[17]=1'b0;
      //if (prevSpecLoad) rT=5'd17;
      //else 
      prT[17]=opcode_main[7] ? 5'd16 : 5'd15;
      pthisSpecLoad[17]=1'b1;
          
      if (magic[1:0]==2'b01) begin
          prB[17]=instr[16:12];
      end else begin
          prB[17]={1'b0,instr[15:12]};
      end
      if (opcode_main[7] && instr[11]) perror[17]=1;          
      
      trien[18]=magic[0] & isBaseIndexSpecLoad;
          pport[18]=PORT_LOAD;
          poperation[18][6:0]={~(magic==4'b0111 && instr[57]),opcode_main[7],instr[11:8],1'b0};
          poperation[18][9:8]=magic[2:0]==3'b111 ? instr[53:52] :( magic[1:0]==2'b01 ? 
            instr[22:21] : instr[24:23]);
          poperation[18][12:10]=3'b0;
          poperation[18][7:6]=2'b0;
          prA_use[18]=~(magic==4'b0111 && instr[57]);
          prT_use[18]=opcode_main[7];
          prT_useF[18]=~opcode_main[7];
          prT_isV[18]=~opcode_main[7] && fop_v({instr[11:8],1'b0});
          puseRs[18]=1'b1;
          prAlloc[18]=1'b1;
          puseBConst[18]=magic==4'b0111 & instr[58];
          if (magic[2:0]!=3'b111) pconstant[18]=(magic[1:0]==2'b11) ? {{9+32{instr[47]}},instr[47:25]} : {{23+32{instr[31]}},instr[31:23]};
          perror[18]=2'b0;
         // if (prevSpecLoad) rT=5'd17;
         // else 
          prT[18]=5'd16;
          pthisSpecLoad[18]=1'b1;
          if (magic==4'b0111) begin 
              prB[18]={instr[55],instr[15:12]};
              prA[18]={instr[56],instr[51:48]};
              perror[18]=0;
          end else if (magic[0]) begin
              prB[18]={instr[21]&&magic[1:0]!=2'b01,instr[15:12]};
              prA[18]={instr[22]&&magic[1:0]!=2'b01,instr[19:16]};
          end else begin
              perror[18]=1;
          end
          if (opcode_main[7] && instr[11]) perror[18]=1;          
          prA_use[18]=~(magic==4'b0111 && instr[57]);
          prB_use[18]=1'b1;
          pisIPRel[18]=1'b0;//magic==4'b0111 && instr[59];
          if (|poperation[18][9:8] && ~poperation[18][6]) perror[18]=1;
          if (magic[2:0]==3'b111 && instr[59] && ~instr[58]) perror[18]=1;
          if (magic[2:0]==3'b111 && instr[63:60]!=0) perror[18]=1;
          if (opcode_main[7] && instr[11]) perror[18]=1'b1;          
          if (riscmove) perror[18]=1'b1;

      
      trien[19]=magic[1:0]==2'b11 && isImmLoadStore;
      pport[19]=opcode_main[0] ? PORT_STORE : PORT_LOAD;
      if (opcode_main[7:1]==7'b1011000 && instr[10])
          poperation[19][5:0]=6'd22;
      else
          poperation[19][5:0]=( opcode_main[7:1]==7'b1011000) ? 
          {2'b10,instr[10:8],opcode_main[0]} : {1'b0,instr[11:8],opcode_main[0]};
      poperation[19][12:6]=7'b0;
      pisIPRel[19]=1'b1;
      prA_use[19]=1'b0;
      prB_use[19]=1'b1;
      prT_use[19]=~opcode_main[0] && opcode_main[7:1]==7'b1011000 && ~instr[10];
      prC_use[19]=opcode_main[0] && opcode_main[7:1]==7'b1011000;
      prT_useF[19]=~opcode_main[0] && opcode_main[7:1]!=7'b1011000;
      prC_useF[19]=opcode_main[0] && opcode_main[7:1]!=7'b1011000;
      prT_isV[19]=~opcode_main[0] && opcode_main[7:1]!=7'b1011000 && fop_v({instr[11:8],1'b0});
      puseRs[19]=1'b1;
      prAlloc[19]=~opcode_main[0] && !(opcode_main[7:1]==7'b1011000 && instr[10]);
      puseBConst[19]=1'b1;
      //if (magic[3]) perror[19]=2'b0;
      if (opcode_main[0]) begin
          if (magic[1:0]==2'b01) prC[19]=instr[16:12];
          else prC[19]={opcode_main[7:1]==7'b1011000 ? instr[11] : instr[1],instr[15:12]};
       //   if (prevSpecAlu) rC=6'd16;
      end else begin
          if (magic[1:0]==2'b01) prT[19]=instr[16:12];
          else prT[19]={opcode_main[7:1]==7'b1011000 ? instr[11] : instr[1],instr[15:12]};
          if (prT[19]==5'd16 && opcode_main[7:0]==8'b10110000) begin
              prT[19]=5'd16;
              pthisSpecLoad[19]=1'b1;
          end
          if (prT[19]==5'd15 && opcode_main[7:0]!=8'b10110000) begin
              prT[19]=5'd15;
              pthisSpecLoad[19]=1'b1;
          end
      end
      if (opcode_main[0] && (opcode_main[7:1]==7'b1011000 && instr[10]))
          perror[19]=2'b1;
          
      if (magic[1:0]==2'b01 && instr[17]) perror[19]=1;
      
      trien[20]=magic[0] & isBasicCJump;
      puseBConst[20]=magic[1:0]!=2'b01 && instr[18];
      poperation[20][7:0]=opcode_main[0] ? `op_sub32 : `op_sub64;
      poperation[20][12:8]=5'b0;
      pflags_write[20]=1'b1;
      prA_use[20]=1'b1;
      prB_use[20]=1'b1;
      prT_use[20]=1'b0;
      puseRs[20]=1'b1;
      prAlloc[20]=1'b1;
      if (magic[1:0]!=2'b01) pconstant[20]={{51{instr[31]}},instr[31:19]};
         // flags_use=1'b1;          
      pport[20]=PORT_ALU;
          
      prA[20]={instr[17],instr[11:8]};
      prB[20]={instr[16],instr[15:12]};
      prT[20]=5'd31;
      pjumpType[20]={1'b0,(magic[1:0]==2'b01) ? instr[18] : instr[32],opcode_main[3:1]};  
      if (puseBConst[20] && prB[20]!=0) perror[20]=1;

      trien[21]=magic[0] & isLongCondJump;
      puseRs[21]=1'b0;
      pjumpType[21]={1'b0,instr[11:8]};
      pconstant[21][0]=1'b0;
      pflags_use[21]=1'b1;
      if (magic[1:0]==2'b01) begin
          pconstant[21]={{43{instr[31]}},instr[31:12],1'b0};
      end else if (~magic[0]) begin
          perror[21]=1;
      end 
      
      trien[22]=magic[0] & isSelfTestCJump;
          //warning: if magic is 0 then error
      pport[22]=PORT_ALU;
      puseBConst[22]=1'b0;
      poperation[22][7:0]=opcode_main[0] ? `op_and32 : `op_and64;
      poperation[22][12:8]=5'b0;
      pflags_write[22]=1'b1;
      prA_use[22]=1'b1;
      prB_use[22]=1'b1;
      prT_use[22]=1'b0;
      puseRs[22]=1'b1;
      prAlloc[22]=1'b1;
      pjumpType[22]={1'b0,instr[11:8]};
      pflags_use[22]=1'b1;
          
      prA[22]={instr[16],instr[15:12]};
      prB[22]={instr[16],instr[15:12]};
      
      trien[23]=magic[0] & isUncondJump;
      puseRs[23]=1'b0;
      pjumpType[23]=5'b10000;
      /*pconstant[23][0]=1'b0;
      if (magic[1:0]==2'b01) begin
          pconstant[23]={{39{instr[31]}},instr[31:8],1'b0};
      end else if (~magic[0]) begin
          pconstant[23]={{55{instr[15]}},instr[15:8],1'b0};
      end */
      
      trien[24]=magic[0] & isIndirJump;
      pport[24]=PORT_MUL;
      prB[24]=instr[12:8];
      prB_use[24]=1'b1;
      prT_use[24]=1'b0;
      puseRs[24]=1'b1;
      prAlloc[24]=1'b1;
      poperation[24][7:0]=mode64 ? `op_mov64 : `op_mov32;
      poperation[24][12]=1'b1;
      if (magic[0]) perror[24]=1;
      pjumpType[24]=5'b10001;
      
      trien[25]=magic[0] && isCall|isCallPrep|isRet;
      if (isCall) begin
          pport[25]=PORT_STORE; //warning: need indirect call
          prB[25]=REG_SP;
          prB_use[25]=1'b1;
          prC_use[25]=1'b1;
          puseRs[25]=1'b1;
          prAlloc[25]=1'b0;
          puseCRet[25]=1'b1;
          pisIPRel[25]=1'b1;
            //  useBSmall=1'b1;
          poperation[25]=mode64 ? {9'b0,`mop_int64,1'b1} : {9'b0,`mop_int32,1'b1};
          prC[25]=instr[12:8];
          pconstant[25]=64'b0;
          pjumpType[25]=5'b10000;
      end else if (isCallPrep) begin
        //  ppushCallStack[25]=1'b1;
          pport[25]=PORT_ALU;
          puseBConst[25]=1'b1;
          prB_use[25]=1'b1;
          prA_use[25]=1'b0;
          prT_use[25]=1'b1;
          pisIPRel[25]=1'b1;
          pconstant[25]={{47{instr[31]}},instr[31:16],1'b0};
          prT[25]=instr[12:8];
          poperation[25][7:0]=mode64 ? `op_add64 : `op_add32;
          puseRs[25]=1'b1;
          poperation[25][12]=1'b1;
      end else begin 
          pport[25]=PORT_MUL;
          prB[25]=instr[12:8];
          prB_use[25]=1'b1;
          prT_use[25]=1'b0;
          puseRs[25]=1'b1;
          prAlloc[25]=1'b1;
        //  ppopCallStack[25]=1'b1;
          poperation[25]=mode64 ? `op_mov64 : `op_mov32;
          poperation[25][12]=1'b1;
          pjumpType[25]=5'b10001;
      end

      trien[26]=magic[0] && isMovOrExtB && ~isMovOrExtExcept;
      puseBConst[26]=(magic[1:0]==2'b11 || (magic[1:0]==2'b01 && instr[31]));
      pport[26]=PORT_ALU;
      prA_use[26]=opcode_main==8'd186||opcode_main==8'd185;
      prB_use[26]=1'b1;
      prT_use[26]=1'b1;
      puseRs[26]=1'b1;
      prAlloc[26]=1'b1;
      if (magic[3:0]==4'hf && opcode_main==8'd183) perror[26]=0;
      poperation[26][12]=1'b1;
      //verilator lint_off CASEINCOMPLETE
      case(opcode_main)
      8'd183: poperation[26][7:0]=`op_mov64;
      8'd184: poperation[26][7:0]=`op_mov32;
      8'd185: poperation[26][7:0]=`op_mov16;
      8'd186: poperation[26][7:0]=`op_mov8;
      8'd187: poperation[26][7:0]=`op_zxt8_64;
      8'd189: poperation[26][7:0]=`op_sxt8_32;
      endcase
      //verilator lint_on CASEINCOMPLETE
      if (magic[3:0]==4'hf) pconstant[26]=instr[79:16]; 
      if (magic[1:0]==2'b01) begin
          prA[26]={instr[17],instr[11:8]};
          prT[26]={instr[17],instr[11:8]};
          prB[26]=instr[16:12];
          pconstant[26]={{51{instr[30]}},instr[30:18]};
	  if (!instr[31]) begin
	      prTE[26]=instr[18];
	      prBE[26]=instr[19];
	  end
          if (opcode_main[7:0]==8'd186) begin
              poperation[26][8]=instr[30];//rT
              poperation[26][9]=instr[28]^instr[30];
              poperation[26][10]=instr[29];//rB
          end                  
      end else  begin
          prA[26]=instr[12:8];
          prT[26]=instr[12:8];
          prB[26]=5'd31;
	  if (~puseBConst[26]) perror[26]=1;
      end 
      
      trien[27]=magic[0] && isMovOrExtA && ~isMovOrExtExcept;
      pport[27]=PORT_ALU;
      prA_use[27]=1'b0;
      prB_use[27]=1'b1;
      prT_use[27]=1'b1;
      puseRs[27]=1'b1;
      prAlloc[27]=1'b1;
      poperation[27][12]=1'b1;
      //verilator lint_off CASEINCOMPLETE
      case(opcode_main)
      8'd188: poperation[27][7:0]=`op_zxt16_64;
      8'd190: poperation[27][7:0]=`op_sxt16_32;
      8'd191: poperation[27][7:0]=`op_sxt8_64;
      8'd192: poperation[27][7:0]=`op_sxt16_64;
      8'd193: poperation[27][7:0]=`op_sxt32_64;
      endcase
      //verilator lint_on CASEINCOMPLETE
 
      if (magic[1:0]==2'b01) begin
          prA[27]={instr[17],instr[11:8]};
          prT[27]={instr[17],instr[11:8]};
          prB[27]=instr[16:12];
          if (opcode_main[7:1]==7'd93 || opcode_main==8'd191) begin
              poperation[27][8]=instr[30];
              poperation[27][9]=instr[30];
              poperation[27][10]=instr[29];
              if (instr[31]) begin
                  perror[27]=1;
              end
          end                  
      end else  begin
	  perror[27]=2'b1;
      end
       
      trien[28]=magic[0] && isLeaIPRel|isCSet;
      if (isLeaIPRel) begin
          puseBConst[28]=1'b1;
	  pport[28]=PORT_ALU;
	  prB_use[28]=1'b1;
	  prT_use[28]=1'b1;
	  puseRs[28]=1'b1;
	  prAlloc[28]=1'b1;
	  poperation[28][7:0]=`op_add64;
	  poperation[28][12]=1'b1;
	  pisIPRel[28]=1'b1;
	  prT[28]=instr[12:8];
	  if (instr[15:13]!=0) perror[28]=1;
          poperation[28][12]=1'b1;
          //WARNING: loads IP only; no offset
      end else begin
          poperation[28][7:0]=instr[12] ? `op_csetn : `op_cset;
          poperation[28][10:8]=instr[15:13];
          poperation[28][12]=1'b1;
          pport[28]=PORT_ALU;
          puseRs[28]=1'b1;
          prAlloc[28]=1'b1;
          prT_use[28]=1'b1;
          pflags_use[28]=1'b1;
          if (magic[1:0]==2'b01) prT[28]={instr[17],instr[11:8]};
          //else if (~magic[0]) rT=instr[11:8];
          else perror[28]=1;
      end
      
      trien[29]=magic[0] & isBasicAddNoFl;
          //if no magic, it's register-register
      puseBConst[29]=magic[2:0]==3'b011;
      poperation[29][11:0]=opcode_main[0] ? `op_add64 : `op_add32;
      poperation[29][12]=1'b1;
      pport[29]=PORT_ALU;
      prA_use[29]=1'b1;
      prB_use[29]=1'b1;
      prT_use[29]=1'b1;
      puseRs[29]=1'b1;
      prAlloc[29]=1'b1;
          
      if (magic[0]) begin
          if (magic[1:0]==2'b01) begin
              prA[29]={instr[17],instr[11:8]};
              prT[29]=instr[16:12];
              prB[29]=5'd31;
          end else begin
              prA[29]={1'b0,instr[11:8]};
              prT[29]={1'b0,instr[15:12]};
              prB[29]=5'd31;
          end
      end else begin
          if (~prevSpecLoad) begin
              prA[29]={1'b0,instr[15:12]};
              prT[29]={1'b0,instr[15:12]};
              prB[29]={1'b0,instr[11:8]};
          end else begin
              prA[29]={1'b0,instr[11:8]};
              prT[29]={1'b0,instr[15:12]};
              prB[29]=5'd16;
          end
      end
      //    if (rT==6'd16) thisSpecAlu=1'b1;
      
      trien[30]=magic[0] && isBasicMUL && ~isBasicALUExcept;
      pport[30]=PORT_MUL;
      prA_use[30]=1'b1;
      prB_use[30]=1'b1;
      prT_use[30]=1'b1;
      puseRs[30]=1'b1;
      prAlloc[30]=1'b1;
      puseBConst[30]=opcode_main[0];
      case({opcode_main[6:3],opcode_main[1]})
	      0: poperation[30]=`op_mul32;
	      1: poperation[30]=`op_mul32_64;
	      2: poperation[30]=`op_mul64;
	      3: poperation[30]=`op_lmul64;
	      4: poperation[30]=`op_imul32;
	      5: poperation[30]=`op_imul32_64;
	      6: poperation[30]=`op_imul64;
	      7: poperation[30]=`op_limul64;
	      8: begin poperation[30]=`op_enptr; pport[30]=PORT_ALU; prB_use[30]=1'b0; end
	      9: begin poperation[30]=`op_unptr; pport[30]=PORT_ALU; prB_use[30]=1'b0; end
	      default: perror[30]=2'b1;
      endcase
      if (opcode_main[0]) begin
           if (magic[1:0]==2'b01) begin
               prA[30]={instr[17],instr[11:8]};
               prT[30]=instr[16:12];
               prB[30]=5'd31;
           end else if (magic[3:0]==4'b0111) begin
               prA[30]={instr[48],instr[11:8]};
               prT[30]={instr[49],instr[15:12]};
               prB[30]=5'd31;
               perror[30]=0;
           end else begin
               prA[30]={1'b0,instr[11:8]};
               prT[30]={1'b0,instr[15:12]};
               prB[30]=5'd31;
           end
      end else begin
           if (magic[1:0]==2'b01) begin
               prA[30]={instr[17],instr[11:8]};
               prT[30]=instr[16:12];
               prB[30]=instr[22:18];
           end else begin
               perror[30]=1;
           end
      end
	  
      trien[31]=magic[0] & (isJalR|isCexALU);
      if (isCexALU) begin
          pport[31]=PORT_ALU;
	  if (instr[12]) pport[31]=PORT_MUL;
	  else if (instr[10])
	      pport[31]=PORT_SHIFT;
	  prA_use[31]=1'b1;
	  prB_use[31]=1'b1;
	  prT_use[31]=1'b1;
	  puseBConst[31]=magic[1:0]==2'b11 || instr[23];
	  pconstant[31]=magic[2] ? {{32{instr[47]}},instr[47:16]} : {{39{instr[47]}},instr[47:23]};
	  puseRs[31]=1'b1;
	  prAlloc[31]=1'b1;
	  pflags_write[31]=1'b0;
	  poperation[31][12]=1'b1;
	  poperation[31][7:0]={3'b0,instr[10:8],instr[12:11]};
	  if (magic[1:0]==2'b01) begin
	      prA[31]=instr[22:18];
	      prB[31]=instr[28:24];
	      prT[31]=instr[22:18];
	      palucond[31]={1'b1,instr[17:14]};
	      poperation[31][8]=instr[13];
	      pconstant[31]={{56{instr[31]}},instr[31:24]};
	  end else if (magic[2]) begin
	      prA[31]=instr[52:48];
	      prT[31]=instr[52:48];
	      palucond[31]={1'b1,instr[56:53]};
	      poperation[31][8]=instr[13];
	  end else begin
	      palucond[31]={1'b1,instr[17:14]};
	      poperation[31][8]=instr[13];
              prA[31]=instr[22:18];
	      prT[31]=instr[22:18];
	  end
      end else if (opcode_main==8'd123) begin//shladd
          pport[31]=PORT_ALU;
          prA_use[31]=1'b1;
          prB_use[31]=opcode_main!=8'd213;
          prT_use[31]=1'b1;
          puseRs[31]=1'b1;
          prAlloc[31]=1'b1;
          puseBConst[31]=1'b0;
          prA[31]={instr[17],instr[11:8]};
          prT[31]={instr[16],instr[15:12]};
          prB[31]=instr[22:18];
          pflags_write[31]=instr[23];
          poperation[31][10:8]=instr[21:19];
          poperation[31][0]=instr[18];
          poperation[31][7:1]=instr[22] ? 7'd5 : 7'd7;
          poperation[31][12]=~instr[23];
          perror[31]={1'b0,instr[31:24]==8'd0};
          if (magic[1:0]!=2'b01) perror[31]=2'b1;
      end else begin//sxadd
          pport[31]=PORT_ALU;
          prA_use[31]=1'b1;
          prB_use[31]=1'b1;
          prT_use[31]=1'b1;
          puseRs[31]=1'b1;
          prAlloc[31]=1'b1;
          puseBConst[31]=opcode_main[0];
          prA[31]={instr[17],instr[11:8]};
          prT[31]={instr[16],instr[15:12]};
          prB[31]=instr[22:18];
          poperation[31][7:0]=opcode_main[7:1]==7'd107 ? `op_add64 : `op_sub64;
          poperation[31][12]=1'b1;
	  poperation[31][8]=1'b1;
          if (magic[1:0]!=2'b01) perror[31]=2'b1;
      end
 
      trien[32]=magic[0] & isSimdInt;
      puseRs[32]=1'b1;
      prA_useF[32]=1'b1;
      prB_useF[32]=1'b1;
      prT_useF[32]=1'b1;
      prA_isV[32]=1'b1;
      prB_isV[32]=1'b1;
      prT_isV[32]=1'b1;
      prAlloc[32]=1'b1;
      if ((instr[13:11]==3'd0 || instr[13:8]==6'd8 || instr[13:8]==6'd9) & ~instr[16]) begin
          //add(s) sub(s) min max
          pport[32]=(instr[13:9]==5'b0) ? PORT_VADD : PORT_VCMP;
          poperation[32][5:0]=instr[13:8];
          poperation[32][7:6]=instr[15:14];
          prA[32]=instr[21:17];
          prB[32]=instr[26:22]; 
          prT[32]=instr[31:27];
      end else if (instr[13:12]==2'b1 && ~instr[16]) begin
          pport[32]=PORT_VCMP;
          poperation[32][5:0]=`simd_cmp;
          poperation[32][7:6]=instr[15:14];
          {poperation[32][12],poperation[32][10:8]}=instr[11:8]; //compare criterion
          prA[32]=instr[21:17];
          prB[32]=instr[26:22];
          prT[32]=instr[31:27];
      end else if ((instr[13:8]==6'd10 || instr[13:8]==6'd11) & ~instr[16]) begin
          //bitwise
          pport[32]=PORT_VADD;
          poperation[32][7:0]=(instr[13:8]==6'd10) ? {6'b100,instr[15:14]} : {6'b101,instr[15:14]};
          prA[32]=instr[21:17];
          prB[32]=instr[26:22];
          prT[32]=instr[31:27];
	  if (instr[15:14]==2'd3) prA_useF[32]=0;
	  if (instr[15:14]==2'd3 && instr[21:17]!=0) perror[32]=1;
      end else if ((instr[13:9]==5'b0 || instr[13:8]==6'b10) & instr[16]) begin
          pport[32]=PORT_VCMP;
          poperation[32][5:0]=(instr[13:8]==6'b10) ? 6'd11 : {5'd6,instr[8]};
          poperation[32][6]=instr[14];
          perror[32]={1'b0,instr[15]}; //no 32and 64 bit shift for now
          prA[32]=instr[21:17];
          prB[32]=instr[26:22];
          prT[32]=instr[31:27];
      end else if (instr[13:8]==6'b11 & instr[16]) begin
          // rA_isAnyV=1'b1;
          prA_useF[32]=1'b0;
          prBT_copyV[32]=1'b1;
          pport[32]=PORT_VANY;
          perror[32]={1'b0,instr[15:14]!=2'b0}; 
          prA[32]=instr[21:17];
          prB[32]=instr[26:22];
          prT[32]=instr[31:27];
          poperation[32][7:0]=8'hff;//mov 128 bit untyped
	  if (instr[21:17]!=0) perror[32]=1;
      end
      if (magic[2:0]==3'b011) begin
          prAX[32]=instr[32]; if (instr[32]) prA[32][4:1]=4'b0;
	  prBE[32]=instr[33]; if (instr[33]) prB[32][4:1]=4'b0;
	  prTE[32]=instr[34]; if (instr[34]) prT[32][4:1]=4'b0;
	  palucond[32]=instr[39:35];
	  prndmode[32]=instr[42:40];
	  //prndmod[33]=instr[42:0]
      end else if (magic[1:0]!=2'b01) begin
	  perror[32]=1;
      end
      
      trien[33]=magic[0] & isBasicFPUScalarA;
      puseRs[33]=1'b1;
      if (magic[2:0]==3'b011) begin
          prAX[33]=instr[32]; if (instr[32]) prA[33][4:1]=4'b0;
	  prBE[33]=instr[33]; if (instr[33]) prB[33][4:1]=4'b0;
	  prTE[33]=instr[34]; if (instr[34]) prT[33][4:1]=4'b0;
	  palucond[33]=instr[39:35];
	  prndmode[33]=instr[42:40];
	  //prndmod[33]=instr[42:0]
      end else if (magic[1:0]!=2'b01) begin
	  perror[33]=1;
      end
      prA[33]=instr[21:17];
      prB[33]=instr[26:22];
      prT[33]=instr[31:27];
      prT_useF[33]=1'b1;
      prA_useF[33]=1'b1;
      prB_useF[33]=1'b1;
      prAlloc[33]=1'b1;
      if (poperation[33][7:0]!=`fop_mulDL && poperation[33][7:0]!=`fop_mulDH && poperation[33][7:0]!=`fop_mulDP && |instr[15:14]) begin
         {poperation[33][12],poperation[33][9:8]}=instr[16:14];
      end else begin
         {poperation[33][10],poperation[33][9:8]}=instr[16:14];
         if (instr[16] && poperation[33][7:0]!=`fop_mulDL && poperation[33][7:0]!=`fop_mulDH && poperation[33][7:0]!=`fop_mulDP)
             poperation[33][9:8]=2'b11;
      end
      case(instr[13:8])
          6'd0: begin poperation[33][7:0]=`fop_addDH; pport[33]=PORT_FADD; end
          6'd1: begin poperation[33][7:0]=`fop_addDL; pport[33]=PORT_FADD; end
          6'd2: begin poperation[33][7:0]=`fop_subDH; pport[33]=PORT_FADD; end
          6'd3: begin poperation[33][7:0]=`fop_subDL; pport[33]=PORT_FADD; end
          6'd4: begin poperation[33][7:0]=`fop_mulDH; perror[33]={1'b0,perror[33]|instr[16]}; pport[33]=PORT_FMUL; end
          6'd5: begin poperation[33][7:0]=`fop_mulDL; pport[33]=PORT_FMUL; end
          6'd6: begin poperation[33][7:0]=`fop_addDP; pport[33]=PORT_FADD; end
          6'd7: begin poperation[33][7:0]=`fop_subDP; pport[33]=PORT_FADD; end
          6'd8: begin poperation[33][7:0]=`fop_mulDP; perror[33]={1'b0,perror[33]|instr[16]}; pport[33]=PORT_FMUL; end
          6'd9: begin poperation[33][7:0]=`fop_addsubDP; pport[33]=PORT_FADD; end
          default: perror[33]=1;
      endcase
      
      trien[34]=magic[0] & isBasicFPUScalarB;
      puseRs[34]=1'b1;
      prA[34]=instr[21:17];
      prB[34]=instr[26:22];
      prT[34]=instr[31:27];
      if (magic[2:0]==3'b011) begin
          prAX[34]=instr[32]; if (instr[32]) prA[34][4:1]=4'b0;
	  prBE[34]=instr[33]; if (instr[33]) prB[34][4:1]=4'b0;
	  prTE[34]=instr[34]; if (instr[34]) prT[34][4:1]=4'b0;
	  palucond[34]=instr[39:35];
	  prndmode[34]=instr[42:40];
	  //prndmod[33]=instr[42:0]
      end else if (magic[1:0]!=2'b01) begin
	  perror[34]=1;
      end
      prT_useF[34]=1'b1;
      prA_useF[34]=1'b1;
      prB_useF[34]=1'b1;
      prAlloc[34]=1'b1;
      {poperation[34][10],poperation[34][9:8]}=instr[16:14];
      case(instr[13:8])
          6'd16: begin poperation[34][7:0]=`fop_addS; pport[34]=PORT_FADD; end
          6'd17: begin poperation[34][7:0]=`fop_subS; pport[34]=PORT_FADD; end
          6'd18: begin poperation[34][7:0]=`fop_mulS; pport[34]=PORT_FMUL; end
          6'd19: begin poperation[34][7:0]=`fop_addSP; pport[34]=PORT_FADD; end
          6'd20: begin poperation[34][7:0]=`fop_subSP; pport[34]=PORT_FADD; end
          6'd21: begin poperation[34][7:0]=`fop_mulSP; pport[34]=PORT_FMUL; end
          6'd22: begin poperation[34][7:0]=`fop_addEE; pport[34]=PORT_FADD; 
                 prA[34]=rA_reor32; prB[34]=rB_reor32; prT[34]=rT_reor32; end
          6'd23: begin poperation[34][7:0]=`fop_subEE; pport[34]=PORT_FADD;
                 prA[34]=rA_reor32; prB[34]=rB_reor32; prT[34]=rT_reor32; end
          6'd24: begin poperation[34][7:0]=`fop_mulEE; pport[34]=PORT_FADD; 
                 prA[34]=rA_reor32; prB[34]=rB_reor32; prT[34]=rT_reor32; end
          6'd26,6'd27: begin 
	      poperation[34][7:0]=`fop_permDS; 
	      pport[34]=PORT_FANY; 
	      poperation[34][12]=instr[8];
                 end
          default: perror[34]=1;
      endcase
      
      trien[35]=(magic[0] && isBasicSysInstr);
         // if (instr[15:8]==8'hff && ~magic[0]) halt=1'b1;
      if (instr[15:13]==3'b0) begin //write CSR
        // constant=instr[31:16];
          prB_use[35]=1'b1;
          puseBConst[35]=1'b0;
          pport[35]=PORT_MUL;
          prA_use[35]=1'b0;
          prB[35]=instr[12:8];            
          poperation[35]=mode64 ? `op_mov64 : `op_mov32;
          puseRs[35]=1'b1;
          pjumpType[35]=5'b11001;
          poperation[35][12]=1'b1;
          perror[35]={2{~can_write_csr}};
      end else if (instr[15:13]==3'd1) begin //read_CSR
          puseRs[35]=1'b1;
          prB_use[35]=1'b1;
          puseBConst[35]=1'b1;
          prT_use[35]=1'b1;
          prT[35]=instr[12:8];
          poperation[35]=mode64 ? `op_mov64 : `op_mov32;
          pport[35]=PORT_ALU;
          poperation[35][12]=1'b1;
          prAlloc[35]=1'b1;
          perror[35]={2{~can_read_csr}};
	  //pconstant[35]=instr[79:16];
      end else if (instr[15:13]==3'd2) begin //iret
          puseRs[35]=1'b1;
          prB_use[35]=1'b1;
          puseBConst[35]=1'b1;
          prT_use[35]=1'b0;
          if (instr[12:8]!=0 || ~ can_jump_csr) perror[35]=1;
          poperation[35]=mode64 ? `op_mov64 : `op_mov32;
          pport[35]=PORT_MUL;
          poperation[35][12]=1'b1;
          prAlloc[35]=1'b1;
          pjumpType[35]=5'b10001;
	  //pconstant[35]=instr[79:16];
	  csrss_retIP_en=!(instr[31:16]==`csr_retIP);
          perror[35]={2{~can_jump_csr}};
      end
      
      trien[36]=magic[0] & isBasicFPUScalarC;
      puseRs[36]=1'b1;
      if (magic[1:0]!=2'b01) perror[36]=1;
      prA[36]=instr[21:17];
      prB[36]=instr[26:22];
      prT[36]=instr[31:27];
      if (magic[2:0]==3'b011) begin
          prAX[36]=instr[32]; if (instr[32]) prA[36][4:1]=4'b0;
	  prBE[36]=instr[33]; if (instr[33]) prB[36][4:1]=4'b0;
	  prTE[36]=instr[34]; if (instr[34]) prT[36][4:1]=4'b0;
	  palucond[36]=instr[39:35];
	  prndmode[36]=instr[42:40];
	  //prndmod[33]=instr[42:0]
      end else if (magic[1:0]!=2'b01) begin
	  perror[36]=1;
      end
      prT_useF[36]=1'b1;
      prA_useF[36]=1'b1;
      prB_useF[36]=1'b1;
      prAlloc[36]=1'b1;
      {poperation[36][11],poperation[36][9:8]}={1'b1,{2{instr[16]}}};
      if (instr[15:14]!=0) perror[36]=1;
      case(instr[13:8])
          6'd32: begin poperation[36][7:0]=`fop_forkL; pport[36]=PORT_FADD; prB_useF[36]=1'b0; end
          6'd33: begin poperation[36][7:0]=`fop_forkH; pport[36]=PORT_FADD; prB_useF[36]=1'b0; end
          6'd34: begin poperation[36][7:0]=`fop_divDH; pport[36]=PORT_FMUL; end
          6'd35: begin poperation[36][7:0]=`fop_divDL; pport[36]=PORT_FMUL; end
          6'd36: begin poperation[36][7:0]=`fop_sqrtE; pport[36]=PORT_FMUL; prB_useF[36]=1'b0; 
                 prA[34]=rA_reor32; prB[34]=rB_reor32; prT[34]=rT_reor32; end
          6'd37: begin poperation[36][7:0]=`fop_divE; pport[36]=PORT_FMUL; 
                 prA[34]=rA_reor32; prB[34]=rB_reor32; prT[34]=rT_reor32; end
          6'd38: begin poperation[36][7:0]=`fop_sqrtS; pport[36]=PORT_FMUL; prB_useF[36]=1'b0; end
          6'd39: begin poperation[36][7:0]=`fop_divS; pport[36]=PORT_FMUL; end
	  6'd40,6'd41,6'd42,6'd43: begin poperation[36][7:0]=`fop_logic; poperation[36][1:0]=instr[9:8]; 
	     pport[36]=PORT_FADD; poperation[36][10:8]={instr[16],2'b0}; end 
          default: perror[36]=1;
      endcase
      
      trien[37]=magic[0] & isBasicFPUScalarCmp;
      puseRs[37]=1'b1;
      if (magic[1:0]!=2'b01) perror[37]=1;
      prA[37]=instr[21:17];
      prB[37]=instr[26:22];
      prT[37]=instr[31:27];
      if (magic[2:0]==3'b011) begin
          prAX[37]=instr[32]; if (instr[32]) prA[37][4:1]=4'b0;
	  prBE[37]=instr[33]; if (instr[33]) prB[37][4:1]=4'b0;
	  prTE[37]=instr[34]; if (instr[34]) prT[37][4:1]=4'b0;
	  palucond[37]=instr[39:35];
	  //prndmod[33]=instr[42:0]
      end else if (magic[1:0]!=2'b01) begin
	  perror[36]=1;
      end
      prT_useF[37]=1'b0;
      prA_useF[37]=1'b1;
      prB_useF[37]=1'b1;
      prAlloc[37]=1'b1;
      pflags_write[37]=1'b1;
      poperation[37][9:8]={2{instr[16]}};
      poperation[37][10]=instr[10]; //lin search
      case(instr[13:8])
          6'd32,6'd36: begin poperation[37][7:0]=`fop_cmpDH; pport[37]=PORT_FADD; end
          6'd33,6'd37: begin poperation[37][7:0]=`fop_cmpDL; pport[37]=PORT_FADD; end
          6'd34,6'd38: begin poperation[37][7:0]=`fop_cmpE; pport[37]=PORT_FADD; prA[37]=rA_reor32; prB[37]=rB_reor32; end
          6'd35,6'd39: begin poperation[37][7:0]=`fop_cmpS; pport[37]=PORT_FADD; end
	  6'd40: begin poperation[37][7:0]=`fop_tblD; pport[37]=PORT_MUL; prA_useF[37]=1'b0; prT_use[37]=1'b1; end
	  6'd41: begin poperation[37][7:0]=`fop_cvtD; pport[37]=PORT_MUL; prA_useF[37]=1'b0; prT_use[37]=1'b1; end
	  6'd42: begin poperation[37][7:0]=`fop_cvt32D; pport[37]=PORT_MUL; prA_useF[37]=1'b0; prT_use[37]=1'b1; end
	  6'd43: begin poperation[37][7:0]=`fop_cvtE; pport[37]=PORT_MUL; prA_useF[37]=1'b0; prT_use[37]=1'b1;
	      prB[37]=rB_reor32; end
	  6'd44: begin poperation[37][7:0]=`fop_cvtS; pport[37]=PORT_MUL; prA_useF[37]=1'b0; prT_use[37]=1'b1; end
	  6'd45: begin poperation[37][7:0]=`fop_cvt32S; pport[37]=PORT_MUL; prA_useF[37]=1'b0; prT_use[37]=1'b1; end
          default: perror[37]=1;
      endcase
      //flags_write=~operation[12] & useRs || flags_wrFPU;
      trien[38]=magic[0] & isBasicFPUScalarCmp2;
      puseRs[38]=1'b1;
      if (magic[1:0]!=2'b01) perror[38]=1;
      prA[38]=instr[21:17];
      prB[38]=instr[26:22];
      prT_useF[38]=1'b1;
      prT[38]=instr[31:27];
      if (magic[2:0]==3'b011) begin
          prAX[38]=instr[32]; if (instr[32]) prA[38][4:1]=4'b0;
	  prBE[38]=instr[33]; if (instr[33]) prB[38][4:1]=4'b0;
	  prTE[38]=instr[34]; if (instr[34]) prT[38][4:1]=4'b0;
	  palucond[38]=instr[39:35];
	  //prndmod[33]=instr[42:0]
      end else if (magic[1:0]!=2'b01) begin
	  perror[38]=1;
      end
      prA_useF[38]=1'b1;
      prB_useF[38]=1'b1;
      prAlloc[38]=1'b1;
      pflags_write[38]=1'b1;
      poperation[38][10]=instr[16]; //signed/single
      case(instr[13:8])
	  6'd32: begin poperation[38][7:0]=`fop_pcmplt; pport[38]=PORT_FADD; end
	  6'd33: begin poperation[38][7:0]=`fop_pcmpge; pport[38]=PORT_FADD; end
	  6'd34: begin poperation[38][7:0]=`fop_pcmpeq; pport[38]=PORT_FADD; end
	  6'd35: begin poperation[38][7:0]=`fop_pcmpne; pport[38]=PORT_FADD; end
	  6'd36: begin poperation[38][7:0]=`fop_rndES; pport[38]=PORT_FMUL; 
                 prA[34]=rA_reor32; prB[34]=rB_reor32; prT[34]=rT_reor32; end
	  6'd37: begin poperation[38][7:0]=`fop_rndED; pport[38]=PORT_FMUL; 
                 prA[34]=rA_reor32; prB[34]=rB_reor32; prT[34]=rT_reor32; end
	  6'd38: begin poperation[38][7:0]=`fop_rndDSP; pport[38]=PORT_FMUL; end
	  6'd40: begin poperation[38][7:0]=`op_cvtE; pport[38]=PORT_MUL; pflags_write[38]=1'b0;
	    prA_useF[38]=1'b0; prB_useF[38]=1'b0; prB_use[38]=1'b1; prT[38]=rT_reor32; end
	  6'd41: begin poperation[38][7:0]=`op_cvtD; pport[38]=PORT_MUL; pflags_write[38]=1'b0;
	    prA_useF[38]=1'b0; prB_useF[38]=1'b0; prB_use[38]=1'b1; end
	  6'd42: begin poperation[38][7:0]=`op_cvtS; pport[38]=PORT_MUL; pflags_write[38]=1'b0;
	    prA_useF[38]=1'b0; prB_useF[38]=1'b0; prB_use[38]=1'b1; end
	    //add select instruction single,double
	  default: perror[38]=1;
      endcase
      
      trien[39]=magic[0] & isBasicFPUScalarCmp3;
      puseRs[39]=1'b1;
      if (magic[1:0]!=2'b01) perror[39]=1;
      prA[39]=instr[21:17];
      prB[39]=instr[26:22];
      prT_useF[39]=1'b0;
      prT[39]=instr[31:27];
      if (magic[2:0]==3'b011) begin
          prAX[39]=instr[32]; if (instr[32]) prA[39][4:1]=4'b0;
	  prBE[39]=instr[33]; if (instr[33]) prB[39][4:1]=4'b0;
	  prTE[39]=instr[34]; if (instr[34]) prT[39][4:1]=4'b0;
	  palucond[39]=instr[39:35];
	  //prndmod[33]=instr[42:0]
      end else if (magic[1:0]!=2'b01) begin
	  perror[39]=1;
      end
      prA_useF[39]=1'b1;
      prB_useF[39]=1'b1;
      prAlloc[39]=1'b1;
      pflags_write[39]=1'b1;
      poperation[39][10]=instr[16]; //signed/single
      case(instr[13:8])
	  6'd32: begin poperation[39][7:0]=`fop_linsrch; pport[39]=PORT_FADD; end
	  6'd33: begin poperation[39][7:0]=`fop_linsrch+1; pport[39]=PORT_FADD; end
	  6'd34: begin poperation[39][7:0]=`fop_linsrch+2; pport[39]=PORT_FADD; end
	  6'd35: begin poperation[39][7:0]=`fop_linsrch+3; pport[39]=PORT_FADD; end
	  6'd36: begin
	      prA_useF[39]=1'b0;
	      prB_useF[39]=1'b0;
	      prT_useF[39]=1'b0;
	      prA_use[39]=1'b1;
	      prB_use[39]=1'b1;
	      prT_use[39]=1'b1;
	      pport[39]=PORT_LOAD;
	      prB[39][4:1]=4'b0;
	      prBE[39]=1'b1;
	      poperation[39][7:0]={2'b01,5'b10001,instr[23]};
	      poperation[39][9:8]={1'b1,instr[24]}; 
	      poperation[39][12:10]=3'b0;
	      pconstant[39]={60'b0,instr[26:25],2'b0};
	      pflags_write[39]=1'b0;
	  end
	  default: perror[39]=1;
      endcase
  end


endmodule

