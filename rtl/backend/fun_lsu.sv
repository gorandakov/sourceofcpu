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

/*verilator hier_block*/
module agu_block(
  clk, rst,
  except,
  excpt_gate,
  excpt_in_vm,
  excpt_in_km,
  rsStall,
  pause_agu,
  miss_holds_agu,
  miss_pause_agu,
  wt_pause_agu,
  mOp_write_clear,
  u1_base,u1_index,u1_const,
  u1_base_fufwd,u1_base_fuufwd,
  u1_index_fufwd,u1_index_fuufwd,
  u1_op,u1_reg,
  u1_LSQ_no,u1_II_no,u1_WQ_no,
  u1_lsflag,u1_clkEn,u1_attr,
  u2_base,u2_index,u2_const,
  u2_base_fufwd,u2_base_fuufwd,
  u2_index_fufwd,u2_index_fuufwd,
  u2_op,u2_reg,
  u2_LSQ_no,u2_II_no,u2_WQ_no,
  u2_lsflag,u2_clkEn,u2_attr,
  u3_base,u3_index,u3_const,
  u3_base_fufwd,u3_base_fuufwd,
  u3_index_fufwd,u3_index_fuufwd,
  u3_op,u3_reg,
  u3_LSQ_no,u3_II_no,u3_WQ_no,
  u3_lsflag,u3_clkEn,u3_attr,
  u4_base,u4_index,u4_const,
  u4_base_fufwd,u4_base_fuufwd,
  u4_index_fufwd,u4_index_fuufwd,
  u4_op,u4_reg,
  u4_LSQ_no,u4_II_no,u4_WQ_no,
  u4_lsflag,u4_clkEn,u4_attr,
  u5_base,u5_index,u5_const,
  u5_base_fufwd,u5_base_fuufwd,
  u5_index_fufwd,u5_index_fuufwd,
  u5_op,u5_reg,
  u5_LSQ_no,u5_II_no,u5_WQ_no,
  u5_lsflag,u5_clkEn,u5_attr,
  mOp0_clHit,mOp1_clHit,mOp2_clHit,mOp3_clHit,
  miss4,
  mOpY4_en,
  mOpY4_hit,
  mOpY4_dupl,//write to a non-exclusive cl
  //mOp4_thread,
  mOpY4_addrEven,
  mOpY4_addrOdd,
  mOpY4_sz,
  mOpY4_first,
  mOpY4_banks,
  mOpY4_bank0,
  mOpY4_bank1,
  mOpY4_bgn_b,
  mOpY4_end_b,
  mOpY4_odd,
  mOpY4_addr_low,
  mOpY4_split,
  mOpY4_clHit,
  mOpY4_data,
  mOpY4_pbit,
  mOpY4_type,
  mOpY4_II,
  mOpY4_en_o,
  mOpY4_addrEven_o,
  mOpY4_addrOdd_o,
  mOpY4_sz_o,
  mOpY4_first_o,
  mOpY4_banks_o,
  mOpY4_bank0_o,
  mOpY4_bank1_o,
  mOpY4_bgn_b_o,
  mOpY4_end_b_o,
  mOpY4_odd_o,
  mOpY4_addr_low_o,
  mOpY4_split_o,
//  mOpY4_clHit_o,
  mOpY4_data_o,
  mOpY4_dataN_o,
  mOpY4_pbit_o,
  mOpY4_type_o,
  mOpY4_II_o,
  miss5,
  mOpY5_en,
  mOpY5_hit,
  mOpY5_dupl,//write to a non-exclusive cl
  //mOp4_thread,
  mOpY5_addrEven,
  mOpY5_addrOdd,
  mOpY5_sz,
  mOpY5_first,
  mOpY5_banks,
  mOpY5_bank0,
  mOpY5_bank1,
  mOpY5_bgn_b,
  mOpY5_end_b,
  mOpY5_odd,
  mOpY5_addr_low,
  mOpY5_split,
  mOpY5_clHit,
  mOpY5_data,
  mOpY5_pbit,
  mOpY5_type,
  mOpY5_II,
  mOpY5_en_o,
  //mOp4_thread,
  mOpY5_addrEven_o,
  mOpY5_addrOdd_o,
  mOpY5_sz_o,
  mOpY5_first_o,
  mOpY5_banks_o,
  mOpY5_bank0_o,
  mOpY5_bank1_o,
  mOpY5_bgn_b_o,
  mOpY5_end_b_o,
  mOpY5_odd_o,
  mOpY5_addr_low_o,
  mOpY5_split_o,
  mOpY5_data_o,
  mOpY5_dataN_o,
  mOpY5_pbit_o,
  mOpY5_type_o,
  mOpY5_II_o,
  p0_adata,p0_banks,p0_LSQ,p0_en,p0_rsEn,p0_secq,p0_ret,p0_repl,p0_lsfwd,
  p1_adata,p1_banks,p1_LSQ,p1_en,p1_rsEn,p1_secq,p1_ret,p1_repl,p1_lsfwd,
  p2_adata,p2_banks,p2_LSQ,p2_en,p2_rsEn,p2_secq,p2_ret,p2_repl,p2_lsfwd,p2_data,p2_pbit,p2_brdbanks,
  p3_adata,p3_banks,p3_LSQ,p3_en,p3_rsEn,p3_ioEn,p3_io_ack,p3_ret,p3_data,p3_pbit,p3_brdbanks,p3_repl,p3_lsfwd,
  p4_adata,p4_LSQ,p4_en,p4_secq,p4_ret,
  p5_adata,p5_LSQ,p5_en,p5_secq,p5_ret,
  p_bankNone,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  FU0,FU1,FU2,FU3,FU4,FU5,FU6,FU7,FU8,FU9,
  FUN0,FUN1,FUN2,FUN3,FUN4,FUN5,FUN6,FUN7,FUN8,FUN9,
  FUreg3_reg,dc_rdataA,
  msi_exp_addr,msi_en,msi_out_clear,//msi_out_clear=can do msi en
  csrss_en,csrss_addr,csrss_data,
  req_addr,req_tlbAttr,req_tlbEn,
  bus_tlb_data,bus_tlb_en,
  reqBus_en,
  reqBus_addr,
  reqBus_req,
  reqBus_want_excl,
  reqBus_dupl,
  reqBus_io,
  reqBus_sz,
  reqBus_low,
  reqBus_bank0,
  insert_isData,
  insBus_req,
  wr0_hit,
  wr0_addrE,wr0_addrO,
  wr0_banks,
  wr0_begin,wr0_end,
  wr0_bgn_ben,wr0_end_ben,
  wr0_odd,wr0_split,
  wr0_data,
  wr0_pbit,wr0_d128,
  wr1_hit,
  wr1_addrE,wr1_addrO,
  wr1_banks,
  wr1_begin,wr1_end,
  wr1_bgn_ben,wr1_end_ben,
  wr1_odd,wr1_split,
  wr1_data,
  wr1_pbit,wr1_d128,
  wrStall
  );
  parameter [4:0] BUS_ID=5'd0;

  input clk;
  input rst;
  input except;
  input excpt_gate;
  input excpt_in_vm;
  input excpt_in_km;
  input [3:0] rsStall;
  output pause_agu;
  output miss_holds_agu;
  output miss_pause_agu;
  output wt_pause_agu;
  output mOp_write_clear;
  input [64:0] u1_base;
  input [64:0] u1_index;
  input [32:0] u1_const;
  input [3:0]  u1_base_fufwd;
  input [3:0]  u1_base_fuufwd;
  input [3:0]  u1_index_fufwd;
  input [3:0]  u1_index_fuufwd;
  input [12:0] u1_op;
  input [8:0]  u1_reg;
  input [8:0]  u1_LSQ_no;
  input [9:0]  u1_II_no;
  input [5:0]  u1_WQ_no;
  input        u1_lsflag;
  input        u1_clkEn;
  input [3:0]  u1_attr;
  input [64:0] u2_base;
  input [64:0] u2_index;
  input [32:0] u2_const;
  input [3:0]  u2_base_fufwd;
  input [3:0]  u2_base_fuufwd;
  input [3:0]  u2_index_fufwd;
  input [3:0]  u2_index_fuufwd;
  input [12:0] u2_op;
  input [8:0]  u2_reg;
  input [8:0]  u2_LSQ_no;
  input [9:0]  u2_II_no;
  input [5:0]  u2_WQ_no;
  input        u2_lsflag;
  input        u2_clkEn;
  input [3:0]  u2_attr;
  input [64:0] u3_base;
  input [64:0] u3_index;
  input [32:0] u3_const;
  input [3:0]  u3_base_fufwd;
  input [3:0]  u3_base_fuufwd;
  input [3:0]  u3_index_fufwd;
  input [3:0]  u3_index_fuufwd;
  input [12:0] u3_op;
  input [8:0]  u3_reg;
  input [8:0]  u3_LSQ_no;
  input [9:0]  u3_II_no;
  input [5:0]  u3_WQ_no;
  input        u3_lsflag;
  input        u3_clkEn;
  input [3:0]  u3_attr;
  input [64:0] u4_base;
  input [64:0] u4_index;
  input [32:0] u4_const;
  input [3:0]  u4_base_fufwd;
  input [3:0]  u4_base_fuufwd;
  input [3:0]  u4_index_fufwd;
  input [3:0]  u4_index_fuufwd;
  input [12:0] u4_op;
  input [8:0]  u4_reg;
  input [8:0]  u4_LSQ_no;
  input [9:0]  u4_II_no;
  input [5:0]  u4_WQ_no;
  input        u4_lsflag;
  input        u4_clkEn;
  input [3:0]  u4_attr;
  input [64:0] u5_base;
  input [64:0] u5_index;
  input [32:0] u5_const;
  input [3:0]  u5_base_fufwd;
  input [3:0]  u5_base_fuufwd;
  input [3:0]  u5_index_fufwd;
  input [3:0]  u5_index_fuufwd;
  input [12:0] u5_op;
  input [8:0]  u5_reg;
  input [8:0]  u5_LSQ_no;
  input [9:0]  u5_II_no;
  input [5:0]  u5_WQ_no;
  input        u5_lsflag;
  input        u5_clkEn;
  input [3:0]  u5_attr;
  input [1:0] mOp0_clHit;
  input [1:0] mOp1_clHit;
  input [1:0] mOp2_clHit;
  input [1:0] mOp3_clHit;

  input miss4;
  input        mOpY4_en;
  input        mOpY4_hit;
  input [1:0]  mOpY4_dupl;//write to a non-exclusive cl
  //mOp4_thread,
  input [35:0] mOpY4_addrEven;
  input [35:0] mOpY4_addrOdd;
  input [4:0]  mOpY4_sz;
  input        mOpY4_first;
  input [31:0] mOpY4_banks;
  input [4:0]  mOpY4_bank0;
  input [4:0]  mOpY4_bank1; // end bank
  input [3:0]  mOpY4_bgn_b;
  input [3:0]  mOpY4_end_b;
  input        mOpY4_odd;
  input [1:0]  mOpY4_addr_low;
  input        mOpY4_split;
  input [1:0]  mOpY4_clHit;
  input[159:0] mOpY4_data;
  input [1:0]  mOpY4_type;
  input [9:0]  mOpY4_II;
  input [1:0]  mOpY4_pbit;
  output        mOpY4_en_o;
  //mOp4_thread,
  output [35:0] mOpY4_addrEven_o;
  output [35:0] mOpY4_addrOdd_o;
  output [4:0]  mOpY4_sz_o;
  output        mOpY4_first_o;
  output [31:0] mOpY4_banks_o;
  output [4:0]  mOpY4_bank0_o;
  output [4:0]  mOpY4_bank1_o; // end bank
  output [3:0]  mOpY4_bgn_b_o;
  output [3:0]  mOpY4_end_b_o;
  output        mOpY4_odd_o;
  output [1:0]  mOpY4_addr_low_o;
  output        mOpY4_split_o;
  output[159:0] mOpY4_data_o;
  output[159:0] mOpY4_dataN_o;
  output [1:0]  mOpY4_type_o;
  output [9:0]  mOpY4_II_o;
  output [1:0]  mOpY4_pbit_o;
  input miss5;
  input        mOpY5_en;
  input        mOpY5_hit;
  input [1:0]  mOpY5_dupl;//write to a non-exclusive cl
  //mOp4_thread,
  input [35:0] mOpY5_addrEven;
  input [35:0] mOpY5_addrOdd;
  input [4:0]  mOpY5_sz;
  input        mOpY5_first;
  input [31:0] mOpY5_banks;
  input [4:0]  mOpY5_bank0;
  input [4:0]  mOpY5_bank1; // end bank
  input [3:0]  mOpY5_bgn_b;
  input [3:0]  mOpY5_end_b;
  input        mOpY5_odd;
  input [1:0]  mOpY5_addr_low;
  input        mOpY5_split;
  input [1:0]  mOpY5_clHit;
  input[159:0] mOpY5_data;
  input [1:0]  mOpY5_type;
  input [9:0]  mOpY5_II;
  input [1:0]  mOpY5_pbit;
  output        mOpY5_en_o;
  //mOp4_thread,
  output [35:0] mOpY5_addrEven_o;
  output [35:0] mOpY5_addrOdd_o;
  output [4:0]  mOpY5_sz_o;
  output        mOpY5_first_o;
  output [31:0] mOpY5_banks_o;
  output [4:0]  mOpY5_bank0_o;
  output [4:0]  mOpY5_bank1_o; // end bank
  output [3:0]  mOpY5_bgn_b_o;
  output [3:0]  mOpY5_end_b_o;
  output        mOpY5_odd_o;
  output [1:0]  mOpY5_addr_low_o;
  output        mOpY5_split_o;
  output[159:0] mOpY5_data_o;
  output[159:0] mOpY5_dataN_o;
  output [1:0]  mOpY5_type_o;
  output [9:0]  mOpY5_II_o;
  output [1:0]  mOpY5_pbit_o;
  output [`lsaddr_width-1:0] p0_adata;
  output [31:0]p0_banks;
  output [8:0] p0_LSQ;
  output       p0_en;
  output       p0_rsEn;
  output       p0_secq;
  output [13:0]p0_ret;
  output       p0_repl;
  output       p0_lsfwd;
  output [`lsaddr_width-1:0] p1_adata;
  output [31:0]p1_banks;
  output [8:0] p1_LSQ;
  output       p1_en;
  output       p1_rsEn;
  output       p1_secq;
  output [13:0]p1_ret;
  output       p1_repl;
  output       p1_lsfwd;
  output [`lsaddr_width-1:0] p2_adata;
  output [31:0]p2_banks;
  output [8:0] p2_LSQ;
  output       p2_en;
  output       p2_rsEn;
  output       p2_secq;
  output [13:0]p2_ret;
  output       p2_repl;
  output       p2_lsfwd;
  output[127+8:0]p2_data;
  output [1:0] p2_pbit;
  output [4:0] p2_brdbanks;
  output [`lsaddr_width-1:0] p3_adata;
  output [31:0]p3_banks;
  output [8:0] p3_LSQ;
  output       p3_en;
  output       p3_rsEn;
  output       p3_ioEn;
  input        p3_io_ack;
  output [13:0]p3_ret;
  output[127+8:0]p3_data;
  output [1:0] p3_pbit;
  output [4:0] p3_brdbanks;
  output       p3_repl;
  output       p3_lsfwd;
  output [`lsaddr_width-1:0] p4_adata;
  output [8:0] p4_LSQ;
  output       p4_en;
  output       p4_secq;
  output [13:0]p4_ret;
  output [`lsaddr_width-1:0] p5_adata;
  output [8:0] p5_LSQ;
  output       p5_en;
  output       p5_secq;
  output [13:0]p5_ret;
  output [31:0] p_bankNone;

  input FU0Hit,FU1Hit,FU2Hit,FU3Hit;

  input [64:0] FU0;
  input [64:0] FU1;
  input [64:0] FU2;
  input [64:0] FU3;
  input [64:0] FU4;
  input [64:0] FU5;
  input [64:0] FU6;
  input [64:0] FU7;
  input [64:0] FU8;
  input [64:0] FU9;
  input [64:0] FUN0;
  input [64:0] FUN1;
  input [64:0] FUN2;
  input [64:0] FUN3;
  input [64:0] FUN4;
  input [64:0] FUN5;
  input [64:0] FUN6;
  input [64:0] FUN7;
  input [64:0] FUN8;
  input [64:0] FUN9;
  input [8:0] FUreg3_reg;
  input [127+8:0] dc_rdataA;
  
  input [36:0] msi_exp_addr;
  input        msi_en;
  output       msi_out_clear;

  input csrss_en;
  input [15:0] csrss_addr;
  input [63:0] csrss_data;

  input [30:0] req_addr;
  input [3:0] req_tlbAttr;
  input req_tlbEn;
  output [`ctlbData_width-1:0] bus_tlb_data;
  output bus_tlb_en;
  
  output reg reqBus_en;
  output reg [43:7] reqBus_addr;
  output reg [9:0] reqBus_req;
  output reg reqBus_want_excl;
  output reg reqBus_dupl;
  output reg reqBus_io;
  output reg [4:0] reqBus_sz;
  output reg [1:0] reqBus_low;
  output reg [4:0] reqBus_bank0;
  
  input insert_isData;
  input [9:0] insBus_req;

  output [1:0] wr0_hit;
  output [35:0] wr0_addrE;
  output [35:0] wr0_addrO;
  output [31:0] wr0_banks;
  output [4:0] wr0_begin;
  output [4:0] wr0_end;
  output [3:0] wr0_bgn_ben;
  output [3:0] wr0_end_ben;
  output wr0_odd,wr0_split;
  output [159:0] wr0_data;
  output [1:0] wr0_pbit;
  output wr0_d128;
  output [1:0] wr1_hit;
  output [35:0] wr1_addrE;
  output [35:0] wr1_addrO;
  output [31:0] wr1_banks;
  output [4:0] wr1_begin;
  output [4:0] wr1_end;
  output [3:0] wr1_bgn_ben;
  output [3:0] wr1_end_ben;
  output [159:0] wr1_data;
  output [1:0] wr1_pbit;
  output wr1_d128;
  output wr1_odd,wr1_split;
  input wrStall;
  
  function get_d128;
      input [4:0] msz;
      get_d128=msz==5'h1 || msz==5'h2 || msz==5'h0 || msz==5'ha || msz==5'hc || msz==5'hB || msz==5'hf;
  endfunction
  
  wire csrss_thread=1'b0;

  reg [64:0] FU0_reg;
  reg [64:0] FU1_reg;
  reg [64:0] FU2_reg;
  reg [64:0] FU3_reg;
  reg [64:0] FU4_reg;
  reg [64:0] FU5_reg;
  reg [64:0] FU6_reg;
  reg [64:0] FU7_reg;
  reg [64:0] FU8_reg;
  reg [64:0] FU9_reg;
  
  reg bus_holds_agu;
  reg bus_holds_agu_reg;

  wire [64:0] uu_base1;
  wire [64:0] uu_index1;
  wire [64:0] uu_base2;
  wire [64:0] uu_index2;
  wire [64:0] uu_base3;
  wire [64:0] uu_index3;
  wire [64:0] uu_base4;
  wire [64:0] uu_index4;
  wire [64:0] uu_base5;
  wire [64:0] uu_index5;
 
  wire [3:0] u1_sh;
  wire [3:0] u2_sh;
  wire [3:0] u3_sh;
  wire [3:0] u4_sh;
  wire [3:0] u5_sh;
  
  wire [50:0] tlb_addr;
  wire tlb_wen;
  wire tlb_2M;
  wire [`dtlbData_width-1:0] tlb_data0;
  wire [`dtlbData_width-1:0] tlb_data1;
  wire [`dtlbData_width-1:0] tlb_data2;
  wire [2:0] tlb_frc_way;
  wire tlb_frc_en;

  wire [31:0] mOp_noBanks;
  wire [31:0] mOp_noBanks_o;
  
  wire rec_lsflag;
  wire [43:0] rec_addr;
  wire [35:0] rec_addrE;
  wire [35:0] rec_addrO;
  wire rec_lsfwd;
  wire rec_odd;
  wire [1:0] rec_addr_low;
  wire [8:0] rec_register;
  wire [4:0] rec_size;
  wire rec_invtlb;
  wire rec_split;
  wire rec_en;
  wire [4:0] rec_beginA;
  wire [8:0] rec_LSQ;
  wire [9:0] rec_II;
  wire [5:0] rec_WQ;
  wire [1:0] rec_type;
  wire [4:0] rec_brdbnk;
  wire [127+8:0] rec_data;
  wire rec_stall;
  wire rec_tlb_miss;
  wire [3:0] rec_attr;
  wire [1:0] rec_pbit;

  wire [63:0] p0_cmplxAddr_d;
  wire [63:0] p1_cmplxAddr_d;
  wire [63:0] p2_cmplxAddr_d;
  wire [63:0] p3_cmplxAddr_d;
  wire [63:0] p4_cmplxAddr_d;
  wire [63:0] p5_cmplxAddr_d;

  reg [63:0] p0_cmplxAddr;
  reg [63:0] p1_cmplxAddr;
  reg [63:0] p2_cmplxAddr;
  reg [63:0] p3_cmplxAddr;
  reg [63:0] p4_cmplxAddr;
  reg [63:0] p5_cmplxAddr;
  
  reg alt_bus_hold_reg;
  reg alt_bus_hold_reg2;
  reg alt_bus_hold_reg3;
  reg alt_bus_hold_reg4;
  reg [36:0] alt_bus_addr_reg;
  wire [36:0] insBus_addr;
  reg  [36:0] insBus_addr_reg;
  reg  [36:0] insBus_addr_reg2;
  reg insert_isData_reg;
  reg insert_isData_reg2;
 
  reg [35:0] mOpY4_addrEven_o_reg;
  reg [35:0] mOpY4_addrOdd_o_reg;
  reg [31:0] mOpY4_banks_o_reg;
  reg [4:0]  mOpY4_bank0_o_reg;
  reg [4:0]  mOpY4_bank1_o_reg;
  reg [3:0]  mOpY4_bgn_b_o_reg;
  reg [3:0]  mOpY4_end_b_o_reg;
  reg        mOpY4_odd_o_reg;
  reg        mOpY4_split_o_reg;
  reg [159:0]mOpY4_data_o_reg;
  reg [1  :0]mOpY4_pbit_o_reg;
  reg        mOpY4_d128_o_reg;

  reg [35:0] mOpY4_addrEven_o_reg2;
  reg [35:0] mOpY4_addrOdd_o_reg2;
  reg [31:0] mOpY4_banks_o_reg2;
  reg [4:0]  mOpY4_bank0_o_reg2;
  reg [4:0]  mOpY4_bank1_o_reg2;
  reg [3:0]  mOpY4_bgn_b_o_reg2;
  reg [3:0]  mOpY4_end_b_o_reg2;
  reg        mOpY4_odd_o_reg2;
  reg        mOpY4_split_o_reg2;
  reg [159:0]mOpY4_data_o_reg2;
  reg [1  :0]mOpY4_pbit_o_reg2;
  reg        mOpY4_d128_o_reg2;
  
  reg [35:0] mOpY4_addrEven_o_reg3;
  reg [35:0] mOpY4_addrOdd_o_reg3;
  reg [31:0] mOpY4_banks_o_reg3;
  reg [4:0]  mOpY4_bank0_o_reg3;
  reg [4:0]  mOpY4_bank1_o_reg3;
  reg [3:0]  mOpY4_bgn_b_o_reg3;
  reg [3:0]  mOpY4_end_b_o_reg3;
  reg        mOpY4_odd_o_reg3;
  reg        mOpY4_split_o_reg3;
  reg [159:0]mOpY4_data_o_reg3;
  reg [1  :0]mOpY4_pbit_o_reg3;
  reg        mOpY4_d128_o_reg3;

  reg [35:0] mOpY5_addrEven_o_reg;
  reg [35:0] mOpY5_addrOdd_o_reg;
  reg [31:0] mOpY5_banks_o_reg;
  reg [4:0]  mOpY5_bank0_o_reg;
  reg [4:0]  mOpY5_bank1_o_reg;
  reg [3:0]  mOpY5_bgn_b_o_reg;
  reg [3:0]  mOpY5_end_b_o_reg;
  reg        mOpY5_odd_o_reg;
  reg        mOpY5_split_o_reg;
  reg [159:0]mOpY5_data_o_reg;
  reg [1  :0]mOpY5_pbit_o_reg;
  reg        mOpY5_d128_o_reg;

  reg [35:0] mOpY5_addrEven_o_reg2;
  reg [35:0] mOpY5_addrOdd_o_reg2;
  reg [31:0] mOpY5_banks_o_reg2;
  reg [4:0]  mOpY5_bank0_o_reg2;
  reg [4:0]  mOpY5_bank1_o_reg2;
  reg [3:0]  mOpY5_bgn_b_o_reg2;
  reg [3:0]  mOpY5_end_b_o_reg2;
  reg        mOpY5_odd_o_reg2;
  reg        mOpY5_split_o_reg2;
  reg [159:0]mOpY5_data_o_reg2;
  reg [1  :0]mOpY5_pbit_o_reg2;
  reg        mOpY5_d128_o_reg2;
  
  reg [35:0] mOpY5_addrEven_o_reg3;
  reg [35:0] mOpY5_addrOdd_o_reg3;
  reg [31:0] mOpY5_banks_o_reg3;
  reg [4:0]  mOpY5_bank0_o_reg3;
  reg [4:0]  mOpY5_bank1_o_reg3;
  reg [3:0]  mOpY5_bgn_b_o_reg3;
  reg [3:0]  mOpY5_end_b_o_reg3;
  reg        mOpY5_odd_o_reg3;
  reg        mOpY5_split_o_reg3;
  reg [159:0]mOpY5_data_o_reg3;
  reg [1  :0]mOpY5_pbit_o_reg3;
  reg        mOpY5_d128_o_reg3;

  wire alt_bus_hold;
  wire [36:0] alt_bus_addr;



//  wire wt_pause_agu;
  reg  wt_pause_agu_reg;

  wire miss0,miss1,miss2,miss3;

  reg miss_holds_agu_reg;
  reg miss_holds_agu_reg2;
  reg bus_holds_agu_reg2;
  reg bus_holds_agu_reg3;
  reg bus_holds_agu_reg4;
  reg bus_holds_agu_reg5;
  wire miss_next;
  wire mcam_replay;
  wire miss_unlock;
  wire [1:0] miss_clDo;
  wire now_flushing;
  reg  now_flushing_reg;

  reg miss_doneEven,miss_doneOdd;

  wire [44-8:0] mcam_addr;
  reg [44-8:0] mcam_addr_reg;
  wire [3:0] mcam_req;
  wire mcam_hasfree;
  wire mcam_dupl;
  wire mcam_locked;
  wire mcam_do_req;
  wire mcam_st;
  wire mcam_cldupl;
  wire [4:0] mcam_sz;
  wire [4:0] mcam_bank0;
  wire [1:0] mcam_low;
  wire mcam_io;
  reg mcam_st_reg;
  reg mcam_cldupl_reg;
  reg [4:0] mcam_sz_reg;
  reg [4:0] mcam_bank0_reg;
  reg [1:0] mcam_low_reg;
  reg mcam_io_reg;

  wire Em_tlb_req_en;
  wire [43-14:0] Em_tlb_req_addr;
  wire [3:0] Em_tlb_req_attr;
  wire Em_tlb_req_ack;
  
  reg [`lsfxdata_width-1:0] lso_xdataA_reg;
  
  wire mOpR_en;
  wire [3:0] mOpR_req;
  reg mOpR_en_reg;
  wire [36:0] mOpR_addr;
  wire [4:0]  mOpR_sz;
  wire mOpR_st;
//  mOpR_first,
//  mOpR_banks,
  wire [4:0] mOpR_bank0;
  wire mOpR_io;//???
  wire mOpR_odd;
  wire [1:0] mOpR_addr_low;
  wire mOpR_split;
  wire mOpR_dupl;
  wire mOpR_stall;
 
  wire p0_conflict;
  wire p1_conflict;
  wire p2_conflict;
  wire p3_conflict;
  wire p4_conflict;
  wire p5_conflict;

  wire p0_sec_in,p1_sec_in,p2_sec_in,p3_sec_in;
  wire p4_sec_in,p5_sec_in;
  wire p0_ndiff,p1_ndiff,p2_ndiff,p3_ndiff;
  wire p4_ndiff,p5_ndiff;
  wire p4_ptrdiff=1'b0,p5_ptrdiff=1'b0;
  wire p4_ptrdiff_reg=1'b0,p5_ptrdiff_reg=1'b0;
  reg p0_sec_in_reg,p1_sec_in_reg,p2_sec_in_reg,p3_sec_in_reg;
  reg p4_sec_in_reg,p5_sec_in_reg;
  reg p0_ndiff_reg,p1_ndiff_reg,p2_ndiff_reg,p3_ndiff_reg;
  reg p4_ndiff_reg,p5_ndiff_reg;
 
  wire other_flip;

  reg p0_conflict_reg;
  reg p1_conflict_reg;
  reg p2_conflict_reg;
  reg p0_conflict_reg2;
  reg p1_conflict_reg2;
  reg p2_conflict_reg2;
  
  reg [`lsaddr_width-1:0] p0_adata_reg;
  reg [`lsaddr_width-1:0] p1_adata_reg;
  reg [`lsaddr_width-1:0] p2_adata_reg;
  reg [`lsaddr_width-1:0] p3_adata_reg;
  reg p0_en_reg;
  reg p1_en_reg;
  reg p2_en_reg;
  reg p3_en_reg;

  wire p0_tlbmiss;
  wire p1_tlbmiss;
  wire p2_tlbmiss;
  wire p3_tlbmiss;
  wire p4_tlbmiss;
  wire p5_tlbmiss;

  reg p0_tlbmiss_reg;
  reg p1_tlbmiss_reg;
  reg p2_tlbmiss_reg;
  reg p3_tlbmiss_reg;
  reg p4_tlbmiss_reg;
  reg p5_tlbmiss_reg;

  wire p0_pageFault;
  wire p1_pageFault;
  wire p2_pageFault;
  wire p3_pageFault;
  wire p4_pageFault;
  wire p5_pageFault;

  wire [7:0] p0_faultCode;
  wire [7:0] p1_faultCode;
  wire [7:0] p2_faultCode;
  wire [7:0] p3_faultCode;
  wire [7:0] p4_faultCode;
  wire [7:0] p5_faultCode;
  
  wire [8:0] p0_faultNo;
  wire [8:0] p1_faultNo;
  wire [8:0] p2_faultNo;
  wire [8:0] p3_faultNo;
  wire [8:0] p4_faultNo;
  wire [8:0] p5_faultNo;
  
  wire        p4_mex_en;
  wire [3:0]  p4_mex_attr;
  wire [43:0] p4_mex_addr;
  wire        p5_mex_en;
  wire [3:0]  p5_mex_attr;
  wire [43:0] p5_mex_addr;
  wire [4:0]  p4_mex_sz;
  wire [4:0]  p5_mex_sz;
  reg        p4_mex_en_reg;
  reg        p5_mex_en_reg;

  reg        u1_clkEn_reg;
  reg [12:0] u1_op_reg;
  reg [3:0]  u1_sh_reg;
  reg [8:0]  u1_reg_reg;
  reg [8:0]  u1_LSQ_no_reg;
  reg [9:0]  u1_II_no_reg;
  reg [5:0]  u1_WQ_no_reg;
  reg        u1_lsflag_reg;
  reg [63:0] u1_const_reg;
  reg [3:0]  u1_attr_reg;

  reg        u2_clkEn_reg;
  reg [12:0] u2_op_reg;
  reg [3:0]  u2_sh_reg;
  reg [8:0]  u2_reg_reg;
  reg [8:0]  u2_LSQ_no_reg;
  reg [9:0]  u2_II_no_reg;
  reg [5:0]  u2_WQ_no_reg;
  reg        u2_lsflag_reg;
  reg [63:0] u2_const_reg;
  reg [3:0]  u2_attr_reg;
  
  reg        u3_clkEn_reg;
  reg [12:0] u3_op_reg;
  reg [3:0]  u3_sh_reg;
  reg [8:0]  u3_reg_reg;
  reg [8:0]  u3_LSQ_no_reg;
  reg [9:0]  u3_II_no_reg;
  reg [5:0]  u3_WQ_no_reg;
  reg        u3_lsflag_reg;
  reg [63:0] u3_const_reg;
  reg [3:0]  u3_attr_reg;
  
  reg        u4_clkEn_reg;
  reg [12:0] u4_op_reg;
  reg [3:0]  u4_sh_reg;
  reg [8:0]  u4_reg_reg;
  reg [8:0]  u4_LSQ_no_reg;
  reg [9:0]  u4_II_no_reg;
  reg [5:0]  u4_WQ_no_reg;
  reg        u4_lsflag_reg;
  reg [63:0] u4_const_reg;
  reg [3:0]  u4_attr_reg;
  
  reg        u5_clkEn_reg;
  reg [12:0] u5_op_reg;
  reg [3:0]  u5_sh_reg;
  reg [8:0]  u5_reg_reg;
  reg [8:0]  u5_LSQ_no_reg;
  reg [9:0]  u5_II_no_reg;
  reg [5:0]  u5_WQ_no_reg;
  reg        u5_lsflag_reg;
  reg [63:0] u5_const_reg;
  reg [3:0]  u5_attr_reg;
  
  reg        u1_clkEn_reg2;
  reg [12:0] u1_op_reg2;
  reg [3:0]  u1_sh_reg2;
  reg [8:0]  u1_reg_reg2;
  reg [8:0]  u1_LSQ_no_reg2;
  reg [9:0]  u1_II_no_reg2;
  reg [5:0]  u1_WQ_no_reg2;
  reg        u1_lsflag_reg2;

  reg        u2_clkEn_reg2;
  reg [12:0] u2_op_reg2;
  reg [3:0]  u2_sh_reg2;
  reg [8:0]  u2_reg_reg2;
  reg [8:0]  u2_LSQ_no_reg2;
  reg [9:0]  u2_II_no_reg2;
  reg [5:0]  u2_WQ_no_reg2;
  reg        u2_lsflag_reg2;
  
  reg        u3_clkEn_reg2;
  reg [12:0] u3_op_reg2;
  reg [3:0]  u3_sh_reg2;
  reg [8:0]  u3_reg_reg2;
  reg [8:0]  u3_LSQ_no_reg2;
  reg [9:0]  u3_II_no_reg2;
  reg [5:0]  u3_WQ_no_reg2;
  reg        u3_lsflag_reg2;
  
  reg        u4_clkEn_reg2;
  reg [12:0] u4_op_reg2;
  reg [3:0]  u4_sh_reg2;
  reg [8:0]  u4_reg_reg2;
  reg [8:0]  u4_LSQ_no_reg2;
  reg [9:0]  u4_II_no_reg2;
  reg [5:0]  u4_WQ_no_reg2;
  reg        u4_lsflag_reg2;
  
  reg        u5_clkEn_reg2;
  reg [12:0] u5_op_reg2;
  reg [3:0]  u5_sh_reg2;
  reg [8:0]  u5_reg_reg2;
  reg [8:0]  u5_LSQ_no_reg2;
  reg [9:0]  u5_II_no_reg2;
  reg [5:0]  u5_WQ_no_reg2;
  reg        u5_lsflag_reg2;
  
  wire        mOpX0_en;
  wire        mOpX0_thread;
  wire [35:0] mOpX0_addrEven;
  wire [35:0] mOpX0_addrOdd;
  wire [4:0]  mOpX0_sz;
  wire        mOpX0_st;
  wire [31:0] mOpX0_banks;
  wire [4:0]  mOpX0_bank0;
  wire        mOpX0_odd;
  wire [1:0]  mOpX0_low;
  wire        mOpX0_split;
  wire [8:0]  mOpX0_register;
  wire [1:0]  mOpX0_type;
  wire [8:0]  mOpX0_LSQ;
  wire [9:0]  mOpX0_II;
  wire [5:0]  mOpX0_WQ;
  wire        mOpX0_lsflag;
  wire        mOpX0_lsfwd;
  wire [3:0]  mOpX0_attr;
  reg mOpX0_lsflag_reg, mOpX0_lsflag_reg2, mOpX0_lsflag_reg3;
  reg mOpX0_en_reg,     mOpX0_en_reg2,     mOpX0_en_reg3;
  reg mOp0_rsEn_reg,mOp1_rsEn_reg,mOp2_rsEn_reg,mOp3_rsEn_reg;
  reg [1:0] mOpX0_type_reg;
  reg [1:0] mOpX0_type_reg2;
  reg [1:0] mOpX0_type_reg3;
  reg        mOp0_sec_reg2;
  reg        mOp0_sec_reg3;
  
  reg [35:0] mOpX0_addrEven_reg;
  reg [35:0] mOpX0_addrOdd_reg;
  reg [4:0]  mOpX0_sz_reg;
  reg        mOp0_sec_reg;
  reg [31:0] mOpX0_banks_reg;
  reg [4:0]  mOpX0_bank0_reg;
  reg        mOpX0_odd_reg;
  reg [1:0]  mOpX0_low_reg;
  reg        mOpX0_split_reg;
  reg [8:0]  mOpX0_register_reg;
  reg [8:0]  mOpX0_LSQ_reg;
  reg [9:0]  mOpX0_II_reg;
  reg [5:0]  mOpX0_WQ_reg;

  wire        mOp0_en,mOp0_sec;
  wire [43:0] mOp0_addrMain;
  wire [35:0] mOp0_addrEven;
  wire [35:0] mOp0_addrOdd;
  wire [4:0]  mOp0_sz;
  wire        mOp0_invtlb;
  wire [31:0] mOp0_banks;
  wire [4:0]  mOp0_bank0;
  wire        mOp0_odd;
  wire [1:0]  mOp0_low;
  wire        mOp0_split;
  wire [8:0]  mOp0_register;
  wire [1:0]  mOp0_type;
  wire [8:0]  mOp0_LSQ;
  wire [9:0]  mOp0_II;
  wire [5:0]  mOp0_WQ;
  wire        mOp0_lsflag;
  wire [3:0]  mOp0_attr;
  reg        mOpX0_lsfwd_reg;

  wire        mOpX1_en;
  wire        mOpX1_thread;
  wire [35:0] mOpX1_addrEven;
  wire [35:0] mOpX1_addrOdd;
  wire [4:0]  mOpX1_sz;
  wire        mOpX1_invtlb;
  wire [31:0] mOpX1_banks;
  wire [4:0]  mOpX1_bank0;
  wire        mOpX1_odd;
  wire [1:0]  mOpX1_low;
  wire        mOpX1_split;
  wire [8:0]  mOpX1_register;
  wire [1:0]  mOpX1_type;
  wire [8:0]  mOpX1_LSQ;
  wire [9:0]  mOpX1_II;
  wire [5:0]  mOpX1_WQ;
  wire        mOpX1_lsflag;
  wire        mOpX1_lsfwd;
  wire [3:0]  mOpX1_attr;
  reg mOpX1_lsflag_reg, mOpX1_lsflag_reg2, mOpX1_lsflag_reg3;
  reg mOpX1_en_reg,     mOpX1_en_reg2,     mOpX1_en_reg3;
  reg [1:0] mOpX1_type_reg;
  reg [1:0] mOpX1_type_reg2;
  reg [1:0] mOpX1_type_reg3;
  reg [35:0] mOpX1_addrEven_reg;
  reg [35:0] mOpX1_addrOdd_reg;
  reg [4:0]  mOpX1_sz_reg;
  reg        mOp1_sec_reg;
  reg [31:0] mOpX1_banks_reg;
  reg [4:0]  mOpX1_bank0_reg;
  reg        mOpX1_odd_reg;
  reg [1:0]  mOpX1_low_reg;
  reg        mOpX1_split_reg;
  reg [8:0]  mOpX1_register_reg;
  reg [8:0]  mOpX1_LSQ_reg;
  reg [9:0]  mOpX1_II_reg;
  reg [5:0]  mOpX1_WQ_reg;
  reg        mOp1_sec_reg2;
  reg        mOp1_sec_reg3;
  
  wire        mOp1_en,mOp1_sec;
  wire [43:0] mOp1_addrMain;
  wire [35:0] mOp1_addrEven;
  wire [35:0] mOp1_addrOdd;
  wire [4:0]  mOp1_sz;
  wire        mOp1_invtlb;
  wire [31:0] mOp1_banks;
  wire [4:0]  mOp1_bank0;
  wire        mOp1_odd;
  wire [1:0]  mOp1_low;
  wire        mOp1_split;
  wire [8:0]  mOp1_register;
  wire [1:0]  mOp1_type;
  wire [8:0]  mOp1_LSQ;
  wire [9:0]  mOp1_II;
  wire [5:0]  mOp1_WQ;
  wire        mOp1_lsflag;
  wire [3:0]  mOp1_attr;
  reg        mOpX1_lsfwd_reg;

  wire        mOpX2_en;
  wire        mOpX2_thread;
  wire [35:0] mOpX2_addrEven;
  wire [35:0] mOpX2_addrOdd;
  wire [4:0]  mOpX2_sz;
  wire        mOpX2_invtlb;
  wire [31:0] mOpX2_banks;
  wire [4:0]  mOpX2_bank0;
  wire        mOpX2_odd;
  wire [1:0]  mOpX2_low;
  wire        mOpX2_split;
  wire [8:0]  mOpX2_register;
  wire [1:0]  mOpX2_type;
  wire [8:0]  mOpX2_LSQ;
  wire [9:0]  mOpX2_II;
  wire [5:0]  mOpX2_WQ;
  wire        mOpX2_lsflag;
  wire        mOpX2_lsfwd;
  wire [3:0]  mOpX2_attr;
  reg mOpX2_lsflag_reg, mOpX2_lsflag_reg2, mOpX2_lsflag_reg3;
  reg mOpX2_en_reg,     mOpX2_en_reg2,     mOpX2_en_reg3;
  reg [1:0] mOpX2_type_reg;
  reg [1:0] mOpX2_type_reg2;
  reg [1:0] mOpX2_type_reg3;
  reg [35:0] mOpX2_addrEven_reg;
  reg [35:0] mOpX2_addrOdd_reg;
  reg [4:0]  mOpX2_sz_reg;
  reg        mOp2_sec_reg;
  reg [31:0] mOpX2_banks_reg;
  reg [4:0]  mOpX2_bank0_reg;
  reg        mOpX2_odd_reg;
  reg [1:0]  mOpX2_low_reg;
  reg        mOpX2_split_reg;
  reg [8:0]  mOpX2_register_reg;
  reg [8:0]  mOpX2_LSQ_reg;
  reg [9:0]  mOpX2_II_reg;
  reg [5:0]  mOpX2_WQ_reg;
  reg        mOp2_sec_reg2;
  reg        mOp2_sec_reg3;
  
  wire        mOp2_en,mOp2_sec;
  wire [43:0] mOp2_addrMain;
  wire [35:0] mOp2_addrEven;
  wire [35:0] mOp2_addrOdd;
  wire [4:0]  mOp2_sz;
  wire        mOp2_invtlb;
  wire [31:0] mOp2_banks;
  wire [4:0]  mOp2_bank0;
  wire        mOp2_odd;
  wire [1:0]  mOp2_low;
  wire        mOp2_split;
  wire [8:0]  mOp2_register;
  wire [1:0]  mOp2_type;
  wire [8:0]  mOp2_LSQ;
  wire [9:0]  mOp2_II;
  wire [5:0]  mOp2_WQ;
  wire        mOp2_lsflag;
  wire [3:0]  mOp2_attr;
  reg        mOpX2_lsfwd_reg;

  wire        mOpX3_en;
  wire        mOpX3_thread;
  wire [35:0] mOpX3_addrEven;
  wire [35:0] mOpX3_addrOdd;
  wire [4:0]  mOpX3_sz;
  wire        mOpX3_invtlb;
  wire [31:0] mOpX3_banks;
  wire [4:0]  mOpX3_bank0;
  wire        mOpX3_odd;
  wire [1:0]  mOpX3_low;
  wire        mOpX3_split;
  wire [8:0]  mOpX3_register;
  wire [1:0]  mOpX3_type;
  wire [8:0]  mOpX3_LSQ;
  wire [9:0]  mOpX3_II;
  wire [5:0]  mOpX3_WQ;
  wire        mOpX3_lsflag;
  wire [3:0]  mOpX3_attr;
  reg mOpX3_lsflag_reg, mOpX3_lsflag_reg2, mOpX3_lsflag_reg3;
  reg mOpX3_en_reg,     mOpX3_en_reg2,     mOpX3_en_reg3;
  reg [1:0] mOpX3_type_reg;
  reg [1:0] mOpX3_type_reg2;
  reg [1:0] mOpX3_type_reg3;
  wire        mOpX3_lsfwd;//needs to go to io
  reg        mOpX3_lsfwd_reg;
  reg [35:0] mOpX3_addrEven_reg;
  reg [35:0] mOpX3_addrOdd_reg;
  reg [4:0]  mOpX3_sz_reg;
  reg        mOpX3_invtlb_reg;
  reg [31:0] mOpX3_banks_reg;
  reg [4:0]  mOpX3_bank0_reg;
  reg        mOpX3_odd_reg;
  reg [1:0]  mOpX3_low_reg;
  reg        mOpX3_split_reg;
  reg [8:0]  mOpX3_register_reg;
  reg [8:0]  mOpX3_register_reg2;
  reg [8:0]  mOpX3_register_reg3;
  reg [8:0]  mOpX3_LSQ_reg;
  reg [9:0]  mOpX3_II_reg;
  reg [5:0]  mOpX3_WQ_reg;
  
  wire        mOp3_en,mOp3_sec;
  wire [43:0] mOp3_addrMain;
  wire [35:0] mOp3_addrEven;
  wire [35:0] mOp3_addrOdd;
  wire [4:0]  mOp3_sz;
  wire        mOp3_invtlb;
  wire [31:0] mOp3_banks;
  wire [4:0]  mOp3_bank0;
  wire        mOp3_odd;
  wire [1:0]  mOp3_low;
  wire        mOp3_split;
  wire [8:0]  mOp3_register;
  wire [1:0]  mOp3_type;
  wire [8:0]  mOp3_LSQ;
  wire [9:0]  mOp3_II;
  wire [5:0]  mOp3_WQ;
  wire        mOp3_lsflag;
  wire        mOp3_lsfwd;
  wire [3:0]  mOp3_attr;

  wire        mOpX4_en;
  wire        mOpX4_thread;
  wire [35:0] mOpX4_addrEven;
  wire [35:0] mOpX4_addrOdd;
  wire [4:0]  mOpX4_sz;
 // wire        mOp4_sec;
  wire [31:0] mOpX4_banks;
  wire [4:0]  mOpX4_bank0;
  wire        mOpX4_odd;
  wire [1:0]  mOpX4_low;
  wire        mOpX4_split;
  wire [8:0]  mOpX4_register;
  wire [1:0]  mOpX4_type;
  wire [8:0]  mOpX4_LSQ;
  wire [9:0]  mOpX4_II;
  wire [5:0]  mOpX4_WQ;
  wire        mOpX4_lsflag;
  wire [3:0]  mOpX4_attr;
  reg        mOpX4_en_reg;
  reg        mOpX4_thread_reg;
  reg [35:0] mOpX4_addrEven_reg;
  reg [35:0] mOpX4_addrOdd_reg;
  reg [4:0]  mOpX4_sz_reg;
  reg        mOpX4_st_reg;
  reg        mOp4_sec_reg;
  reg [31:0] mOpX4_banks_reg;
  reg [4:0]  mOpX4_bank0_reg;
  reg        mOpX4_odd_reg;
  reg [1:0]  mOpX4_low_reg;
  reg        mOpX4_split_reg;
  reg [8:0]  mOpX4_register_reg;
  reg [1:0]  mOpX4_type_reg;
  reg [8:0]  mOpX4_LSQ_reg;
  reg [9:0]  mOpX4_II_reg;
  reg [5:0]  mOpX4_WQ_reg;
  reg        mOpX4_lsflag_reg;
  
  
  wire        mOp4_en,mOp4_sec,mOp4_ptrdiff;
  wire [43:0] mOp4_addrMain;
  wire [35:0] mOp4_addrEven;
  wire [35:0] mOp4_addrOdd;
  wire [4:0]  mOp4_sz;
  wire        mOp4_st;
  wire [31:0] mOp4_banks;
  wire [4:0]  mOp4_bank0;
  wire        mOp4_odd;
  wire [1:0]  mOp4_low;
  wire        mOp4_split;
  wire [8:0]  mOp4_register;
  wire [1:0]  mOp4_type;
  wire [8:0]  mOp4_LSQ;
  wire [9:0]  mOp4_II;
  wire [5:0]  mOp4_WQ;
  wire        mOp4_lsflag;
  wire [3:0]  mOp4_attr;

  wire        mOpX5_en;
  wire        mOpX5_thread;
  wire [35:0] mOpX5_addrEven;
  wire [35:0] mOpX5_addrOdd;
  wire [4:0]  mOpX5_sz;
  wire        mOpX5_st;
  wire [31:0] mOpX5_banks;
  wire [4:0]  mOpX5_bank0;
  wire        mOpX5_odd;
  wire [1:0]  mOpX5_low;
  wire        mOpX5_split;
  wire [8:0]  mOpX5_register;
  wire [1:0]  mOpX5_type;
  wire [8:0]  mOpX5_LSQ;
  wire [9:0]  mOpX5_II;
  wire [5:0]  mOpX5_WQ;
  wire        mOpX5_lsflag;
  wire [3:0]  mOpX5_attr;
  reg        mOpX5_en_reg;
  reg [35:0] mOpX5_addrEven_reg;
  reg [35:0] mOpX5_addrOdd_reg;
  reg [4:0]  mOpX5_sz_reg;
  reg        mOp5_sec_reg;
  reg [31:0] mOpX5_banks_reg;
  reg [4:0]  mOpX5_bank0_reg;
  reg        mOpX5_odd_reg;
  reg [1:0]  mOpX5_low_reg;
  reg        mOpX5_split_reg;
  reg [8:0]  mOpX5_register_reg;
  reg [1:0]  mOpX5_type_reg;
  reg [8:0]  mOpX5_LSQ_reg;
  reg [9:0]  mOpX5_II_reg;
  reg [5:0]  mOpX5_WQ_reg;
  reg        mOpX5_lsflag_reg;
  
  wire        mOp5_en,mOp5_sec,mOp5_ptrdiff;
  wire [43:0] mOp5_addrMain;
  wire [35:0] mOp5_addrEven;
  wire [35:0] mOp5_addrOdd;
  wire [4:0]  mOp5_sz;
  wire        mOp5_st;
  wire [31:0] mOp5_banks;
  wire [4:0]  mOp5_bank0;
  wire        mOp5_odd;
  wire [1:0]  mOp5_low;
  wire        mOp5_split;
  wire [8:0]  mOp5_register;
  wire [1:0]  mOp5_type;
  wire [8:0]  mOp5_LSQ;
  wire [9:0]  mOp5_II;
  wire [5:0]  mOp5_WQ;
  wire        mOp5_lsflag;
  wire [3:0]  mOp5_attr;


  wire mOp4_rsEn;
  wire mOp5_rsEn;


  wire        mOp0_rsEn;
  wire [31:0] mOp0_rsBanks;
  wire        mOp1_rsEn;
  wire [31:0] mOp1_rsBanks;
  wire        mOp2_rsEn;
  wire [31:0] mOp2_rsBanks;
  wire mOp3_rsEn;
  wire [4:0] mOp3_brdread;
  wire [127+8:0] mOp3_data;
  wire [1:0]   mOp3_pbit;
  wire [4:0] mOpX3_brdread;
  wire [127+8:0] mOpX3_data;
  wire [1:0] mOpX3_pbit;
  wire [4:0] mOpX2_brdread;
  wire [127+8:0] mOpX2_data;
  wire [1:0] mOpX2_pbit;
  reg [4:0] mOpX3_brdread_reg;
  reg [127+8:0] mOpX3_data_reg;
  reg [4:0] mOpX2_brdread_reg;
  reg [127+8:0] mOpX2_data_reg;
  reg [1:0] mOpX2_pbit_reg;
  reg [1:0] mOpX3_pbit_reg;

  reg all_clear,all_clear_pre;

  function [3:0] get_byte_mod4;
      input [1:0] addr_low;
      input [4:0] sz;
      begin
          get_byte_mod4=4'b0;
          if (sz!=5'd16 && sz!=5'd17) get_byte_mod4=4'hf;
          else begin
              get_byte_mod4[addr_low]=1'b1;
              if (sz==5'd17) get_byte_mod4=get_byte_mod4|{get_byte_mod4[2:0],get_byte_mod4[3]};
          end
      end
  endfunction

  rs_write_forward #(65) nxtBase1(
  clk,rst,
  ~u1_clkEn|(rsStall[0]&~now_flushing&~alt_bus_hold_reg),
  u1_base,uu_base1,
  u1_base_fufwd,u1_base_fuufwd,
  FUN0,FUN1,FUN2,FUN3,FUN4,
  FUN5,FUN6,FUN7,FUN8,FUN9,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(65) nxtIndex1(
  clk,rst,
  ~u1_clkEn|(rsStall[0]&~now_flushing&~alt_bus_hold_reg),
  u1_index,uu_index1,
  u1_index_fufwd,u1_index_fuufwd,
  FUN0,FUN1,FUN2,FUN3,FUN4,
  FUN5,FUN6,FUN7,FUN8,FUN9,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(65) nxtBase2(
  clk,rst,
  ~u2_clkEn|(rsStall[1]&~now_flushing&~alt_bus_hold_reg),
  u2_base,uu_base2,
  u2_base_fufwd,u2_base_fuufwd,
  FUN0,FUN1,FUN2,FUN3,FUN4,
  FUN5,FUN6,FUN7,FUN8,FUN9,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(65) nxtIndex2(
  clk,rst,
  ~u2_clkEn|(rsStall[1]&~now_flushing&~alt_bus_hold_reg),
  u2_index,uu_index2,
  u2_index_fufwd,u2_index_fuufwd,
  FUN0,FUN1,FUN2,FUN3,FUN4,
  FUN5,FUN6,FUN7,FUN8,FUN9,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  
  rs_write_forward #(65) nxtBase3(
  clk,rst,
  ~u3_clkEn|(rsStall[2]&~now_flushing&~alt_bus_hold_reg),
  u3_base,uu_base3,
  u3_base_fufwd,u3_base_fuufwd,
  FUN0,FUN1,FUN2,FUN3,FUN4,
  FUN5,FUN6,FUN7,FUN8,FUN9,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(65) nxtIndex3(
  clk,rst,
  ~u3_clkEn|(rsStall[2]&~now_flushing&~alt_bus_hold_reg),
  u3_index,uu_index3,
  u3_index_fufwd,u3_index_fuufwd,
  FUN0,FUN1,FUN2,FUN3,FUN4,
  FUN5,FUN6,FUN7,FUN8,FUN9,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  
  rs_write_forward #(65) nxtBase4(
  clk,rst,
  ~u4_clkEn,
  u4_base,uu_base4,
  u4_base_fufwd,u4_base_fuufwd,
  FUN0,FUN1,FUN2,FUN3,FUN4,
  FUN5,FUN6,FUN7,FUN8,FUN9,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(65) nxtIndex4(
  clk,rst,
  ~u4_clkEn,
  u4_index,uu_index4,
  u4_index_fufwd,u4_index_fuufwd,
  FUN0,FUN1,FUN2,FUN3,FUN4,
  FUN5,FUN6,FUN7,FUN8,FUN9,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  
  rs_write_forward #(65) nxtBase5(
  clk,rst,
  ~u5_clkEn,
  u5_base,uu_base5,
  u5_base_fufwd,u5_base_fuufwd,
  FUN0,FUN1,FUN2,FUN3,FUN4,
  FUN5,FUN6,FUN7,FUN8,FUN9,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  rs_write_forward #(65) nxtIndex5(
  clk,rst,
  ~u5_clkEn,
  u5_index,uu_index5,
  u5_index_fufwd,u5_index_fuufwd,
  FUN0,FUN1,FUN2,FUN3,FUN4,
  FUN5,FUN6,FUN7,FUN8,FUN9,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  
  agu_get_shiftSize sh1(u1_op,u1_sh); 
  agu_get_shiftSize sh2(u2_op,u2_sh); 
  agu_get_shiftSize sh3(u3_op,u3_sh); 
  agu_get_shiftSize sh4(u4_op,u4_sh); 
  agu_get_shiftSize sh5(u5_op,u5_sh); 
 
  add_agu aadd1(uu_base1,u1_const_reg,uu_index1,p0_cmplxAddr_d,p0_sec_in,
    p0_ndiff,1'b1,u1_sh_reg);
  add_agu aadd2(uu_base2,u2_const_reg,uu_index2,p1_cmplxAddr_d,p1_sec_in,
    p1_ndiff,1'b1,u2_sh_reg);
  add_agu aadd3(uu_base3,u3_const_reg,uu_index3,p2_cmplxAddr_d,p2_sec_in,
    p2_ndiff,1'b1,u3_sh_reg);
  add_agu aadd4(uu_base4,u4_const_reg,uu_index4,p4_cmplxAddr_d,p4_sec_in,
    p4_ndiff,~p4_mex_en,u4_sh_reg);
  add_agu aadd5(uu_base5,u5_const_reg,uu_index5,p5_cmplxAddr_d,p5_sec_in,
    p5_ndiff,~p5_mex_en,u5_sh_reg);

  assign p4_cmplxAddr_d=p4_mex_en ? {5'b11111,7'b0,7'h7f,1'b1,p4_mex_addr} : 64'bz;
  assign p5_cmplxAddr_d=p5_mex_en ? {5'b11111,7'b0,7'h7f,1'b1,p5_mex_addr} : 64'bz;

  sagu Wagu_mod(
  .clk(clk),
  .rst(rst),
  .except(except),
  .attr(u4_attr_reg),
  .read_clkEn(u4_clkEn_reg),
  .doStall(),
  .bus_hold(wt_pause_agu_reg), 
  .mex_addr(p4_mex_addr),
  .mex_attr(p4_mex_attr),
  .mex_en(p4_mex_en),
 // .mex_ptrdiff(p4_ptrdiff),
  .op(p4_mex_en ? {7'b0,p4_mex_sz,1'b1} : u4_op_reg),
  .shiftSize(u4_sh_reg),
  .regno(9'b0),
  .LSQ_no(u4_LSQ_no_reg),
  .II_no(u4_II_no_reg),
  .WQ_no(u4_WQ_no_reg),
  .thread(1'b0),
  .lsflag(u4_lsflag_reg),
  .cmplxAddr(p4_cmplxAddr),
  .cin_secq(p4_mex_en_reg ? 1'b1 : p4_sec_in_reg),
  .ptrdiff(p4_mex_en_reg ? 1'b0 : ~p4_ndiff_reg),
  //.conflict(),
  .tlbMiss(p4_tlbmiss),
  .mOp_register(),
  .mOp_type(mOp4_type),
  .mOp_LSQ(mOp4_LSQ),
  .mOp_II(mOp4_II),
  .mOp_WQ(mOp4_WQ),
  .mOp_attr(mOp4_attr),
  .mOp_addrEven(mOpX4_addrEven),
  .mOp_addrOdd(mOpX4_addrOdd),
  .mOp_addrMain(mOp4_addrMain),
  .mOp_sz(mOp4_sz),
  .mOp_st(),
  .mOp_en(mOp4_en),
  .mOp_secq(mOp4_sec),
//  .mOp_ptrdiff(mOp4_ptrdiff),
  .mOp_rsEn(),
  .mOp_thread(),
  .mOp_lsflag(mOp4_lsflag),
  .mOp_banks(mOp4_banks),
  .mOp_bank0(mOp4_bank0),
  //.mOp_bank1(dc_wrBeginB[n]),
  .mOp_odd(mOp4_odd),
  .mOp_addr_low(mOp4_low),
  .mOp_split(mOp4_split),
  .pageFault(p4_pageFault),
  .faultCode(p4_faultCode),
  .faultNo(p4_faultNo),
  //.mOp_noBanks(),
  .writeTlb_IP(tlb_addr),
  .writeTlb_wen(tlb_wen),
  .writeTlb_force_way(tlb_frc_way),
  .writeTlb_force_way_en(tlb_frc_en),
  .writeTlb_data0(tlb_data0),
  .writeTlb_data1(tlb_data1),
  .writeTlb_data2(tlb_data2),
  .csrss_no(csrss_addr),.csrss_thr(csrss_thread),.csrss_en(csrss_en),.csrss_data(csrss_data)
  );
  
  sagu Wagu2_mod(
  .clk(clk),
  .rst(rst),
  .except(except),
  .attr(u5_attr_reg),
  .read_clkEn(u5_clkEn_reg),
  .doStall(),
  .bus_hold(wt_pause_agu_reg), 
  .mex_addr(p5_mex_addr),
  .mex_attr(p5_mex_attr),
  .mex_en(p5_mex_en),
  .op(p5_mex_en ? {7'b0,p5_mex_sz,1'b1} : u5_op_reg),
  .shiftSize(u5_sh_reg),
  .regno(9'b0),
  .LSQ_no(u5_LSQ_no_reg),
  .II_no(u5_II_no_reg),
  .WQ_no(u5_WQ_no_reg),
  .thread(1'b0),
  .lsflag(u5_lsflag_reg),
  .cmplxAddr(p5_cmplxAddr),
  .cin_secq(p5_mex_en_reg ? 1'b1 : p5_sec_in_reg),
  .ptrdiff(p5_mex_en_reg ? 1'b0 : ~p5_ndiff_reg),
  //.conflict(),
  .tlbMiss(p5_tlbmiss),
  .mOp_register(),
  .mOp_type(mOp5_type),
  .mOp_LSQ(mOp5_LSQ),
  .mOp_II(mOp5_II),
  .mOp_WQ(mOp5_WQ),
  .mOp_attr(mOp5_attr),
  .mOp_addrEven(mOpX5_addrEven),
  .mOp_addrOdd(mOpX5_addrOdd),
  .mOp_addrMain(mOp5_addrMain),
  .mOp_sz(mOp5_sz),
  .mOp_st(),
  .mOp_en(mOp5_en),
  .mOp_secq(mOp5_sec),
  //.mOp_ptrdiff(mOp5_ptrdiff),
  .mOp_rsEn(),
  .mOp_thread(),
  .mOp_lsflag(mOp5_lsflag),
  .mOp_banks(mOp5_banks),
  .mOp_bank0(mOp5_bank0),
  //.mOp_bank1(dc_wrBeginB[n]),
  .mOp_odd(mOp5_odd),
  .mOp_addr_low(mOp5_low),
  .mOp_split(mOp5_split),
  .pageFault(p5_pageFault),
  .faultCode(p5_faultCode),
  .faultNo(p5_faultNo),
  //.mOp_noBanks(),
  .writeTlb_IP(tlb_addr),
  .writeTlb_wen(tlb_wen),
  .writeTlb_force_way(tlb_frc_way),
  .writeTlb_force_way_en(tlb_frc_en),
  .writeTlb_data0(tlb_data0),
  .writeTlb_data1(tlb_data1),
  .writeTlb_data2(tlb_data2),
  .csrss_no(csrss_addr),.csrss_thr(csrss_thread),.csrss_en(csrss_en),.csrss_data(csrss_data)
  );
          
  wtmiss wtmiss_mod(
  clk,
  rst,
  except,
  1'b0,
  u4_clkEn_reg2|u5_clkEn_reg2,//mOp5_rsEn|mOp4_rsEn,
  wt_pause_agu,
  p4_tlbmiss,
  mOp4_en,
  1'b0,
  mOp4_addrMain,
  mOp4_type,
  mOp4_sz,
  mOp4_banks,
  mOp4_bank0,
  mOp4_odd,
  mOp4_low,
  mOp4_split,
  mOp4_LSQ,
  mOp4_II,
  mOp4_WQ,
  mOp4_attr,
  mOp4_lsflag,
  mOpX4_en,
  ,
 // mOp0_addrMain_o,
  mOpX4_type,
  mOpX4_sz,
  mOpX4_banks,
  mOpX4_bank0,
  mOpX4_odd,
  mOpX4_low,
  mOpX4_split,
  mOpX4_LSQ,
  mOpX4_II,
  mOpX4_WQ,
  mOpX4_lsflag,
  p5_tlbmiss,
  mOp5_en,
  1'b0,
  mOp5_addrMain,
  mOp5_type,
  mOp5_sz,
  mOp5_banks,
  mOp5_bank0,
  mOp5_odd,
  mOp5_low,
  mOp5_split,
  mOp5_LSQ,
  mOp5_II,
  mOp5_WQ,
  mOp5_attr,
  mOp5_lsflag,
  mOpX5_en,
  mOpX5_thread,
 // mOp1_addrMain_o,
  mOpX5_type,
  mOpX5_sz,
  mOpX5_banks,
  mOpX5_bank0,
  mOpX5_odd,
  mOpX5_low,
  mOpX5_split,
  mOpX5_LSQ,
  mOpX5_II,
  mOpX5_WQ,
  mOpX5_lsflag,
  p4_mex_addr,
  p4_mex_sz,
  p4_mex_attr,
  p4_mex_en,
  p5_mex_addr,
  p5_mex_sz,
  p5_mex_attr,
  p5_mex_en,
  Em_tlb_req_en,
  Em_tlb_req_addr,
  Em_tlb_req_attr,
  Em_tlb_req_ack
  );
          

  LFSR16_1 oO_mod(clk,rst,other_flip);

  agu #(0) agu0(
  clk,
  rst,
  except,
  u1_attr,
  rsStall[0],
  u1_clkEn,
  ,
  bus_holds_agu|miss_holds_agu,
  u1_op,
  u1_sh,
  u1_reg,
  u1_LSQ_no,
  u1_II_no,
  u1_WQ_no,
  1'b0,
  u1_lsflag,
  p0_cmplxAddr_d,
  p0_sec_in,
  ~p0_ndiff,
  mOp1_rsBanks,
  mOp2_rsBanks,
  mOp3_banks,
  other_flip,
  p0_conflict,
  p0_tlbmiss,
  p0_pageFault,
  p0_faultCode,
  p0_faultNo,
  mOp0_register,
  mOp0_type,
  mOp0_LSQ,
  mOp0_II,
  mOp0_WQ,
  mOp0_attr,
  mOp0_addrEven,
  mOp0_addrOdd,
  mOp0_addrMain,
  mOp0_sz,
  ,
  mOp0_en,
  mOp0_sec,
  mOp0_invtlb,
  mOp0_rsEn,
  ,
  mOp0_lsflag,
  mOp0_banks,
  mOp0_rsBanks,
  mOp0_bank0,
  mOp0_odd,
  mOp0_low,
  mOp0_split,
  mOp_noBanks,
  tlb_addr,
  tlb_wen,
  tlb_frc_way,
  tlb_frc_en,
  tlb_data0,
  tlb_data1,
  tlb_data2,
  csrss_addr,
  csrss_en,
  csrss_thread,
  csrss_data
  );
  
  agu #(1) agu1(
  clk,
  rst,
  except,
  u2_attr,
  rsStall[1],
  u2_clkEn,
  ,
  bus_holds_agu|miss_holds_agu,
  u2_op,
  u2_sh,
  u2_reg,
  u2_LSQ_no,
  u2_II_no,
  u2_WQ_no,
  1'b0,
  u2_lsflag,
  p1_cmplxAddr_d,
  p1_sec_in,
  ~p1_ndiff,
  mOp0_rsBanks,
  mOp2_rsBanks,
  mOp3_banks,
  other_flip,
  p1_conflict,
  p1_tlbmiss,
  p1_pageFault,
  p1_faultCode,
  p1_faultNo,
  mOp1_register,
  mOp1_type,
  mOp1_LSQ,
  mOp1_II,
  mOp1_WQ,
  mOp1_attr,
  mOp1_addrEven,
  mOp1_addrOdd,
  mOp1_addrMain,
  mOp1_sz,
  ,
  mOp1_en,
  mOp1_sec,
  mOp1_invtlb,
  mOp1_rsEn,
  ,
  mOp1_lsflag,
  mOp1_banks,
  mOp1_rsBanks,
  mOp1_bank0,
  mOp1_odd,
  mOp1_low,
  mOp1_split,
  mOp_noBanks,
  tlb_addr,
  tlb_wen,
  tlb_frc_way,
  tlb_frc_en,
  tlb_data0,
  tlb_data1,
  tlb_data2,
  csrss_addr,
  csrss_en,
  csrss_thread,
  csrss_data
  );

  agu #(0) agu2(
  clk,
  rst,
  except,
  u3_attr,
  rsStall[2],
  u3_clkEn,
  ,
  bus_holds_agu|miss_holds_agu,
  u3_op,
  u3_sh,
  u3_reg,
  u3_LSQ_no,
  u3_II_no,
  u3_WQ_no,
  1'b0,
  u3_lsflag,
  p2_cmplxAddr_d,
  p2_sec_in,
  ~p2_ndiff,
  mOp1_rsBanks,
  mOp0_rsBanks,
  mOp3_banks,
  ~other_flip,
  p2_conflict,
  p2_tlbmiss,
  p2_pageFault,
  p2_faultCode,
  p2_faultNo,
  mOp2_register,
  mOp2_type,
  mOp2_LSQ,
  mOp2_II,
  mOp2_WQ,
  mOp2_attr,
  mOp2_addrEven,
  mOp2_addrOdd,
  mOp2_addrMain,
  mOp2_sz,
  ,
  mOp2_en,
  mOp2_sec,
  mOp2_invtlb,
  mOp2_rsEn,
  ,
  mOp2_lsflag,
  mOp2_banks,
  mOp2_rsBanks,
  mOp2_bank0,
  mOp2_odd,
  mOp2_low,
  mOp2_split,
  mOp_noBanks,
  tlb_addr,
  tlb_wen,
  tlb_frc_way,
  tlb_frc_en,
  tlb_data0,
  tlb_data1,
  tlb_data2,
  csrss_addr,
  csrss_en,
  csrss_thread,
  csrss_data
  );
  
  agucam recirculate_mod(
  .clk(clk),
  .rst(rst),
  .except(except),
  .except_thread(1'b0),
  .read_clkEn(~Em_tlb_req_en && ~rec_stall &&~bus_holds_agu_reg &&~miss_holds_agu_reg &&~alt_bus_hold_reg),// && ~miss_pause_agu),
  .doSkip(pause_agu),
  .rsStall(rsStall[3]),
  .conflict0(p0_conflict | p0_tlbmiss_reg),
  .mOp0_lsflag(mOp0_lsflag),
  .mOp0_thread(1'b0),
  .mOp0_addrMain(mOp0_addrMain),
  .mOp0_regNo(mOp0_register),
  .mOp0_sz(mOp0_sz),
  .mOp0_invtlb(mOp0_invtlb),
  .mOp0_split(mOp0_split),
  .mOp0_bank0(mOp0_bank0),
  .mOp0_LSQ(mOp0_LSQ),
  .mOp0_type(mOp0_type),
  .mOp0_II(mOp0_II),
  .mOp0_WQ(mOp0_WQ),
  .mOp0_attr(mOp0_attr),
  .conflict1(p1_conflict | p1_tlbmiss_reg),
  .mOp1_lsflag(mOp1_lsflag),
  .mOp1_thread(1'b0),
  .mOp1_addrMain(mOp1_addrMain),
  .mOp1_regNo(mOp1_register),
  .mOp1_sz(mOp1_sz),
  .mOp1_invtlb(mOp1_invtlb),
  .mOp1_split(mOp1_split),
  .mOp1_bank0(mOp1_bank0),
  .mOp1_LSQ(mOp1_LSQ),
  .mOp1_type(mOp1_type),
  .mOp1_II(mOp1_II),
  .mOp1_WQ(mOp1_WQ),
  .mOp1_attr(mOp1_attr),
  .conflict2(p2_conflict | p2_tlbmiss_reg),
  .mOp2_lsflag(mOp2_lsflag),
  .mOp2_thread(1'b0),
  .mOp2_addrMain(mOp2_addrMain),
  .mOp2_regNo(mOp2_register),
  .mOp2_sz(mOp2_sz),
  .mOp2_invtlb(mOp2_invtlb),
  .mOp2_split(mOp2_split),
  .mOp2_bank0(mOp2_bank0),
  .mOp2_LSQ(mOp2_LSQ),
  .mOp2_type(mOp2_type),
  .mOp2_II(mOp2_II),
  .mOp2_WQ(mOp2_WQ),
  .mOp2_attr(mOp2_attr),
 
  .mOpR_lsflag(rec_lsflag),
  .mOpR_addrMain(rec_addr),
  .mOpR_addrEven(rec_addrE),
  .mOpR_addrOdd(rec_addrO),
  .mOpR_lsfw(rec_lsfwd),
  .mOpR_odd(rec_odd),
  .mOpR_low(rec_addr_low),
  .mOpR_regNo(rec_register),
  .mOpR_sz(rec_size),
  .mOpR_invtlb(rec_invtlb),
  .mOpR_split(rec_split),
  .mOpR_en(rec_en),
  .mOpR_bank0(rec_beginA),
  .mOpR_LSQ(rec_LSQ),
  .mOpR_II(rec_II),
  .mOpR_WQ(rec_WQ),
  .mOpR_attr(rec_attr),
  .mOpR_type(rec_type),
  .mOpR_thread()
  );
  
  agu_r rec_agu_mod(
  .clk(clk),
  .rst(rst),
  .except(except),
  .doStall(rec_stall),
  .bus_hold(bus_holds_agu_reg|miss_holds_agu_reg|alt_bus_hold_reg),
  .pause_miss(miss_pause_agu),
  .rsStall(rsStall[3]),
  .mOp0_en(rec_en),
  .mOp0_thread(1'b0),
  .mOp0_addrMain(rec_addr),
  .mOp0_addrEven(rec_addrE),
  .mOp0_addrOdd(rec_addrO),
  .mOp0_lsfwd(1'b0),
  .mOp0_odd(rec_odd),
  .mOp0_addr_low(rec_addr_low),
  .mOp0_bread(rec_brdbnk),
  .mOp0_data(rec_data),
  .mOp0_pbit(rec_pbit),
  .mOp0_sz(rec_size),
  .mOp0_invtlb(rec_invtlb),
  .mOp0_st(1'b0),
  .mOp0_split(rec_split),
  .mOp0_bank0(rec_beginA),
  .mOp0_regNo(rec_register),
  .mOp0_LSQ(rec_LSQ),
  .mOp0_type(rec_type),
  .mOp0_II(rec_II),
  .mOp0_WQ(rec_WQ),
  .mOp0_attr(rec_attr),
  .mOp0_lsflag(rec_lsflag),
 
  .reqtlb_addr(Em_tlb_req_addr),
  .reqtlb_attr(Em_tlb_req_attr),
  .reqtlb_en(Em_tlb_req_en),
  .reqtlb_ack(Em_tlb_req_ack), 
  .reqC_addr(req_addr),
  .reqC_attr(req_tlbAttr),
  .reqC_tlbEn(req_tlbEn),
  .busC_tlb_data(bus_tlb_data),
  .busC_tlb_en(bus_tlb_en),
  .csrss_no(csrss_addr),.csrss_en(csrss_en),.csrss_thread(csrss_thread),.csrss_data(csrss_data),
  .pageFault(p3_pageFault),
  .faultCode(p3_faultCode),
  .faultNo(p3_faultNo),
  .mOp_addrEven(mOp3_addrEven),
  .mOp_addrOdd(mOp3_addrOdd),
  .mOp_sz(mOp3_sz),
  .mOp_st(),
  .mOp_en(mOp3_en),
  .mOp_rsEn(mOp3_rsEn),
  .mOp_ioEn(p3_ioEn),
 // .mOp_thread(),
  .mOp_banks(mOp3_banks),
  .mOp_bank0(mOp3_bank0),
  .mOp_odd(mOp3_odd),
  .mOp_addr_low(mOp3_low),
  .mOp_split(mOp3_split),
  .mOp_regNo(mOp3_register),
  .mOp_LSQ(mOp3_LSQ),
  .mOp_type(mOp3_type),
  .mOp_II(mOp3_II),
  .mOp_WQ(mOp3_WQ),
  .mOp_lsfwd(mOp3_lsfwd),
  .mOp_bread(mOp3_brdread),
  .mOp_data(mOp3_data),
  .mOp_pbit(mOp3_pbit),
  .mOp_lsflag(mOp3_lsflag),
  .mOp_tlb_miss(rec_tlb_miss),
  .FU3Hit(FU3Hit),
  .FU3reg(FUreg3_reg),
  .FU3Data(dc_rdataA),
  .extern_feed(p3_io_ack),
  .writeTlb_IP(tlb_addr),
  .writeTlb_wen(tlb_wen),
  .writeTlb_force_way(tlb_frc_way),
  .writeTlb_force_way_en(tlb_frc_en),
  .writeTlb_data0(tlb_data0),
  .writeTlb_data1(tlb_data1),
  .writeTlb_data2(tlb_data2)
  );

  assign miss0=~FU0Hit & mOpX0_en_reg3 & ~p0_conflict_reg2 & 
    ~bus_holds_agu_reg4 &  
    (mOpX0_type_reg3!=2'b10) & ~except & ~mOp0_sec_reg3 & ~alt_bus_hold_reg4;
  assign miss1=~FU1Hit & mOpX1_en_reg3 & ~p1_conflict_reg2 & 
    ~bus_holds_agu_reg4 &  
    (mOpX1_type_reg3!=2'b10) & ~except & ~mOp1_sec_reg3 & ~alt_bus_hold_reg4;
  assign miss2=~FU2Hit & mOpX2_en_reg3 & ~p2_conflict_reg2 & 
    ~bus_holds_agu_reg4 &  
    (mOpX2_type_reg3!=2'b10) & ~except & ~mOp2_sec_reg3 & ~alt_bus_hold_reg4;
  assign miss3=~FU3Hit & mOpX3_en_reg3 & ~alt_bus_hold_reg4 & 
    ~bus_holds_agu_reg4 & (~except || mOpX3_register_reg3==9'h1fc);
  
  assign wr0_hit={mOpY4_hit && mOpY4_odd_o_reg3 | mOpY4_split_o_reg3,mOpY4_hit && ~mOpY4_odd_o_reg3 | mOpY4_split_o_reg3};
  assign wr0_addrE=mOpY4_addrEven_o_reg3;
  assign wr0_addrO=mOpY4_addrOdd_o_reg3;
  assign wr0_banks=mOpY4_banks_o_reg3;
  assign wr0_begin=mOpY4_bank0_o_reg3;
  assign wr0_end=mOpY4_bank1_o_reg3;
  assign wr0_bgn_ben=mOpY4_bgn_b_o_reg3;
  assign wr0_end_ben=mOpY4_end_b_o_reg3;
  assign wr0_odd=mOpY4_odd_o_reg3;
  assign wr0_split=mOpY4_split_o_reg3;
  assign wr0_data=mOpY4_data_o_reg3;
  assign wr0_pbit=mOpY4_pbit_o_reg3;
  assign wr0_d128=mOpY4_d128_o_reg3;
  
  assign wr1_hit={mOpY5_hit && mOpY5_odd_o_reg3 | mOpY5_split_o_reg3,mOpY5_hit && ~mOpY5_odd_o_reg3 | mOpY5_split_o_reg3};
  assign wr1_addrE=mOpY5_addrEven_o_reg3;
  assign wr1_addrO=mOpY5_addrOdd_o_reg3;
  assign wr1_banks=mOpY5_banks_o_reg3;
  assign wr1_begin=mOpY5_bank0_o_reg3;
  assign wr1_end=mOpY5_bank1_o_reg3;
  assign wr1_bgn_ben=mOpY5_bgn_b_o_reg3;
  assign wr1_end_ben=mOpY5_end_b_o_reg3;
  assign wr1_odd=mOpY5_odd_o_reg3;
  assign wr1_split=mOpY5_split_o_reg3;
  assign wr1_data=mOpY5_data_o_reg3;
  assign wr1_pbit=mOpY5_pbit_o_reg3;
  assign wr1_d128=mOpY5_d128_o_reg3;
 /* 
  assign miss_clDo[0]=mOpR_en && ~mOpR_clHit[0] && ~miss_doneEven && ~mOpR_odd|mOpR_split;
  assign miss_clDo[1]=mOpR_en && ~mOpR_clHit[1] && ~miss_doneOdd &&  mOpR_odd|mOpR_split;
  
  assign mcam_addr=miss_clDo[0] ? {mOpR_addrEven,1'b0} : {mOpR_addrOdd,1'b1};
  assign mcam_cldupl=miss_clDo[0] ? mOpR_dupl[0] : mOpR_dupl[1];
  assign mcam_st=mOpR_st;
  assign mcam_sz=mOpR_sz;
  assign mcam_low=mOpR_addr_low;
  assign mcam_bank0=mOpR_bank0;
  assign mcam_io=mOpR_io;
  assign miss_next=!(&miss_clDo) && mcam_hasfree;
  
  assign mcam_do_req=mOpR_en_reg&&~mcam_locked&&~mcam_dupl&&~mcam_replay;
*/

  missQ memmiss(
  clk,
  rst,
  except,
  1'b0,
  insert_isData,
  insBus_req[3:0],
  insBus_addr,
 // miss_next,
 // mcam_replay,
  miss_pause_agu,//??
  miss_holds_agu,
 // miss_unlock,
  now_flushing,
  miss0,
  mOp0_en,
  1'b0,
  mOp0_addrEven,
  mOp0_addrOdd,
  mOp0_sz,
  1'b0,
  mOp0_banks,
  mOp0_bank0,
  mOp0_odd,
  mOp0_low,
  mOp0_split,
  mOp0_register,
  mOp0_type,
  mOp0_clHit,
  mOp0_LSQ,
  mOp0_II,
  mOp0_WQ,
  mOp0_lsflag,
  mOpX0_en,
  mOpX0_thread,
  mOpX0_addrEven,
  mOpX0_addrOdd,
  mOpX0_sz,
  ,
  mOpX0_banks,
  mOpX0_bank0,
  mOpX0_odd,
  mOpX0_low,
  mOpX0_split,
  mOpX0_register,
  mOpX0_type,
  mOpX0_LSQ,
  mOpX0_II,
  mOpX0_WQ,
  mOpX0_lsflag,
  mOpX0_lsfwd,
  miss1,
  mOp1_en,
  1'b0,
  mOp1_addrEven,
  mOp1_addrOdd,
  mOp1_sz,
  1'b0,
  mOp1_banks,
  mOp1_bank0,
  mOp1_odd,
  mOp1_low,
  mOp1_split,
  mOp1_register,
  mOp1_type,
  mOp1_clHit,
  mOp1_LSQ,
  mOp1_II,
  mOp1_WQ,
  mOp1_lsflag,
  mOpX1_en,
  mOpX1_thread,
  mOpX1_addrEven,
  mOpX1_addrOdd,
  mOpX1_sz,
  ,
  mOpX1_banks,
  mOpX1_bank0,
  mOpX1_odd,
  mOpX1_low,
  mOpX1_split,
  mOpX1_register,
  mOpX1_type,
  mOpX1_LSQ,
  mOpX1_II,
  mOpX1_WQ,
  mOpX1_lsflag,
  mOpX1_lsfwd,
  miss2,
  mOp2_en,
  1'b0,
  mOp2_addrEven,
  mOp2_addrOdd,
  mOp2_sz,
  1'b0,
  mOp2_banks,
  mOp2_bank0,
  mOp2_odd,
  mOp2_low,
  mOp2_split,
  mOp2_register,
  mOp2_type,
  mOp2_clHit,
  mOp2_LSQ,
  mOp2_II,
  mOp2_WQ,
  mOp2_lsflag,
  mOpX2_en,
  mOpX2_thread,
  mOpX2_addrEven,
  mOpX2_addrOdd,
  mOpX2_sz,
  ,
  mOpX2_banks,
  mOpX2_bank0,
  mOpX2_odd,
  mOpX2_low,
  mOpX2_split,
  mOpX2_register,
  mOpX2_type,
  mOpX2_LSQ,
  mOpX2_II,
  mOpX2_WQ,
  mOpX2_lsflag,
  mOpX2_lsfwd,
  mOpX2_data,
  mOpX2_pbit,
  mOpX2_brdread,
  miss3,
  mOp3_en,
  1'b0,
  mOp3_addrEven,
  mOp3_addrOdd,
  mOp3_sz,
  1'b0,
  mOp3_banks,
  mOp3_bank0,
  mOp3_odd,
  mOp3_low,
  mOp3_split,
  mOp3_register,
  mOp3_clHit,
  mOp3_LSQ,
  mOp3_II,
  mOp3_WQ,
  mOp3_lsflag,
  mOp3_lsfwd,
  mOp3_data,
  mOp3_pbit,
  mOp3_type,
  mOp3_brdread,
  mOpX3_en,
  ,
  mOpX3_addrEven,
  mOpX3_addrOdd,
  mOpX3_sz,
  ,
  mOpX3_banks,
  mOpX3_bank0,
  mOpX3_odd,
  mOpX3_low,
  mOpX3_split,
  mOpX3_register,
  mOpX3_LSQ,
  mOpX3_II,
  mOpX3_WQ,
  mOpX3_lsflag,
  mOpX3_lsfwd,
  mOpX3_data,
  mOpX3_pbit,
  mOpX3_type,
  mOpX3_brdread,
  miss4,
  mOpY4_en,
  mOpY4_dupl,//write to a non-exclusive cl
  //mOp4_thread,
  mOpY4_addrEven,
  mOpY4_addrOdd,
  mOpY4_sz,
  mOpY4_first,
  mOpY4_banks,
  mOpY4_bank0,
  mOpY4_bank1,
  mOpY4_bgn_b,
  mOpY4_end_b,
  mOpY4_odd,
  mOpY4_addr_low,
  mOpY4_split,
  mOpY4_clHit,
  mOpY4_data,
  mOpY4_pbit,
  mOpY4_type,
  mOpY4_II,
  mOpY4_en_o,
//  mOp4_dupl_o,
  //mOp4_thread_o,
  mOpY4_addrEven_o,
  mOpY4_addrOdd_o,
  mOpY4_sz_o,
//  mOp4_first_o,
  mOpY4_banks_o,
  mOpY4_bank0_o,
  mOpY4_bank1_o,
  mOpY4_bgn_b_o,
  mOpY4_end_b_o,
  mOpY4_odd_o,
  mOpY4_addr_low_o,
  mOpY4_split_o,
  mOpY4_data_o,
  mOpY4_dataN_o,
  mOpY4_pbit_o,
  mOpY4_type_o,
  mOpY4_II_o,
  miss5,
  mOpY5_en,
  mOpY5_dupl,
 // mOp5_thread,
  mOpY5_addrEven,
  mOpY5_addrOdd,
  mOpY5_sz,
  mOpY5_first,
  mOpY5_banks,
  mOpY5_bank0,
  mOpY5_bank1,
  mOpY5_bgn_b,
  mOpY5_end_b,
  mOpY5_odd,
  mOpY5_addr_low,
  mOpY5_split,
  mOpY5_clHit,
  mOpY5_data,
  mOpY5_pbit,
  mOpY5_type,
  mOpY5_II,
  mOpY5_en_o,
//  mOp5_dupl_o,
 // mOp5_thread_o,
  mOpY5_addrEven_o,
  mOpY5_addrOdd_o,
  mOpY5_sz_o,
//  mOp5_first_o,
  mOpY5_banks_o,
  mOpY5_bank0_o,
  mOpY5_bank1_o,
  mOpY5_bgn_b_o,
  mOpY5_end_b_o,
  mOpY5_odd_o,
  mOpY5_addr_low_o,
  mOpY5_split_o,
  mOpY5_data_o,
  mOpY5_dataN_o,
  mOpY5_pbit_o,
  mOpY5_type_o,
  mOpY5_II_o,

  mOp_noBanks,
  mOp_noBanks_o,
  mOp_write_clear,
  mOpR_en,
  mOpR_addr,
  mOpR_sz,
  mOpR_req,
  mOpR_st,
  mOpR_bank0,
  mOpR_io,
  mOpR_odd,
  mOpR_addr_low,
  mOpR_split,
  mOpR_dupl,
  mOpR_stall,
  alt_bus_hold_reg,
  alt_bus_addr_reg,
  alt_bus_hold_reg3
  );
 
  msiq msiq_mod(
  clk,
  rst,
  all_clear,
  p0_adata_reg,p0_en,p0_repl,
  p1_adata_reg,p1_en,p1_repl,
  p2_adata_reg,p2_en,p2_repl,
  p3_adata_reg,p3_en,p3_repl,
  msi_exp_addr,msi_en,msi_out_clear);
 
/* 
  dmisscam mcam_mod(
  .clk(clk),
  .rst(rst),
  .fill_en(mOpR_en_reg),
  .fill_en_pre(mOpR_en),
  .fill_addr(mcam_addr_reg),
  .fill_st(mcam_st_reg),
  .fill_req(mcam_req),
  .ins_en(insert_isData),
  .ins_req(insBus_req[3:0]),
  .ins_addr_o(insBus_addr),
  .has_free(mcam_hasfree),
  .fill_match(mcam_dupl),
  .locked(mcam_locked),
  .begin_replay(mcam_replay),
  .unlock(miss_unlock)
  );
*/
  assign alt_bus_hold=insert_isData_reg2;
  assign alt_bus_addr=insBus_addr_reg2;

  assign p0_adata[`lsaddr_addrE]=mOpX0_addrEven_reg;
  assign p0_adata[`lsaddr_addrO]=mOpX0_addrOdd_reg;
 // assign p0_adata[`lsaddr_banks]=mOp0_rsBanks_reg;
  assign p0_adata[`lsaddr_bank0]=mOpX0_bank0_reg;
  assign p0_adata[`lsaddr_low]=  mOpX0_low_reg;
  assign p0_adata[`lsaddr_split]=mOpX0_split_reg;
  assign p0_adata[`lsaddr_odd]=  mOpX0_odd_reg;
  assign p0_adata[`lsaddr_st]=   1'b0;
  assign p0_adata[`lsaddr_sz]=   mOpX0_sz_reg;
  assign p0_adata[`lsaddr_odd_round]=mOpX0_LSQ_reg[8];
  assign p0_adata[`lsaddr_II]=   mOpX0_II_reg;
  assign p0_adata[`lsaddr_WQ]=   mOpX0_WQ_reg;
  assign p0_adata[`lsaddr_reg_hi]=mOpX0_register_reg[8:4];
  assign p0_adata[`lsaddr_reg_low]=mOpX0_register_reg[3:0];
  assign p0_adata[`lsaddr_mtype]=mOpX0_type_reg;
  assign p0_adata[`lsaddr_flag]= mOpX0_lsflag_reg;
  assign p0_adata[`lsaddr_pconfl]=1'b0;//next clock
  assign p0_adata[`lsaddr_except]=p0_pageFault&~now_flushing_reg;
  assign p0_adata[`lsaddr_blow]=get_byte_mod4(mOpX0_low_reg,mOpX0_sz_reg);
  assign p0_adata[`lsaddr_OH]=   mOpX0_odd_reg;
  assign p0_adata[`lsaddr_EH]=  ~mOpX0_odd_reg;
  assign p0_adata[`lsaddr_OL]=(mOpX0_odd_reg && ~mOpX0_split_reg|~mOpX0_bank0_reg[4]) 
        || (~mOpX0_odd_reg && mOpX0_split_reg && mOpX0_bank0_reg[4]);
  assign p0_adata[`lsaddr_EL]=(~mOpX0_odd_reg && ~mOpX0_split_reg|~mOpX0_bank0_reg[4])
    || (mOpX0_odd_reg && mOpX0_split_reg && mOpX0_bank0_reg[4]);
  assign p0_adata[`lsaddr_etype]=p0_faultCode[3:0];
  assign p0_adata[`lsaddr_banks]=mOpX0_banks_reg;
  assign p0_rsEn=mOp0_rsEn_reg && ~p0_pageFault && ~now_flushing_reg;
  assign p0_en=mOpX0_en_reg & !p0_conflict;
  assign p0_LSQ=mOpX0_LSQ_reg;
  assign p0_ret={1'b0,p0_faultCode[3:0],p0_faultNo};
  assign p0_secq=mOp0_sec_reg;
  assign p0_lsfwd=mOpX0_lsfwd_reg;

  assign p1_adata[`lsaddr_addrE]=mOpX1_addrEven_reg;
  assign p1_adata[`lsaddr_addrO]=mOpX1_addrOdd_reg;
  //assign p1_adata[`lsaddr_banks]=mOp1_rsBanks_reg;
  assign p1_adata[`lsaddr_bank0]=mOpX1_bank0_reg;
  assign p1_adata[`lsaddr_low]=  mOpX1_low_reg;
  assign p1_adata[`lsaddr_split]=mOpX1_split_reg;
  assign p1_adata[`lsaddr_odd]=  mOpX1_odd_reg;
  assign p1_adata[`lsaddr_st]=   1'b0;
  assign p1_adata[`lsaddr_sz]=   mOpX1_sz_reg;
  assign p1_adata[`lsaddr_odd_round]=mOpX1_LSQ_reg[8];
  assign p1_adata[`lsaddr_II]=   mOpX1_II_reg;
  assign p1_adata[`lsaddr_WQ]=   mOpX1_WQ_reg;
  assign p1_adata[`lsaddr_reg_hi]=mOpX1_register_reg[8:4];
  assign p1_adata[`lsaddr_reg_low]=mOpX1_register_reg[3:0];
  assign p1_adata[`lsaddr_mtype]=mOpX1_type_reg;
  assign p1_adata[`lsaddr_flag]= mOpX1_lsflag_reg;
  assign p1_adata[`lsaddr_pconfl]=1'b0;//next clock
  assign p1_adata[`lsaddr_except]=p1_pageFault&~now_flushing_reg;
  assign p1_adata[`lsaddr_blow]=get_byte_mod4(mOpX1_low_reg,mOpX1_sz_reg);
  assign p1_adata[`lsaddr_OH]=   mOpX1_odd_reg;
  assign p1_adata[`lsaddr_EH]=  ~mOpX1_odd_reg;
  assign p1_adata[`lsaddr_OL]=(mOpX1_odd_reg && ~mOpX1_split_reg|~mOpX1_bank0_reg[4]) 
        || (~mOpX1_odd_reg && mOpX1_split_reg && mOpX1_bank0_reg[4]);
  assign p1_adata[`lsaddr_EL]=(~mOpX1_odd_reg && ~mOpX1_split_reg|~mOpX1_bank0_reg[4])
    || (mOpX1_odd_reg && mOpX1_split_reg && mOpX1_bank0_reg[4]);
  assign p1_adata[`lsaddr_etype]=p1_faultCode[3:0];
  assign p1_adata[`lsaddr_banks]=mOpX1_banks_reg;
  assign p1_rsEn=mOp1_rsEn_reg && ~p1_pageFault && ~now_flushing_reg;
  assign p1_en=mOpX1_en_reg & ~p1_conflict;
  assign p1_LSQ=mOpX1_LSQ_reg;
  assign p1_ret={1'b0,p1_faultCode[3:0],p1_faultNo};
  assign p1_secq=mOp1_sec_reg;
  assign p1_lsfwd=mOpX1_lsfwd_reg;

  assign p2_adata[`lsaddr_addrE]=mOpX2_addrEven_reg;
  assign p2_adata[`lsaddr_addrO]=mOpX2_addrOdd_reg;
//  assign p2_adata[`lsaddr_banks]=mOp2_rsBanks_reg;
  assign p2_adata[`lsaddr_bank0]=mOpX2_bank0_reg;
  assign p2_adata[`lsaddr_low]=  mOpX2_low_reg;
  assign p2_adata[`lsaddr_split]=mOpX2_split_reg;
  assign p2_adata[`lsaddr_odd]=  mOpX2_odd_reg;
  assign p2_adata[`lsaddr_st]=   1'b0;
  assign p2_adata[`lsaddr_sz]=   mOpX2_sz_reg;
  assign p2_adata[`lsaddr_odd_round]=mOpX2_LSQ_reg[8];
  assign p2_adata[`lsaddr_II]=   mOpX2_II_reg;
  assign p2_adata[`lsaddr_WQ]=   mOpX2_WQ_reg;
  assign p2_adata[`lsaddr_reg_hi]=mOpX2_register_reg[8:4];
  assign p2_adata[`lsaddr_reg_low]=mOpX2_register_reg[3:0];
  assign p2_adata[`lsaddr_mtype]=mOpX2_type_reg;
  assign p2_adata[`lsaddr_flag]= mOpX2_lsflag_reg;
  assign p2_adata[`lsaddr_pconfl]=1'b0;//next clock
  assign p2_adata[`lsaddr_except]=p2_pageFault&~now_flushing_reg;
  assign p2_adata[`lsaddr_blow]=get_byte_mod4(mOpX2_low_reg,mOpX2_sz_reg);
  assign p2_adata[`lsaddr_OH]=   mOpX2_odd_reg;
  assign p2_adata[`lsaddr_EH]=  ~mOpX2_odd_reg;
  assign p2_adata[`lsaddr_OL]=(mOpX2_odd_reg && ~mOpX2_split_reg|~mOpX2_bank0_reg[4]) 
        || (~mOpX2_odd_reg && mOpX2_split_reg && mOpX2_bank0_reg[4]);
  assign p2_adata[`lsaddr_EL]=(~mOpX2_odd_reg && ~mOpX2_split_reg|~mOpX2_bank0_reg[4])
    || (mOpX2_odd_reg && mOpX2_split_reg && mOpX2_bank0_reg[4]);
  assign p2_adata[`lsaddr_etype]=p2_faultCode[3:0];
  assign p2_adata[`lsaddr_banks]=mOpX2_banks_reg;
  assign p2_rsEn=mOp2_rsEn_reg && ~p2_pageFault && ~now_flushing_reg;
  assign p2_en=mOpX2_en_reg & ~p2_conflict;
  assign p2_LSQ=mOpX2_LSQ_reg;
  assign p2_ret={1'b0,p2_faultCode[3:0],p2_faultNo};
  assign p2_secq=mOp2_sec_reg;
  assign p2_lsfwd=mOpX2_lsfwd_reg;
  assign p2_data=mOpX2_data_reg;
  assign p2_pbit=mOpX2_pbit_reg;
  assign p2_brdbanks=mOpX2_brdread_reg;

  assign p3_adata[`lsaddr_addrE]=mOpX3_addrEven_reg;
  assign p3_adata[`lsaddr_addrO]=mOpX3_addrOdd_reg;
  assign p3_adata[`lsaddr_banks]=mOpX3_banks_reg;
  assign p3_adata[`lsaddr_bank0]=mOpX3_bank0_reg;
  assign p3_adata[`lsaddr_low]=  mOpX3_low_reg;
  assign p3_adata[`lsaddr_split]=mOpX3_split_reg;
  assign p3_adata[`lsaddr_odd]=  mOpX3_odd_reg;
  assign p3_adata[`lsaddr_st]=   1'b0;
  assign p3_adata[`lsaddr_sz]=   mOpX3_sz_reg;
  assign p3_adata[`lsaddr_odd_round]=mOpX3_LSQ_reg[8];
  assign p3_adata[`lsaddr_II]=   mOpX3_II_reg;
  assign p3_adata[`lsaddr_WQ]=   mOpX3_WQ_reg;
  assign p3_adata[`lsaddr_reg_hi]=mOpX3_register_reg[8:4];
  assign p3_adata[`lsaddr_reg_low]=mOpX3_register_reg[3:0];
  assign p3_adata[`lsaddr_mtype]=mOpX3_type_reg;
  assign p3_adata[`lsaddr_flag]= mOpX3_lsflag_reg;
  assign p3_adata[`lsaddr_pconfl]=1'b0;//next clock
  assign p3_adata[`lsaddr_except]=p3_pageFault&~now_flushing_reg;
  assign p3_adata[`lsaddr_blow]=get_byte_mod4(mOpX3_low_reg,mOpX3_sz_reg);
  assign p3_adata[`lsaddr_OH]=   mOpX3_odd_reg;
  assign p3_adata[`lsaddr_EH]=  ~mOpX3_odd_reg;
  assign p3_adata[`lsaddr_OL]=(mOpX3_odd_reg && ~mOpX3_split_reg|~mOpX3_bank0_reg[4]) 
        || (~mOpX3_odd_reg && mOpX3_split_reg && mOpX3_bank0_reg[4]);
  assign p3_adata[`lsaddr_EL]=(~mOpX3_odd_reg && ~mOpX3_split_reg|~mOpX3_bank0_reg[4])
    || (mOpX3_odd_reg && mOpX3_split_reg && mOpX3_bank0_reg[4]);
  assign p3_adata[`lsaddr_etype]=p3_faultCode[3:0];
  //assign p3_adata[`lsaddr_banks]=mOpX3_banks_reg;
  assign p3_rsEn=mOp3_rsEn_reg && ~p3_pageFault && ~now_flushing_reg;
  assign p3_en=mOpX3_en_reg;
  assign p3_LSQ=mOpX3_LSQ_reg;
  assign p3_lsfwd=mOpX3_lsfwd_reg;
  assign p3_data=mOpX3_data_reg;
  assign p3_pbit=mOpX3_pbit_reg;
  assign p3_ret={1'b0,p3_faultCode[3:0],p3_faultNo};
  assign p3_brdbanks=mOpX3_brdread_reg;

  assign p_bankNone=~mOpX3_banks_reg & ~mOpX2_banks_reg & ~mOpX1_banks_reg &~mOpX0_banks_reg;

  assign p4_adata[`lsaddr_addrE]=mOpX4_addrEven_reg;
  assign p4_adata[`lsaddr_addrO]=mOpX4_addrOdd_reg;
  assign p4_adata[`lsaddr_banks]=mOpX4_banks_reg;
  assign p4_adata[`lsaddr_bank0]=mOpX4_bank0_reg;
  assign p4_adata[`lsaddr_low]=  mOpX4_low_reg;
  assign p4_adata[`lsaddr_split]=mOpX4_split_reg;
  assign p4_adata[`lsaddr_odd]=  mOpX4_odd_reg;
  assign p4_adata[`lsaddr_st]=   1'b1;
  assign p4_adata[`lsaddr_sz]=   mOpX4_sz_reg;
  assign p4_adata[`lsaddr_odd_round]=mOpX4_LSQ_reg[8];
  assign p4_adata[`lsaddr_II]=   mOpX4_II_reg;
  assign p4_adata[`lsaddr_WQ]=   mOpX4_WQ_reg;
  assign p4_adata[`lsaddr_reg_hi]=mOpX4_register_reg[8:4];
  assign p4_adata[`lsaddr_reg_low]=mOpX4_register_reg[3:0];
  assign p4_adata[`lsaddr_mtype]=mOpX4_type_reg;
  assign p4_adata[`lsaddr_flag]= mOpX4_lsflag_reg;
  assign p4_adata[`lsaddr_pconfl]=1'b0;//unused for store
  assign p4_adata[`lsaddr_except]=p4_pageFault;
  assign p4_adata[`lsaddr_blow]=get_byte_mod4(mOpX4_low_reg,mOpX4_sz_reg);
  assign p4_adata[`lsaddr_OH]=   mOpX4_odd_reg;
  assign p4_adata[`lsaddr_EH]=  ~mOpX4_odd_reg;
  assign p4_adata[`lsaddr_OL]=(mOpX4_odd_reg && ~mOpX4_split_reg|~mOpX4_bank0_reg[4]) 
        || (~mOpX4_odd_reg && mOpX4_split_reg && mOpX4_bank0_reg[4]);
  assign p4_adata[`lsaddr_EL]=(~mOpX4_odd_reg && ~mOpX4_split_reg|~mOpX4_bank0_reg[4])
    || (mOpX4_odd_reg && mOpX4_split_reg && mOpX4_bank0_reg[4]);
  assign p4_adata[`lsaddr_etype]=p4_faultCode[3:0];
  assign p4_en=mOpX4_en_reg;
  assign p4_LSQ=mOpX4_LSQ_reg;
  assign p4_secq=mOp4_sec_reg;
  assign p4_ret={1'b0,p4_faultCode[3:0],p4_faultNo};

  assign p5_adata[`lsaddr_addrE]=mOpX5_addrEven_reg;
  assign p5_adata[`lsaddr_addrO]=mOpX5_addrOdd_reg;
  assign p5_adata[`lsaddr_banks]=mOpX5_banks_reg;
  assign p5_adata[`lsaddr_bank0]=mOpX5_bank0_reg;
  assign p5_adata[`lsaddr_low]=  mOpX5_low_reg;
  assign p5_adata[`lsaddr_split]=mOpX5_split_reg;
  assign p5_adata[`lsaddr_odd]=  mOpX5_odd_reg;
  assign p5_adata[`lsaddr_st]=   1'b1;
  assign p5_adata[`lsaddr_sz]=   mOpX5_sz_reg;
  assign p5_adata[`lsaddr_odd_round]=mOpX5_LSQ_reg[8];
  assign p5_adata[`lsaddr_II]=   mOpX5_II_reg;
  assign p5_adata[`lsaddr_WQ]=   mOpX5_WQ_reg;
  assign p5_adata[`lsaddr_reg_hi]=mOpX5_register_reg[8:4];
  assign p5_adata[`lsaddr_reg_low]=mOpX5_register_reg[3:0];
  assign p5_adata[`lsaddr_mtype]=mOpX5_type_reg;
  assign p5_adata[`lsaddr_flag]= mOpX5_lsflag_reg;
  assign p5_adata[`lsaddr_pconfl]=1'b0;
  assign p5_adata[`lsaddr_except]=p5_pageFault;
  assign p5_adata[`lsaddr_blow]=get_byte_mod4(mOpX5_low_reg,mOpX5_sz_reg);
  assign p5_adata[`lsaddr_OH]=   mOpX5_odd_reg;
  assign p5_adata[`lsaddr_EH]=  ~mOpX5_odd_reg;
  assign p5_adata[`lsaddr_OL]=(mOpX5_odd_reg && ~mOpX5_split_reg|~mOpX5_bank0_reg[4]) 
        || (~mOpX5_odd_reg && mOpX5_split_reg && mOpX5_bank0_reg[4]);
  assign p5_adata[`lsaddr_EL]=(~mOpX5_odd_reg && ~mOpX5_split_reg|~mOpX5_bank0_reg[4])
    || (mOpX5_odd_reg && mOpX5_split_reg && mOpX5_bank0_reg[4]);
  assign p5_adata[`lsaddr_etype]=p5_faultCode[3:0];
  assign p5_en=mOpX5_en_reg;
  assign p5_LSQ=mOpX5_LSQ_reg;
  assign p5_secq=mOp5_sec_reg;
  assign p5_ret={1'b0,p5_faultCode[3:0],p5_faultNo};

  always @(posedge clk) begin
      if (p4_mex_en) $display("mex4");
      if (p5_mex_en) $display("mex5");
      if (Em_tlb_req_en) $display("dtlbR ", Em_tlb_req_addr);
      if (Em_tlb_req_ack) $display("dtlbW");
      if (rec_invtlb) $display("rec_invtlb");

      p4_mex_en_reg<=p4_mex_en;
      p5_mex_en_reg<=p5_mex_en;
      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) begin
          u1_clkEn_reg<=u1_clkEn;
          u1_op_reg<=u1_op;
          u1_sh_reg<=u1_sh;
          u1_reg_reg<=u1_reg;
          u1_LSQ_no_reg<=u1_LSQ_no;
          u1_II_no_reg<=u1_II_no;
          u1_WQ_no_reg<=u1_WQ_no;
          u1_lsflag_reg<=u1_lsflag;
          u1_const_reg<={{31{u1_const[32]}},u1_const};
      end

      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) begin
          u2_clkEn_reg<=u2_clkEn;
          u2_op_reg<=u2_op;
          u2_sh_reg<=u2_sh;
          u2_reg_reg<=u2_reg;
          u2_LSQ_no_reg<=u2_LSQ_no;
          u2_II_no_reg<=u2_II_no;
          u2_WQ_no_reg<=u2_WQ_no;
          u2_lsflag_reg<=u2_lsflag;
          u2_const_reg<={{31{u2_const[32]}},u2_const};
      end
      
      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) begin
          u3_clkEn_reg<=u3_clkEn;
          u3_op_reg<=u3_op;
          u3_sh_reg<=u3_sh;
          u3_reg_reg<=u3_reg;
          u3_LSQ_no_reg<=u3_LSQ_no;
          u3_II_no_reg<=u3_II_no;
          u3_WQ_no_reg<=u3_WQ_no;
          u3_lsflag_reg<=u3_lsflag;
          u3_const_reg<={{31{u3_const[32]}},u3_const};
      end

      u4_clkEn_reg<=u4_clkEn;
      u4_op_reg<=u4_op;
      u4_sh_reg<=u4_sh;
      u4_reg_reg<=u4_reg;
      u4_LSQ_no_reg<=u4_LSQ_no;
      u4_II_no_reg<=u4_II_no;
      u4_WQ_no_reg<=u4_WQ_no;
      u4_lsflag_reg<=u4_lsflag;
      u4_const_reg<={{31{u4_const[32]}},u4_const};

      u5_clkEn_reg<=u5_clkEn;
      u5_op_reg<=u5_op;
      u5_sh_reg<=u5_sh;
      u5_reg_reg<=u5_reg;
      u5_LSQ_no_reg<=u5_LSQ_no;
      u5_II_no_reg<=u5_II_no;
      u5_WQ_no_reg<=u5_WQ_no;
      u5_lsflag_reg<=u5_lsflag;
      u5_const_reg<={{31{u5_const[32]}},u5_const};

      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) begin      
          u1_clkEn_reg2<=u1_clkEn_reg & ~except;
          u1_op_reg2<=u1_op_reg;
          u1_sh_reg2<=u1_sh_reg;
          u1_reg_reg2<=u1_reg_reg;
          u1_LSQ_no_reg2<=u1_LSQ_no_reg;
          u1_II_no_reg2<=u1_II_no_reg;
          u1_WQ_no_reg2<=u1_WQ_no_reg;
          u1_lsflag_reg2<=u1_lsflag_reg;
      end

      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) begin      
          u2_clkEn_reg2<=u2_clkEn_reg & ~except;
          u2_op_reg2<=u2_op_reg;
          u2_sh_reg2<=u2_sh_reg;
          u2_reg_reg2<=u2_reg_reg;
          u2_LSQ_no_reg2<=u2_LSQ_no_reg;
          u2_II_no_reg2<=u2_II_no_reg;
          u2_WQ_no_reg2<=u2_WQ_no_reg;
          u2_lsflag_reg2<=u2_lsflag_reg;
      end

      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) begin      
          u3_clkEn_reg2<=u3_clkEn_reg & ~except;
          u3_op_reg2<=u3_op_reg;
          u3_sh_reg2<=u3_sh_reg;
          u3_reg_reg2<=u3_reg_reg;
          u3_LSQ_no_reg2<=u3_LSQ_no_reg;
          u3_II_no_reg2<=u3_II_no_reg;
          u3_WQ_no_reg2<=u3_WQ_no_reg;
          u3_lsflag_reg2<=u3_lsflag_reg;
      end

      u4_clkEn_reg2<=u4_clkEn_reg & ~except;
      u4_op_reg2<=u4_op_reg;
      u4_sh_reg2<=u4_sh_reg;
      u4_reg_reg2<=u4_reg_reg;
      u4_LSQ_no_reg2<=u4_LSQ_no_reg;
      u4_II_no_reg2<=u4_II_no_reg;
      u4_WQ_no_reg2<=u4_WQ_no_reg;
      u4_lsflag_reg2<=u4_lsflag_reg;

      u5_clkEn_reg2<=u5_clkEn_reg & ~except;
      u5_op_reg2<=u5_op_reg;
      u5_sh_reg2<=u5_sh_reg;
      u5_reg_reg2<=u5_reg_reg;
      u5_LSQ_no_reg2<=u5_LSQ_no_reg;
      u5_II_no_reg2<=u5_II_no_reg;
      u5_WQ_no_reg2<=u5_WQ_no_reg;
      u5_lsflag_reg2<=u5_lsflag_reg;
     
      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) mOp0_sec_reg<=mOp0_sec&~now_flushing&~alt_bus_hold_reg;
      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) mOp1_sec_reg<=mOp1_sec&~now_flushing&~alt_bus_hold_reg;
      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) mOp2_sec_reg<=mOp2_sec&~now_flushing&~alt_bus_hold_reg;
      mOp4_sec_reg<=mOp4_sec;
      mOp5_sec_reg<=mOp5_sec;

      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) mOp0_sec_reg2<=mOp0_sec_reg;
      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) mOp1_sec_reg2<=mOp1_sec_reg;
      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) mOp2_sec_reg2<=mOp2_sec_reg;
      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) mOp0_sec_reg3<=mOp0_sec_reg2;
      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) mOp1_sec_reg3<=mOp1_sec_reg2;
      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) mOp2_sec_reg3<=mOp2_sec_reg2;

      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) mOp0_rsEn_reg<=mOp0_rsEn;
      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) mOp1_rsEn_reg<=mOp1_rsEn;
      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) mOp2_rsEn_reg<=mOp2_rsEn;
      if (~(rsStall[3]&~now_flushing&~alt_bus_hold_reg)) mOp3_rsEn_reg<=mOp3_rsEn;

      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) begin
          mOpX0_en_reg     <=mOpX0_en;
          mOpX0_lsflag_reg <=mOpX0_lsflag;
          mOpX0_type_reg   <=mOpX0_type;
          mOpX0_en_reg2    <=mOpX0_en_reg & ~except;
          mOpX0_lsflag_reg2<=mOpX0_lsflag_reg;
          mOpX0_type_reg2  <=mOpX0_type_reg;
          mOpX0_en_reg3    <=mOpX0_en_reg2 & ~except;
          mOpX0_lsflag_reg3<=mOpX0_lsflag_reg2;
          mOpX0_type_reg3  <=mOpX0_type_reg2;
      end

      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) begin
          mOpX1_en_reg     <=mOpX1_en;
          mOpX1_lsflag_reg <=mOpX1_lsflag;
          mOpX1_type_reg   <=mOpX1_type;
          mOpX1_en_reg2    <=mOpX1_en_reg & ~except;
          mOpX1_lsflag_reg2<=mOpX1_lsflag_reg;
          mOpX1_type_reg2  <=mOpX1_type_reg;
          mOpX1_en_reg3    <=mOpX1_en_reg2 & ~except;
          mOpX1_lsflag_reg3<=mOpX1_lsflag_reg2;
          mOpX1_type_reg3  <=mOpX1_type_reg2;
      end

      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) begin
          mOpX2_en_reg     <=mOpX2_en;
          mOpX2_lsflag_reg <=mOpX2_lsflag;
          mOpX2_type_reg   <=mOpX2_type;
          mOpX2_en_reg2    <=mOpX2_en_reg & ~except;
          mOpX2_lsflag_reg2<=mOpX2_lsflag_reg;
          mOpX2_type_reg2  <=mOpX2_type_reg;
          mOpX2_en_reg3    <=mOpX2_en_reg2 & ~except;
          mOpX2_lsflag_reg3<=mOpX2_lsflag_reg2;
          mOpX2_type_reg3  <=mOpX2_type_reg2;
      end

      if (~(rsStall[3]&~now_flushing&~alt_bus_hold_reg)) begin
          mOpX3_en_reg     <=mOpX3_en;
          mOpX3_lsflag_reg <=mOpX3_lsflag;
          mOpX3_type_reg   <=mOpX3_type;
          mOpX3_en_reg2    <=mOpX3_en_reg & (~except || mOpX3_register_reg==9'h1fc);
          mOpX3_lsflag_reg2<=mOpX3_lsflag_reg;
          mOpX3_type_reg2  <=mOpX3_type_reg;
          mOpX3_en_reg3    <=mOpX3_en_reg2 & (~except || mOpX3_register_reg2==9'h1fc);
          mOpX3_lsflag_reg3<=mOpX3_lsflag_reg2;
          mOpX3_type_reg3  <=mOpX3_type_reg2;
          mOpX3_lsfwd_reg  <=mOpX3_lsfwd;
      end

      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) begin
          mOpX0_addrEven_reg<=mOpX0_addrEven;
          mOpX0_addrOdd_reg<=mOpX0_addrOdd;
          mOpX0_sz_reg<=mOpX0_sz;
          mOpX0_banks_reg<=mOpX0_banks;
          mOpX0_bank0_reg<=mOpX0_bank0;
          mOpX0_odd_reg<=mOpX0_odd;
          mOpX0_low_reg<=mOpX0_low;
          mOpX0_split_reg<=mOpX0_split;
          mOpX0_register_reg<=mOpX0_register;
          mOpX0_LSQ_reg<=mOpX0_LSQ;
          mOpX0_II_reg<=mOpX0_II;
          mOpX0_WQ_reg<=mOpX0_WQ;
          mOpX0_lsfwd_reg  <=mOpX0_lsfwd;
      end

      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) begin
          mOpX1_addrEven_reg<=mOpX1_addrEven;
          mOpX1_addrOdd_reg<=mOpX1_addrOdd;
          mOpX1_sz_reg<=mOpX1_sz;
          mOpX1_banks_reg<=mOpX1_banks;
          mOpX1_bank0_reg<=mOpX1_bank0;
          mOpX1_odd_reg<=mOpX1_odd;
          mOpX1_low_reg<=mOpX1_low;
          mOpX1_split_reg<=mOpX1_split;
          mOpX1_register_reg<=mOpX1_register;
          mOpX1_LSQ_reg<=mOpX1_LSQ;
          mOpX1_II_reg<=mOpX1_II;
          mOpX1_WQ_reg<=mOpX1_WQ;
          mOpX1_lsfwd_reg  <=mOpX1_lsfwd;
      end

      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) begin
          mOpX2_addrEven_reg<=mOpX2_addrEven;
          mOpX2_addrOdd_reg<=mOpX2_addrOdd;
          mOpX2_sz_reg<=mOpX2_sz;
          mOpX2_banks_reg<=mOpX2_banks;
          mOpX2_bank0_reg<=mOpX2_bank0;
          mOpX2_odd_reg<=mOpX2_odd;
          mOpX2_low_reg<=mOpX2_low;
          mOpX2_split_reg<=mOpX2_split;
          mOpX2_register_reg<=mOpX2_register;
          mOpX2_LSQ_reg<=mOpX2_LSQ;
          mOpX2_II_reg<=mOpX2_II;
          mOpX2_WQ_reg<=mOpX2_WQ;
          mOpX2_brdread_reg<=mOpX2_brdread;
          mOpX2_data_reg<=mOpX2_data;
          mOpX2_pbit_reg<=mOpX2_pbit;
          mOpX2_lsfwd_reg  <=mOpX3_lsfwd;
      end

      if (~(rsStall[3]&~now_flushing&~alt_bus_hold_reg)) begin
          mOpX3_addrEven_reg<=mOpX3_addrEven;
          mOpX3_addrOdd_reg<=mOpX3_addrOdd;
          mOpX3_sz_reg<=mOpX3_sz;
          mOpX3_invtlb_reg<=mOpX3_invtlb;
          mOpX3_banks_reg<=mOpX3_banks;
          mOpX3_bank0_reg<=mOpX3_bank0;
          mOpX3_odd_reg<=mOpX3_odd;
          mOpX3_low_reg<=mOpX3_low;
          mOpX3_split_reg<=mOpX3_split;
          mOpX3_register_reg<=mOpX3_register;
          mOpX3_register_reg2<=mOpX3_register_reg;
          mOpX3_register_reg3<=mOpX3_register_reg2;
          mOpX3_LSQ_reg<=mOpX3_LSQ;
          mOpX3_II_reg<=mOpX3_II;
          mOpX3_WQ_reg<=mOpX3_WQ;
          mOpX3_brdread_reg<=mOpX3_brdread;
          mOpX3_data_reg<=mOpX3_data;
          mOpX3_pbit_reg<=mOpX3_pbit;
       end

      mOpX4_en_reg<=mOpX4_en & ~except;
      mOpX4_addrEven_reg<=mOpX4_addrEven;
      mOpX4_addrOdd_reg<=mOpX4_addrOdd;
      mOpX4_sz_reg<=mOpX4_sz;
      mOpX4_banks_reg<=mOpX4_banks;
      mOpX4_bank0_reg<=mOpX4_bank0;
      mOpX4_odd_reg<=mOpX4_odd;
      mOpX4_low_reg<=mOpX4_low;
      mOpX4_split_reg<=mOpX4_split;
      mOpX4_register_reg<=mOpX4_register;
      mOpX4_type_reg<=mOpX4_type;
      mOpX4_LSQ_reg<=mOpX4_LSQ;
      mOpX4_II_reg<=mOpX4_II;
      mOpX4_WQ_reg<=mOpX4_WQ;
      mOpX4_lsflag_reg<=mOpX4_lsflag;
  
      mOpX5_en_reg<=mOpX5_en & ~except;
      mOpX5_addrEven_reg<=mOpX5_addrEven;
      mOpX5_addrOdd_reg<=mOpX5_addrOdd;
      mOpX5_sz_reg<=mOpX5_sz;
      mOpX5_banks_reg<=mOpX5_banks;
      mOpX5_bank0_reg<=mOpX5_bank0;
      mOpX5_odd_reg<=mOpX5_odd;
      mOpX5_low_reg<=mOpX5_low;
      mOpX5_split_reg<=mOpX5_split;
      mOpX5_register_reg<=mOpX5_register;
      mOpX5_type_reg<=mOpX5_type;
      mOpX5_LSQ_reg<=mOpX5_LSQ;
      mOpX5_II_reg<=mOpX5_II;
      mOpX5_WQ_reg<=mOpX5_WQ;
      mOpX5_lsflag_reg<=mOpX5_lsflag;

      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) p0_cmplxAddr<=p0_cmplxAddr_d;
      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) p1_cmplxAddr<=p1_cmplxAddr_d;
      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) p2_cmplxAddr<=p2_cmplxAddr_d;
      if (~(rsStall[3]&~now_flushing&~alt_bus_hold_reg)) p3_cmplxAddr<=p3_cmplxAddr_d;
      p4_cmplxAddr<=p4_cmplxAddr_d;
      p5_cmplxAddr<=p5_cmplxAddr_d;

      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) p0_conflict_reg<=p0_conflict;
      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) p1_conflict_reg<=p1_conflict;
      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) p2_conflict_reg<=p2_conflict;
      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) p0_conflict_reg2<=p0_conflict_reg;
      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) p1_conflict_reg2<=p1_conflict_reg;
      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) p2_conflict_reg2<=p2_conflict_reg;

      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) p0_tlbmiss_reg<=p0_tlbmiss;
      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) p1_tlbmiss_reg<=p1_tlbmiss;
      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) p2_tlbmiss_reg<=p2_tlbmiss;

      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) p0_sec_in_reg<=p0_sec_in;
      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) p1_sec_in_reg<=p1_sec_in;
      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) p2_sec_in_reg<=p2_sec_in;
      if (~(rsStall[3]&~now_flushing&~alt_bus_hold_reg)) p3_sec_in_reg<=p3_sec_in;
      p4_sec_in_reg<=p4_sec_in;
      p5_sec_in_reg<=p5_sec_in;

      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) p0_ndiff_reg<=p0_ndiff;
      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) p1_ndiff_reg<=p1_ndiff;
      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) p2_ndiff_reg<=p2_ndiff;
      if (~(rsStall[3]&~now_flushing&~alt_bus_hold_reg)) p3_ndiff_reg<=p3_ndiff;
      p4_ndiff_reg<=p4_ndiff;
      p5_ndiff_reg<=p5_ndiff;

      wt_pause_agu_reg<=wt_pause_agu;
      miss_holds_agu_reg<=miss_holds_agu;
      miss_holds_agu_reg2<=miss_holds_agu_reg;
      bus_holds_agu_reg2<=bus_holds_agu_reg;
      alt_bus_hold_reg<=alt_bus_hold;
      alt_bus_addr_reg<=alt_bus_addr;
      alt_bus_hold_reg2<=alt_bus_hold_reg;
      alt_bus_hold_reg3<=alt_bus_hold_reg2;
      alt_bus_hold_reg4<=alt_bus_hold_reg3;
      
      bus_holds_agu<=insert_isData;
      bus_holds_agu_reg<=bus_holds_agu;
      bus_holds_agu_reg2<=bus_holds_agu_reg;
      bus_holds_agu_reg3<=bus_holds_agu_reg2;
      bus_holds_agu_reg4<=bus_holds_agu_reg3;
      bus_holds_agu_reg5<=bus_holds_agu_reg4;
     
      mOpY4_addrEven_o_reg<=mOpY4_addrEven_o;
      mOpY4_addrOdd_o_reg<=mOpY4_addrOdd_o;
      mOpY4_banks_o_reg<=mOpY4_banks_o;
      mOpY4_bank0_o_reg<=mOpY4_bank0_o;
      mOpY4_bank1_o_reg<=mOpY4_bank1_o;
      mOpY4_bgn_b_o_reg<=mOpY4_bgn_b_o;
      mOpY4_end_b_o_reg<=mOpY4_end_b_o;
      mOpY4_odd_o_reg<=mOpY4_odd_o;
      mOpY4_split_o_reg<=mOpY4_split_o;
      mOpY4_data_o_reg<=mOpY4_data_o|~mOpY4_dataN_o;
      mOpY4_pbit_o_reg<=mOpY5_pbit_o;
      mOpY4_d128_o_reg<=get_d128(mOpY4_sz_o);

      mOpY4_addrEven_o_reg2<=mOpY4_addrEven_o_reg;
      mOpY4_addrOdd_o_reg2<=mOpY4_addrOdd_o_reg;
      mOpY4_banks_o_reg2<=mOpY4_banks_o_reg;
      mOpY4_bank0_o_reg2<=mOpY4_bank0_o_reg;
      mOpY4_bank1_o_reg2<=mOpY4_bank1_o_reg;
      mOpY4_bgn_b_o_reg2<=mOpY4_bgn_b_o_reg;
      mOpY4_end_b_o_reg2<=mOpY4_end_b_o_reg;
      mOpY4_odd_o_reg2<=mOpY4_odd_o_reg;
      mOpY4_split_o_reg2<=mOpY4_split_o_reg;
      mOpY4_data_o_reg2<=mOpY4_data_o_reg;
      mOpY4_pbit_o_reg2<=mOpY5_pbit_o_reg;
      mOpY4_d128_o_reg2<=mOpY5_d128_o_reg;

      mOpY4_addrEven_o_reg3<=mOpY4_addrEven_o_reg2;
      mOpY4_addrOdd_o_reg3<=mOpY4_addrOdd_o_reg2;
      mOpY4_banks_o_reg3<=mOpY4_banks_o_reg2;
      mOpY4_bank0_o_reg3<=mOpY4_bank0_o_reg2;
      mOpY4_bank1_o_reg3<=mOpY4_bank1_o_reg2;
      mOpY4_bgn_b_o_reg3<=mOpY4_bgn_b_o_reg2;
      mOpY4_end_b_o_reg3<=mOpY4_end_b_o_reg2;
      mOpY4_odd_o_reg3<=mOpY4_odd_o_reg2;
      mOpY4_split_o_reg3<=mOpY4_split_o_reg2;
      mOpY4_data_o_reg3<=mOpY4_data_o_reg2;
      mOpY4_pbit_o_reg3<=mOpY5_pbit_o_reg2;
      mOpY4_d128_o_reg3<=mOpY5_d128_o_reg2;

      mOpY5_addrEven_o_reg<=mOpY5_addrEven_o;
      mOpY5_addrOdd_o_reg<=mOpY5_addrOdd_o;
      mOpY5_banks_o_reg<=mOpY5_banks_o;
      mOpY5_bank0_o_reg<=mOpY5_bank0_o;
      mOpY5_bank1_o_reg<=mOpY5_bank1_o;
      mOpY5_bgn_b_o_reg<=mOpY5_bgn_b_o;
      mOpY5_end_b_o_reg<=mOpY5_end_b_o;
      mOpY5_odd_o_reg<=mOpY5_odd_o;
      mOpY5_split_o_reg<=mOpY5_split_o;
      mOpY5_data_o_reg<=mOpY5_data_o|~mOpY5_dataN_o;
      mOpY5_pbit_o_reg<=mOpY5_pbit_o;
      mOpY5_d128_o_reg<=get_d128(mOpY5_sz_o);

      mOpY5_addrEven_o_reg2<=mOpY5_addrEven_o_reg;
      mOpY5_addrOdd_o_reg2<=mOpY5_addrOdd_o_reg;
      mOpY5_banks_o_reg2<=mOpY5_banks_o_reg;
      mOpY5_bank0_o_reg2<=mOpY5_bank0_o_reg;
      mOpY5_bank1_o_reg2<=mOpY5_bank1_o_reg;
      mOpY5_bgn_b_o_reg2<=mOpY5_bgn_b_o_reg;
      mOpY5_end_b_o_reg2<=mOpY5_end_b_o_reg;
      mOpY5_odd_o_reg2<=mOpY5_odd_o_reg;
      mOpY5_split_o_reg2<=mOpY5_split_o_reg;
      mOpY5_data_o_reg2<=mOpY5_data_o_reg;
      mOpY5_pbit_o_reg2<=mOpY5_pbit_o_reg;
      mOpY5_d128_o_reg2<=mOpY5_d128_o_reg;

      mOpY5_addrEven_o_reg3<=mOpY5_addrEven_o_reg2;
      mOpY5_addrOdd_o_reg3<=mOpY5_addrOdd_o_reg2;
      mOpY5_banks_o_reg3<=mOpY5_banks_o_reg2;
      mOpY5_bank0_o_reg3<=mOpY5_bank0_o_reg2;
      mOpY5_bank1_o_reg3<=mOpY5_bank1_o_reg2;
      mOpY5_bgn_b_o_reg3<=mOpY5_bgn_b_o_reg2;
      mOpY5_end_b_o_reg3<=mOpY5_end_b_o_reg2;
      mOpY5_odd_o_reg3<=mOpY5_odd_o_reg2;
      mOpY5_split_o_reg3<=mOpY5_split_o_reg2;
      mOpY5_data_o_reg3<=mOpY5_data_o_reg2;
      mOpY5_pbit_o_reg3<=mOpY5_pbit_o_reg2;
      mOpY5_d128_o_reg3<=mOpY5_d128_o_reg2;

      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) p0_en_reg<=p0_en;
      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) p1_en_reg<=p1_en;
      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) p2_en_reg<=p2_en;
      if (~(rsStall[3]&~now_flushing&~alt_bus_hold_reg)) p3_en_reg<=p3_en;
      if (~(rsStall[0]&~now_flushing&~alt_bus_hold_reg)) p0_adata_reg<=p0_adata;
      if (~(rsStall[1]&~now_flushing&~alt_bus_hold_reg)) p1_adata_reg<=p1_adata;
      if (~(rsStall[2]&~now_flushing&~alt_bus_hold_reg)) p2_adata_reg<=p2_adata;
      if (~(rsStall[3]&~now_flushing&~alt_bus_hold_reg)) p3_adata_reg<=p3_adata;

      mcam_addr_reg<=mcam_addr;
      mcam_st_reg<=mcam_st;
      mcam_cldupl_reg<=mcam_cldupl;
      mcam_sz_reg<=mcam_sz;
      mcam_bank0_reg<=mcam_bank0;
      mcam_low_reg<=mcam_low;
      mcam_io_reg<=mcam_io;
      mOpR_en_reg<=mOpR_en& (|miss_clDo);

      now_flushing_reg<=now_flushing;
      
      if (rst|(miss_next&&~mOpR_stall|~mOpR_en)) begin
          miss_doneEven<=1'b0;
          miss_doneOdd<=1'b0;
      end else begin
          if (miss_clDo[0] && mOpR_en && mcam_hasfree) miss_doneEven<=1'b1;
          if (miss_clDo==2'b10 && mOpR_en && mcam_hasfree) miss_doneOdd<=1'b1;
      end

      if (rst) begin
          reqBus_en<=1'b0;
          reqBus_req<=10'b0;
          reqBus_addr<=37'b0;
          reqBus_want_excl<=1'b0;
          reqBus_dupl<=1'b0;
	  reqBus_sz<=5'b0;
	  reqBus_low<=2'b0;
	  reqBus_bank0<=5'd0;
	  reqBus_io<=1'b0;
      end else begin
          reqBus_en<=mOpR_en;
          reqBus_req<={BUS_ID,1'b0,mOpR_req};
          reqBus_addr<=mOpR_addr;
          reqBus_want_excl<=mOpR_st;
          reqBus_dupl<=mOpR_dupl;
	  reqBus_sz<=mOpR_sz;
	  reqBus_low<=mOpR_addr_low;
	  reqBus_bank0<=mOpR_bank0;
	  reqBus_io<=mOpR_io;
      end

      if (rst) begin
          all_clear_pre=1'b0;
          all_clear<=1'b0;
      end else begin
          if (now_flushing && ~now_flushing_reg) all_clear_pre=1'b1;
          if (now_flushing_reg && p0_repl|p1_repl|p2_repl|p3_repl) begin
              all_clear_pre=1'b0;
          end
          if (~now_flushing & now_flushing_reg) all_clear<=all_clear_pre;
          else all_clear<=all_clear&&~(miss0|miss1|miss2|miss3);
      end
      FU0_reg<=FU0;
      FU1_reg<=FU1;
      FU2_reg<=FU2;
      FU3_reg<=FU3;
      FU4_reg<=FU4;
      FU5_reg<=FU5;
      FU6_reg<=FU6;
      FU7_reg<=FU7;
      FU8_reg<=FU8;
      FU9_reg<=FU9;
      if (rst) begin
          insert_isData_reg<=1'b0;
          insert_isData_reg2<=1'b0;
	  insBus_addr_reg<=37'b0;
	  insBus_addr_reg2<=37'b0;
      end else begin
          insert_isData_reg<=insert_isData;
          insert_isData_reg2<=insert_isData_reg;
	  insBus_addr_reg<=insBus_addr;
	  insBus_addr_reg2<=insBus_addr_reg;
      end
  end
endmodule
