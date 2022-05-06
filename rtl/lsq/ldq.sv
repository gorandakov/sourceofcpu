`include "../struct.sv"


module ldq_chk_confl(
  isOH0,isEH0,isOL0,isEL0,
  isOH1,isEH1,isOL1,isEL1,
  chkMatchE,chkMatchO,
  chkBankL,chkBankH,
  isBlow,chkBlow,
  confl
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

  input chkBankL;
  input chkBankH;

  input [3:0] isBlow;
  input [3:0] chkBlow;

  output confl;

  wire blowc;

  assign blowc=(chkBlow&isBlow)!=4'b0;
  
  assign confl=(isOH0 & isOH1 & chkMatchO & chkBankH ||
    isOL0 & isOL1 & chkMatchO & chkBankL ||
    isEH0 & isEH1 & chkMatchE & chkBankH ||
    isEL0 & isEL1 & chkMatchE & chkBankL)&blowc;    
  
endmodule


module ldq_buf(
  clk,
  rst,
  except,
  except_thread,
  aStall,
  newAddrE0,newAddrO0,newBanks0,newBlow0,newII0,newIsOH0,newIsEH0,newIsOL0,newIsEL0,newEn0,newThr0,newChk0,
  newAddrE1,newAddrO1,newBanks1,newBlow1,newII1,newIsOH1,newIsEH1,newIsOL1,newIsEL1,newEn1,newThr1,newChk1,
  chkAddrE0,chkAddrO0,chkBanks0,chkBlow0, chkIsOH0,chkIsEH0,chkIsOL0,chkIsEL0,chkEn0,chkMask0,
  chkAddrE1,chkAddrO1,chkBanks1,chkBlow1, chkIsOH1,chkIsEH1,chkIsOL1,chkIsEL1,chkEn1,chkMask1,
  chkAddrE3,chkAddrO3,chkIsOH3,chkIsEH3,chkIsOL3,chkIsEL3,chkEn3,
  freeII0,freeMask0,freeEnX0,freeEn0,freeConfl0,freeConflSmp0,
  freeII1,freeMask1,freeEnX1,freeEn1,freeConfl1,freeConflSmp1,
  free
  );
  localparam PADDR_WIDTH=44;
  localparam BANK_COUNT=32;
  localparam II_WIDTH=10;
  localparam ADDR_WIDTH=4;
  
  input clk;
  input rst;

  input except;
  input except_thread;
  input aStall;

  input [PADDR_WIDTH-9:0] newAddrE0;
  input [PADDR_WIDTH-9:0] newAddrO0;
  input [31:0] newBanks0;
  input [3:0] newBlow0;
  input [II_WIDTH-1:0] newII0;
  input newIsOH0,newIsEH0,newIsOL0,newIsEL0;
  input newEn0;
  input newThr0;
  input newChk0;
  input [PADDR_WIDTH-9:0] newAddrE1;
  input [PADDR_WIDTH-9:0] newAddrO1;
  input [31:0] newBanks1;
  input [3:0]  newBlow1;
  input [II_WIDTH-1:0] newII1;
  input newIsOH1,newIsEH1,newIsOL1,newIsEL1;
  input newEn1;
  input newThr1;
  input newChk1;
  input [PADDR_WIDTH-9:0] chkAddrE0;
  input [PADDR_WIDTH-9:0] chkAddrO0;
  input [31:0] chkBanks0;
  input [3:0] chkBlow0;
  input chkIsOH0,chkIsEH0,chkIsOL0,chkIsEL0;
  input chkEn0;
  input [5:0] chkMask0;
  input [PADDR_WIDTH-9:0] chkAddrE1;
  input [PADDR_WIDTH-9:0] chkAddrO1;
  input [31:0] chkBanks1;
  input [3:0] chkBlow1;
  input chkIsOH1,chkIsEH1,chkIsOL1,chkIsEL1;
  input chkEn1;
  input [5:0] chkMask1;
  input [PADDR_WIDTH-9:0] chkAddrE3;
  input [PADDR_WIDTH-9:0] chkAddrO3;
  input chkIsOH3,chkIsEH3,chkIsOL3,chkIsEL3;
  input chkEn3;

  input [II_WIDTH-1:0] freeII0;
  input [5:0] freeMask0;
  input freeEnX0;
  input freeEn0;
  output freeConfl0;
  output freeConflSmp0;
  input [II_WIDTH-1:0] freeII1;
  input [5:0] freeMask1;
  input freeEnX1;
  input freeEn1;
  output freeConfl1;
  output freeConflSmp1;
  
  output reg free;

  reg [PADDR_WIDTH-9:0] addrE;
  reg [PADDR_WIDTH-9:0] addrO;
  reg [31:0] banks;
  reg [3:0] bank_low;
  reg [II_WIDTH-1:0] II;
  reg isOH,isEH,isOL,isEL;
//  reg sFetch;
  reg thread;
  reg confl;
  reg confl_smp;
  
  wire [2:0] chkBankL;
  wire [2:0] chkBankH;
  wire [2:0] chkMatchE;
  wire [2:0] chkMatchO;

  wire chkMatch3;

  wire [2:0]   chkIsOH={chkIsOH3,chkIsOH1,chkIsOH0};
  wire [2:0]   chkIsOL={chkIsOL3,chkIsOL1,chkIsOL0};
  wire [2:0]   chkIsEH={chkIsEH3,chkIsEH1,chkIsEH0};
  wire [2:0]   chkIsEL={chkIsEL3,chkIsEL1,chkIsEL0};
  
  wire [2:0] chkMatch;
  
  wire [3:0] chkBlow[2:0];
  
  wire chkMatch0,chkMatch1;
 
  assign chkBankL[0]= (banks[15:0]&chkBanks0[15:0])!=0;
  assign chkBankH[0]= (banks[31:16]&chkBanks0[31:16])!=0;
  assign chkMatchE[0]=chkAddrE0==addrE;   
  assign chkMatchO[0]=chkAddrO0==addrO;   

  assign chkBankL[1]= (banks[15:0]&chkBanks1[15:0])!=0;
  assign chkBankH[1]=(banks[31:16]&chkBanks1[31:16])!= 0;
  assign chkMatchE[1]=chkAddrE1==addrE;   
  assign chkMatchO[1]=chkAddrO1==addrO;   

  assign chkBankL[2]=|banks[15:0];
  assign chkBankH[2]=|banks[31:16];
  assign chkMatchE[2]=chkAddrE3==addrE;   
  assign chkMatchO[2]=chkAddrO3==addrO;  

  assign chkBlow[0]=chkBlow0; 
  assign chkBlow[1]=chkBlow1; 
  assign chkBlow[2]=4'hf; 
  
  assign chkMatch0=chkMatch[0]&~free&chkEn0;
  assign chkMatch1=chkMatch[1]&~free&chkEn1;
//  assign chkMatch2=chkMatch[2]&~free&chkEn2;
  assign chkMatch3=chkMatch[2]&~free&chkEn3;

  assign freeConfl0=(((freeII0==II && confl!=0)  && freeII0[9:4]==II[9:4]) && ~free) &freeEn0;
  assign freeConfl1=(((freeII1==II && confl!=0)  && freeII1[9:4]==II[9:4]) && ~free) &freeEn1;

  assign freeConflSmp0=(freeII0==II && confl_smp) & freeEn0;
  assign freeConflSmp1=(freeII1==II && confl_smp) & freeEn1;
  generate
      genvar k;
      for(k=0;k<3;k=k+1) begin : chk_gen
          ldq_chk_confl chk_mod(
          isOH,isEH,isOL,isEL,
          chkIsOH[k],chkIsEH[k],chkIsOL[k],chkIsEL[k],
          chkMatchE[k],chkMatchO[k],
          chkBankL[k],chkBankH[k],
          bank_low,chkBlow[k],
          chkMatch[k]
          );
      end
  endgenerate
  

  always @(posedge clk) begin
      if (rst) begin
          addrE<=36'b0;
          addrO<=36'b0;
          banks<=32'b0;
          II<={II_WIDTH{1'b0}};
          free<=1'b1;
          isOH<=1'b0;
          isOL<=1'b0;
          isEH<=1'b0;
          isEL<=1'b0;
          thread<=1'b0;
          //sFetch<=1'b0;
          confl<=1'b0;
          confl_smp<=1'b0;
          bank_low<=4'b0;
      end else if (except && (except_thread ~^ thread)) begin
          free<=1'b1;
      end else if (newEn0) begin
          addrE<=newAddrE0;
          addrO<=newAddrO0;
          banks<=newBanks0;
          II<=newII0;
          free<=1'b0;
          isOH<=newIsOH0;
          isEH<=newIsEH0;
          isOL<=newIsOL0;
          isEL<=newIsEL0;
         // sFetch<=newSFetch0;
          thread<=newThr0;
          confl<=newChk0;
          confl_smp<=1'b0;
          bank_low<=newBlow0;
      end else if (newEn1) begin
          addrE<=newAddrE1;
          addrO<=newAddrO1;
          banks<=newBanks1;
          II<=newII1;
          free<=1'b0;
          isOH<=newIsOH1;
          isEH<=newIsEH1;
          isOL<=newIsOL1;
          isEL<=newIsEL1;
         // sFetch<=newSFetch1;
          thread<=newThr1;
          confl<=newChk1;
          confl_smp<=1'b0;
          bank_low<=newBlow1;
      end else begin
          if (freeEnX0 && freeII0==II && ~aStall) free<=1'b1;
          if (freeEnX1 && freeII1==II && ~aStall) free<=1'b1;
          confl<=confl || chkMatch0 || chkMatch1 || chkMatch3;
          confl_smp<=confl_smp | chkMatch3;
      end
  end
endmodule


module ldq_up_down0(
  cnt,
  cnt_d,
  cnt_extra,en_xtra,en_z,
  newEn0,newEn1,newMatch,
  freeEn0,freeEn1,freeMatch
  );
  input [5:0] cnt;
  output [5:0] cnt_d;
  input [5:0] cnt_extra;
  input en_xtra,en_z;
  input newEn0;
  input newEn1;
  input newMatch;
  input freeEn0;
  input freeEn1;
  input freeMatch;

  wire [2:0] inc;
  wire [2:0] dec;
  wire [2:-2] cpop;
  wire [6:0] par0[2:0];
  wire [6:0] par1[2:0];
  assign inc[0]=~newEn0 & ~newEn1 || en_xtra || ~newMatch;
  assign inc[1]=newEn0 ^ newEn1 && ~en_xtra && newMatch;
  assign inc[2]=newEn0 & newEn1 && ~en_xtra && newMatch;
  assign dec[0]=~freeEn0 & ~freeEn1 || en_xtra || ~freeMatch;
  assign dec[1]=freeEn0 ^ freeEn1 && ~en_xtra && freeMatch;
  assign dec[2]=freeEn0 & freeEn1 && ~en_xtra && freeMatch;

  assign cpop=dec[0] ? {inc,2'b0} : 5'bz;
  assign cpop=dec[1] ? {1'b0,inc,1'b0} : 5'bz;
  assign cpop=dec[2] ? {2'b0,inc} : 5'bz;

  generate

    genvar t,p;
    for(t=-2;t<=2;t=t+1) begin : incdec_gen
        adder #(6) add_mod(cnt,t[5:0],cnt_d,1'b0,cpop[t] && ~en_xtra,,,,);
    end

    for(p=0;p<=2;p=p+1) begin : xtra_gen
        adder_CSA #(6) csa_mod(cnt,-p[5:0],~cnt_extra,par0[p],par1[p]);
	adder #(6) xtraadd_mod(par0[p][5:0],par1[p][5:0],cnt_d,1'b1,dec[p]&&en_xtra&&~en_z,,,,);
    end

  endgenerate
  
  assign cnt_d=(en_xtra & en_z) ? 6'd0 : 6'bz;

endmodule

module ldq_up_down1(
  cnt,
  cnt_d,
  cnt_extra0,en_xtra0,
  cnt_extra1,en_xtra1,
  newEn0,newEn1,newMatch,
  freeEn0,freeEn1,freeMatch
  );
  input [5:0] cnt;
  output [5:0] cnt_d;
  input [5:0] cnt_extra0;
  input en_xtra0;
  input [5:0] cnt_extra1;
  input en_xtra1;
  input newEn0;
  input newEn1;
  input newMatch;
  input freeEn0;
  input freeEn1;
  input freeMatch;

  wire [2:0] inc;
  wire [2:0] dec;
  wire [2:-2] cpop;
  wire [6:0] par0a[2:-2];
  wire [6:0] par1a[2:-2];
  wire [6:0] par0b[2:-2];
  wire [6:0] par1b[2:-2];
  wire [5:0] cnt_d1;
  wire [5:0] cnt_d2;
  wire [5:0] cnt_d3;

  assign inc[0]=~newEn0 & ~newEn1 || ~newMatch;
  assign inc[1]=newEn0 ^ newEn1 && newMatch;
  assign inc[2]=newEn0 & newEn1 && newMatch;
  assign dec[0]=~freeEn0 & ~freeEn1 || ~freeMatch;
  assign dec[1]=freeEn0 ^ freeEn1 && freeMatch;
  assign dec[2]=freeEn0 & freeEn1 && freeMatch;

  assign cpop=dec[0] ? {inc,2'b0} : 5'bz;
  assign cpop=dec[1] ? {1'b0,inc,1'b0} : 5'bz;
  assign cpop=dec[2] ? {2'b0,inc} : 5'bz;

  assign cnt_d=(~en_xtra0 & ~en_xtra1) ? cnt_d1 : 6'bz;
  assign cnt_d=en_xtra0 ? cnt_d2 : 6'bz;
  assign cnt_d=en_xtra1 ? cnt_d3 : 6'bz;

  generate

    genvar t,p;
    for(t=-2;t<=2;t=t+1) begin : incdec_gen
        adder #(6) add_mod(cnt,t[5:0],cnt_d1,1'b0,cpop[t],,,,);
    end

    for(p=-2;p<=2;p=p+1) begin : xtra_gen
        adder_CSA #(6) csa_mod(cnt,p[5:0],~cnt_extra0,par0a[p],par1a[p]);
	adder #(6) xtraadd_mod(par0a[p][5:0],par1a[p][5:0],cnt_d2,1'b1,cpop[p],,,,);
        adder_CSA #(6) csa1_mod(cnt,p[5:0],~cnt_extra1,par0b[p],par1b[p]);
	adder #(6) xtraadd1_mod(par0b[p][5:0],par1b[p][5:0],cnt_d3,1'b1,cpop[p],,,,);
    end

  endgenerate
  

endmodule

module ldq_up_down(
  clk,
  rst,
  except,
  except_thread,
  newEn0,newEn1,newThread,
  freeEn0,freeEn1,freeThread,
  stall,
  doStall
  );
  parameter STALL_CNT=39;
  localparam WIDTH=6;

  input clk;
  input rst;
  input except;
  input except_thread;
  input newEn0;
  input newEn1;
  input newThread;
  input freeEn0;
  input freeEn1;
  input freeThread;
  input stall;
  output doStall;

  wire [2:0][WIDTH-1:0] cnt_d;
  reg  [2:0][WIDTH-1:0] cnt;
  assign doStall=cnt[2]==STALL_CNT || cnt[2]==(STALL_CNT+1);
  
  ldq_up_down0 ud0_mod(
  .cnt(cnt[0]),
  .cnt_d(cnt_d[0]),
  .cnt_extra(cnt[1]),
  .en_xtra(except),.en_z(except && ~except_thread),
  .newEn0(newEn0),.newEn1(newEn1),.newMatch(~newThread && ~stall && ~doStall),
  .freeEn0(freeEn0),.freeEn1(freeEn1),.freeMatch(~freeThread)
  );

  ldq_up_down0 ud1_mod(
  .cnt(cnt[1]),
  .cnt_d(cnt_d[1]),
  .cnt_extra(cnt[0]),
  .en_xtra(except),.en_z(except && except_thread),
  .newEn0(newEn0),.newEn1(newEn1),.newMatch(newThread && ~stall && ~doStall),
  .freeEn0(freeEn0),.freeEn1(freeEn1),.freeMatch(freeThread)
  );

  ldq_up_down1 udcommon_mod(
  .cnt(cnt[2]),
  .cnt_d(cnt_d[2]),
  .cnt_extra0(cnt[0]),.en_xtra0(except & ~except_thread),
  .cnt_extra1(cnt[1]),.en_xtra1(except & except_thread),
  .newEn0(newEn0),.newEn1(newEn1),.newMatch((newThread ^ except_thread || ~except) & ~stall &~doStall),
  .freeEn0(freeEn0),.freeEn1(freeEn1),.freeMatch(except_thread ^ freeThread || ~except)
  );

  always @(posedge clk) begin
    if (rst) begin
        cnt[0]<=6'd0;
        cnt[1]<=6'd0;
        cnt[2]<=6'd0;
    end else begin
        cnt[0]<=cnt_d[0];
        cnt[1]<=cnt_d[1];
        cnt[2]<=cnt_d[2];
    end
  end

endmodule

module ldq_array(
  clk,
  rst,
  except,
  except_thread,
  aStall,
  newAddrE0,newAddrO0,newBanks0,newBlow0,newII0,newIsOH0,newIsEH0,newIsOL0,newIsEL0,newEn0,newThr0,
  newAddrE1,newAddrO1,newBanks1,newBlow1,newII1,newIsOH1,newIsEH1,newIsOL1,newIsEL1,newEn1,newThr1,
  chkAddrE0,chkAddrO0,chkBanks0,chkBlow0, chkIsOH0,chkIsEH0,chkIsOL0,chkIsEL0,chkEn0,chkMask0,
  chkAddrE1,chkAddrO1,chkBanks1,chkBlow1, chkIsOH1,chkIsEH1,chkIsOL1,chkIsEL1,chkEn1,chkMask1,
  chkAddrE3,chkAddrO3, chkIsOH3,chkIsEH3,chkIsOL3,chkIsEL3,chkEn3,
  freeII0,freeMask0,freeEnX0,freeEn0,freeConfl0,freeConflSmp0,
  freeII1,freeMask1,freeEnX1,freeEn1,freeConfl1,freeConflSmp1,
  free
  );
 
  localparam PADDR_WIDTH=44;
  localparam BANK_COUNT=32;
  localparam II_WIDTH=10;
  localparam ADDR_WIDTH=4;
  localparam BUF_COUNT=40;
//  localparam STALL_CNT=19;
  
  input clk;
  input rst;

  input except;
  input except_thread;
  input aStall;

  input [PADDR_WIDTH-9:0] newAddrE0;
  input [PADDR_WIDTH-9:0] newAddrO0;
  input [31:0] newBanks0;
  input [3:0] newBlow0;
//  input newSFetch0;
  input [II_WIDTH-1:0] newII0;
  input newIsOH0,newIsEH0,newIsOL0,newIsEL0;
  input newEn0;
  input newThr0;
  input [PADDR_WIDTH-9:0] newAddrE1;
  input [PADDR_WIDTH-9:0] newAddrO1;
  input [31:0] newBanks1;
  input [3:0] newBlow1;
  //input newSFetch1;
  input [II_WIDTH-1:0] newII1;
  input newIsOH1,newIsEH1,newIsOL1,newIsEL1;
  input newEn1;
  input newThr1;
  input [PADDR_WIDTH-9:0] chkAddrE0;
  input [PADDR_WIDTH-9:0] chkAddrO0;
  input [31:0] chkBanks0;
  input [3:0] chkBlow0;
  input chkIsOH0,chkIsEH0,chkIsOL0,chkIsEL0;
  input chkEn0;
  input [5:0] chkMask0;
  input [PADDR_WIDTH-9:0] chkAddrE1;
  input [PADDR_WIDTH-9:0] chkAddrO1;
  input [31:0] chkBanks1;
  input [3:0] chkBlow1;
  input chkIsOH1,chkIsEH1,chkIsOL1,chkIsEL1;
  input chkEn1;
  input [5:0] chkMask1;
  input [PADDR_WIDTH-9:0] chkAddrE3;
  input [PADDR_WIDTH-9:0] chkAddrO3;
  input chkIsOH3,chkIsEH3,chkIsOL3,chkIsEL3;
  input chkEn3;
  
  input [II_WIDTH-1:0] freeII0;
  input [5:0] freeMask0;
  input freeEn0;
  input freeEnX0;
  output freeConfl0;
  output freeConflSmp0;
  input [II_WIDTH-1:0] freeII1;
  input [5:0] freeMask1;
  input freeEn1;
  input freeEnX1;
  output freeConfl1;
  output freeConflSmp1;

  output [BUF_COUNT-1:0] free;

  wire [BUF_COUNT-1:0] newEn0_buf;
  wire [BUF_COUNT-1:0] newEn1_buf;
  wire [BUF_COUNT-1:0] first;
  wire [BUF_COUNT-1:0] last;
  wire [BUF_COUNT-1:0] freeConfl0_buf;
  wire [BUF_COUNT-1:0] freeConfl1_buf;
  wire [BUF_COUNT-1:0] freeConflSmp0_buf;
  wire [BUF_COUNT-1:0] freeConflSmp1_buf;

  wire [2:0] chk0BankL;
  wire [2:0] chk0BankH;
  wire [2:0] chk0MatchE;
  wire [2:0] chk0MatchO;

  wire chkMatch0;
 
  wire [2:0] chk1BankL;
  wire [2:0] chk1BankH;
  wire [2:0] chk1MatchE;
  wire [2:0] chk1MatchO;

  wire chkMatch1;

  wire [2:0]   chkIsOH={chkIsOH3,chkIsOH1,chkIsOH0};
  wire [2:0]   chkIsOL={chkIsOL3,chkIsOL1,chkIsOL0};
  wire [2:0]   chkIsEH={chkIsEH3,chkIsEH1,chkIsEH0};
  wire [2:0]   chkIsEL={chkIsEL3,chkIsEL1,chkIsEL0};
  
  wire [2:0] chk1Match;
  wire [2:0] chk0Match;
  
  wire [3:0] chkBlow[2:0];

  assign chk0BankL[0]= (newBanks0[15:0]&chkBanks0[15:0])!=0;
  assign chk0BankH[0]= (newBanks0[31:16]&chkBanks0[31:16])!=0;
  assign chk0MatchE[0]=chkAddrE0==newAddrE0;   
  assign chk0MatchO[0]=chkAddrO0==newAddrO0;   

  assign chk0BankL[1]= (newBanks0[15:0]&chkBanks1[15:0])!=0;
  assign chk0BankH[1]=(newBanks0[31:16]&chkBanks1[31:16])!= 0;
  assign chk0MatchE[1]=chkAddrE1==newAddrE0;   
  assign chk0MatchO[1]=chkAddrO1==newAddrO0;   

  assign chk0BankL[2]=|newBanks0[15:0];
  assign chk0BankH[2]=|newBanks0[31:16];
  assign chk0MatchE[2]=chkAddrE3==newAddrE0;   
  assign chk0MatchO[2]=chkAddrO3==newAddrO0;  

  assign chkBlow[0]=chkBlow0; 
  assign chkBlow[1]=chkBlow1; 
  assign chkBlow[2]=4'hf; 
  
  assign chkMatch0=
    chk0Match[0]&chkEn0 ||
    chk0Match[1]&chkEn1 ||
    chk0Match[2]&chkEn3;

  assign chk1BankL[0]= (newBanks1[15:0]&chkBanks0[15:0])!=0;
  assign chk1BankH[0]= (newBanks1[31:16]&chkBanks0[31:16])!=0;
  assign chk1MatchE[0]=chkAddrE0==newAddrE1;   
  assign chk1MatchO[0]=chkAddrO0==newAddrO1;   

  assign chk1BankL[1]= (newBanks1[15:0]&chkBanks1[15:0])!=0;
  assign chk1BankH[1]=(newBanks1[31:16]&chkBanks1[31:16])!= 0;
  assign chk1MatchE[1]=chkAddrE1==newAddrE1;   
  assign chk1MatchO[1]=chkAddrO1==newAddrO1;   

  assign chk1BankL[2]=|newBanks1[15:0];
  assign chk1BankH[2]=|newBanks1[31:16];
  assign chk1MatchE[2]=chkAddrE3==newAddrE1;   
  assign chk1MatchO[2]=chkAddrO3==newAddrO1;  

  assign chkMatch1=
    chk1Match[0]&chkEn0 ||
    chk1Match[1]&chkEn1 ||
    chk1Match[2]&chkEn3;


  generate
      genvar k;
      for(k=0;k<3;k=k+1) begin : chk_gen
          ldq_chk_confl chk0_mod(
          newIsOH0,newIsEH0,newIsOL0,newIsEL0,
          chkIsOH[k],chkIsEH[k],chkIsOL[k],chkIsEL[k],
          chk0MatchE[k],chk0MatchO[k],
          chk0BankL[k],chk0BankH[k],
          newBlow0,chkBlow[k],
          chk0Match[k]
          );
          ldq_chk_confl chk1_mod(
          newIsOH1,newIsEH1,newIsOL1,newIsEL1,
          chkIsOH[k],chkIsEH[k],chkIsOL[k],chkIsEL[k],
          chk1MatchE[k],chk1MatchO[k],
          chk1BankL[k],chk1BankH[k],
          newBlow1,chkBlow[k],
          chk1Match[k]
          );
      end
      genvar p;
      for(p=0;p<BUF_COUNT;p=p+1) begin : buf_gen
          ldq_buf buf_mod(
          clk,
          rst,
          except,
          except_thread,aStall,
          newAddrE0,newAddrO0,newBanks0,newBlow0,newII0,newIsOH0,newIsEH0,newIsOL0,newIsEL0,newEn0_buf[p],newThr0,chkMatch0,
          newAddrE1,newAddrO1,newBanks1,newBlow1,newII1,newIsOH1,newIsEH1,newIsOL1,newIsEL1,newEn1_buf[p],newThr1,chkMatch1,
          chkAddrE0,chkAddrO0,chkBanks0,chkBlow0, chkIsOH0,chkIsEH0,chkIsOL0,chkIsEL0,chkEn0,chkMask0,
          chkAddrE1,chkAddrO1,chkBanks1,chkBlow1, chkIsOH1,chkIsEH1,chkIsOL1,chkIsEL1,chkEn1,chkMask1,
          chkAddrE3,chkAddrO3, chkIsOH3,chkIsEH3,chkIsOL3,chkIsEL3,chkEn3,
          freeII0,freeMask0,freeEnX0,freeEn0,freeConfl0_buf[p],freeConflSmp0_buf[p],
          freeII1,freeMask1,freeEnX1,freeEn1,freeConfl1_buf[p],freeConflSmp1_buf[p],
          free[p]
          );
      end
  endgenerate
  
  bit_find_first_bit #(BUF_COUNT) first_mod(free,first,);
  bit_find_last_bit #(BUF_COUNT) last_mod(free,last,);

  assign newEn0_buf=first & {BUF_COUNT{newEn0}};
  assign newEn1_buf=last & {BUF_COUNT{newEn1}};

  assign freeConfl0=|freeConfl0_buf;
  assign freeConfl1=|freeConfl1_buf;
  assign freeConflSmp0=|freeConflSmp0_buf;
  assign freeConflSmp1=|freeConflSmp1_buf;

endmodule


module ldq(
  clk,
  rst,
  except,except_thread,
  stall,doStall,
  aStall,
  new0_data,new0_rsEn,new0_isFlag,new0_thread,
  new1_data,new1_rsEn,new1_isFlag,new1_thread,
  new2_data,new2_rsEn,new2_isFlag,new2_thread,
  new3_data,new3_rsEn,new3_isFlag,new3_thread,
  newI_mask,newI_en,newI_thr,
  chk0_dataA,chk0_enA,
  chk1_dataA,chk1_enA,
  chk2_dataA,chk2_enA,
  chk3_dataA,chk3_enA,
  chk4_dataA,chk4_enA,
  chk5_dataA,chk5_enA,
  chk_data_shr,
  chk_en,chk_enP,
  confl,confl_smp,conflX,
  expun_addr,expun_en
  );

  localparam DATA_WIDTH=`lsaddr_width;
  localparam SHRDATA_WIDTH=`lsqshare_width;
  localparam II_WIDTH=10;
  localparam PADDR_WIDTH=44;
  localparam SPADDR_WIDTH=44-20;
  localparam BUF_COUNT=40;

  input clk;
  input rst;
  input except;
  input except_thread;
  input stall;
  output doStall;
  input aStall;
  input [DATA_WIDTH-1:0] new0_data;
  input new0_rsEn;
  input new0_isFlag;
  input new0_thread;
  input [DATA_WIDTH-1:0] new1_data;
  input new1_rsEn;
  input new1_isFlag;
  input new1_thread;
  input [DATA_WIDTH-1:0] new2_data;
  input new2_rsEn;
  input new2_isFlag;
  input new2_thread;
  input [DATA_WIDTH-1:0] new3_data;
  input new3_rsEn;
  input new3_isFlag;
  input new3_thread;
  input [5:0] newI_mask;
  input newI_en;
  input newI_thr;
  input [DATA_WIDTH-1:0] chk0_dataA;
  input chk0_enA;
  input [DATA_WIDTH-1:0] chk1_dataA;
  input chk1_enA;
  input [DATA_WIDTH-1:0] chk2_dataA;
  input chk2_enA;
  input [DATA_WIDTH-1:0] chk3_dataA;
  input chk3_enA;
  input [DATA_WIDTH-1:0] chk4_dataA;
  input chk4_enA;
  input [DATA_WIDTH-1:0] chk5_dataA;
  input chk5_enA;
  input [SHRDATA_WIDTH-1:0] chk_data_shr;
  input chk_en,chk_enP;
  output [5:0] confl;
  output [5:0] confl_smp;
  output [5:0] conflX;
  input [PADDR_WIDTH-8:0] expun_addr;
  input expun_en;

  wire [2:0] doStall_rs;
  wire [DATA_WIDTH-1:0] chkL0_data;
  wire [DATA_WIDTH-1:0] chkL1_data;
  wire [DATA_WIDTH-1:0] chkL2_data;
  wire [5:0] chkL0_mask;
  wire [5:0] chkL1_mask;
  wire [5:0] chkL2_mask;
  wire [5:0][5:0] chk_mask;
  wire [5:0][II_WIDTH-1:0] chk_II;
  reg [5:0][II_WIDTH-1:0] II_save;
  wire [2:0][5:0] chkbits;
  wire [2:0][10:1] cnt_chk;
  
  integer u;
  wire [5:0][DATA_WIDTH-1:0] chk_dataA;
  wire [3:0][DATA_WIDTH-1:0] new_data;
  wire [3:0] new_rsEn;
  wire [3:0] new_thread;
  wire [3:0] new_isFlag;
  wire [5:0] conflP;
  wire [5:0] confl_smpP;
  wire [5:0] confl_X;
  
//  wire [2:0] chkMatch;
  reg [PADDR_WIDTH-8:0] expun_addr_reg;
  reg expun_en_reg;

  wire [BUF_COUNT-1:0] expun_match[2:0];//unused

  wire [3:0] new3_reg_low;

  reg chkEn0,chkEn1,chkEn2;
  reg init;
  reg [7:0] initcount;
  wire [7:0] initcount_new;
  wire [5:0] chk_enA={chk5_enA,chk4_enA,chk3_enA,chk2_enA,chk1_enA,chk0_enA};
  reg [5:0] chk_enA_reg;
  wire chkL0_en,chkL1_en,chkL2_en;
  
  generate
    genvar k,p,l;
    for(k=0;k<3;k=k+1) begin : ldq_gen
        ldq_array ldq_mod(
        .clk(clk),
        .rst(rst),
	.except(except),.except_thread(except_thread),.aStall(~chk_en | aStall),
        .newAddrE0(new_data[k][`lsaddr_addrE]),.newAddrO0(new_data[k][`lsaddr_addrO]),
          .newBanks0(new_data[k][`lsaddr_banks]),.newBlow0(new_data[k][`lsaddr_blow]),
          .newII0(new_data[k][`lsaddr_II]),
          .newIsOH0(new_data[k][`lsaddr_OH]),.newIsEH0(new_data[k][`lsaddr_EH]),
          .newIsOL0(new_data[k][`lsaddr_OL]),.newIsEL0(new_data[k][`lsaddr_EL]),
          .newEn0(new_rsEn[k]&~(~new_data[k][`lsaddr_st] && new_isFlag[k])),.newThr0(new_thread[k]),
        .newAddrE1(new_data[3][`lsaddr_addrE]),.newAddrO1(new_data[3][`lsaddr_addrO]),
          .newBanks1(new_data[3][`lsaddr_banks]),.newBlow1(new_data[k][`lsaddr_blow]),
          .newII1(new_data[3][`lsaddr_II]),
          .newIsOH1(new_data[3][`lsaddr_OH]),.newIsEH1(new_data[3][`lsaddr_EH]),
          .newIsOL1(new_data[3][`lsaddr_OL]),.newIsEL1(new_data[3][`lsaddr_EL]),
	  .newEn1(new_rsEn[3]&&(new3_reg_low==k || new3_reg_low==(k+3) || new3_reg_low==(k+6))&
          ~(~new_data[3][`lsaddr_st] && new_isFlag[3])),.newThr1(new_thread[3]),
        .chkAddrE0(chkL0_data[`lsaddr_addrE]),.chkAddrO0(chkL0_data[`lsaddr_addrO]),
          .chkBanks0(chkL0_data[`lsaddr_banks]),.chkBlow0(chkL0_data[`lsaddr_blow]), .chkIsOH0(chkL0_data[`lsaddr_OH]),
          .chkIsEH0(chkL0_data[`lsaddr_EH]),.chkIsOL0(chkL0_data[`lsaddr_OL]),
          .chkIsEL0(chkL0_data[`lsaddr_EL]),.chkEn0(chkEn0),.chkMask0(chkL0_mask),
        .chkAddrE1(chkL1_data[`lsaddr_addrE]),.chkAddrO1(chkL1_data[`lsaddr_addrO]),
          .chkBanks1(chkL1_data[`lsaddr_banks]),.chkBlow1(chkL1_data[`lsaddr_blow]), .chkIsOH1(chkL1_data[`lsaddr_OH]),
          .chkIsEH1(chkL1_data[`lsaddr_EH]),.chkIsOL1(chkL1_data[`lsaddr_OL]),
          .chkIsEL1(chkL1_data[`lsaddr_EL]),.chkEn1(chkEn1),.chkMask1(chkL1_mask),
        .chkAddrE3(expun_addr_reg[44-8:1]),.chkAddrO3(expun_addr_reg[44-8:1]), 
	   .chkIsOH3(expun_addr_reg[0]),.chkIsEH3(~expun_addr_reg[0]),
	   .chkIsOL3(expun_addr_reg[0]),.chkIsEL3(~expun_addr_reg[0]),.chkEn3(expun_en_reg),
        .freeII0(chk_II[k]),.freeMask0(chk_mask[k]),.freeEnX0(cnt_chk[k][1] & chk_en & ~aStall),
	.freeEn0(cnt_chk[k][1] & chk_enP),.freeConfl0(conflP[k]),.freeConflSmp0(confl_smpP[k]),
        .freeII1(chk_II[k+3]),.freeMask1(chk_mask[k+3]),.freeEnX1(cnt_chk[k][2] & chk_en & ~aStall),
	.freeEn1(cnt_chk[k][2] & chk_enP),.freeConfl1(conflP[k+3]),.freeConflSmp1(confl_smpP[k+3]),
        .free()
        );
        popcnt10_or_more cpop_mod({4'b0,chkbits[k]},cnt_chk[k]);
        
        ldq_up_down stall_mod(
        .clk(clk),
        .rst(rst),
        .except(except),
        .except_thread(except_thread),
        .newEn0(newI_mask[k]&newI_en&~stall&~doStall),.newEn1(newI_mask[k+3]&newI_en&~stall&~doStall),
        .newThread(newI_thr),
        .freeEn0(cnt_chk[k][1] & chk_en & ~aStall),
        .freeEn1(cnt_chk[k][2] & chk_en & ~aStall),.freeThread(1'b0),
        .stall(stall),
        .doStall(doStall_rs[k])
        );
    end
    for(p=0;p<6;p=p+1) begin
        assign chkL0_data=(chk_data_shr[`lsqshare_wrt0]==p) ? chk_dataA[p] : {DATA_WIDTH{1'bz}}; 
        assign chkL1_data=(chk_data_shr[`lsqshare_wrt1]==p) ? chk_dataA[p] : {DATA_WIDTH{1'bz}}; 

        assign chkL0_en=(chk_data_shr[`lsqshare_wrt0]==p) ? chk_enA[p] : 1'bz; 
        assign chkL1_en=(chk_data_shr[`lsqshare_wrt1]==p) ? chk_enA[p] : 1'bz; 
        
        assign chkL0_mask=(chk_data_shr[`lsqshare_wrt0]==p) ? 6'b111110<<p : 6'bz; 
        assign chkL1_mask=(chk_data_shr[`lsqshare_wrt1]==p) ? 6'b111110<<p  : 6'bz; 

	assign confl_X[p]=chk_dataA[p][`lsaddr_mtype]==2'b10 && ~chk_dataA[p][`lsaddr_flag];
        
        for(l=0;l<3;l=l+1) begin
            assign chkbits[l][p]=(chk_dataA[p][`lsaddr_reg_low]==l[3:0] ||
              chk_dataA[p][`lsaddr_reg_low]==(4'd3+l[3:0]) || chk_dataA[p][`lsaddr_reg_low]==(4'd6+l[3:0])) &&
              chk_enA[p] && ~chk_dataA[p][`lsaddr_st];
 
            if (p!=0) assign chk_II[l]=(chkbits[l][p] && chkbits[l][p-1:0]==0) ? II_save[p] : 10'bz;
            else assign chk_II[l]=(chkbits[l][p]) ? II_save[p] : 10'bz;
            if (p!=0) assign chk_II[l+3]=(chkbits[l][p] && chkbits[l][p-1:0]!=0) ? II_save[p] : 10'bz;

            if (p!=0) assign chk_mask[l]=(chkbits[l][p] && chkbits[l][p-1:0]==0) ? 6'b1<<p : 6'bz;
            else assign chk_mask[l]=(chkbits[l][p]) ? 6'b1<<p : 6'bz;
            if (p!=0) assign chk_mask[l+3]=(chkbits[l][p] && chkbits[l][p-1:0]!=0) ? 6'b1<<p : 6'bz;

            if (p!=0) assign confl[p]=(chkbits[l][p] && chkbits[l][p-1:0]==0) ? conflP[l]|confl_X[p] : 1'bz;
            else assign confl[p]=(chkbits[l][p]) ? conflP[l]|confl_X[p] : 1'bz;
            if (p!=0) assign confl[p]=(chkbits[l][p] && chkbits[l][p-1:0]!=0) ? conflP[l+3]|confl_X[p] : 1'bz;
            
            if (p!=0) assign conflX[p]=(chkbits[l][p] && chkbits[l][p-1:0]==0) ? confl_X[p] : 1'bz;
            else assign conflX[p]=(chkbits[l][p]) ? confl_X[p] : 1'bz;
            if (p!=0) assign conflX[p]=(chkbits[l][p] && chkbits[l][p-1:0]!=0) ? confl_X[p] : 1'bz;
            
            if (p!=0) assign confl_smp[p]=(chkbits[l][p] && chkbits[l][p-1:0]==0) ? confl_smpP[l] : 1'bz;
            else assign confl_smp[p]=(chkbits[l][p]) ? confl_smpP[l] : 1'bz;
            if (p!=0) assign confl_smp[p]=(chkbits[l][p] && chkbits[l][p-1:0]!=0) ? confl_smpP[l+3] : 1'bz;
            
           /* if (p) assign chk_ret[l]=(chkbits_reg[l][p] && !chkbits_reg[l][p-1:0]) ? ret_mask[II_save[p][3:0]] : 10'bz;
            else assign chk_ret[l]=(chkbits_reg[l][p]) ? ret_mask[II_save[p][3:0]] : 10'bz;
            if (p) assign chk_ret[l+3]=(chkbits_reg[l][p] && chkbits_reg[l][p-1:0]) ? ret_mask[II_save[p][3:0]] : 10'bz;*/
        end
        assign confl[p]=(chkbits[0][p] || chkbits[1][p] || chkbits[2][p]) ? 1'bz : 1'b0; 
        assign conflX[p]=(chkbits[0][p] || chkbits[1][p] || chkbits[2][p]) ? 1'bz : 1'b0; 
        assign confl_smp[p]=(chkbits[0][p] || chkbits[1][p] || chkbits[2][p]) ? 1'bz : 1'b0; 
    end
  endgenerate
  
  assign chk_II[0]=chkbits[0]!=0 ? 10'bz : 10'hf;
  assign chk_II[1]=chkbits[1]!=0 ? 10'bz : 10'hf;
  assign chk_II[2]=chkbits[2]!=0 ? 10'bz : 10'hf;
  assign chk_II[3]=cnt_chk[0][2] ? 10'bz : 10'hf;
  assign chk_II[4]=cnt_chk[1][2] ? 10'bz : 10'hf;
  assign chk_II[5]=cnt_chk[2][2] ? 10'bz : 10'hf;

  assign chk_mask[0]=chkbits[0]!=0 ? 6'bz : 6'b0;
  assign chk_mask[1]=chkbits[1]!=0 ? 6'bz : 6'b0;
  assign chk_mask[2]=chkbits[2]!=0 ? 6'bz : 6'b0;
  assign chk_mask[3]=cnt_chk[0][2] ? 6'bz : 6'b0;
  assign chk_mask[4]=cnt_chk[1][2] ? 6'bz : 6'b0;
  assign chk_mask[5]=cnt_chk[2][2] ? 6'bz : 6'b0;



  assign chkL0_data=(chk_data_shr[`lsqshare_wrt0]==3'd7) ? {DATA_WIDTH{1'B0}} : {DATA_WIDTH{1'bz}}; 
  assign chkL1_data=(chk_data_shr[`lsqshare_wrt1]==3'd7) ? {DATA_WIDTH{1'B0}} : {DATA_WIDTH{1'bz}}; 

  assign chkL0_en=(chk_data_shr[`lsqshare_wrt0]==3'd7) ? 1'B0 : 1'bz; 
  assign chkL1_en=(chk_data_shr[`lsqshare_wrt1]==3'd7) ? 1'B0 : 1'bz; 
 
  assign chkL0_mask=(chk_data_shr[`lsqshare_wrt0]==3'd7) ? 6'B0 : 6'bz; 
  assign chkL1_mask=(chk_data_shr[`lsqshare_wrt1]==3'd7) ? 6'B0 : 6'bz; 

  assign new3_reg_low=new_data[3][`lsaddr_reg_low];

  assign doStall=|doStall_rs;

  assign chk_dataA[0]=chk0_dataA;
  assign chk_dataA[1]=chk1_dataA;
  assign chk_dataA[2]=chk2_dataA;
  assign chk_dataA[3]=chk3_dataA;
  assign chk_dataA[4]=chk4_dataA;
  assign chk_dataA[5]=chk5_dataA;

  assign new_data[0]=new0_data;
  assign new_data[1]=new1_data;
  assign new_data[2]=new2_data;
  assign new_data[3]=new3_data;
  
  assign new_rsEn[0]=new0_rsEn;
  assign new_rsEn[1]=new1_rsEn;
  assign new_rsEn[2]=new2_rsEn;
  assign new_rsEn[3]=new3_rsEn;
  
  assign new_thread[0]=new0_thread;
  assign new_thread[1]=new1_thread;
  assign new_thread[2]=new2_thread;
  assign new_thread[3]=new3_thread;
  
  assign new_isFlag[0]=new0_isFlag;
  assign new_isFlag[1]=new1_isFlag;
  assign new_isFlag[2]=new2_isFlag;
  assign new_isFlag[3]=new3_isFlag;
  
  adder_inc #(8) init_add_mod(initcount,initcount_new,1'b1,);

  always @* begin
        for(u=0;u<6;u=u+1) begin
            II_save[u]=chk_dataA[u][`lsaddr_II];
        end
        chkEn0=chk_data_shr[`lsqshare_wrt0]!=3'd7 && chkL0_en;
        chkEn1=chk_data_shr[`lsqshare_wrt1]!=3'd7 && chkL1_en;
  end
  
  always @(posedge clk) begin
    if (rst) begin
        init<=1'b1;
        initcount<=8'd0;
    end else if (init) begin
        initcount<=initcount_new;
        if (initcount==8'hff) init<=1'b0;
    end
    if (rst) begin
        expun_addr_reg<=0;
        expun_en_reg<=0;
    end else if (~init && ~aStall) begin
        expun_addr_reg<=expun_addr;
        expun_en_reg<=expun_en;
    end else if (~init && ~chk_en) begin
        expun_addr_reg<=expun_addr;
        expun_en_reg<=expun_en;
    end
  end
endmodule



