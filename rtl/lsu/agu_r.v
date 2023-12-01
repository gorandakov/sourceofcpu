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
  reqtlb_en,
  reqtlb_addr,
  reqtlb_attr,
  reqtlb_ack,
  reqC_addr,
  reqC_attr,
  reqC_tlbEn,
  busC_tlb_data,
  busC_tlb_en,
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
  mOp_skip_LDQ,
  FU3Hit,
  FU3reg,
  FU3Data,
  extern_feed,
  writeTlb_IP,
  writeTlb_wen,
  writeTlb_force_way,
  writeTlb_force_way_en,
  writeTlb_data0,
  writeTlb_data1,
  writeTlb_data2,
  tlb_clkEn,
  cout_secq,
  addrTlb,
  sproc,
  tlb_data0,
  tlb_data1,
  tlb_hit,
  tlb_way 
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
  input reqtlb_en;
  input [29:0] reqtlb_addr;
  input [3:0] reqtlb_attr;
  output reqtlb_ack;
  input [30:0] reqC_addr;
  input [3:0] reqC_attr;
  input reqC_tlbEn;
  output [`ctlbData_width-1:0] busC_tlb_data;
  output busC_tlb_en;
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
  output mOp_skip_LDQ;
  input FU3Hit;
  input [8:0] FU3reg;
  input [127+8:0] FU3Data;
  input extern_feed;
  output [2:0] [TLB_IP_WIDTH-2:0] writeTlb_IP;
  output [2:0] writeTlb_wen;
  output [2:0] [2:0] writeTlb_force_way;
  output [2:0]  writeTlb_force_way_en;
  output [2:0] [TLB_DATA_WIDTH-1:0] writeTlb_data0;
  output [2:0] [TLB_DATA_WIDTH-1:0] writeTlb_data1;
  output [2:0] [TLB_DATA_WIDTH-1:0] writeTlb_data2;
  output tlb_clkEn;
  output cout_secq;
  output  [TLB_IP_WIDTH-1:0] addrTlb;
  output [23:0] sproc;
  input [TLB_DATA_WIDTH-1:0] tlb_data0;
  input [TLB_DATA_WIDTH-1:0] tlb_data1;
  input tlb_hit;
  input [2:0] tlb_way;

  wire [2:0]new_en;
  wire [2:0] new_can;
  reg [2:0] new_can_reg;
  reg [2:0] new_can_reg2;
  wire [2:0] [47:0] new_addr;
  wire [2:0] [3:0] new_attr;
  wire [2:0] new_indir;
  wire [2:0] new_inv;
  wire [2:0] new_permReq;

  wire tlb_clkEn;

  wire [2:0] writeTlb_wenC0;
  wire [2:0] writeTlb_wenHC0;
  wire [2:0] writeTlb_low0;
  reg [2:0] writeTlb_low0_reg;
  reg [2:0] writeTlb_wenC0_reg;
  reg [2:0] writeTlb_wenHC0_reg;

  wire writeTlb_low;

  wire [2:0] [TLB_IP_WIDTH-2:0] writeTlb_IP0;
  wire [2:0] writeTlb_wen0;
  wire [2:0] [TLB_DATA_WIDTH-1:0] writeTlb_data00;
  wire [2:0] [TLB_DATA_WIDTH-1:0] writeTlb_data10;
  wire [2:0] [TLB_DATA_WIDTH-1:0] writeTlb_data20;

  reg [2:0] [TLB_IP_WIDTH-2:0] writeTlb_IP0_reg;
  reg [2:0] writeTlb_wen0_reg;
  reg [2:0] [TLB_DATA_WIDTH-1:0] writeTlb_data00_reg;
  reg [2:0] [TLB_DATA_WIDTH-1:0] writeTlb_data10_reg;
  reg [2:0] [TLB_DATA_WIDTH-1:0] writeTlb_data20_reg;

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
  
  wire [14:0] addrMain;
  wire [13:0] addrNext;

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
  reg [1:0][23:0] pproc;
  reg [1:0][23:0] vproc;
  reg [1:0][63:0] mflags;

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

  assign new_en[0]=reqtlb_en;
  assign new_en[1]=reqC_tlbEn;
  assign new_en[2]=new_miss;
  assign new_addr[0]={reqtlb_addr,14'b0};
  assign new_addr[1]={reqC_addr,13'b0};
  assign new_addr[2]=mOp0_addrMain_reg;
  assign new_attr[0]=reqtlb_attr;
  assign new_attr[1]=reqC_attr;
  assign new_attr[2]=mOp0_attr_reg;
 
  wire mop_ack;

  assign reqtlb_ack=new_can[0] & ~new_can_reg[0]; 
  assign busC_tlb_en=new_can[1] & ~new_can_reg[1]; 
  assign mop_ack=new_can[2] & ~new_can_reg[2]; 

  assign writeTlb_IP[0]=reqtlb_ack ? writeTlb_IP0_reg[0] : writeTlb_IP0_reg[2];
  assign writeTlb_IP[1]=busC_tlb_en ? writeTlb_IP0_reg[1] : writeTlb_IP0_reg[2];
  assign writeTlb_IP[2]=reqtlb_ack ? writeTlb_IP0_reg[0] : writeTlb_IP0_reg[2];
  assign writeTlb_data0[0]=reqtlb_ack ? writeTlb_data00_reg[0] : writeTlb_data00_reg[2];
  assign writeTlb_data0[1]=busC_tlb_en ? writeTlb_data00_reg[1] : writeTlb_data00_reg[2];
  assign writeTlb_data0[2]=reqtlb_ack ? writeTlb_data00_reg[0] : writeTlb_data00_reg[2];
  assign writeTlb_data1[0]=reqtlb_ack ? writeTlb_data10_reg[0] : writeTlb_data10_reg[2];
  assign writeTlb_data1[1]=busC_tlb_en ? writeTlb_data10_reg[1] : writeTlb_data10_reg[2];
  assign writeTlb_data1[2]=reqtlb_ack ? writeTlb_data10_reg[0] : writeTlb_data10_reg[2];
  assign writeTlb_data2[0]=reqtlb_ack ? writeTlb_data20_reg[0] : writeTlb_data20_reg[2];
  assign writeTlb_data2[1]=busC_tlb_en ? writeTlb_data20_reg[1] : writeTlb_data20_reg[2];
  assign writeTlb_data2[2]=reqtlb_ack ? writeTlb_data20_reg[0] : writeTlb_data20_reg[2];
  assign writeTlb_low=busC_tlb_en ? writeTlb_low0_reg[1] : writeTlb_low0_reg[2];
 
  assign mOp_addrEven[12:8]=(~mOp0_lsfwd_reg & ~req_bus & addrMain[7]) ? addrNext[12:8] : 5'bz;
  assign mOp_addrEven[12:8]=(~mOp0_lsfwd_reg & ~req_bus & ~addrMain[7]) ? addrMain[12:8] : 5'bz;
  assign mOp_addrEven=(mOp0_lsfwd_reg & ~req_bus) ? mOp0_addrEven_reg : 36'bz;
  assign mOp_addrOdd[12:8]=(~mOp0_lsfwd_reg & ~req_bus & ~addrMain[7]) ? addrNext[12:8] : 5'bz;
  assign mOp_addrOdd[12:8]=(~mOp0_lsfwd_reg & ~req_bus & addrMain[7]) ? addrMain[12:8] : 5'bz;
  assign mOp_addrOdd=(mOp0_lsfwd_reg & ~req_bus) ? mOp0_addrOdd_reg : 36'bz;
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
    ~pause_miss_reg2 & ~tlb_proceed & ~bus_hold & (mOp0_type_reg[1]) : 1'b0; 

  assign doStall=mOp0_en_reg & ~(tlb_hit|mOp0_lsfwd_reg|tlb_is_inv) || bus_hold || pause_miss_reg2 || tlb_proceed ||
  reqtlb_en || reqC_tlbEn || req_bus;
//& ~reqtlb_en & ~reqC_tlbEn & ~pause_miss &
//         ~(~tlb_hit & ~mOp0_lsfwd_reg & mOp0_en_reg & tlb_clkEn)
  assign mOp_tlb_miss=mOp0_en_reg & ~(tlb_hit|mOp0_lsfwd_reg);
  
  assign tlb_clkEn=mOp0_en_reg | reqtlb_en_reg;

  assign mOp_skip_LDQ=~tlb_data[`dtlbData_wp] && ~tlb_data_next[`dtlbData_wp]|~page_carry;

  assign mOp_addrEven[43:13]=(~mOp0_lsfwd_reg & ~req_bus && ~page_carry | ~addrMain[8]) ? 
    tlb_data[`dtlbData_phys] : 31'bz;
  assign mOp_addrEven[43:13]=(~mOp0_lsfwd_reg & ~req_bus && page_carry && addrMain[8]) ?
    tlb_data_next[`dtlbData_phys] : 31'bz;
  assign mOp_addrOdd[43:13]=(~mOp0_lsfwd_reg & ~req_bus && ~page_carry | addrMain[8]) ? 
    tlb_data[`dtlbData_phys] : 31'bz;
  assign mOp_addrOdd[43:13]=(~mOp0_lsfwd_reg & ~req_bus && page_carry && ~addrMain[8]) ?
    tlb_data_next[`dtlbData_phys] : 31'bz;
  
  assign pageFault_t=(page_carry) ? (fault_tlb | ({2{mOp_split}} & fault_tlb_next)) & {2{tlb_hit}} : fault_tlb & {2{tlb_hit}};
  assign pageFault=(pageFault_t_reg!=0) | fault_cann_reg && mOp_en_reg && ~bus_hold_reg;
  assign fault_cann=1'b0;
  assign faultNo=fault_cann_reg | (pageFault_t_reg!=0) && ~bus_hold_reg ? {6'd11,1'b0,2'd1} : {6'd0,1'b0,2'd2};
  assign faultCode={3'b0,fault_cann_reg,pageFault_t_reg[1],2'b0,pageFault_t_reg[0]};
  
  assign fault_tlb={mflags[`mflags_cpl+1] & tlb_data[`dtlbData_sys] || mflags[-1+`mflags_cpl] & ~&addrMain_tlb[42:41], ~tlb_data[`dtlbData_na]}; 
  assign fault_tlb_next={mflags[`mflags_cpl+1] & tlb_data_next[`dtlbData_sys],  ~tlb_data_next[`dtlbData_na]}; 

  assign addrTlb=addrMain_tlb;

  assign mOp_rsEn=mOp0_en_reg & tlb_hit & ~pause_miss_reg2 & ~bus_hold & ~tlb_proceed & ~mOp0_lsfwd_reg & ~(mOp0_type_reg==2'b10); 
//dummy page walker
  assign reqtlb_ack=tlb_proceed & req_can & reqtlb_next;

  assign addrInPage=addrMain_tlb[43:15];

  assign busC_tlb_data[`ctlbData_phys]=writeTlb_low[1] ? writeTlb_data1[1][`dtlbData_phys] : writeTlb_data0[1][`dtlbData_phys];
  assign busC_tlb_data[`ctlbData_sys]=writeTlb_low[1] ? writeTlb_data1[1][`dtlbData_sys] : writeTlb_data0[1][`dtlbData_sys];
  assign busC_tlb_data[`ctlbData_ne]=writeTlb_low[1] ? writeTlb_data1[1][`dtlbData_ne] : writeTlb_data0[1][`dtlbData_ne];
  assign busC_tlb_data[`ctlbData_na]=writeTlb_low[1] ? writeTlb_data1[1][`dtlbData_na] : writeTlb_data0[1][`dtlbData_na];
  assign busC_tlb_data[`ctlbData_global]=writeTlb_low[1] ? writeTlb_data1[1][`dtlbData_glo] : writeTlb_data0[1][`dtlbData_glo];

//  assign busC_tlb_en=writeTlb_wenC[1] | writeTlb_wenHC[1];

  assign new_miss=~tlb_hit & tlb_clkEn & ~mOp0_lsfwd_reg & 
            ~reqC_tlbEn & mOp0_en_reg & ~tlb_proceed & ~(mOp0_invtlb_reg &
            tlb_is_inv_reg) || tlb_hit & tlb_clkEn & ~mOp0_lsfwd_reg &
            ~reqC_tlbEn & mOp0_en_reg & ~tlb_proceed & mOp0_invtlb_reg &
            ~tlb_is_inv_reg;
  assign writeTlb_force_way[2]=tlb_way_reg;
  assign writeTlb_force_way_en[2]=writeTlb_wen && tlb_is_inv;
  assign writeTlb_force_way[1]=tlb_way_reg;
  assign writeTlb_force_way_en[1]=writeTlb_wen && tlb_is_inv;
  assign writeTlb_force_way[0]=tlb_way_reg;
  assign writeTlb_force_way_en[0]=writeTlb_wen && tlb_is_inv;

  adder_inc #(7) addNext_mod(addrMain[13:7],addrNext[13:7],1'b1,page_carry);

  assign new_inv[0]=1'b0;
  assign new_inv[1]=1'b0;
  assign new_inv[2]=tlb_is_inv;

  assign new_permReq[0]=1'b0;
  assign new_permReq[1]=1'b1;
  assign new_permReq[2]=1'b0;

  pager pgr_mod(
  .clk(clk),
  .rst(rst),
  .except(except),
  .bus_hold(bus_hold),
  .req_bus(req_bus),
  .new_en(new_en),
  .new_can(req_can),
  .new_addr(new_addr),
  .new_attr(new_attr),
  .new_indir(1'b0),
  .new_inv(new_inv),
  .new_permReq(new_permReq),
  .csrss_no(csrss_no),
  .csrss_thread(csrss_thread),
  .csrss_en(csrss_en),
  .csrss_data(csrss_data),
  .mOp_register(mOp_regNo),
  .mOp_LSQ(mOp_LSQ),
  .mOp_II(mOp_II),
  .mOp_WQ(mOp_WQ),
  .mOp_addrEven(mOp_addrEven),
  .mOp_addrOdd(mOp_addrOdd),
//  .mOp_addrMain(mOp_addrMain),
  .mOp_sz(mOp_sz),
  .mOp_st(mOp_st),
  .mOp_en(mOp_en),
//  .mOp_thread(mOp_thread),
  .mOp_lsflag(mOp_lsflag),
  .mOp_banks(mOp_banks),
//  .mOp_rsBanks(mOp_rsBanks),
  .mOp_bank0(mOp_bank0),
  .mOp_odd(mOp_odd),
  .mOp_addr_low(mOp_addr_low),
  .mOp_split(mOp_split),
  .FUHit(FU3Hit),
  .FUreg(FU3reg),
  .data_in(FU3Data[127:0]),
  .writeTlb_IP(writeTlb_IP0),
  .writeTlb_low(writeTlb_low0),
  .writeTlb_wen(writeTlb_wen0),
  .writeTlb_wen_c(writeTlb_wenC0),
  .writeTlb_wenH_c(writeTlb_wenHC0),
  .writeTlb_data0(writeTlb_data00),
  .writeTlb_data1(writeTlb_data10),
  .writeTlb_data2(writeTlb_data20)
  //add code invlpg io
  );
  
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
          (((opsize==5 && stepOver) || opsize==6) && bank0==((i-4)&5'h1f)) || (opsize==7 && bank0[4:3]=={i[4:3],3'b0});
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
         5'hc,5'hd,5'he:  opsize=7; //int, double, single 128 bit (a)
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
          if (mOp0_en & ~|req_bus || extern_feed & |req_bus & (mOp0_type_reg==2'b10) || |req_bus & (mOp0_type_reg==2'b11)) begin
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
	      mflags[`mflags_cpl]<={mOp0_attr[`attr_km],mOp0_attr[`attr_sec]};//muha-srankk
          end else if (!rsStall) begin
	      if (mOp_en && !|req_bus) mOp0_en_reg<=1'b0;
          end
      end 
      if (rst) begin
          new_can_reg<=3'b111;
          new_can_reg2<=3'b111;
          writeTlb_IP0_reg<=0;
          writeTlb_data00_reg<=0;
          writeTlb_data10_reg<=0;
          writeTlb_data20_reg<=0;
          writeTlb_low0_reg<=0;
      end else begin
          new_can_reg<=new_can;
          new_can_reg2<=new_can_reg;
          writeTlb_IP0_reg<=writeTlb_IP0;
          writeTlb_data00_reg<=writeTlb_data00;
          writeTlb_data10_reg<=writeTlb_data10;
          writeTlb_data20_reg<=writeTlb_data20;
          writeTlb_low0_reg<=writeTlb_low0;
      end
     
      if (rst) begin
          pause_miss_reg<=1'b0;
          pause_miss_reg2<=1'b0;
      end else begin
          pause_miss_reg<=pause_miss;
          pause_miss_reg2<=pause_miss_reg;
      end
          if (rst) begin
              pproc[0]<=24'b0;
              vproc[0]<=24'b0;
	      mflags[0]<=64'b0;
              pproc[1]<=24'b0;
              vproc[1]<=24'b0;
	      mflags[1]<=64'b0;
          end else if (csrss_en) begin
              case(csrss_no[14:0])
           `csr_page: begin pproc[csrss_no[15]]<=csrss_data[63:40]; end
           `csr_vmpage: vproc[csrss_no[15]]<=csrss_data[63:40];
           `csr_mflags: mflags[csrss_no[15]]<=csrss_data;
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
    always @* begin
	if (~mOp0_attr_reg[`attr_vm]) begin
	    proc=pproc[mOp0_thread_reg];
	    sproc=0;
	end
	if (mOp0_attr_reg[`attr_vm]) begin
	    proc=vproc[mOp0_thread_reg];
	    sproc=pproc[mOp0_thread_reg]^1;
	end
    end   
endmodule

