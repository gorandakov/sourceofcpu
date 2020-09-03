
module block_int(
  clk,
  rst,
  except,
  u1_A,u1_B,u1_S,u1_op,u1_ret,u1_rten,u1_clkEn,
    u1_A_fufwd,u1_A_fuufwd,u1_B_fufwd,u1_B_fuufwd,
    u1_S_fufwd,u1_S_fuufwd,
  u2_A,u2_B,u2_S,u2_op,u2_ret,u2_rten,u2_clkEn,
    u2_A_fufwd,u2_A_fuufwd,u2_B_fufwd,u2_B_fuufwd,
    u2_S_fufwd,u2_S_fuufwd,
  u3_A,u3_B,u3_S,u3_op,u3_ret,u3_rten,u3_clkEn,
    u3_A_fufwd,u3_A_fuufwd,u3_B_fufwd,u3_B_fuufwd,
    u3_S_fufwd,u3_S_fuufwd,
  u4_A,u4_B,u4_S,u4_op,u4_ret,u4_rten,u4_clkEn,
    u4_A_fufwd,u4_A_fuufwd,u4_B_fufwd,u4_B_fuufwd,
    u4_S_fufwd,u4_S_fuufwd,
  u5_A,u5_B,u5_S,u5_nDataAlt,u5_op,u5_ret,u5_rten,u5_clkEn,
    u5_A_fufwd,u5_A_fuufwd,u5_B_fufwd,u5_B_fuufwd,
    u5_S_fufwd,u5_S_fuufwd,
  u6_A,u6_B,u6_S,u6_op,u6_ret,u6_rten,u6_clkEn,
    u6_A_fufwd,u6_A_fuufwd,u6_B_fufwd,u6_B_fuufwd,
    u6_S_fufwd,u6_S_fuufwd,
  v1_base,v1_index,v1_const,
  v1_base_fufwd,v1_base_fuufwd,
  v1_index_fufwd,v1_index_fuufwd,
  v1_op,v1_reg,
  v1_LSQ_no,v1_II_no,v1_WQ_no,
  v1_lsflag,v1_clkEn,v1_attr,
  v2_base,v2_index,v2_const,
  v2_base_fufwd,v2_base_fuufwd,
  v2_index_fufwd,v2_index_fuufwd,
  v2_op,v2_reg,
  v2_LSQ_no,v2_II_no,v2_WQ_no,
  v2_lsflag,v2_clkEn,v2_attr,
  v3_base,v3_index,v3_const,
  v3_base_fufwd,v3_base_fuufwd,
  v3_index_fufwd,v3_index_fuufwd,
  v3_op,v3_reg,
  v3_LSQ_no,v3_II_no,v3_WQ_no,
  v3_lsflag,v3_clkEn,v3_attr,
  v4_base,v4_index,v4_const,
  v4_base_fufwd,v4_base_fuufwd,
  v4_index_fufwd,v4_index_fuufwd,
  v4_op,v4_reg,
  v4_LSQ_no,v4_II_no,v4_WQ_no,
  v4_lsflag,v4_clkEn,v4_attr,
  v5_base,v5_index,v5_const,
  v5_base_fufwd,v5_base_fuufwd,
  v5_index_fufwd,v5_index_fuufwd,
  v5_op,v5_reg,
  v5_LSQ_no,v5_II_no,v5_WQ_no,
  v5_lsflag,v5_clkEn,v5_attr,
  retire_enFl,
  retire0_rT,retire0_rF,retire0_enG,retire0_enV,retire0_enF,
  retire1_rT,retire1_rF,retire1_enG,retire1_enV,retire1_enF,
  retire2_rT,retire2_rF,retire2_enG,retire2_enV,retire2_enF,
  retire3_rT,retire3_rF,retire3_enG,retire3_enV,retire3_enF,
  retire4_rT,retire4_rF,retire4_enG,retire4_enV,retire4_enF,
  retire5_rT,retire5_rF,retire5_enG,retire5_enV,retire5_enF,
  retire6_rT,retire6_rF,retire6_enG,retire6_enV,retire6_enF,
  retire7_rT,retire7_rF,retire7_enG,retire7_enV,retire7_enF,
  retire8_rT,retire8_rF,retire8_enG,retire8_enV,retire8_enF,
  doRetire,retcnt,retclr,
  jupd0_en,jupdt0_en,jupd0_ght_en,
  jupd0_addr,jupd0_baddr,
  jupd0_sc,jupd0_tk,
  jupd1_en,jupdt1_en,jupd1_ght_en,
  jupd1_addr,jupd1_baddr,
  jupd1_sc,jupd1_tk,
  ret0_addr,ret0_data,ret0_wen,
  ret1_addr,ret1_data,ret1_wen,
  ret2_addr,ret2_data,ret2_wen,
  ret3_addr,ret3_data,ret3_wen,
  ret4_addr,ret4_data,ret4_wen,
  ret5_addr,ret5_data,ret5_wen,ret5_IP,ret5_IP_en,
  ret6_addr,ret6_data,ret6_wen,
  ret7_addr,ret7_data,ret7_wen,
  req_addr,req_tlbEn,
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
  wr1_hit,
  wr1_addrE,wr1_addrO,
  wr1_banks,
  wr1_begin,wr1_end,
  wr1_bgn_ben,wr1_end_ben,
  wr1_odd,wr1_split,
  wr1_data,
  wrStall
);
  parameter [4:0] BUS_ID;
  input clk;
  input rst;
  output except;
  output excpt_set_flag;
  output csrss_en;
  output [15:0] csrss_addr;
  output [64:0] csrss_data;

  input [64:0]          u1_A;
  input [64:0]          u1_B;
  input [5:0]           u1_S;
  input [12:0]          u1_op;
  input                 u1_clkEn;
  input [3:0]           u1_A_fufwd;
  input [3:0]           u1_A_fuufwd;
  input [3:0]           u1_B_fufwd;
  input [3:0]           u1_B_fuufwd;
  input [3:0]           u1_S_fufwd;
  input [3:0]           u1_S_fuufwd;

  input [64:0]          u2_A;
  input [64:0]          u2_B;
  input [5:0]           u2_S;
  input [12:0]          u2_op;
  input                 u2_clkEn;
  input [3:0]           u2_A_fufwd;
  input [3:0]           u2_A_fuufwd;
  input [3:0]           u2_B_fufwd;
  input [3:0]           u2_B_fuufwd;
  input [3:0]           u2_S_fufwd;
  input [3:0]           u2_S_fuufwd;

  input [64:0]          u3_A;
  input [64:0]          u3_B;
  input [5:0]           u3_S;
  input [12:0]          u3_op;
  input                 u3_clkEn;
  input [3:0]           u3_A_fufwd;
  input [3:0]           u3_A_fuufwd;
  input [3:0]           u3_B_fufwd;
  input [3:0]           u3_B_fuufwd;
  input [3:0]           u3_S_fufwd;
  input [3:0]           u3_S_fuufwd;

  input [64:0]          u4_A;
  input [64:0]          u4_B;
  input [5:0]           u4_S;
  input [12:0]          u4_op;
  input                 u4_clkEn;
  input [3:0]           u4_A_fufwd;
  input [3:0]           u4_A_fuufwd;
  input [3:0]           u4_B_fufwd;
  input [3:0]           u4_B_fuufwd;
  input [3:0]           u4_S_fufwd;
  input [3:0]           u4_S_fuufwd;

  input [64:0]          u5_A;
  input [64:0]          u5_B;
  input [5:0]           u5_S;
  input                 u5_nDataAlt;
  input [12:0]          u5_op;
  input                 u5_clkEn;
  input [3:0]           u5_A_fufwd;
  input [3:0]           u5_A_fuufwd;
  input [3:0]           u5_B_fufwd;
  input [3:0]           u5_B_fuufwd;
  input [3:0]           u5_S_fufwd;
  input [3:0]           u5_S_fuufwd;

  input [64:0]          u6_A;
  input [64:0]          u6_B;
  input [5:0]           u6_S;
  input [12:0]          u6_op;
  input                 u6_clkEn;
  input [3:0]           u6_A_fufwd;
  input [3:0]           u6_A_fuufwd;
  input [3:0]           u6_B_fufwd;
  input [3:0]           u6_B_fuufwd;
  input [3:0]           u6_S_fufwd;
  input [3:0]           u6_S_fuufwd;

  input [64:0] v1_base;
  input [64:0] v1_index;
  input [32:0] v1_const;
  input [3:0]  v1_base_fufwd;
  input [3:0]  v1_base_fuufwd;
  input [3:0]  v1_index_fufwd;
  input [3:0]  v1_index_fuufwd;
  input [12:0] v1_op;
  input [8:0]  v1_reg;
  input [8:0]  v1_LSQ_no;
  input [9:0]  v1_II_no;
  input [7:0]  v1_WQ_no;
  input        v1_lsflag;
  input        v1_clkEn;
  input [3:0]  v1_attr;
  input [64:0] v2_base;
  input [64:0] v2_index;
  input [32:0] v2_const;
  input [3:0]  v2_base_fufwd;
  input [3:0]  v2_base_fuufwd;
  input [3:0]  v2_index_fufwd;
  input [3:0]  v2_index_fuufwd;
  input [12:0] v2_op;
  input [8:0]  v2_reg;
  input [8:0]  v2_LSQ_no;
  input [9:0]  v2_II_no;
  input [7:0]  v2_WQ_no;
  input        v2_lsflag;
  input        v2_clkEn;
  input [3:0]  v2_attr;
  input [64:0] v3_base;
  input [64:0] v3_index;
  input [32:0] v3_const;
  input [3:0]  v3_base_fufwd;
  input [3:0]  v3_base_fuufwd;
  input [3:0]  v3_index_fufwd;
  input [3:0]  v3_index_fuufwd;
  input [12:0] v3_op;
  input [8:0]  v3_reg;
  input [8:0]  v3_LSQ_no;
  input [9:0]  v3_II_no;
  input [7:0]  v3_WQ_no;
  input        v3_lsflag;
  input        v3_clkEn;
  input [3:0]  v3_attr;
  input [64:0] v4_base;
  input [64:0] v4_index;
  input [32:0] v4_const;
  input [3:0]  v4_base_fufwd;
  input [3:0]  v4_base_fuufwd;
  input [3:0]  v4_index_fufwd;
  input [3:0]  v4_index_fuufwd;
  input [12:0] v4_op;
  input [8:0]  v4_reg;
  input [8:0]  v4_LSQ_no;
  input [9:0]  v4_II_no;
  input [7:0]  v4_WQ_no;
  input        v4_lsflag;
  input        v4_clkEn;
  input [3:0]  v4_attr;
  input [64:0] v5_base;
  input [64:0] v5_index;
  input [32:0] v5_const;
  input [3:0]  v5_base_fufwd;
  input [3:0]  v5_base_fuufwd;
  input [3:0]  v5_index_fufwd;
  input [3:0]  v5_index_fuufwd;
  input [12:0] v5_op;
  input [8:0]  v5_reg;
  input [8:0]  v5_LSQ_no;
  input [9:0]  v5_II_no;
  input [7:0]  v5_WQ_no;
  input        v5_lsflag;
  input        v5_clkEn;
  input [3:0]  v5_attr;
  input [1:0] mOp0_clHit;
  input [1:0] mOp1_clHit;
  input [1:0] mOp2_clHit;
  input [1:0] mOp3_clHit;
  input FU0Hit,FU1Hit,FU2Hit,FU3Hit;

  wire [8:0]            u1_ret;
  wire                  u1_rten;
  wire [8:0]            u2_ret;
  wire                  u2_rten;
  wire [8:0]            u3_ret;
  wire                  u3_rten;
  wire [8:0]            u4_ret;
  wire                  u4_rten;
  wire [8:0]            u5_ret;
  wire                  u5_rten;
  wire [8:0]            u6_ret;
  wire                  u6_rten;


  fu_alu mod_rightmost(
  clk,
  rst,
  except,
  u1_A,u1_B,u1_S,u1_op,u1_ret,u1_rten,u1_clkEn,
    u1_A_fufwd,u1_A_fuufwd,u1_B_fufwd,u1_B_fuufwd,
    u1_S_fufwd,u1_S_fuufwd,
  u2_A,u2_B,u2_S,u2_op,u2_ret,u2_rten,u2_clkEn,
    u2_A_fufwd,u2_A_fuufwd,u2_B_fufwd,u2_B_fuufwd,
    u2_S_fufwd,u2_S_fuufwd,
  u3_A,u3_B,u3_S,u3_op,u3_ret,u3_rten,u3_clkEn,
    u3_A_fufwd,u3_A_fuufwd,u3_B_fufwd,u3_B_fuufwd,
    u3_S_fufwd,u3_S_fuufwd,
  u4_A,u4_B,u4_S,u4_op,u4_ret,u4_rten,u4_clkEn,
    u4_A_fufwd,u4_A_fuufwd,u4_B_fufwd,u4_B_fuufwd,
    u4_S_fufwd,u4_S_fuufwd,
  u5_A,u5_B,u5_S,u5_nDataAlt,u5_op,u5_ret,u5_rten,u5_clkEn,
    u5_A_fufwd,u5_A_fuufwd,u5_B_fufwd,u5_B_fuufwd,
    u5_S_fufwd,u5_S_fuufwd,
  u6_A,u6_B,u6_S,u6_op,u6_ret,u6_rten,u6_clkEn,
    u6_A_fufwd,u6_A_fuufwd,u6_B_fufwd,u6_B_fuufwd,
    u6_S_fufwd,u6_S_fuufwd,
  FU0, FU1,  FU2,  FU3,
  FU4, FU5,  FU6,  FU7,
  FU8, FU9,
  FUS1,  FUS2,  FUS3,
  FUS4, FUS5,  FUS6,  FUS7,
  FUS8,FUS9,
  fxFRT_alten_reg,
  fcvtout,
  DataAlt,
  FUCVTIN
  );

  agu_block #(BUS_ID) mod_middle(
  clk, rst,
  except,
  //excpt_gate,
  //excpt_in_vm,
  //excpt_in_km,
  pause_agu,
  miss_holds_agu,
  miss_pause_agu,
  wt_pause_agu,
  mOp_write_clear,
  v1_base,v1_index,v1_const,
  v1_base_fufwd,v1_base_fuufwd,
  v1_index_fufwd,v1_index_fuufwd,
  v1_op,v1_reg,
  v1_LSQ_no,v1_II_no,v1_WQ_no,
  v1_lsflag,v1_clkEn,v1_attr,
  v2_base,v2_index,v2_const,
  v2_base_fufwd,v2_base_fuufwd,
  v2_index_fufwd,v2_index_fuufwd,
  v2_op,v2_reg,
  v2_LSQ_no,v2_II_no,v2_WQ_no,
  v2_lsflag,v2_clkEn,v2_attr,
  v3_base,v3_index,v3_const,
  v3_base_fufwd,v3_base_fuufwd,
  v3_index_fufwd,v3_index_fuufwd,
  v3_op,v3_reg,
  v3_LSQ_no,v3_II_no,v3_WQ_no,
  v3_lsflag,v3_clkEn,v3_attr,
  v4_base,v4_index,v4_const,
  v4_base_fufwd,v4_base_fuufwd,
  v4_index_fufwd,v4_index_fuufwd,
  v4_op,v4_reg,
  v4_LSQ_no,v4_II_no,v4_WQ_no,
  v4_lsflag,v4_clkEn,v4_attr,
  v5_base,v5_index,v5_const,
  v5_base_fufwd,v5_base_fuufwd,
  v5_index_fufwd,v5_index_fuufwd,
  v5_op,v5_reg,
  v5_LSQ_no,v5_II_no,v5_WQ_no,
  v5_lsflag,v5_clkEn,v5_attr,
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
  mOpY5_type_o,
  mOpY5_II_o,
  lso_adata,lso_xdataA,lso_data,lso_bnkread,
  lso2_adata,lso2_xdataA,lso2_data,lso2_bnkread,lso2_wb_en,
  p0_adata,p0_banks,p0_LSQ,p0_en,p0_rsEn,p0_secq,p0_ret,p0_repl,p0_lsfwd,
  p1_adata,p1_banks,p1_LSQ,p1_en,p1_rsEn,p1_secq,p1_ret,p1_repl,p1_lsfwd,
  p2_adata,p2_banks,p2_LSQ,p2_en,p2_rsEn,p2_secq,p2_ret,p2_repl,p2_lsfwd,p2_data,p2_brdbanks,
  p3_adata,p3_banks,p3_LSQ,p3_en,p3_rsEn,p3_ioEn,p3_io_ack,p3_ret,p3_data,p3_brdbanks,p3_repl,p3_lsfwd,
  p4_adata,p4_LSQ,p4_en,p4_secq,p4_ret,
  p5_adata,p5_LSQ,p5_en,p5_secq,p5_ret,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  FU0,FU1,FU2,FU3,FU4,FU5,FU6,FU7,FU8,FU9,
  FUreg3_reg,dc_rdataA,
  msi_exp_addr,msi_en,msi_out_clear,//msi_out_clear=can do msi en
  csrss_en,csrss_addr,csrss_data,
  alt_bus_hold,
  alt_bus_addr,
  req_addr,req_tlbEn,
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
  wr1_hit,
  wr1_addrE,wr1_addrO,
  wr1_banks,
  wr1_begin,wr1_end,
  wr1_bgn_ben,wr1_end_ben,
  wr1_odd,wr1_split,
  wr1_data,
  wrStall
  );

  fun_lsq mod_leftmost(
  clk,
  rst,
  except,
  bus_holds_agu_reg2,miss_holds_agu_reg2,miss_pause_agu_reg2,insert_isData_reg2,
  pause_agu,WDoRsPause,
  p0_adata,p0_LSQ,p0_en,p0_rsEn,p0_smpc,p0_lsfwd,
  p1_adata,p1_LSQ,p1_en,p1_rsEn,p1_smpc,p1_lsfwd,
  p2_adata,p2_LSQ,p2_en,p2_rsEn,p2_smpc,p2_lsfwd,
  p3_adata,p3_LSQ,p3_en,p3_rsEn,p3_smpc,p3_lsfwd,
  p4_adata,p4_LSQ,p4_en,
  p5_adata,p5_LSQ,p5_en,
  FU0Hit,
  FU1Hit,
  FU2Hit,
  FU3Hit,
  st_stall,
  st0_adata,st0_en,st0_bank1,st0_bgn_ben,st0_end_ben,st0_data,
  st1_adata,st1_en,st1_bank1,st1_bgn_ben,st1_end_ben,st1_data,
  wb0_adata,wb0_LSQ,wb0_en,wb0_ret,wb0_data,wb0_brdbanks,
  wb1_adata,wb1_LSQ,wb1_en,wb1_ret,wb1_data,wb1_brdbanks,
  mem_II_upper,
  mem_II_upper_in,
  mem_II_bits_fine,
  mem_II_bits_ldconfl,
  mem_II_bits_waitconfl,
  mem_II_bits_except,
  mem_II_bits_ret,
  mem_II_exbitsx6,
  mem_II_stall,
  mem_II_stall2,
  doStall_rs,stall_cntrl, 
  doStall_alloc,doStall_cntrl,
  doStall_WQ,stall_WQ,
  doRetire_d,
  xbreak,
  has_xbreak,
  ldq_new_mask_reg,bundle_in_reg2,II_upper,LSQ_shr_data,
  WQS0_reg,WQR0_reg,
  WQS1_reg,WQR1_reg,
  WQS2_reg,WQR2_reg,
  lsw_wq0,lsw_wdata0,lsw_rs_en0,
  lsw_wq1,lsw_wdata1,lsw_rs_en1,
  mOpY4_II,mOpY4_hit,
  mOpY5_II,mOpY5_hit,
  lsi0_reg,lsi1_reg,lsi2_reg,
  MSI_exp_addr,MSI_en,
  doStall_STQ,
  doStall_LDQ,
  doStall_LSQ 
  );

  cntrl_find_outcome mod_leftmost_top(
  clk,rst,
  stall,doStall,
  except,
  exceptIP,
  except_thread,
  except_both,
  except_due_jump,
  except_jump_ght,
  except_set_instr_flag,
  except_jmp_mask_en,
  except_jmp_mask,
  csrss_no,csrss_thread,csrss_en,csrss_data,
  new_en,new_thread,new_addr,
  instr0_en,instr0_wren,instr0_IPOff,instr0_magic,instr0_last,instr0_after_spec,
  instr1_en,instr1_wren,instr1_IPOff,instr1_magic,instr1_last,instr1_after_spec,
  instr2_en,instr2_wren,instr2_IPOff,instr2_magic,instr2_last,instr2_after_spec,
  instr3_en,instr3_wren,instr3_IPOff,instr3_magic,instr3_last,instr3_after_spec,
  instr4_en,instr4_wren,instr4_IPOff,instr4_magic,instr4_last,instr4_after_spec,
  instr5_en,instr5_wren,instr5_IPOff,instr5_magic,instr5_last,instr5_after_spec,
  instr6_en,instr6_wren,instr6_IPOff,instr6_magic,instr6_last,instr6_after_spec,
  instr7_en,instr7_wren,instr7_IPOff,instr7_magic,instr7_last,instr7_after_spec,
  instr8_en,instr8_wren,instr8_IPOff,instr8_magic,instr8_last,instr8_after_spec,
  instr9_en,instr9_wren,instr9_IPOff,instr9_magic,instr9_last,instr9_after_spec,
  instr_attr,
  instr0_rT,instr0_gen,instr0_vec,
  instr1_rT,instr1_gen,instr1_vec,
  instr2_rT,instr2_gen,instr2_vec,
  instr3_rT,instr3_gen,instr3_vec,
  instr4_rT,instr4_gen,instr4_vec,
  instr5_rT,instr5_gen,instr5_vec,
  instr6_rT,instr6_gen,instr6_vec,
  instr7_rT,instr7_gen,instr7_vec,
  instr8_rT,instr8_gen,instr8_vec,
  instr9_rT,instr9_gen,instr9_vec,
  iret0,iret1,iret2,iret3,iret4,
  iret5,iret6,iret7,iret8,
  iret0_rF,iret1_rF,iret2_rF,iret3_rF,iret4_rF,
  iret5_rF,iret6_rF,iret7_rF,iret8_rF,
  iret_clr,
  ijump0Type,ijump0Off,ijump0IP,ijump0BND,ijump0Mask,
  ijump1Type,ijump1Off,ijump1IP,ijump1BND,ijump1Mask,
  ijump0BtbWay,ijump0JmpInd,ijump0GHT,
  ijump1BtbWay,ijump1JmpInd,ijump1GHT,
  ijump0SC,ijump0Miss,ijump0BtbOnly,
  ijump1SC,ijump1Miss,ijump1BtbOnly,
  itk_after,ifsimd,
  iJump0Taken,iJump1Taken,
  flTE,retire_enFl,
  retire0_rT,retire0_rF,retire0_enG,retire0_enV,retire0_enF,
  retire1_rT,retire1_rF,retire1_enG,retire1_enV,retire1_enF,
  retire2_rT,retire2_rF,retire2_enG,retire2_enV,retire2_enF,
  retire3_rT,retire3_rF,retire3_enG,retire3_enV,retire3_enF,
  retire4_rT,retire4_rF,retire4_enG,retire4_enV,retire4_enF,
  retire5_rT,retire5_rF,retire5_enG,retire5_enV,retire5_enF,
  retire6_rT,retire6_rF,retire6_enG,retire6_enV,retire6_enF,
  retire7_rT,retire7_rF,retire7_enG,retire7_enV,retire7_enF,
  retire8_rT,retire8_rF,retire8_enG,retire8_enV,retire8_enF,
  doRetire,retcnt,retclr,
  jupd0_en,jupdt0_en,jupd0_ght_en,
  jupd0_addr,jupd0_baddr,
  jupd0_sc,jupd0_tk,
  jupd1_en,jupdt1_en,jupd1_ght_en,
  jupd1_addr,jupd1_baddr,
  jupd1_sc,jupd1_tk,
  ret0_addr,ret0_data,ret0_wen,
  ret1_addr,ret1_data,ret1_wen,
  ret2_addr,ret2_data,ret2_wen,
  ret3_addr,ret3_data,ret3_wen,
  ret4_addr,ret4_data,ret4_wen,
  ret5_addr,ret5_data,ret5_wen,ret5_IP,ret5_IP_en,
  ret6_addr,ret6_data,ret6_wen,
  ret7_addr,ret7_data,ret7_wen,
  mem_II_upper,
  mem_II_upper_out,
  mem_II_bits_fine,
  mem_II_bits_ldconfl,
  mem_II_bits_except,
  mem_II_bits_ret,
  mem_II_stall,
  
  doRetire_d,
  xbreak,
  has_xbreak
  );

endmodule

