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
module agu_r(
  clk,
  rst,
  except,
  doStall,
  bus_hold,
  pause_miss,
  rsStall,
  mOp0_en,
  mOp0_thread,
  mOp0_lsflag,
  mOp0_addrMain,
  mOp0_addrEven,
  mOp0_addrOdd,
  mOp0_lsfwd,
  mOp0_type,
  mOp0_odd,
  mOp0_addr_low,
  mOp0_bread,
  mOp0_data,
  mOp0_pbit,
  mOp0_sz,
  mOp0_invtlb,
  mOp0_st,
  mOp0_split,
  mOp0_bank0,
  mOp0_regNo,
  mOp0_LSQ,
  mOp0_II,
  mOp0_WQ,
  mOp0_attr,
  csrss_no,csrss_en,csrss_thread,csrss_data,
  pageFault,
  faultCode,
  faultNo,
  mOp_addrEven,
  mOp_addrOdd,
  mOp_sz,
  mOp_st,
  mOp_en,
  mOp_rsEn,
  mOp_ioEn,
 // mOp_thread,
  mOp_lsflag,
  mOp_banks,
  mOp_bank0,
  mOp_odd,
  mOp_addr_low,
  mOp_split,
  mOp_regNo,
  mOp_LSQ,
  mOp_II,
  mOp_WQ,
  mOp_lsfwd,
  mOp_type,
  mOp_bread,
  mOp_data,
  mOp_pbit,
  mOp_tlb_miss,
  FU3Hit,
  FU3reg,
  FU3Data,
  extern_feed
  );
  
  localparam VADDR_WIDTH=64;
  localparam BANK_COUNT=32;
  localparam PADDR_WIDTH=44;
  localparam TLB_IP_WIDTH=52;
  localparam TLB_DATA_WIDTH=`dtlbData_width;

  input clk;
  input rst;
  input except;
  output doStall;
  input bus_hold;
  input pause_miss;
  input rsStall;
  input mOp0_en;
  input mOp0_thread;
  input mOp0_lsflag;
  input [43:0] mOp0_addrMain;
  input [PADDR_WIDTH-9:0] mOp0_addrEven;
  input [PADDR_WIDTH-9:0] mOp0_addrOdd;
  input mOp0_lsfwd;
  input [1:0] mOp0_type;
  input mOp0_odd;
  input [1:0] mOp0_addr_low;
  input [3+1:0] mOp0_bread;
  input [127+8:0] mOp0_data;
  input [1:0] mOp0_pbit;
  input [4:0] mOp0_sz;
  input mOp0_invtlb;
  input mOp0_st;
  input mOp0_split;
  input [4:0] mOp0_bank0;
  input [8:0] mOp0_regNo;
  input [8:0] mOp0_LSQ;
  input [9:0] mOp0_II;
  input [5:0] mOp0_WQ;
  input [3:0] mOp0_attr;
  input [15:0] csrss_no;
  input csrss_en;
  input csrss_thread;
  input [63:0] csrss_data;

  output pageFault;
  output [7:0] faultCode;
  output [8:0] faultNo;
  output [PADDR_WIDTH-1:8] mOp_addrEven;
  output [PADDR_WIDTH-1:8] mOp_addrOdd;
  output [4:0] mOp_sz;
  output mOp_st;
  output mOp_en;
  output mOp_rsEn;
  output mOp_ioEn;
//  output mOp_thread;
  output mOp_lsflag;
  output [BANK_COUNT-1:0] mOp_banks;
  output [4:0] mOp_bank0;
  output mOp_odd;
  output [1:0] mOp_addr_low;
  output mOp_split;
  output [8:0] mOp_regNo;
  output [8:0] mOp_LSQ;
  output [9:0] mOp_II;
  output [5:0] mOp_WQ;
  output mOp_lsfwd;
  output [1:0] mOp_type;
  output [3+1:0] mOp_bread;
  output [127+8:0] mOp_data;
  output [1:0] mOp_pbit;
  output mOp_tlb_miss;
  input FU3Hit;
  input [8:0] FU3reg;
  input [127+8:0] FU3Data;
  input extern_feed;

  wire tlb_clkEn;

  wire writeTlb_wenC;
  wire writeTlb_wenHC;
  wire writeTlb_low;

  reg mOp0_en_reg;
  reg mOp0_thread_reg;
  reg mOp0_lsflag_reg;
  reg [43:0] mOp0_addrMain_reg;
  reg [VADDR_WIDTH:0] addrMain_tlb;
  reg [VADDR_WIDTH:0] addrSupp_tlb;
  reg [VADDR_WIDTH:0] addrSupp2_tlb;
  reg [3:0] addrMain_attr;
  reg [3:0] addrSupp_attr;
  reg [3:0] addrSupp2_attr;
//  reg [VADDR_WIDTH-1:0] addrMain_tlb_reg;
  reg tlb_save;
  reg tlb_save2;
  reg tlb_is_code;
  reg [4:0] mOp0_sz_reg;
  reg mOp0_invtlb_reg;
  reg mOp0_st_reg;
  reg mOp0_split_reg;
  reg [4:0] mOp0_bank0_reg;
 // reg [4:0] mOp0_bank1_reg;
  reg [8:0] mOp0_regNo_reg;
  reg [8:0] mOp0_LSQ_reg;
  reg [9:0] mOp0_II_reg;
  reg [5:0] mOp0_WQ_reg;
  reg [3:0] mOp0_attr_reg;
  reg [PADDR_WIDTH-9:0] mOp0_addrEven_reg;
  reg [PADDR_WIDTH-9:0] mOp0_addrOdd_reg;
  reg mOp0_lsfwd_reg;
  reg [1:0] mOp0_type_reg;
  reg mOp0_odd_reg;
  reg [1:0] mOp0_addr_low_reg;
  reg [3+1:0] mOp0_bread_reg;
  reg [127+1+7:0] mOp0_data_reg;
  reg [1:0] mOp0_pbit_reg;

  wire [29:0] addrInPage;
  wire [29:0] addrOffPage;
  reg reqtlb_en_reg,tlb_hit_reg,reqtlb_en_reg2;
//  reg [VADDR_WIDTH-14:0] reqtlb_addr_reg;
  reg tlb_clkEn_reg;

  wire [TLB_DATA_WIDTH-1:0] tlb_data;
  wire [TLB_DATA_WIDTH-1:0] tlb_data_next;
  wire tlb_hit;

  assign tlb_hit=1'b1;
  
  wire [13:0] addrMain;
  wire [12:0] addrNext;

  reg [2:0] opsize;
  wire hasBankNext=1'b0;
 
  wire [2:0] tlb_way;
  reg  [2:0] tlb_way_reg;
  reg tlb_is_inv,tlb_is_inv_reg,tlb_is_inv_reg2;

  reg [4:0] bank0;
  reg [31:0] banks0;
  reg stepOver;
  reg stepOver2;
  
  reg pause_miss_reg;
  reg pause_miss_reg2;
  
  wire page_carry;
  
  wire req_bus,req_can;
  reg tlb_proceed;

  reg reqtlb_next;
  reg tlb_save_reg;
  reg req_can_reg; 
  reg tlb_in_flight;//misnomer

  reg [23:0] proc;
  reg [23:0] sproc;
  reg [23:0] pproc;
  reg [23:0] vproc;
  reg [63:0] mflags;

  wire [1:0] fault_tlb;
  wire [1:0] fault_tlb_next;
  //wire [4:0] lastSz;
  wire [1:0] pageFault_t;
  reg [1:0] pageFault_t_reg; 
  wire fault_cann;
  reg fault_cann_reg;
  reg mOp_en_reg;
  reg bus_hold_reg;

  integer i;

  wire new_miss;

  assign addrNext[6:0]=addrMain[6:0];
  assign addrMain[13:0]=mOp0_addrMain_reg[13:0];
  assign mOp_addr_low=(~mOp0_lsfwd_reg & ~req_bus) ? addrMain[1:0] : 2'bz;
  assign mOp_addr_low=(mOp0_lsfwd_reg & ~req_bus) ? mOp0_addr_low_reg : 2'bz;
  assign mOp_odd=(~mOp0_lsfwd_reg & ~req_bus) ? addrMain[7] : 1'bz;
  assign mOp_odd=(mOp0_lsfwd_reg & ~req_bus) ? mOp0_odd_reg : 1'bz;
  assign mOp_banks=(~req_bus & mOp0_en_reg & (tlb_hit|mOp0_lsfwd_reg)) ? banks0 : 32'bz;
  assign mOp_banks=(~req_bus & ~(mOp0_en_reg & (tlb_hit|mOp0_lsfwd_reg))) ? 32'b0 : 32'bz;
  assign mOp_bank0=(~req_bus) ? mOp0_bank0_reg : 5'bz;
  assign mOp_split=(~req_bus) ? mOp0_split_reg : 1'bz;
  assign mOp_sz=(~req_bus) ? mOp0_sz_reg : 5'bz;
  assign mOp_st=(~req_bus) ? mOp0_st_reg : 1'bz;
  assign mOp_regNo=(~req_bus) ? mOp0_regNo_reg : 9'bz;
  assign mOp_LSQ=(~req_bus) ? mOp0_LSQ_reg : 9'bz;
  assign mOp_II=(~req_bus) ? mOp0_II_reg : 10'bz;
  assign mOp_WQ=(~req_bus) ? mOp0_WQ_reg : 6'bz;
//  assign mOp_thread=(~req_bus) ? mOp0_thread_reg : 1'bz;
  assign mOp_lsflag=(~req_bus) ? mOp0_lsflag_reg : 1'bz;
  assign mOp_lsfwd=(~req_bus) ? mOp0_lsfwd_reg : 1'b0;
  assign mOp_type=(~req_bus) ? mOp0_type_reg : 2'b00;
  assign mOp_bread=(~req_bus) ? mOp0_bread_reg|{5{~mOp0_lsfwd_reg}} : 5'b1111;
  assign mOp_data=(~req_bus) ? mOp0_data_reg : 136'b0;
  assign mOp_pbit=(~req_bus) ? mOp0_pbit_reg : 2'b0;
 
  assign mOp_en=(~req_bus) ? mOp0_en_reg & (tlb_hit|mOp0_lsfwd_reg|tlb_is_inv) & ~req_bus & ~except &
    ~pause_miss_reg2 & ~tlb_proceed & ~bus_hold & (mOp0_type_reg!=2'b10) : 1'bz; 
  assign mOp_ioEn=(~req_bus) ? mOp0_en_reg & (tlb_hit|mOp0_lsfwd_reg) & ~req_bus & ~except &
    ~pause_miss_reg2 & ~tlb_proceed & ~bus_hold & (mOp0_type_reg==2'b10) : 1'b0; 

  assign doStall=mOp0_en_reg & ~(tlb_hit|mOp0_lsfwd_reg|tlb_is_inv) || bus_hold || pause_miss_reg2 || tlb_proceed ||
  reqtlb_en || reqC_tlbEn || req_bus;
//& ~reqtlb_en & ~reqC_tlbEn & ~pause_miss &
//         ~(~tlb_hit & ~mOp0_lsfwd_reg & mOp0_en_reg & tlb_clkEn)
  assign mOp_tlb_miss=mOp0_en_reg & ~(tlb_hit|mOp0_lsfwd_reg);
  
  assign tlb_clkEn=mOp0_en_reg | reqtlb_en_reg;

  assign mOp_addrEven[43:8]=mOp0_addrEven_reg[43:8];
  assign mOp_addrEven[43:8]=mOp0_addrOdd_reg[43:8];
  
  assign pageFault_t=(page_carry) ? (fault_tlb | ({2{mOp_split}} & fault_tlb_next)) & {2{tlb_hit}} : fault_tlb & {2{tlb_hit}};
  assign pageFault=(pageFault_t_reg!=0) | fault_cann_reg && mOp_en_reg && ~bus_hold_reg;
  assign fault_cann=1'b0;
  assign faultNo=fault_cann_reg | (pageFault_t_reg!=0) && ~bus_hold_reg ? {6'd11,1'b0,2'd1} : {6'd0,1'b0,2'd2};
  assign faultCode={3'b0,fault_cann_reg,pageFault_t_reg[1],2'b0,pageFault_t_reg[0]};
  
  assign fault_tlb={mflags[`mflags_cpl]==2'd3 && tlb_data[`dtlbData_sys], ~tlb_data[`dtlbData_na]}; 
  assign fault_tlb_next={mflags[`mflags_cpl]==2'd3 && tlb_data_next[`dtlbData_sys],  ~tlb_data_next[`dtlbData_na]}; 

  assign mOp_rsEn=mOp0_en_reg & tlb_hit & ~pause_miss_reg2 & ~bus_hold & ~tlb_proceed & ~mOp0_lsfwd_reg & ~(mOp0_type_reg==2'b10); 
//dummy page walker
  adder_inc #(6) addNext_mod(addrMain[12:7],addrNext[12:7],1'b1,page_carry);

  
    always @*
    begin
      stepOver=|mOp0_addrMain_reg[1:0];
      stepOver2=&mOp0_addrMain_reg[1:0];
      bank0=mOp0_bank0_reg;
      /* verilator lint_off WIDTH */
      for (i=0;i<32;i=i+1)
        begin
          banks0[i]=bank0==i || 
          ((opsize==6 || opsize==3 || opsize[2] || (stepOver && opsize==2) || 
            (stepOver2 && opsize==1)) && bank0==((i-1)&5'h1f)) ||
          (((opsize==3 && stepOver) || opsize[2] || opsize==6) && bank0==((i-2)&5'h1f)) || 
          (((opsize==4 && stepOver2) || opsize==5 || opsize==6) && bank0==((i-3)&5'h1f)) ||
          (((opsize==5 && stepOver) || opsize==6) && bank0==((i-4)&5'h1f));
        end
    end
      /* verilator lint_on WIDTH */
  always @* begin
      case(mOp0_sz_reg)
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
	 5'hf: opsize=6; //160 bit fill/spill
	 default: opsize=3;
      endcase
  end

  always @(posedge clk) begin
      if (rst) begin
          mOp0_en_reg<=1'b0;
          mOp0_thread_reg<=1'b0;
          mOp0_lsflag_reg<=1'b0;
          mOp0_addrMain_reg<=44'b0;
          mOp0_sz_reg<=5'b0;
          mOp0_invtlb_reg<=1'b0;
          mOp0_st_reg<=1'b0;
          mOp0_split_reg<=1'b0;
          mOp0_bank0_reg<=5'b0;
          mOp0_regNo_reg<=9'b0;
	  mOp0_LSQ_reg<=9'b0;
	  mOp0_II_reg<=10'b0;
	  mOp0_WQ_reg<=6'b0;
	  mOp0_attr_reg<=4'b0;
          mOp0_addrEven_reg<=36'b0;
          mOp0_addrOdd_reg<=36'b0;
          mOp0_lsfwd_reg<=1'b0;
          mOp0_odd_reg<=1'b0;
          mOp0_addr_low_reg<=2'b0;
          mOp0_bread_reg<={1'b0,4'b0};
          mOp0_data_reg<={8'b0,128'b0};
          mOp0_pbit_reg<={2'b0};
          addrMain_tlb<=65'b0;
      end else if (except) begin
          mOp0_en_reg<=1'b0;
      end else if (~doStall&&!rsStall) begin
          mOp0_en_reg<=mOp0_en & ~(except);
          if (mOp0_en & ~req_bus || extern_feed & ~req_bus & (mOp0_type_reg==2'b10)) begin
              mOp0_thread_reg<=mOp0_thread;
              mOp0_lsflag_reg<=mOp0_lsflag;
              mOp0_addrMain_reg<=mOp0_addrMain;
              addrMain_tlb<={proc[20:0],mOp0_addrMain};
              mOp0_sz_reg<=mOp0_sz;
              mOp0_st_reg<=mOp0_st;
              mOp0_invtlb_reg<=mOp0_invtlb;
              mOp0_split_reg<=mOp0_split;
              mOp0_bank0_reg<=mOp0_bank0;
              mOp0_regNo_reg<=mOp0_regNo;
	      mOp0_LSQ_reg<=mOp0_LSQ;
	      mOp0_II_reg<=mOp0_II;
	      mOp0_WQ_reg<=mOp0_WQ;
	      mOp0_attr_reg<=mOp0_attr;
              mOp0_addrEven_reg<=mOp0_addrEven;
              mOp0_addrOdd_reg<=mOp0_addrOdd;
              mOp0_lsfwd_reg<=mOp0_lsfwd;
              mOp0_odd_reg<=mOp0_odd;
              mOp0_addr_low_reg<=mOp0_addr_low;
              mOp0_bread_reg<=mOp0_bread;
              mOp0_data_reg<=mOp0_data;
              mOp0_pbit_reg<=mOp0_pbit;
	      if (~mOp0_attr[`attr_vm]) begin
		  proc<=pproc;
		  sproc<=0;
	      end
	      if (mOp0_attr[`attr_vm]) begin
		  proc<=vproc;
		  sproc<=pproc^1;
	      end
	      mflags[`mflags_cpl]<=mOp0_attr[`attr_km] ? 2'b0 : 2'b11;
	      mflags[`mflags_sec]<=mOp0_attr[`attr_sec];//muha-srankk
          end else if (!rsStall) begin
	      if (mOp_en && !req_bus) mOp0_en_reg<=1'b0;
          end
      end 
      if (rst) begin
          tlb_hit_reg<=1'b0; 
//          addrMain_tlb_reg<={VADDR_WIDTH{1'b0}};
          //reqtlb_addr_reg<=51'b0;
          tlb_clkEn_reg<=1'b0;
	  mOp_en_reg<=1'b0;
	  bus_hold_reg<=1'b0;
      end else begin
          tlb_hit_reg<=tlb_hit; 
//          addrMain_tlb_reg<=addrMain_tlb;
          //reqtlb_addr_reg<=reqtlb_addr;
          tlb_clkEn_reg<=tlb_clkEn;
	  mOp_en_reg<=mOp_en && ~req_bus;
	  bus_hold_reg<=bus_hold;
      end
     
      if (rst) begin
          pause_miss_reg<=1'b0;
          pause_miss_reg2<=1'b0;
      end else begin
          pause_miss_reg<=pause_miss;
          pause_miss_reg2<=pause_miss_reg;
      end
          if (rst) begin
              proc<=24'b0;
              sproc<=24'b0;
	      mflags<=64'b0;
          end else if (csrss_en) begin
              case(csrss_no)
           `csr_page: begin pproc<=csrss_data[63:40]; proc<=csrss_data[63:40]; sproc<=0; end
           `csr_vmpage: vproc<=csrss_data[63:40];
           `csr_mflags: mflags<=csrss_data;
              endcase
	 end
      if (rst) tlb_way_reg<=3'd0;
      else if (tlb_clkEn) tlb_way_reg<=tlb_way;
      tlb_save_reg<=tlb_save;
      req_can_reg<=req_can; 
      if (rst) begin
         // cmplxAddr_reg<=64'b0;
          pageFault_t_reg<=2'b0;
          fault_cann_reg<=1'b0;
      end else if (!rsStall) begin
         // cmplxAddr_reg<=cmplxAddr;
          pageFault_t_reg<=pageFault_t;
          fault_cann_reg<=fault_cann;
      end
  end
endmodule

