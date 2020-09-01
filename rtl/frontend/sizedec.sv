`include "../struct.sv"
`include "../csrss_no.sv"

module predecoder_class(instr,magic,flag,class_,isLNK,isRet,LNK);
  input [31:0] instr;
  input [1:0] magic;
  input flag;
  output [12:0] class_;
  output isLNK;
  output isRet;
  output [15:0] LNK;

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

  wire isSimdInt; 
  wire isFPUreor;
 
  wire isBasicFPUScalarA;
  wire isBasicFPUScalarB;
  wire isBasicFPUScalarC;
  wire isBasicFPUScalarCmp;

  wire isBasicSysInstr=opcode_main==8'hff;
  
  wire isCallPrep;

  wire [5:0] opcode_sub;
  
  assign subIsBasicALU=(!opcode_sub[5:4] || opcode_sub[5:2]==4'b0100) & ~magic[0];
  assign subIsBasicShift=(~opcode_sub[5] && ~subIsBasicALU && opcode_sub[0]) & ~magic[0];
  assign subIsFPUE=opcode_sub==6'b010100 && ~magic[0]; 
  assign subIsFPUSngl=((opcode_sub==6'b010110 || opcode_sub==6'b011000) && opcode_main[7:6]!=2'b11) & ~magic[0];
  assign subIsSIMD=(opcode_sub[5:3]==3'b011 && opcode_sub[2:1] && ~opcode_sub[0]) & ~magic[0];
  assign subIsMovOrExt=(opcode_sub[5:3]==3'b100 || opcode_sub[5:1]==5'b10100) & ~magic[0];
  assign subIsCmpTest=(opcode_sub[5:1]==5'b10101 || opcode_sub[5:2]==5'b1011) & ~magic[0];
  assign subIsCJ=opcode_sub[5:2]==4'b1100 && ~magic[0];
  assign subIsFPUD=(opcode_sub[5:2]==4'b1101 || opcode_sub[5:1]==5'b11100) & ~magic[0];
  assign subIsFPUPD=(opcode_sub[5:3]==3'b111 && opcode_sub[5:1]!=5'b11100) & ~magic[0];
  
  
  assign opcode_main=instr[7:0];
  assign opcode_sub=instr[5:0];
  
  
  assign isBasicALU=(!opcode_main[7:5] || opcode_main[7:3]==3'b00100) & ~opcode_main[2] & magic[0];
  assign isBasicMUL=(!opcode_main[7:5] || opcode_main[7:3]==3'b00100) & opcode_main[2] & magic[0];
  assign isBasicALUExcept=~opcode_main[0] && magic[1:0]==2'b11 | (magic==2'b01 && instr[28:23]);  
  assign isBasicShift=(opcode_main[7:1]==7'd20 || opcode_main[7:1]==7'd21 ||
      opcode_main[7:1]==7'd22)&&magic[0];      
  assign isBasicShiftExcept=magic==2'b01 && instr[29:25];
  
  assign isBasicCmpTest=(opcode_main[7:1]==7'd23 || opcode_main[7:2]==6'd12 ||
    opcode_main[7:1]==7'd26) && magic[0];

  assign isBaseSpecLoad=(opcode_main==8'd54 || opcode_main==8'd176) && magic[0];
  assign isBaseIndexSpecLoad=(opcode_main==8'd55 || opcode_main==8'd177) && magic[0];
  
  assign isImmLoadStore=(opcode_main[7:2]==6'd15 || opcode_main[7:1]==7'b1011000) && magic[0];  

  assign isBaseLoadStore=(opcode_main[7:5]==3'b010 || opcode_main[7:4]==4'b0110) && magic[0];
  assign isBaseIndexLoadStore=(opcode_main[7:5]==3'b100 || opcode_main[7:4]==4'b0111) && magic[0];

  assign isBasicCJump=(opcode_main[7:4]==4'b1010) && magic[0];
  assign isSelfTestCJump=(opcode_main==8'd178 || opcode_main==8'd179) && magic[0];
  assign isLongCondJump=(opcode_main==8'd180) && magic[0];
  assign isUncondJump=(opcode_main==8'd181) && magic[0];
  assign isIndirJump=(opcode_main==8'd182 && instr[15:13]==3'd0) && magic[0];
  assign isCall=(opcode_main==8'd182 && (instr[15:13]==3'd1 || instr[15:13]==3'd2)) && magic[0];
  assign isRet=(opcode_main==8'd182 && instr[15:13]==3'd3) && magic[0];
  assign isMovOrExt=(opcode_main==8'd183 || opcode_main[7:3]==5'b10111 || opcode_main[7:1]==7'd96) && magic[0];
  assign isMovOrExtExcept=magic[1] && opcode_main!=8'd183 && opcode_main[7:1]!=7'd92;
  assign isCSet=(opcode_main==8'd194) && magic[0]; 
  assign isBasicAddNoFl=(opcode_main==8'd195 || opcode_main==8'd196) && magic[0];
  
  assign isLeaIPRel=(opcode_main==8'd197) & magic[0];

  assign isCmov=opcode_main==198 && magic==2'b01 && instr[31:29]==3'd0;
//  assign isCmpTestExtra=opcode_main==198 && magic==2'b01 && instr[31:29]==3'd1;
  
  
  assign isSimdInt=opcode_main==8'd200;
  assign isFPUreor=opcode_main==8'd201;
  
  assign isBasicFPUScalarA=opcode_main==8'hef && instr[13:12]==2'b0;
  assign isBasicFPUScalarB=opcode_main==8'hef && instr[13:12]==2'b1;
  assign isBasicFPUScalarC=opcode_main==8'hef && instr[15:12]==4'd2;
  assign isBasicFPUScalarCmp=opcode_main==8'hef && instr[15:12]==4'd6;
  assign isBasicFPUScalarCmp2=opcode_main==8'hef && instr[15:12]==4'ha;

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
  
  assign clsALU=|{
  isBasicALU & ~isBasicALUExcept,
  isBasicCmpTest,
  isBasicCJump & magic[0],
  isSelfTestCJump,
  isMovOrExt & ~isMovOrExtExcept,
  isCSet,
  isBasicAddNoFl,
  isCmov,
  isSimdInt & ~instr[16],subIsFPUD & !(opcode_sub[5:1]==5'b11100),
  subIsFPUPD & !(opcode_sub[5:1]==5'b11101), subIsFPUSngl & !(opcode_main[7:6]==2'b0),
  subIsFPUE & !(opcode_main[7:6]==2'b0),
  subIsSIMD,
  isSimdInt && ((instr[13:9]==5'd0 && ~instr[16]) || (instr[13:9]==5'd5 && ~instr[16]) || (instr[13:8]==5'b11 && instr[16])),
  subIsBasicALU,subIsCmpTest,
  opcode_main==8'hff && instr[15:13]==3'd1 && magic[0],
  isBasicFPUScalarA && instr[13:9]!=5'd2 && instr[13:8]!=6'd8,
  isBasicFPUScalarB && instr[13:8]!=6'd18 && instr[13:8]!=6'd21,
  isBasicFPUScalarC && instr[13:11],
  isBasicFPUScalarCmp && !instr[13:11],
  isBasicFPUScalarCmp2 && !instr[13:11],
  subIsMovOrExt,
  isLeaIPRel
  };
  
  assign clsPos0=opcode_main==8'hff && instr[15:13]==3'd1 && magic[0] && instr[31:16]==`csr_FPU;
  
  assign clsShift=isBasicShift & ~isBasicShiftExcept || subIsBasicShift || subIsFPUD & (opcode_sub[5:1]==5'b11100) ||
    subIsFPUPD & (opcode_sub[5:1]==5'b11101) || subIsFPUSngl &(opcode_main[7:6]==2'b0)
    || subIsFPUE &(opcode_main[7:6]==2'b0) || isSimdInt & instr[16] ||
    (isSimdInt && ~((instr[13:9]==5'd0 && ~instr[16]) || (instr[13:9]==5'd5 && ~instr[16]) ||
     (instr[13:8]==5'b11 && instr[16]))) || 
    (isBasicFPUScalarA && ~(instr[13:9]!=5'd2 && instr[13:8]!=6'd8)) ||
    (isBasicFPUScalarB && ~(instr[13:8]!=6'd18 && instr[13:8]!=6'd21));
  
  assign clsLoad=|{
  isBaseLoadStore & ~opcode_main[0],
  isBaseIndexLoadStore & ~opcode_main[0],  
  isBaseSpecLoad,
  isBaseIndexSpecLoad,
  isImmLoadStore && ~opcode_main[0]
  };

  assign clsStore=|{
  isBaseLoadStore &  opcode_main[0],
  isImmLoadStore && opcode_main[0],
  isBaseIndexLoadStore & opcode_main[0],
  isCall & magic
  };
  
  assign clsStore2=isBaseIndexLoadStore & opcode_main[0];

  assign clsLoadFPU=|{
    isBaseLoadStore & ~opcode_main[0] & ~opcode_main[5],
    isBaseIndexLoadStore & ~opcode_main[0] & opcode_main[7:4]!=4'b0111,  
    isBaseSpecLoad & ~opcode_main[7],
    isBaseIndexSpecLoad & ~opcode_main[7],
    isImmLoadStore && ~opcode_main[0] && opcode_main[7:1]!=7'b1011000
  };
  
  assign clsMul=|{
    isBasicMUL,
    opcode_main==8'hff && ~instr[15] && ~instr[13] && magic[0],
    isBasicFPUScalarC && !instr[13:11],
     isBasicFPUScalarCmp && instr[13:11],
     isBasicFPUScalarCmp2 && instr[13:11]
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
  assign class_[`iclass_store2]=clsStore2;
  assign class_[`iclass_FPU]=clsFPU;
  assign class_[`iclass_loadFPU]=clsLoadFPU;
  assign class_[`iclass_sys]=clsSys;
  assign class_[`iclass_flag]=flag;
  assign class_[`iclass_pos0]=clsPos0;
  
  assign LNK=isRet ? 16'b0 : 16'bz;
//  assign LNK=(isCallPrep & ~magic[0]) ? instr[11:8] : 16'bz;
  assign LNK=isCallPrep ? instr[31:16] : 16'bz;
  assign LNK=(~isRet & ~isCallPrep) ? 16'hf : 16'bz;
  
  assign isLNK=isRet | isCallPrep;
  
endmodule

module predecoder_get(
    clk,
    rst,
    bundle,btail,
    flag_bits,
    startOff,
    instr0,instr1,instr2,instr3,
    instr4,instr5,instr6,instr7,
    magic0,magic1,magic2,magic3,
    magic4,magic5,magic6,magic7,
    off0,off1,off2,off3,
    off4,off5,off6,off7,
    class0,class1,class2,class3,
    class4,class5,class6,class7,
    instrEn,
    isAvx,
    hasJumps,
    error,
    jerror,
    Jinstr0,Jinstr1,Jinstr2,Jinstr3,
    Jmagic0,Jmagic1,Jmagic2,Jmagic3,
    Joff0,Joff1,Joff2,Joff3,
    Jclass0,Jclass1,Jclass2,Jclass3,
    Jen,
    lnkLink,lnkOff,lnkMagic,lnkRet,lnkJumps
    );
    localparam CLSWIDTH=12;
    
    input clk;
    input rst;
    input [255:0] bundle;
    input [16:0] btail;
    input [14:0] flag_bits;
    input [3:0] startOff;
    output [31:0] instr0;
    output [31:0] instr1;
    output [31:0] instr2;
    output [31:0] instr3;
    output [31:0] instr4;
    output [31:0] instr5;
    output [31:0] instr6;
    output [31:0] instr7;

    output [3:0] magic0;
    output [3:0] magic1;
    output [3:0] magic2;
    output [3:0] magic3;
    output [3:0] magic4;
    output [3:0] magic5;
    output [3:0] magic6;
    output [3:0] magic7;

    output [3:0] off0;
    output [3:0] off1;
    output [3:0] off2;
    output [3:0] off3;
    output [3:0] off4;
    output [3:0] off5;
    output [3:0] off6;
    output [3:0] off7;
    
    output [11:0] class0;
    output [11:0] class1;
    output [11:0] class2;
    output [11:0] class3;
    output [11:0] class4;
    output [11:0] class5;
    output [11:0] class6;
    output [11:0] class7;
    
    output [7:0] instrEn;
    output reg isAvx;
    output hasJumps;
    output reg error;
    output reg jerror;
    
    output [31:0] Jinstr0;
    output [31:0] Jinstr1;
    output [31:0] Jinstr2;
    output [31:0] Jinstr3;

    output [3:0] Jmagic0;
    output [3:0] Jmagic1;
    output [3:0] Jmagic2;
    output [3:0] Jmagic3;

    output [3:0] Joff0;
    output [3:0] Joff1;
    output [3:0] Joff2;
    output [3:0] Joff3;
    
    output [11:0] Jclass0;
    output [11:0] Jclass1;
    output [11:0] Jclass2;
    output [11:0] Jclass3;
    
    output [3:0] Jen;
    output [15:0] lnkLink;
    output [3:0] lnkOff;
    output [3:0] lnkMagic;
    output lnkRet;
    output [4:0] lnkJumps;

    reg [19:-1] instrEnd;
    
    wire [15:-2][16:0] cntEnd;
    wire [15:-1] mask;
 
    wire [15:0] cntEnd2;
    wire [16:1] cntEnd3;
    
    wire [15:0][11:0] class_ ;
    wire [255+16+48:0] bundle0;

    wire [14:0] is_jmp;
    reg [14:0] is_jmp_reg;
    wire [15:-1][15:0] cntJEnd;
    wire [14:0] jcnt_or_less;
    wire [15:1] jcnt_or_more;
    
    wire [15:0] is_lnk0;
    wire [14:0] is_lnk;
    reg [14:0] is_lnk_reg;
    wire [14:0] first_lnk;
    wire has_lnk;
    wire [15:0][15:0] LNK;
    wire [14:0] lcnt_or_less;
    wire [15:0] is_ret0;
    wire [14:0] is_ret;
    reg [14:0] is_ret_reg;
    reg [15:0] flag_bits0;
        
    generate
        genvar k;
        for(k=0;k<=15;k=k+1) begin : popcnt_gen
            popcnt16 cnt_mod(instrEnd[15:0] & ((15'b10<<k)-15'b1) & mask[15:0],cntEnd[k]);
            get_carry #(4) carry_mod(k[3:0],~startOff,1'b1,mask[k]);
 
            predecoder_class cls_mod(bundle0[k*16+:32],~instrEnd[k+:2],flag_bits0[k],class_[k],
              is_lnk0[k],is_ret0[k],LNK[k]);
            popcnt15 cntJ_mod(is_jmp[14:0] & ((15'b10<<k)-15'b1),cntJEnd[k]);

            if (k<15) begin
                assign {lnkLink,lnkOff,lnkMagic,lnkRet}=first_lnk[k] ? {LNK[k],k[3:0],instrEnd[k+:4],is_ret[k]} : 25'bz;
                assign lnkJumps=first_lnk[k] ? cntJEnd[k][4:0] : 5'bz;
            end  
            
            assign {Jclass0,Jmagic0,Jinstr0,Joff0}= 
              cntJEnd[k][1] & cntJEnd[k-1][0] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:32],k[3:0]} : 48'bz;
            assign {Jclass1,Jmagic1,Jinstr1,Joff1}= 
              cntJEnd[k][2] & cntJEnd[k-1][1] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:32],k[3:0]} : 48'bz;
            assign {Jclass2,Jmagic2,Jinstr2,Joff2}= 
              cntJEnd[k][3] & cntJEnd[k-1][2] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:32],k[3:0]} : 48'bz;
            assign {Jclass3,Jmagic3,Jinstr3,Joff3}= 
              cntJEnd[k][4] & cntJEnd[k-1][3] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:32],k[3:0]} : 48'bz;
            
            assign {class0,magic0,instr0,off0}=(mask[k] & ~mask[k-1]) ?
              {class_[k],instrEnd[k+:4],bundle0[k*16+:32],k[3:0]} : 48'bz;
            assign {class1,magic1,instr1,off1}=mask[k] & 
              cntEnd[k-1][1] & cntEnd[k-2][0] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:32],k[3:0]} : 48'bz;
            assign {class2,magic2,instr2,off2}=mask[k] & 
              cntEnd[k-1][2] & cntEnd[k-2][1] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:32],k[3:0]} : 48'bz;
            assign {class3,magic3,instr3,off3}=mask[k] &
              cntEnd[k-1][3] & cntEnd[k-2][2] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:32],k[3:0]} : 48'bz;
            assign {class4,magic4,instr4,off4}=mask[k] &
              cntEnd[k-1][4] & cntEnd[k-2][3] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:32],k[3:0]} : 48'bz;
            assign {class5,magic5,instr5,off5}=mask[k] &
              cntEnd[k-1][5] & cntEnd[k-2][4] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:32],k[3:0]} : 48'bz;
            assign {class6,magic6,instr6,off6}=mask[k] &
              cntEnd[k-1][6] & cntEnd[k-2][5] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:32],k[3:0]} : 48'bz;
            assign {class7,magic7,instr7,off7}=mask[k] &
              cntEnd[k-1][7] & cntEnd[k-2][6] ? {class_[k], instrEnd[k+:4],bundle0[k*16+:32],k[3:0]} : 48'bz;

        end
    endgenerate

    popcnt16_or_less ce2_mod(instrEnd[15:0]&mask[15:0],cntEnd2);
    popcnt16_or_more ce3_mod(instrEnd[15:0]&mask[15:0],cntEnd3);
    popcnt15_or_less jce_mod(is_jmp,jcnt_or_less);
    popcnt15_or_more jcen_mod(is_jmp,jcnt_or_more);
    bit_find_first_bit #(15) getLNK_mod(is_lnk,first_lnk,has_lnk);    
    popcnt15_or_less lce_mod(is_lnk,lcnt_or_less);
    assign mask[-1]=1'b0;
//    assign mask[15]=1'b0;

    assign cntEnd[-1]=16'd1;
    assign cntEnd[-2]=16'd1;
    assign cntJEnd[-1]=16'd1;
    
    assign bundle0={48'b0,bundle};
    
    assign {class7,magic7, instr7, off7}=cntEnd2[6] ? 48'b0 : 48'bz;
    assign {class6,magic6, instr6, off6}=cntEnd2[5] ? 48'b0 : 48'bz;
    assign {class5,magic5, instr5, off5}=cntEnd2[4] ? 48'b0 : 48'bz;
    assign {class4,magic4, instr4, off4}=cntEnd2[3] ? 48'b0 : 48'bz;
    assign {class3,magic3, instr3, off3}=cntEnd2[2] ? 48'b0 : 48'bz;
    assign {class2,magic2, instr2, off2}=cntEnd2[1] ? 48'b0 : 48'bz;
    assign {class1,magic1, instr1, off1}=cntEnd2[0] ? 48'b0 : 48'bz;
    assign {class0,magic0, instr0, off0}=(!mask) ? 48'b0 : 48'bz;

    assign {lnkLink,lnkOff,lnkMagic,lnkRet}=has_lnk ? 25'bz : 25'b1110_0000_0001_0;
    assign lnkJumps=has_lnk ? 5'bz : 5'd1;

    assign instrEn=cntEnd3[8:1];
    assign Jen=jcnt_or_more[4:1];
    
    assign is_jmp={class_[14][`iclass_jump],
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
        } & instrEnd[13:-1] & (instrEnd[14:0] | instrEnd[15:1] | instrEnd[15:2] |
          instrEnd[15:3]);

    assign is_lnk=is_lnk0[14:0] & instrEnd[13:-1];
    assign is_ret=is_lnk0[14:0] & instrEnd[13:-1] & is_ret[14:0];
    
    assign {Jclass3,Jmagic3, Jinstr3, Joff3}=jcnt_or_less[3] ? 48'b0 : 48'bz;
    assign {Jclass2,Jmagic2, Jinstr2, Joff2}=jcnt_or_less[2] ? 48'b0 : 48'bz;
    assign {Jclass1,Jmagic1, Jinstr1, Joff1}=jcnt_or_less[1] ? 48'b0 : 48'bz;
    assign {Jclass0,Jmagic0, Jinstr0, Joff0}=jcnt_or_less[0] ? 48'b0 : 48'bz;
      
    assign hasJumps=(is_jmp & mask[14:0])!=15'b0;
    
    always @*
      begin
        instrEnd={3'b0,16'haaaa,1'b1};
        error=cntEnd3[13];
        isAvx=1'b0;
        jerror=~lcnt_or_less[1] || ~jcnt_or_less[4];
        flag_bits0={btail[16],flag_bits};
      end
/*
    always @(posedge clk) begin
        if (rst) is_jmp_reg<=15'b0;
        else is_jmp_reg<=is_jmp;
        if (rst) is_lnk_reg<=15'b0;
        else is_lnk_reg<=is_lnk;
        if (rst) is_ret_reg<=15'b0;
        else is_ret_reg<=is_lnk;
    end
 */
endmodule

