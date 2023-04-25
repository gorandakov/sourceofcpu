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
`include "../exc.sv"

module agu(
  clk,
  rst,
  except,
 // except_gate,
 // except_in_vm,
//  except_in_km,
  attr,
  rsStall,
  read_clkEn,
  doStall,
  bus_hold,
  op,
  shiftSize,
  regno,
  LSQ_no,
  II_no,
  WQ_no,
  thread,
  lsflag,
  cmplxAddrn,
  cmplxAddr,
  cin_secq,
  ptrdiff,
  other0_banks,
  other1_banks,
  otherR_banks,
  other_flip,
  conflict,
  tlbMiss,
  pageFault,
  faultCode,
  faultNo,
  mOp_register,
  mOp_type,
  mOp_LSQ,
  mOp_II,
  mOp_WQ,
  mOp_attr,
  mOp_addrEven,
  mOp_addrOdd,
  mOp_addrMain,
  mOp_sz,
  mOp_st,
  mOp_en,
  mOp_secq,
  mOp_invtlb,
  mOp_rsEn,
  mOp_thread,
  mOp_lsflag,
  mOp_banks,
  mOp_rsBanks,
  mOp_bank0,
  mOp_odd,
  mOp_addr_low,
  mOp_split,
  mOp_noBanks,
  csrss_no,
  csrss_en,
  csrss_thr,
  csrss_data
  );

  parameter INDEX=0; //0 1 2 
  localparam ADDR_WIDTH=64;
  localparam PADDR_WIDTH=44;
  localparam OPERATION_WIDTH=`operation_width;
  localparam BANK_COUNT=32;
  localparam TLB_DATA_WIDTH=`dtlbData_width;
  localparam TLB_IP_WIDTH=52;
  localparam REG_WIDTH=`reg_addr_width;

  input clk;
  input rst;
  input except;
  input [3:0] attr;
  input rsStall;
  input read_clkEn;
  output doStall;
  input bus_hold;
  input [OPERATION_WIDTH-1:0] op;
  input [3:0] shiftSize;
  input [REG_WIDTH-1:0] regno;
  input [8:0] LSQ_no;
  input [9:0] II_no;
  input [5:0] WQ_no;
  input thread;
  input lsflag;
  input [63:0] cmplxAddr;
  input [63:0] cmplxAddrN;
  input cin_secq;
  input ptrdiff;
  input [BANK_COUNT-1:0] other0_banks;
  input [BANK_COUNT-1:0] other1_banks;
  input [BANK_COUNT-1:0] otherR_banks;
  input other_flip;
  output conflict;
  output tlbMiss;
  output pageFault;
  output [7:0] faultCode;
  output [8:0] faultNo;
  output [REG_WIDTH-1:0] mOp_register;
  output [1:0] mOp_type;
  output [8:0] mOp_LSQ;
  output [9:0] mOp_II;
  output [5:0] mOp_WQ;
  output [3:0] mOp_attr;
  output [PADDR_WIDTH-1:8] mOp_addrEven;
  output [PADDR_WIDTH-1:8] mOp_addrOdd;
  output [43:0] mOp_addrMain;
  output [4:0] mOp_sz;
  output mOp_st;
  output mOp_en;
  output mOp_secq;
  output mOp_invtlb;
  output mOp_rsEn;
  output mOp_thread;
  output mOp_lsflag;
  output [BANK_COUNT-1:0] mOp_banks;
  output [BANK_COUNT-1:0] mOp_rsBanks;
  output [4:0] mOp_bank0;
  output mOp_odd;
  output [1:0] mOp_addr_low;
  output mOp_split;
  output [BANK_COUNT-1:0] mOp_noBanks;
  input [15:0] csrss_no;
  input csrss_en;
  input csrss_thr;
  input [63:0] csrss_data;

  reg [2:0] opsize;
  wire hasIndex;
  reg aligned;//aligned for int subsys purpose not arch
  reg aligned2;//same for complex addressing
  reg tiny; //1 or 2 byte
  
  reg mode64;
  reg modeCmplx;
  reg modeCmplx_reg;
  
  wire isLongOffset;
  reg stepOver;//step over to next bank because of offset
  reg stepOver2;
  reg addrCarry;//offset by one bank
  wire stepOverCmplx;
  wire stepOverCmplx2;

  wire modeCmplx_d;
  //complex mode when index register used, or offset not fit in unsigned 12-bit range

  reg [31:0] banks0;
  
  wire [4:0] bank0;
  wire [4:0] bankL1;
  reg  [1:0] mOp_type_reg;
  wire split;
  wire [12:0] addrMain;
  wire [13:0] addrNext;
  wire [12:0] dummy0;
//  wire [12:0] CSAarg1;
//  wire [12:0] CSAarg2;
//  wire pageCarry;
//  wire pageCarry1;
  
//  wire [5:0] CSAbn0;
//  wire [5:0] CSAbn1;
  
  wire [TLB_IP_WIDTH-1:0] addrTlb;
  
  wire tlb_clkEn;
  wire tlb_hit;
  wire cout_secq;
  
  assign tlb_hit=1'b1;

  reg read_clkEn_reg;
  reg read_clkEn_reg2;
  reg [OPERATION_WIDTH-1:0] op_reg;


  wire [BANK_COUNT-1:0] all_banks;
  wire otherness;

  wire [BANK_COUNT-1:0] bit_confl;
  reg  [BANK_COUNT-1:0] bit_confl_reg;
  
  reg cin_secq_reg;
  
  wire carryNext;
 // wire non_overlap;

  reg [23:0] proc;
  reg [23:0] pproc;
  reg [23:0] sproc;
  reg [23:0] vproc;
  //reg [23:0] proc_reg;
  //reg [23:0] proc_reg2;
  reg [63:0] mflags;
  wire [63:0] mflags0; 
  integer i;
  
//  reg [ADDR_WIDTH-1:48] cmplxAddr_reg;
  
//  wire [4:0] bankNextOff;
//  wire hasBankNext;
  
  reg bus_hold_reg;
  reg bus_hold_reg2;
  
  reg [REG_WIDTH-1:0] regno_reg;
  reg [8:0] LSQ_no_reg;
  reg [9:0] II_no_reg;
  reg [5:0] WQ_no_reg;
  reg thread_reg;
  reg lsflag_reg;
  reg thread_reg2;

  wire [1:0] rcn_mask;

  reg except_reg;
  reg except_reg2;
  reg except_thread_reg;
  reg except_thread_reg2;
  
  wire [1:0] fault_tlb;
  wire [1:0] fault_tlb_next;
  wire [4:0] lastSz;
  wire [1:0] pageFault_t;
  reg [1:0] pageFault_t_reg; 
  wire fault_cann;
  reg fault_cann_reg;
 
  reg [3:0] attr_reg;
  
  generate
      genvar p,q;
      for(p=0;p<32;p=p+1) begin
          wire otherness;
          assign otherness=~(otherR_banks[p] & all_banks[p]);
        
          if (INDEX==0) begin
              assign bit_confl[p]=otherness && ~other_flip|~(all_banks[p]&&other0_banks[p]|other1_banks[p]);
          end
          if (INDEX==1) begin
              assign bit_confl[p]=other_flip ? otherness && ~(other1_banks[p]&all_banks[p]) :
                otherness && ~(other0_banks[p]&all_banks[p]);
          end
/*          if (INDEX==2) begin
              assign bit_confl[p]=(otherness && ~other_flip && !(other1_banks[p] & all_banks[p]))
                ? 1'b1 : 1'bz;
              assign bit_confl[p]=(otherness && other_flip && !(other0_banks[p] & all_banks[p]))
                ? 1'b1 : 1'bz;
              assign bit_confl[p]=((~other_flip && (other1_banks[p] & all_banks[p])) || ~otherness) ? 1'b0 : 1'bz;
              assign bit_confl[p]=((other_flip && (other0_banks[p] & all_banks[p])) || ~otherness) ? 1'b0 : 1'bz;
          end*/
          assign mOp_banks[p]=(all_banks[p] & read_clkEn_reg) & bit_confl[p]; 
      end
      if (INDEX==1) begin
        assign mOp_noBanks=~(mOp_banks|other0_banks|other1_banks|otherR_banks);
      end

  endgenerate
 
//  assign bankNextOff=5'd2; //##
//  assign hasBankNext=1'b0;//##
  assign hasIndex=op[7:6]==2'b01;
  assign stepOverCmplx=|cmplxAddr[1:0];
  assign stepOverCmplx2=&cmplxAddr[1:0];
  assign bank0=cmplxAddr[6:2];
  assign mOp_bank0=bank0;

  assign mOp_rsBanks=all_banks & {32{mOp_rsEn}}; 
  assign lastSz[1]=(opsize==1 && stepOver2) || (opsize==2 && stepOver) || (opsize==3 && ~stepOver);
  assign lastSz[2]=opsize==3 && stepOver;
  assign lastSz[4:3]=2'b0;
  assign lastSz[0]=(opsize==0) || (opsize==1 & ~stepOver2) || (opsize==2 & ~stepOver);  
  assign mOp_split=(opsize==1) ?
    bank0==5'h1f && stepOver2 : 1'bz;
  assign mOp_split=(opsize==2) ?
    bank0==5'h1f && stepOver : 1'bz;
  assign mOp_split=(opsize==3) ?
    bank0==5'h1f || (bank0==5'h1e && stepOver) : 1'bz;
  assign mOp_split=(opsize==4) ?
    bank0[4:1]==4'hf || (bank0==5'h1d && stepOver2) : 1'bz;
  assign mOp_split=(opsize==5||opsize==6) ?
    bank0[4:2]==3'h7 && (bank0[1:0]!=0 || stepOver || opsize==6) : 1'bz;
  assign mOp_split=(opsize==0) ? 1'b0 : 1'bz;
  
  assign all_banks=banks0;

  assign split=(opsize==1) ?
    bank0==5'h1f && stepOver2 : 1'bz;
  assign split=(opsize==2) ?
    bank0==5'h1f && stepOver : 1'bz;
  assign split=(opsize==3) ?
    bank0==5'h1f || (bank0==5'h1e && stepOver) : 1'bz;
  assign split=(opsize==4) ?
    bank0[4:1]==4'hf || (bank0==5'h1d && stepOver2) : 1'bz;
  assign split=(opsize==5 || opsize==6) ?
    bank0[4:2]==3'h7 && (bank0[1:0]!=0 || stepOver || opsize==6) : 1'bz;
  assign split=(opsize==0) ? 1'b0 : 1'bz;

  assign conflict=(((|(~bit_confl_reg))||mOp_type_reg==2'b10) && ~bus_hold_reg2 && 
    read_clkEn_reg2 && ~fault_cann_reg);
  
  
  assign mOp_addrEven[12:8]=(addrMain[7] ) ? addrNext[12:8] : 5'bz;
  assign mOp_addrEven[12:8]=(~addrMain[7]) ? addrMain[12:8] : 5'bz;
  assign mOp_addrOdd[12:8]=(addrMain[7] ) ? addrMain[12:8] : 5'bz;
  assign mOp_addrOdd[12:8]=(~addrMain[7]) ? addrNext[12:8] : 5'bz;
  
  assign mOp_odd=addrMain[7];
  assign mOp_addr_low=addrMain[1:0];
  
  assign addrTlb={proc[20:0],cmplxAddr[43:13]};

  assign tlb_data=tlb_data0;
  assign tlb_data_next=tlb_data1;

  assign mOp_type=tlb_data[`dtlbData_type];
  assign mOp_addrEven[43:13]=(addrMain[7] && addrNext[13]) ? cmplxAddrN[43:13] :
    31'bz;
  assign mOp_addrEven[43:13]=(~(addrMain[7] && addrNext[13] )) ?  cmplxAddr[43:13] :
    31'bz;
  assign mOp_addrOdd[43:13]=(~(~addrMain[7] && addrNext[13] ) ) ? cmplxAddr[43:13] : 
    31'bz;
  assign mOp_addrOdd[43:13]=(~addrMain[7] && addrNext[13] ) ? cmplxAddrN :
    31'bz;
//todo: add read_clkEn to pageFault
  assign pageFault_t=(addrNext[13]) ? (fault_tlb | ({2{split}} & fault_tlb_next)) & {2{tlb_hit}} : fault_tlb & {2{tlb_hit}};
  assign pageFault=(pageFault_t_reg!=0) | fault_cann_reg && read_clkEn_reg2 && ~bus_hold_reg2;
  assign fault_cann=~cout_secq;
  assign faultNo=fault_cann_reg | (pageFault_t_reg!=0) && ~bus_hold_reg2 ? {6'd11,1'b0,2'd1} : {6'd0,1'b0,2'd2};
  assign faultCode={3'b0,fault_cann_reg,pageFault_t_reg[1],2'b0,pageFault_t_reg[0]};
  assign mOp_addrMain={addrTlb[30:0],addrMain[12:0]};
  
  assign tlbMiss=read_clkEn_reg&~tlb_hit&~fault_cann & rcn_mask[1];
  
  assign addrMain=cmplxAddr[12:0];
  assign addrNext=cmplxAddrN[12:0];
  
  assign mOp_en= read_clkEn_reg &tlb_hit & rcn_mask[1];

  assign mOp_secq=fault_cann & read_clkEn;
  
  assign mOp_thread=thread_reg;
  
  assign mOp_lsflag=lsflag_reg;
  
  assign mOp_sz=op_reg[5:1];
  assign mOp_invtlb=op_reg[7];
  
  assign mOp_st=op_reg[0];
 

  assign mOp_register=regno_reg;

  assign mOp_LSQ=LSQ_no_reg;

  assign mOp_II=II_no_reg;
  
  assign mOp_WQ=WQ_no_reg;
  
  assign mOp_attr=attr_reg;
  
  assign tlb_clkEn=read_clkEn_reg;
  
  assign doStall=1'b0;

  assign mOp_rsEn=read_clkEn_reg &tlb_hit & rcn_mask[1];
    
  assign rcn_mask={~(except),~(except)};
//  assign proc=pproc[thread];
  
  assign mflags0=mflags;
  
  assign fault_tlb={mflags0[`mflags_cpl]==2'd3 && tlb_data[`dtlbData_sys], ~tlb_data[`dtlbData_na]}; 
  assign fault_tlb_next={mflags0[`mflags_cpl]==2'd3 && tlb_data_next[`dtlbData_sys],  ~tlb_data_next[`dtlbData_na]}; 

  
  agusec_range rng_mod(
  cmplxAddr,
  cin_secq,
  ptrdiff,
  cout_secq);

/*
  dtlb tlb_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(tlb_clkEn),
  .sec_wren(cout_secq),
  .addr(addrTlb),
  .sproc(sproc[20:0]),
  .read_data(tlb_data0),
  .read_data_next(tlb_data1),
  .read_way(),
  .read_hit(tlb_hit),
  */ /*.write_addr(writeTlb_IP),
  .write_data0(writeTlb_data0),
  .write_data1(writeTlb_data1),
  .write_data2(writeTlb_data2),
  .force_way(writeTlb_force_way),
  .force_way_en(writeTlb_force_way_en),
  .write_xstant(writeTlb_force_way_en),
  .write_invl(writeTlb_force_way_en),
  .write_wen(writeTlb_wen)
  );*/  

  always @*
    begin
      case(opsize)
        0: begin aligned2=1'b1; tiny=1'b1; end //byte
        1: begin aligned2=~cmplxAddr[0]; tiny=1'b1; end //2 byte
        2,3,4: 
          begin 
            aligned2=cmplxAddr[1:0]==0;
            tiny=1'b0;
          end //4,8,16 byte
      endcase
    end
  
  always @*
    begin
//addrCarry=starting at +1 offset
//stepOver=step to next 4 byte for 4 byte op
              stepOver=stepOverCmplx;
              addrCarry=1'b0;
              stepOver2=stepOverCmplx2;
    end
  always @* begin
      case(op_reg[5:1])
         5'd16: opsize=0;
         5'd17: opsize=1;
         5'd18: opsize=2;
         5'd19: opsize=3;
         5'h3:  opsize=4; //long double
         5'h0,5'h1,5'h2:  opsize=5; //int, double, single 128 bit (u)
         5'hc,5'hd,5'he:  opsize=5; //int, double, single 128 bit (a)
         5'h4,5'h5,5'h6:  opsize=2; //singleE,single,singleD
         5'h8,5'h9,5'ha:  opsize=3; //doubleE, double, singlePairD
	 //7,11=64 bit
	 5'hf: opsize=6;//fill-spill
	 default: opsize=3;
      endcase
  end
  always @*
    begin
      for (i=0;i<32;i=i+1)
       /* verilator lint_off WIDTH */
       begin
          banks0[i]=bank0==i || 
          ((opsize==6 || opsize==3 || opsize[2] || (stepOver && opsize==2) || 
            (stepOver2 && opsize==1)) && bank0==((i-1)&5'h1f)) ||
          (((opsize==3 && stepOver) || opsize[2] || opsize==6 ) && bank0==((i-2)&5'h1f)) || 
          (((opsize==4 && stepOver2) || opsize==5 || opsize==6) && bank0==((i-3)&5'h1f)) ||
          (((opsize==5 && stepOver) || opsize==6) && bank0==((i-4)&5'h1f));
        end
      /* verilator lint_on WIDTH */
    end
    
	
  always @(posedge clk)
    begin
	  if (rst) tlb_data_reg<={TLB_DATA_WIDTH{1'B0}};
	  else tlb_data_reg<=tlb_data;
          if (rst) begin
             // cmplxAddr_reg<=64'b0;
              pageFault_t_reg<=2'b0;
              fault_cann_reg<=1'b0;
          end else if (!rsStall) begin
             // cmplxAddr_reg<=cmplxAddr;
              pageFault_t_reg<=pageFault_t;
              fault_cann_reg<=fault_cann;
          end
	  mOp_type_reg<=mOp_type;
	  if (rst)
	    begin
	      //proc_reg<=15'b0;
	      //proc_reg2<=15'b0;
              op_reg<=13'b0;
              regno_reg<={REG_WIDTH{1'B0}};
              LSQ_no_reg<=9'b0;
              II_no_reg<=10'b0;
              WQ_no_reg<=6'b0;
	      attr_reg<=4'b0;
              thread_reg<=1'b0;
              thread_reg2<=1'b0;
              lsflag_reg<=1'b0;
	    end
	  else if (!rsStall)
	    begin
	      //proc_reg<=proc;
	      //proc_reg2<=proc_reg;
              op_reg<=op;
              regno_reg<=regno;
              LSQ_no_reg<=LSQ_no;
              II_no_reg<=II_no;
              WQ_no_reg<=WQ_no;
	      attr_reg<=attr;
              thread_reg<=thread;
              thread_reg2<=thread_reg;
              lsflag_reg<=lsflag;
	    end
	  if (rst) begin
	      bus_hold_reg<=1'b0;
	      bus_hold_reg2<=1'b0;
	  end else if (!rsStall) begin
	      bus_hold_reg<=bus_hold;
	      bus_hold_reg2<=bus_hold_reg;
	  end
	  if (rst) bit_confl_reg<=32'b0;
	  else if (!rsStall) bit_confl_reg<=bit_confl;
	  
	  if (rst) begin
	      read_clkEn_reg<=1'b0;
	      read_clkEn_reg2<=1'b0;
              except_reg<=1'b0;
              except_reg2<=1'b0;
              //except_thread_reg<=1'b0;
              //except_thread_reg2<=1'b0;
	  end else if (!rsStall) begin 
              read_clkEn_reg<=read_clkEn && rcn_mask[0] & ~except_reg;
              read_clkEn_reg2<=read_clkEn_reg && rcn_mask[1];
              except_reg<=except;
              except_reg2<=except_reg;
              //except_thread_reg<=except_thread;
              //except_thread_reg2<=except_thread_reg;
	  end
          if (rst) begin
              pproc<=24'b0;
              vproc<=24'b0;
              sproc<=24'b0;
              proc<=24'b0;
              mflags<=64'b0;
          end else if (csrss_en) begin
              case(csrss_no)
           `csr_page: begin pproc<=csrss_data[63:40]; proc<=csrss_data[63:40]; sproc<=0; end
           `csr_vmpage: vproc<=csrss_data[63:40];
           `csr_mflags: mflags<=csrss_data;
              endcase
	      if (~attr[`attr_vm]) begin
		  proc<=pproc;
		  sproc<=0;
	      end
	      if (attr[`attr_vm]) begin
		  proc<=vproc;
		  sproc<=pproc^1;
	      end
	      mflags[`mflags_cpl]<=attr[`attr_km] ? 2'b0 : 2'b11;
	      mflags[`mflags_sec]<=attr[`attr_sec];
          end else if (!rsStall) begin
	      if (~attr[`attr_vm]) begin
		  proc<=pproc;
		  sproc<=0;
	      end
	      if (attr[`attr_vm]) begin
		  proc<=vproc;
		  sproc<=pproc^1;
	      end
	      mflags[`mflags_cpl]<=attr[`attr_km] ? 2'b0 : 2'b11;
	      mflags[`mflags_sec]<=attr[`attr_sec];//muha-srankk
          end
	  
    end
   
endmodule


module agu_get_shiftSize(op,shiftSize);
  localparam OPERATION_WIDTH=`operation_width;
  input [OPERATION_WIDTH-1:0] op;
  output reg [3:0] shiftSize;
  always @* begin
      if (op[7:6]==2'b01) begin
          case(op[9:8])
       2'd0: shiftSize=4'b1;
       2'd1: shiftSize=4'b10;
       2'd2: shiftSize=4'b100;
       2'd3: shiftSize=4'b1000;
          endcase
      end else begin
          shiftSize=4'b1;
      end
  end
endmodule
