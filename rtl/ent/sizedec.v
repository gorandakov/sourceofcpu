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
`include "../csrss_no.sv"

module predecoder_class(instr,magic,flag,class_,isLNK,isRet,LNK);
  input [31:0] instr;
  input [3:0] magic;
  input flag;
  output [12:0] class_;
  output isLNK;
  output isRet;
  output [4:0] LNK;

  wire clsIndir;
  wire clsJump;
  wire clsALU;
  wire clsShift;
  wire clsMul;
  wire clsLoad;
  wire clsStore;
  wire clsStore2;
  wire clsFPU;
  wire clsLoadFPU;
  wire clsSys;
  wire clsPos0;
  wire clsFMA;
  
  wire [7:0] opcode_main;

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
  wire subIsBasicXOR;
  wire isBasicXOR;

  
  wire isBasicALU;
  wire isBasicALUExcept;
  wire isBasicShift;
  wire isBasicShiftExcept;
  wire isBasicCmpTest;
//  wire isCmpTestExtra;   
  
  wire isBaseLoadStore;
  wire isBaseIndexLoadStore;
  wire isBaseSpecLoad;
  wire isBaseIndexSpecLoad;
  wire isImmLoadStore;
  wire isBasicMUL;
  wire isImmCISC;
  wire isBaseCISC;
  wire isBaseIndexCISC;
  wire isLeaIPRel;

  wire isBasicCJump;
  wire isInvCJumpLong;
  wire isSelfTestCJump;
  wire isLongCondJump;
  wire isUncondJump;
  
  wire isIndirJump;
  wire isCall;
  
  wire isMovOrExt;
  wire isMovOrExtExcept;
  wire isCmov;
  wire isCSet;
  wire isBasicAddNoFl;
  wire isAddNoFlExtra;
  wire isShiftNoFl;

  wire isCexALU;

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
  
  wire isCallPrep;

  wire [5:0] opcode_sub;
  
  assign subIsBasicALU=(!|opcode_sub[5:4] || opcode_sub[5:2]==4'b0100) & ~magic[0];
  assign subIsBasicShift=(~opcode_sub[5] && ~subIsBasicALU && opcode_sub[0]) & ~magic[0];
  assign subIsFPUE=opcode_sub==6'b010100 && ~magic[0]; 
  assign subIsFPUSngl=((opcode_sub==6'b010110 || opcode_sub==6'b011000) && opcode_main[7:6]!=2'b11) & ~magic[0];
  assign subIsLinkRet=(opcode_sub==6'b010110 || opcode_sub==6'b011000) && opcode_main[7:6]==2'b11 && ~magic[0];
  assign subIsSIMD=(opcode_sub[5:3]==3'b011 && |opcode_sub[2:1] && ~opcode_sub[0]) & ~magic[0];
  assign subIsMovOrExt=(opcode_sub[5:3]==3'b100 || opcode_sub[5:1]==5'b10100) & ~magic[0];
  assign subIsCmpTest=(opcode_sub[5:1]==5'b10101 || opcode_sub[5:2]==4'b1011) & ~magic[0];
  assign subIsCJ=opcode_sub[5:2]==4'b1100 && opcode_main[7:0]!=8'b11110010 && ~magic[0];
  assign subIsFPUD=(opcode_sub[5:2]==4'b1101 || opcode_sub[5:1]==5'b11100) & ~magic[0];
  assign subIsFPUPD=(opcode_sub[5:3]==3'b111 && opcode_sub[5:1]!=5'b11100) & ~magic[0];
  assign subIsBasicXOR=opcode_sub[5:2]==4'b0100;//not a separate class
  assign isBasicXOR=(opcode_main[7:3]==5'b00100) & ~opcode_main[2];//not a seprarate class
  
 
  assign isBasicSysInstr=opcode_main==8'hff&&magic[0]; 

  assign opcode_main=instr[7:0];
  assign opcode_sub=instr[5:0];
  
  
  assign isBasicALU=(!|opcode_main[7:5] || opcode_main[7:3]==5'b00100) & ~opcode_main[2] & magic[0];
  assign isBasicMUL=(!|opcode_main[7:5] || opcode_main[7:3]==5'b00100) & opcode_main[2] & magic[0];
  assign isBasicALUExcept=~opcode_main[0] && (magic[1:0]==2'b01 && |instr[28:23]);  
  assign isBasicShift=(opcode_main[7:1]==7'd20 || opcode_main[7:1]==7'd21 ||
      opcode_main[7:1]==7'd22)&&magic[0];      
  assign isBasicShiftExcept=magic[1:0]==2'b01 && |instr[29:25];
  
  assign isBasicCmpTest=(opcode_main[7:1]==7'd23 || opcode_main[7:2]==6'd12 ||
    opcode_main[7:1]==7'd26 || opcode_main[7:2]==6'd54) && magic[0];

  assign isBaseSpecLoad=(opcode_main==8'd54 || opcode_main==8'd202) && magic[0];
  assign isBaseIndexSpecLoad=(opcode_main==8'd55 || opcode_main==8'd203) && magic[0];
  
  assign isImmLoadStore=((opcode_main[7:2]==6'd15) || opcode_main[7:1]==7'b1011000) & magic[0];  
  assign isBaseCISC=magic[1]==1'b0 ? instr[19:18]!=2'b0 : 1'bz;
  assign isBaseCISC=magic[1]==1'b1 ? instr[17:16]!=2'b0 : 1'bz;
  assign isBaseLoadStore=((opcode_main[7:5]==3'b010 && !isBaseCISC) || opcode_main[7:4]==4'b0110) & magic[0];
  assign isBaseIndexCISC=magic[1]==1'b0 ? instr[24:23]!=0 : 1'bz;
  assign isBaseIndexCISC=magic[2:1]==2'b01 ? instr[26:25]!=0 : 1'bz;
  assign isBaseIndexCISC=magic[2:1]==2'b11 ? instr[17:16]!=0 : 1'bz;
  assign isBaseIndexLoadStore=((opcode_main[7:5]==3'b100 && !isBaseIndexCISC) || opcode_main[7:4]==4'b0111) & magic[0];


  assign isBasicCJump=(opcode_main[7:4]==4'b1010) && magic[0];
  assign isSelfTestCJump=(opcode_main==8'd178 || opcode_main==8'd179) && magic[0];
  assign isLongCondJump=(opcode_main==8'd180) && magic[0];
  assign isUncondJump=(opcode_main==8'd181) && magic[0];
  assign isIndirJump=(opcode_main==8'd182 && instr[15:13]==3'd0) && magic[0];
  assign isCall=(opcode_main==8'd182 && (instr[15:13]==3'd1 || instr[15:13]==3'd2)) && magic[0];
  assign isRet=(opcode_main==8'd182 && instr[15:13]==3'd3) && magic[0];
  assign isMovOrExt=(opcode_main==8'd183 || opcode_main[7:3]==5'b10111 || opcode_main[7:1]==7'd96) && magic[0];
  assign isMovOrExtExcept=magic[1:0]==2'b11 && opcode_main!=8'd183 && opcode_main[7:1]!=7'd92;
  assign isCSet=(opcode_main==8'd194) && magic[0]; 
  assign isBasicAddNoFl=(opcode_main==8'd195 || opcode_main==8'd196) && magic[0];
  
  assign isLeaIPRel=(opcode_main==8'd197) & magic[0];

  assign isCmov=opcode_main==198 && magic[1:0]==2'b01;
  
  
  assign isSimdInt=opcode_main==8'd200 && magic[0];
  assign isFPUreor=opcode_main==8'd201 && magic[0];
  
  assign isShlAddMulLike=(opcode_main==8'd210 || opcode_main==8'd211) && magic[0];
  assign isPtrSec=opcode_main==8'd212 && magic[0];
  assign isJalR=(opcode_main==8'd213 || opcode_main==8'd214 || opcode_main==8'd215 || opcode_main==8'd220 || opcode_main==8'd221) && magic[0];
  assign isCexALU=opcode_main==8'd222 && magic[0];
  
  assign isBasicFPUScalarA=opcode_main==8'hf0 && instr[13:12]==2'b0 && magic[0];
  assign isBasicFPUScalarB=opcode_main==8'hf0 && instr[13:12]==2'b1 && magic[0];
  assign isBasicFPUScalarC=opcode_main==8'hf0 && instr[15:12]==4'd2 && magic[0];
  assign isBasicFPUScalarCmp=opcode_main==8'hf0 && instr[15:12]==4'd6 && magic[0];
  assign isBasicFPUScalarCmp2=opcode_main==8'hf0 && instr[15:12]==4'ha && magic[0];
  assign isBasicFPUScalarCmp3=opcode_main==8'hf0 && instr[15:12]==4'd12;

  assign isCallPrep=(opcode_main==8'd199) && magic[0];
  
  assign clsJump=|{
  isBasicCJump,
  isSelfTestCJump,
  isLongCondJump,
  isUncondJump,
  isIndirJump,
  isCall,
  isRet,
  subIsCJ,
  opcode_main==8'hff && ~instr[15] && ~instr[13] && magic[0]
  };

  assign clsIndir=|{
  isIndirJump,
  isRet,
 // isCall,
  opcode_main==8'hff && ~instr[15] && ~instr[13] && magic[0]
  };

  assign clsFMA=|{
  instr[31:27]==5'd16 && isBasicFPUScalarB && (instr[13:8]==6'd18) | (instr[13:8]==6'd21),
  instr[16] && isBasicFPUScalarB && (instr[13:9]==5'd8) | (instr[13:8]==6'd19) | (isntr[13:8]==6'd20),
  instr[31:27]==5'd16 && isBasicFPUScalarA && (instr[13:9]==5'd2) | (instr[13:8]==6'd8),
  instr[16:14]==3'b100 && isBAsicFPUScalarA && (instr[13:10]==4'd0) | (instr[13:9]==5'd3)};
  
  assign clsALU=|{
  isBasicALU & ~isBasicALUExcept & ~isBasicXOR,
  isCexALU & ~instr[12] & ~instr[10],
  isBasicCmpTest,
  isBasicCJump & magic[0],
  isSelfTestCJump,
  isMovOrExt & ~isMovOrExtExcept,
  isCSet,
  isBasicAddNoFl,
  isCmov,
  isShlAddMulLike,
  isSimdInt & ~instr[16],subIsFPUD & !(opcode_sub[5:1]==5'b11100),
  subIsFPUPD & !(opcode_sub[5:1]==5'b11101), subIsFPUSngl & !(opcode_main[7:6]==2'b0),
  subIsFPUE & !(opcode_main[7:6]==2'b0),
  subIsSIMD,
  isSimdInt && ((instr[13:9]==5'd0 && ~instr[16]) || (instr[13:9]==5'd5 && ~instr[16]) || (instr[13:8]==6'b11 && instr[16])),
  subIsBasicALU & ~subIsBasicXOR,subIsCmpTest,subIsLinkRet,
  opcode_main==8'hff && instr[15:13]==3'd1 && magic[0],
  isBasicFPUScalarA && instr[13:9]!=5'd2 && instr[13:8]!=6'd8,
  isBasicFPUScalarB && instr[13:8]!=6'd18 && instr[13:8]!=6'd21,
  isBasicFPUScalarC && instr[13:8]!=6'd32,
  isBasicFPUScalarCmp && instr[13:11]==3'b100,
  isBasicFPUScalarCmp2 && instr[13:10]==4'b1000,
  isBasicFPUScalarCmp3 && instr[13:10]==4'b1000,
  subIsMovOrExt,
  isLeaIPRel,
  isJalR
  };
  
  assign clsPos0=opcode_main==8'hff && instr[15:13]==3'd1 && magic[0] && instr[31:16]==`csr_FPU;
  
  assign clsShift=isBasicShift & ~isBasicShiftExcept || subIsBasicShift || subIsFPUD & (opcode_sub[5:1]==5'b11100) ||
    isCexALU & ~instr[12] & instr[10] ||
    subIsFPUPD & (opcode_sub[5:1]==5'b11101) || subIsFPUSngl &(opcode_main[7:6]==2'b0)
    || subIsFPUE &(opcode_main[7:6]==2'b0) || isSimdInt & instr[16] ||
    (isSimdInt && ~((instr[13:9]==5'd0 && ~instr[16]) || (instr[13:9]==5'd5 && ~instr[16]) ||
     (instr[13:8]==6'b11 && instr[16]))) || 
    isBasicALU & ~isBasicALUExcept & isBasicXOR ||
    subIsBasicALU & subIsBasicXOR ||
    (isBasicFPUScalarA && ~(instr[13:9]!=5'd2 && instr[13:8]!=6'd8)) ||
    (isBasicFPUScalarB && ~(instr[13:8]!=6'd18 && instr[13:8]!=6'd21));
  
  assign clsLoad=|{
  isBaseLoadStore & ~opcode_main[0],
  isBaseIndexLoadStore & ~opcode_main[0],  
  isBaseSpecLoad,
  isBaseIndexSpecLoad,
  isImmLoadStore && ~opcode_main[0],
  isBasicFPUScalarCmp3 && instr[13:8]==6'b100100//tlb jump table load gen purp
  };

  assign clsStore=|{
  isBaseLoadStore &  opcode_main[0],
  isImmLoadStore && opcode_main[0],
  isBaseIndexLoadStore & opcode_main[0],
  isCall & magic[0]
  };
  
  assign clsStore2=|{
  isBaseLoadStore &  opcode_main[0],
  isImmLoadStore && opcode_main[0],
  isBaseIndexLoadStore & opcode_main[0],
  isCall & magic[0]
  };
  
//  assign clsStore2=isBaseIndexLoadStore & opcode_main[0];

  assign clsLoadFPU=|{
    isBaseLoadStore & ~opcode_main[0] & ~opcode_main[5],
    isBaseIndexLoadStore & ~opcode_main[0] & opcode_main[7:4]!=4'b0111,  
    isBaseSpecLoad & ~opcode_main[7],
    isBaseIndexSpecLoad & ~opcode_main[7],
    isImmLoadStore && ~opcode_main[0] && opcode_main[7:1]!=7'b1011000
  };
  
  assign clsMul=|{
    isBasicMUL,
    isPtrSec,
    isCexALU & instr[12],
    opcode_main==8'hff && ~instr[15] && ~instr[13] && magic[0],
     isBasicFPUScalarC && instr[13:8]==6'd32,

     isBasicFPUScalarCmp && |instr[12:11],
     isBasicFPUScalarCmp2 && |instr[12:10]
  };
  
  assign clsSys=isBasicSysInstr|isFPUreor;
  
  assign clsFPU=isBasicFPUScalarA || isBasicFPUScalarB || isBasicFPUScalarC || subIsFPUD || subIsFPUPD || subIsFPUSngl ||
    subIsFPUE || subIsSIMD;
  assign class_[`iclass_indir]=clsIndir;
  assign class_[`iclass_jump]= clsJump;
  assign class_[`iclass_ALU]= clsALU;
  assign class_[`iclass_shift]= clsShift;
  assign class_[`iclass_mul]= clsMul;
  assign class_[`iclass_load]=clsLoad;
  assign class_[`iclass_store]=clsStore;
  assign class_[`iclass_store2]=clsFMA;
  assign class_[`iclass_FPU]=clsFPU;
  assign class_[`iclass_loadFPU]=clsLoadFPU;
  assign class_[`iclass_sys]=clsSys;
  assign class_[`iclass_flag]=flag;
  assign class_[`iclass_pos0]=clsPos0;
  
  assign LNK=isRet ? 5'h1f : 5'bz;
//  assign LNK=(isCallPrep & ~magic[0]) ? instr[11:8] : 16'bz;
  assign LNK=isCallPrep ? instr[20:16] : 5'bz;
  assign LNK=subIsLinkRet&~opcode_sub[1] ? {1'b0,instr[15:12]} : 5'bz;
  assign LNK=(~isRet & ~isCallPrep & ~(subIsLinkRet&~opcode_sub[1])) ? 5'h1f : 5'bz;
  
  assign isLNK=isRet | isCallPrep | (subIsLinkRet&~opcode_sub[1]);
  
endmodule

module predecoder_get(
    clk,
    rst,
    bundle,btail,bstop,in_bite,
    flag_bits,
    startOff,
    instr0,instr1,instr2,instr3,
    instr4,instr5,instr6,instr7,
    instr8,instr9,instr10,instr11,
    instr12,instr13,instr14,instr15,
    magic0,magic1,magic2,magic3,
    magic4,magic5,magic6,magic7,
    magic8,magic9,magic10,magic11,
    magic12,magic13,magic14,magic15,
    off0,off1,off2,off3,
    off4,off5,off6,off7,
    off8,off9,off10,off11,
    off12,off13,off14,off15,
    class0,class1,class2,class3,
    class4,class5,class6,class7,
    class8,class9,class10,class11,
    class12,class13,class14,class15,
    instrEn,
    isAvx,
    hasJumps,
    error,
    jerror,
    jsplit_pos,
    Jinstr0,Jinstr1,Jinstr2,Jinstr3,
    Jmagic0,Jmagic1,Jmagic2,Jmagic3,
    Joff0,Joff1,Joff2,Joff3,
    Jclass0,Jclass1,Jclass2,Jclass3,
    Jen,
    lnkLink0,lnkOff0,lnkMagic0,lnkRet0,lnkJumps0,
    lnkLink1,lnkOff1,lnkMagic1,lnkRet1,lnkJumps1,
    lnkLink2,lnkOff2,lnkMagic2,lnkRet2,lnkJumps2,
    lnkLink3,lnkOff3,lnkMagic3,lnkRet3,lnkJumps3
    );
    localparam CLSWIDTH=12;
    
    input clk;
    input rst;
    input [255:0] bundle;
    input [63:0] btail;
    input [3:0] bstop;
    input in_bite;
    input [15:0] flag_bits;
    input [3:0] startOff;
    output [79:0] instr0;
    output [79:0] instr1;
    output [79:0] instr2;
    output [79:0] instr3;
    output [79:0] instr4;
    output [79:0] instr5;
    output [79:0] instr6;
    output [79:0] instr7;
    output [79:0] instr8;
    output [79:0] instr9;
    output [79:0] instr10;
    output [79:0] instr11;
    output [79:0] instr12;
    output [79:0] instr13;
    output [79:0] instr14;
    output [79:0] instr15;

    output [3:0] magic0;
    output [3:0] magic1;
    output [3:0] magic2;
    output [3:0] magic3;
    output [3:0] magic4;
    output [3:0] magic5;
    output [3:0] magic6;
    output [3:0] magic7;
    output [3:0] magic8;
    output [3:0] magic9;
    output [3:0] magic10;
    output [3:0] magic11;
    output [3:0] magic12;
    output [3:0] magic13;
    output [3:0] magic14;
    output [3:0] magic15;

    output [3:0] off0;
    output [3:0] off1;
    output [3:0] off2;
    output [3:0] off3;
    output [3:0] off4;
    output [3:0] off5;
    output [3:0] off6;
    output [3:0] off7;
    output [3:0] off8;
    output [3:0] off9;
    output [3:0] off10;
    output [3:0] off11;
    output [3:0] off12;
    output [3:0] off13;
    output [3:0] off14;
    output [3:0] off15;
    
    output [12:0] class0;
    output [12:0] class1;
    output [12:0] class2;
    output [12:0] class3;
    output [12:0] class4;
    output [12:0] class5;
    output [12:0] class6;
    output [12:0] class7;
    output [12:0] class8;
    output [12:0] class9;
    output [12:0] class10;
    output [12:0] class11;
    output [12:0] class12;
    output [12:0] class13;
    output [12:0] class14;
    output [12:0] class15;
    
    output [15:0] instrEn;
    output reg isAvx;
    output hasJumps;
    output reg error;
    output reg jerror;
    output [15:4] jerror_pos;
    
    output [79:0] Jinstr0;
    output [79:0] Jinstr1;
    output [79:0] Jinstr2;
    output [79:0] Jinstr3;

    output [3:0] Jmagic0;
    output [3:0] Jmagic1;
    output [3:0] Jmagic2;
    output [3:0] Jmagic3;

    output [3:0] Joff0;
    output [3:0] Joff1;
    output [3:0] Joff2;
    output [3:0] Joff3;
    
    output [12:0] Jclass0;
    output [12:0] Jclass1;
    output [12:0] Jclass2;
    output [12:0] Jclass3;
    
    output [3:0] Jen;
    output [4:0] lnkLink0;
    output [4:0] lnkOff0;
    output [3:0] lnkMagic0;
    output       lnkRet0;
    output [4:0] lnkJumps0;
    output [4:0] lnkLink1;
    output [4:0] lnkOff1;
    output [3:0] lnkMagic1;
    output       lnkRet1;
    output [4:0] lnkJumps1;
    output [4:0] lnkLink2;
    output [4:0] lnkOff2;
    output [3:0] lnkMagic2;
    output       lnkRet2;
    output [4:0] lnkJumps2;
    output [4:0] lnkLink3;
    output [4:0] lnkOff3;
    output [3:0] lnkMagic3;
    output       lnkRet3;
    output [4:0] lnkJumps3;

    reg [19:-1] instrEnd;
    reg [19:-1] instrEndF;
    
    wire [15:-2][15:0] cntEnd;
    wire [15:-1] mask;
 
    wire [15:0] cntEnd2;
    wire [16:1] cntEnd3;
    
    wire [15:0][12:0] class_ ;
    wire [255+16+48:0] bundle0;
    wire [255+16+48:0] bundleF;

    wire [15:0] is_jmp;
    reg [15:0] is_jmp_reg;
    wire [16:-1][16:0] cntJEnd;
    wire [15:0] jcnt_or_less;
    wire [16:1] jcnt_or_more;
    
    wire [15:0] is_lnk0;
    wire [15:0] is_lnk;
    reg [15:0] is_lnk_reg;
    wire [15:0] first_lnk;
    wire has_lnk;
    wire [16:0][4:0] LNK;
    wire [15:0] lcnt_or_less;
    wire [15:-1][16:0] lcnt;
    wire [15:0] is_ret0;
    wire [15:0] is_ret;
    reg [15:0] is_ret_reg;
    reg [16:0] flag_bits0;
        
    generate
        genvar k;
        for(k=0;k<16;k=k+1) begin : popcnt_gen
            popcnt16 cnt_mod(instrEnd[15:0] & ((16'b10<<k)-16'b1) & mask[15:0],cntEnd[k]);
            get_carry #(4) carry_mod(k[3:0],~startOff,1'b1,mask[k]);

            wire [3:0] kk;
            assign kk=k==0 && in_bite && bstop[3:2]==2'b01 ? 4'he : 4'bz;
            assign kk=k==0 && in_bite && bstop[3:1]==3'b001 ? 4'hd : 4'bz;
            assign kk=k==0 && in_bite && bstop[3:0]==4'b0001 ? 4'hc : 4'bz;
            assign kk=k==0 && in_bite && bstop[3:0]==4'b0 ? 4'hb : 4'bz;
            assign kk= k!=0 || ~in_bite || bstop[3] ? k[3:0] : 4'bz;

            predecoder_class cls_mod(bundleF[k*16+:32],~instrEndF[k+:4],flag_bits0[k],class_[k],
              is_lnk0[k],is_ret0[k],LNK[k]);
            popcnt16 cntJ_mod(is_jmp[15:0] & ((16'b10<<k)-16'b1),cntJEnd[k]);
            popcnt16 cntL_mod(is_lnk[15:0] & ((16'b10<<k)-16'b1),lcnt[k]);
            assign {lnkLink0,lnkOff0,lnkMagic0,lnkRet0}=lcnt[k][1] & lcnt[k-1][0] ? {LNK[k],1'b0,kk[3:0],instrEndF[k+:4],is_ret[k]} :
	       	15'bz;
            assign {lnkLink1,lnkOff1,lnkMagic1,lnkRet1}=lcnt[k][2] & lcnt[k-1][1] ? {LNK[k],1'b0,k[3:0],instrEndF[k+:4],is_ret[k]} :
	       	15'bz;
            assign {lnkLink2,lnkOff2,lnkMagic2,lnkRet2}=lcnt[k][3] & lcnt[k-1][2] ? {LNK[k],1'b0,k[3:0],instrEndF[k+:4],is_ret[k]} :
	       	15'bz;
            assign {lnkLink3,lnkOff3,lnkMagic3,lnkRet3}=lcnt[k][4] & lcnt[k-1][3] ? {LNK[k],1'b0,k[3:0],instrEndF[k+:4],is_ret[k]} :
	       	15'bz;
            assign lnkJumps0=lcnt[k][1] & lcnt[k-1][0] ? cntJEnd[k][4:0] : 5'bz;
            assign lnkJumps1=lcnt[k][2] & lcnt[k-1][1] ? cntJEnd[k][4:0] : 5'bz;
            assign lnkJumps2=lcnt[k][3] & lcnt[k-1][2] ? cntJEnd[k][4:0] : 5'bz;
            assign lnkJumps3=lcnt[k][4] & lcnt[k-1][3] ? cntJEnd[k][4:0] : 5'bz;
            
            assign {Jclass0,Jmagic0,Jinstr0,Joff0}= 
              cntJEnd[k][1] & cntJEnd[k-1][0] ? {class_[k], instrEndF[k+:4],bundleF[k*16+:80],kk[3:0]} : 101'bz;
            assign {Jclass1,Jmagic1,Jinstr1,Joff1}= 
              cntJEnd[k][2] & cntJEnd[k-1][1] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {Jclass2,Jmagic2,Jinstr2,Joff2}= 
              cntJEnd[k][3] & cntJEnd[k-1][2] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {Jclass3,Jmagic3,Jinstr3,Joff3}= 
              cntJEnd[k][4] & cntJEnd[k-1][3] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;

            assign jerror_pos=cntJEnd[k][5] & cntJEnd[k-1][4] & |lcnt[k-1][4:0] ? k[3:0] : 4'b0;
            assign jerror_pos=lcnt[k][5] & lcnt[k-1][4] & |cntJEnd[k-1][4:0] ? k[3:0] : 4'b0;
            
            assign {class0,magic0,instr0,off0}=(mask[k] & ~mask[k-1]) ?
              {class_[k],instrEnd[k+:4],bundle0[k*16+:80],kk[3:0]} : 101'bz;
            assign {class1,magic1,instr1,off1}=mask[k] & 
              cntEnd[k-1][1] & cntEnd[k-2][0] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class2,magic2,instr2,off2}=mask[k] & 
              cntEnd[k-1][2] & cntEnd[k-2][1] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class3,magic3,instr3,off3}=mask[k] &
              cntEnd[k-1][3] & cntEnd[k-2][2] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class4,magic4,instr4,off4}=mask[k] &
              cntEnd[k-1][4] & cntEnd[k-2][3] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class5,magic5,instr5,off5}=mask[k] &
              cntEnd[k-1][5] & cntEnd[k-2][4] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class6,magic6,instr6,off6}=mask[k] &
              cntEnd[k-1][6] & cntEnd[k-2][5] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class7,magic7,instr7,off7}=mask[k] &
              cntEnd[k-1][7] & cntEnd[k-2][6] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class8,magic8,instr8,off8}=mask[k] &
              cntEnd[k-1][8] & cntEnd[k-2][7] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class9,magic9,instr9,off9}=mask[k] &
              cntEnd[k-1][9] & cntEnd[k-2][8] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class10,magic10,instr10,off10}=mask[k] &
              cntEnd[k-1][10] & cntEnd[k-2][9] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class11,magic11,instr11,off11}=mask[k] &
              cntEnd[k-1][11] & cntEnd[k-2][10] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class12,magic12,instr12,off12}=mask[k] &
              cntEnd[k-1][12] & cntEnd[k-2][11] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class13,magic13,instr13,off13}=mask[k] &
              cntEnd[k-1][13] & cntEnd[k-2][12] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class14,magic14,instr14,off14}=mask[k] &
              cntEnd[k-1][14] & cntEnd[k-2][13] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;
            assign {class15,magic15,instr15,off15}=mask[k] &
              cntEnd[k-1][15] & cntEnd[k-2][14] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:80],k[3:0]} : 101'bz;

        end
    endgenerate

    popcnt16_or_less ce2_mod(instrEnd[15:0]&mask[15:0],cntEnd2);
    popcnt16_or_more ce3_mod(instrEnd[15:0]&mask[15:0],cntEnd3);
    popcnt16_or_less jce_mod(is_jmp,jcnt_or_less);
    popcnt16_or_more jcen_mod(is_jmp,jcnt_or_more);
    bit_find_first_bit #(16) getLNK_mod(is_lnk,first_lnk,has_lnk);    
    popcnt16_or_less lce_mod(is_lnk,lcnt_or_less);
    assign mask[-1]=1'b0;
//    assign mask[15]=1'b0;

    assign cntEnd[-1]=16'd1;
    assign cntEnd[-2]=16'd1;
    assign cntJEnd[-1]=16'd1;
    assign lcnt[-1]=16'd1;

    assign bundleF=is_bite && startOff==0 && bstop[3:2]==2'b01 ? {bundle0[255+48:0],btail[63:48]} : 'z;
    assign bundleF=is_bite && startOff==0 && bstop[3:1]==3'b001 ? {bundle0[255+32:0],btail[63:32]} : 'z;
    assign bundleF=is_bite && startOff==0 && bstop[3:0]==4'b0001 ? {bundle0[255+16:0],btail[63:16]} : 'z;
    assign bundleF=is_bite && startOff==0 && bstop[3:0]==4'b0000 ? {bundle0[255:0],btail[63:0]} : 'z;
    assign bundleF=(~is_bite && startOff==0) | bstop[3] ? bundle0 : 'z;
    assign bundleF=is_bite && startOff==0 && bstop[3:2]==2'b01 ? {bundle0[255+48:0],btail[63:48]} : 'z;

    assign instrEndF=is_bite && startOff==0 && bstop[3:2]==2'b01 ? {instrEnd[16:0],bstop[3:1],instrEnd[-1]} : 'z;
    assign instrEndF=is_bite && startOff==0 && bstop[3:1]==3'b001 ? {instrEnd[17:0],bstop[3:2],instrEnd[-1]} : 'z;
    assign instrEndF=is_bite && startOff==0 && bstop[3:0]==4'b0001 ? {instrEnd[18:0],bstop[3],instrEnd[-1]} : 'z;
    assign instrEndF=is_bite && startOff==0 && bstop[3:0]==4'b0000 ? {instrEnd[15:0],bstop[3:0],instrEnd[-1]} : 'z;
    assign instrEndF=(~is_bite && startOff==0) | bstop[3] ? instrEnd : 'z;
    
    assign bundle0={64'b0,bundle[255:0]};
    
    assign {class15,magic15, instr15, off15}=cntEnd2[14] ? 101'b0 : 101'bz;
    assign {class14,magic14, instr14, off14}=cntEnd2[13] ? 101'b0 : 101'bz;
    assign {class13,magic13, instr13, off13}=cntEnd2[12] ? 101'b0 : 101'bz;
    assign {class12,magic12, instr12, off12}=cntEnd2[11] ? 101'b0 : 101'bz;
    assign {class11,magic11, instr11, off11}=cntEnd2[10] ? 101'b0 : 101'bz;
    assign {class10,magic10, instr10, off10}=cntEnd2[9] ? 101'b0 : 101'bz;
    assign {class9,magic9, instr9, off9}=cntEnd2[8] ? 101'b0 : 101'bz;
    assign {class8,magic8, instr8, off8}=cntEnd2[7] ? 101'b0 : 101'bz;
    assign {class7,magic7, instr7, off7}=cntEnd2[6] ? 101'b0 : 101'bz;
    assign {class6,magic6, instr6, off6}=cntEnd2[5] ? 101'b0 : 101'bz;
    assign {class5,magic5, instr5, off5}=cntEnd2[4] ? 101'b0 : 101'bz;
    assign {class4,magic4, instr4, off4}=cntEnd2[3] ? 101'b0 : 101'bz;
    assign {class3,magic3, instr3, off3}=cntEnd2[2] ? 101'b0 : 101'bz;
    assign {class2,magic2, instr2, off2}=cntEnd2[1] ? 101'b0 : 101'bz;
    assign {class1,magic1, instr1, off1}=cntEnd2[0] ? 101'b0 : 101'bz;
    assign {class0,magic0, instr0, off0}=(0==mask) ? 101'b0 : 101'bz;

    assign {lnkLink0,lnkOff0,lnkMagic0,lnkRet0}=lcnt_or_less[0] ? 15'b1110_10000_0001_0 : 15'bz;
    assign {lnkLink1,lnkOff1,lnkMagic1,lnkRet1}=lcnt_or_less[1] ? 15'b1110_10000_0001_0 : 15'bz;
    assign {lnkLink2,lnkOff2,lnkMagic2,lnkRet2}=lcnt_or_less[2] ? 15'b1110_10000_0001_0 : 15'bz;
    assign {lnkLink3,lnkOff3,lnkMagic3,lnkRet3}=lcnt_or_less[3] ? 15'b1110_10000_0001_0 : 15'bz;
    assign lnkJumps0=lcnt_or_less[0] ?  5'd1 : 5'bz;
    assign lnkJumps1=lcnt_or_less[1] ?  5'd1 : 5'bz;
    assign lnkJumps2=lcnt_or_less[2] ?  5'd1 : 5'bz;
    assign lnkJumps3=lcnt_or_less[3] ?  5'd1 : 5'bz;

    assign instrEn=cntEnd3[16:1];
    assign Jen=jcnt_or_more[4:1];

    assign jerror_pos=lcnt_or_less[4] ? 12'b0 : 12'bz;
    
    assign is_jmp={
        class_[15][`iclass_jump],
        class_[14][`iclass_jump],
        class_[13][`iclass_jump],
        class_[12][`iclass_jump],
        class_[11][`iclass_jump],
        class_[10][`iclass_jump],
        class_[9][`iclass_jump],
        class_[8][`iclass_jump],
        class_[7][`iclass_jump],
        class_[6][`iclass_jump],
        class_[5][`iclass_jump],
        class_[4][`iclass_jump],
        class_[3][`iclass_jump],
        class_[2][`iclass_jump],
        class_[1][`iclass_jump],
        class_[0][`iclass_jump]
        } & instrEnd[14:-1] & (instrEnd[15:0] | instrEnd[16:1] | {1'b0,instrEnd[16:2]} |
          {2'b0,instrEnd[16:3]});

    assign is_lnk=is_lnk0[15:0] & instrEnd[14:-1];
    assign is_ret=is_lnk0[15:0] & instrEnd[14:-1] & is_ret0[15:0];
    
    assign {Jclass3,Jmagic3, Jinstr3, Joff3}=jcnt_or_less[3] ? 101'b0 : 101'bz;
    assign {Jclass2,Jmagic2, Jinstr2, Joff2}=jcnt_or_less[2] ? 101'b0 : 101'bz;
    assign {Jclass1,Jmagic1, Jinstr1, Joff1}=jcnt_or_less[1] ? 101'b0 : 101'bz;
    assign {Jclass0,Jmagic0, Jinstr0, Joff0}=jcnt_or_less[0] ? 101'b0 : 101'bz;
      
    assign hasJumps=(is_jmp & mask[14:0])!=15'b0;
    
    always @*
      begin
        instrEnd={4'b0,bundle0[255],bundle0[239],bundle0[223],bundle0[207],bundle0[191],
            bundle0[175],bundle0[159],bundle0[143],bundle0[127],bundle0[111],
            bundle0[95],bundle0[79],bundle0[63],bundle0[47],bundle0[31],bundle0[15],1'b1};
        error=cntEnd3[13] || startOff==15;
        isAvx=1'b0;
        jerror=~lcnt_or_less[4] || ~jcnt_or_less[4];
        flag_bits0={btail[16],flag_bits};
      end

endmodule

