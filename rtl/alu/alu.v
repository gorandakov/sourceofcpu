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


//compile alu into hard macro with 1 horizontal x2 wire
//do not delete redundant output
//place next to alu_shift in alu-shift combo

module alu(clk,rst,except,except_thread,thread,operation,cond,sub,cary_invert,dataEn,nDataAlt,retData,retEn,val1,val2,valS,valRes,valRes_N);

  localparam REG_WIDTH=`reg_addr_width;
  localparam OPERATION_WIDTH=`operation_width;
  localparam EXCEPT_WIDTH=9;
  localparam FLAG_WIDTH=6; 
  parameter NOSHIFT=1'b1;  
  input clk;
  input rst;
  input except;
  input except_thread;
  input thread;
  input [OPERATION_WIDTH-1:0] operation;
  input [4:0] cond;
  input [5:0] sub; //high power fat wire
  input cary_invert; //invert carry out from add instruction
  input dataEn;//1=coming data from rs
  input nDataAlt;//0=feeding data through multiclk unit
  output wire [EXCEPT_WIDTH-1:0] retData;
  output retEn;
  input [64:0] val1;
  input [64:0] val2;
  input [5:0] valS;//flag
  inout  [64:0] valRes;  
  output [64:0] valRes_N;  
  
  wire  [64:0] valRes_X;  
  wire  [64:0] valRes_X_N;  

  assign valRes=valRes_X;
  assign valRes_N=~valRes;

  reg [64:0] valRes_reg;

  wire [63:0] valRes1;  
  wire [7:0] valRes8;
  wire [63:0] valRes2;  

  wire [EXCEPT_WIDTH-1:0] retData_X;
  assign retData=retData_X;

  wire flag64_ZF;
  wire flag32_ZF;
  reg flag64_ZF_reg;
  reg flag32_ZF_reg;
  wire flag16_ZF;
  wire flag8_ZF;
  reg flag16_ZF_reg;
  reg flag8_ZF_reg;
        
  wire flag8_PF;
  reg flag8_PF_reg;
  wire flag8_SF;
  reg flagAdd8_CF;
  reg flagAdd8_AF;

  
  wire carryAdd44;
  wire carryAdd64;
  wire carryAdd32;
  wire carryAdd16;
  wire carryAdd8LL;
  wire carryAdd8HL;
  wire carryAdd8LH;
  wire carryAdd8HH;
  wire carryAdd4LL;
  wire carryAdd4HL;
  wire carryAdd4LH;
  wire carryAdd4HH;
        
  
  
  
  reg carryAdd44_reg;
  reg carryAdd64_reg;
  reg carryAdd32_reg;
  reg carryAdd16_reg;
  reg carryAdd8LL_reg;
  reg carryAdd8HL_reg;
  reg carryAdd8LH_reg;
  reg carryAdd8HH_reg;
  reg carryAdd4LL_reg;
  reg carryAdd4HL_reg;
  reg carryAdd4LH_reg;
  reg carryAdd4HH_reg;
        
  
  reg val1_sign44;
  reg val1_sign65;
  reg val1_sign64;
  reg val1_sign32;
  reg val1_sign16;
  reg val1_sign8;

          
  reg val2_sign64;
  reg val2_sign65;
  reg val2_sign44;
  reg val2_sign32;
  reg val2_sign16;
  reg val2_sign8;
  
  wire flagAdd64_OF;
  wire flagAdd32_OF;
  wire flagAdd16_OF;
  wire flagAdd8_OF;
          
  wire flagSub64_OF;
  wire flagSub44_OF;
  wire flagSub32_OF;
  wire flagSub16_OF;
  wire flagSub8_OF;
  
  reg flagAdd64_OF_reg;
  reg flagAdd32_OF_reg;
  reg flagSub64_OF_reg;
  reg flagSub44_OF_reg;
  reg flagSub32_OF_reg;
  reg flagSub16_OF_reg;
  reg flagSub8_OF_reg;

  wire [5:0] flags_COASZP;


  wire isFlags;
  reg isFlags_reg;
  wire [2:0] reg8flg;
  wire [7:0] smallOP;
  reg nDataAlt_reg;

  wire [63:0] val_and;
  wire [63:0] val_or;
  wire [63:0] val_xor;
 
  wire nDataAlt2; 
  wire [3:0] val1One;
  reg [3:0] val1One_reg;
 
  wire [4:0] jumpType; 
  wire doJmp;
  reg doJmp_reg;
  wire doJmp2;

  wire add_en;
  wire shift_en;
  wire add8_en;
  wire sahf_en;
  reg shift_en_reg;
  
  reg [OPERATION_WIDTH-1:0] retOp;
  reg [5:0] valS_reg;
  reg [5:0] val1_reg;

  reg dataEn_reg;
  wire thrinh;
  reg thrinh_reg;
  reg except_reg;
  reg except_thread_reg;
  wire logic_en,spec1_en,spec2_en;
  wire cmov_en;
  reg logic_en_reg;

  wire [2:0] cin_seq;
  reg cin_seq_reg;
  wire is_ptr,is_sub;
  wire cout_seq;
  wire [63:0] ptr;
  reg [63:0] ptr_reg;
  reg is_ptr_reg;
  reg is_ptr_sub;

  assign reg8flg=operation[10:8];
  assign smallOP=operation[7:0];

  assign jumpType[4]=1'b0;
  assign jumpType[3:1]=operation[10:8];
  assign jumpType[0]=operation[0]; //1 for inverse

  
  assign isFlags=~operation[12];
  
  assign val1One[0]=|val1[7:0];
  assign val1One[1]=|val1[15:8];
  assign val1One[2]=|val1[31:16];
  assign val1One[3]=|val1[63:32];
  
  assign val_or={is_ptr ? ptr[63:44] : val1[63:44]|val2[63:44],val1[43:0]|val2[43:0]};
  assign val_xor={is_ptr ? ptr[63:44] : val1[63:44]^val2[63:44],val1[43:0]^val2[43:0]};
  assign val_and={is_ptr ? ptr[63:44] : val1[63:44]&val2[63:44],val1[43:0]&val2[43:0]};
  
  assign nDataAlt2=nDataAlt && doJmp2 | ~cond[4];
  assign valRes_X=(add_en||shift_en&~NOSHIFT||~nDataAlt)&~(~doJmp2|~cond[4]) ? 65'bz : {nDataAlt & ~nDataAlt2 ? val1[64] : is_ptr,valRes2};
  assign valRes2[63:0]=(operation[11] || ~nDataAlt) ? 64'b0: 64'bz;
  assign valRes2[63:0]=nDataAlt & ~nDataAlt2 ? val1[63:0] : 64'bz;
  assign valRes2[63:0]=(~add8_en & ~sahf_en && nDataAlt2) ? valRes1 : 64'bz;
  assign valRes2[63:8]=(add8_en|sahf_en && nDataAlt2) ? 56'b0 : 56'bz;
  assign valRes2[7:0]=(add8_en|sahf_en && nDataAlt2) ? valRes8 : 8'bz;

  assign valRes8=(sahf_en) ? 8'bz : 8'b0;
  assign valRes8=sahf_en ? {2'b0,valS} : 8'bz;

  assign logic_en=(operation[7:3]==5'd1 || operation[7:2]==6'b100) && ~operation[1];
  assign spec1_en=(operation[7:3]==5'b100 && operation[7:0]!=8'd38) || operation[7:2]==6'b1010;
  assign spec2_en=(operation[7:3]==5'b110 && operation[7:0]!=8'd56) || operation[7:1]==7'd29;
  
  assign valRes1=(operation[11] || ~nDataAlt || (~logic_en && ~spec1_en && ~spec2_en)) ? 
    64'b0: 64'bz;
  assign add_en=(~(|operation[7:3])|(operation[7:1]==7'd30) && ~operation[11]) && nDataAlt;
  assign add8_en=1'b0;
  assign sahf_en=~operation[11] && operation[7:0]==`op_sahf && nDataAlt;
  assign shift_en=(operation[7:2]==6'd5 || operation[7:2]==6'd6 || operation[7:2]==6'd7) && nDataAlt && ~operation[11];
  assign valRes1=(add_en|shift_en) ? 64'b0 : 64'bz;
    
  assign flag8_SF=retOp[8] ? valRes_reg[15] : valRes_reg[7];

  assign valRes1[63:32]=((operation[11:0]==`op_and64) && nDataAlt) ? val_and[63:32] : 32'bz;   
  assign valRes1[63:32]=((operation[11:0]==`op_and32) && nDataAlt) ? 32'b0 : 32'bz;   
  assign valRes1[31:0]=((operation[11:0]==`op_and32 || operation[11:0]==`op_and64) && nDataAlt) ? val_and[31:0] : 32'bz;   
  

  assign valRes1[63:32]=((operation[11:0]==`op_or64 || operation[11:1]==11'd29) && nDataAlt) ? val_or[63:32] : 32'bz;   
  assign valRes1[63:32]=((operation[11:0]==`op_or32) && nDataAlt) ? 32'b0  : 32'bz;   
  assign valRes1[31:0]=((operation[11:0]==`op_or32 || operation[11:0]==`op_or64) && nDataAlt) ? val_or[31:0] : 32'bz;   
  
  
  assign valRes1[63:32]=((operation[11:0]==`op_xor64) && nDataAlt) ? val_xor[63:32] : 32'bz;   
  assign valRes1[63:32]=((operation[11:0]==`op_xor32) && nDataAlt) ? 32'b0  : 32'bz;   
  assign valRes1[31:0]=((operation[11:0]==`op_xor32 || operation[11:0]==`op_xor64) && nDataAlt) ? val_xor[31:0] : 32'bz;   
  
  assign valRes1[63:32]=((operation[11:0]==`op_nxor64) && nDataAlt) ? (~val_xor[63:32]) : 32'bz;   
  assign valRes1[63:32]=((operation[11:0]==`op_nxor32) && nDataAlt) ? 32'b0  : 32'bz;   
  assign valRes1[31:0]=((operation[11:0]==`op_nxor32 || operation[11:0]==`op_nxor64) && nDataAlt) ? 
	  (~val_xor[31:0]) : 32'bz;   
  

  assign valRes1[63:32]=((operation[11:0]==`op_mov64) && nDataAlt) ? val2[63:32] : 32'bz;   
  assign valRes1[63:32]=((operation[11:0]==`op_mov32) && nDataAlt) ? 32'b0 : 32'bz;   
  assign valRes1[63:32]=((operation[11:0]==`op_mov16 || (operation[7:0]==`op_mov8)&~operation[11]) && nDataAlt) ? val1[63:32] : 32'bz;   
  assign valRes1[31:16]=((operation[11:0]==`op_mov32 || operation[11:0]==`op_mov64) && nDataAlt) ? val2[31:16] : 16'bz;   
  assign valRes1[31:16]=((operation[11:0]==`op_mov16 || (operation[7:0]==`op_mov8)&~operation[11]) && nDataAlt) ? val1[31:16] : 16'bz;   
  assign valRes1[15:0]=((((operation[9:0]==`op_mov16) && ~operation[10]) || operation[11:0]==`op_mov32 || operation[11:0]==`op_mov64) && nDataAlt) ?
    val2[15:0] : 16'bz;   
  assign valRes1[15:0]=((((operation[9:0]==`op_mov16) && operation[10])) && nDataAlt) ?
    val2[31:16] : 16'bz;   
  assign valRes1[15:0]=((operation[11:0]=={1'b0,3'b000,8'd`op_mov8}) && nDataAlt) ? {val1[15:8],val2[7:0]} : 16'bz;   
  assign valRes1[15:0]=((operation[11:0]=={1'b0,3'b011,8'd`op_mov8}) && nDataAlt) ? {val1[15:8],val2[15:8]} : 16'bz;   
  assign valRes1[15:0]=((operation[11:0]=={1'b0,3'b100,8'd`op_mov8}) && nDataAlt) ? {val2[7:0],val1[7:0]} : 16'bz;   
  assign valRes1[15:0]=((operation[11:0]=={1'b0,3'b111,8'd`op_mov8}) && nDataAlt) ? {val2[15:8],val1[7:0]} : 16'bz;   
  assign valRes1[15:0]=((operation[11:0]=={1'b0,3'b001,8'd`op_mov8}) && nDataAlt) ? {val1[15:8],val2[31:24]} : 16'bz;   
  assign valRes1[15:0]=((operation[11:0]=={1'b0,3'b101,8'd`op_mov8}) && nDataAlt) ? {val2[31:24],val1[7:0]} : 16'bz;   
  assign valRes1[15:0]=((operation[11:0]=={1'b0,3'b010,8'd`op_mov8}) && nDataAlt) ? 16'b0 : 16'bz;   
  assign valRes1[15:0]=((operation[11:0]=={1'b0,3'b110,8'd`op_mov8}) && nDataAlt) ? 16'b0 : 16'bz;   
  

  assign valRes1[63:32]=(((operation[11:0]==`op_zxt16_64) || (operation[7:0]==`op_zxt8_64 && ~operation[11]))
    && nDataAlt) ? 32'b0 : 32'bz;   
  assign valRes1[31:16]=((operation[11:0]==`op_zxt16_64 || (operation[7:0]==`op_zxt8_64 && ~operation[11])) && nDataAlt) ? 16'b0 : 16'bz;   
  assign valRes1[15:0]=((operation[11:0]==`op_zxt16_64) && nDataAlt) ?
    val2[15:0] : 16'bz;
  assign valRes1[15:8]=((operation[7:0]==`op_zxt8_64) && ~operation[11] && nDataAlt) ? 8'b0 : 8'bz;   
  assign valRes1[7:0]=((operation[7:0]==`op_zxt8_64) && nDataAlt) ? val2[7:0]: 8'bz;   

  assign cmov_en=~operation[11] && (operation[7:0]==`op_cmov64 || operation[7:0]==`op_cmovn64);

  assign valRes1[63:32]=operation[11:0]==`op_sxt16_32 || (operation[7:0]==`op_sxt8_32 && ~operation[11])
    && nDataAlt ? 32'b0 : 32'bz;   
  assign valRes1[63:32]=((operation[11:0]==`op_sxt16_64) && nDataAlt) ? {32{val2[15]}} : 32'bz;
  assign valRes1[63:32]=((operation[11:0]==`op_sxt32_64) && nDataAlt) ? {32{val2[31]}} : 32'bz;
  assign valRes1[63:32]=((operation[7:0]==`op_sxt8_64) && nDataAlt) ? {32{val2[7]}} : 32'bz;
  assign valRes1[31:16]=(operation[11:0]==`op_sxt32_64 && nDataAlt) ? val2[31:16] : 16'bz;
  assign valRes1[31:16]=((operation[11:0]==`op_sxt16_32 || operation[11:0]==`op_sxt16_64) && nDataAlt) ? {16{val2[15]}} : 16'bz;
  assign valRes1[31:8]=((operation[7:0]==`op_sxt8_32 || operation[7:0]==`op_sxt8_64) 
    && nDataAlt) ? {24{val2[7]}} : 24'bz;
  assign valRes1[15:0]=((operation[11:0]==`op_sxt16_32 || operation[11:0]==`op_sxt16_64 || operation[11:0]==`op_sxt32_64)
    && nDataAlt) ? val2[15:0] : 16'bz;
  assign valRes1[7:0]=((operation[7:0]==`op_sxt8_64 || operation[7:0]==`op_sxt8_32)
    && nDataAlt) ? val2[7:0]: 8'bz;   
  
  assign valRes1[31:0]=((smallOP==`op_cmov64 || smallOP==`op_cmov32 ||
    smallOP==`op_cmovn32 || smallOP==`op_cmovn64) && ~operation[11] && doJmp) ? val2[31:0] : 32'bz;
  assign valRes1[31:0]=((smallOP==`op_cmov64 || smallOP==`op_cmov32 ||
    smallOP==`op_cmovn32 || smallOP==`op_cmovn64) && ~operation[11] && ~doJmp) ? val1[31:0] : 32'bz;

  assign valRes1[31:0]=((smallOP==`op_clahf || smallOP==`op_clahfn) && ~operation[11] ) ? 32'b0 : 32'bz;

  assign valRes1[63:32]=((smallOP==`op_clahf || smallOP==`op_clahfn || 
    smallOP==`op_cmov32 || smallOP==`op_cmovn32) && ~operation[11]) ? 32'b0 : 32'bz;

    
  assign valRes1[63:32]=((smallOP==`op_cmov64 || smallOP==`op_cmovn64) && ~operation[11] && doJmp) ? val2[63:32] : 32'bz;
  assign valRes1[63:32]=((smallOP==`op_cmov64 || smallOP==`op_cmovn64) && ~operation[11] && ~doJmp) ? val1[63:32] : 32'bz;

  assign valRes1[7:0]=((smallOP==`op_cset || smallOP==`op_csetn) && ~operation[11]) ? {7'b0,doJmp} : 8'bz;
  assign valRes1[7:0]=((smallOP==`op_csand || smallOP==`op_csandn) && ~operation[11]) ? {7'b0,doJmp&val1[0]} : 8'bz;
  assign valRes1[7:0]=((smallOP==`op_csor || smallOP==`op_csor_n) && ~operation[11]) ? {7'b0,doJmp|val1[0]} : 8'bz;

  assign valRes1[63:8]=((smallOP==`op_cset || smallOP==`op_csetn ||
      smallOP==`op_csand || smallOP==`op_csandn || smallOP==`op_csor || smallOP==`op_csor_n) && ~operation[11]) ? 56'b0 : 56'bz;
 
  assign is_ptr=val1[64]|val2[64]|(operation[11:0]==12'd58) && ~(val1[64]&val2[64]&is_sub||val2[64]&is_sub) && (add_en&~operation[8])|logic_en|
    (cmov_en&&(doJmp&val2[64]||~doJmp&val1[64]))|(operation[11:0]==12'd58)|(operation[11:0]==`op_mov64) && 
    ((operation[1:0]==2'b0 && operation[7:5]==3'b0|(operation[7:2]==6'b001000))||cmov_en||operation[11:1]==11'd29);

  assign is_sub=operation[7:0]==`op_sub64;

  assign ptr=val1[64] ? val1[63:0] : val2[63:0];
  
  addsub_alu mainAdder_mod(
    .a(val1),
    .b(val2),
    .out(valRes_X),
    .sub(sub),
    .en(add_en),
    .sxtEn(operation[8]),
    .ben({(operation[7:0]==`op_add64 || operation[7:0]==`op_sub64 || operation[7:1]==7'd30 || operation[7:1]==7'd1) && 
    ~is_ptr && ~(val1[64]&val2[64]&is_sub||val2[64]&is_sub),
    (operation[7:0]==`op_add64 || operation[7:0]==`op_sub64 || operation[7:1]==7'd30 || operation[7:1]==7'd1)
      }),
    .cout(carryAdd64),
    .cout4(carryAdd4LL),
    .cout8LL(carryAdd8LL),
    .cout16(carryAdd16),
    .cout32(carryAdd32),
    .cout_sec(cin_seq),
    .ndiff(),
    .cout44(carryAdd44)
    );

  except_jump_cmp jcmp_mod (valS,jumpType,doJmp);
  except_jump_cmp jcmp2_mod (valS,{1'b0,cond[3:0]},doJmp2);
  
 
  assign flag64_ZF=(valRes[63:0]==64'b0);
  assign flag32_ZF=(valRes[31:0]==32'b0);
  assign flag16_ZF=(valRes[15:0]==16'b0);
  assign flag8_ZF=(valRes[7:0]==8'b0);

  
  assign flag8_PF=~^(valRes[7:0]);

  assign flagAdd64_OF=val1[63] & val2[63] & ~valRes[63] | ~val1[63] & ~val2[63] & valRes[63];  
  assign flagAdd32_OF=val1[31] & val2[31] & ~valRes[31] | ~val1[31] & ~val2[31] & valRes[31];  

  assign flagSub44_OF=val1[43] & ~val2[43] & ~valRes[43] | ~val1[43] & val2[43] & valRes[43];  
  assign flagSub64_OF=val1[63] & ~val2[63] & ~valRes[63] | ~val1[63] & val2[63] & valRes[63];  
  assign flagSub32_OF=val1[31] & ~val2[31] & ~valRes[31] | ~val1[31] & val2[31] & valRes[31];  
  assign flagSub16_OF=val1[15] & ~val2[15] & ~valRes[15] | ~val1[15] & val2[15] & valRes[15];  
  assign flagSub8_OF=val1[7] & ~val2[7] & ~valRes[7] | ~val1[7] & val2[7] & valRes[7];  
   
// flag assignment mux
  assign flags_COASZP=((retOp[7:0]==`op_add64 || retOp[7:0]==`op_sub64) && isFlags_reg) ? {carryAdd64_reg&~is_ptr_reg,flagAdd64_OF_reg&~is_ptr_reg,carryAdd4LL_reg&~is_ptr_reg,valRes_reg[63],flag64_ZF_reg,1'b0} : 6'bz;
  assign flags_COASZP=((retOp[7:0]==`op_add32 || retOp[7:0]==`op_sub32) && isFlags_reg) ? {carryAdd32_reg,flagAdd32_OF_reg,carryAdd4LL_reg,valRes_reg[31],flag32_ZF_reg,1'b0} : 6'bz;
  assign flags_COASZP=((retOp[7:1]==7'd1) && isFlags_reg) ? {4'b0,~flag64_ZF_reg&doJmp_reg,1'b0} : 6'bz;
  
  assign flags_COASZP=((retOp[7:0]==`op_sub64) && isFlags_reg && is_ptr_sub) ? {carryAdd44_reg,flagSub44_OF_reg,~carryAdd4LL_reg,valRes_reg[43],flag64_ZF_reg,1'b0} : 6'bz;
  assign flags_COASZP=((retOp[7:0]==`op_sub64) && isFlags_reg && ~is_ptr_sub) ? {carryAdd64_reg & ~is_ptr_reg,flagSub64_OF_reg&~is_ptr_reg,~carryAdd4LL_reg&~is_ptr_reg,valRes_reg[63],flag64_ZF_reg,1'b0} : 6'bz;
  assign flags_COASZP=((retOp[7:0]==`op_sub32) && isFlags_reg) ? {carryAdd32_reg,flagSub32_OF_reg,~carryAdd4LL_reg,valRes_reg[31],flag32_ZF_reg,1'b0} : 6'bz;
  assign flags_COASZP=((retOp[7:0]==`op_cmp16) && isFlags_reg) ? {carryAdd16_reg,flagSub16_OF_reg,~carryAdd4LL_reg,valRes_reg[15],flag16_ZF_reg,1'b0} : 6'bz;
  assign flags_COASZP=((retOp[7:0]==`op_cmp8) && isFlags_reg) ? {carryAdd8LL_reg,flagSub8_OF_reg,~carryAdd4LL_reg,valRes_reg[7],flag8_ZF_reg,1'b0} : 6'bz;

  assign flags_COASZP=((retOp[7:0]==`op_and64) | (retOp==`op_or64) | (retOp==`op_xor64) | (retOp==`op_nxor64) && isFlags_reg) ? 
    {3'b000,valRes_reg[63],flag64_ZF_reg,1'b0} : 6'bz;
  assign flags_COASZP=((retOp[7:0]==`op_and32) | (retOp==`op_or32) | (retOp==`op_xor32) | (retOp[7:1]==7'd5) | (retOp[7:1]==7'd7)
     | (retOp==`op_nxor64) && isFlags_reg) ? {3'b000,valRes_reg[31],flag32_ZF_reg,1'b0} : 6'bz;

  assign flags_COASZP=((|retOp[7:5]) && retOp[7:0]!=`op_lahf && retOp[7:0]!=`op_clahf && retOp[7:0]!=`op_clahfn &&
	  ~retOp[11]) ? 6'b0 : 6'bz;
  assign flags_COASZP=(retOp[7:0]==`op_lahf && ~retOp[11]) ? val1_reg[5:0] : 6'bz;
  assign flags_COASZP=(isFlags_reg&~retOp[11]&(retOp[7:5]==3'b0)) ? 6'bz : 6'b0;  
  assign flags_COASZP=((retOp[7:0]==`op_clahf || retOp[7:0]==`op_clahfn) && doJmp_reg) ? val1_reg[5:0] : 6'bz;
  assign flags_COASZP=((retOp[7:0]==`op_clahf || retOp[7:0]==`op_clahfn) && ~doJmp_reg) ? valS_reg : 6'bz;
  //other stuff
  
  assign retData_X[`except_flags]=nDataAlt_reg && ~shift_en_reg|NOSHIFT 
    && cin_seq_reg|~is_ptr_reg && (~val2_sign65||val1_sign65||retOp[7:0]!=`op_sub64) &&
    (!val1_sign65 || !val2_sign65 || !logic_en_reg)  ? flags_COASZP : 6'bz;
  assign retData_X[`except_flags]=nDataAlt_reg && ~shift_en_reg|NOSHIFT 
    && (~cin_seq_reg & is_ptr_reg || val2_sign65 & ~val1_sign65 & (retOp[7:0]==`op_sub64)
    || val2_sign65 & val1_sign65 & logic_en_reg) ? 6'd11 : 6'bz;
  assign retData_X[`except_status]=nDataAlt_reg && cin_seq_reg|~is_ptr_reg && (~val2_sign65||val1_sign65||retOp[7:0]!=`op_sub64) &&
    (!val1_sign65 || !val2_sign65 || !logic_en_reg) ? 2'd2 : 2'bz; //done
  assign retData_X[`except_status]=nDataAlt_reg && (~cin_seq_reg & is_ptr_reg || val2_sign65 & ~val1_sign65 & (retOp[7:0]==`op_sub64)
    || val2_sign65 & val1_sign65 & logic_en_reg) ? 2'd1 : 2'bz; //done
  assign retData_X[`except_setsFlags]=nDataAlt_reg ? isFlags_reg&dataEn_reg : 1'bz;
  
  assign retEn=nDataAlt_reg ? dataEn_reg & ~retOp[11] &~thrinh_reg : 1'bz; 

  assign thrinh=(thread^~except_thread && except) || (thread^~except_thread_reg && except_reg);

  always @* begin
      case (retOp[10:9])
2'b00: begin
           flagAdd8_CF=carryAdd8LL_reg;
           flagAdd8_AF=carryAdd4LL_reg;
       end
2'b01: begin
           flagAdd8_CF=carryAdd8LH_reg;
           flagAdd8_AF=carryAdd4LH_reg;
       end
2'b10: begin
           flagAdd8_CF=carryAdd8HL_reg;
           flagAdd8_AF=carryAdd4HL_reg;
       end
2'b11: begin
           flagAdd8_CF=carryAdd8HH_reg;
           flagAdd8_AF=carryAdd4HH_reg;
       end
      endcase
  end  
  
`ifndef aluneg
  always @(posedge clk)
`else
  always @(negedge clk)
`end
    begin
//      $display("flg ",valS," jt ",jumpType," j",doJmp," op ",operation);
      if (rst)
        begin
          valRes_reg<=65'b0;
         // retEn<=1'b0;
          isFlags_reg<=1'b1;
          retOp<={OPERATION_WIDTH{1'b0}};

          carryAdd44_reg<=1'b0;
          carryAdd64_reg<=1'b0;
          carryAdd32_reg<=1'b0;
          carryAdd16_reg<=1'b0;
          carryAdd8LL_reg <=1'b0;
          carryAdd8LH_reg <=1'b0;
          carryAdd8HL_reg <=1'b0;
          carryAdd8HH_reg <=1'b0;
          carryAdd4LL_reg <=1'b0;
          carryAdd4LH_reg <=1'b0;
          carryAdd4HL_reg <=1'b0;
          carryAdd4HH_reg <=1'b0;
        
      
          val1_sign65<=1'b0;
          val1_sign64<=1'b0;
          val1_sign44<=1'b0;
          val1_sign32<=1'b0;
          val1_sign16<=1'b0;
          val1_sign8<=1'b0;

          val2_sign44<=1'b0;
          val2_sign65<=1'b0;
          val2_sign64<=1'b0;
          val2_sign32<=1'b0;
          val2_sign16<=1'b0;
          val2_sign8<=1'b0;
          
          val1One_reg<=4'b0;
          
          dataEn_reg<=1'b0;
          
          nDataAlt_reg<=1'b1;
          
          valS_reg<=6'b0;
          val1_reg<=6'b0;

	  shift_en_reg<=1'b0;

	  doJmp_reg<=1'b0;

          thrinh_reg<=1'b0;
          except_reg<=1'b0;
          except_thread_reg<=1'b0;
          cin_seq_reg<=1'b0;
          is_ptr_reg<=1'b0;
	  is_ptr_sub<=1'b0;
	  logic_en_reg<=1'b0;
          
	  flag64_ZF_reg<=1'b0;
          flag32_ZF_reg<=1'b0;
	  flag16_ZF_reg<=1'b0;
          flag8_ZF_reg<=1'b0;
          flag8_PF_reg<=1'b0;
	  flagAdd64_OF_reg<=1'b0;
          flagAdd32_OF_reg<=1'b0;
	  flagSub64_OF_reg<=1'b0;
          flagSub32_OF_reg<=1'b0;
	  flagSub44_OF_reg<=1'b0;
          flagSub16_OF_reg<=1'b0;
          flagSub8_OF_reg<=1'b0;
        end
      else
        begin
          valRes_reg<=valRes;
//          retEn<=dataEn & ~except;
          isFlags_reg<=isFlags;
          retOp<=operation;

          carryAdd64_reg<=carryAdd64^(operation[7:0]==`op_add64 && cary_invert);
          carryAdd44_reg<=carryAdd44^(operation[7:0]==`op_add64 && cary_invert);
          carryAdd32_reg<=carryAdd32^(operation[7:0]==`op_add32 && cary_invert);
          carryAdd16_reg<=carryAdd16;
          carryAdd4LL_reg <=carryAdd4LL;
          carryAdd4HL_reg <=carryAdd4HL;
          carryAdd8LH_reg <=carryAdd8LH;
          carryAdd8HH_reg <=carryAdd8HH;
          carryAdd8LL_reg <=carryAdd8LL;
          carryAdd8HL_reg <=carryAdd8HL;
          carryAdd8LH_reg <=carryAdd8LH;
          carryAdd8HH_reg <=carryAdd8HH;
        

          val1_sign65<=val1[64];
          val1_sign44<=val1[43];
          val1_sign64<=val1[63];
          val1_sign32<=val1[31];
          val1_sign16<=val1[15];
          val1_sign8<=operation[9] ? val1[15] : val1[7];

          val2_sign44<=val2[43];
          val2_sign65<=val2[64];
          val2_sign64<=val2[63];
          val2_sign32<=val2[31];
          val2_sign16<=val2[15];
          val2_sign8<=operation[10] ? val2[15] : val2[7];
          
          val1One_reg<=val1One;
          
          dataEn_reg<=dataEn;
          
          nDataAlt_reg<=nDataAlt;
          
	  doJmp_reg<=doJmp;
	  shift_en_reg<=shift_en;
          valS_reg<=valS;
          val1_reg<=val1[5:0];
          thrinh_reg<=thrinh;
          except_reg<=except;
          except_thread_reg<=except_thread;

          if (add_en) cin_seq_reg<=cin_seq[0];
          else if (operation[7:0]==`op_and64)
              cin_seq_reg<=cin_seq[2];
          else cin_seq_reg<=cin_seq[1]|cmov_en;

          is_ptr_reg<=is_ptr;       
          is_ptr_sub<=val1[64]&val2[64]&is_sub;

	  logic_en_reg<=(operation[7:0]==`op_and64) || (operation[7:0]==`op_or64) || (operation[7:0]==`op_xor64);
	  //$display("LL ",logic_en_reg," ",val1_sign65," ",val2_sign65," ",is_ptr_reg," ",cin_seq_reg);
	  flag64_ZF_reg<=flag64_ZF;
          flag32_ZF_reg<=flag32_ZF;
	  flag16_ZF_reg<=flag16_ZF;
          flag8_ZF_reg<=flag8_ZF;
          flag8_PF_reg<=flag8_PF;
	  flagAdd64_OF_reg<=flagAdd64_OF;
          flagAdd32_OF_reg<=flagAdd32_OF;
	  flagSub64_OF_reg<=flagSub64_OF;
          flagSub32_OF_reg<=flagSub32_OF;
	  flagSub44_OF_reg<=flagSub44_OF;
          flagSub16_OF_reg<=flagSub32_OF;
          flagSub8_OF_reg<=flagSub32_OF;

        end
    end
endmodule



module except_jump_cmp(
  flags,
  jumpType,
  doJump
  );
  parameter JUMP_TYPE_WIDTH=5;
  parameter FLAGS_WIDTH=`flags_width;

  input [FLAGS_WIDTH-1:0] flags;
  input [JUMP_TYPE_WIDTH-1:0] jumpType;
  output reg doJump;

  wire C;
  wire O;
  wire A;
  wire S;
  wire Z;
  wire P;

  assign {C,O,A,S,Z,P}=flags;

  always @(*)
    begin
      case(jumpType)
        `jump_Z:	doJump=Z;
        `jump_nZ:	doJump=~Z;
        `jump_S:	doJump=S;
        `jump_nS:	doJump=~S;
        `jump_uGT:	doJump=~(~C | Z);
        `jump_uLE:	doJump=~C | Z;
        `jump_uGE:	doJump=C;
        `jump_uLT:	doJump=~C;
        `jump_sGT:	doJump=~((S^O)|Z);
        `jump_sLE:	doJump=(S^O)|Z;
        `jump_sGE:	doJump=~S^O;
        `jump_sLT:	doJump=S^O;
        `jump_O:	doJump=O;
        `jump_nO:	doJump=~O;
        `jump_P:	doJump=P;
        `jump_nP:	doJump=1'b1;
        5'b11001:	doJump=0;//wr csrss
        default:	doJump=1;
      endcase
    end
endmodule




