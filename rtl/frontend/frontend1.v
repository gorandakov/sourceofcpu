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


module frontend1(
  clk,
  rst,
  except,
  exceptIP,
  exceptThread,
  exceptAttr,
  exceptDueJump,
  exceptJumpGHT,
  exceptLDConfl,
  except_jmask,
  except_jmask_en,
  jupd0_en,jupdt0_en,jupd0_ght_en,jupd0_addr,jupd0_baddr,jupd0_sc,jupd0_tk,
  jupd1_en,jupdt1_en,jupd1_ght_en,jupd1_addr,jupd1_baddr,jupd1_sc,jupd1_tk,
  bus_data,
  bus_slot,
  bus_en,
  req_addr,
  req_slot,
  req_en,
  req_tlbEn,
  req_tlbAttr,
  bus_tlb_data,
  bus_tlb_slot,
  bus_tlb_en,
  miss_now,
  tlbMiss_now,
  miss_now_in,
  instr0,instr1,instr2,instr3,
  instr4,instr5,instr6,instr7,
  instr8,instr9,
  extra0,extra1,extra2,extra3,
  extra4,extra5,extra6,extra7,
  extra8,extra9,
  instrEat,
  iAvail,
  stall,
  btbl_step,
  btbl_IP0,
  btbl_IP1,
  btbl_mask0,
  btbl_mask1,
  btbl_attr0,
  btbl_attr1,
  csrss_en,csrss_addr,csrss_data,
  cc_instrEn,
  cc_read_set_flag,
  cc_fstall,
  cc_except,
  cc_IP_phys,
  cc_read_hit,
  cc_read_tagErr,
  cc_read_data,
  cc_read_dataX,
  cc_write_IP,
  cc_write_wen,
  cc_invalidate,
  cc_write_data,
  MSI_expAddr,
  MSI_expAddr_en,
  MSI_expAddr_hit,
  expun_addr,
  expun_wen
  );

  parameter [0:0] thread=0;
  localparam PHYS_WIDTH=44;
  localparam VIRT_WIDTH=64;
  localparam IP_WIDTH=64;
  localparam [63:0] INIT_IP=64'hf80ff00000000000;
  localparam [3:0] INIT_ATTR=4'b0;
  localparam BUS_BANK=32;
  localparam BUS_WIDTH=BUS_BANK*16;
  localparam DATA_WIDTH=65*8;
  localparam INSTR_WIDTH=80;
  localparam CLS_WIDTH=13;
  parameter [4:0] BUS_ID=0;
/*verilator public_module*/ 
  input clk;
  input rst;
  input except;
  input [VIRT_WIDTH-1:0] exceptIP;
  input exceptThread;
  input [3:0] exceptAttr;
  input exceptDueJump;
  input [7:0] exceptJumpGHT;
  input exceptLDConfl;
  input [3:0] except_jmask;
  input except_jmask_en;
  input jupd0_en;
  input jupdt0_en;
  input jupd0_ght_en;
  input [15:0] jupd0_addr;
  input [12:0] jupd0_baddr;
  input [1:0] jupd0_sc;
  input jupd0_tk;
  input jupd1_en;
  input jupdt1_en;
  input jupd1_ght_en;
  input [15:0] jupd1_addr;
  input [12:0] jupd1_baddr;
  input [1:0] jupd1_sc;
  input jupd1_tk;



  input [BUS_WIDTH-1:0] bus_data;
  input [9:0] bus_slot;
  input bus_en;
  
  output [37:0] req_addr;
  output [9:0] req_slot;
  output req_en;
  output req_tlbEn;
  output [3:0] req_tlbAttr;

  input [`ctlbData_width-1:0] bus_tlb_data;
  input [9:0] bus_tlb_slot;
  input bus_tlb_en;

  output miss_now;
  output tlbMiss_now;
  input miss_now_in;

  output [INSTR_WIDTH-1:0] instr0;
  output [INSTR_WIDTH-1:0] instr1;
  output [INSTR_WIDTH-1:0] instr2;
  output [INSTR_WIDTH-1:0] instr3;
  output [INSTR_WIDTH-1:0] instr4;
  output [INSTR_WIDTH-1:0] instr5;
  output [INSTR_WIDTH-1:0] instr6;
  output [INSTR_WIDTH-1:0] instr7;
  output [INSTR_WIDTH-1:0] instr8;
  output [INSTR_WIDTH-1:0] instr9;

  output [`instrQ_width-1:0] extra0;
  output [`instrQ_width-1:0] extra1;
  output [`instrQ_width-1:0] extra2;
  output [`instrQ_width-1:0] extra3;
  output [`instrQ_width-1:0] extra4;
  output [`instrQ_width-1:0] extra5;
  output [`instrQ_width-1:0] extra6;
  output [`instrQ_width-1:0] extra7;
  output [`instrQ_width-1:0] extra8;
  output [`instrQ_width-1:0] extra9;


  input [9:0] instrEat;
  output [9:0] iAvail;
  input stall;
  
  input [2:0] btbl_step;
  output [IP_WIDTH-2:0] btbl_IP0;
  output [IP_WIDTH-2:0] btbl_IP1;
  output [3:0] btbl_mask0;
  output [3:0] btbl_mask1;
  output [3:0] btbl_attr0;
  output [3:0] btbl_attr1;
  
  input csrss_en;
  input [15:0] csrss_addr;
  input [63:0] csrss_data;
  output cc_instrEn=instrEn;
  output cc_read_set_flag=read_set_flag_reg;
  output cc_fstall=fstall;
  output cc_except=ixcept;
  output [PHYS_WIDTH-1:0] cc_IP_phys=IP_phys_reg;
  input cc_read_hit;
  input cc_read_tagErr;
  input [DATA_WIDTH/2-1:0] cc_read_data;
  assign read_data=cc_read_data;
  input [14:0] cc_read_dataX;
  assign read_dataX=cc_read_dataX;
  output [PHYS_WIDTH-1:0] cc_write_IP={write_IP,5'b0};
  output cc_write_wen=bus_match_reg;
  output cc_invalidate=1'b0;
  output [DATA_WIDTH-1:0] cc_write_data=write_data;
  
  input [36:0] MSI_expAddr;
  input MSI_expAddr_en;
  output MSI_expAddr_hit;
  output [36:0] expun_addr;
  output expun_wen;

  wire [DATA_WIDTH/2-1:0] read_data;
  wire [14:0] read_dataX;
  wire [16:0] read_dataY; 
  wire [DATA_WIDTH/2-1:0] read_data_reg;
  wire instrFed;
  reg instrFed_reg;

  wire do_seq_any,do_seq_miss;

  wire [63:0] cc_read_IP_d;
//  wire [63:0] tr_read_IP_d;
  wire do_seq;
  reg do_seq_reg;
  reg do_seq_reg2;
  reg do_seq_reg3;
  reg do_seq_reg4;
  reg do_seq_reg5;
  reg miss_now;
  reg tlbMiss_now;
  reg miss_now_reg;
  reg [63:0] cc_read_IP;
  reg [63:0] cc_read_IP_reg;
  reg [63:0] cc_read_IP_reg2;
  reg [63:0] cc_read_IP_reg3;
  reg [63:0] cc_read_IP_reg4;
  reg [63:0] cc_read_IP_reg5;
 // reg [47:0] cc_read_IP_REG3;
 // reg [47:0] cc_read_IP_REG4;
  reg  [63:0] cc_base_IP;
  wire [63:0] cc_base_IP_d;
  wire [8:0] cc_base_dummy9;
  wire [8:0] cc_base_dummy9dec;
  wire cc_base_sec;
  wire cc_base_tick;
  reg cc_base_tick_reg;
  reg cc_base_tick_reg2;
  reg cc_base_tick_reg3;
  reg cc_base_tick_reg4;
  reg proturberan;
  wire [3:0] cc_base_off;
  reg [3:0] cc_base_off_reg;
  reg [3:0] cc_base_off_reg2;
  reg [3:0] cc_base_off_reg3;
  reg [3:0] cc_base_off_reg4;
 
  reg [3:0]  cc_attr;
  wire [3:0] btbx_attr; 

  wire [3:0] cc_attr_d;
  wire [3:0] ixceptAttr;
  reg [63:0] miss_IP;
  //reg [47:0] link_IP;
  reg [23:0] proc;
  reg kmode;
  
  reg instrEn;
  reg instrEn_reg;
  reg instrEn_reg2;
  reg instrEn_reg3;
  reg new_instrEn;
 
  wire cc_read_hit;
  wire miss_recover;

 // wire [47:0] link_IP_d;
  
  wire [`ctlbData_width-1:0] tlb_data;
  reg [`ctlbData_width-1:0] tlb_data_reg;
  reg [`ctlbData_width-1:0] tlb_data_reg2;
  reg [`ctlbData_width-1:0] tlb_data_reg3;
  wire [PHYS_WIDTH-13:0] tlb_phys;
  wire tlb_nx;
  wire tlb_na;
  wire tlb_sys;
  wire tlb_match;

  reg [PHYS_WIDTH-13:0] tlb_phys_reg;

  wire [PHYS_WIDTH-13:0] read_physOut;
  reg miss_seq;
  reg [4:0] miss_cnt;
  wire [4:0] miss_cnt_next;
  reg [2:0] miss_slot;
  wire [2:0] miss_slot_next;

  reg [PHYS_WIDTH-14:0] miss_phys;
  
  wire req_en0,req_en1;
  //wire overpage;
  reg IP_chg,IP_chg_reg,IP_chg_reg2,IP_chg_reg3,IP_chg_reg4;
  
  wire tlb_hit;
  reg tlb_hit_reg;
  reg tlb_hit_reg2;
  reg tlb_hit_reg3;
  reg tlb_hit_reg4;
 
  wire [PHYS_WIDTH-1:0] IP_phys; 
  wire [DATA_WIDTH-1:0] write_data;
  reg [BUS_WIDTH-1:0] bus_data_reg;
  wire bus_match;
  reg bus_match_reg;
  reg [PHYS_WIDTH-1:0] IP_phys_reg; 
  reg [PHYS_WIDTH-1:0] IP_phys_reg2; 
  reg [PHYS_WIDTH-1:0] IP_phys_reg3; 
  
  wire [VIRT_WIDTH-26:0] write_IP;
  wire [VIRT_WIDTH-28:0] req_addrR;
  wire [PHYS_WIDTH-14:0] req_addrP;
  wire [VIRT_WIDTH-13:0] tlb_IP;
  
  wire bus_tlb_match;
  reg bus_tlb_match_reg;
  reg bus_tlb_match_reg2;
  reg bus_tlb_match_reg3;
  reg [`ctlbData_width-1:0] bus_tlb_data_reg;
  
  wire [7:0] cc_tagErr;
  
  reg init;
  reg [8:0] initCount;
  wire [8:0] initCount_next;
  
  
  wire bus_match0;
  reg bus_match0_reg;
  reg bus_match0_reg2;
  reg bus_match0_reg3;
  reg bus_match0_reg4;
  
  wire [11:0] pre_instrEn;
  wire [INSTR_WIDTH-1:0] pre_instr0;
  wire [INSTR_WIDTH-1:0] pre_instr1;
  wire [INSTR_WIDTH-1:0] pre_instr2;
  wire [INSTR_WIDTH-1:0] pre_instr3;
  wire [INSTR_WIDTH-1:0] pre_instr4;
  wire [INSTR_WIDTH-1:0] pre_instr5;
  wire [INSTR_WIDTH-1:0] pre_instr6;
  wire [INSTR_WIDTH-1:0] pre_instr7;
  wire [INSTR_WIDTH-1:0] pre_instr8;
  wire [INSTR_WIDTH-1:0] pre_instr9;
  wire [INSTR_WIDTH-1:0] pre_instr10;
  wire [INSTR_WIDTH-1:0] pre_instr11;

  reg [12:0] pre_instrEn_reg/*verilator public*/;
  reg [INSTR_WIDTH-1:0] pre_instr0_reg/*verilator public*/;
  reg [INSTR_WIDTH-1:0] pre_instr1_reg/*verilator public*/;
  reg [INSTR_WIDTH-1:0] pre_instr2_reg/*verilator public*/;
  reg [INSTR_WIDTH-1:0] pre_instr3_reg/*verilator public*/;
  reg [INSTR_WIDTH-1:0] pre_instr4_reg/*verilator public*/;
  reg [INSTR_WIDTH-1:0] pre_instr5_reg/*verilator public*/;
  reg [INSTR_WIDTH-1:0] pre_instr6_reg/*verilator public*/;
  reg [INSTR_WIDTH-1:0] pre_instr7_reg/*verilator public*/;
  reg [INSTR_WIDTH-1:0] pre_instr8_reg/*verilator public*/;
  reg [INSTR_WIDTH-1:0] pre_instr9_reg/*verilator public*/;
  reg [INSTR_WIDTH-1:0] pre_instr10_reg/*verilator public*/;
  reg [INSTR_WIDTH-1:0] pre_instr11_reg/*verilator public*/;

  wire [11:0][3:0] pre_off/*verilator public*/;
  reg [3:0] pre_off_reg[11:0]/*verilator public*/;
  
  wire [11:0][3:0] pre_magic/*verilator public*/;
  reg  [3:0] pre_magic_reg[11:0]/*verilator public*/;
  wire [11:0][`instrQ_width-1:0] pre_other/*verilator public*/;
//  reg [`instrQ_width-1:0] pre_other_reg[11:0];
  
  wire pre_isAvx;
  reg pre_isAvx_reg;
  wire [11:0][CLS_WIDTH-1:0] pre_class;
  reg [CLS_WIDTH-1:0] pre_class_reg[11:0]/*verilator public*/;
  wire pre_has_jumps;
 // wire [3:0] jFirst;
 // wire [4:0] jmpCount;
  
  wire pre_error;
  
  reg [7:0] dreq; 
  reg [7:0] dreq_reg; 
  reg [7:0] dreq_reg2; 
  reg [7:0] dreq_reg3; 
  reg [7:0] dreq_reg4; 

  reg except_save;
  reg [VIRT_WIDTH-1:0] exceptIP_save;
  reg [3:0] exceptAttr_save;
  reg exceptThread_save;
  reg exceptLDConfl_save;
  reg exceptDueJump_save;
  reg [7:0] exceptJumpGHT_save;
  reg [3:0] except_jmask_save;
  reg except_jmask_en_save;
  reg ixcept;
  reg ixcept_reg;
  wire uxcept;
  wire [VIRT_WIDTH-1:0] ixceptIP;
  wire ixceptThread;
  wire ixceptDueJump;
  wire ixceptLDConfl;
  wire [7:0] ixceptJumpGHT;
  wire [3:0] ixcept_jmask;
  wire ixcept_jmask_en;
//  reg ixcept_reg;
//  reg ixceptLDConfl_reg;

  wire fstall;
  wire fmstall;
  wire iq_fstall;
  wire jq_fstall;
  wire btbFStall;
  reg btbFStall_save;
  reg btbFStall_reg;
  reg btbFStall_reg2;
  reg btbFStall_reg3;
//  reg btbFStall_reg4;
//  reg btbFStall_reg5;

  reg btbFStall_recover;
  reg btbFStall_recover_reg;
  reg btbFStall_recover_reg2;
    
  wire [3:0][3:0] jmp_off;
  reg [3:0] jmp_off_reg[3:0];
  wire [3:0][63:0] jdec_const;
  reg [63:0] jdec_const_reg[3:0];
  wire [3:0] jdec_bkjump;
  wire [3:0][INSTR_WIDTH-1:0] jmp_instr;
  wire [3:0][3:0] jmp_magic;
  wire [3:0][CLS_WIDTH-1:0] jmp_class;
  wire [3:0] jdec_push;
  wire [3:0] jdec_pop;
  wire [3:0][4:0] jdec_type;
  wire [3:0][3:0] jdec_attr;
  wire [4:0] jdec_link0;
  wire [4:0] jdec_link1;
  wire [4:0] jdec_link2;
  wire [4:0] jdec_link3;
  wire btb_way;
  reg  btb_way_reg;
  reg  btb_way_reg2;
  wire [3:0][3:0] jmp_moff;
  reg [3:0] jmp_moff_reg[3:0];
  wire [3:0][43:1] jmp_par0;
  wire [3:0][43:1] jmp_par1;
  wire [3:0][43:1] jmp_tpar0;
  wire [3:0][43:1] jmp_tpar1;
  wire [3:0][63:1] jdec_target;
  wire [3:0] jdec_sec;
  wire [3:0][3:0] jmp_mask;
  reg [3:0] jmp_mask_reg[3:0];
  reg [3:0] jmp_mask_reg2[3:0];
  reg [3:0] jmp_mask_reg3[3:0];
  reg [3:0] jmp_mask_reg4[3:0];
  wire [3:0] jmp_en;
  wire [4:0] lnk_link0;
  wire [4:0] lnk_link1;
  wire [4:0] lnk_link2;
  wire [4:0] lnk_link3;
  wire [4:0] lnk_off0;
  wire [4:0] lnk_off1;
  wire [4:0] lnk_off2;
  wire [4:0] lnk_off3;
  wire lnk_isRet0;
  wire lnk_isRet1;
  wire lnk_isRet2;
  wire lnk_isRet3;
  wire [4:0] lnk_jpos0;
  wire [4:0] lnk_jpos1;
  wire [4:0] lnk_jpos2;
  wire [4:0] lnk_jpos3;
  wire [3:0] lnk_magic0;
  wire [3:0] lnk_magic1;
  wire [3:0] lnk_magic2;
  wire [3:0] lnk_magic3;
  reg [4:0] lnk_link0_reg;
  reg [4:0] lnk_link1_reg;
  reg [4:0] lnk_link2_reg;
  reg [4:0] lnk_link3_reg;
  reg [4:0] lnk_off0_reg;
  reg [4:0] lnk_off1_reg;
  reg [4:0] lnk_off2_reg;
  reg [4:0] lnk_off3_reg;
  reg lnk_isRet0_reg;
  reg lnk_isRet1_reg;
  reg lnk_isRet2_reg;
  reg lnk_isRet3_reg;
  reg [3:0] lnk_magic0_reg;
  reg [3:0] lnk_magic1_reg;
  reg [3:0] lnk_magic2_reg;
  reg [3:0] lnk_magic3_reg;
  reg [4:0] lnk_jpos0_reg;
  reg [4:0] lnk_jpos1_reg;
  reg [4:0] lnk_jpos2_reg;
  reg [4:0] lnk_jpos3_reg;
  wire jmp_error;
  wire lnk_offIn_cc,lnk_offIn_tr,lnk_offIn;
    
  wire [3:0] taken;
  reg [3:0] taken_reg;
  reg [3:0] taken_reg2;
  reg [3:0] taken_reg3;
  reg [3:0] taken_reg4;
  reg [3:0] taken_REG;
  wire [3:0] takenA;
  wire [3:0] takenB;
  wire btb_hasTK;
  reg btb_hasTK_reg;
  reg btb_hasTK_reg2;
  reg btb_hasTK_reg3;
  reg btb_hasTK_reg4;

  wire [7:0] GHT_d;
  wire [7:0] GHTt_d;
  wire [3:0] GHTx;
  reg [7:0] GHT;
  reg [7:0] GHT_reg;
  reg [7:0] GHT_reg2;
  reg [7:0] GHT_reg3;
  reg [7:0] GHT_reg4;
  wire [4:0] start;
  wire [4:0] start2;
  wire [4:0] startt;
  wire [4:0] startx;
  reg  [4:0] startx_reg;
  reg  [4:0] startx_reg2;
  reg  [4:0] startx_reg3;
  reg  [4:0] startx_reg4;

`define ZERO 4
  wire [3:0] btb_indir;
  wire [4:0]       btb_jlink0;
  wire [`ZERO:0]  btb_jlnpos0;
  wire [`ZERO:0] btb_jlnjpos0;
  wire [4:0]       btb_jlink1;
  wire [`ZERO:0]  btb_jlnpos1;
  wire [`ZERO:0] btb_jlnjpos1;
  wire [4:0]       btb_jlink2;
  wire [`ZERO:0]  btb_jlnpos2;
  wire [`ZERO:0] btb_jlnjpos2;
  wire [4:0]       btb_jlink3;
  wire [`ZERO:0]  btb_jlnpos3;
  wire [`ZERO:0] btb_jlnjpos3;
  wire btb_in_link,btb_in_ret;
  wire [11:0] pre_jbefore;
  wire [11:0] pre_jbefore0;
  wire [3:0] last_off;
  wire [3:0][3:0] btb_joff;
  reg [3:0] last_off_reg;
  reg [3:0] last_off_reg2;
  reg [3:0] last_off_reg3;
  reg [3:0] last_off_reg4;
  wire [67:1] rstack_dataW;
  wire [67:1] rstack_dataR;
  
  wire btb_has0,btb_has1,btb_has2,btb_has3;
  wire [1:0] btb_sc0A;
  wire [1:0] btb_sc1A;
  wire [1:0] btb_sc2A;
  wire [1:0] btb_sc3A;
  wire [1:0] btb_sc0B;
  wire [1:0] btb_sc1B;
  wire [1:0] btb_sc2B;
  wire [1:0] btb_sc3B;
  wire btb_hit;
  reg btb_hit_reg;
  reg btb_hit_reg2;
  reg btb_hit_reg3;
  wire [3:0] btb_jmask;
  wire [3:0] btb_jmask2;
  wire [3:0] btb_chmaskB;
  wire [3:0] btb_chmaskA;
  wire [3:0] btb_predB;
  wire [3:0] btb_predA;
  wire [3:0] btb_cond;
  wire [63:0] btb_tgt;
  wire [62:0] btb_tgt0;
  wire [62:0] btb_tgt1;
  wire [62:0] btb_tgt2;
  wire [62:0] btb_tgt3;
  wire [1:0] pred_sc0A;
  wire [1:0] pred_sc1A;
  wire [1:0] pred_sc2A;
  wire [1:0] pred_sc3A;
  wire [1:0] pred_sc0B;
  wire [1:0] pred_sc1B;
  wire [1:0] pred_sc2B;
  wire [1:0] pred_sc3B;
  
  wire btb_can_ins;
  
  wire [3:0] btbx_jmask;
  wire [1:0] predx_sc0;
  wire [1:0] predx_sc1;
  wire [1:0] predx_sc2;
  wire [1:0] predx_sc3;
  wire [1:0] predy_sc0;
  wire [1:0] predy_sc1;
  wire [1:0] predy_sc2;
  wire [1:0] predy_sc3;
  reg [1:0] predx_sc0_reg;
  reg [1:0] predx_sc1_reg;
  reg [1:0] predx_sc2_reg;
  reg [1:0] predx_sc3_reg;
  reg [1:0] predx_sc0_reg2;
  reg [1:0] predx_sc1_reg2;
  reg [1:0] predx_sc2_reg2;
  reg [1:0] predx_sc3_reg2;
  reg [1:0] predx_sc0_reg3;
  reg [1:0] predx_sc1_reg3;
  reg [1:0] predx_sc2_reg3;
  reg [1:0] predx_sc3_reg3;
  reg [1:0] predx_sc0_reg4;
  reg [1:0] predx_sc1_reg4;
  reg [1:0] predx_sc2_reg4;
  reg [1:0] predx_sc3_reg4;
 
  reg [3:0] btbx_jmask_reg;
  reg [3:0] btbx_jmask_REG;
  wire [3:0] iqe_jbits;
  wire [5:0] iqe_jcnt;
  wire [3:0] iqe_jbitZ;
  wire [5:0] iqe_jcnD;
  reg [5:0] iqe_jcnt_reg;
  reg [5:0] iqe_jcnt_reg2;


  wire [63:0] btbx_tgt;
  wire [4:0]       btbx_jlink0;
  wire [`ZERO:0]  btbx_jlnpos0;
  wire [`ZERO:0] btbx_jlnjpos0;
  wire [4:0]       btbx_jlink1;
  wire [`ZERO:0]  btbx_jlnpos1;
  wire [`ZERO:0] btbx_jlnjpos1;
  wire [4:0]       btbx_jlink2;
  wire [`ZERO:0]  btbx_jlnpos2;
  wire [`ZERO:0] btbx_jlnjpos2;
  wire [4:0]       btbx_jlink3;
  wire [`ZERO:0]  btbx_jlnpos3;
  wire [`ZERO:0] btbx_jlnjpos3;
  wire [3:0][3:0] btbx_joff;
  reg  [3:0] btbx_joff_reg[3:0];
  reg  [3:0] btbx_joff_reg2[3:0];
  reg  [3:0] btbx_joff_reg3[3:0];
  reg  [3:0] btbx_joff_reg4[3:0];
  reg  btbxx_way_reg;
  wire [62:0] btbx_tgt0;
  wire [62:0] btbx_tgt1;
  wire [62:0] btbx_tgt2;
  wire [62:0] btbx_tgt3;
  reg [62:0] btbx_tgt0_reg;
  reg [62:0] btbx_tgt1_reg;
  reg [62:0] btbx_tgt2_reg;
  reg [62:0] btbx_tgt3_reg;
  reg [62:0] btbx_tgt0_reg2;
  reg [62:0] btbx_tgt1_reg2;
  reg [62:0] btbx_tgt2_reg2;
  reg [62:0] btbx_tgt3_reg2;
  reg [62:0] btbx_tgt0_reg3;
  reg [62:0] btbx_tgt1_reg3;
  reg [62:0] btbx_tgt2_reg3;
  reg [62:0] btbx_tgt3_reg3;
  reg [62:0] btbx_tgt0_reg4;
  reg [62:0] btbx_tgt1_reg4;
  reg [62:0] btbx_tgt2_reg4;
  reg [62:0] btbx_tgt3_reg4;
  wire [3:0] btbx_cond;
  reg [3:0] btbx_cond_reg;
  reg [3:0] btbx_cond_reg2;
  reg [3:0] btbx_cond_reg3;
  reg [3:0] btbx_cond_reg4;
  reg btb_can_ins_reg;
  reg btbt_can_ins_reg;
  reg btb_can_ins_reg2;
  reg btbt_can_ins_reg2;
  reg btb_can_ins_reg3;
  reg btbt_can_ins_reg3;
  reg btb_can_ins_reg4;
  
  wire btbt_can_ins;
  
  wire btb_hold_except;
  reg read_set_flag,read_set_flag_reg;
  
  reg [3:0] btbx_attr0_reg;
  reg [3:0] btbx_attr1_reg;
  reg [3:0] btbx_attr2_reg;
  reg [3:0] btbx_attr3_reg;
  reg [3:0] btbx_attr0_reg2;
  reg [3:0] btbx_attr1_reg2;
  reg [3:0] btbx_attr2_reg2;
  reg [3:0] btbx_attr3_reg2;
  reg [3:0] btbx_attr0_reg3;
  reg [3:0] btbx_attr1_reg3;
  reg [3:0] btbx_attr2_reg3;
  reg [3:0] btbx_attr3_reg3;
  reg [3:0] btbx_attr0_reg4;
  reg [3:0] btbx_attr1_reg4;
  reg [3:0] btbx_attr2_reg4;
  reg [3:0] btbx_attr3_reg4;
//  wire tr_odd_d,tr_half_d;
//  reg tr_odd,tr_odd_reg,tr_odd_reg2;
//  reg tr_half,tr_half_reg,tr_half_reg2;

  wire jlnin,jlnint,jlninx;  
  
  wire [511:0] bus_data_cvt;

  wire [5:0] lpar30;
  wire [5:0] lpar31;
  wire [5:0] lpar20;
  wire [5:0] lpar21;
  wire [5:0] lpar10;
  wire [5:0] lpar11;
  wire [5:0] lpar00;
  wire [5:0] lpar01;
 // wire [5:0] lcpar0;
  //wire [5:0] lcpar1;
//  wire instrEn2=instr
  wire jumpTK_btb_fstall;
  reg jumpTK_en;
  reg [63:0] jumpTK_addr;
  reg [3:0] jumpTK_attr;

  wire [3:0] btb_attr0;
  wire [3:0] btb_attr1;
  wire [3:0] btb_attr2;
  wire [3:0] btb_attr3;
  wire [3:0] btbx_attr0;
  wire [3:0] btbx_attr1;
  wire [3:0] btbx_attr2;
  wire [3:0] btbx_attr3;
  wire [3:0] btb_attr;
  wire jlninx0,jlninx1,jlninx2,jlninx3;
  wire jlnin0,jlnin1,jlnin2,jlnin3;
  wire [4:0] btbx_jlnoff;
  wire [4:0] btb_jlnoff;
  wire [4:0] btbx_lnpos0;
  wire [4:0] btbx_lnpos1;
  wire [4:0] btbx_lnpos2;
  wire [4:0] btbx_lnpos3;
  wire [4:0] btb_lnpos0;
  wire [4:0] btb_lnpos1;
  wire [4:0] btb_lnpos2;
  wire [4:0] btb_lnpos3;
  wire btb_jlnin0,btb_jlnin1,btb_jlnin2,btb_jlnin3;

  integer m,n,t;

  generate
      genvar k,j;
      for(k=0;k<4;k=k+1) begin : ecc_strip_gen
          wire par0,par1;
          //front_strip_ECC ecc0_mod(bus_data_reg[39*2*k+:39],write_data[65*k+:32],par0);
          //front_strip_ECC ecc1_mod(bus_data_reg[39*2*k+39+:39],write_data[65*k+32+:32],par1);
          assign write_data[65*k+:64]=bus_data_cvt[64*k+:64];
          assign write_data[65*k+64]=^bus_data_cvt[64*k+:64];
          assign write_data[65*(k+4)+:64]=bus_data_cvt[64*(k+4)+:64];
          assign write_data[65*(k+4)+64]=^bus_data_cvt[64*(k+4)+:64];
                    
          assign jmp_moff[k]=jmp_magic[k][0] ? 4'd1 : 4'bz;
          assign jmp_moff[k]=(jmp_magic[k][1:0]==2'b10) ? 4'd2 : 4'bz;
          assign jmp_moff[k]=(jmp_magic[k][2:0]==3'b100) ? 4'd3 : 4'bz;
          assign jmp_moff[k]=(jmp_magic[k][3:0]==4'b1000) ? 4'd4 : 4'bz;
          assign jmp_moff[k]=(jmp_magic[k][3:0]==4'b0) ? 4'd5 : 4'bz;
          
          assign last_off=taken[k] ? btbx_joff[k] : 4'bz;
          
          assign jdec_bkjump[k]=jdec_const_reg[k][63];
          
          assign btbx_joff[k]=btb_joff[k]; 
          
          //adder_CSA #(43) cs1_mod({cc_read_IP_reg3[43:5],jmp_off_reg[k]},{39'b0,jmp_moff_reg[k]},jdec_const_reg[k][43:1], {par0,jmp_par0[k]}, {par1,jmp_par1[k]});
          //adder #(43) add1_mod(jmp_par0[k], jmp_par1[k],jdec_target[k][43:1],1'b0,1'b1,,,,);
	  //assign jdec_target[k][63:44]=cc_read_IP_reg3[63:44];
          add_agu add1_mod(.a({1'b1,cc_read_IP_reg3[63:5],jmp_off_reg[k],1'b0}),.b({59'b0,jmp_moff_reg[k],1'b0}),
	      .c({21'b0,jdec_const_reg[k][43:1],1'b0}),.out({jdec_target[k],par0}),.cout_sec(jdec_sec[k]),.ndiff(),.en(1'b1),
	      .shift(4'h1),.sh2(2'h0));
 
          jump_decoder #(thread) jdec_mod(
          .clk(clk),
          .rst(rst),
          .mode64(1'b1),
          .instr(jmp_instr[k]),
          .magic(~jmp_magic[k]),
          .class_(jmp_class[k][11:0]),
          .isAvx(1'b0),
          .constant(jdec_const[k]),
          
          .pushCallStack(jdec_push[k]),
          .popCallStack(jdec_pop[k]),
          .isJump(),
          .jumpType(jdec_type[k]),
          .jumpIndir(),
          .isIPRel()
          );
  
      end
      for (j=0;j<12;j=j+1) begin
          wire [3:0] isJ;
          assign pre_other[j][`instrQ_magic]=~pre_magic_reg[j];
	      assign pre_other[j][`instrQ_srcIPOff]=read_data_reg2[255] && cc_read_IP_reg3[4:1]==4'b0 ? {cc_base_off_reg,pre_off_reg[j]}: 
              {cc_base_off,pre_off_reg[j]};
          if (j!=11) assign pre_other[j][`instrQ_srcTick]=cc_base_tick &&//cc_read_IP_reg4[43:9]!=cc_read_IP_reg5[43:9] &&
		  do_seq_reg5 && pre_instrEn_reg[j]&&pre_jbefore[j]&&j=={31'b0,read_data_reg2[255] && cc_read_IP_reg3[4:1]==0}; 
          else assign pre_other[j][`instrQ_srcTick]=cc_base_tick &&//cc_read_IP_reg4[43:9]!=cc_read_IP_reg5[43:9] &&
		  do_seq_reg5 && pre_instrEn_reg[j]&&pre_jbefore[j]&&j=={31'b0,read_data_reg2[255] && cc_read_IP_reg3[4:1]==0}; 
          assign pre_other[j][`instrQ_class]=pre_class_reg[j];
          //assign pre_other[j][`instrQ_taken]=btb_hasTK_reg3 ? 1'bz : 1'b0;
          assign pre_other[j][`instrQ_taken]=(taken_reg4 & isJ) !=4'b0;
          assign isJ[0]=pre_off_reg[j]==btbx_joff_reg4[0] && pre_class_reg[j][`iclass_jump];
          assign isJ[1]=pre_off_reg[j]==btbx_joff_reg4[1] && pre_class_reg[j][`iclass_jump];
          assign isJ[2]=pre_off_reg[j]==btbx_joff_reg4[2] && pre_class_reg[j][`iclass_jump];
          assign isJ[3]=pre_off_reg[j]==btbx_joff_reg4[3] && pre_class_reg[j][`iclass_jump];
          assign pre_other[j][`instrQ_jmp_ind]=isJ[0] ? 2'd0 : 2'bz;
          assign pre_other[j][`instrQ_jmp_ind]=isJ[1] ? 2'd1 : 2'bz;
          assign pre_other[j][`instrQ_jmp_ind]=isJ[2] ? 2'd2 : 2'bz;
          assign pre_other[j][`instrQ_jmp_ind]=isJ[3] ? 2'd3 : 2'bz;
          assign pre_other[j][`instrQ_jmp_ind]=isJ!=0 ? 2'bz : 2'd0;
          assign pre_other[j][`instrQ_btb_way]=btbxx_way_reg;
          assign pre_other[j][`instrQ_ght_addr]=(startx_reg4&{1'b1,isJ})!=0 || isJ==0 ? GHT_reg4 : 8'bz;
          assign pre_other[j][`instrQ_ght_addr]=(startx_reg4[2:0]&isJ[3:1])!=0 ? {GHT_reg4[6:0],1'b0} : 8'bz;
          assign pre_other[j][`instrQ_ght_addr]=(startx_reg4[1:0]&isJ[3:2])!=0 ? {GHT_reg4[5:0],2'b0} : 8'bz;
          assign pre_other[j][`instrQ_ght_addr]=(startx_reg4[0]&isJ[3]) ? {GHT_reg4[4:0],3'b0} : 8'bz;
	      assign pre_other[j][`instrQ_lastInstr]=pre_instrEn_reg[j]&&~pre_instrEn_reg[j+1]&&~read_data_reg[255];
	  assign pre_other[j][`instrQ_sc]=isJ[0] ? predx_sc0_reg4 : 2'bz;
	  assign pre_other[j][`instrQ_sc]=isJ[1] ? predx_sc1_reg4 : 2'bz;
	  assign pre_other[j][`instrQ_sc]=isJ[2] ? predx_sc2_reg4 : 2'bz;
	  assign pre_other[j][`instrQ_sc]=isJ[3] ? predx_sc3_reg4 : 2'bz;
	  assign pre_other[j][`instrQ_sc]=isJ!=0 ? 2'bz : 2'b0;
//	  assign pre_other[j][`instrQ_avx]=pre_isAvx_reg;
	  assign pre_other[j][`instrQ_btbMiss]=~btb_can_ins_reg4;
	  assign pre_other[j][`instrQ_btb_only]=(isJ&btbx_cond_reg4)==4'b0;
          get_carry #(4) jcmp_mod(last_off_reg4,~pre_off_reg[j],1'b1,pre_jbefore0[j]);
          assign pre_jbefore[j]=pre_jbefore0[j];
      end
  endgenerate

  insconv ins0_mod(bus_data_reg[255:0],bus_data_cvt[255:0]);
  insconv ins2_mod(bus_data_reg[511:256],bus_data_cvt[511:256]);
  
  assign bus_match0=bus_en && bus_slot=={BUS_ID,5'b10000};
  
  assign tlb_IP=bus_tlb_match_reg ? {proc[20:0],miss_IP[43:13]} : {proc[20:0],cc_read_IP[43:13]};
  
  assign bus_tlb_match=bus_tlb_slot[9:5]==BUS_ID && bus_tlb_en;
  
  assign instrFed=instrEn_reg3 && (cc_read_hit && tlb_match);
  
  assign cc_base_IP_d=(~do_seq_reg5) ? cc_read_IP_reg4 : 64'bz;
  assign cc_base_IP_d=(do_seq_reg5 & ~cc_base_tick) ? cc_base_IP : 64'bz;
  assign cc_base_IP_d[8:0]=(do_seq_reg5 & cc_base_tick) ? cc_base_IP[8:0] : 9'bz;
 // assign {cc_base_tick,cc_base_off}=(~do_seq_reg  && ~(miss_recover && proturberan)) ? 5'b0 : 5'bz;
  
  assign cc_read_IP_d[4:0]=(~init & do_seq_any & ~jumpTK_en & ~fmstall & ~(do_seq&miss_recover)) ? 5'b0 : 5'bz;
  assign cc_read_IP_d=(~init & btb_hasTK & ~miss_recover & ~miss_now & ~jumpTK_en & ~(ixcept|uxcept) & ~fmstall) ? btbx_tgt : 64'bz;
  assign cc_read_IP_d=(~init & miss_recover & ~jumpTK_en & ~(ixcept|uxcept) & ~fmstall) ? miss_IP : 64'bz;
  assign cc_read_IP_d=(~init & (ixcept|uxcept) ) ? {ixceptIP[63:1],1'b0} : 64'bz;
  assign cc_read_IP_d=(~init & ~jumpTK_en & ~(ixcept|uxcept) & ~miss_now & btb_in_ret & ~fmstall) ? {rstack_dataR[63:1],1'b0} : 64'bz;
  assign cc_read_IP_d=~init & ~(ixcept|uxcept) & jumpTK_en & ~fmstall? jumpTK_addr : 64'bz;
  assign cc_read_IP_d=(init || fmstall & ~(ixcept|uxcept)) ? cc_read_IP : 64'bz;
  
  assign cc_attr_d=(~init & do_seq_any & ~jumpTK_en & ~fmstall & ~(do_seq&miss_recover)) ? cc_attr : 4'bz;
  assign cc_attr_d=(~init & btb_hasTK & ~miss_recover & ~miss_now & ~jumpTK_en & ~(ixcept|uxcept) & ~fmstall) ? btbx_attr : 4'bz;
  assign cc_attr_d=(~init & miss_recover & ~jumpTK_en & ~(ixcept|uxcept) & ~fmstall) ? cc_attr : 4'bz;
  assign cc_attr_d=(~init & (ixcept|uxcept) ) ? {ixceptAttr} : 4'bz;
  assign cc_attr_d=(~init & ~jumpTK_en & ~(ixcept|uxcept) & ~miss_now & btb_in_ret & ~fmstall) ? {rstack_dataR[67:64]} : 4'bz;
  assign cc_attr_d=~init & ~(ixcept|uxcept) & jumpTK_en & ~fmstall? jumpTK_attr : 4'bz;
  assign cc_attr_d=(init || fmstall & ~(ixcept|uxcept)) ? cc_attr : 4'bz;
  
  assign bus_match={BUS_ID,1'b1}==bus_slot[9:4] & bus_en;
  assign write_IP={req_addrP,req_addrR[5:0],2'b0};
  
  assign do_seq=~miss_now | miss_recover && ~(ixcept|uxcept) && ~btb_hasTK && ~btb_in_ret;
  assign do_seq_miss=miss_now && ~miss_recover && ~(ixcept|uxcept) && ~btb_hasTK && ~btb_in_ret;
  assign do_seq_any=~miss_recover && ~(ixcept|uxcept) && ~btb_hasTK && ~btb_in_ret;

  assign btb_hasTK=|(btbx_jmask&{predx_sc3[0],predx_sc2[0],predx_sc1[0],predx_sc0[0]});

  assign btb_tgt=taken[0] ? {btb_tgt0,1'b0} : 64'bz;
  assign btb_tgt=taken[1] ? {btb_tgt1,1'b0} : 64'bz;
  assign btb_tgt=taken[2] ? {btb_tgt2,1'b0} : 64'bz;
  assign btb_tgt=taken[3] ? {btb_tgt3,1'b0} : 64'bz;
  assign btb_tgt=btb_hasTK ? 64'bz : 64'b0;  

  assign btb_attr=taken[0] & ~btb_in_ret ? {btb_attr0} : 4'bz;
  assign btb_attr=taken[1] & ~btb_in_ret ? {btb_attr1} : 4'bz;
  assign btb_attr=taken[2] & ~btb_in_ret ? {btb_attr2} : 4'bz;
  assign btb_attr=taken[3] & ~btb_in_ret ? {btb_attr3} : 4'bz;
  assign btb_attr=~btb_hasTK & ~btb_in_ret ? cc_attr : 4'bz;  
  assign btb_attr=btb_in_ret ? rstack_dataR[67:64] : 4'bz;


  assign btbx_tgt=btb_tgt;
  assign btbx_tgt0=btb_tgt0;
  assign btbx_tgt1=btb_tgt1;
  assign btbx_tgt2=btb_tgt2;
  assign btbx_tgt3=btb_tgt3;
  
  assign btbx_attr=btb_attr;
  assign btbx_attr0=btb_attr0;
  assign btbx_attr1=btb_attr1;
  assign btbx_attr2=btb_attr2;
  assign btbx_attr3=btb_attr3;
  
  assign rstack_dataW[63:44]=cc_read_IP[63:44];
  assign rstack_dataW[67:64]=cc_attr;

  adder #(43) rsw_med(cc_read_IP[43:1],{38'b0,btbx_jlnoff},rstack_dataW[43:1],1'b0,1'b1,,,,);

  assign btbx_jlnoff=jlninx0 ? btbx_lnpos0 : 5'bz;
  assign btbx_jlnoff={jlninx1,jlninx0}==2'b10 ? btbx_lnpos1 : 5'bz;
  assign btbx_jlnoff={jlninx2,jlninx1,jlninx0}==3'b100 ? btbx_lnpos2 : 5'bz;
  assign btbx_jlnoff={jlninx2,jlninx1,jlninx0}==3'b0 ? btbx_lnpos3 : 5'bz;
  
  assign last_off=btb_hasTK ? 4'bz : 4'he;
 
  assign jlninx0=btb_jlnin0 && ~btb_jlnpos0[4]; 
  assign jlninx1=btb_jlnin1 && ~btb_jlnpos1[4]; 
  assign jlninx2=btb_jlnin2 && ~btb_jlnpos2[4]; 
  assign jlninx3=btb_jlnin3 && ~btb_jlnpos3[4]; 

  assign btb_in_link=taken[3] ? (jlninx0 && btbx_jlink0[4:0]!=5'h1f && ~btbx_jlnjpos0[3]) ||
	 (jlninx1 && btbx_jlink1[4:0]!=5'h1f && ~btbx_jlnjpos1[3]) ||
	(jlninx2 && btbx_jlink2[4:0]!=5'h1f && ~btbx_jlnjpos2[3]) ||
       (jlninx3 && btbx_jlink3[4:0]!=5'h1f && ~btbx_jlnjpos3[3])	: 1'bz;
  assign btb_in_link=taken[2] ? (jlninx0 && btbx_jlink0[4:0]!=5'h1f && ~btbx_jlnjpos0[2]) ||
	 (jlninx1 && btbx_jlink1[4:0]!=5'h1f && ~btbx_jlnjpos1[2]) ||
	(jlninx2 && btbx_jlink2[4:0]!=5'h1f && ~btbx_jlnjpos2[2]) : 1'bz;
  assign btb_in_link=taken[1] ? (jlninx0 && btbx_jlink0[4:0]!=5'h1f && ~btbx_jlnjpos0[1]) ||
	 (jlninx1 && btbx_jlink1[4:0]!=5'h1f && ~btbx_jlnjpos1[1]) : 1'bz;
  assign btb_in_link=taken[0] ? jlninx0 && btbx_jlink0[4:0]!=5'h1f && btbx_jlnjpos0[0] : 1'bz;
  assign btb_in_link=(~btb_hasTK) ? (jlninx0 && btbx_jlink0[4:0]!=5'h1f)|| (jlninx1 && btbx_jlink1[4:0]!=5'h1f)||
	  (jlninx2 && btbx_jlink2[4:0]!=5'h1f) || (jlninx3 && btbx_jlink3[4:0]!=5'h1f) : 1'bz;//if no jump taken then link is last instr in bundle

  assign btb_in_ret=taken[3] ? (btbx_jlink0[4:0]==5'h1f && btbx_jlnjpos0[4] && ~btbx_jlnpos0[4]) ||
	  (btbx_jlink1[4:0]==5'h1f && btbx_jlnjpos1[4] && ~btbx_jlnpos1[4]) ||
	  (btbx_jlink2[4:0]==5'h1f && btbx_jlnjpos2[4] && ~btbx_jlnpos2[4]) ||
	  (btbx_jlink3[4:0]==5'h1f && btbx_jlnjpos3[4] && ~btbx_jlnpos3[4]) : 1'bz;
  assign btb_in_ret=taken[2] ? (btbx_jlink0[4:0]==5'h1f && btbx_jlnjpos0[3] && ~btbx_jlnpos0[4]) ||
	 (btbx_jlink1[4:0]==5'h1f && btbx_jlnjpos1[3] && ~btbx_jlnpos1[4]) ||
	(btbx_jlink2[4:0]==5'h1f && btbx_jlnjpos2[3] && ~btbx_jlnpos2[4]) : 1'bz;
  assign btb_in_ret=taken[1] ? (btbx_jlink0[4:0]==5'h1f && btbx_jlnjpos0[2] && ~btbx_jlnpos0[4]) ||
	  (btbx_jlink1[4:0]==5'h1f && btbx_jlnjpos1[2] && ~btbx_jlnpos1[4]) : 1'bz;
  assign btb_in_ret=taken[0] ? (btbx_jlink0[4:0]==5'h1f && btbx_jlnjpos0[1] && ~btbx_jlnpos0[4]) : 1'bz;
  assign btb_in_ret=(~btb_hasTK) ? 1'b0 : 1'bz;

 // assign link_IP_d[0]=1'b0;
  
  //lnk_isRet_reg & lnk_jpos[0] not possible
  
  assign tlb_phys={1'b0,tlb_data_reg3[`ctlbData_phys]};
  assign tlb_nx=tlb_data_reg3[`ctlbData_ne];
  assign tlb_na=tlb_data_reg3[`ctlbData_na];
  assign tlb_sys=tlb_data_reg3[`ctlbData_sys];
  
  assign tlb_match=tlb_hit_reg3;

  assign IP_phys={tlb_data[`ctlbData_phys],cc_read_IP[12:0]};

  assign req_addr=req_en0 ? {tlb_phys_reg,cc_read_IP_reg4[12:7]} : 38'bz;
  assign req_slot=req_en0 ? {BUS_ID,2'b10,miss_slot} : 10'bz;
  assign req_en0=miss_now & ~tlbMiss_now & miss_seq & IP_chg_reg4;
  assign req_en=req_en0 & (~cc_read_hit & tlb_match || ~miss_now_reg) &~fstall;
  
  assign req_en1=miss_now & tlbMiss_now & miss_seq;
  assign req_tlbEn=req_en1 & ~fstall;
  assign req_addr=req_en1 ? {7'b0,cc_read_IP_reg3[43:13]} : 38'bz;
  assign req_slot=req_en1 ? {BUS_ID,2'b10,miss_slot} : 10'bz;

  assign req_addr=(~req_en0 & ~req_en1) ?  38'b0 : 38'bz;
  assign req_slot=(~req_en0 & ~req_en1) ? 10'b0 : 10'bz;
  
  assign miss_recover=(bus_match0_reg3 && ~miss_seq && dreq_reg4==0)|| bus_tlb_match_reg3;


  assign uxcept=except & ~miss_now & ~btb_hold_except || except_save & ~miss_now &
    ~fstall & ~ixcept;
  
  assign ixceptIP=(~except_save) ? exceptIP : exceptIP_save;
  assign ixceptAttr=(~except_save) ? exceptAttr : exceptAttr_save;
  assign ixceptThread=(~except_save) ? exceptThread : exceptThread_save;
  assign ixceptDueJump=(~except_save) ? exceptDueJump : exceptDueJump_save;
  assign ixceptLDConfl=(~except_save) ? exceptLDConfl : exceptLDConfl_save;
  assign ixceptJumpGHT=(~except_save) ? exceptJumpGHT : exceptJumpGHT_save;
  assign ixcept_jmask=(~except_save) ? except_jmask : except_jmask_save;
  assign ixcept_jmask_en=(~except_save) ? except_jmask_en : except_jmask_en_save;
  
  assign btbFStall=instrEn_reg3 & ~(cc_read_hit && btb_hit_reg3)
    & pre_has_jumps; 
  assign fstall=iq_fstall || jq_fstall || fmstall || btbFStall || btbFStall_reg 
    || btbFStall_reg2 || btbFStall_reg3 || btbFStall_recover;
  
  assign btb_hold_except=btbFStall || btbFStall_reg || btbFStall_reg2 || btbFStall_reg3;
  
  assign GHT_d=start[0] & predy_sc0[0] || start[1] & predy_sc1[0] ||
    start[2] & predy_sc2[0] || start[3] & predy_sc3[0] ? {GHT[6:0],1'b1} : 8'bz;
  assign GHT_d=start[0] & ~predy_sc0[0] & predy_sc1[0] ||
    start[1] & ~predy_sc1[0] & predy_sc2[0] ||
    start[2] & ~predy_sc2[0] & predy_sc3[0] ? {GHT[5:0],2'b01} : 8'bz;
  assign GHT_d=start[0] & ~predy_sc0[0] & ~predy_sc1[0] & predy_sc2[0] ||
    start[1] & ~predy_sc1[0] & ~predy_sc2[0] & predy_sc3[0]  ? {GHT[4:0],3'b001} : 8'bz;
  assign GHT_d=(start[0] & ~predy_sc0[0] & ~predy_sc1[0] & ~predy_sc2[0] & predy_sc3[0]) ? 
    {GHT[3:0],4'b0001} : 8'bz;
  assign GHT_d=(~predy_sc0[0] & ~predy_sc1[0] & ~predy_sc2[0] & ~predy_sc3[0]) && 
    (start[3] & btb_has3 || start[2]&btb_has2&~btb_has3||
    start[1]&btb_has1&~btb_has2||start[0]&btb_has0&~btb_has1) ? {GHT[6:0],1'b0} : 8'bz;
  assign GHT_d=(~predy_sc0[0] & ~predy_sc1[0] & ~predy_sc2[0] & ~predy_sc3[0]) && 
    (start[2] & btb_has3 || start[1] & btb_has2 & ~btb_has3 || start[0] & btb_has1 & ~btb_has2) ? 
    {GHT[5:0],2'b0} : 8'bz;
  assign GHT_d=(~predy_sc0[0] & ~predy_sc1[0] & ~predy_sc2[0] & ~predy_sc3[0]) && 
    (start[1] & btb_has3 || start[0] & btb_has2 & ~btb_has3) ? {GHT[4:0],3'b0} : 8'bz;
  assign GHT_d=(~predy_sc0[0] & ~predy_sc1[0] & ~predy_sc2[0] & ~predy_sc3[0]) && 
    (start[0] & btb_has3) ? {GHT[3:0],4'b0} : 8'bz;
  assign GHT_d=start[4]||((~predy_sc0[0] & ~predy_sc1[0] & ~predy_sc2[0] & ~predy_sc3[0]) && 
    (start[0] & ~btb_has0 || start[1] & ~btb_has1 || start[2] & ~btb_has2 || start[3] & ~btb_has3)) ? 
    GHT : 8'bz;


//  assign GHTx=4'b0;
      
  assign start[0]=btb_jmask[0];
  assign start[1]=btb_jmask[1:0]==2'b10;
  assign start[2]=btb_jmask[2:0]==3'b100;
  assign start[3]=btb_jmask[3:0]==4'b1000;
  assign start[4]=btb_jmask==0;

  assign start2[0]=btb_jmask2[0];
  assign start2[1]=btb_jmask2[1:0]==2'b10;
  assign start2[2]=btb_jmask2[2:0]==3'b100;
  assign start2[3]=btb_jmask2[3:0]==4'b1000;
  assign start2[4]=btb_jmask2==0;

  assign btb_jmask2=(btb_way ? btb_chmaskB : btb_chmaskA)&{4{btb_hit}};

  assign startx=start;

  assign btbx_jmask=btb_jmask&{btb_has3,btb_has2,btb_has1,btb_has0};
  assign predx_sc0=btb_way ? pred_sc0B : pred_sc0A;
  assign predx_sc1=btb_way ? pred_sc1B : pred_sc1A;
  assign predx_sc2=btb_way ? pred_sc2B : pred_sc2A;
  assign predx_sc3=btb_way ? pred_sc3B : pred_sc3A;
  assign predy_sc0=btb_way ? pred_sc0B&{2{btb_cond[0]}} : pred_sc0A&{2{btb_cond[0]}};
  assign predy_sc1=btb_way ? pred_sc1B&{2{btb_cond[1]}} : pred_sc1A&{2{btb_cond[1]}};
  assign predy_sc2=btb_way ? pred_sc2B&{2{btb_cond[2]}} : pred_sc2A&{2{btb_cond[2]}};
  assign predy_sc3=btb_way ? pred_sc3B&{2{btb_cond[3]}} : pred_sc3A&{2{btb_cond[3]}};
  assign btbx_jlink0= btb_jlink0;
  assign btbx_jlnpos0=btb_jlnpos0;
  assign btbx_jlnjpos0=btb_jlnjpos0;
  assign btbx_jlink1= btb_jlink1;
  assign btbx_jlnpos1=btb_jlnpos1;
  assign btbx_jlnjpos1=btb_jlnjpos1;
  assign btbx_jlink2= btb_jlink2;
  assign btbx_jlnpos2=btb_jlnpos2;
  assign btbx_jlnjpos2=btb_jlnjpos2;
  assign btbx_jlink3= btb_jlink3;
  assign btbx_jlnpos3=btb_jlnpos3;
  assign btbx_jlnjpos3=btb_jlnjpos3;

  assign jdec_link0=lnk_isRet0_reg ? 5'h1f : 5'bz;
  assign jdec_link1=lnk_isRet1_reg ? 5'h1f : 5'bz;
  assign jdec_link2=lnk_isRet2_reg ? 5'h1f : 5'bz;
  assign jdec_link3=lnk_isRet3_reg ? 5'h1f : 5'bz;
  
  assign lnk_offIn=lnk_offIn_cc;
 
  assign fmstall= (btb_way ? (btb_jmask&{btb_has3,btb_has2,btb_has1,btb_has0})!=
    btb_chmaskB && btb_hit && btb_hasTK_reg|ixcept_reg && ~uxcept: 
    (btb_jmask&{btb_has3,btb_has2,btb_has1,btb_has0})!=btb_chmaskA && btb_hit && btb_hasTK_reg|ixcept_reg && ~uxcept) || miss_now_in;
  assign iqe_jbits=taken_reg[0] ? {3'b0,btbx_jmask_reg[0]} : 4'bz;
  assign iqe_jbits=taken_reg[1] ? {2'b0,btbx_jmask_reg[1:0]} : 4'bz;
  assign iqe_jbits=taken_reg[2] ? {1'b0,btbx_jmask_reg[2:0]} : 4'bz;
  assign iqe_jbits=taken_reg[3] || (taken_reg==0) ? btbx_jmask_reg : 4'bz;
  
  assign iqe_jbitZ=taken_REG[0] ? {3'b0,btbx_jmask_REG[0]} : 4'bz;
  assign iqe_jbitZ=taken_REG[1] ? {2'b0,btbx_jmask_REG[1:0]} : 4'bz;
  assign iqe_jbitZ=taken_REG[2] ? {1'b0,btbx_jmask_REG[2:0]} : 4'bz;
  assign iqe_jbitZ=taken_REG[3] || (taken_REG==0) ? btbx_jmask_REG : 4'bz;

  assign btbx_cond=btb_cond;

  assign jumpTK_btb_fstall=btb_hasTK && btbFStall_recover;

  popcnt5 wjcnt_mod({1'b0,iqe_jbits},iqe_jcnt);
  popcnt5 wjcnD_mod({1'b0,iqe_jbitZ},iqe_jcnD);

//  cc_comb cc_mod(
//  );  

  ctlb tlb_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(instrEn || ixcept),
  .read_thread(thread),
  .fStall(fstall),
  .addr({tlb_IP,13'b0}),
  .read_data(tlb_data),
  .nat_jump(1'b0),
  .read_hit(tlb_hit),
  .write_data(bus_tlb_data_reg),
  .write_wen(bus_tlb_match_reg),
  .csrss_en(csrss_en),
  .csrss_addr(csrss_addr),
  .csrss_data(csrss_data)
  );
  
  frontReq_ram req_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(bus_en),
  .read_addr(bus_slot[2:0]),
  .read_data({req_addrR,req_addrP}),
  .write_addr(req_slot[2:0]),
  .write_data({cc_read_IP_reg4[43:7],miss_phys}),
  .write_wen(req_en|req_tlbEn)
  );

  predecoder_get preDec_mod(
    .clk(clk),
    .rst(rst),
    .bundle({read_data[258:195],read_data[193:130],read_data[128:65],read_data[63:0]}),
    .btail(read_data_reg[239:176]),
    .bstop(read_data_reg[254:251]),
    .flag_bits(read_dataX),
    .startOff(cc_read_IP_reg2[4:1]),
    .instr0(pre_instr0),.instr1(pre_instr1),.instr2(pre_instr2),.instr3(pre_instr3),
    .instr4(pre_instr4),.instr5(pre_instr5),.instr6(pre_instr6),.instr7(pre_instr7),
    .instr8(pre_instr8),.instr9(pre_instr9),.instr10(pre_instr10),.instr11(pre_instr11),
    .magic0(pre_magic[0]),.magic1(pre_magic[1]),.magic2(pre_magic[2]),.magic3(pre_magic[3]),
    .magic4(pre_magic[4]),.magic5(pre_magic[5]),.magic6(pre_magic[6]),.magic7(pre_magic[7]),
    .magic8(pre_magic[8]),.magic9(pre_magic[9]),.magic10(pre_magic[10]),.magic11(pre_magic[11]),
    .off0(pre_off[0]),.off1(pre_off[1]),.off2(pre_off[2]),.off3(pre_off[3]),
    .off4(pre_off[4]),.off5(pre_off[5]),.off6(pre_off[6]),.off7(pre_off[7]),
    .off8(pre_off[8]),.off9(pre_off[9]),.off10(pre_off[10]),.off11(pre_off[11]),
    .class0(pre_class[0]),.class1(pre_class[1]),.class2(pre_class[2]),.class3(pre_class[3]),
    .class4(pre_class[4]),.class5(pre_class[5]),.class6(pre_class[6]),.class7(pre_class[7]),
    .class8(pre_class[8]),.class9(pre_class[9]),.class10(pre_class[10]),.class11(pre_class[11]),
    .instrEn(pre_instrEn),
    .isAvx(pre_isAvx),
    .hasJumps(pre_has_jumps),
    .error(pre_error),
    .jerror(jmp_error),
    .Jinstr0(jmp_instr[0]),.Jinstr1(jmp_instr[1]),.Jinstr2(jmp_instr[2]),.Jinstr3(jmp_instr[3]),
    .Jmagic0(jmp_magic[0]),.Jmagic1(jmp_magic[1]),.Jmagic2(jmp_magic[2]),.Jmagic3(jmp_magic[3]),
    .Joff0(jmp_off[0]),.Joff1(jmp_off[1]),.Joff2(jmp_off[2]),.Joff3(jmp_off[3]),
    .Jclass0(jmp_class[0]),.Jclass1(jmp_class[1]),.Jclass2(jmp_class[2]),.Jclass3(jmp_class[3]),
    .Jen(jmp_en),
    .lnkLink0(lnk_link0),.lnkOff0(lnk_off0),.lnkMagic0(lnk_magic0),.lnkRet0(lnk_isRet0),.lnkJumps0(lnk_jpos0),
    .lnkLink1(lnk_link1),.lnkOff1(lnk_off1),.lnkMagic1(lnk_magic1),.lnkRet1(lnk_isRet1),.lnkJumps1(lnk_jpos1),
    .lnkLink2(lnk_link2),.lnkOff2(lnk_off2),.lnkMagic2(lnk_magic2),.lnkRet2(lnk_isRet2),.lnkJumps2(lnk_jpos2),
    .lnkLink3(lnk_link3),.lnkOff3(lnk_off3),.lnkMagic3(lnk_magic3),.lnkRet3(lnk_isRet3),.lnkJumps3(lnk_jpos3)
    );
    
  instrQ instrQ_mod(
  .clk(clk),
  .rst(rst),
  .write_instrEn(pre_instrEn_reg[11:0]&pre_jbefore),
  .write_thread(1'b0),
  .write_wen(instrFed_reg&~btbFStall&~btbFStall_reg&~btbFStall_reg2&~btbFStall_reg3&~btbFStall_recover_reg2&~jq_fstall&~fmstall),
  .doFStall(iq_fstall),
  .except(uxcept|ixcept|except),
  .except_thread(1'b0),
  .write_instr0(pre_instr0_reg),.write_other0(pre_other[0]),
  .write_instr1(pre_instr1_reg),.write_other1(pre_other[1]),
  .write_instr2(pre_instr2_reg),.write_other2(pre_other[2]),
  .write_instr3(pre_instr3_reg),.write_other3(pre_other[3]),
  .write_instr4(pre_instr4_reg),.write_other4(pre_other[4]),
  .write_instr5(pre_instr5_reg),.write_other5(pre_other[5]),
  .write_instr6(pre_instr6_reg),.write_other6(pre_other[6]),
  .write_instr7(pre_instr7_reg),.write_other7(pre_other[7]),
  .write_instr8(pre_instr8_reg),.write_other8(pre_other[8]),
  .write_instr9(pre_instr9_reg),.write_other9(pre_other[9]),
  .write_instr10(pre_instr10_reg),.write_other10(pre_other[10]),
  .write_instr11(pre_instr11_reg),.write_other11(pre_other[11]),
  .read_thread(1'b0),
  .read_clkEn(~stall),
  .read_instrEn(instrEat),
  .read_avail(iAvail),
  .read_instr0(instr0),.read_other0(extra0),
  .read_instr1(instr1),.read_other1(extra1),
  .read_instr2(instr2),.read_other2(extra2),
  .read_instr3(instr3),.read_other3(extra3),
  .read_instr4(instr4),.read_other4(extra4),
  .read_instr5(instr5),.read_other5(extra5),
  .read_instr6(instr6),.read_other6(extra6),
  .read_instr7(instr7),.read_other7(extra7),
  .read_instr8(instr8),.read_other8(extra8),
  .read_instr9(instr9),.read_other9(extra9)
  );

  instrQextra jmp_queue_mod(
  .clk(clk),
  .rst(rst),
  .except(uxcept|ixcept|except),
  .except_thread(ixceptThread),
  .fStall(iq_fstall|fmstall|btbFStall|btbFStall_reg|btbFStall_reg2|btbFStall_reg3|btbFStall_recover_reg2),
  .doFStall(jq_fstall),
  .stall(stall),
  .read_thread(1'b0),
  .read_cnt(btbl_step),
  .read_data0({btbl_mask0,btbl_IP0,btbl_attr0}),
  .read_data1({btbl_mask1,btbl_IP1,btbl_attr0}),
  .write_wen(instrFed_reg&~btbFStall&~btbFStall_reg&~btbFStall_reg2&~btbFStall_reg3&
    ~btbFStall_recover_reg2&~jq_fstall&~fmstall),
  .write_thread(1'b0),
  .write_cnt(btbFStall_recover_reg ? iqe_jcnD[4:0] : iqe_jcnt_reg2[4:0]),
  .write_start(startx_reg3),
  .write_data0({jmp_mask_reg4[0],btbx_tgt0_reg4,btbx_attr0_reg4}),
  .write_data1({jmp_mask_reg4[1],btbx_tgt1_reg4,btbx_attr1_reg4}),
  .write_data2({jmp_mask_reg4[2],btbx_tgt2_reg4,btbx_attr2_reg4}),
  .write_data3({jmp_mask_reg4[3],btbx_tgt3_reg4,btbx_attr3_reg4})
  );
  /*
  instrQ_tk tk_queue_mod(
  .clk(clk),
  .rst(rst),
  .doFStall(tq_fstall),
  .read_clkEn(btbl_step & ~stall),
  .read_thread(1'b0),
  .read_data(btbl_IP),
  .write_data(btbx_tgt_reg3),
  .write_thread(1'b0),
  .write_wen(btb_hasTK_reg3 & ~iq_fstall & ~btbFStall_reg &
    ~btbFStall_reg2 & ~btbFStall_reg3 & ~btbFStall_recover & instrFed_reg)
  );*/
    
  adder_inc #(43) seqAdd_mod(cc_read_IP[47:5],cc_read_IP_d[47:5],
    do_seq &~init & ~jumpTK_en & ~fmstall &~miss_recover,);
  adder #(43) seqM_Add_mod(cc_read_IP[47:5],43'd2,cc_read_IP_d[47:5],
    1'b0,do_seq_miss &~init & ~jumpTK_en & ~fmstall,,,,);
  adder_inc #(5) misCntAdd_mod(miss_cnt,miss_cnt_next,1'b1,);
  adder_inc #(3) misSlotAdd_mod(miss_slot,miss_slot_next,1'b1,);
  adder_inc #(9) initAdd_mod(initCount,initCount_next,1'b1,);

  adder #(5) ln0off1t_mod(lnk_off0_reg,lnk_link0_reg,jdec_link0,1'b1,lnk_magic0_reg[0] & ~lnk_isRet0_reg,,,,);
  adder_CSA #(5) ln0off2CSAt_mod(lnk_off0_reg,lnk_link0_reg,5'd2,lpar00,lpar01);
  adder #(5) ln0off2t_mod(lpar00[4:0],lpar01[4:0],jdec_link0,1'b0,~lnk_magic0_reg[0] & ~lnk_isRet0_reg,,,,);

  adder #(5) ln1off1t_mod(lnk_off1_reg,lnk_link1_reg,jdec_link1,1'b1,lnk_magic1_reg[0] & ~lnk_isRet1_reg,,,,);
  adder_CSA #(5) ln1off2CSAt_mod(lnk_off1_reg,lnk_link1_reg,5'd2,lpar10,lpar11);
  adder #(5) ln1off2t_mod(lpar10[4:0],lpar11[4:0],jdec_link1,1'b0,~lnk_magic1_reg[0] & ~lnk_isRet1_reg,,,,);

  adder #(5) ln2off1t_mod(lnk_off2_reg,lnk_link2_reg,jdec_link2,1'b1,lnk_magic2_reg[0] & ~lnk_isRet2_reg,,,,);
  adder_CSA #(5) ln2off2CSAt_mod(lnk_off2_reg,lnk_link2_reg,5'd2,lpar20,lpar21);
  adder #(5) ln2off2t_mod(lpar20[4:0],lpar21[4:0],jdec_link2,1'b0,~lnk_magic2_reg[0] & ~lnk_isRet2_reg,,,,);

  adder #(5) ln3off1t_mod(lnk_off3_reg,lnk_link3_reg,jdec_link3,1'b1,lnk_magic3_reg[0] & ~lnk_isRet3_reg,,,,);
  adder_CSA #(5) ln3off2CSAt_mod(lnk_off3_reg,lnk_link3_reg,5'd2,lpar30,lpar31);
  adder #(5) ln3off2t_mod(lpar30[4:0],lpar31[4:0],jdec_link3,1'b0,~lnk_magic3_reg[0] & ~lnk_isRet3_reg,,,,);

  get_carry #(4) btbLNoffCmpCC(lnk_off0_reg[3:0],~cc_read_IP_reg2[4:1],1'b1,lnk_offIn_cc);
  
  get_carry #(4) btbL0NoffCmpCC(btb_jlnpos0[3:0],~cc_read_IP[4:1],1'b1,btb_jlnin0);
  get_carry #(4) btbL1NoffCmpCC(btb_jlnpos1[3:0],~cc_read_IP[4:1],1'b1,btb_jlnin1);
  get_carry #(4) btbL2NoffCmpCC(btb_jlnpos2[3:0],~cc_read_IP[4:1],1'b1,btb_jlnin2);
  get_carry #(4) btbL3NoffCmpCC(btb_jlnpos3[3:0],~cc_read_IP[4:1],1'b1,btb_jlnin3);
  
  adder #(5) baseTick_mod(cc_read_IP_reg4[9:5],~cc_base_IP[9:5],{cc_base_tick,cc_base_off},1'b1,1'b1,,,,);
 // adder_inc #(35) baseInc_mod(cc_base_IP[43:9],cc_base_IP_d[43:9],do_seq_reg & cc_base_tick,);
  add_agu baseInc_mod(.a({1'b1,cc_base_IP[63:9],9'b0}),.b(64'b0),.c(65'b1000000000),.out({cc_base_IP_d[63:9],cc_base_dummy9}),
      .cout_sec(cc_base_sec),.ndiff(),.en(do_seq_reg5 && cc_base_tick),.shift(4'h1),.sh2(2'h0));
 
  tbuf tbuf_mod(
  .clk(clk),
  .rst(rst),
  .except(ixcept),
  .except_thread(ixceptThread),
  .except_due_jump(ixceptDueJump),
  .except_jmask(ixcept_jmask),
  .except_jmask_en(ixcept_jmask_en),
  .mismatch_stall(fmstall),
  .uxcept(uxcept),
  .read_clkEn(ixcept || ~fstall & new_instrEn||
     btbFStall_recover & ~iq_fstall & ~jq_fstall),
  .nextIP({btbFStall_reg2 ? cc_read_IP_reg2[63:1] : cc_read_IP_d[63:1]}),
  .read_hit(btb_hit),
  .taken(taken&{4{btb_hit}}),
  .has0(btb_has0),
  .has1(btb_has1),
  .has2(btb_has2),
  .has3(btb_has3),
  .sc0A(btb_sc0A),
  .sc1A(btb_sc1A),
  .sc2A(btb_sc2A),
  .sc3A(btb_sc3A),
  .sc0B(btb_sc0B),
  .sc1B(btb_sc1B),
  .sc2B(btb_sc2B),
  .sc3B(btb_sc3B),
  .jump_mask(btb_jmask),
  .chk_maskA(btb_chmaskA),
  .chk_maskB(btb_chmaskB),
  .jump0_jmask(jmp_mask[0]),
  .jump1_jmask(jmp_mask[1]),
  .jump2_jmask(jmp_mask[2]),
  .jump3_jmask(jmp_mask[3]),
  .tbuf_predA(btb_predA),
  .tbuf_predB(btb_predB),
  .cond(btb_cond),
  .indir(btb_indir),
  .link0(btb_jlink0),
  .lnpos0(btb_jlnpos0),
  .ljpos0(btb_jlnjpos0),
  .link1(btb_jlink1),
  .lnpos1(btb_jlnpos1),
  .ljpos1(btb_jlnjpos1),
  .link2(btb_jlink2),
  .lnpos2(btb_jlnpos2),
  .ljpos2(btb_jlnjpos2),
  .link3(btb_jlink3),
  .lnpos3(btb_jlnpos3),
  .ljpos3(btb_jlnjpos3),
  .way(btb_way),
  .off0(btb_joff[0]),.off1(btb_joff[1]),.off2(btb_joff[2]),.off3(btb_joff[3]),
  .attr0I(jdec_attr[0]),.attr1I(jdec_attr[1]),.attr2I(jdec_attr[2]),.attr3I(jdec_attr[3]),
  .attr0O(btb_attr0),.attr1O(btb_attr1),.attr2O(btb_attr2),.attr3O(btb_attr3),
  .tgt0I(jdec_target[0]),.tgt1I(jdec_target[1]),.tgt2I(jdec_target[2]),.tgt3I(jdec_target[3]),
  .tgt0O(btb_tgt0),
  .tgt1O(btb_tgt1),
  .tgt2O(btb_tgt2),
  .tgt3O(btb_tgt3),
  .write_off0(jmp_off_reg[0]),.write_off1(jmp_off_reg[1]),.write_off2(jmp_off_reg[2]),.write_off3(jmp_off_reg[3]),
  .write_cond(~{jdec_type[3][4],jdec_type[2][4],jdec_type[1][4],jdec_type[0][4]}),
  .write_indir({jdec_type[3]==5'h11,jdec_type[2]==5'h11,jdec_type[1]==5'h11,jdec_type[0]==5'h11}),
  .write_link0(jdec_link0[4:0]),.write_lnpos0(lnk_off0_reg),
  .write_link1(jdec_link1[4:0]),.write_lnpos1(lnk_off1_reg),
  .write_link2(jdec_link2[4:0]),.write_lnpos2(lnk_off2_reg),
  .write_link3(jdec_link3[4:0]),.write_lnpos3(lnk_off3_reg),
  .write_way(btb_way_reg2),
  .write_thread(1'b0),
  .write_wen(1'b0),
  .write_insert(btbFStall_reg2 & btb_can_ins),
  .write_can(btb_can_ins),
  .write_read_fwd(1'b0),
  .write_read_lowIP(cc_read_IP_reg2[4:1]),
  .update_addr0(jupd0_baddr),.update_addr1(jupd1_baddr),
  .update_en(jupd1_en|jupd0_en), .update_taken({jupd1_tk,jupd0_tk}),
  .update_use({jupd1_en,jupd0_en})
  );

  ght GHT_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(ixcept || ~fstall & instrEn||
     btbFStall_recover & ~iq_fstall & ~jq_fstall & ~fmstall),
  .fstall(fstall),
  .except(ixcept),
  .exceptThr(ixceptThread),
  .IP_BITS(cc_read_IP_d[20:5]),
  .GHT(GHT),
  .jumpMask(btb_jmask),
  .AbtbPred(btb_predA),
  .BbtbPred(btb_predB),
  .Abtb_sc0(btb_sc0A),
  .Abtb_sc1(btb_sc1A),
  .Abtb_sc2(btb_sc2A),
  .Abtb_sc3(btb_sc3A),
  .Bbtb_sc0(btb_sc0B),
  .Bbtb_sc1(btb_sc1B),
  .Bbtb_sc2(btb_sc2B),
  .Bbtb_sc3(btb_sc3B),
  .AotherPred0(pred_sc0A),
  .AotherPred1(pred_sc1A),
  .AotherPred2(pred_sc2A),
  .AotherPred3(pred_sc3A),
  .BotherPred0(pred_sc0B),
  .BotherPred1(pred_sc1B),
  .BotherPred2(pred_sc2B),
  .BotherPred3(pred_sc3B),
  .write0_sc(jupd0_sc),
  .write0_addr(jupd0_addr),
  .write0_wen(jupd0_en&jupd0_ght_en),
  .write1_sc(jupd1_sc),
  .write1_addr(jupd1_addr),
  .write1_wen(jupd1_en&jupd1_ght_en)
  );

  
  ret_stack rstack_mod(
  .clk(clk),
  .rst(rst),
  .except(uxcept|ixcept),
  .except_thread(ixceptThread),
  .read_clkEn(btb_in_ret & btb_hit&instrEn&~fstall),
  .thread(1'b0),
  .read_data(rstack_dataR),
  .write_data(rstack_dataW),
  .write_lnk(btbx_jlnoff),
  .write_trace(1'b0),
  .write_wen(btb_in_link & btb_hit&instrEn&~fstall)
  );
  
  bit_find_first_bit #(4) tkjiA_mod({pred_sc3A[0],
    pred_sc2A[0],
    pred_sc1A[0],
    pred_sc0A[0]},
    takenA,);
  bit_find_first_bit #(4) tkjiB_mod({pred_sc3B[0],
    pred_sc2B[0],
    pred_sc1B[0],
    pred_sc0B[0]},
    takenB,);
  assign taken=btb_way ? takenB&{btb_has3,btb_has2,btb_has1,btb_has0} : 
    takenA&{btb_has3,btb_has2,btb_has1,btb_has0};

  always @* begin
      new_instrEn=instrEn;
      if (ixcept) new_instrEn=1'b1;
      else if (~fstall) begin
          if (~cc_read_hit & ~miss_now & instrEn_reg3) new_instrEn=1'b0;
          if (miss_recover) new_instrEn=1'b1; 
      end
  end
  always @(posedge clk) 
  begin
      if (rst) begin
          dreq<=8'b0;
      end else for (m=0;m<8;m=m+1) begin
          if (req_en && req_slot[2:0]==m[2:0]) dreq[m]<=1'b1;
          if (bus_en && bus_slot[2:0]==m[2:0] && bus_match) dreq[m]<=1'b0;
      end
      if (rst) begin
          init<=1'b1;
          initCount<=9'b0;
      end else begin
          if (init) begin 
              initCount<=initCount_next;
              if (initCount==9'd511) begin
                  init<=1'b0;
                  instrEn<=1'b1;
              end
          end
      end
      if (rst) begin
          dreq_reg<=8'b0;
          dreq_reg2<=8'b0;
          dreq_reg3<=8'b0;
          dreq_reg4<=8'b0;
          btbFStall_save<=1'b0;
          btbFStall_reg<=1'b0;
          btbFStall_reg2<=1'b0;
          btbFStall_reg3<=1'b0;
//          btbFStall_reg4<=1'b0;
//          btbFStall_reg5<=1'b0;
          btbFStall_recover<=1'b0;
          btbFStall_recover_reg<=1'b0;
          btbFStall_recover_reg2<=1'b0;
          GHT<=8'b0;
          lnk_link0_reg<=5'b0;
          lnk_off0_reg<=5'b0;
          lnk_isRet0_reg<=1'b0;
          lnk_magic0_reg<=4'b0;
          lnk_jpos0_reg<=5'b0;
          lnk_link1_reg<=5'b0;
          lnk_off1_reg<=5'b0;
          lnk_isRet1_reg<=1'b0;
          lnk_magic1_reg<=4'b0;
          lnk_jpos1_reg<=5'b0;
          lnk_link2_reg<=5'b0;
          lnk_off2_reg<=5'b0;
          lnk_isRet2_reg<=1'b0;
          lnk_magic2_reg<=4'b0;
          lnk_jpos2_reg<=5'b0;
          lnk_link3_reg<=5'b0;
          lnk_off3_reg<=5'b0;
          lnk_isRet3_reg<=1'b0;
          lnk_magic3_reg<=4'b0;
          lnk_jpos3_reg<=5'b0;
          for(t=0;t<4;t=t+1) begin
              jmp_off_reg[t]<=4'b0;
              jmp_moff_reg[t]<=4'b0;
              jdec_const_reg[t]<=64'b0;
          end
/*          cc_read_IP_REG3<=48'b0;
          cc_read_IP_REG4<=48'b0;
          tr_read_IP_REG3<=48'b0;
          tr_read_IP_REG4<=48'b0;
          tr_read_hit_REG3<=1'b0;
          tr_read_hit_REG4<=1'b0;*/
      end else begin
          dreq_reg<=dreq;
          dreq_reg2<=dreq_reg;
          dreq_reg3<=dreq_reg2;
          dreq_reg4<=dreq_reg3;
          btbFStall_save<=btbFStall & ~(btbFStall_recover && ~fstall);
          btbFStall_reg<=btbFStall & ~btbFStall_save;
          btbFStall_reg2<=btbFStall_reg;
          btbFStall_reg3<=btbFStall_reg2;
//          btbFStall_reg4<=btbFStall_reg3;
//          btbFStall_reg5<=btbFStall_reg4;
          if (btbFStall_recover && ~iq_fstall && ~jq_fstall && ~fmstall) btbFStall_recover<=1'b0;
          else btbFStall_recover<=btbFStall_recover|btbFStall_reg3;
          
          if (~iq_fstall & ~jq_fstall & ~fmstall) btbFStall_recover_reg<=btbFStall_recover;
          if (~fstall) btbFStall_recover_reg2<=btbFStall_recover_reg;
          if (ixcept) begin
              GHT<=ixceptJumpGHT;
          end else begin
              if (btb_hit&instrEn&~fstall)
                  GHT<=GHT_d;
          end
          lnk_link0_reg<=lnk_link0;
          lnk_off0_reg<=lnk_off0;
          lnk_isRet0_reg<=lnk_isRet0;
          lnk_magic0_reg<=lnk_magic0;
          lnk_jpos0_reg<=lnk_jpos0;
          lnk_link1_reg<=lnk_link1;
          lnk_off1_reg<=lnk_off1;
          lnk_isRet1_reg<=lnk_isRet1;
          lnk_magic1_reg<=lnk_magic1;
          lnk_jpos1_reg<=lnk_jpos1;
          lnk_link2_reg<=lnk_link2;
          lnk_off2_reg<=lnk_off2;
          lnk_isRet2_reg<=lnk_isRet2;
          lnk_magic2_reg<=lnk_magic2;
          lnk_jpos2_reg<=lnk_jpos2;
          lnk_link3_reg<=lnk_link3;
          lnk_off3_reg<=lnk_off3;
          lnk_isRet3_reg<=lnk_isRet3;
          lnk_magic3_reg<=lnk_magic3;
          lnk_jpos3_reg<=lnk_jpos3;
          for(t=0;t<4;t=t+1) begin
              jmp_off_reg[t]<=jmp_en[t] ? jmp_off[t] : 4'hf;
              jmp_moff_reg[t]<=jmp_moff[t];
              jdec_const_reg[t]<=jdec_const[t];
          end
/*          cc_read_IP_REG3<=cc_read_IP_reg2;
          cc_read_IP_REG4<=cc_read_IP_REG3;
          tr_read_IP_REG3<=cc_read_IP_reg2;
          tr_read_IP_REG4<=cc_read_IP_REG3;
          tr_read_hit_REG3<=tr_read_hit_reg2&~ixcept;
          tr_read_hit_REG4<=tr_read_hit_REG3&~ixcept;*/
      end
      
      if (rst) begin
          except_save<=1'b0;
          exceptIP_save<={64{1'B0}};
          exceptThread_save<=1'b0;
          exceptAttr_save<=4'b0;
          exceptLDConfl_save<=1'b0;
          exceptDueJump_save<=1'b0;
          exceptJumpGHT_save<=8'b0;
          except_jmask_save<=4'b0;
          except_jmask_en_save<=1'b0;
      end else if (except) begin
          except_save<=1'b1;
          exceptIP_save<=exceptIP;
          exceptThread_save<=exceptThread;
          exceptAttr_save<=exceptAttr;
          exceptLDConfl_save<=exceptLDConfl;
          exceptDueJump_save<=exceptDueJump;
          exceptJumpGHT_save<=exceptJumpGHT;
          except_jmask_save<=except_jmask;
          except_jmask_en_save<=except_jmask_en;
      end else if (ixcept) begin
          except_save<=1'b0;
          exceptIP_save<={64{1'B0}};
	  exceptAttr_save<=4'b0;
          exceptThread_save<=1'b0;
          exceptLDConfl_save<=1'b0;
          exceptDueJump_save<=1'b0;
          exceptJumpGHT_save<=8'b0;
          except_jmask_save<=4'b0;
          except_jmask_en_save<=1'b0;
      end
     
      if (rst) ixcept<=1'b0;
      else ixcept<=uxcept;
      if (rst) ixcept_reg<=1'b0;
      else ixcept_reg<=ixcept;
      
      if (rst) begin
          //ixcept_reg<=1'b0;
          //ixceptLDConfl_reg<=1'b0;
          read_set_flag<=1'b0;
          read_set_flag_reg<=1'b0;
          cc_read_IP<=INIT_IP;
	  cc_attr<=INIT_ATTR;
          miss_IP<=64'b0;
  //        link_IP<=48'b0;
//          tr_odd<=1'b0;
//          tr_half<=1'b0;
          tlb_data_reg<={`ctlbData_width{1'b0}};
          miss_now<=1'b0;
          miss_cnt<=5'b0;
          IP_chg<=1'b0;
          IP_chg_reg<=1'b0;
          IP_chg_reg2<=1'b0;
          IP_chg_reg3<=1'b0;
          IP_chg_reg4<=1'b0;
          miss_slot<=3'b0;
          tlb_hit_reg<=1'b0;
          bus_data_reg<={BUS_WIDTH{1'B0}};
          bus_match_reg<=1'b0;
          bus_tlb_match_reg<=1'b0;
          bus_tlb_match_reg2<=1'b0;
          bus_tlb_match_reg3<=1'b0;
          bus_tlb_data_reg<={`ctlbData_width{1'b0}};
          instrEn<=1'b0;
          instrEn_reg<=1'b0;
          instrEn_reg2<=1'b0;
          instrEn_reg3<=1'b0;
          cc_read_IP_reg<=64'b0;
          cc_read_IP_reg2<=64'b0;
          cc_read_IP_reg3<=64'b0;
          cc_read_IP_reg4<=64'b0;
          cc_read_IP_reg5<=64'b0;
          //cc_base_tick_reg<=1'b0;
         // cc_base_tick_reg2<=1'b0;
         // cc_base_tick_reg3<=1'b0;
         // cc_base_tick_reg4<=1'b0;

          tlbMiss_now<=1'b0;
          miss_seq<=1'b0;
          proc<=24'b0;
          kmode<=1'b1;
          miss_phys<=31'b0;
          tlb_hit_reg2<=1'b0;
          tlb_data_reg2<={`ctlbData_width{1'b0}};
          tlb_data_reg3<={`ctlbData_width{1'b0}};
          tlb_phys_reg<=32'b0;
          bus_match0_reg<=1'b0;
          bus_match0_reg2<=1'b0;
          bus_match0_reg3<=1'b0;
          bus_match0_reg4<=1'b0;
          pre_instrEn_reg<=13'b0;
          pre_instr0_reg<={INSTR_WIDTH{1'B0}};
          pre_instr1_reg<={INSTR_WIDTH{1'B0}};
          pre_instr2_reg<={INSTR_WIDTH{1'B0}};
          pre_instr3_reg<={INSTR_WIDTH{1'B0}};
          pre_instr4_reg<={INSTR_WIDTH{1'B0}};
          pre_instr5_reg<={INSTR_WIDTH{1'B0}};
          pre_instr6_reg<={INSTR_WIDTH{1'B0}};
          pre_instr7_reg<={INSTR_WIDTH{1'B0}};
          pre_instr8_reg<={INSTR_WIDTH{1'B0}};
          pre_instr9_reg<={INSTR_WIDTH{1'B0}};
          pre_instr10_reg<={INSTR_WIDTH{1'B0}};
          pre_instr11_reg<={INSTR_WIDTH{1'B0}};
	  pre_isAvx_reg<=1'b0;
          for (n=0;n<12;n=n+1) begin
              pre_off_reg[n]<=4'b0;
              pre_magic_reg[n]<=4'B0;
              pre_class_reg[n]<={CLS_WIDTH{1'B0}};
              if (n<4) btbx_joff_reg[n]<=4'b0;
              if (n<4) btbx_joff_reg2[n]<=4'b0;
              if (n<4) btbx_joff_reg3[n]<=4'b0;
              if (n<4) btbx_joff_reg4[n]<=4'b0;
          end
          instrFed_reg<=1'b0;
          btb_way_reg<=1'b0;
          btb_way_reg2<=1'b0;
          btb_hit_reg<=1'b0;
          btb_hit_reg2<=1'b0;
          btb_hit_reg3<=1'b0;
	  jmp_mask_reg[0]<=4'b0;
	  jmp_mask_reg[1]<=4'b0;
	  jmp_mask_reg[2]<=4'b0;
	  jmp_mask_reg[3]<=4'b0;
	  jmp_mask_reg2[0]<=4'b0;
	  jmp_mask_reg2[1]<=4'b0;
	  jmp_mask_reg2[2]<=4'b0;
	  jmp_mask_reg2[3]<=4'b0;
	  jmp_mask_reg3[0]<=4'b0;
	  jmp_mask_reg3[1]<=4'b0;
	  jmp_mask_reg3[2]<=4'b0;
	  jmp_mask_reg3[3]<=4'b0;
	  jmp_mask_reg4[0]<=4'b0;
	  jmp_mask_reg4[1]<=4'b0;
	  jmp_mask_reg4[2]<=4'b0;
	  jmp_mask_reg4[3]<=4'b0;
          btbx_tgt0_reg<=63'b0;
	  btbx_tgt1_reg<=63'b0;
	  btbx_tgt2_reg<=63'b0;
	  btbx_tgt3_reg<=63'b0;
	  btbx_tgt0_reg2<=63'b0;
	  btbx_tgt1_reg2<=63'b0;
	  btbx_tgt2_reg2<=63'b0;
	  btbx_tgt3_reg2<=63'b0;
	  btbx_tgt0_reg3<=63'b0;
	  btbx_tgt1_reg3<=63'b0;
	  btbx_tgt2_reg3<=63'b0;
	  btbx_tgt3_reg3<=63'b0;
	  btbx_tgt0_reg4<=63'b0;
	  btbx_tgt1_reg4<=63'b0;
	  btbx_tgt2_reg4<=63'b0;
	  btbx_tgt3_reg4<=63'b0;
          btbx_attr0_reg<=4'b0;
	  btbx_attr1_reg<=4'b0;
	  btbx_attr2_reg<=4'b0;
	  btbx_attr3_reg<=4'b0;
	  btbx_attr0_reg2<=4'b0;
	  btbx_attr1_reg2<=4'b0;
	  btbx_attr2_reg2<=4'b0;
	  btbx_attr3_reg2<=4'b0;
	  btbx_attr0_reg3<=4'b0;
	  btbx_attr1_reg3<=4'b0;
	  btbx_attr2_reg3<=4'b0;
	  btbx_attr3_reg3<=4'b0;
	  btbx_attr0_reg4<=4'b0;
	  btbx_attr1_reg4<=4'b0;
	  btbx_attr2_reg4<=4'b0;
	  btbx_attr3_reg4<=4'b0;
	  btbx_jmask_reg<=4'b0;
	  iqe_jcnt_reg<=6'b1;
	  iqe_jcnt_reg2<=6'b1;
	  startx_reg<=5'b0;
	  startx_reg2<=5'b0;
	  startx_reg3<=5'b0;
	  startx_reg4<=5'b0;
          do_seq_reg<=1'b0;
          do_seq_reg2<=1'b0;
          do_seq_reg3<=1'b0;
          do_seq_reg4<=1'b0;
          do_seq_reg5<=1'b0;
          btb_hasTK_reg<=1'b0;
          btb_hasTK_reg2<=1'b0;
          btb_hasTK_reg3<=1'b0;
          btb_hasTK_reg4<=1'b0;
          btbxx_way_reg<=1'b0;
          GHT_reg<=8'b0;
          GHT_reg2<=8'b0;
          GHT_reg3<=8'b0;
          GHT_reg4<=8'b0;
          taken_reg<=4'b0;
          taken_reg2<=4'b0;
          taken_reg3<=4'b0;
          taken_reg4<=4'b0;
	  predx_sc0_reg<=2'b0;
	  predx_sc1_reg<=2'b0;
	  predx_sc2_reg<=2'b0;
	  predx_sc3_reg<=2'b0;
	  predx_sc0_reg2<=2'b0;
	  predx_sc1_reg2<=2'b0;
	  predx_sc2_reg2<=2'b0;
	  predx_sc3_reg2<=2'b0;
	  predx_sc0_reg3<=2'b0;
	  predx_sc1_reg3<=2'b0;
	  predx_sc2_reg3<=2'b0;
	  predx_sc3_reg3<=2'b0;
	  predx_sc0_reg4<=2'b0;
	  predx_sc1_reg4<=2'b0;
	  predx_sc2_reg4<=2'b0;
	  predx_sc3_reg4<=2'b0;
	  cc_base_IP<={20'hf80ff,44'b0};
	  taken_REG<=4'b0;
	  btbx_jmask_REG<=4'b0;
	  miss_now_reg<=1'b0;
          jumpTK_en<=1'b0;
          jumpTK_addr<=64'b0;
	  jumpTK_attr<=4'b0;
	  IP_phys_reg<=44'b0;
	  IP_phys_reg2<=44'b0;
	  IP_phys_reg3<=44'b0;
          read_data_reg<=0;
      end else if (ixcept) begin
          //ixcept_reg<=1'b1;
          //ixceptLDConfl_reg<=ixceptLDConfl;
          jumpTK_en<=1'b0;
          read_set_flag<=ixceptLDConfl;
	  read_set_flag_reg<=1'b0;
          cc_read_IP<=cc_read_IP_d;
          cc_attr<=cc_attr_d;
          miss_now<=1'b0;
          miss_cnt<=5'b0;
          IP_chg<=1'b0;
          IP_chg_reg<=1'b0;
          IP_chg_reg2<=1'b0;
          IP_chg_reg3<=1'b0;
          IP_chg_reg4<=1'b0;
          miss_slot<=3'b0;
          tlb_hit_reg<=1'b0;
          bus_match_reg<=1'b0;
          bus_tlb_match_reg<=1'b0;
          bus_tlb_match_reg2<=1'b0;
          bus_tlb_match_reg3<=1'b0;
          instrEn<=1'b1;
          instrEn_reg<=1'b0;
          instrEn_reg2<=1'b0;
          instrEn_reg3<=1'b0;
          tlbMiss_now<=1'b0;
          miss_seq<=1'b0;
          tlb_hit_reg2<=1'b0;
          tlb_hit_reg3<=1'b0;
          tlb_hit_reg4<=1'b0;
          bus_match0_reg<=1'b0;
          bus_match0_reg2<=1'b0;
          bus_match0_reg3<=1'b0;
          bus_match0_reg4<=1'b0;
          instrFed_reg<=1'b0;
          btb_hit_reg<=1'b0;
          btb_hit_reg2<=1'b0;
          btb_hit_reg3<=1'b0;
          do_seq_reg<=1'b0;
          do_seq_reg2<=1'b0;
          do_seq_reg3<=1'b0;
          do_seq_reg4<=1'b0;
          do_seq_reg5<=1'b0;
          btb_hasTK_reg<=1'b0;
          btb_hasTK_reg2<=1'b0;
          btb_hasTK_reg3<=1'b0;
          btb_hasTK_reg4<=1'b0;
	  btb_can_ins_reg<=1'b1;
	  btb_can_ins_reg2<=1'b1;
	  btb_can_ins_reg3<=1'b1;
	  btb_can_ins_reg4<=1'b1;
	  btbx_cond_reg<=4'b0;
	  btbx_cond_reg2<=4'b0;
	  btbx_cond_reg3<=4'b0;
	  btbx_cond_reg4<=4'b0;
	  cc_base_IP<=cc_read_IP_d;
	  miss_IP<=cc_read_IP_d;
          pre_instrEn_reg<=13'b0;
      end else if (~fstall) begin
          //ixcept_reg<=1'b0;
          //ixceptLDConfl_reg<=1'b0;
          read_set_flag<=1'b0;
	  read_set_flag_reg<=read_set_flag;
          cc_read_IP<=cc_read_IP_d;
          cc_attr<=cc_attr_d;
          read_data_reg<=read_data;
          jumpTK_en<=1'b0;
          if ((~cc_read_hit|~tlb_match) & ~miss_now & instrEn_reg3) begin
              miss_IP<=cc_read_IP_reg3;
	      //proturberan<=cc_base_tick|cc_base_tick_reg|cc_base_tick_reg2|cc_base_tick_reg3;
              miss_phys<=IP_phys_reg3[43:13];
              miss_now<=1'b1;
              tlbMiss_now<=~tlb_match;
              miss_cnt<=0;
              miss_slot<=3'b0;
              miss_seq<=1'b1;
              instrEn<=1'b0;
	      instrEn_reg<=1'b0;
	      instrEn_reg2<=1'b0;
	      instrEn_reg3<=1'b0;
	      if (~btbFStall_recover_reg2) instrFed_reg<=1'b0;
              bus_match0_reg<=1'b0;
              bus_match0_reg2<=1'b0;
              bus_match0_reg3<=1'b0;
              bus_match0_reg4<=1'b0;
          end else begin
              instrEn_reg<=instrEn;
              instrEn_reg2<=instrEn_reg;
              instrEn_reg3<=instrEn_reg2;
              instrFed_reg<=instrFed;
	  end
          if (miss_recover) begin
              miss_now<=1'b0;
              tlbMiss_now<=1'b0;
              instrEn<=1'b1;
              miss_cnt<=5'b0;
              miss_slot<=3'b0;
	      //proturberan<=1'b0;
          end
          if (miss_cnt==15) miss_seq<=1'b0;
          if (miss_slot==7 || tlbMiss_now) miss_seq<=1'b0;
          if (miss_seq) miss_cnt<=miss_cnt_next;
          if (miss_seq && ~cc_read_hit && IP_chg_reg3) miss_slot<=miss_slot_next;
   //       link_IP<=link_IP_d;
          tlb_data_reg<=tlb_data;
          IP_chg<=(cc_read_IP[6:5]==2'b11) & do_seq || (cc_read_IP[6]==1'b1) & do_seq_miss || miss_recover;
          IP_chg_reg<=IP_chg;
          IP_chg_reg2<=IP_chg_reg;
          IP_chg_reg3<=IP_chg_reg2;
          IP_chg_reg4<=IP_chg_reg3;
          tlb_hit_reg<=tlb_hit;
          bus_data_reg<=bus_data;
          bus_match_reg<=bus_match;
          bus_tlb_match_reg<=bus_tlb_match;
          bus_tlb_match_reg2<=bus_tlb_match_reg;
          bus_tlb_match_reg3<=bus_tlb_match_reg2;
          bus_tlb_data_reg<=bus_tlb_data;
          cc_read_IP_reg<=cc_read_IP;
          cc_read_IP_reg2<=cc_read_IP_reg;
          cc_read_IP_reg3<=cc_read_IP_reg2;
          cc_read_IP_reg4<=cc_read_IP_reg3;
          cc_read_IP_reg5<=cc_read_IP_reg4;
         // cc_base_tick_reg<=cc_base_tick;
         // cc_base_tick_reg2<=cc_base_tick_reg;
         // cc_base_tick_reg3<=cc_base_tick_reg2;
         // cc_base_tick_reg4<=cc_base_tick_reg3;
          tlb_hit_reg2<=tlb_hit_reg;
          tlb_hit_reg3<=tlb_hit_reg2;
          tlb_hit_reg4<=tlb_hit_reg3;
          tlb_data_reg2<=tlb_data_reg;
          tlb_phys_reg<=tlb_phys;
          tlb_data_reg3<=tlb_data_reg2;
          if (~miss_recover) begin
              bus_match0_reg<=bus_match0_reg|bus_match0;
              bus_match0_reg2<=bus_match0_reg2|bus_match0_reg;
              bus_match0_reg3<=bus_match0_reg3|bus_match0_reg2;
              bus_match0_reg4<=bus_match0_reg4|bus_match0_reg3;
          end else begin
              bus_match0_reg<=1'b0;
              bus_match0_reg2<=1'b0;
              bus_match0_reg3<=1'b0;
              bus_match0_reg4<=1'b0;
          end
          pre_instrEn_reg<={1'b0,pre_instrEn};
          pre_instr0_reg<=pre_instr0;
          pre_instr1_reg<=pre_instr1;
          pre_instr2_reg<=pre_instr2;
          pre_instr3_reg<=pre_instr3;
          pre_instr4_reg<=pre_instr4;
          pre_instr5_reg<=pre_instr5;
          pre_instr6_reg<=pre_instr6;
          pre_instr7_reg<=pre_instr7;
          pre_instr8_reg<=pre_instr8;
          pre_instr9_reg<=pre_instr9;
          pre_instr10_reg<=pre_instr10;
          pre_instr11_reg<=pre_instr11;
	  pre_isAvx_reg<=pre_isAvx;
          for (n=0;n<12;n=n+1) begin
              pre_off_reg[n]<=pre_off[n];
              pre_magic_reg[n]<=pre_magic[n];
              pre_class_reg[n]<=pre_class[n];
              if (n<4) btbx_joff_reg[n]<=btbx_joff[n];
              if (n<4) btbx_joff_reg2[n]<=btbx_joff_reg[n];
              if (n<4) btbx_joff_reg3[n]<=btbx_joff_reg2[n];
              if (n<4) btbx_joff_reg4[n]<=btbx_joff_reg3[n];
          end
          btb_way_reg<=btb_way;
          btb_way_reg2<=btb_way_reg;
          btb_hit_reg<=btb_hit;
          btb_hit_reg2<=btb_hit_reg;
          btb_hit_reg3<=btb_hit_reg2;
	  jmp_mask_reg[0]<=jmp_mask[0];
	  jmp_mask_reg[1]<=jmp_mask[1];
	  jmp_mask_reg[2]<=jmp_mask[2];
	  jmp_mask_reg[3]<=jmp_mask[3];
	  jmp_mask_reg2[0]<=jmp_mask_reg[0];
	  jmp_mask_reg2[1]<=jmp_mask_reg[1];
	  jmp_mask_reg2[2]<=jmp_mask_reg[2];
	  jmp_mask_reg2[3]<=jmp_mask_reg[3];
	  jmp_mask_reg3[0]<=jmp_mask_reg2[0];
	  jmp_mask_reg3[1]<=jmp_mask_reg2[1];
	  jmp_mask_reg3[2]<=jmp_mask_reg2[2];
	  jmp_mask_reg3[3]<=jmp_mask_reg2[3];
	  jmp_mask_reg4[0]<=jmp_mask_reg3[0];
	  jmp_mask_reg4[1]<=jmp_mask_reg3[1];
	  jmp_mask_reg4[2]<=jmp_mask_reg3[2];
	  jmp_mask_reg4[3]<=jmp_mask_reg3[3];
          btbx_tgt0_reg<=btbx_tgt0;
	  btbx_tgt1_reg<=btbx_tgt1;
	  btbx_tgt2_reg<=btbx_tgt2;
	  btbx_tgt3_reg<=btbx_tgt3;
	  btbx_tgt0_reg2<=btbx_tgt0_reg;
	  btbx_tgt1_reg2<=btbx_tgt1_reg;
	  btbx_tgt2_reg2<=btbx_tgt2_reg;
	  btbx_tgt3_reg2<=btbx_tgt3_reg;
	  btbx_tgt0_reg3<=btbx_tgt0_reg2;
	  btbx_tgt1_reg3<=btbx_tgt1_reg2;
	  btbx_tgt2_reg3<=btbx_tgt2_reg2;
	  btbx_tgt3_reg3<=btbx_tgt3_reg2;
	  btbx_tgt0_reg4<=btbx_tgt0_reg3;
	  btbx_tgt1_reg4<=btbx_tgt1_reg3;
	  btbx_tgt2_reg4<=btbx_tgt2_reg3;
	  btbx_tgt3_reg4<=btbx_tgt3_reg3;
          btbx_attr0_reg<=btbx_attr0;
	  btbx_attr1_reg<=btbx_attr1;
	  btbx_attr2_reg<=btbx_attr2;
	  btbx_attr3_reg<=btbx_attr3;
	  btbx_attr0_reg2<=btbx_attr0_reg;
	  btbx_attr1_reg2<=btbx_attr1_reg;
	  btbx_attr2_reg2<=btbx_attr2_reg;
	  btbx_attr3_reg2<=btbx_attr3_reg;
	  btbx_attr0_reg3<=btbx_attr0_reg2;
	  btbx_attr1_reg3<=btbx_attr1_reg2;
	  btbx_attr2_reg3<=btbx_attr2_reg2;
	  btbx_attr3_reg3<=btbx_attr3_reg2;
	  btbx_attr0_reg4<=btbx_attr0_reg3;
	  btbx_attr1_reg4<=btbx_attr1_reg3;
	  btbx_attr2_reg4<=btbx_attr2_reg3;
	  btbx_attr3_reg4<=btbx_attr3_reg3;
	  btbx_jmask_reg<=(btb_way ? btb_chmaskB : btb_chmaskA)&{4{btb_hit}};
	  iqe_jcnt_reg<=iqe_jcnt;
	  iqe_jcnt_reg2<=iqe_jcnt_reg;
	  startx_reg<=startx;
	  startx_reg2<=startx_reg;
	  startx_reg3<=startx_reg2;
	  startx_reg4<=startx_reg3;
          do_seq_reg<=do_seq;
          do_seq_reg2<=do_seq_reg;
          do_seq_reg3<=do_seq_reg2;
          do_seq_reg4<=do_seq_reg3;
          do_seq_reg5<=do_seq_reg4;
          btb_hasTK_reg<=btb_hasTK && btb_hit;
          btb_hasTK_reg2<=btb_hasTK_reg;
          btb_hasTK_reg3<=btb_hasTK_reg2;
          btb_hasTK_reg4<=btb_hasTK_reg3;
          btbxx_way_reg<=btb_way_reg2;
          GHT_reg<=GHT;
          GHT_reg2<=GHT_reg;
          GHT_reg3<=GHT_reg2;
          GHT_reg4<=GHT_reg3;
          taken_reg<=taken;
          taken_reg2<=taken_reg;
          taken_reg3<=taken_reg2;
          taken_reg4<=taken_reg3;
	  predx_sc0_reg<=predx_sc0;
	  predx_sc1_reg<=predx_sc1;
	  predx_sc2_reg<=predx_sc2;
	  predx_sc3_reg<=predx_sc3;
	  predx_sc0_reg2<=predx_sc0_reg;
	  predx_sc1_reg2<=predx_sc1_reg;
	  predx_sc2_reg2<=predx_sc2_reg;
	  predx_sc3_reg2<=predx_sc3_reg;
	  predx_sc0_reg3<=predx_sc0_reg2;
	  predx_sc1_reg3<=predx_sc1_reg2;
	  predx_sc2_reg3<=predx_sc2_reg2;
	  predx_sc3_reg3<=predx_sc3_reg2;
	  predx_sc0_reg4<=predx_sc0_reg3;
	  predx_sc1_reg4<=predx_sc1_reg3;
	  predx_sc2_reg4<=predx_sc2_reg3;
	  predx_sc3_reg4<=predx_sc3_reg3;
	  btb_can_ins_reg<=1'b1;
	  btb_can_ins_reg2<=1'b1;
	  btb_can_ins_reg3<=1'b1;
	  btb_can_ins_reg4<=1'b1;
	  btbx_cond_reg<=btbx_cond;
	  btbx_cond_reg2<=btbx_cond_reg;
	  btbx_cond_reg3<=btbx_cond_reg2;
	  btbx_cond_reg4<=btbx_cond_reg3;
	  if (instrFed_reg&~btbFStall_recover_reg2)  cc_base_IP<=cc_base_IP_d;
	  miss_now_reg<=miss_now;
	  IP_phys_reg<=IP_phys;
	  IP_phys_reg2<=IP_phys_reg;
	  IP_phys_reg3<=IP_phys_reg2;
      end else if (btbFStall_recover && ~iq_fstall && ~jq_fstall && ~fmstall) begin
          pre_instrEn_reg<={1'b0,pre_instrEn};
          pre_instr0_reg<=pre_instr0;
          pre_instr1_reg<=pre_instr1;
          pre_instr2_reg<=pre_instr2;
          pre_instr3_reg<=pre_instr3;
          pre_instr4_reg<=pre_instr4;
          pre_instr5_reg<=pre_instr5;
          pre_instr6_reg<=pre_instr6;
          pre_instr7_reg<=pre_instr7;
          pre_instr8_reg<=pre_instr8;
          pre_instr9_reg<=pre_instr9;
          pre_instr10_reg<=pre_instr10;
          pre_instr11_reg<=pre_instr11;
          read_data_reg<=read_data;
	  pre_isAvx_reg<=pre_isAvx;
          for (n=0;n<12;n=n+1) begin
              pre_off_reg[n]<=pre_off[n];
              pre_magic_reg[n]<=pre_magic[n];
              pre_class_reg[n]<=pre_class[n];
              if (n<4) btbx_joff_reg3[n]<=btbx_joff[n];
          end
          instrFed_reg<=instrFed;
          do_seq_reg5<=do_seq_reg4;
          btb_hasTK_reg4<=btb_hasTK;
          taken_reg4<=taken;
	  predx_sc0_reg4<=predx_sc0;
	  predx_sc1_reg4<=predx_sc1;
	  predx_sc2_reg4<=predx_sc2;
	  predx_sc3_reg4<=predx_sc3;
          cc_read_IP_reg4<=cc_read_IP_reg3;
          cc_read_IP_reg5<=cc_read_IP_reg4;
          btbxx_way_reg<=btb_way;
          GHT_reg4<=GHT;
	  jmp_mask_reg4[0]<=jmp_mask[0];
	  jmp_mask_reg4[1]<=jmp_mask[1];
	  jmp_mask_reg4[2]<=jmp_mask[2];
	  jmp_mask_reg4[3]<=jmp_mask[3];
          btbx_tgt0_reg4<=btbx_tgt0;
	  btbx_tgt1_reg4<=btbx_tgt1;
	  btbx_tgt2_reg4<=btbx_tgt2;
	  btbx_tgt3_reg4<=btbx_tgt3;
          btbx_attr0_reg4<=btbx_attr0;
	  btbx_attr1_reg4<=btbx_attr1;
	  btbx_attr2_reg4<=btbx_attr2;
	  btbx_attr3_reg4<=btbx_attr3;
//	  iqe_jcnt_reg2<=iqe_jcnt_reg; //reg2 here at same clock as other reg3
	  startx_reg4<=startx;//??
	  btb_can_ins_reg4<=btb_can_ins;
	  btbx_cond_reg4<=btbx_cond;
	  taken_REG<=taken;
	  btbx_jmask_REG<=(btb_way ? btb_chmaskB : btb_chmaskA)&{4{btb_hit}};
          if (jumpTK_btb_fstall) begin
            //  instrEn<=1'b0;
              instrEn_reg<=1'b0;
              instrEn_reg2<=1'b0;
              instrEn_reg3<=1'b0;
              jumpTK_addr<=btbx_tgt;
	      jumpTK_attr<=btbx_attr;
              jumpTK_en<=1'b1;
          end
      end else if (btbFStall_reg3) begin
          btb_hit_reg3<=1'b1;
	  btb_can_ins_reg3<=btb_can_ins_reg2;
      end else if (btbFStall_reg2) begin
	  btb_can_ins_reg2<=btb_can_ins_reg;
	  btb_can_ins_reg<=btb_can_ins;
      end
      
      if (rst) begin
          last_off_reg<=4'b0;
          last_off_reg2<=4'b0;
          last_off_reg3<=4'b0;
          last_off_reg4<=4'b0;
      end else begin
          if (~fstall) begin
            last_off_reg<=last_off;
            last_off_reg2<=last_off_reg;
            last_off_reg3<=last_off_reg2;
            last_off_reg4<=last_off_reg3;
          end else if (btbFStall_recover && ~iq_fstall && ~jq_fstall && ~fmstall) begin
            last_off_reg4<=last_off;
          end
      end
  end
  
endmodule




module frontReq_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=44-13+64-27;
  localparam ADDR_WIDTH=3;
  localparam ADDR_COUNT=8;

  input clk;
  input rst;
  input read_clkEn;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  reg [ADDR_WIDTH-1:0] read_addr_reg;
  
  assign read_data=ram[read_addr_reg];

  always @(posedge clk)
    begin
      if (rst) read_addr_reg<={ADDR_WIDTH{1'b0}};
      else if (read_clkEn) read_addr_reg<=read_addr;
      if (write_wen) ram[write_addr]<=write_data;
    end

endmodule


module front_strip_ECC(dataIn,dataOut,par);
  input [39:1] dataIn;
  output [31:0] dataOut;
  output par;
  
  assign dataOut={dataIn[38:33],dataIn[31:17],dataIn[15:9],dataIn[7:5],dataIn[3]};
  assign par=dataIn[39];
  
endmodule