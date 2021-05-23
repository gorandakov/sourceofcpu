`include "../struct.sv"




module storq_genaddr(
  conflictM,
  conflictN,
  bit0,bank0,has0,
  bit1,bank1,has1,
  bit2,bank2,has2,
//  bit,
//  on_M,
  multi
  );
  localparam BUF_COUNT=32;
  localparam BUF3_COUNT=96;
  input [BUF3_COUNT-1:0] conflictN;
  input [BUF3_COUNT-1:0] conflictM;
  output [BUF_COUNT-1:0] bit0;
  output [3:0] bank0;
  output has0;
  output [BUF_COUNT-1:0] bit1;
  output [3:0] bank1;
  output has1;
  output [BUF_COUNT-1:0] bit2;
  output [3:0] bank2;
  output has2;
//  output [BUF3_COUNT-1:0] bit;
//  input [2:0] on_M;
  output multi;

  wire [BUF3_COUNT-1:0] bitN;
  wire [BUF3_COUNT-1:0] bitN_first;
  wire [BUF3_COUNT-1:0] BITN_first;
  wire [3:0] bankN[2:0];
  wire hasN;
  wire [BUF3_COUNT-1:0] bitM;
  wire [BUF3_COUNT-1:0] bitM_first;
  wire [BUF3_COUNT-1:0] BITM_first;
  wire [3:0] bankM[2:0];
  wire hasM;
  wire [2:0] muM;
  wire [2:0] muN;
  wire [2:0] hhasM;
  wire [2:0] hhasN;
  
  generate
      genvar h,q;
      for(h=0;h<3;h=h+1) begin : first_gen
         // assign muN[h]=bitN[h]&conflictN[h*BUF_COUNT+:BUF_COUNT]!=conflictN[h*BUF_COUNT+:BUF_COUNT];
         // assign muM[h]=bitM[h]&conflictM[h*BUF_COUNT+:BUF_COUNT]!=conflictM[h*BUF_COUNT+:BUF_COUNT];
          for(q=0;q<BUF_COUNT;q=q+1) begin
              assign bitN[q*3+h]=conflictN[h*BUF_COUNT+q];
              assign bitM[q*3+h]=conflictM[h*BUF_COUNT+q];
              assign BITN_first[h*BUF_COUNT+q]=bitN_first[q*3+h];
              assign BITM_first[h*BUF_COUNT+q]=bitM_first[q*3+h];
          end
      end
  endgenerate
  bit_find_last_bit #(BUF3_COUNT) bitKL_mod(bitN,bitN_first,hasN);
  bit_find_last_bit #(BUF3_COUNT) bitKLM_mod(bitM,bitM_first,hasM);

  assign bit0=hasM ? BITM_first[31:0] : BITN_first[31:0];
  assign bit1=hasM ? BITM_first[63:32] : BITN_first[63:32];
  assign bit2=hasM ? BITM_first[95:64] : BITN_first[95:64];
  assign bankN[0]={|BITN_first[31:24],|BITN_first[23:16],|BITN_first[15:8],|BITN_first[7:0]};
  assign bankN[1]={|BITN_first[31+32:24+32],|BITN_first[23+32:16+32],|BITN_first[15+32:8+32],|BITN_first[7+32:0+32]};
  assign bankN[2]={|BITN_first[31+64:24+64],|BITN_first[23+64:16+64],|BITN_first[15+64:8+64],|BITN_first[7+64:0+64]};
  assign bankM[0]={|BITM_first[31:24],|BITM_first[23:16],|BITM_first[15:8],|BITM_first[7:0]};
  assign bankM[1]={|BITM_first[31+32:24+32],|BITM_first[23+32:16+32],|BITM_first[15+32:8+32],|BITM_first[7+32:0+32]};
  assign bankM[2]={|BITM_first[31+64:24+64],|BITM_first[23+64:16+64],|BITM_first[15+64:8+64],|BITM_first[7+64:0+64]};
  assign hhasN[0]=|bankN[0];
  assign hhasN[1]=|bankN[1];
  assign hhasN[2]=|bankN[2];
  assign hhasM[0]=|bankM[0];
  assign hhasM[1]=|bankM[1];
  assign hhasM[2]=|bankM[2];
  assign bank0=hasM ? bankM[0] : bankN[0];
  assign bank1=hasM ? bankM[1] : bankN[1];
  assign bank2=hasM ? bankM[2] : bankN[2];
  //up to here
  assign has0=hasM ? hhasM[0] : hhasN[0];
  assign has1=hasM ? hhasM[1] : hhasN[1];
  assign has2=hasM ? hhasM[2] : hhasN[2];
  
  assign multi=hasM ? (conflictM&~BITM_first)!=0 || hasN : |(conflictN&~BITN_first);
endmodule
   




module storq_chk_confl(
  isOH0,isEH0,isOL0,isEL0,
  isOH1,isEH1,isOL1,isEL1,
  chkMatchE,chkMatchO,
  chkBankLB,chkBankHB,
  chkBankL,chkBankH,
  isBlow,chkBlow,
  chkSz,isLow,chkLow,
  confl,conflB
  );
  localparam WIDTH=`lsaddr_width;

  input isOH0;
  input isEH0;
  input isOL0;
  input isEL0;

  input isOH1;
  input isEH1;
  input isOL1;
  input isEL1;

  input chkMatchE;
  input chkMatchO;

  input [3:0] chkBankLB;
  input [3:0] chkBankHB;
  input chkBankL;
  input chkBankH;

  input [3:0] isBlow;
  input [3:0] chkBlow;
  input [4:0] chkSz;
  input [1:0] isLow;
  input [1:0] chkLow;

  output confl;
  output [3:0] conflB;

  wire blowc;
  wire sz_en;

  assign blowc=(chkBlow&isBlow)!=4'b0;
  assign sz_en=chkSz!=5'd3 && (chkSz[3:1]!=0 || ~chkSz[4] ) && isLow==chkLow;
  
  assign conflB=(({4{isOH0 & isOH1 & chkMatchO}} & chkBankHB) |
    ({4{isOL0 & isOL1 & chkMatchO}} & chkBankLB) |
    ({4{isEH0 & isEH1 & chkMatchE}} & chkBankHB) |
    ({4{isEL0 & isEL1 & chkMatchE}} & chkBankLB))&{4{blowc&sz_en}};    
  assign confl=((isOH0 & isOH1 & chkMatchO & chkBankH) |
    (isOL0 & isOL1 & chkMatchO & chkBankL) |
    (isEH0 & isEH1 & chkMatchE & chkBankH) |
    (isEL0 & isEL1 & chkMatchE & chkBankL))&blowc;    
  
endmodule


module storq_buf(
  clk,
  rst,
  except,excpt_thread,
  newAddrE0,newAddrO0,newBanks0,newBanksX0,newBlow0,newII0,newIIMask0,newIsOH0,newIsEH0,newIsOL0,newIsEL0,newId0,newEn0,newOK0,
  newSZ0,newBankA0,newOdd0,newAddrLow0,newSplit0,newThread0,
  chkAddrE0,chkAddrO0,chkBanks0,chkBanksX0,chkBlow0,chkAddrLow0, chkIsOH0,chkIsEH0,chkIsOL0,chkIsEL0,chkMatch0,chkMatchIn0,chkEn0,
  chkAddrE1,chkAddrO1,chkBanks1,chkBanksX1,chkBlow1,chkAddrLow1, chkIsOH1,chkIsEH1,chkIsOL1,chkIsEL1,chkMatch1,chkMatchIn1,chkEn1,
  chkAddrE2,chkAddrO2,chkBanks2,chkBanksX2,chkBlow2,chkAddrLow2, chkIsOH2,chkIsEH2,chkIsOL2,chkIsEL2,chkMatch2,chkMatchIn2,chkEn2,
  chkAddrE3,chkAddrO3,chkBanks3,chkBanksX3,chkBlow3,chkAddrLow3, chkIsOH3,chkIsEH3,chkIsOL3,chkIsEL3,chkMatch3,chkMatchIn3,chkEn3,
  chkAddrE4,chkAddrO4,chkBanks4,chkBanksX4,chkBlow4,chkAddrLow4, chkIsOH4,chkIsEH4,chkIsOL4,chkIsEL4,chkMatch4,chkMatchIn4,chkEn4,
  chkAddrE5,chkAddrO5,chkBanks5,chkBanksX5,chkBlow5,chkAddrLow5, chkIsOH5,chkIsEH5,chkIsOL5,chkIsEL5,chkMatch5,chkMatchIn5,chkEn5,
  chkBAddrE0,chkBAddrO0,chkBBanks0,chkBBanksX0,chkBBlow0,chkBAddrLow0, chkBIsOH0,chkBIsEH0,chkBIsOL0,chkBIsEL0,chkBMatch0,chkBEn0,
  chkBAddrE1,chkBAddrO1,chkBBanks1,chkBBanksX1,chkBBlow1,chkBAddrLow1, chkBIsOH1,chkBIsEH1,chkBIsOL1,chkBIsEL1,chkBMatch1,chkBEn1,
  chkBAddrE2,chkBAddrO2,chkBBanks2,chkBBanksX2,chkBBlow2,chkBAddrLow2, chkBIsOH2,chkBIsEH2,chkBIsOL2,chkBIsEL2,chkBMatch2,chkBEn2,
  chkBAddrE3,chkBAddrO3,chkBBanks3,chkBBanksX3,chkBBlow3,chkBAddrLow3, chkBIsOH3,chkBIsEH3,chkBIsOL3,chkBIsEL3,chkBMatch3,chkBEn3,
  chkAddrE6,chkAddrO6, chkIsOH6,chkIsEH6,chkIsOL6,chkIsEL6,chkMatch6,
  nChNext0,
  nChNext1,
  freeEn0,
  freeII1A,freeEn1A,
  freeII1B,freeEn1B,
  freeII1A_r,freeEn1A_r,
  freeII1B_r,freeEn1B_r,
  ret_II,ret_mask,ret_en,ret_hit,
  newII_upper,newII_chk,
  free0,
  free1
  );
  /*
    free ports used for actual write (2x)
    read ports used for clarifying store-to-load forwarding
  */
  parameter INDEX=0;
  localparam PADDR_WIDTH=44;
  localparam BANK_COUNT=32;
  localparam II_WIDTH=10;
  localparam ADDR_WIDTH=4;
 
  input clk;
  input rst;

  input except;
  input excpt_thread;

  input [PADDR_WIDTH-9:0] newAddrE0;
  input [PADDR_WIDTH-9:0] newAddrO0;
  input [31:0] newBanks0;
  input [31:0] newBanksX0;
  input [3:0] newBlow0;
  input [II_WIDTH-1:0] newII0;
  input [9:0] newIIMask0;
  input newIsOH0,newIsEH0,newIsOL0,newIsEL0;
  input [4:0] newId0;
  input newEn0;
  input newOK0;
  input [4:0] newSZ0;
  input [4:0] newBankA0;
  input newOdd0;
  input [1:0] newAddrLow0;
  input newSplit0;
  input newThread0;

  input [PADDR_WIDTH-9:0] chkAddrE0;
  input [PADDR_WIDTH-9:0] chkAddrO0;
  input [31:0] chkBanks0;
  input [31:0] chkBanksX0;
  input [3:0] chkBlow0;
  input [1:0] chkAddrLow0;
  input chkIsOH0,chkIsEH0,chkIsOL0,chkIsEL0;
  output chkMatch0;
  input chkMatchIn0;
  input chkEn0;
  input [PADDR_WIDTH-9:0] chkAddrE1;
  input [PADDR_WIDTH-9:0] chkAddrO1;
  input [31:0] chkBanks1;
  input [31:0] chkBanksX1;
  input [3:0] chkBlow1;
  input [1:0] chkAddrLow1;
  input chkIsOH1,chkIsEH1,chkIsOL1,chkIsEL1;
  output chkMatch1;
  input chkMatchIn1;
  input chkEn1;
  input [PADDR_WIDTH-9:0] chkAddrE2;
  input [PADDR_WIDTH-9:0] chkAddrO2;
  input [31:0] chkBanks2;
  input [31:0] chkBanksX2;
  input [3:0] chkBlow2;
  input [1:0] chkAddrLow2;
  input chkIsOH2,chkIsEH2,chkIsOL2,chkIsEL2;
  output chkMatch2;
  input chkMatchIn2;
  input chkEn2;
  input [PADDR_WIDTH-9:0] chkAddrE3;
  input [PADDR_WIDTH-9:0] chkAddrO3;
  input [31:0] chkBanks3;
  input [31:0] chkBanksX3;
  input [3:0] chkBlow3;
  input [1:0] chkAddrLow3;
  input chkIsOH3,chkIsEH3,chkIsOL3,chkIsEL3;
  output chkMatch3;
  input chkMatchIn3;
  input chkEn3;
  input [PADDR_WIDTH-9:0] chkAddrE4;
  input [PADDR_WIDTH-9:0] chkAddrO4;
  input [31:0] chkBanks4;
  input [31:0] chkBanksX4;
  input [3:0] chkBlow4;
  input [1:0] chkAddrLow4;
  input chkIsOH4,chkIsEH4,chkIsOL4,chkIsEL4;
  output chkMatch4;
  input chkMatchIn4;
  input chkEn4;
  input [PADDR_WIDTH-9:0] chkAddrE5;
  input [PADDR_WIDTH-9:0] chkAddrO5;
  input [31:0] chkBanks5;
  input [31:0] chkBanksX5;
  input [3:0] chkBlow5;
  input [1:0] chkAddrLow5;
  input chkIsOH5,chkIsEH5,chkIsOL5,chkIsEL5;
  output chkMatch5;
  input chkMatchIn5;
  input chkEn5;
  input [PADDR_WIDTH-9:0] chkBAddrE0;
  input [PADDR_WIDTH-9:0] chkBAddrO0;
  input [31:0] chkBBanks0;
  input [31:0] chkBBanksX0;
  input [3:0] chkBBlow0;
  input [1:0] chkBAddrLow0;
  input chkBIsOH0,chkBIsEH0,chkBIsOL0,chkBIsEL0;
  output chkBMatch0;
  input chkBEn0;
  input [PADDR_WIDTH-9:0] chkBAddrE1;
  input [PADDR_WIDTH-9:0] chkBAddrO1;
  input [31:0] chkBBanks1;
  input [31:0] chkBBanksX1;
  input [3:0] chkBBlow1;
  input [1:0] chkBAddrLow1;
  input chkBIsOH1,chkBIsEH1,chkBIsOL1,chkBIsEL1;
  output chkBMatch1;
  input chkBEn1;
  input [PADDR_WIDTH-9:0] chkBAddrE2;
  input [PADDR_WIDTH-9:0] chkBAddrO2;
  input [31:0] chkBBanks2;
  input [31:0] chkBBanksX2;
  input [3:0] chkBBlow2;
  input [1:0] chkBAddrLow2;
  input chkBIsOH2,chkBIsEH2,chkBIsOL2,chkBIsEL2;
  output chkBMatch2;
  input chkBEn2;
  input [PADDR_WIDTH-9:0] chkBAddrE3;
  input [PADDR_WIDTH-9:0] chkBAddrO3;
  input [31:0] chkBBanks3;
  input [31:0] chkBBanksX3;
  input [3:0] chkBBlow3;
  input [1:0] chkBAddrLow3;
  input chkBIsOH3,chkBIsEH3,chkBIsOL3,chkBIsEL3;
  output chkBMatch3;
  input chkBEn3;
  input [PADDR_WIDTH-9:0] chkAddrE6;
  input [PADDR_WIDTH-9:0] chkAddrO6;
  input chkIsOH6,chkIsEH6,chkIsOL6,chkIsEL6;
  output chkMatch6;
  output nChNext0;
  output nChNext1;
  
  input freeEn0;

  input [II_WIDTH-1:0] freeII1A;
  input freeEn1A;
  input [II_WIDTH-1:0] freeII1B;
  input freeEn1B;
  input [II_WIDTH-1:0] freeII1A_r;
  input freeEn1A_r;
  input [II_WIDTH-1:0] freeII1B_r;
  input freeEn1B_r;
  input [5:0] ret_II;
  input [9:0] ret_mask;
  input ret_en;
  output wire ret_hit;
  input [5:0] newII_upper;
  output newII_chk;

  output reg free0;
  output reg free1;

  reg free0_5;
  wire nChMatch1,nChMatch0;
  reg [PADDR_WIDTH-9:0] addrE;
  reg [PADDR_WIDTH-9:0] addrO;
  reg [31:0] banks;
  wire [PADDR_WIDTH-9:0] baddrE;
  wire [PADDR_WIDTH-9:0] baddrO;
  //reg [31:0] banks;
  wire [31:0] bbanks;
  reg [II_WIDTH-1:0] II;
  reg isOH,isEH,isOL,isEL;
  wire [4:0] bsz0;
  reg [4:0] sz0;
  reg [4:0] bankA;
  reg odd;
  wire [1:0] baddrLow;
  reg [1:0] addrLow;
  reg split;
  reg thread;
  wire isOHb,isEHb,isOLb,isELb;
//  reg expunged;
  reg OK;
  wire bOK;
  wire [3:0] bbank_low;
  reg [3:0] bank_low;
  reg retired;
  reg [9:0] II_mask;
  reg [31:0] bnkX;
  wire [31:0] bbnkX;
  reg [1:0] addr_low; 
  wire [3:0] chkBBankLB[3:0];
  wire [3:0] chkBBankHB[3:0];
  wire chkBBankL[3:0];
  wire chkBBankH[3:0];
  wire [3:0] chkBMatchE;
  wire [3:0] chkBMatchO;
  wire newEnX0;

  wire [3:0]   chkBIsOH={chkBIsOH3,chkBIsOH2,chkBIsOH1,chkBIsOH0};
  wire [3:0]   chkBIsOL={chkBIsOL3,chkBIsOL2,chkBIsOL1,chkBIsOL0};
  wire [3:0]   chkBIsEH={chkBIsEH3,chkBIsEH2,chkBIsEH1,chkBIsEH0};
  wire [3:0]   chkBIsEL={chkBIsEL3,chkBIsEL2,chkBIsEL1,chkBIsEL0};
  
  wire [3:0] chkBankLB[6:0];
  wire [3:0] chkBankHB[6:0];
  wire chkBankL[6:0];
  wire chkBankH[6:0];
  wire [6:0] chkMatchE;
  wire [6:0] chkMatchO;

  wire [6:0]   chkIsOH={chkIsOH6,chkIsOH5,chkIsOH4,chkIsOH3,chkIsOH2,chkIsOH1,chkIsOH0};
  wire [6:0]   chkIsOL={chkIsOL6,chkIsOL5,chkIsOL4,chkIsOL3,chkIsOL2,chkIsOL1,chkIsOL0};
  wire [6:0]   chkIsEH={chkIsEH6,chkIsEH5,chkIsEH4,chkIsEH3,chkIsEH2,chkIsEH1,chkIsEH0};
  wire [6:0]   chkIsEL={chkIsEL6,chkIsEL5,chkIsEL4,chkIsEL3,chkIsEL2,chkIsEL1,chkIsEL0};
  
  wire [3:0] chkBMatch;
  wire [3:0] chkBMatchB[3:0];
  wire [6:0] chkMatch;
  wire [3:0] chkMatchB[6:0];
  wire [5:0] llmatch1;
  wire [5:0] llmatch2;
  wire [5:0] ll2match1;
  wire [5:0] ll2match2;
  wire freeEn1;
  wire freeEn1_r;

  wire [3:0] chkBlow[6:0];
  wire [3:0] chkBBlow[3:0];
  wire [1:0] chkAddrLow[6:0];
  wire [1:0] chkBAddrLow[3:0];

  assign freeEn1=(freeEn1A&&freeII1A==II)|(freeEn1B&&freeII1B==II); 
  assign freeEn1_r=(freeEn1A_r&&freeII1A_r==II)|(freeEn1B_r&&freeII1B_r==II); 
  assign ret_hit=II[9:4]==ret_II && (ret_mask & II_mask)!=0 && ret_en;

  assign newII_chk=newII_upper==II[9:4] && ~free1;
  assign chkBMatchE[0]=chkBAddrE0==baddrE;   
  assign chkBMatchO[0]=chkBAddrO0==baddrO;   

  assign chkBMatchE[1]=chkBAddrE1==baddrE;   
  assign chkBMatchO[1]=chkBAddrO1==baddrO;   

  assign chkBMatchE[2]=chkBAddrE2==baddrE;   
  assign chkBMatchO[2]=chkBAddrO2==baddrO;   

  assign chkBMatchE[3]=chkBAddrE3==baddrE;   
  assign chkBMatchO[3]=chkBAddrO3==baddrO;   
  
  assign chkMatchE[0]=chkAddrE0==baddrE;   
  assign chkMatchO[0]=chkAddrO0==baddrO;   

  assign chkMatchE[1]=chkAddrE1==baddrE;   
  assign chkMatchO[1]=chkAddrO1==baddrO;   

  assign chkMatchE[2]=chkAddrE2==baddrE;   
  assign chkMatchO[2]=chkAddrO2==baddrO;   

  assign chkMatchE[3]=chkAddrE3==baddrE;   
  assign chkMatchO[3]=chkAddrO3==baddrO;   

  assign chkMatchE[4]=chkAddrE4==baddrE;   
  assign chkMatchO[4]=chkAddrO4==baddrO;   

  assign chkMatchE[5]=chkAddrE5==baddrE;   
  assign chkMatchO[5]=chkAddrO5==baddrO;   

  assign chkMatchE[6]=chkAddrE6==addrE;   
  assign chkMatchO[6]=chkAddrO6==addrO;   
 
  assign nChNext0=((freeEn1A&&freeII1A==II) || (except && excpt_thread ~^ thread && ~retired))&~free1;
  assign nChNext1=(freeEn1B&&freeII1B==II)&~free1;
  //assign nChNext0B=~nChExcl0B && !(chkMatch_reg2&nChSel0B);
 // assign nChNext1B=~nChExcl1B && !(chkMatch_reg2&nChSel1B);
  assign chkMatch0=chkMatch[0] && ~free0_5|nChNext0|nChNext1 && chkEn0 && bOK;
  assign chkMatch1=chkMatch[1] && ~free0_5|nChNext0|nChNext1 && chkEn1 && bOK;
  assign chkMatch2=chkMatch[2] && ~free0_5|nChNext0|nChNext1 && chkEn2 && bOK;
  assign chkMatch3=chkMatch[3] && ~free0_5|nChNext0|nChNext1 && chkEn3 && bOK;
  assign chkMatch4=chkMatch[4] && ~free0_5|nChNext0|nChNext1 && chkEn4 && bOK;
  assign chkMatch5=chkMatch[5] && ~free0_5|nChNext0|nChNext1 && chkEn5 && bOK;
  assign chkMatch6=chkMatch[6] && ~free0_5|nChNext0|nChNext1;
  assign chkBMatch0=chkBMatch[0] && ~free0_5|nChNext0|nChNext1 && chkBEn0 && bOK;
  assign chkBMatch1=chkBMatch[1] && ~free0_5|nChNext0|nChNext1 && chkBEn1 && bOK;
  assign chkBMatch2=chkBMatch[2] && ~free0_5|nChNext0|nChNext1 && chkBEn2 && bOK;
  assign chkBMatch3=chkBMatch[3] && ~free0_5|nChNext0|nChNext1 && chkBEn3 && bOK;

  assign chkBBlow[0]=chkBBlow0; 
  assign chkBBlow[1]=chkBBlow1; 
  assign chkBBlow[2]=chkBBlow2; 
  assign chkBBlow[3]=chkBBlow3; 
  assign chkBlow[0]=chkBlow0; 
  assign chkBlow[1]=chkBlow1; 
  assign chkBlow[2]=chkBlow2; 
  assign chkBlow[3]=chkBlow3; 
  assign chkBlow[4]=chkBlow4; 
  assign chkBlow[5]=chkBlow5;
  assign chkBlow[6]=4'hf;
  
  assign chkBAddrLow[0]=chkBAddrLow0; 
  assign chkBAddrLow[1]=chkBAddrLow1; 
  assign chkBAddrLow[2]=chkBAddrLow2; 
  assign chkBAddrLow[3]=chkBAddrLow3; 
  assign chkAddrLow[0]=chkAddrLow0; 
  assign chkAddrLow[1]=chkAddrLow1; 
  assign chkAddrLow[2]=chkAddrLow2; 
  assign chkAddrLow[3]=chkAddrLow3; 
  assign chkAddrLow[4]=chkAddrLow4; 
  assign chkAddrLow[5]=chkAddrLow5;
  assign chkAddrLow[6]=2'b0;

  assign newEnX0=1'b0; //newEn0 && newId0==INDEX && ~(except && excpt_thread ~^ thread) && ~freeEn0;
  assign bbanks=newEnX0 ? newBanks0 : banks;
  assign bbnkX=newEnX0 ? newBanksX0 : bnkX;
  assign bOK=newEnX0 ? newOK0 : OK;
  assign bbank_low=newEnX0 ? newBlow0 : bank_low;
  assign baddrLow=newEnX0 ? newAddrLow0 : addrLow;
  assign baddrE=newEnX0 ? newAddrE0 : addrE;
  assign baddrO=newEnX0 ? newAddrO0 : addrO;
  assign bsz0=newEnX0 ? newSZ0 : sz0;
  assign isEHb=newEnX0 ? newIsEH0 : isEH;
  assign isOHb=newEnX0 ? newIsOH0 : isOH;
  assign isOLb=newEnX0 ? newIsOL0 : isOL;
  assign isELb=newEnX0 ? newIsEL0 : isEL;

  assign chkBankL[0]=(bbanks[15:0]&chkBanks0[15:0])!=16'b0; 
  assign chkBankH[0]=(bbanks[31:16]&chkBanks0[31:16])!=16'b0; 
  assign chkBankL[1]=(bbanks[15:0]&chkBanks1[15:0])!=16'b0; 
  assign chkBankH[1]=(bbanks[31:16]&chkBanks1[31:16])!=16'b0; 
  assign chkBankL[2]=(bbanks[15:0]&chkBanks2[15:0])!=16'b0; 
  assign chkBankH[2]=(bbanks[31:16]&chkBanks2[31:16])!=16'b0; 
  assign chkBankL[3]=(bbanks[15:0]&chkBanks3[15:0])!=16'b0; 
  assign chkBankH[3]=(bbanks[31:16]&chkBanks3[31:16])!=16'b0; 
  assign chkBankL[4]=(bbanks[15:0]&chkBanks4[15:0])!=16'b0; 
  assign chkBankH[4]=(bbanks[31:16]&chkBanks4[31:16])!=16'b0; 
  assign chkBankL[5]=(bbanks[15:0]&chkBanks5[15:0])!=16'b0; 
  assign chkBankH[5]=(bbanks[31:16]&chkBanks5[31:16])!=16'b0; 
  assign chkBankL[6]=1'b1; 
  assign chkBankH[6]=1'b1; 
  assign chkBBankL[0]=(bbanks[15:0]&chkBBanks0[15:0])!=16'b0; 
  assign chkBBankH[0]=(bbanks[31:16]&chkBBanks0[31:16])!=16'b0; 
  assign chkBBankL[1]=(bbanks[15:0]&chkBBanks1[15:0])!=16'b0; 
  assign chkBBankH[1]=(bbanks[31:16]&chkBBanks1[31:16])!=16'b0; 
  assign chkBBankL[2]=(bbanks[15:0]&chkBBanks2[15:0])!=16'b0; 
  assign chkBBankH[2]=(bbanks[31:16]&chkBBanks2[31:16])!=16'b0; 
  assign chkBBankL[3]=(bbanks[15:0]&chkBBanks3[15:0])!=16'b0; 
  assign chkBBankH[3]=(bbanks[31:16]&chkBBanks3[31:16])!=16'b0; 
  
  generate
      genvar k,p;
      for(k=0;k<7;k=k+1) begin : chk_gen
          storq_chk_confl chk_mod(
          isOHb,isEHb,isOLb,isELb,
          chkIsOH[k],chkIsEH[k],chkIsOL[k],chkIsEL[k],
          chkMatchE[k],chkMatchO[k],
          chkBankLB[k],chkBankHB[k],
          chkBankL[k],chkBankH[k],
          bbank_low,chkBlow[k],
          bsz0,
          baddrLow,chkAddrLow[k],
          chkMatch[k],chkMatchB[k]
          );
      end
      for(p=0;p<4;p=p+1) begin
          storq_chk_confl chkB_mod(
          isOHb,isEHb,isOLb,isELb,
          chkBIsOH[p],chkBIsEH[p],chkBIsOL[p],chkBIsEL[p],
          chkBMatchE[p],chkBMatchO[p],
          chkBBankLB[p],chkBBankHB[p],
          chkBBankL[p],chkBBankH[p],
          bbank_low,chkBBlow[p],
          bsz0,
          baddrLow,chkBAddrLow[p],
          chkBMatch[p],chkBMatchB[p]
          );
          assign chkBBankLB[0][p]=1 && ({bbnkX[p+12],bbnkX[p+8],bbnkX[p+4],bbnkX[p+0]}&
            {chkBBanksX0[p+12],chkBBanksX0[p+8],chkBBanksX0[p+4],chkBBanksX0[p+0]})!=0;
          assign chkBBankHB[0][p]=1 && ({bbnkX[p+28],bbnkX[p+24],bbnkX[p+20],bbnkX[p+16]}&
            {chkBBanksX0[p+28],chkBBanksX0[p+24],chkBBanksX0[p+20],chkBBanksX0[p+16]})!=0;
          assign chkBBankLB[1][p]=1 && ({bbnkX[p+12],bbnkX[p+8],bbnkX[p+4],bbnkX[p+0]}&
            {chkBBanksX1[p+12],chkBBanksX1[p+8],chkBBanksX1[p+4],chkBBanksX1[p+0]})!=0;
          assign chkBBankHB[1][p]=1 && ({bbnkX[p+28],bbnkX[p+24],bbnkX[p+20],bbnkX[p+16]}&
            {chkBBanksX1[p+28],chkBBanksX1[p+24],chkBBanksX1[p+20],chkBBanksX1[p+16]})!=0;
          assign chkBBankLB[2][p]=1 && ({bbnkX[p+12],bbnkX[p+8],bbnkX[p+4],bbnkX[p+0]}&
            {chkBBanksX2[p+12],chkBBanksX2[p+8],chkBBanksX2[p+4],chkBBanksX2[p+0]})!=0;
          assign chkBBankHB[2][p]=1 && ({bbnkX[p+28],bbnkX[p+24],bbnkX[p+20],bbnkX[p+16]}&
            {chkBBanksX2[p+28],chkBBanksX2[p+24],chkBBanksX2[p+20],chkBBanksX2[p+16]})!=0;
          assign chkBBankLB[3][p]=1 && ({bbnkX[p+12],bbnkX[p+8],bbnkX[p+4],bbnkX[p+0]}&
            {chkBBanksX3[p+12],chkBBanksX3[p+8],chkBBanksX3[p+4],chkBBanksX3[p+0]})!=0;
          assign chkBBankHB[3][p]=1 && ({bbnkX[p+28],bbnkX[p+24],bbnkX[p+20],bbnkX[p+16]}&
            {chkBBanksX3[p+28],chkBBanksX3[p+24],chkBBanksX3[p+20],chkBBanksX3[p+16]})!=0;
          

          assign chkBankLB[0][p]=1 && ({bbnkX[p+12],bbnkX[p+8],bbnkX[p+4],bbnkX[p+0]}&
            {chkBanksX0[p+12],chkBanksX0[p+8],chkBanksX0[p+4],chkBanksX0[p+0]})!=0;
          assign chkBankHB[0][p]=1 && ({bbnkX[p+28],bbnkX[p+24],bbnkX[p+20],bbnkX[p+16]}&
            {chkBanksX0[p+28],chkBanksX0[p+24],chkBanksX0[p+20],chkBanksX0[p+16]})!=0;
          assign chkBankLB[1][p]=1 && ({bbnkX[p+12],bbnkX[p+8],bbnkX[p+4],bbnkX[p+0]}&
            {chkBanksX1[p+12],chkBanksX1[p+8],chkBanksX1[p+4],chkBanksX1[p+0]})!=0;
          assign chkBankHB[1][p]=1 && ({bbnkX[p+28],bbnkX[p+24],bbnkX[p+20],bbnkX[p+16]}&
            {chkBanksX1[p+28],chkBanksX1[p+24],chkBanksX1[p+20],chkBanksX1[p+16]})!=0;
          assign chkBankLB[2][p]=1 && ({bbnkX[p+12],bbnkX[p+8],bbnkX[p+4],bbnkX[p+0]}&
            {chkBanksX2[p+12],chkBanksX2[p+8],chkBanksX2[p+4],chkBanksX2[p+0]})!=0;
          assign chkBankHB[2][p]=1 && ({bbnkX[p+28],bbnkX[p+24],bbnkX[p+20],bbnkX[p+16]}&
            {chkBanksX2[p+28],chkBanksX2[p+24],chkBanksX2[p+20],chkBanksX2[p+16]})!=0;
          assign chkBankLB[3][p]=1 && ({bbnkX[p+12],bbnkX[p+8],bbnkX[p+4],bbnkX[p+0]}&
            {chkBanksX3[p+12],chkBanksX3[p+8],chkBanksX3[p+4],chkBanksX3[p+0]})!=0;
          assign chkBankHB[3][p]=1 && ({bbnkX[p+28],bbnkX[p+24],bbnkX[p+20],bbnkX[p+16]}&
            {chkBanksX3[p+28],chkBanksX3[p+24],chkBanksX3[p+20],chkBanksX3[p+16]})!=0;
          assign chkBankLB[4][p]=1 && ({bbnkX[p+12],bbnkX[p+8],bbnkX[p+4],bbnkX[p+0]}&
            {chkBanksX4[p+12],chkBanksX4[p+8],chkBanksX4[p+4],chkBanksX4[p+0]})!=0;
          assign chkBankHB[4][p]=1 && ({bbnkX[p+28],bbnkX[p+24],bbnkX[p+20],bbnkX[p+16]}&
            {chkBanksX4[p+28],chkBanksX4[p+24],chkBanksX4[p+20],chkBanksX4[p+16]})!=0;
          assign chkBankLB[5][p]=1 && ({bbnkX[p+12],bbnkX[p+8],bbnkX[p+4],bbnkX[p+0]}&
            {chkBanksX5[p+12],chkBanksX5[p+8],chkBanksX5[p+4],chkBanksX5[p+0]})!=0;
          assign chkBankHB[5][p]=1 && ({bbnkX[p+28],bbnkX[p+24],bbnkX[p+20],bbnkX[p+16]}&
            {chkBanksX5[p+28],chkBanksX5[p+24],chkBanksX5[p+20],chkBanksX5[p+16]})!=0;
          assign chkBankLB[6][p]=1 && ({bbnkX[p+12],bbnkX[p+8],bbnkX[p+4],bbnkX[p+0]})!=0;
          assign chkBankHB[6][p]=1 && ({bbnkX[p+28],bbnkX[p+24],bbnkX[p+20],bbnkX[p+16]})!=0;
      end
  endgenerate
  

  always @(posedge clk) begin
      if (rst) begin
          addrE<=36'b0;
          addrO<=36'b0;
          banks<=32'b0;
          bnkX<=32'b0;
          II<={II_WIDTH{1'b0}};
          free0<=1'b1;
          free0_5<=1'b1;
          free1<=1'b1;
          isOH<=1'b0;
          isOL<=1'b0;
          isEH<=1'b0;
          isEL<=1'b0;
          sz0<=5'b0;
          bankA<=5'b0;
          odd<=1'b0;
          addrLow<=2'b0;
          split<=1'b0;
          thread<=1'b0;
  //        expunged<=1'b0;
	  OK<=1'b0;
          bank_low<=4'd0;
          II_mask<=10'b0;
          retired<=1'b1;
          addr_low<=2'b0;
      end else if (except && excpt_thread ~^ thread && ~retired) begin
          free0<=1'b1;
          free0_5<=1'b1;
          free1<=1'b1;
	  OK<=1'b0;
          retired<=1'b1;
          II_mask<=10'b0;
          if (freeEn1) begin //NIR
              free0_5<=1'b1;
          end
          if (freeEn1_r) begin //NIR2.5
              free1<=1'b1;
          end
      end else if (newEn0 && newId0==INDEX && ~(except && excpt_thread ~^ thread) && ~freeEn0) begin
          addrE<=newAddrE0;
          addrO<=newAddrO0;
          banks<=newBanks0;
          bnkX<=newBanksX0;
          II<=newII0;
          free0<=1'b0;
          free0_5<=1'b0;
          free1<=1'b0;
          isOH<=newIsOH0;
          isEH<=newIsEH0;
          isOL<=newIsOL0;
          isEL<=newIsEL0;
          sz0<=newSZ0;
          bankA<=newBankA0;
          odd<=newOdd0;
          addrLow<=newAddrLow0;
          split<=newSplit0;
          thread<=newThread0;
    //      expunged<=1'b0;
	  OK<=newOK0;
          bank_low<=newBlow0;
          II_mask<=newIIMask0;
          retired<=1'b0;
          addr_low<=newAddrLow0;
      end else begin
          if (freeEn0) begin
              free0<=1'b1;
          end 
          if (freeEn1) begin
              free0_5<=1'b1;
          end
          if (freeEn1_r) begin
              free1<=1'b1;
          end
          if (ret_hit) retired<=1'b1;
          if (ret_hit) II_mask<=10'b0;
      end
  end

endmodule


module storq_array(
  clk,
  rst,
  stall,
  doStall,
  newI_alloc,
  except,excpt_thread,
  newAddrE0,newAddrO0,newBanks0,newBlow0,newII0,newIIMask0,newIsOH0,newIsEH0,newIsOL0,newIsEL0,newId0,newEn0,newOK0,
  newSZ0,newBankA0,newOdd0,newAddrLow0,newSplit0,newThread0,
  chkAddrE0,chkAddrO0,chkBanks0,chkBlow0,chkAddrLow0, chkIsOH0,chkIsEH0,chkIsOL0,chkIsEL0,chkMatch0,chkMatchIn0,chkEn0,
  chkAddrE1,chkAddrO1,chkBanks1,chkBlow1,chkAddrLow1, chkIsOH1,chkIsEH1,chkIsOL1,chkIsEL1,chkMatch1,chkMatchIn1,chkEn1,
  chkAddrE2,chkAddrO2,chkBanks2,chkBlow2,chkAddrLow2, chkIsOH2,chkIsEH2,chkIsOL2,chkIsEL2,chkMatch2,chkMatchIn2,chkEn2,
  chkAddrE3,chkAddrO3,chkBanks3,chkBlow3,chkAddrLow3, chkIsOH3,chkIsEH3,chkIsOL3,chkIsEL3,chkMatch3,chkMatchIn3,chkEn3,
  chkAddrE4,chkAddrO4,chkBanks4,chkBlow4,chkAddrLow4, chkIsOH4,chkIsEH4,chkIsOL4,chkIsEL4,chkMatch4,chkMatchIn4,chkEn4,
  chkAddrE5,chkAddrO5,chkBanks5,chkBlow5,chkAddrLow5, chkIsOH5,chkIsEH5,chkIsOL5,chkIsEL5,chkMatch5,chkMatchIn5,chkEn5,
  chkBAddrE0,chkBAddrO0,chkBBanks0,chkBBlow0,chkBAddrLow0, chkBIsOH0,chkBIsEH0,chkBIsOL0,chkBIsEL0,chkBMatch0,chkBEn0,
  chkBAddrE1,chkBAddrO1,chkBBanks1,chkBBlow1,chkBAddrLow1, chkBIsOH1,chkBIsEH1,chkBIsOL1,chkBIsEL1,chkBMatch1,chkBEn1,
  chkBAddrE2,chkBAddrO2,chkBBanks2,chkBBlow2,chkBAddrLow2, chkBIsOH2,chkBIsEH2,chkBIsOL2,chkBIsEL2,chkBMatch2,chkBEn2,
  chkBAddrE3,chkBAddrO3,chkBBanks3,chkBBlow3,chkBAddrLow3, chkBIsOH3,chkBIsEH3,chkBIsOL3,chkBIsEL3,chkBMatch3,chkBEn3,
  chkAddrE6,chkAddrO6, chkIsOH6,chkIsEH6,chkIsOL6,chkIsEL6,chkMatch6,
  nChNext0,
  freeEn0,
  freeII1A,freeEn1A,
  freeII1B,freeEn1B,
  ret_II,ret_mask,ret_en,ret_hit,
  newII_upper,newII_chk,
  free0,
  free1
  );
  
  localparam PADDR_WIDTH=44;
  localparam BANK_COUNT=32;
  localparam II_WIDTH=10;
  localparam ADDR_WIDTH=4;
  localparam BUF_COUNT=32;
  
  input clk;
  input rst;

  input stall;
  output doStall;
  input newI_alloc;
  
  input except;
  input excpt_thread;

  input [PADDR_WIDTH-9:0] newAddrE0;
  input [PADDR_WIDTH-9:0] newAddrO0;
  input [31:0] newBanks0;
  input [3:0] newBlow0;
  input [II_WIDTH-1:0] newII0;
  input [9:0] newIIMask0;
  input newIsOH0,newIsEH0,newIsOL0,newIsEL0;
  input [4:0] newId0;
  input newEn0;
  input newOK0;
  input [4:0] newSZ0;
  input [4:0] newBankA0;
  input newOdd0;
  input [1:0] newAddrLow0;
  input newSplit0;
  input newThread0;
  
  input [PADDR_WIDTH-9:0] chkAddrE0;
  input [PADDR_WIDTH-9:0] chkAddrO0;
  input [31:0] chkBanks0;
  input [3:0] chkBlow0;
  input [1:0] chkAddrLow0;
  input chkIsOH0,chkIsEH0,chkIsOL0,chkIsEL0;
  output [BUF_COUNT-1:0] chkMatch0;
  input [BUF_COUNT-1:0] chkMatchIn0;
  input chkEn0;
  input [PADDR_WIDTH-9:0] chkAddrE1;
  input [PADDR_WIDTH-9:0] chkAddrO1;
  input [31:0] chkBanks1;
  input [3:0] chkBlow1;
  input [1:0] chkAddrLow1;
  input chkIsOH1,chkIsEH1,chkIsOL1,chkIsEL1;
  output [BUF_COUNT-1:0] chkMatch1;
  input [BUF_COUNT-1:0] chkMatchIn1;
  input chkEn1;
  input [PADDR_WIDTH-9:0] chkAddrE2;
  input [PADDR_WIDTH-9:0] chkAddrO2;
  input [31:0] chkBanks2;
  input [3:0] chkBlow2;
  input [1:0] chkAddrLow2;
  input chkIsOH2,chkIsEH2,chkIsOL2,chkIsEL2;
  output [BUF_COUNT-1:0] chkMatch2;
  input [BUF_COUNT-1:0] chkMatchIn2;
  input chkEn2;
  input [PADDR_WIDTH-9:0] chkAddrE3;
  input [PADDR_WIDTH-9:0] chkAddrO3;
  input [31:0] chkBanks3;
  input [3:0] chkBlow3;
  input [1:0] chkAddrLow3;
  input chkIsOH3,chkIsEH3,chkIsOL3,chkIsEL3;
  output [BUF_COUNT-1:0] chkMatch3;
  input [BUF_COUNT-1:0] chkMatchIn3;
  input chkEn3;
  input [PADDR_WIDTH-9:0] chkAddrE4;
  input [PADDR_WIDTH-9:0] chkAddrO4;
  input [31:0] chkBanks4;
  input [3:0] chkBlow4;
  input [1:0] chkAddrLow4;
  input chkIsOH4,chkIsEH4,chkIsOL4,chkIsEL4;
  output [BUF_COUNT-1:0] chkMatch4;
  input [BUF_COUNT-1:0] chkMatchIn4;
  input chkEn4;
  input [PADDR_WIDTH-9:0] chkAddrE5;
  input [PADDR_WIDTH-9:0] chkAddrO5;
  input [31:0] chkBanks5;
  input [3:0] chkBlow5;
  input [1:0] chkAddrLow5;
  input chkIsOH5,chkIsEH5,chkIsOL5,chkIsEL5;
  output [BUF_COUNT-1:0] chkMatch5;
  input [BUF_COUNT-1:0] chkMatchIn5;
  input chkEn5;
  input [PADDR_WIDTH-9:0] chkBAddrE0;
  input [PADDR_WIDTH-9:0] chkBAddrO0;
  input [31:0] chkBBanks0;
  input [3:0] chkBBlow0;
  input [1:0] chkBAddrLow0;
  input chkBIsOH0,chkBIsEH0,chkBIsOL0,chkBIsEL0;
  output [BUF_COUNT-1:0] chkBMatch0;
  input chkBEn0;
  input [PADDR_WIDTH-9:0] chkBAddrE1;
  input [PADDR_WIDTH-9:0] chkBAddrO1;
  input [31:0] chkBBanks1;
  input [3:0] chkBBlow1;
  input [1:0] chkBAddrLow1;
  input chkBIsOH1,chkBIsEH1,chkBIsOL1,chkBIsEL1;
  output [BUF_COUNT-1:0] chkBMatch1;
  input chkBEn1;
  input [PADDR_WIDTH-9:0] chkBAddrE2;
  input [PADDR_WIDTH-9:0] chkBAddrO2;
  input [31:0] chkBBanks2;
  input [3:0] chkBBlow2;
  input [1:0] chkBAddrLow2;
  input chkBIsOH2,chkBIsEH2,chkBIsOL2,chkBIsEL2;
  output [BUF_COUNT-1:0] chkBMatch2;
  input chkBEn2;
  input [PADDR_WIDTH-9:0] chkBAddrE3;
  input [PADDR_WIDTH-9:0] chkBAddrO3;
  input [31:0] chkBBanks3;
  input [3:0] chkBBlow3;
  input [1:0] chkBAddrLow3;
  input chkBIsOH3,chkBIsEH3,chkBIsOL3,chkBIsEL3;
  output [BUF_COUNT-1:0] chkBMatch3;
  input chkBEn3;
  input [PADDR_WIDTH-9:0] chkAddrE6;
  input [PADDR_WIDTH-9:0] chkAddrO6;
  input chkIsOH6,chkIsEH6,chkIsOL6,chkIsEL6;
  output chkMatch6;
  
  output [BUF_COUNT-1:0] nChNext0;

  input [BUF_COUNT-1:0] freeEn0;
  
  input [II_WIDTH-1:0] freeII1A;
  input freeEn1A;
  input [II_WIDTH-1:0] freeII1B;
  input freeEn1B;
  
  input [5:0] ret_II;
  input [9:0] ret_mask;
  input ret_en;
  output [BUF_COUNT-1:0] ret_hit;
  input [5:0] newII_upper;
  output [BUF_COUNT-1:0] newII_chk;

  output [BUF_COUNT-1:0] free0;
  output [BUF_COUNT-1:0] free1;
  reg [4:0] newI_id;
  wire [4:0] newI_id_next;
  
  wire [BUF_COUNT-1:0] nChNext0_buf;
  wire [BUF_COUNT-1:0] nChNext1_buf;
  wire [BUF_COUNT-1:0] chkMatch6_buf;
  reg [BUF_COUNT-1:0] newI_mask;
 
  wire [31:0] newBankX0=newAddrLow0!=0 ? newBanks0&{newBanks0[0],newBanks0[31:1]} : newBanks0;
  
  wire [31:0] chkBankX0=chkAddrLow0!=0 ? chkBanks0&{chkBanks0[0],chkBanks0[31:1]} : chkBanks0;
  wire [31:0] chkBankX1=chkAddrLow1!=0 ? chkBanks1&{chkBanks1[0],chkBanks1[31:1]} : chkBanks1;
  wire [31:0] chkBankX2=chkAddrLow2!=0 ? chkBanks2&{chkBanks2[0],chkBanks2[31:1]} : chkBanks2;
  wire [31:0] chkBankX3=chkAddrLow3!=0 ? chkBanks3&{chkBanks3[0],chkBanks3[31:1]} : chkBanks3;
  wire [31:0] chkBankX4=chkAddrLow4!=0 ? chkBanks4&{chkBanks4[0],chkBanks4[31:1]} : chkBanks4;
  wire [31:0] chkBankX5=chkAddrLow5!=0 ? chkBanks5&{chkBanks5[0],chkBanks5[31:1]} : chkBanks5;
  
  wire [31:0] chkBBankX0=chkBAddrLow0!=0 ? chkBBanks0&{chkBBanks0[0],chkBBanks0[31:1]} : chkBBanks0;
  wire [31:0] chkBBankX1=chkBAddrLow1!=0 ? chkBBanks1&{chkBBanks1[0],chkBBanks1[31:1]} : chkBBanks1;
  wire [31:0] chkBBankX2=chkBAddrLow2!=0 ? chkBBanks2&{chkBBanks2[0],chkBBanks2[31:1]} : chkBBanks2;
  wire [31:0] chkBBankX3=chkBAddrLow3!=0 ? chkBBanks3&{chkBBanks3[0],chkBBanks3[31:1]} : chkBBanks3;
  
  reg [II_WIDTH-1:0] freeII1A_reg;
  reg freeEn1A_reg;
  reg [II_WIDTH-1:0] freeII1B_reg;
  reg freeEn1B_reg;
  reg [II_WIDTH-1:0] freeII1A_reg2;
  reg freeEn1A_reg2;
  reg [II_WIDTH-1:0] freeII1B_reg2;
  reg freeEn1B_reg2;
  
  assign chkMatch6=|chkMatch6_buf;

  assign doStall=1'b0;

  assign nChNext0=nChNext0_buf|nChNext1_buf;
//  assign nChNext1B=&nChNext1B_buf;

  generate
      genvar l;
      for(l=0;l<BUF_COUNT;l=l+1) begin : buffers_gen
          storq_buf #(l) buf_mod(
          clk,
          rst,
          except,excpt_thread,
          newAddrE0,newAddrO0,newBanks0,newBankX0,newBlow0,newII0,newIIMask0,newIsOH0,newIsEH0,newIsOL0,newIsEL0,newId0,newEn0,newOK0,
          newSZ0,newBankA0,newOdd0,newAddrLow0,newSplit0,newThread0,
          chkAddrE0,chkAddrO0,chkBanks0,chkBankX0,chkBlow0,chkAddrLow0, chkIsOH0,chkIsEH0,chkIsOL0,chkIsEL0,chkMatch0[l],chkMatchIn0[l],chkEn0,
          chkAddrE1,chkAddrO1,chkBanks1,chkBankX1,chkBlow1,chkAddrLow1, chkIsOH1,chkIsEH1,chkIsOL1,chkIsEL1,chkMatch1[l],chkMatchIn1[l],chkEn1,
          chkAddrE2,chkAddrO2,chkBanks2,chkBankX2,chkBlow2,chkAddrLow2, chkIsOH2,chkIsEH2,chkIsOL2,chkIsEL2,chkMatch2[l],chkMatchIn2[l],chkEn2,
          chkAddrE3,chkAddrO3,chkBanks3,chkBankX3,chkBlow3,chkAddrLow3, chkIsOH3,chkIsEH3,chkIsOL3,chkIsEL3,chkMatch3[l],chkMatchIn3[l],chkEn3,
          chkAddrE4,chkAddrO4,chkBanks4,chkBankX4,chkBlow4,chkAddrLow4, chkIsOH4,chkIsEH4,chkIsOL4,chkIsEL4,chkMatch4[l],chkMatchIn4[l],chkEn4,
          chkAddrE5,chkAddrO5,chkBanks5,chkBankX5,chkBlow5,chkAddrLow5, chkIsOH5,chkIsEH5,chkIsOL5,chkIsEL5,chkMatch5[l],chkMatchIn5[l],chkEn5,
          chkBAddrE0,chkBAddrO0,chkBBanks0,chkBBankX0,chkBBlow0,chkBAddrLow0, chkBIsOH0,chkBIsEH0,chkBIsOL0,chkBIsEL0,chkBMatch0[l],chkBEn0,
          chkBAddrE1,chkBAddrO1,chkBBanks1,chkBBankX1,chkBBlow1,chkBAddrLow1, chkBIsOH1,chkBIsEH1,chkBIsOL1,chkBIsEL1,chkBMatch1[l],chkBEn1,
          chkBAddrE2,chkBAddrO2,chkBBanks2,chkBBankX2,chkBBlow2,chkBAddrLow2, chkBIsOH2,chkBIsEH2,chkBIsOL2,chkBIsEL2,chkBMatch2[l],chkBEn2,
          chkBAddrE3,chkBAddrO3,chkBBanks3,chkBBankX3,chkBBlow3,chkBAddrLow3, chkBIsOH3,chkBIsEH3,chkBIsOL3,chkBIsEL3,chkBMatch3[l],chkBEn3,
          chkAddrE6,chkAddrO6, chkIsOH6,chkIsEH6,chkIsOL6,chkIsEL6,chkMatch6_buf[l],
          nChNext0_buf[l],
          nChNext1_buf[l],
          freeEn0[l],
          freeII1A,freeEn1A,
          freeII1B,freeEn1B,
          freeII1A,freeEn1A,
          freeII1B,freeEn1B,
          ret_II,ret_mask,ret_en,ret_hit[l],
          newII_upper,newII_chk[l],
          free0[l],
          free1[l]
          );
      end

  endgenerate

  adder_inc #(5) idAdd_mod(newI_id,newI_id_next,1'b1,);

  always @(posedge clk) begin
      if (rst|except) newI_mask<={BUF_COUNT{1'b0}};
      else begin
          if (~stall & ~doStall & newI_alloc) newI_mask[newI_id]<=1'b1;
          if (newEn0) newI_mask[newId0]<=1'b0;
      end
      if (rst) newI_id<=5'd0;
      else if (~stall & ~doStall & newI_alloc &~except)
        newI_id<=newI_id_next;
  /*    if (rst) begin
          freeII1A_reg<=10'b0;
          freeEn1A_reg<=1'b0;
          freeII1B_reg<=10'b0;
          freeEn1B_reg<=1'b0;
          freeII1A_reg2<=10'b0;
          freeEn1A_reg2<=1'b0;
          freeII1B_reg2<=10'b0;
          freeEn1B_reg2<=1'b0;
      end else begin
          //if (nChClkEn) begin
              freeII1A_reg<=freeII1A;
              freeEn1A_reg<=freeEn1A;
              freeII1B_reg<=freeII1B;
              freeEn1B_reg<=freeEn1B;
         // end
         // if (mChClkEn) begin
              freeII1A_reg2<=freeII1A_reg;
              freeEn1A_reg2<=freeEn1A_reg;
              freeII1B_reg2<=freeII1B_reg;
              freeEn1B_reg2<=freeEn1B_reg;
        //  end
      end*/
  end
  
endmodule


module storq(
  clk,
  rst,
  stall,
  doStall,
  aStall,
  aDoStall,
  lStall,
  lDoStall,
  bStall,
  rDoStall,
  newI_alloc,
  newII_upper,newII_req,
  except,
  excpt_thread,
  new_data_shr,
  new_dataA0,new_enA0,
  new_dataA1,new_enA1,
  new_dataA2,new_enA2,
  new_dataA3,new_enA3,
  new_dataA4,new_enA4,
  new_dataA5,new_enA5,
  new_en,new_enP,
  new_thr,
  new_confl,
  pch_dataA0,pch_confl0,
  pch_dataA1,pch_confl1,
  pch_dataA2,pch_confl2,
  pch_dataA3,pch_confl3,
  pfree_data0, pfree_en0,//pfree=data freed0 from  storq
  pfree_data1, pfree_en1,
  pfree_data2, pfree_en2,
  pfree_data_shr,
  wret_II0,wret_en0,
  wret_II1,wret_en1,

  ret_has_ldst,
  ret_data_shr,
  ret_mask,
  ret_retire,
  
  LDQmask,

  new_conflictx,
  new_conflicty,
  m_mask,n_mask,
  new_conflictA,p1_new_conflictA_b,new_conflictA_has,
  new_conflictB,p1_new_conflictB_b,new_conflictB_has,
  lstep1_owndataA,
  lstep1_owndataB,
  new_conflict2_acc,
  p1_nChNextA0,p1_nChNextA1,p1_nChNextA2,
  p1_ins_addr0,p1_pos_dataA0,p1_pos_en0,
  p1_ins_addr1,p1_pos_dataA1,p1_pos_en1,
  p1_ins_addr2,p1_pos_dataA2,p1_pos_en2,
  new_en_reg2,new_enP_reg2,p1_peek_aStall,
  confl_first,confl_last,confl_cnt,chmo_bolotnoe2

  ); 
  localparam DATA_WIDTH=`lsaddr_width;
  localparam SDATA_WIDTH=`lsqshare_width;
  localparam BUF_COUNT=32; 
  input clk;
  input rst;
  input stall;
  output doStall;
  input aStall;
  output aDoStall;
  input lStall;
  input lDoStall;
  input bStall;
  output rDoStall;
  input [2:0] newI_alloc;
  input [5:0] newII_upper;
  input newII_req;
  input except;
  input excpt_thread;
  input [SDATA_WIDTH-1:0] new_data_shr;
  input [DATA_WIDTH-1:0] new_dataA0;
  input new_enA0;
  input [DATA_WIDTH-1:0] new_dataA1;
  input new_enA1;
  input [DATA_WIDTH-1:0] new_dataA2;
  input new_enA2;
  input [DATA_WIDTH-1:0] new_dataA3;
  input new_enA3;
  input [DATA_WIDTH-1:0] new_dataA4;
  input new_enA4;
  input [DATA_WIDTH-1:0] new_dataA5;
  input new_enA5;
  input new_en,new_enP;
  input new_thr;
  output [5:0] new_confl;
  input [DATA_WIDTH-1:0] pch_dataA0;
  output pch_confl0;
  input [DATA_WIDTH-1:0] pch_dataA1;
  output pch_confl1;
  input [DATA_WIDTH-1:0] pch_dataA2;
  output pch_confl2;
  input [DATA_WIDTH-1:0] pch_dataA3;
  output pch_confl3;
  output [DATA_WIDTH-1:0] pfree_data0;
  output pfree_en0;
  output [DATA_WIDTH-1:0] pfree_data1;
  output pfree_en1;
  output [DATA_WIDTH-1:0] pfree_data2;
  output pfree_en2;
  output [5:0] pfree_data_shr;

  input [9:0] wret_II0;
  input wret_en0;
  input [9:0] wret_II1;
  input wret_en1;
  

  input ret_has_ldst;
  input [SDATA_WIDTH-1:0] ret_data_shr;
  input [9:0] ret_mask;
  input ret_retire;
  
  output [5:0] LDQmask;
  
  output [3*BUF_COUNT-1:0] new_conflictx;
  output [3*BUF_COUNT-1:0] new_conflicty;
  output [3*BUF_COUNT-1:0] m_mask;
  output [3*BUF_COUNT-1:0] n_mask;
//  output [3*BUF_COUNT-1:0] p1_new_conflictAp;
//  output [3*BUF_COUNT-1:0] p1_new_conflictBp;
  output [3*BUF_COUNT-1:0] new_conflictA;
  output [11:0] p1_new_conflictA_b;
  output [2:0] new_conflictA_has;
  output [3*BUF_COUNT-1:0] new_conflictB;
  output [11:0] p1_new_conflictB_b;
  output [2:0] new_conflictB_has;
  output [DATA_WIDTH-1:0] lstep1_owndataA;
  output [DATA_WIDTH-1:0] lstep1_owndataB;
  output [3*BUF_COUNT-1:0] new_conflict2_acc;
  output [BUF_COUNT-1:0] p1_nChNextA0;
  output [BUF_COUNT-1:0] p1_nChNextA1;
  output [BUF_COUNT-1:0] p1_nChNextA2;
  output [4:0] p1_ins_addr0;
  output [DATA_WIDTH-1:0] p1_pos_dataA0;
  output p1_pos_en0;
  output [4:0] p1_ins_addr1;
  output [DATA_WIDTH-1:0] p1_pos_dataA1;
  output p1_pos_en1;
  output [4:0] p1_ins_addr2;
  output [DATA_WIDTH-1:0] p1_pos_dataA2;
  output p1_pos_en2;

/*  output [9:0] wret_II0;
  output wret_en0;
  output [9:0] wret_II1;
  output wret_en1;
  */
  output new_en_reg2;
  output new_enP_reg2;
  input p1_peek_aStall;
  output [5:0] confl_first;
  output [5:0] confl_last;
  output [6:0] confl_cnt;
  output reg chmo_bolotnoe2;

  reg chmo_bolotnoe3;

  reg [2:0] cur_posh;
  wire [3:0] wroet_cnt;
  wire [2:0] wroet_en;
  reg [2:0] wroet_en_reg;
  reg [2:0] cur_pos;
 // reg [2:0] wrt_en;
  reg new_en_reg;
  reg new_en_reg2;
  reg new_en_reg3;
  reg new_enP_reg;
  reg new_enP_reg2;
  reg new_enP_reg3;
  reg new_thr_reg;
  reg new_thr_reg2;
  reg new_thr_reg3;

  reg [5:0] new_II_reg;
  reg [5:0] new_II_reg2;
  reg [5:0] new_II_reg3;
  reg [5:0] new_II_reg4;

  reg [4:0] ins_addr[2:0];
  wire [2:0][4:0] ins_addr_d;
  wire [2:0] ins_addr_cout;

  reg [4:0] insh_addr[2:0];
  wire [2:0][4:0] insh_addr_d;
  wire [2:0] insh_addr_cout;
  wire [2:0] posh_en;


  wire [2:0][BUF_COUNT-1:0] free2;
  wire [2:0][BUF_COUNT-1:0] free;
  wire [2:0][BUF_COUNT-1:0] free_lastM;
  wire [2:0][BUF_COUNT-1:0] free_lastN;
  wire [2:0][BUF_COUNT-1:0] free_last;
  wire [2:0][BUF_COUNT-1:0] freeEn;
  wire [2:0][BUF_COUNT-1:0] freeOEn;
  wire [2:0][3:0] free_lastM_bank;
  wire [2:0][3:0] free_lastN_bank;
  wire [2:0][3:0] free_last_bank;
  wire [2:0][3:0] freeEn_bank;
  reg [BUF_COUNT-1:0] free_maskM[2:0];
  reg [BUF_COUNT-1:0] free_maskN[2:0];
  reg [BUF_COUNT-1:0] free_maskM_reg[2:0];
  reg [BUF_COUNT-1:0] free_maskN_reg[2:0];
  reg [BUF_COUNT-1:0] free_maskM_reg2[2:0];
  reg [BUF_COUNT-1:0] free_maskN_reg2[2:0];
  reg [BUF_COUNT-1:0] free_maskXM[2:0];
  reg [BUF_COUNT-1:0] free_maskXN[2:0];
  wire [2:0]has_free;
  wire [2:0]has_freeM;
  wire [2:0]has_freeN;
  wire [2:0] free_eat;
  wire [2:0] free_oeat;
  wire [2:0] free_on;
  wire [2:0] pos_en;
  wire [5:0][DATA_WIDTH-1:0] new_dataA;
  wire [5:0] new_enA={new_enA5,new_enA4,new_enA3,new_enA2,new_enA1,new_enA0};
  reg [5:0] new_enA_reg;
  reg  [DATA_WIDTH-1:0] new_dataA_chk[5:0];
  reg  [DATA_WIDTH-1:0] new_dataA_chk_reg[5:0];
 // wire [5:0] new_dataA_unal;
 // wire [9:0] free_need_instrB[2:0];
  wire [2:0][DATA_WIDTH-1:0] wrt_dataA;
  wire [2:0][2:0] wrt_indexA;
  wire [2:0][DATA_WIDTH-1:0] pos_dataA;
  wire [2:0][2:0] pos_indexA;
  reg [DATA_WIDTH-1:0] wrt_dataA_reg[2:0];
  reg [2:0] wrt_indexA_reg[2:0];
  reg [2:0] pos_indexA_reg[2:0];
  wire [2:0] wrt_en;
  reg [2:0] wrt_en_reg;
  wire [BUF_COUNT-1:0] free_lastMG;
  wire [BUF_COUNT-1:0] free_lastNG;
  wire [BUF_COUNT-1:0] free_lastNG0;
  wire free_hasMG,free_hasNG;

  wire [2:0][DATA_WIDTH-1:0] pfree_data;
 // wire pfree_en[2:0];
  
  wire [2:0] stallone;

  wire [3:1] retcnt_more;
  wire [3:1] roetcnt_more;
  wire [3:0] wrt_cnt;
  wire [2:0] retX_m;

  reg [5:0] new_confl_reg;
  wire [5:0] new_confl_ex;
  reg [5:0] new_en_mask;
  reg [5:0] new_en_mask0;
  reg [9:0] ret_wait;

  wire [3:0][3*BUF_COUNT-1:0] pch_conflict;
  wire [3*BUF_COUNT-1:0] new_conflict_exx;
 
  wire [5:0][3*BUF_COUNT-1:0] new_conflict_ex;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict1;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict2;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict1p;
  //wire [5:0][3*BUF_COUNT-1:0] new_conflict2p;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict1q;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict2q;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict1r;
  wire [5:0][3*BUF_COUNT-1:0] new_conflict2r;
  wire [5:0][3:0] new_conflict1p_b0;
//  wire [5:0][3:0] new_conflict2p_b0;
  wire [5:0][3:0] new_conflict1p_b1;
//  wire [5:0][3:0] new_conflict2p_b1;
  wire [5:0][3:0] new_conflict1p_b2;
//  wire [5:0][3:0] new_conflict2p_b2;
  wire [3*BUF_COUNT-1:0] new_conflictA;
  wire [3*BUF_COUNT-1:0] new_conflictB;
  wire [3*BUF_COUNT-1:0] new_conflictAp;
  wire [3*BUF_COUNT-1:0] new_conflictBp;
  wire [3*BUF_COUNT-1:0] new_conflictAq;
  wire [3*BUF_COUNT-1:0] new_conflictBq;
  wire [3*BUF_COUNT-1:0] new_conflictx;
  wire [3*BUF_COUNT-1:0] new_conflicty;
  wire [2:0][3:0] new_conflictA_b;
  wire [2:0][3:0] new_conflictB_b;
  reg [3*BUF_COUNT-1:0] new_conflict1_reg[5:0];
  reg [3*BUF_COUNT-1:0] new_conflict2_reg[5:0];
  reg [3*BUF_COUNT-1:0] new_conflict1_acc;
  reg [3*BUF_COUNT-1:0] new_conflict2_acc;
  wire [6:0] confl_cnt;
  wire [5:0] confl_first;
  wire [5:0] confl_last;
  wire [5:0] new_conflict_has1r;
  wire [5:0] new_conflict_has2r;
  wire [2:0] new_conflict_has1p[5:0];
//  wire [2:0] new_conflict_has2p[5:0];
  wire [2:0] new_conflictA_has;
  wire [2:0] new_conflictB_has;
  wire [2:0] newAQEn;
  wire [2:0] newBQEn;
  reg [2:0] on_M;
  reg [2:0] on_M_reg;
  reg [2:0] on_XM;
 // reg [3*BUF_COUNT-1:0] new_conflictAp_reg;
 // reg [3*BUF_COUNT-1:0] new_conflictBp_reg;
  //wire [1:0] lstep1_multi;
  //wire lstep1_allow;
  wire [DATA_WIDTH-1:0] lstep1_owndataA;
  wire [DATA_WIDTH-1:0] lstep1_owndataB;
//  wire lstep1_undoA;
//  wire lstep1_undoB;
 // reg lstep1_undoA_reg;
 // reg lstep1_undoB_reg;
  
//  wire lstep2_undoA;
//  wire lstep2_undoB;
//  reg lstep2_undoA_reg;
 // reg lstep2_undoB_reg;
  reg [1:0] lstep1_invd_acc;
  wire lDoNext_Aq0;
  wire lDoNext_Bq0; 
  //reg lstep2_multiA_reg,lstep2_multiB_reg;

  reg confl_waited;
  reg [5:0] new_c_mask;
  reg [5:0] new_c_confl; 
 // wire lDoStall_Aq;
 // wire lDoStall_Bq;
 // wire lDoStall_Aq0;
 // wire lDoStall_Bq0;
  wire [2+1 :0] lDoNext_Aq1;
  wire [1+ 2:0] lDoNext_Bq1;
  reg  [1:0] lDoNext_Aq1R;
  reg  [1:0] lDoNext_Bq1R;
  wire lStFirst;
  reg lStFirst_pause; 
  wire free_on0,free_on1,free_on2; 
  wire free_on0A,free_on1A,free_on2A; 
  wire [2:0][BUF_COUNT-1:0] nChNextA ;
  wire [3*BUF_COUNT-1:0] nChNextB ;
 // wire [2:0] nChNextAx;
 // wire [2:0] nChNextBx;
  reg free2_reg;  
  reg [9:0] wret_II0_reg;
  reg wret_en0_reg;
  reg [9:0] wret_II1_reg;
  reg wret_en1_reg;

  wire [4:0] std_bankA0;
  wire [4:0] std_bankB0;

  wire [2:0][BUF_COUNT-1:0] ins_addr_bit;
  reg [BUF_COUNT-1:0] ins_addr_bit_reg[2:0];
  
  wire [2:0][BUF_COUNT-1:0] ret_hit;
  wire [2:0][9:0] pos_iimask;

  wire [1:0] lstep1_invd;
  reg [1:0] lstep1_invd_reg;
  reg [1:0] lstep1_invd_reg2;
  wire [1:0] out_invd;
  wire [1:0] out_invd2;

  wire lstep2A_validA;
  wire lstep2A_validB;

  wire [2:0][BUF_COUNT-1:0] newII_chk;
  integer b;
  wire newII_stall;
 /// wire lDoStall_inv0;

  //reg lDoStall_reg;

/*  function [3:0] bank_reorder;
      input [3:0] banks;
      input [4:0] bank0;
      case(bank0[1:0])
      2'd0: bank_reorder=banks;
      2'd1: bank_reorder={banks[0],banks[3:1]};
      2'd2: bank_reorder={banks[1:0],banks[3:2]};
      2'd3: bank_reorder={banks[2:0],banks[3]};
      endcase
  endfunction*/
//  popcnt3_or_more retcnt_mod(ret_mask_store,retcnt_more);
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

  function [3:0] bnmask;
      input [1:0] low;
      input [4:0] sz;
      input [4:0] bgn;
     // reg stepOver;
     // reg stepOver2;
      reg [3:0] ops=fsz(sz);
      begin
          bnmask=1;
          bnmask[1]=ops==3 || ops[2];
	  bnmask[2]=ops[2];
	  bnmask[3]=ops==5 || ops==6;
      end 
  endfunction
  generate
    genvar t,c,p,n1,n2;
    for(t=0;t<6;t=t+1) begin : aport_gen
     //   bit_find_last_bit #(3*BUF_COUNT) confl1Bit_mod(new_conflict1_reg[t],new_conflict1r[t],new_conflict_has1r[t]);
     //   bit_find_last_bit #(3*BUF_COUNT) confl2Bit_mod(new_conflict2_reg[t],new_conflict2r[t],new_conflict_has2r[t]);
     //   bit_find_last_bit #(3*BUF_COUNT) confl1rBit_mod(new_conflict1r[t],new_conflict1rr[t],new_conflict_has1rr[t]);
     //   bit_find_last_bit #(3*BUF_COUNT) confl2rBit_mod(new_conflict2r[t],new_conflict2rr[t],new_conflict_has2rr[t]);
        
        
        
       storq_genaddr gdr_mod(
       .conflictM(new_conflict2q[t]),
       .conflictN(new_conflict1q[t]),
       .bit0(new_conflict1p[t][0*BUF_COUNT+:BUF_COUNT]),.bank0(new_conflict1p_b0[t]),.has0(new_conflict_has1p[t][0]),
       .bit1(new_conflict1p[t][1*BUF_COUNT+:BUF_COUNT]),.bank1(new_conflict1p_b1[t]),.has1(new_conflict_has1p[t][1]),
       .bit2(new_conflict1p[t][2*BUF_COUNT+:BUF_COUNT]),.bank2(new_conflict1p_b2[t]),.has2(new_conflict_has1p[t][2]),
//  bit,
//  on_M,
       .multi()
       ); 
	assign wrt_dataA[0]=(new_data_shr[`lsqshare_wrt0]==t) ? new_dataA[t] : {DATA_WIDTH{1'BZ}};
        assign wrt_dataA[1]=(new_data_shr[`lsqshare_wrt1]==t) ? new_dataA[t] : {DATA_WIDTH{1'BZ}};
        assign wrt_dataA[2]=(new_data_shr[`lsqshare_wrt2]==t) ? new_dataA[t] : {DATA_WIDTH{1'BZ}};
	assign wrt_indexA[0]=(new_data_shr[`lsqshare_wrt0]==t) ? t[2:0] : 3'BZ;
	assign wrt_indexA[1]=(new_data_shr[`lsqshare_wrt1]==t) ? t[2:0] : 3'BZ;
	assign wrt_indexA[2]=(new_data_shr[`lsqshare_wrt2]==t) ? t[2:0] : 3'BZ;
        //assign conflict_first=(confl_first[t]) ? new_conflict_reg[t] : {3*BUF_COUNT{1'BZ}};
        //assign conflict_last=(confl_last[t]) ? new_conflict_reg[t] : {3*BUF_COUNT{1'BZ}};
        assign new_confl[t]=((|new_conflict[t]) || (|new_conflict_ex[t])) && new_c_confl[t]|new_c_mask[t];
        assign LDQmask[t]=new_c_confl[t]|new_c_mask[t];
   //     assign lstep1_multi[0]=(confl_first[t] &  new_conflict_has1r[t]) ? 0!=(~new_conflict1r[t]&new_conflict1_reg[t]) : 1'bz;
   //     assign lstep1_multi[0]=(confl_first[t] & ~new_conflict_has1r[t]) ? 0!=(~new_conflict2r[t]&new_conflict2_reg[t]) : 1'bz;
   //     assign lstep1_multi[1]=(confl_last[t] &  new_conflict_has1r[t]) ? 0!=(~new_conflict1r[t]&new_conflict1_reg[t]) : 1'bz;
   //     assign lstep1_multi[1]=(confl_last[t] & ~new_conflict_has1r[t]) ? 0!=(~new_conflict2r[t]&new_conflict2_reg[t]) : 1'bz;
        
        assign new_conflictA[0*BUF_COUNT+:3*BUF_COUNT]=(confl_first[t]) ? new_conflict1p[t][0*BUF_COUNT+:3*BUF_COUNT] : {3*BUF_COUNT{1'bz}};
        assign new_conflictB[0*BUF_COUNT+:3*BUF_COUNT]=(confl_last[t])  ? new_conflict1p[t][0*BUF_COUNT+:3*BUF_COUNT] : {3*BUF_COUNT{1'bz}};
        
        
	assign new_conflictA_b[0]=(confl_first[t]) ? new_conflict1p_b0[t] : 4'bz;
        assign new_conflictB_b[0]=(confl_last[t]) ? new_conflict1p_b0[t] : 4'bz;
        
	assign new_conflictA_b[1]=(confl_first[t]) ? new_conflict1p_b1[t] : 4'bz;
        assign new_conflictB_b[1]=(confl_last[t]) ? new_conflict1p_b1[t] : 4'bz;
        
	assign new_conflictA_b[2]=(confl_first[t]) ? new_conflict1p_b2[t] : 4'bz;
        assign new_conflictB_b[2]=(confl_last[t]) ? new_conflict1p_b2[t] : 4'bz;
        
        assign new_conflictA_has=(confl_first[t]) ? new_conflict_has1p[t] : 3'bz;
        assign new_conflictB_has=(confl_last[t]) ? new_conflict_has1p[t] : 3'bz;
        

        assign lstep1_owndataA=(confl_first[t]) ? new_dataA_chk_reg[t] : {DATA_WIDTH{1'BZ}};
        assign lstep1_owndataB=(confl_last[t] ) ? new_dataA_chk_reg[t] : {DATA_WIDTH{1'BZ}};

        assign new_conflictx=(confl_first[t]) ? new_conflict1q[t]|new_conflict2q[t] : {3*BUF_COUNT{1'BZ}};
        assign new_conflicty=(confl_last[t]) ? new_conflict1q[t]|new_conflict2q[t] : {3*BUF_COUNT{1'BZ}};

        if (t!=0) storq_check_same_clk #(t) clk_chk_mod(
        .dataA0(new_dataA_chk[0]),.dataEnA0(new_enA_reg[0]&new_c_mask[0]),
        .dataA1(new_dataA_chk[1]),.dataEnA1(new_enA_reg[1]&new_c_mask[1]),
        .dataA2(new_dataA_chk[2]),.dataEnA2(new_enA_reg[2]&new_c_mask[2]),
        .dataA3(new_dataA_chk[3]),.dataEnA3(new_enA_reg[3]&new_c_mask[3]),
        .dataA4(new_dataA_chk[4]),.dataEnA4(new_enA_reg[4]&new_c_mask[4]),
        .dataA5(new_dataA_chk[5]),.dataEnA5(new_enA_reg[5]&new_c_mask[5]),
        .ind0(pos_indexA[0]),.bits0(ins_addr_bit[0]&~nChNextA[0]),
        .ind1(pos_indexA[1]),.bits1(ins_addr_bit[1]&~nChNextA[1]),
        .ind2(pos_indexA[2]),.bits2(ins_addr_bit[2]&~nChNextA[2]),
        .last_wrt(),
        .has_wrt(new_confl_ex[t]),
        .bits(new_conflict_ex[t])
        );
        else begin
            assign new_confl_ex[t]=(new_dataA_chk[0][`lsaddr_flag]|new_dataA_chk[0][`lsaddr_pconfl]) & ~new_dataA_chk[0][`lsaddr_st] & new_enA_reg[0]; 
            assign new_conflict_ex[t]=96'b0;
        end
    end
    for(p=0;p<10;p=p+1) begin
        assign retX_m[0]=(ret_data_shr[`lsqshare_wrtII0]==p) ? ~ret_mask[p] & ~ret_wait[p] & ret_has_ldst : 1'bz;
        assign retX_m[1]=(ret_data_shr[`lsqshare_wrtII1]==p) ? ~ret_mask[p] & ~ret_wait[p] & ret_has_ldst : 1'bz;
        assign retX_m[2]=(ret_data_shr[`lsqshare_wrtII2]==p) ? ~ret_mask[p] & ~ret_wait[p] & ret_has_ldst : 1'bz;

        assign pos_iimask[0][p]=pos_dataA[0][`lsaddr_II_low]==p;
        assign pos_iimask[1][p]=pos_dataA[1][`lsaddr_II_low]==p;
        assign pos_iimask[2][p]=pos_dataA[2][`lsaddr_II_low]==p;
    end
    for(c=0;c<3;c=c+1) begin : store_mod
      
        bit_find_first_bit #(32) lastM_mod(~free[c]&free_maskXM[c],free_lastM[c],has_freeM[c]);
        bit_find_first_bit #(32) lastN_mod(~free[c]&free_maskXN[c],free_lastN[c],has_freeN[c]);

        bit_find_first_bit #(4) lastMB_mod({|(~free[c][31:24]&free_maskXM[c][31:24]),
          |(~free[c][23:16]&free_maskXM[c][23:16]),|(~free[c][15:8]&free_maskXM[c][15:8]),
          |(~free[c][7:0]&free_maskXM[c][7:0])},free_lastM_bank[c],);
        bit_find_first_bit #(4) lastNB_mod({|(~free[c][31:24]&free_maskXN[c][31:24]),
          |(~free[c][23:16]&free_maskXN[c][23:16]),|(~free[c][15:8]&free_maskXN[c][15:8]),
          |(~free[c][7:0]&free_maskXN[c][7:0])},free_lastN_bank[c],);

        adder_inc #(5) MincF_mod(ins_addr[c],ins_addr_d[c],pos_en[c],);
        adder_inc #(5) MincF1_mod(insh_addr[c],insh_addr_d[c],posh_en[c],);
        
        storq_array storq_mod(
        .clk(clk),
        .rst(rst),
        .stall(stall|stallone[(c+1)%3]|stallone[(c+2)%3]),.doStall(stallone[c]),.newI_alloc(newI_alloc[c]),
        .except(except),.excpt_thread(excpt_thread),
        .newAddrE0(pos_dataA[c][`lsaddr_addrE]),.newAddrO0(pos_dataA[c][`lsaddr_addrO]),
        .newBanks0(pos_dataA[c][`lsaddr_banks]),.newBlow0(pos_dataA[c][`lsaddr_blow]),.newII0(pos_dataA[c][`lsaddr_II]),.newIIMask0(pos_iimask[c]),
        .newIsOH0(pos_dataA[c][`lsaddr_OH]),.newIsEH0(pos_dataA[c][`lsaddr_EH]),
        .newIsOL0(pos_dataA[c][`lsaddr_OL]),.newIsEL0(pos_dataA[c][`lsaddr_EL]),
        .newId0(ins_addr[c]),.newEn0(pos_en[c] & ~aStall & ~aDoStall & ~~new_enP_reg),.newOK0(~pos_dataA[c][`lsaddr_except]),
        .newSZ0(pos_dataA[c][`lsaddr_sz]),.newBankA0(pos_dataA[c][`lsaddr_bank0]),
        .newOdd0(pos_dataA[c][`lsaddr_odd]),.newAddrLow0(pos_dataA[c][`lsaddr_low]),
        .newSplit0(pos_dataA[c][`lsaddr_split]),
        .newThread0(new_thr),
        .chkAddrE0(new_dataA_chk[0][`lsaddr_addrE]),.chkAddrO0(new_dataA_chk[0][`lsaddr_addrO]),
          .chkBanks0(new_dataA_chk[0][`lsaddr_banks]),.chkBlow0(new_dataA_chk[0][`lsaddr_blow]),.chkAddrLow0(new_dataA_chk[0][`lsaddr_low]),
          .chkIsOH0(new_dataA_chk[0][`lsaddr_OH]),.chkIsEH0(new_dataA_chk[0][`lsaddr_EH]),.chkIsOL0(new_dataA_chk[0][`lsaddr_OL]),
          .chkIsEL0(new_dataA_chk[0][`lsaddr_EL]),.chkMatch0(new_conflict[0][BUF_COUNT*c+:BUF_COUNT]),
	  .chkMatchIn0(new_conflict_ex[0][BUF_COUNT*c+:BUF_COUNT]),
          .chkEn0(~new_dataA_chk[0][`lsaddr_except] && ~new_dataA_chk[0][`lsaddr_st] && new_enA_reg[0] && new_c_mask[0]),
        .chkAddrE1(new_dataA_chk[1][`lsaddr_addrE]),.chkAddrO1(new_dataA_chk[1][`lsaddr_addrO]),
          .chkBanks1(new_dataA_chk[1][`lsaddr_banks]),.chkBlow1(new_dataA_chk[1][`lsaddr_blow]),.chkAddrLow1(new_dataA_chk[1][`lsaddr_low]),
          .chkIsOH1(new_dataA_chk[1][`lsaddr_OH]),.chkIsEH1(new_dataA_chk[1][`lsaddr_EH]),.chkIsOL1(new_dataA_chk[1][`lsaddr_OL]),
          .chkIsEL1(new_dataA_chk[1][`lsaddr_EL]),.chkMatch1(new_conflict[1][BUF_COUNT*c+:BUF_COUNT]),
	  .chkMatchIn1(new_conflict_ex[1][BUF_COUNT*c+:BUF_COUNT]),
          .chkEn1(~new_dataA_chk[1][`lsaddr_except] && new_enA_reg[1] && ~new_dataA_chk[1][`lsaddr_st] && new_c_mask[1]),
        .chkAddrE2(new_dataA_chk[2][`lsaddr_addrE]),.chkAddrO2(new_dataA_chk[2][`lsaddr_addrO]),
          .chkBanks2(new_dataA_chk[2][`lsaddr_banks]),.chkBlow2(new_dataA_chk[2][`lsaddr_blow]),.chkAddrLow2(new_dataA_chk[2][`lsaddr_low]),
          .chkIsOH2(new_dataA_chk[2][`lsaddr_OH]),.chkIsEH2(new_dataA_chk[2][`lsaddr_EH]),.chkIsOL2(new_dataA_chk[2][`lsaddr_OL]),
          .chkIsEL2(new_dataA_chk[2][`lsaddr_EL]),.chkMatch2(new_conflict[2][BUF_COUNT*c+:BUF_COUNT]),
	  .chkMatchIn2(new_conflict_ex[2][BUF_COUNT*c+:BUF_COUNT]),
          .chkEn2(~new_dataA_chk[2][`lsaddr_except] && new_enA_reg[2] && ~new_dataA_chk[2][`lsaddr_st] && new_c_mask[2]),
        .chkAddrE3(new_dataA_chk[3][`lsaddr_addrE]),.chkAddrO3(new_dataA_chk[3][`lsaddr_addrO]),
          .chkBanks3(new_dataA_chk[3][`lsaddr_banks]),.chkBlow3(new_dataA_chk[3][`lsaddr_blow]),.chkAddrLow3(new_dataA_chk[3][`lsaddr_low]),
          .chkIsOH3(new_dataA_chk[3][`lsaddr_OH]),.chkIsEH3(new_dataA_chk[3][`lsaddr_EH]),.chkIsOL3(new_dataA_chk[3][`lsaddr_OL]),
          .chkIsEL3(new_dataA_chk[3][`lsaddr_EL]),.chkMatch3(new_conflict[3][BUF_COUNT*c+:BUF_COUNT]),
	  .chkMatchIn3(new_conflict_ex[3][BUF_COUNT*c+:BUF_COUNT]),
          .chkEn3(~new_dataA_chk[3][`lsaddr_except] && new_enA_reg[3] && ~new_dataA_chk[3][`lsaddr_st] && new_c_mask[3]),
        .chkAddrE4(new_dataA_chk[4][`lsaddr_addrE]),.chkAddrO4(new_dataA_chk[4][`lsaddr_addrO]),
          .chkBanks4(new_dataA_chk[4][`lsaddr_banks]),.chkBlow4(new_dataA_chk[4][`lsaddr_blow]),.chkAddrLow4(new_dataA_chk[4][`lsaddr_low]),
          .chkIsOH4(new_dataA_chk[4][`lsaddr_OH]),.chkIsEH4(new_dataA_chk[4][`lsaddr_EH]),.chkIsOL4(new_dataA_chk[4][`lsaddr_OL]),
          .chkIsEL4(new_dataA_chk[4][`lsaddr_EL]),.chkMatch4(new_conflict[4][BUF_COUNT*c+:BUF_COUNT]),
	  .chkMatchIn4(new_conflict_ex[4][BUF_COUNT*c+:BUF_COUNT]),
          .chkEn4(~new_dataA_chk[4][`lsaddr_except] && new_enA_reg[4] && ~new_dataA_chk[4][`lsaddr_st] && new_c_mask[4]),
        .chkAddrE5(new_dataA_chk[5][`lsaddr_addrE]),.chkAddrO5(new_dataA_chk[5][`lsaddr_addrO]),
          .chkBanks5(new_dataA_chk[5][`lsaddr_banks]),.chkBlow5(new_dataA_chk[5][`lsaddr_blow]),.chkAddrLow5(new_dataA_chk[5][`lsaddr_low]),
          .chkIsOH5(new_dataA_chk[5][`lsaddr_OH]),.chkIsEH5(new_dataA_chk[5][`lsaddr_EH]),.chkIsOL5(new_dataA_chk[5][`lsaddr_OL]),
          .chkIsEL5(new_dataA_chk[5][`lsaddr_EL]),.chkMatch5(new_conflict[5][BUF_COUNT*c+:BUF_COUNT]),
	  .chkMatchIn5(new_conflict_ex[5][BUF_COUNT*c+:BUF_COUNT]),
          .chkEn5(~new_dataA_chk[5][`lsaddr_except] && new_enA_reg[5] && ~new_dataA_chk[5][`lsaddr_st] && new_c_mask[5]),
        .chkBAddrE0(pch_dataA0[`lsaddr_addrE]),.chkBAddrO0(pch_dataA0[`lsaddr_addrO]),
          .chkBBanks0(pch_dataA0[`lsaddr_banks]),.chkBBlow0(pch_dataA0[`lsaddr_blow]),.chkBAddrLow0(pch_dataA0[`lsaddr_low]),
          .chkBIsOH0(pch_dataA0[`lsaddr_OH]),
          .chkBIsEH0(pch_dataA0[`lsaddr_EH]),.chkBIsOL0(pch_dataA0[`lsaddr_OL]),
          .chkBIsEL0(pch_dataA0[`lsaddr_EL]),.chkBMatch0(pch_conflict[0][BUF_COUNT*c+:BUF_COUNT]),
          .chkBEn0(~pch_dataA0[`lsaddr_except]),
        .chkBAddrE1(pch_dataA1[`lsaddr_addrE]),.chkBAddrO1(pch_dataA1[`lsaddr_addrO]),
          .chkBBanks1(pch_dataA1[`lsaddr_banks]),.chkBBlow1(pch_dataA1[`lsaddr_blow]),.chkBAddrLow1(pch_dataA1[`lsaddr_low]),
          .chkBIsOH1(pch_dataA1[`lsaddr_OH]),
          .chkBIsEH1(pch_dataA1[`lsaddr_EH]),.chkBIsOL1(pch_dataA1[`lsaddr_OL]),
          .chkBIsEL1(pch_dataA1[`lsaddr_EL]),.chkBMatch1(pch_conflict[1][BUF_COUNT*c+:BUF_COUNT]),
          .chkBEn1(~pch_dataA1[`lsaddr_except]),
        .chkBAddrE2(pch_dataA2[`lsaddr_addrE]),.chkBAddrO2(pch_dataA2[`lsaddr_addrO]),
          .chkBBanks2(pch_dataA2[`lsaddr_banks]),.chkBBlow2(pch_dataA2[`lsaddr_blow]),.chkBAddrLow2(pch_dataA2[`lsaddr_low]),
          .chkBIsOH2(pch_dataA2[`lsaddr_OH]),
          .chkBIsEH2(pch_dataA2[`lsaddr_EH]),.chkBIsOL2(pch_dataA2[`lsaddr_OL]),
          .chkBIsEL2(pch_dataA2[`lsaddr_EL]),.chkBMatch2(pch_conflict[2][BUF_COUNT*c+:BUF_COUNT]),
          .chkBEn2(~pch_dataA2[`lsaddr_except]),
        .chkBAddrE3(pch_dataA3[`lsaddr_addrE]),.chkBAddrO3(pch_dataA3[`lsaddr_addrO]),
          .chkBBanks3(pch_dataA3[`lsaddr_banks]),.chkBBlow3(pch_dataA3[`lsaddr_blow]),.chkBAddrLow3(pch_dataA3[`lsaddr_low]),
          .chkBIsOH3(pch_dataA3[`lsaddr_OH]),
          .chkBIsEH3(pch_dataA3[`lsaddr_EH]),.chkBIsOL3(pch_dataA3[`lsaddr_OL]),
          .chkBIsEL3(pch_dataA3[`lsaddr_EL]),.chkBMatch3(pch_conflict[3][BUF_COUNT*c+:BUF_COUNT]),
          .chkBEn3(~pch_dataA3[`lsaddr_except]),
        .chkAddrE6(36'b0),.chkAddrO6(36'b0), .chkIsOH6(1'b0),.chkIsEH6(1'b0),.chkIsOL6(1'b0),.chkIsEL6(1'b0),.chkMatch6(),
        .nChNext0(nChNextA[c]),
        .freeEn0(freeEn[c]),
        .freeII1A(wret_II0),.freeEn1A(wret_en0),
        .freeII1B(wret_II1),.freeEn1B(wret_en1),
        .ret_II(ret_data_shr[`lsqshare_II]),.ret_mask(~ret_mask),.ret_en(ret_has_ldst&~bStall),.ret_hit(ret_hit[c]),
        .newII_upper(newII_upper),.newII_chk(newII_chk[c]),
        .free0(free[c]),
        .free1(free2[c])
        );

         lsw_ram lsw_mod(
           clk,rst,
           pfree_data[c],freeEn[c],freeEn_bank[c],ret_has_ldst&&free_eat[c],
           ins_addr[c],pos_dataA[c],pos_en[c]);   
        
 //       assign s_lstep2_dataA=lstep2A_cnHasA[c] ? lstep2A_ldataA[c] : {DATA_WIDTH{1'BZ}};
 //       assign s_lstep2_dataB=lstep2A_cnHasB[c] ? lstep2A_ldataB[c] : {DATA_WIDTH{1'BZ}};
	
        assign free_last[c]=has_freeN[c] ? free_lastN[c] : free_lastM[c];
	assign free_last_bank[c]=has_freeN[c] ? free_lastN_bank[c] : free_lastM_bank[c];
        assign has_free[c]=has_freeN[c] | has_freeM[c];
       
        assign new_conflict_exx=new_conflict_ex[0]|new_conflict_ex[1]|new_conflict_ex[2]
            |new_conflict_ex[3]|new_conflict_ex[4]|new_conflict_ex[5];	
	assign pos_dataA[c]=cur_posh[c] ? wrt_dataA_reg[0] : {DATA_WIDTH{1'BZ}};
        assign pos_dataA[c]=cur_posh[(c+2)%3] ? wrt_dataA_reg[1] : {DATA_WIDTH{1'BZ}};
        assign pos_dataA[c]=cur_posh[(c+1)%3] ? wrt_dataA_reg[2] : {DATA_WIDTH{1'BZ}};
      
	assign pos_indexA[c]=cur_posh[c] ? wrt_indexA_reg[0] : 3'BZ;
        assign pos_indexA[c]=cur_posh[(c+2)%3] ? wrt_indexA_reg[1] : 3'BZ;
        assign pos_indexA[c]=cur_posh[(c+1)%3] ? wrt_indexA_reg[2] : 3'BZ;
        
        assign pos_en[c]=cur_pos[c] ? wrt_cnt[3:1]!=0 : 1'BZ;
        assign pos_en[c]=cur_pos[(c+2)%3] ? wrt_cnt[3:2]!=0 : 1'BZ;
        assign pos_en[c]=cur_pos[(c+1)%3] ? wrt_cnt[3]!=0 : 1'BZ;

        assign posh_en[c]=cur_posh[c] ? wroet_cnt[3:1]!=0 : 1'BZ;
        assign posh_en[c]=cur_posh[(c+2)%3] ? wroet_cnt[3:2]!=0 : 1'BZ;
        assign posh_en[c]=cur_posh[(c+1)%3] ? wroet_cnt[3]!=0 : 1'BZ;

        assign pfree_data_shr[2*c+:2]=free_on[c] ? 2'd0 | {2{~free_eat[c]}} : 2'bz;
        assign pfree_data_shr[2*c+:2]=free_on[(c+2)%3] ? 2'd1 | {2{~free_eat[c]}} : 2'bz;
        assign pfree_data_shr[2*c+:2]=free_on[(c+1)%3] ? 2'd2 | {2{~free_eat[c]}} : 2'bz;

        assign ins_addr_d[c]=pos_en[c] ? 5'bz : ins_addr[c];       
        assign ins_addr_cout[c]=ins_addr[c]==5'h1f && pos_en[c]; 
        assign insh_addr_d[c]=posh_en[c] ? 5'bz : insh_addr[c];       
        assign insh_addr_cout[c]=insh_addr[c]==5'h1f && posh_en[c]; 
      
        for(n1=0;n1<BUF_COUNT;n1=n1+1) begin
            for(n2=0;n2<6;n2=n2+1) begin
                assign new_conflict1[n2][n1*3+c]=new_conflict[n2][BUF_COUNT*c+n1]& free_maskN[c][n1]
                  || new_conflict_ex[n2][BUF_COUNT*c+n1] &~on_M[c];
                assign new_conflict2[n2][n1*3+c]=new_conflict[n2][BUF_COUNT*c+n1]& free_maskM[c][n1]
                  || new_conflict_ex[n2][BUF_COUNT*c+n1] &on_M[c];
                assign new_conflict1q[n2][BUF_COUNT*c+n1]=new_conflict1_reg[n2][n1*3+c];
                assign new_conflict2q[n2][BUF_COUNT*c+n1]=new_conflict2_reg[n2][n1*3+c];
            end
            assign nChNextB[n1*3+c]=nChNextA[c][n1];
            assign new_conflictAq[BUF_COUNT*c+n1]=new_conflictAp[n1*3+c];
            assign new_conflictBq[BUF_COUNT*c+n1]=new_conflictBp[n1*3+c];
            assign ins_addr_bit[c][n1]=insh_addr[c]==n1 && posh_en[c];
        end

    end

  endgenerate
  
  assign newII_stall=(|newII_chk[0]) || (|newII_chk[1]) || (|newII_chk[2]);
  assign pfree_data0=pfree_data[0];
  assign pfree_data1=pfree_data[1];
  assign pfree_data2=pfree_data[2];
  assign pfree_en0=ret_has_ldst&&free_eat[0];
  assign pfree_en1=ret_has_ldst&&free_eat[1];
  assign pfree_en2=ret_has_ldst&&free_eat[2];

  assign doStall=(|stallone) || newII_req & newII_stall;
  assign rDoStall=retcnt_more[3] && ret_has_ldst;

  assign p1_ins_addr0=ins_addr[0];
  assign p1_pos_dataA0=pos_dataA[0]; 
  assign p1_pos_en0=pos_en[0];
  assign p1_ins_addr1=ins_addr[1];
  assign p1_pos_dataA1=pos_dataA[1]; 
  assign p1_pos_en1=pos_en[1];
  assign p1_ins_addr2=ins_addr[2];
  assign p1_pos_dataA2=pos_dataA[2]; 
  assign p1_pos_en2=pos_en[2];

  assign m_mask={free_maskM[2],free_maskM[1],free_maskM[0]};
  assign n_mask={free_maskN[2],free_maskN[1],free_maskN[0]};


//  assign s_lstep2_dataA=lstep2A_cnHasA!=0  ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
//  assign s_lstep2_dataB=lstep2A_cnHasB!=0  ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  
  assign lstep1_owndataA=(!confl_cnt[0]) ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign lstep1_owndataB=(confl_cnt[1:0]==0) ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  
  assign wrt_en[0]=(new_data_shr[`lsqshare_wrt0]==3'd0 && new_enP && new_enA0&~new_en_mask0[0]) ||
	  (new_data_shr[`lsqshare_wrt0]==3'd1 && new_enP && new_enA1&~new_en_mask0[1]) ||
	  (new_data_shr[`lsqshare_wrt0]==3'd2 && new_enP && new_enA2&~new_en_mask0[2]) ||
	  (new_data_shr[`lsqshare_wrt0]==3'd3 && new_enP && new_enA3&~new_en_mask0[3]) ||
	  (new_data_shr[`lsqshare_wrt0]==3'd4 && new_enP && new_enA4&~new_en_mask0[4]) ||
	  (new_data_shr[`lsqshare_wrt0]==3'd5 && new_enP && new_enA5&~new_en_mask0[5]);
  assign wrt_en[1]=(new_data_shr[`lsqshare_wrt1]==3'd0 && new_enP && new_enA0&~new_en_mask0[0]) ||
	  (new_data_shr[`lsqshare_wrt1]==3'd1 && new_enP && new_enA1&~new_en_mask0[1]) ||
	  (new_data_shr[`lsqshare_wrt1]==3'd2 && new_enP && new_enA2&~new_en_mask0[2]) ||
	  (new_data_shr[`lsqshare_wrt1]==3'd3 && new_enP && new_enA3&~new_en_mask0[3]) ||
	  (new_data_shr[`lsqshare_wrt1]==3'd4 && new_enP && new_enA4&~new_en_mask0[4]) ||
	  (new_data_shr[`lsqshare_wrt1]==3'd5 && new_enP && new_enA5&~new_en_mask0[5]);
  assign wrt_en[2]=(new_data_shr[`lsqshare_wrt2]==3'd0 && new_enP && new_enA0&~new_en_mask0[0]) ||
	  (new_data_shr[`lsqshare_wrt2]==3'd1 && new_enP && new_enA1&~new_en_mask0[1]) ||
	  (new_data_shr[`lsqshare_wrt2]==3'd2 && new_enP && new_enA2&~new_en_mask0[2]) ||
	  (new_data_shr[`lsqshare_wrt2]==3'd3 && new_enP && new_enA3&~new_en_mask0[3]) ||
	  (new_data_shr[`lsqshare_wrt2]==3'd4 && new_enP && new_enA4&~new_en_mask0[4]) ||
	  (new_data_shr[`lsqshare_wrt2]==3'd5 && new_enP && new_enA5&~new_en_mask0[5]);

  assign wroet_en[0]=new_data_shr[`lsqshare_wrt0]!=3'h7;
  assign wroet_en[1]=new_data_shr[`lsqshare_wrt1]!=3'h7;
  assign wroet_en[2]=new_data_shr[`lsqshare_wrt2]!=3'h7;
  
  assign wrt_dataA[0]=wroet_en[0] ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign wrt_dataA[1]=wroet_en[1] ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign wrt_dataA[2]=wroet_en[2] ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};

  assign wrt_indexA[0]=wroet_en[0] ? 3'BZ : 3'h6;
  assign wrt_indexA[1]=wroet_en[1] ? 3'BZ : 3'h6;
  assign wrt_indexA[2]=wroet_en[2] ? 3'BZ : 3'h6;
  
  assign retX_m[0]=(ret_data_shr[`lsqshare_wrtII0]==4'hf) ? 1'b0 : 1'bz;
  assign retX_m[1]=(ret_data_shr[`lsqshare_wrtII1]==4'hf) ? 1'b0 : 1'bz;
  assign retX_m[2]=(ret_data_shr[`lsqshare_wrtII2]==4'hf) ? 1'b0 : 1'bz;

  assign retcnt_more[1]=|retX_m;
  assign retcnt_more[2]=&retX_m[1:0] || &retX_m[2:1] || retX_m[0]&retX_m[2];
  assign retcnt_more[3]=&retX_m;

  assign roetcnt_more[1]=(ret_data_shr[`lsqshare_wrtII0]!=4'hf) & ret_has_ldst;
  assign roetcnt_more[2]=(ret_data_shr[`lsqshare_wrtII1]!=4'hf) & ret_has_ldst;
  assign roetcnt_more[3]=(ret_data_shr[`lsqshare_wrtII2]!=4'hf) & ret_has_ldst;
  
  

  assign free_on2=~free_on1 && ~~~free_on0;
  assign free_on1=~free_on0 && ( (free_lastN[1]&free_lastNG)!=0  || (~free_hasNG && (free_lastM[1]&free_lastMG)!=0));
  assign free_on0= (free_lastN[0]&free_lastNG)!=0 || (~free_hasNG && (free_lastM[0]&free_lastMG)!=0);

  assign free_on[0]=free_on0;
  assign free_on[1]=free_on1;
  assign free_on[2]=free_on2;

  assign freeEn[0]=free_last[0] & {BUF_COUNT{ret_has_ldst&&free_eat[0]}};
  assign freeEn[1]=free_last[1] & {BUF_COUNT{ret_has_ldst&&free_eat[1]}};
  assign freeEn[2]=free_last[2] & {BUF_COUNT{ret_has_ldst&&free_eat[2]}};
  
  assign freeOEn[0]=free_last[0] & {BUF_COUNT{ret_retire&&ret_has_ldst&&free_oeat[0]}};
  assign freeOEn[1]=free_last[1] & {BUF_COUNT{ret_retire&&ret_has_ldst&&free_oeat[1]}};
  assign freeOEn[2]=free_last[2] & {BUF_COUNT{ret_retire&&ret_has_ldst&&free_oeat[2]}};


  assign freeEn_bank[0]=free_last_bank[0] & {4{ret_has_ldst&&free_eat[0]!=0}};
  assign freeEn_bank[1]=free_last_bank[1] & {4{ret_has_ldst&&free_eat[1]!=0}};
  assign freeEn_bank[2]=free_last_bank[2] & {4{ret_has_ldst&&free_eat[2]!=0}};
  
  assign free_eat[0]=(free_on[0] & retcnt_more[1] || free_on[2] & retcnt_more[2]) && has_free[0] &~bStall;
  assign free_eat[1]=(free_on[1] & retcnt_more[1] || free_on[0] & retcnt_more[2]) && has_free[1] &~bStall;
  assign free_eat[2]=(free_on[2] & retcnt_more[1] || free_on[1] & retcnt_more[2]) && has_free[2] &~bStall;

  assign free_oeat[0]=(free_on[0] & roetcnt_more[1] || free_on[2] & roetcnt_more[2] || roetcnt_more[3]) && has_free[0];
  assign free_oeat[1]=(free_on[1] & roetcnt_more[1] || free_on[0] & roetcnt_more[2] || roetcnt_more[3]) && has_free[1];
  assign free_oeat[2]=(free_on[2] & roetcnt_more[1] || free_on[1] & roetcnt_more[2] || roetcnt_more[3]) && has_free[2];

  
  assign new_dataA[0]=new_dataA0;
  assign new_dataA[1]=new_dataA1;
  assign new_dataA[2]=new_dataA2;
  assign new_dataA[3]=new_dataA3;
  assign new_dataA[4]=new_dataA4;
  assign new_dataA[5]=new_dataA5;
        
//  assign lDoStall_Aq=new_conflictAq_reg&{nChNextA[2],nChNextA[1],nChNextA[0]}&&~lstep1_invd_reg[0];
//  assign lDoStall_Bq=new_conflictBq_reg&{nChNextA[2],nChNextA[1],nChNextA[0]}&&~lstep1_invd_reg[1];
//  assign lDoStall_Aq0=new_conflictAq&{nChNextA[2],nChNextA[1],nChNextA[0]}&&~lstep1_invd[0];
//  assign lDoStall_Bq0=new_conflictBq&{nChNextA[2],nChNextA[1],nChNextA[0]}&&~lstep1_invd[1];
/*  assign lDoStall_cnA0={lstep2_cnBitA[2],lstep2_cnBitA[1],lstep2_cnBitA[0]}&{nChNextA[2],nChNextA[1],nChNextA[0]}!=96'b0;
  assign lDoStall_cnB0={lstep2_cnBitB[2],lstep2_cnBitB[1],lstep2_cnBitB[0]}&{nChNextA[2],nChNextA[1],nChNextA[0]}!=96'b0;
  assign ilDoStall_cnA1={lstep2_cnBitA_reg[2],lstep2_cnBitA_reg[1],lstep2_cnBitA_reg[0]}&{nChNextA[2],nChNextA[1],nChNextA[0]}!=96'b0;
  assign ilDoStall_cnB1={lstep2_cnBitB_reg[2],lstep2_cnBitB_reg[1],lstep2_cnBitB_reg[0]}&{nChNextA[2],nChNextA[1],nChNextA[0]}!=96'b0; */
  
//  assign lDoStall_A1=new_conflictAq_req2&{nChNextA[2],nChNextA[1],nChNextA[0]}!=96'b0


  assign aDoStall=(lDoStall || lStall || confl_cnt[6:3]!=0) || ~free2[0][ins_addr[0]]
    || ~free2[1][ins_addr[1]] || ~free2[2][ins_addr[2]];

  assign new_conflictAp=confl_cnt[0] ? {3*BUF_COUNT{1'b0}} : {3*BUF_COUNT{1'bz}};
  assign new_conflictBp=confl_cnt[1:0]!=0 ? {3*BUF_COUNT{1'b0}} : {3*BUF_COUNT{1'bz}};
  
  assign new_conflictx[0*BUF_COUNT+:BUF_COUNT]=confl_cnt[0] ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflicty[0*BUF_COUNT+:BUF_COUNT]=confl_cnt[1:0]!=0 ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictx[1*BUF_COUNT+:BUF_COUNT]=confl_cnt[0] ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflicty[1*BUF_COUNT+:BUF_COUNT]=confl_cnt[1:0]!=0 ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictx[2*BUF_COUNT+:BUF_COUNT]=confl_cnt[0] ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflicty[2*BUF_COUNT+:BUF_COUNT]=confl_cnt[1:0]!=0 ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  
  assign new_conflictA[0*BUF_COUNT+:BUF_COUNT]=confl_cnt[0] ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictB[0*BUF_COUNT+:BUF_COUNT]=confl_cnt[1:0]!=0 ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictA[1*BUF_COUNT+:BUF_COUNT]=confl_cnt[0] ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictB[1*BUF_COUNT+:BUF_COUNT]=confl_cnt[1:0]!=0 ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictA[2*BUF_COUNT+:BUF_COUNT]=confl_cnt[0] ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictB[2*BUF_COUNT+:BUF_COUNT]=confl_cnt[1:0]!=0 ? {BUF_COUNT{1'b0}} : {BUF_COUNT{1'bz}};
  assign new_conflictA_b[0]=confl_cnt[0] ? 4'b0 : 4'bz;
  assign new_conflictB_b[0]=confl_cnt[1:0]!=0 ? 4'b0 : 4'bz;
  assign new_conflictA_b[1]=confl_cnt[0] ? 4'b0 : 4'bz;
  assign new_conflictB_b[1]=confl_cnt[1:0]!=0 ? 4'b0 : 4'bz;
  assign new_conflictA_b[2]=confl_cnt[0] ? 4'b0 : 4'bz;
  assign new_conflictB_b[2]=confl_cnt[1:0]!=0  ? 4'b0 : 4'bz;
  assign new_conflictA_has[0]=confl_cnt[0] ? 1'b0 : 1'bz;
  assign new_conflictB_has[0]=confl_cnt[1:0]!=0  ? 1'b0 : 1'bz;
  assign new_conflictA_has[1]=confl_cnt[0] ? 1'b0 : 1'bz;
  assign new_conflictB_has[1]=confl_cnt[1:0]!=0  ? 1'b0 : 1'bz;
  assign new_conflictA_has[2]=confl_cnt[0] ? 1'b0 : 1'bz;
  assign new_conflictB_has[2]=confl_cnt[1:0]!=0  ? 1'b0 : 1'bz;
 
/*  assign lstep1_undoA=(lstep1_dataA[`lsaddr_II]==wret_II0 && wret_en0) ||
    (lstep1_dataA[`lsaddr_II]==wret_II1 && wret_en1);
  assign lstep1_undoB=(lstep1_dataB[`lsaddr_II]==wret_II0 && wret_en0) ||
    (lstep1_dataB[`lsaddr_II]==wret_II1 && wret_en1);

  assign lstep2_undoA=(lstep2_dataA[`lsaddr_II]==wret_II0_reg && wret_en0_reg) ||
    (lstep2_dataA[`lsaddr_II]==wret_II1_reg && wret_en1_reg) ||
    (lstep2_dataA[`lsaddr_II]==wret_II0 && wret_en0) ||
    (lstep2_dataA[`lsaddr_II]==wret_II1 && wret_en1);
  assign lstep2_undoB=(lstep2_dataB[`lsaddr_II]==wret_II0_reg && wret_en0_reg) ||
    (lstep2_dataB[`lsaddr_II]==wret_II1_reg && wret_en1_reg) ||
    (lstep2_dataB[`lsaddr_II]==wret_II0 && wret_en0) ||
    (lstep2_dataB[`lsaddr_II]==wret_II1 && wret_en1);*/
/*
  assign free_lastNG=(free_lastN[0][31]|free_lastN[1][31]|free_lastN[2][31]) && 
    (free_lastN[0][0]|free_lastN[1][0]|free_lastN[2][0]) ?
    32'h8000_0000 : free_lastNG0;
*/
  assign free_lastNG=free_lastNG0;


  assign pch_confl0=|pch_conflict[0];
  assign pch_confl1=|pch_conflict[1];
  assign pch_confl2=|pch_conflict[2];
  assign pch_confl3=|pch_conflict[3];
// sederas pedesar

  assign lstep1_invd[0]=new_conflictA_has==0;
  assign lstep1_invd[1]=new_conflictB_has==0;
  assign out_invd=lstep1_invd_reg2;

  assign p1_new_conflictA_b[3:0]= new_conflictA_b[0];
  assign p1_new_conflictA_b[7:4]= new_conflictA_b[1];
  assign p1_new_conflictA_b[11:8]=new_conflictA_b[2];

  assign p1_new_conflictB_b[3:0]= new_conflictB_b[0];
  assign p1_new_conflictB_b[7:4]= new_conflictB_b[1];
  assign p1_new_conflictB_b[11:8]=new_conflictB_b[2];

  assign p1_nChNextA0=nChNextA[0];
  assign p1_nChNextA1=nChNextA[1];
  assign p1_nChNextA2=nChNextA[2];

  popcnt6 ccnt_mod(new_confl_reg,confl_cnt);
  popcnt3 wcnt_mod(wrt_en_reg,wrt_cnt);
  popcnt3 wcnt2_mod(wroet_en_reg,wroet_cnt);

  bit_find_first_bit #(6) firstC_mod(new_confl_reg,confl_first,);
  bit_find_first_bit #(6) lastC_mod(new_confl_reg&~confl_first,confl_last,);
  
  bit_find_first_bit #(32) firstNG_mod((~free[0]&free_maskXN[0])|(~free[1]&free_maskXN[1])|
    (~free[2]&free_maskXN[2]),free_lastNG0,free_hasNG);      
  bit_find_first_bit #(32) firstMG_mod((~free[0]&free_maskXM[0])|(~free[1]&free_maskXM[1])|
    (~free[2]&free_maskXM[2]),free_lastMG,free_hasMG);      

  always @(posedge clk) begin
 //   if (std_hasB0 && &std_mOpB) $display("XX");
/*    if (rst) begin
        for(b=0;b<6;b=b+1) begin
            new_dataA_chk_reg[b]<={DATA_WIDTH{1'B0}};
	    end
    end else if (new_enP_reg & ~aStall & ~aDoStall) begin
        for(b=0;b<6;b=b+1) begin
            new_dataA_chk_reg[b]<=new_dataA_chk[b];//move to other block??
        end
    end*/
    if (rst|except) begin
        new_c_mask=6'h3f;
        new_c_confl=6'h0;
    end else if (~aStall && ~aDoStall) begin
        if (new_en_reg) begin 
            new_c_mask=6'h3f;
            new_c_confl=6'h0;
        end else begin
            new_c_confl[0]=new_c_confl[0] || new_confl[0] & new_c_mask[0];
            new_c_confl[1]=new_c_confl[1] || new_confl[1] & new_c_mask[1];
            new_c_confl[2]=new_c_confl[2] || new_confl[2] & new_c_mask[2];
            new_c_confl[3]=new_c_confl[3] || new_confl[3] & new_c_mask[3];
            new_c_confl[4]=new_c_confl[4] || new_confl[4] & new_c_mask[4];
            new_c_confl[5]=new_c_confl[5] || new_confl[5] & new_c_mask[5];
            new_c_mask[0]=new_c_mask[0] && ~new_enA_reg[0];
            new_c_mask[1]=new_c_mask[1] && ~new_enA_reg[1];
            new_c_mask[2]=new_c_mask[2] && ~new_enA_reg[2];
            new_c_mask[3]=new_c_mask[3] && ~new_enA_reg[3];
            new_c_mask[4]=new_c_mask[4] && ~new_enA_reg[4];
            new_c_mask[5]=new_c_mask[5] && ~new_enA_reg[5];
        end
    end
    if (rst) lStFirst_pause<=1'b0;
    else if (~lDoStall) lStFirst_pause<=1'b0;
    else lStFirst_pause<=lStFirst_pause|~lStFirst;

    if (rst) begin
	new_en_mask0<=6'b0;
    end else begin
	if (new_en & ~aStall & ~aDoStall || except) new_en_mask0<=6'b0;
	else if (new_enP & ~aStall & ~aDoStall) new_en_mask0<=new_enA;
    end
    if (rst) begin
        for(b=0;b<6;b=b+1) begin
            new_dataA_chk[b]<={DATA_WIDTH{1'B0}};
            if (b<3) wrt_dataA_reg[b]<={DATA_WIDTH{1'B0}};
            if (b<3) wrt_indexA_reg[b]<=3'B0;
        end
        new_enA_reg<=6'b0;
        wrt_en_reg<=3'b0;
        wroet_en_reg<=3'b0;
        new_II_reg<=6'h3f;
        chmo_bolotnoe3<=1'b0;
    end else if (except&&excpt_thread==new_thr) begin
	wrt_en_reg<=3'b0;
        wroet_en_reg<=3'b0;
	new_enA_reg<=6'b0;
        new_II_reg<=6'h3f;
        chmo_bolotnoe3<=1'b0;
    end else if (new_enP & ~aStall & ~aDoStall) begin
        for(b=0;b<6;b=b+1) begin
            new_dataA_chk[b]<=new_dataA[b];
            if (~new_dataA[b][`lsaddr_split] & ~new_dataA[b][`lsaddr_odd])
                new_dataA_chk[b][`lsaddr_addrO]<=new_dataA_chk[b][`lsaddr_addrO];
            if (~new_dataA[b][`lsaddr_split] & new_dataA[b][`lsaddr_odd])
                new_dataA_chk[b][`lsaddr_addrE]<=new_dataA_chk[b][`lsaddr_addrE];
            if (b<3) wrt_dataA_reg[b]<=wrt_dataA[b];
            if (b<3) wrt_indexA_reg[b]<=wrt_indexA[b];
        end
        new_enA_reg<=new_enA;
        chmo_bolotnoe3<=1'b0;
//	if (ret_retire && ~bStall && ~rDoStall && new_data_shr[`lsqshare_II]==ret_data_shr[`lsqshare_II]) begin
  //          wrt_en_reg<=3'b0;
    //        wroet_en_reg<=3'b0;
      //      new_II_reg<=new_data_shr[`lsqshare_II];
//	end else begin
        wrt_en_reg<=wrt_en;
        wroet_en_reg<=wroet_en;
        //new_II_reg<=6'h3f;
  //      end
    end else if (~aStall && ~aDoStall) begin
        wrt_en_reg<=3'b0;
        wroet_en_reg<=3'b0;
      //  new_II_reg<=6'h3f;
	new_enA_reg<=6'b0;
        chmo_bolotnoe3<=1'b0;
    end else if (~lStall && ~lDoStall && confl_cnt[6:3]==0 && confl_waited) begin //copy of other if
        chmo_bolotnoe3<=1'b1;
        //final
    end

    if (rst) begin
        cur_pos<=3'b1;
    end else if (new_enP_reg & ~aStall & ~aDoStall &~except) begin
       //verilator lint_off CASEINCOMPLETE
        case(wrt_cnt)
      4'b10: cur_pos<={cur_pos[1:0],cur_pos[2]};
      4'b100: cur_pos<={cur_pos[0],cur_pos[2:1]};
        endcase
       //verilator lint_on CASEINCOMPLETE
    end 
    if (rst) begin
        cur_posh<=3'b1;
    end else if (new_en_reg & ~aStall & ~aDoStall &~except) begin
        case(wrt_cnt)
      4'b10: cur_posh<={cur_pos[1:0],cur_pos[2]};
      4'b100: cur_posh<={cur_pos[0],cur_pos[2:1]};
      default: cur_posh<=cur_pos;
        endcase
    end else if (except) begin
	cur_posh<=cur_pos;
    end 
    if (rst) begin
        new_confl_reg<=6'b0;
        on_M_reg<=3'b0;
        new_en_mask<=6'b0;
        for(b=0;b<6;b=b+1) begin
            new_conflict1_reg[b]<={3*BUF_COUNT{1'B0}};
            new_conflict2_reg[b]<={3*BUF_COUNT{1'B0}};
            if (b<3) free_maskM_reg[b]<={BUF_COUNT{1'B0}};
            if (b<3) free_maskN_reg[b]<={BUF_COUNT{1'B1}};
            //if (b<3) pos_indexA_reg[b]<=3'h0;
            //if (b<3) ins_addr_bit_reg[b]<={BUF_COUNT{1'B0}};
        end
        new_conflict1_acc<=96'b0;
        new_conflict2_acc<=96'b0;
        confl_waited<=1'b1;
        new_II_reg2<=6'h3f;
        chmo_bolotnoe2<=1'b0;
        for(b=0;b<6;b=b+1) begin
            new_dataA_chk_reg[b]<={DATA_WIDTH{1'B0}};
        end

    end else if ((except && excpt_thread==new_thr_reg)) begin
        for(b=0;b<6;b=b+1) begin
            new_conflict1_reg[b]<=96'b0;
            new_conflict2_reg[b]<=96'b0;
        end
        new_conflict1_acc<=96'b0;
        new_conflict2_acc<=96'b0;
	new_confl_reg<=6'b0;
	new_en_mask<=6'b0;
	confl_waited<=1'b1;
        new_II_reg2<=6'h3f;
        chmo_bolotnoe2<=1'b0;
    end else if ((~lStall && ~lDoStall)) begin
            if (confl_cnt[6:3]!=0) begin
                 if (confl_waited) begin
                     new_confl_reg<=new_confl_reg&~confl_first&~confl_last;
                     new_en_mask<=new_en_mask; 
	         end else  begin
                     new_confl_reg<=(new_confl_reg&~confl_first&~confl_last) | ((new_confl|new_confl_ex)&~new_en_mask);
                     new_en_mask<=new_enA_reg; 
                     for(b=0;b<6;b=b+1) begin
                         if (~new_en_mask[b] & new_enA_reg[b]) begin
                             new_dataA_chk_reg[b]<=new_dataA_chk[b];//move to other block??
                             new_conflict1_reg[b]<=new_conflict1[b]&~{nChNextB}&~new_conflict1_acc;
                             new_conflict2_reg[b]<=new_conflict2[b]&~{nChNextB}&~new_conflict1_acc;
                         end
                     end
	         end
                 confl_waited<=(new_en_reg && ~aStall && ~aDoStall)|confl_waited;
            
	    end else if (confl_waited) begin
                 new_confl_reg<=new_confl|new_confl_ex;
                 new_en_mask<=new_enA_reg;
                 confl_waited<=(new_en_reg && ~aStall && ~aDoStall);
                 new_conflict1_acc<=96'b0;
                 new_conflict2_acc<=96'b0;
                 for(b=0;b<6;b=b+1) begin
                     new_dataA_chk_reg[b]<=new_dataA_chk[b];//move to other block??
                     new_conflict1_reg[b]<=new_conflict1[b]&~{nChNextB}&~new_conflict1_acc;
                     new_conflict2_reg[b]<=new_conflict2[b]&~{nChNextB}&~new_conflict1_acc;
                 end
            end else if (new_enP_reg)  begin
                 new_confl_reg<=(new_confl_reg&~confl_first&~confl_last) | ((new_confl|new_confl_ex)&~new_en_mask);
                 new_en_mask<=new_enA_reg; 
                 confl_waited<=(new_en_reg && ~aStall && ~aDoStall);
                 for(b=0;b<6;b=b+1) begin
                         if (~new_en_mask[b] & new_enA_reg[b]) begin
                             new_dataA_chk_reg[b]<=new_dataA_chk[b];//move to other block??
                             new_conflict1_reg[b]<=new_conflict1[b]&~{nChNextB}&~new_conflict1_acc;
                             new_conflict2_reg[b]<=new_conflict2[b]&~{nChNextB}&~new_conflict1_acc;
                         end
                 end
            end else begin
                 new_confl_reg<=6'b0;
                 new_en_mask<=6'b0;
                 confl_waited<=(new_en_reg && ~aStall && ~aDoStall);
            end
            on_M_reg<=on_M;        
            if (new_en_reg && confl_cnt[6:3]==0) new_conflict1_acc<=96'b0;
	         else if (new_enP_reg) new_conflict1_acc<=new_conflict1_acc|nChNextB;
            if (new_en_reg && confl_cnt[6:3]==0) new_conflict2_acc<=96'b0;
	        else if (new_enP_reg) new_conflict2_acc<=new_conflict2_acc|{nChNextA[2],nChNextA[1],nChNextA[0]};//1 on p1
            for(b=0;b<6;b=b+1) begin
                if (b<3) free_maskM_reg[b]<=free_maskM[b];
                if (b<3) free_maskN_reg[b]<=free_maskN[b];
                //if (b<3) pos_indexA_reg[b]<=pos_indexA[b];
                //if (b<3) ins_addr_bit_reg[b]<=ins_addr_bit[b];
            end
            chmo_bolotnoe2<=chmo_bolotnoe3;
    end else begin
        new_conflict1_acc<=new_conflict1_acc|{nChNextB};
        new_conflict2_acc<=new_conflict2_acc|{nChNextA[2],nChNextA[1],nChNextA[0]};
        for(b=0;b<6;b=b+1) begin
            if (~new_en_mask[b] & new_enA_reg[b]) begin
                new_dataA_chk_reg[b]<=new_dataA_chk[b];//move to other block??
           end
        end
    end


    if (rst) free2_reg<=1'b1;
    else free2_reg<=free2[2][31];

    if (rst) begin
        ins_addr[0]<=5'd0;
        ins_addr[1]<=5'd0;
        ins_addr[2]<=5'd0;
        insh_addr[0]<=5'd0;
        insh_addr[1]<=5'd0;
        insh_addr[2]<=5'd0;
        free_maskM[0]=32'b0;
        free_maskM[1]=32'b0;
        free_maskM[2]=32'b0;
        free_maskN[0]=32'b0;
        free_maskN[1]=32'b0;
        free_maskN[2]=32'b0;
        free_maskXM[0]=32'b0;
        free_maskXM[1]=32'b0;
        free_maskXM[2]=32'b0;
        free_maskXN[0]=32'b0;
        free_maskXN[1]=32'b0;
        free_maskXN[2]=32'b0;
        on_M=3'b0;
        on_XM=3'b0;
    end else if (except && excpt_thread==new_thr_reg) begin
//        free_maskM[0]=32'b0;
//        free_maskM[1]=32'b0;
//        free_maskM[2]=32'b0;
//        free_maskN[0]=32'b0;
//        free_maskN[1]=32'b0;
//        free_maskN[2]=32'b0;
        free_maskXM[0]=32'b0;
        free_maskXM[1]=32'b0;
        free_maskXM[2]=32'b0;
        free_maskXN[0]=32'b0;
        free_maskXN[1]=32'b0;
        free_maskXN[2]=32'b0;
	insh_addr[0]<=ins_addr[0];
        insh_addr[1]<=ins_addr[1];
        insh_addr[2]<=ins_addr[2];
        //on_M=3'b0;
        on_XM=3'b0;
	if (&ins_addr[0] || &ins_addr[1] || & ins_addr[2]) begin
//	    if (~|ins_addr[0]) on_M[0]=1'b1;
//	    if (~|ins_addr[1]) on_M[1]=1'b1;
	    if (~|ins_addr[0]) on_XM[0]=1'b1;
	    if (~|ins_addr[1]) on_XM[1]=1'b1;
	end
        if (free2[2][31] &&~free2_reg&& on_M[0])// && !(pos_en[0] && ins_addr_cout[0])) 
            begin on_M[0]=1'b0; free_maskN[0]=free_maskM[0]; free_maskM[0]=32'b0; end
        else if (on_M[0]) begin free_maskN[0]=free_maskN[0]&~free2[0]; end
           
        if (free2[2][31] && ~free2_reg &&  on_M[1])// && ! (pos_en[1] && ins_addr_cout[1])) 
            begin on_M[1]=1'b0; free_maskN[1]=free_maskM[1]; free_maskM[1]=32'b0; end
        else if (on_M[1]) begin free_maskN[1]=free_maskN[1]&~free2[1]; end
        if (free2[2][31] && ~free2_reg && on_M[2])// && !(pos_en[2] && ins_addr_cout[2])) 
            begin on_M[2]=1'b0; free_maskN[2]=free_maskM[2]; free_maskM[2]=32'b0; end
        else if (on_M[2]) begin free_maskN[2]=free_maskN[2]&~free2[2]; end

    end else begin
        if (new_enP_reg & ~aStall & ~aDoStall & ~(except && excpt_thread==new_thr_reg) ) begin
            ins_addr[0]<=ins_addr_d[0];
            ins_addr[1]<=ins_addr_d[1];
            ins_addr[2]<=ins_addr_d[2];
	    if (new_en_reg) begin
		insh_addr[0]<=insh_addr_d[0];
                insh_addr[1]<=insh_addr_d[1];
                insh_addr[2]<=insh_addr_d[2];
	    end
            if (pos_en[0] && on_M[0]) free_maskM[0][ins_addr[0]]=1'b1;
            if (pos_en[1] && on_M[1]) free_maskM[1][ins_addr[1]]=1'b1;
            if (pos_en[2] && on_M[2]) free_maskM[2][ins_addr[2]]=1'b1;
            if (pos_en[0]) free_maskN[0][ins_addr[0]]=~on_M[0];
            if (pos_en[1]) free_maskN[1][ins_addr[1]]=~on_M[1];
            if (pos_en[2]) free_maskN[2][ins_addr[2]]=~on_M[2];
            if (free2[2][31] &&~free2_reg && on_M[0])// && !(pos_en[0] && ins_addr_cout[0])) 
                begin on_M[0]=1'b0; free_maskN[0]=free_maskM[0]; free_maskM[0]=32'b0; end
            else if (on_M[0]) begin free_maskN[0]=free_maskN[0]&~free2[0]; end
           
            if (free2[2][31] && ~free2_reg  &&  on_M[1])// && ! (pos_en[1] && ins_addr_cout[1])) 
                begin on_M[1]=1'b0; free_maskN[1]=free_maskM[1]; free_maskM[1]=32'b0; end
            else if (on_M[1]) begin free_maskN[1]=free_maskN[1]&~free2[1]; end
            if (free2[2][31] && ~free2_reg && on_M[2])// && !(pos_en[2] && ins_addr_cout[2])) 
                begin on_M[2]=1'b0; free_maskN[2]=free_maskM[2]; free_maskM[2]=32'b0; end
            else if (on_M[2]) begin free_maskN[2]=free_maskN[2]&~free2[2]; end
            if (pos_en[0] && ins_addr_cout[0]) on_M[0]=1'b1;
            if (pos_en[1] && ins_addr_cout[1]) on_M[1:0]=2'b11;
            if (pos_en[2] && ins_addr_cout[2]) on_M[2:0]=3'b111;


            if (pos_en[0] && on_XM[0]) free_maskXM[0][ins_addr[0]]=1'b1;
            if (pos_en[1] && on_XM[1]) free_maskXM[1][ins_addr[1]]=1'b1;
            if (pos_en[2] && on_XM[2]) free_maskXM[2][ins_addr[2]]=1'b1;
            if (pos_en[0]) free_maskXN[0][ins_addr[0]]=~on_XM[0];
            if (pos_en[1]) free_maskXN[1][ins_addr[1]]=~on_XM[1];
            if (pos_en[2]) free_maskXN[2][ins_addr[2]]=~on_XM[2];
            if (freeEn[2][31] && on_XM[0]) 
                begin on_XM[0]=1'b0; free_maskXN[0]=free_maskXM[0]; free_maskXM[0]=32'b0; end
            else 
                begin free_maskXN[0]=free_maskXN[0]&~freeEn[0];  free_maskXM[0]=free_maskXM[0]&~freeEn[0]; end
            if (freeEn[2][31] &&  on_XM[1]) 
                begin on_XM[1]=1'b0; free_maskXN[1]=free_maskXM[1]; free_maskXM[1]=32'b0; end
            else 
                begin free_maskXN[1]=free_maskXN[1]&~freeEn[1];  free_maskXM[1]=free_maskXM[1]&~freeEn[1]; end
            if (freeEn[2][31] && on_XM[2]) 
                begin on_XM[2]=1'b0; free_maskXN[2]=free_maskXM[2]; free_maskXM[2]=32'b0; end
            else 
                begin free_maskXN[2]=free_maskXN[2]&~freeEn[2];  free_maskXM[2]=free_maskXM[2]&~freeEn[2]; end
            if (pos_en[0] && ins_addr_cout[0]) on_XM[0]=1'b1;
            if (pos_en[1] && ins_addr_cout[1]) on_XM[1:0]=2'b11;
            if (pos_en[2] && ins_addr_cout[2]) on_XM[2:0]=3'b111;
        end else begin

            if (free2[2][31] &&~free2_reg && on_M[0])// && !(pos_en[0] && ins_addr_cout[0])) 
                begin on_M[0]=1'b0; free_maskN[0]=free_maskM[0]; free_maskM[0]=32'b0; end
            else if (on_M[0]) begin free_maskN[0]=free_maskN[0]&~free2[0]; end
           
            if (free2[2][31] && ~free2_reg &&  on_M[1])// && ! (pos_en[1] && ins_addr_cout[1])) 
                begin on_M[1]=1'b0; free_maskN[1]=free_maskM[1]; free_maskM[1]=32'b0; end
            else if (on_M[1]) begin free_maskN[1]=free_maskN[1]&~free2[1]; end
            if (free2[2][31] && ~free2_reg && on_M[2])// && !(pos_en[2] && ins_addr_cout[2])) 
                begin on_M[2]=1'b0; free_maskN[2]=free_maskM[2]; free_maskM[2]=32'b0; end
            else if (on_M[2]) begin free_maskN[2]=free_maskN[2]&~free2[2]; end


            if (freeEn[2][31] && on_XM[0]) 
                begin on_XM[0]=1'b0; free_maskXN[0]=free_maskXM[0]; free_maskXM[0]=32'b0; end
            else 
                begin free_maskXN[0]=free_maskXN[0]&~freeEn[0];  free_maskXM[0]=free_maskXM[0]&~freeEn[0]; end
            if (freeEn[2][31] &&  on_XM[1]) 
                begin on_XM[1]=1'b0; free_maskXN[1]=free_maskXM[1]; free_maskXM[1]=32'b0; end
            else 
                begin free_maskXN[1]=free_maskXN[1]&~freeEn[1];  free_maskXM[1]=free_maskXM[1]&~freeEn[1]; end
            if (freeEn[2][31] && on_XM[2]) 
                begin on_XM[2]=1'b0; free_maskXN[2]=free_maskXM[2]; free_maskXM[2]=32'b0; end
            else 
                begin free_maskXN[2]=free_maskXN[2]&~freeEn[2];  free_maskXM[2]=free_maskXM[2]&~freeEn[2]; end
        end
    end 
    
 /*   if (rst) begin
       lstep2A_validA_reg<=1'b0;
       lstep2A_validB_reg<=1'b0;
    end else begin
       lstep2A_validA_reg<=lstep2A_validA;
       lstep2A_validB_reg<=lstep2A_validB;
    end*/

   //new except code up to here.
    if (rst) begin
	ret_wait<=10'b0;
    end else if (ret_retire&~bStall&~rDoStall||except) begin
	ret_wait<=10'b0;
    end else if (ret_has_ldst&~bStall) begin
	ret_wait<=ret_wait|~ret_mask;
	if (retcnt_more[3]) ret_wait[ret_data_shr[`lsqshare_wrtII2]]<=1'b0;
//[	for(b=0;b<10;b=b+1) begin
//	    ret_wait[b]<=ret_wait[b]|!(ret_data_shr[`lsqshare_wrtII0]==b[3:0] ||
//	        ret_data_shr[`lsqshare_wrtII1]==b[3:0] || 
//		ret_data_shr[`lsqshare_wrtII2]==b[3:0]);
//	end
    end
    if (rst) begin
        wret_II0_reg<=10'b0;
        wret_en0_reg<=1'b0;
        wret_II1_reg<=10'b0;
        wret_en1_reg<=1'b0;
        new_en_reg<=1'b0;
        new_en_reg2<=1'b0;
        new_en_reg3<=1'b0;
        new_enP_reg<=1'b0;
        new_enP_reg2<=1'b0;
        new_enP_reg3<=1'b0;
        new_thr_reg<=1'b0;
        new_thr_reg2<=1'b0;
    end else begin
        wret_II0_reg<=wret_II0;
        wret_en0_reg<=wret_en0;
        wret_II1_reg<=wret_II1;
        wret_en1_reg<=wret_en1;
	if (except && excpt_thread==new_thr) begin
	    new_en_reg<=1'b0;
	    new_enP_reg<=1'b0;
        end else begin
            //if (~aStall & ~aDoStall || ~new_en_reg & new_enP_reg) new_en_reg<=new_en;
            if (~aStall & ~aDoStall) new_en_reg<=new_en;
            if (~aStall & ~aDoStall)  new_enP_reg<=new_enP;
        end
	if (except && excpt_thread==new_thr_reg) begin
	    new_en_reg2<=1'b0;
	    new_enP_reg2<=1'b0;
	end else begin
            if (~aStall & ~aDoStall) new_en_reg2<=new_en_reg && confl_cnt[6:3]!=0;
            if (~lStall & ~lDoStall) new_enP_reg2<=new_enP_reg;
	end
	if (except && excpt_thread==new_thr_reg) begin
	    new_en_reg3<=1'b0;
	    new_enP_reg3<=1'b0;
	end else begin
            if (~lStall & ~lDoStall) new_en_reg3<=new_en_reg2;
            if (~lStall & ~lDoStall) new_enP_reg3<=new_enP_reg2;
	end
        if (~aStall & ~aDoStall) new_thr_reg<=new_thr;
	if (~lStall & ~lDoStall) new_thr_reg2<=new_thr_reg;
	if (~lStall & ~lDoStall) new_thr_reg3<=new_thr_reg2;
    end
    //if (rst) lDoStall_reg<=1'b0;
    //else if (~aStall&~aDoStall&~lStall || lDoStall) lDoStall_reg<=lDoStall;
  end
endmodule

