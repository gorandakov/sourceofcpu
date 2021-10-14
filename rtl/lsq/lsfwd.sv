`include "../struct.sv"

module lsf_compare1(
  old_data,
  chk_data,
  banks0,banksX0,Mexact,byBank,Mshift//,overlap
  );

  localparam WIDTH=`lsaddr_width;
  input [WIDTH-1:0] old_data;
  input [WIDTH-1:0] chk_data;
  output [3:0] banks0;
  output [3:0] banksX0;
  output Mexact;
  output byBank;
  output [4:0] Mshift;
//  output overlap;

  wire whole_bank,exact,nocrossmatch,chkAddrE,chkAddrO;
  wire [31:0] match_banks;
  wire [4:0] mbnk0;
  wire [4:0] old_sz;
  wire [4:0] chk_sz;
  wire [1:0] old_low;
  wire [1:0] chk_low;
  wire old_isOL,old_isEL,old_isOH,old_isEH;
  wire chk_isEH,chk_isOH,chk_isEL,chk_isOL;
  wire [31:0] old_banks;
  wire [31:0] chk_banks;
  wire [31:0] old_banks2;
  wire [31:0] chk_banks2;
  wire oc_c;
  wire [7:0] ocdiff;
  wire [7:0] codiff;
  wire [4:0] old_bank0;
  wire [4:0] chk_bank0;
  wire chk_wholebank,old_wholebank;
  wire xmatch;
  wire [3:0] old_bhigh=old_data[`lsaddr_blow];
  wire [3:0] chk_bhigh=chk_data[`lsaddr_blow];
  wire old_hi,chk_hi;

  function [3:0] fsz;
    input [4:0] sz;
    case(sz)
         5'd16: fsz=0;
         5'd17: fsz=1;
         5'd18: fsz=2;
         5'd19: fsz=3;
         5'h3:  fsz=4; //long double
         5'h0,5'h1,5'h2: fsz=5;
         5'hc,5'hd,5'he:  fsz=5; //int, double, single 128 bit (a)
         5'h4,5'h5,5'h6: fsz=2; //singleE,single,singleD
         5'h8,5'h9,5'ha:  fsz=3; //doubleE, double, singlePairD
	 5'hf:fsz=6;
	 default: fsz=3;
    endcase

  endfunction

  function [3:0] wsz; //to ptype
      input [4:0] msz;  
      case(msz)
         5'd16: wsz=0;
         5'd17: wsz=1;
         5'd18: wsz=2;
         5'd19: wsz=3;
         5'h3:  wsz=4; //long double
	 5'h4,5'h5,5'h9,5'hd: wsz=3; //E2d d int64 s64
	 5'h6,5'h7,5'h8: wsz=2; //e2s d2s s2s dp2s
	 5'hf: wsz=6;
	 //0 1 2, a b c = 128 bits,a/u 
	 default: wsz=5;
     endcase
  endfunction

/*  function [3:0] first_bank_b;
      input [1:0] low;
      input [4:0] sz;
      case(low)
      2'd3: first_bank_b=4'b0;
      2'd2: first_bank_b={sz!=5'd0,1'b1,2'b0};
      2'd1: first_bank_b={|sz[4:1],sz!=5'd0,1'b1,1'b0};
      2'd0: first_bank_b={|sz[4:1],|sz[4:1],sz!=5'd0,1'b1};
      endcase
  endfunction*/

  assign old_bank0=old_data[`lsaddr_bank0];
  assign chk_bank0=chk_data[`lsaddr_bank0];
  assign old_sz=old_data[`lsaddr_sz];
  assign chk_sz=chk_data[`lsaddr_sz];
  assign old_low=old_data[`lsaddr_low];
  assign chk_low=chk_data[`lsaddr_low];
  assign old_isEH=old_data[`lsaddr_EH];
  assign old_isOH=old_data[`lsaddr_OH];
  assign old_isEL=old_data[`lsaddr_EL];
  assign old_isOL=old_data[`lsaddr_OL];
  assign chk_isEH=chk_data[`lsaddr_EH];
  assign chk_isOH=chk_data[`lsaddr_OH];
  assign chk_isEL=chk_data[`lsaddr_EL];
  assign chk_isOL=chk_data[`lsaddr_OL];
  assign chk_wholebank=chk_sz!=5'd3 && chk_sz[4:1]!=4'b1000 && chk_sz!=5'hf;
  assign old_wholebank=old_sz!=5'd3 && old_sz[4:1]!=4'b1000 && old_sz!=5'hf;
  assign whole_bank=chk_wholebank && chk_low==old_low;
  assign exact=chk_low==old_low && wsz(chk_sz)==fsz(old_sz) && chk_bank0==old_bank0;
  assign nocrossmatch=(old_sz==16 && (chk_wholebank) && chk_low==0)  ||
     (old_sz==17 && old_low!=2'd3 && (chk_wholebank) && chk_low==0);
  assign chkAddrE=old_data[`lsaddr_addrE]==chk_data[`lsaddr_addrE];
  assign chkAddrO=old_data[`lsaddr_addrO]==chk_data[`lsaddr_addrO];
  assign chk_banks=chk_data[`lsaddr_banks];
  assign old_banks=old_data[`lsaddr_banks];
  assign chk_banks2=chk_low!=0 ? ~{chk_banks[30:0],chk_banks[31]}&chk_banks : chk_banks;
  assign old_banks2=chk_low!=0 ? ~{old_banks[30:0],old_banks[31]}&old_banks : old_banks;
  assign match_banks[15:0]=old_banks[15:0]&chk_banks[15:0]&{16{chk_isOL&old_isOL&chkAddrO||chk_isEL&old_isEL&chkAddrE}}; 
  assign match_banks[31:16]=old_banks[31:16]&chk_banks[31:16]&{16{chk_isOH&old_isOH&chkAddrO||chk_isEH&old_isEH&chkAddrE}}; 
  
  rotate8x4 bankShift0_mod(match_banks,old_data[`lsaddr_bank0],mbnk0);
  assign banksX0=chk_low!=0 ? mbnk0[3:0] & mbnk0 [4:1] : mbnk0[3:0];
  assign banks0=banksX0;
  assign byBank=whole_bank&&old_wholebank&&xmatch;
  assign Mexact=(exact || (nocrossmatch))&&xmatch;
  assign Mshift=exact ? 5'd0 : 5'bz;
  assign Mshift=(~exact & oc_c) ? {1'b0,ocdiff[3:0]} : 5'bz;
  assign Mshift=(~exact & ~oc_c) ? {1'b1,codiff[3:0]} : 5'bz;

  assign xmatch=(old_bhigh&chk_bhigh)!=0 && |match_banks;

  assign old_hi=~|old_bank0[4:3] & &chk_bank0[4:3];
  assign chk_hi=~|chk_bank0[4:3] & &old_bank0[4:3];
  adder #(8) old_chk_sub_mod({old_hi,old_bank0,old_low},~{chk_hi,chk_bank0,chk_low},
    ocdiff,1'b1,1'b1,oc_c,,,);  
  adder #(8) chk_old_sub_mod(~{old_hi,old_bank0,old_low},{chk_hi,chk_bank0,chk_low},
    codiff,1'b1,1'b1,,,,);  
endmodule

module storq_check_same_clk(
  dataA0,dataEnA0,
  dataA1,dataEnA1,
  dataA2,dataEnA2,
  dataA3,dataEnA3,
  dataA4,dataEnA4,
  dataA5,dataEnA5,
  ind0,bits0,
  ind1,bits1,
  ind2,bits2,
  last_wrt,
  has_wrt,
  bits);
  parameter [2:0] INDEX=0;
  localparam DATA_WIDTH=`lsaddr_width;
  input [DATA_WIDTH-1:0] dataA0;
  input dataEnA0;
  input [DATA_WIDTH-1:0] dataA1;
  input dataEnA1;
  input [DATA_WIDTH-1:0] dataA2;
  input dataEnA2;
  input [DATA_WIDTH-1:0] dataA3;
  input dataEnA3;
  input [DATA_WIDTH-1:0] dataA4;
  input dataEnA4;
  input [DATA_WIDTH-1:0] dataA5;
  input dataEnA5;
  input [2:0] ind0;
  input [31:0] bits0;
  input [2:0] ind1;
  input [31:0] bits1;
  input [2:0] ind2;
  input [31:0] bits2;
  output [5:0] last_wrt;
 // output [5:0] wrt;
  output has_wrt;
  output [95:0] bits;

  wire [INDEX:0] confl;
  wire [INDEX:0] Mexact;
  wire [INDEX:0] byBank;
  wire [DATA_WIDTH-1:0] dataA[5:0];
  wire [6:0] dataEnA={1'b0,dataEnA5,dataEnA4,dataEnA3,dataEnA2,dataEnA1,dataEnA0};
  wire [6:0] wrt;
  wire [5:0] chkMatchE;
  wire [5:0] chkMatchO;
  wire [5:0] chkBankH;
  wire [5:0] chkBankL;
  wire [5:0] conflict;
  wire [31:0] chkBanks0; 
  wire [31:0] chkBanks1; 
  wire [31:0] chkBanks2; 
  wire [31:0] chkBanks3; 
  wire [31:0] chkBanks4; 
  wire [31:0] chkBanks5; 
  wire [31:0] banks; 
  wire [31:0] bnkX;
  wire has_wrt0;
   
  generate
      genvar p;
      for(p=0;p[2:0]<=INDEX;p=p+1) begin : cmp_mod
          storq_chk_confl cmp_mod(
          .isOH0(dataA[INDEX][`lsaddr_OH]),.isEH0(dataA[INDEX][`lsaddr_EH]),.isOL0(dataA[INDEX][`lsaddr_OL]),.isEL0(dataA[INDEX][`lsaddr_EL]),
          .isOH1(dataA[p][`lsaddr_OH]),.isEH1(dataA[p][`lsaddr_EH]),.isOL1(dataA[p][`lsaddr_OL]),.isEL1(dataA[p][`lsaddr_EL]),
          .chkMatchE(chkMatchE[p]),.chkMatchO(chkMatchO[p]),
          .chkBankLB(4'b0),.chkBankHB(4'b0),
          .chkBankL(chkBankL[p]),.chkBankH(chkBankH[p]),
          .isBlow(dataA[INDEX][`lsaddr_blow]),.chkBlow(dataA[p][`lsaddr_blow]),
          .isLow(dataA[INDEX][`lsaddr_low]),.chkLow(dataA[p][`lsaddr_low]),
          .chkSz(dataA[p][`lsaddr_sz]),
          .confl(conflict[p]),.conflB());
          assign confl[p]=conflict[p] && dataA[p][`lsaddr_st] && ~dataA[INDEX][`lsaddr_st] && dataEnA[p] && dataEnA[INDEX];
      end
  endgenerate
  //verilator lint_off WIDTH

  bit_find_last_bit #(6) last_mod({6'b0,confl},last_wrt,has_wrt0); 
  //verilator lint_on WIDTH
  
  assign has_wrt=has_wrt0 || ~dataA[INDEX][`lsaddr_st] & (dataA[INDEX][`lsaddr_flag] || dataA[INDEX][`lsaddr_pconfl] 
    || dataA[INDEX][`lsaddr_mtype]==2'b10) & dataEnA[INDEX];
  assign chkBanks0=dataA[0][`lsaddr_banks];
  assign chkBanks1=dataA[1][`lsaddr_banks];
  assign chkBanks2=dataA[2][`lsaddr_banks];
  assign chkBanks3=dataA[3][`lsaddr_banks];
  assign chkBanks4=dataA[4][`lsaddr_banks];
  assign chkBanks5=dataA[5][`lsaddr_banks];
  assign banks=dataA[INDEX][`lsaddr_banks];
  assign bnkX=dataA[INDEX][`lsaddr_low]!=0 ? banks&{banks[0],banks[31:1]} : banks;
  assign chkBankL[0]=(banks[15:0]&chkBanks0[15:0])!=16'b0; 
  assign chkBankH[0]=(banks[31:16]&chkBanks0[31:16])!=16'b0; 
  assign chkBankL[1]=(banks[15:0]&chkBanks1[15:0])!=16'b0; 
  assign chkBankH[1]=(banks[31:16]&chkBanks1[31:16])!=16'b0; 
  assign chkBankL[2]=(banks[15:0]&chkBanks2[15:0])!=16'b0; 
  assign chkBankH[2]=(banks[31:16]&chkBanks2[31:16])!=16'b0; 
  assign chkBankL[3]=(banks[15:0]&chkBanks3[15:0])!=16'b0; 
  assign chkBankH[3]=(banks[31:16]&chkBanks3[31:16])!=16'b0; 
  assign chkBankL[4]=(banks[15:0]&chkBanks4[15:0])!=16'b0; 
  assign chkBankH[4]=(banks[31:16]&chkBanks4[31:16])!=16'b0; 
  assign chkBankL[5]=(banks[15:0]&chkBanks5[15:0])!=16'b0; 
  assign chkBankH[5]=(banks[31:16]&chkBanks5[31:16])!=16'b0; 
  
  assign chkMatchE[0]=dataA[0][`lsaddr_addrE]==dataA[INDEX][`lsaddr_addrE];   
  assign chkMatchO[0]=dataA[0][`lsaddr_addrO]==dataA[INDEX][`lsaddr_addrO];   

  assign chkMatchE[1]=dataA[1][`lsaddr_addrE]==dataA[INDEX][`lsaddr_addrE];   
  assign chkMatchO[1]=dataA[1][`lsaddr_addrO]==dataA[INDEX][`lsaddr_addrO];   

  assign chkMatchE[2]=dataA[2][`lsaddr_addrE]==dataA[INDEX][`lsaddr_addrE];   
  assign chkMatchO[2]=dataA[2][`lsaddr_addrO]==dataA[INDEX][`lsaddr_addrO];   

  assign chkMatchE[3]=dataA[3][`lsaddr_addrE]==dataA[INDEX][`lsaddr_addrE];   
  assign chkMatchO[3]=dataA[3][`lsaddr_addrO]==dataA[INDEX][`lsaddr_addrO];   

  assign chkMatchE[4]=dataA[4][`lsaddr_addrE]==dataA[INDEX][`lsaddr_addrE];   
  assign chkMatchO[4]=dataA[4][`lsaddr_addrO]==dataA[INDEX][`lsaddr_addrO];   

  assign chkMatchE[5]=dataA[5][`lsaddr_addrE]==dataA[INDEX][`lsaddr_addrE];   
  assign chkMatchO[5]=dataA[5][`lsaddr_addrO]==dataA[INDEX][`lsaddr_addrO];   

  assign dataA[0]=dataA0;
  assign dataA[1]=dataA1;
  assign dataA[2]=dataA2;
  assign dataA[3]=dataA3;
  assign dataA[4]=dataA4;
  assign dataA[5]=dataA5;
  //verilator lint_off WIDTH
  assign wrt={6'b0,confl};
  //verilator lint_on WIDTH

  assign bits[31:0]=bits0 & {32{wrt[ind0] && dataEnA[ind0]}};
  assign bits[63:32]=bits1 & {32{wrt[ind1] && dataEnA[ind1]}};
  assign bits[95:64]=bits2 & {32{wrt[ind2] && dataEnA[ind2]}};
endmodule

module lsf_buf(
  clk,
  rst,
  except,
  except_thread,
  newAData0,newEn0,
  newDataXA0,newDataXB0,
  newReqWQA0,
  newReqWQB0,
  newDataA0,newRdyA0,
  newDataB0,newRdyB0,
  newAData1,newEn1,
  newDataXA1,newDataXB1,
  newReqWQA1,
  newReqWQB1,
  newDataA1,newRdyA1,
  newDataB1,newRdyB1,
  portReadyA,
  portReadyB,
  out0DataEn,
  out0Adata,out0XdataA,out0XdataB,
  out0DataA,out0DataB,
  out1DataEn,
  out1Adata,out1XdataA,out1XdataB,
  out1DataA,out1DataB,
  InpWQA,InpEnA,InpDataA,
  InpWQB,InpEnB,InpDataB,
  free
  );
  localparam ADATA_WIDTH=`lsaddr_width;
  localparam XDATA_WIDTH=`lsfxdata_width;
  localparam DATA_WIDTH=128+8+2;
  localparam WQ_WIDTH=8;
  input clk;
  input rst;
  input except;
  input except_thread; //unused
  input [ADATA_WIDTH-1:0] newAData0;
  input newEn0;
  input [XDATA_WIDTH-1:0] newDataXA0;
  input [XDATA_WIDTH-1:0] newDataXB0;
  input [WQ_WIDTH-1:0] newReqWQA0;
  input [WQ_WIDTH-1:0] newReqWQB0;
  input [DATA_WIDTH-1:0] newDataA0;
  input newRdyA0;
  input [DATA_WIDTH-1:0] newDataB0;
  input newRdyB0;
  input [ADATA_WIDTH-1:0] newAData1;
  input newEn1;
  input [XDATA_WIDTH-1:0] newDataXA1;
  input [XDATA_WIDTH-1:0] newDataXB1;
  input [WQ_WIDTH-1:0] newReqWQA1;
  input [WQ_WIDTH-1:0] newReqWQB1;
  input [DATA_WIDTH-1:0] newDataA1;
  input newRdyA1;
  input [DATA_WIDTH-1:0] newDataB1;
  input newRdyB1;
  output portReadyA;
  output portReadyB;
  input out0DataEn;
  output [ADATA_WIDTH-1:0] out0Adata;
  output [XDATA_WIDTH-1:0] out0XdataA;
  output [XDATA_WIDTH-1:0] out0XdataB;
  output [DATA_WIDTH-1:0] out0DataA;
  output [DATA_WIDTH-1:0] out0DataB;
  input out1DataEn;
  output [ADATA_WIDTH-1:0] out1Adata;
  output [XDATA_WIDTH-1:0] out1XdataA;
  output [XDATA_WIDTH-1:0] out1XdataB;
  output [DATA_WIDTH-1:0] out1DataA;
  output [DATA_WIDTH-1:0] out1DataB;
  input [WQ_WIDTH-1:0] InpWQA;
  input InpEnA;
  input [DATA_WIDTH-1:0] InpDataA;
  input [WQ_WIDTH-1:0] InpWQB;
  input InpEnB;
  input [DATA_WIDTH-1:0] InpDataB;
  output reg free;

  reg [ADATA_WIDTH-1:0] adata;
  reg [XDATA_WIDTH-1:0] xdata[1:0];
  reg [DATA_WIDTH-1:0] data[1:0];
  reg [WQ_WIDTH-1:0] WQ[1:0];
  reg rdy[1:0];
  reg which;

  assign out0Adata=out0DataEn ? adata : {ADATA_WIDTH{1'BZ}};
  assign out0XdataA=out0DataEn ? xdata[0] : {XDATA_WIDTH{1'BZ}};
  assign out0XdataB=out0DataEn ? xdata[1] : {XDATA_WIDTH{1'BZ}};
  assign out0DataA=out0DataEn ? data[0] : {DATA_WIDTH{1'BZ}};
  assign out0DataB=out0DataEn ? data[1] : {DATA_WIDTH{1'BZ}};
  assign out1Adata=out1DataEn ? adata : {ADATA_WIDTH{1'BZ}};
  assign out1XdataA=out1DataEn ? xdata[0] : {XDATA_WIDTH{1'BZ}};
  assign out1XdataB=out1DataEn ? xdata[1] : {XDATA_WIDTH{1'BZ}};
  assign out1DataA=out1DataEn ? data[0] : {DATA_WIDTH{1'BZ}};
  assign out1DataB=out1DataEn ? data[1] : {DATA_WIDTH{1'BZ}};
  assign portReadyA=rdy[0]&rdy[1]&~free&~which;
  assign portReadyB=rdy[0]&rdy[1]&~free&which;

  always @(posedge clk) begin
      if (rst) begin
          adata<=0;
          xdata[0]<=0;
          xdata[1]<=0;
          WQ[0]<=0;
          WQ[1]<=0;
          rdy[0]<=0;
          rdy[1]<=0;
          data[0]<=0;
          data[1]<=0;
          free<=1'b1;
	  which<=1'b0;
      end else if (except) begin
	  free<=1'b1;
	  rdy[0]<=1'b0;
	  rdy[1]<=1'b0;
      end else if (newEn0) begin
          adata<=newAData0;
          xdata[0]<=newDataXA0;
          xdata[1]<=newDataXB0;
          WQ[0]<=newReqWQA0;
          WQ[1]<=newReqWQB0;
          rdy[0]<=newRdyA0 | ~newDataXA0[`lsfxdata_has] | (~newDataXA0[`lsfxdata_byBank] & ~newDataXA0[`lsfxdata_Mexact]);
          rdy[1]<=newRdyB0 | ~newDataXB0[`lsfxdata_has] | (~newDataXB0[`lsfxdata_byBank] & ~newDataXB0[`lsfxdata_Mexact]);
          data[0]<=newDataA0;
          data[1]<=newDataB0;
          free<=1'b0;
	  which<=1'b0;
          if (InpWQA== newReqWQA0 && InpEnA) begin
              data[0]<=InpDataA;
              rdy[0]<=1'b1;
          end
          if (InpWQA==newReqWQB0 && InpEnA) begin
              data[1]<=InpDataA;
              rdy[1]<=1'b1;
          end
          if (InpWQB==newReqWQA0 && InpEnB) begin
              data[0]<=InpDataB;
              rdy[0]<=1'b1;
          end
          if (InpWQB==newReqWQB0 && InpEnB) begin
              data[1]<=InpDataB;
              rdy[1]<=1'b1;
          end
      end else if (newEn1) begin
          adata<=newAData1;
          xdata[0]<=newDataXA1;
          xdata[1]<=newDataXB1;
          WQ[0]<=newReqWQA1;
          WQ[1]<=newReqWQB1;
          rdy[0]<=newRdyA1 | ~newDataXA1[`lsfxdata_has] | (~newDataXA1[`lsfxdata_byBank] & ~newDataXA1[`lsfxdata_Mexact]);
          rdy[1]<=newRdyB1 | ~newDataXB1[`lsfxdata_has] | (~newDataXB1[`lsfxdata_byBank] & ~newDataXB1[`lsfxdata_Mexact]);
          data[0]<=newDataA1;
          data[1]<=newDataB1;
          free<=1'b0;
	  which<=1'b1;
          if (InpWQA== newReqWQA1 && InpEnA) begin
              data[0]<=InpDataA;
              rdy[0]<=1'b1;
          end
          if (InpWQA==newReqWQB1 && InpEnA) begin
              data[1]<=InpDataA;
              rdy[1]<=1'b1;
          end
          if (InpWQB==newReqWQA1 && InpEnB) begin
              data[0]<=InpDataB;
              rdy[0]<=1'b1;
          end
          if (InpWQB==newReqWQB1 && InpEnB) begin
              data[1]<=InpDataB;
              rdy[1]<=1'b1;
          end
      end else if (out0DataEn|out1DataEn) begin
          free<=1'b1;
          rdy[0]<=1'b0;
          rdy[1]<=1'b0;
      end else begin
          if (InpWQA==WQ[0] && InpEnA && ~rdy[0]) begin
              data[0]<=InpDataA;
              rdy[0]<=1'b1;
          end
          if (InpWQA==WQ[1] && InpEnA && ~rdy[1]) begin
              data[1]<=InpDataA;
              rdy[1]<=1'b1;
          end
          if (InpWQB==WQ[0] && InpEnB && ~rdy[0]) begin
              data[0]<=InpDataB;
              rdy[0]<=1'b1;
          end
          if (InpWQB==WQ[1] && InpEnB && ~rdy[1]) begin
              data[1]<=InpDataB;
              rdy[1]<=1'b1;
          end
      end 
  end
endmodule



module lsf_array(
  clk,
  rst,
  except,
  excpt_thread,
  stall,
  doStall,
  newAData0,newEn0,
  newDataXA0,newDataXB0,
  newReqWQA0,
  newReqWQB0,
  newDataA0,newRdyA0,
  newDataB0,newRdyB0,
  newAData1,newEn1,
  newDataXA1,newDataXB1,
  newReqWQA1,
  newReqWQB1,
  newDataA1,newRdyA1,
  newDataB1,newRdyB1,
  out0PortEn,
  out0Adata,out0XdataA,out0XdataB,
  out0DataA,out0DataB,
  out1PortEn,
  out1Adata,out1XdataA,out1XdataB,
  out1DataA,out1DataB,
  InpWQA,InpEnA,InpDataA,
  InpWQB,InpEnB,InpDataB
  );
  localparam ADATA_WIDTH=`lsaddr_width;
  localparam XDATA_WIDTH=`lsfxdata_width;
  localparam DATA_WIDTH=128+8+2;
  localparam WQ_WIDTH=8;
  localparam BUF_COUNT=48;

  input clk;
  input rst;
  input except;
  input excpt_thread;
  input stall;
  output doStall;
  input [ADATA_WIDTH-1:0] newAData0;
  input newEn0;
  input [XDATA_WIDTH-1:0] newDataXA0;
  input [XDATA_WIDTH-1:0] newDataXB0;
  input [WQ_WIDTH-1:0] newReqWQA0;
  input [WQ_WIDTH-1:0] newReqWQB0;
  input [DATA_WIDTH-1:0] newDataA0;
  input newRdyA0;
  input [DATA_WIDTH-1:0] newDataB0;
  input newRdyB0;
  input [ADATA_WIDTH-1:0] newAData1;
  input newEn1;
  input [XDATA_WIDTH-1:0] newDataXA1;
  input [XDATA_WIDTH-1:0] newDataXB1;
  input [WQ_WIDTH-1:0] newReqWQA1;
  input [WQ_WIDTH-1:0] newReqWQB1;
  input [DATA_WIDTH-1:0] newDataA1;
  input newRdyA1;
  input [DATA_WIDTH-1:0] newDataB1;
  input newRdyB1;
  input out1PortEn;
  output [ADATA_WIDTH-1:0] out1Adata;
  output [XDATA_WIDTH-1:0] out1XdataA;
  output [XDATA_WIDTH-1:0] out1XdataB;
  output [DATA_WIDTH-1:0] out1DataA;
  output [DATA_WIDTH-1:0] out1DataB;
  input out0PortEn;
  output [ADATA_WIDTH-1:0] out0Adata;
  output [XDATA_WIDTH-1:0] out0XdataA;
  output [XDATA_WIDTH-1:0] out0XdataB;
  output [DATA_WIDTH-1:0] out0DataA;
  output [DATA_WIDTH-1:0] out0DataB;
  input [WQ_WIDTH-1:0] InpWQA;
  input InpEnA;
  input [DATA_WIDTH-1:0] InpDataA;
  input [WQ_WIDTH-1:0] InpWQB;
  input InpEnB;
  input [DATA_WIDTH-1:0] InpDataB;

  wire [BUF_COUNT-1:0] allocA;
  wire allocA_has;
  wire [BUF_COUNT-1:0] allocB;
  wire allocB_has;
  wire [BUF_COUNT-1:0] free;
  wire [BUF_COUNT-1:0] newEnP0;
  wire [BUF_COUNT-1:0] newEnP1;
  wire [BUF_COUNT-1:0] portReadyA;
  wire [BUF_COUNT-1:0] portReadyB;
  wire [BUF_COUNT-1:0] out1DataEn;
  wire [5:0] out1BankEn;
  wire out1HasEn;
  wire [BUF_COUNT-1:0] out0DataEn;
  wire [5:0] out0BankEn;
  wire out0HasEn;

  bit_find_first_bit #(BUF_COUNT) freeA_mod(free,allocA,allocA_has);
  bit_find_last_bit #(BUF_COUNT) freeB_mod(free,allocB,allocB_has);
  rsSelectFifo48 sel_mod(
  .clk(clk),
  .rst(rst),
  .except(except),
  .portReady(portReadyA),
  .portEn(out0PortEn),
  .found(out0HasEn),
  .rsSelect(out0DataEn),
  .rsSel8(out0BankEn)
  );
  rsSelectFifo48 sel1_mod(
  .clk(clk),
  .rst(rst),
  .except(except),
  .portReady(portReadyB),
  .portEn(out1PortEn),
  .found(out1HasEn),
  .rsSelect(out1DataEn),
  .rsSel8(out1BankEn)
  );

  generate
      genvar b,c;
      for(b=0;b<6;b=b+1) begin : banks_gen
          wire [ADATA_WIDTH-1:0] out0Adatak;
          wire [XDATA_WIDTH-1:0] out0XdataAk;
          wire [XDATA_WIDTH-1:0] out0XdataBk;
          wire [DATA_WIDTH-1:0] out0DataAk;
          wire [DATA_WIDTH-1:0] out0DataBk;
          wire [ADATA_WIDTH-1:0] out1Adatak;
          wire [XDATA_WIDTH-1:0] out1XdataAk;
          wire [XDATA_WIDTH-1:0] out1XdataBk;
          wire [DATA_WIDTH-1:0] out1DataAk;
          wire [DATA_WIDTH-1:0] out1DataBk;
          for(c=0;c<8;c=c+1) begin : buf_gen
              lsf_buf buf_mod(
              clk,
              rst,
	      except,
	      excpt_thread,
              newAData0,newEnP0[b*8+c],
              newDataXA0,newDataXB0,
              newReqWQA0,
              newReqWQB0,
              newDataA0,newRdyA0,
              newDataB0,newRdyB0,
              newAData1,newEnP1[b*8+c],
              newDataXA1,newDataXB1,
              newReqWQA1,
              newReqWQB1,
              newDataA1,newRdyA1,
              newDataB1,newRdyB1,
              portReadyA[b*8+c],
              portReadyB[b*8+c],
	      out0DataEn[b*8+c],
              out0Adatak,out0XdataAk,out0XdataBk,
              out0DataAk,out0DataBk,
	      out1DataEn[b*8+c],
              out1Adatak,out1XdataAk,out1XdataBk,
              out1DataAk,out1DataBk,
              InpWQA,InpEnA,InpDataA,
              InpWQB,InpEnB,InpDataB,
              free[b*8+c]
              );
          end
          assign out0Adatak=out0BankEn[b] ? {ADATA_WIDTH{1'BZ}} : {ADATA_WIDTH{1'B0}};
          assign out0XdataAk=out0BankEn[b] ? {XDATA_WIDTH{1'BZ}} : {XDATA_WIDTH{1'B0}};
          assign out0XdataBk=out0BankEn[b] ? {XDATA_WIDTH{1'BZ}} : {XDATA_WIDTH{1'B0}};
          assign out0DataAk=out0BankEn[b] ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
          assign out0DataBk=out0BankEn[b] ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};

          assign out1Adatak=out1BankEn[b] ? {ADATA_WIDTH{1'BZ}} : {ADATA_WIDTH{1'B0}};
          assign out1XdataAk=out1BankEn[b] ? {XDATA_WIDTH{1'BZ}} : {XDATA_WIDTH{1'B0}};
          assign out1XdataBk=out1BankEn[b] ? {XDATA_WIDTH{1'BZ}} : {XDATA_WIDTH{1'B0}};
          assign out1DataAk=out1BankEn[b] ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
          assign out1DataBk=out1BankEn[b] ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};

          assign out1Adata=out1BankEn[b] ? out1Adatak : {ADATA_WIDTH{1'BZ}};
          assign out1XdataA=out1BankEn[b] ? out1XdataAk : {XDATA_WIDTH{1'BZ}};
          assign out1XdataB=out1BankEn[b] ? out1XdataBk : {XDATA_WIDTH{1'BZ}};
          assign out1DataA=out1BankEn[b] ? out1DataAk : {DATA_WIDTH{1'BZ}};
          assign out1DataB=out1BankEn[b] ? out1DataBk : {DATA_WIDTH{1'BZ}};
          
	  assign out0Adata=out0BankEn[b] ? out0Adatak : {ADATA_WIDTH{1'BZ}};
          assign out0XdataA=out0BankEn[b] ? out0XdataAk : {XDATA_WIDTH{1'BZ}};
          assign out0XdataB=out0BankEn[b] ? out0XdataBk : {XDATA_WIDTH{1'BZ}};
          assign out0DataA=out0BankEn[b] ? out0DataAk : {DATA_WIDTH{1'BZ}};
          assign out0DataB=out0BankEn[b] ? out0DataBk : {DATA_WIDTH{1'BZ}};
      end
  endgenerate
  
  assign out0Adata=out0HasEn ?  {ADATA_WIDTH{1'BZ}} : {ADATA_WIDTH{1'B0}};
  assign out0XdataA=out0HasEn ? {XDATA_WIDTH{1'BZ}} : {XDATA_WIDTH{1'B0}};
  assign out0XdataB=out0HasEn ? {XDATA_WIDTH{1'BZ}} : {XDATA_WIDTH{1'B0}};
  assign out0DataA=out0HasEn ?  {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign out0DataB=out0HasEn ?  {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  
  assign out1Adata=out1HasEn ?  {ADATA_WIDTH{1'BZ}} : {ADATA_WIDTH{1'B0}};
  assign out1XdataA=out1HasEn ? {XDATA_WIDTH{1'BZ}} : {XDATA_WIDTH{1'B0}};
  assign out1XdataB=out1HasEn ? {XDATA_WIDTH{1'BZ}} : {XDATA_WIDTH{1'B0}};
  assign out1DataA=out1HasEn ?  {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign out1DataB=out1HasEn ?  {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  
  assign newEnP0=allocA & {BUF_COUNT{~stall & ~doStall & newEn0}};
  assign newEnP1=allocB & {BUF_COUNT{~stall & ~doStall & newEn1}};
  assign doStall=allocA==free;
endmodule


module lsfw_combine(
  xdataA,xdataB,
  dataA,dataB,
  pdataA,pdataB,
  data_req,
  outData,
  outPData,
  outBnRead
  );
  localparam XDATA_WIDTH=`lsfxdata_width;
  localparam DATA_WIDTH=128+8;
  input [XDATA_WIDTH-1:0] xdataA;
  input [XDATA_WIDTH-1:0] xdataB;
  input [DATA_WIDTH-1:0] dataA;
  input [DATA_WIDTH-1:0] dataB;
  input [1:0] pdataA;
  input [1:0] pdataB;
  input [`lsaddr_width-1:0] data_req;
  output [DATA_WIDTH-1:0] outData;
  output [1:0] outPData;
  output reg [3:0] outBnRead;

  wire hasA=xdataA[`lsfxdata_has];
  wire byBankA=xdataA[`lsfxdata_byBank];
  wire MexactA=xdataA[`lsfxdata_Mexact];
  wire [3:0] banksA=xdataA[`lsfxdata_banks];
  wire [4:0] MshiftA=xdataA[`lsfxdata_Mshift];
  wire hasB=xdataB[`lsfxdata_has];
  wire byBankB=xdataB[`lsfxdata_byBank];
  wire MexactB=xdataB[`lsfxdata_Mexact];
  wire [3:0] banksB=xdataB[`lsfxdata_banks];
  wire [4:0] MshiftB=xdataB[`lsfxdata_Mshift];
  wire [127+8:0] dataMA;
  wire [127+8:0] dataMB;
  wire [127+8:0] dataNA;
  wire [127+8:0] dataNB;
  wire [127+8:0] dataQA;
  wire [127+8:0] dataQB;
  wire [15:0] pdataMA;
  wire [15:0] pdataMB;
  wire [15:0] pdataNA;
  wire [15:0] pdataNB;
  wire [15:0] pdataQA;
  wire [15:0] pdataQB;
  wire [3:0] opsz;
  wire [127+8:0] mask;
  
  function [3:0] fsz;
    input [4:0] sz;
    case(sz)
         5'd16: fsz=0;
         5'd17: fsz=1;
         5'd18: fsz=2;
         5'd19: fsz=3;
         5'h3:  fsz=4; //long double
         5'h0,5'h1,5'h2: fsz=5;
         5'hc,5'hd,5'he:  fsz=5; //int, double, single 128 bit (a)
         5'h4,5'h5,5'h6: fsz=2; //singleE,single,singleD
         5'h8,5'h9,5'ha:  fsz=3; //doubleE, double, singlePairD
	 5'hf:fsz=6;
	 default: fsz=3;
    endcase

  endfunction

  assign opsz=fsz(data_req[`lsaddr_sz]);
  assign mask[7:0]=8'hff;
  assign mask[15:8]={8{opsz!=4'd0}};
  assign mask[31:16]={16{opsz[3:1]!=3'b0}};
  assign mask[63:32]={32{opsz==3||opsz[3:2]!=2'b0}};
  assign mask[79:64]={16{opsz[3:2]!=2'b0}};
  assign mask[127:80]={48{opsz==4'd5 || opsz==4'd6}};
  assign mask[127+8:128]={8{opsz==4'd6}};
  generate
      genvar t,k;
      for(t=0;t<4;t=t+1) begin
          assign outData[t*32+:8*(t==3)+32]=(byBankA & banksA[t] || MexactA) ? 
	      dataQA[32*t+:8*(t==3)+32]&mask[32*t+:8*(t==3)+32] : 
	      dataQB[32*t+:8*(t==3)+32]&mask[32*t+:8*(t==3)+32]; 
      end
      for(k=0;k<16;k=k+1) begin
          assign dataMA=(MshiftA[3:0]==k) ? dataA>>(k*8) : 136'BZ;
          assign dataMB=(MshiftB[3:0]==k) ? dataB>>(k*8) : 136'BZ;
          assign dataNA=(MshiftA[3:0]==k) ? dataA<<(k*8) : 136'BZ;
          assign dataNB=(MshiftB[3:0]==k) ? dataB<<(k*8) : 136'BZ;
	  assign pdataMA=(MshiftA[3:0]==k) ? {{8{pdataA[1]}},{8{pdataA[0]}}}>>k : 16'bz;
	  assign pdataMB=(MshiftB[3:0]==k) ? {{8{pdataB[1]}},{8{pdataB[0]}}}>>k : 16'bz;
	  assign pdataNA=(MshiftA[3:0]==k) ? {{8{pdataA[1]}},{8{pdataA[0]}}}<<k : 16'bz;
	  assign pdataNB=(MshiftB[3:0]==k) ? {{8{pdataB[1]}},{8{pdataB[0]}}}<<k : 16'bz;
      end
  endgenerate

  assign dataQA=~MshiftA[4] ? dataMA : dataNA;
  assign dataQB=~MshiftB[4] ? dataMB : dataNB;
  assign pdataQA=~MshiftA[4] ? pdataMA : pdataNA;
  assign pdataQB=~MshiftB[4] ? pdataMB : pdataNB;
          
  assign outPData[0]=(byBankA & banksA[0] || MexactA) ? pdataQA[0] : 
      pdataQB[0]; 
  assign outPData[1]=(byBankA & banksA[2] || MexactA) ? pdataQA[8] : 
      pdataQB[8]; 

//  assign outData=MexactA ? dataMA : 128'BZ;
//  assign outData=hasA ? 128'BZ : 128'b0;

  always @* begin
      outBnRead=4'b0;
      if (MexactA || MexactB & hasB & byBankA) outBnRead= 4'b0;
      if (byBankA & byBankB & hasB) outBnRead=~(banksA|banksB);  
      if (byBankA && ~hasB) outBnRead= ~banksA;
      if (~MexactA && ~byBankA) outBnRead= 4'hf;  
  end
  
endmodule

