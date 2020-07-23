`include "../struct.sv"
  
module fun_lsq(
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

  input clk;
  input rst;
  input except;
  input bus_holds_agu_reg2,miss_holds_agu_reg2,miss_pause_agu_reg2,insert_isData_reg2;
  input pause_agu;
  output [1:0] WDoRsPause;
  input [`lsaddr_width-1:0] p0_adata;
  input [8:0]               p0_LSQ;
  input                     p0_en;
  input                     p0_rsEn;
  input                     p0_smpc;
  input                     p0_lsfwd;
  input [`lsaddr_width-1:0] p1_adata;
  input [8:0]               p1_LSQ;
  input                     p1_en;
  input                     p1_rsEn;
  input                     p1_smpc;
  input                     p1_lsfwd;
  input [`lsaddr_width-1:0] p2_adata;
  input [8:0]               p2_LSQ;
  input                     p2_en;
  input                     p2_rsEn;
  input                     p2_smpc;
  input                     p2_lsfwd;
  input [`lsaddr_width-1:0] p3_adata;
  input [8:0]               p3_LSQ;
  input                     p3_en;
  input                     p3_rsEn;
  input                     p3_smpc;
  input                     p3_lsfwd;
  input [`lsaddr_width-1:0] p4_adata;
  input [8:0]               p4_LSQ;
  input                     p4_en;
  input [`lsaddr_width-1:0] p5_adata;
  input [8:0]               p5_LSQ;
  input                     p5_en;
  input FU0Hit,FU1Hit,FU2Hit,FU3Hit;
  input st_stall;
  output [`lsaddr_width-1:0] st0_adata;
  output                     st0_en;
  output [4:0]               st0_bank1;
  output [3:0]               st0_bgn_ben;
  output [3:0]               st0_end_ben;
  output [159:0]             st0_data;
  output [`lsaddr_width-1:0] st1_adata;
  output                     st1_en;
  output [4:0]               st1_bank1;
  output [3:0]               st1_bgn_ben;
  output [3:0]               st1_end_ben;
  output [159:0]             st1_data;
  output [`lsaddr_width-1:0] wb0_adata;
  output [8:0]               wb0_LSQ;
  output                     wb0_en;
  output [12:0]              wb0_ret;
  output [127+8:0]           wb0_data;
  output [3:0]               wb0_brdbanks;
  output [`lsaddr_width-1:0] wb1_adata;
  output [8:0]               wb1_LSQ;
  output                     wb1_en;
  output [12:0]              wb1_ret;
  output [127+8:0]           wb1_data;
  output [3:0]               wb1_brdbanks;
  
  output [5:0]   mem_II_upper;
  input  [5:0]   mem_II_upper_in;
  output [9:0]   mem_II_bits_fine;
  output [9:0]   mem_II_bits_ldconfl;
  output [9:0]   mem_II_bits_waitconfl;
  output [9:0]   mem_II_bits_except;
  output [9:0]   mem_II_bits_ret;
  output [39:0]  mem_II_exbitsx6;
  output         mem_II_stall;
  output         mem_II_stall2;
  input [3:0] doStall_rs;
  output stall_cntrl;  
  input doStall_alloc;
  input doStall_cntrl;
  input doStall_WQ;
  output stall_WQ;
  wire stall;
  input doRetire_d;
  input [9:0] xbreak;
  input has_xbreak;
  input [5:0] ldq_new_mask_reg;
  input bundle_in_reg2;
  input [5:0] II_upper;
  input [`lsqshare_width-1:0] LSQ_shr_data;
  input [7:0] WQS0_reg;
  input [7:0] WQR0_reg;
  input [7:0] WQS1_reg;
  input [7:0] WQR1_reg;
  input [7:0] WQS2_reg;
  input [7:0] WQR2_reg;
  input [7:0]     lsw_wq0;
  input [127+8:0] lsw_wdata0;
  input [3:0]     lsw_rs_en0;
  input [7:0]     lsw_wq1;
  input [127+8:0] lsw_wdata1;
  input [3:0]     lsw_rs_en1;
  input [9:0] mOpY4_II;
  input       mOpY4_hit;
  input [9:0] mOpY5_II;
  input       mOpY5_hit;
  input [2:0] lsi0_reg;
  input [2:0] lsi1_reg;
  input [2:0] lsi2_reg;
  input [36:0] MSI_exp_addr;
  input MSI_en;
  output doStall_STQ;
  output doStall_LDQ;
  output doStall_LSQ;
 
  wire stall_STQ;
  wire aStall_STQ,lStall_STQ;
  wire aDoStall_STQ;
 // wire lStall_STQ;
  wire lDoStall_STQ;
  wire lDoStall_lsfw;
  wire [`lsqshare_width-1:0] LSQ_shr_dataA;
  wire [`lsaddr_width-1:0] LSQ_dataA0;
  wire [`lsaddr_width-1:0] LSQ_dataA1;
  wire [`lsaddr_width-1:0] LSQ_dataA2;
  wire [`lsaddr_width-1:0] LSQ_dataA3;
  wire [`lsaddr_width-1:0] LSQ_dataA4;
  wire [`lsaddr_width-1:0] LSQ_dataA5;
  wire [5:0] LSQ_enA;
  wire LSQ_rdy_A;
  wire LSQ_rdy_AP;
  wire [5:0] STQ_confl;
  wire [3:0] PSTQ_match;
  wire [`lsaddr_width-1:0] PSTQ_data[2:0];
  wire [2:0] PSTQ_en;
  wire [5:0] PSTQ_data_shr;
  wire [`lsqshare_width-1:0] retM_data_shr;
  wire [`lsqshare_width-1:0] retM_data_shr_reg; 

  wire [`lsaddr_width-1:0]   stqd_mOpA;
  wire [`lsaddr_width-1:0]   stqd_mOpB;
  wire [`lsfxdata_width-1:0] stqd_xdataA0;
  wire [`lsfxdata_width-1:0] stqd_xdataA1;
  wire [`lsfxdata_width-1:0] stqd_xdataB0;
  wire [`lsfxdata_width-1:0] stqd_xdataB1;
  wire [7:0]                 stqd_addrA0;
  wire [7:0]                 stqd_addrA1;
  wire [7:0]                 stqd_addrB0;
  wire [7:0]                 stqd_addrB1;
  wire [127+8:0]             stqd_dataA0;
  wire [127+8:0]             stqd_dataB0;
  wire [127+8:0]             stqd_dataA1;
  wire [127+8:0]             stqd_dataB1;
  wire                       stqd_rdyA0;
  wire                       stqd_rdyA1;
  wire                       stqd_rdyB0;
  wire                       stqd_rdyB1;
  wire [127+8:0]               dc_wdataP[1:0];
  reg  [127+8:0]               dc_wdataP_reg[1:0];
  wire [1:0] sdata_rdy;
  wire [5:0] retM_II_in;
  wire [5:0] retM_II;
  reg st_stall_reg;

  wire [3*32-1:0] new_conflictx;
  wire [3*32-1:0] new_conflicty;
//  wire [3*BUF_COUNT-1:0] p1_new_conflictAp;
//  wire [3*BUF_COUNT-1:0] p1_new_conflictBp;
  wire [3*32-1:0] new_conflictA;
  wire [11:0] p1_new_conflictA_b;
  wire [2:0] new_conflictA_has;
  wire [3*32-1:0] new_conflictB;
  wire [11:0] p1_new_conflictB_b;
  wire [2:0] new_conflictB_has;
  wire [`lsaddr_width-1:0] lstep1_owndataA;
  wire [`lsaddr_width-1:0] lstep1_owndataB;
  wire [3*32-1:0] new_conflict2_acc;
  wire [32-1:0] p1_nChNextA0;
  wire [32-1:0] p1_nChNextA1;
  wire [32-1:0] p1_nChNextA2;
  wire [4:0] p1_ins_addr0;
  wire [`lsaddr_width-1:0] p1_pos_dataA0;
  wire p1_pos_en0;
  wire [4:0] p1_ins_addr1;
  wire [`lsaddr_width-1:0] p1_pos_dataA1;
  wire p1_pos_en1;
  wire [4:0] p1_ins_addr2;
  wire [`lsaddr_width-1:0] p1_pos_dataA2;
  wire p1_pos_en2;

/*  wire [9:0] wret_II0;
  wire wret_en0;
  wire [9:0] wret_II1;
  wire wret_en1;
  */
  wire new_en_reg2;
  wire new_enP_reg2;
  wire p1_peek_aStall;
  wire [5:0] confl_first;
  wire [5:0] confl_last;
  wire [6:0] confl_cnt;
  wire [95:0] m_mask;
  wire [95:0] n_mask;

  wire p1_inhibit;

  reg [`lsaddr_width-1:0] p0_adata_x;
  reg [`lsaddr_width-1:0] p1_adata_x;
  reg [`lsaddr_width-1:0] p2_adata_x;
  reg [`lsaddr_width-1:0] p3_adata_x;

  always @(*) begin
      p0_adata_x=p0_adata;
      p0_adata_x[`lsaddr_pconfl]=PSTQ_match[0];
      p1_adata_x=p1_adata;
      p1_adata_x[`lsaddr_pconfl]=PSTQ_match[1];
      p2_adata_x=p2_adata;
      p2_adata_x[`lsaddr_pconfl]=PSTQ_match[2];
      p3_adata_x=p3_adata;
      p3_adata_x[`lsaddr_pconfl]=PSTQ_match[3];
  end
  

  storq storq_mod(
  .clk(clk),
  .rst(rst),
  .stall(stall_STQ),
  .doStall(doStall_STQ),
  .aStall(aStall_STQ|lStall_STQ),
  .aDoStall(aDoStall_STQ),
  .lStall(lStall_STQ),
  .lDoStall(lDoStall_STQ),
  .bStall(mem_II_stall),
  .rDoStall(mem_II_stall2),
  .newI_alloc({LSQ_shr_data[`lsqshare_wrt2]!=3'd7,LSQ_shr_data[`lsqshare_wrt1]!=3'd7,
     LSQ_shr_data[`lsqshare_wrt0]!=3'd7}),
  .newII_upper(II_upper),.newII_req(bundle_in_reg2),
  .except(except),
  .excpt_thread(1'b0),
  .new_data_shr(LSQ_shr_dataA),
  .new_dataA0(LSQ_dataA0),.new_enA0(LSQ_enA[0]),
  .new_dataA1(LSQ_dataA1),.new_enA1(LSQ_enA[1]),
  .new_dataA2(LSQ_dataA2),.new_enA2(LSQ_enA[2]),
  .new_dataA3(LSQ_dataA3),.new_enA3(LSQ_enA[3]),
  .new_dataA4(LSQ_dataA4),.new_enA4(LSQ_enA[4]),
  .new_dataA5(LSQ_dataA5),.new_enA5(LSQ_enA[5]),
  .new_en(LSQ_rdy_A),
  .new_enP(LSQ_rdy_AP),
  .new_thr(1'b0),//fixme
  .new_confl(STQ_confl), //redundant?
  .pch_dataA0(p0_adata),.pch_confl0(PSTQ_match[0]),
  .pch_dataA1(p1_adata),.pch_confl1(PSTQ_match[1]),
  .pch_dataA2(p2_adata),.pch_confl2(PSTQ_match[2]),
  .pch_dataA3(p3_adata),.pch_confl3(PSTQ_match[3]),
//  .new_confl0(STQ_confls[0]),
//  .new_confl1(STQ_confls[1]),
  .pfree_data0(PSTQ_data[0]),.pfree_en0(PSTQ_en[0]),
  .pfree_data1(PSTQ_data[1]),.pfree_en1(PSTQ_en[1]),
  .pfree_data2(PSTQ_data[2]),.pfree_en2(PSTQ_en[2]),
  .pfree_data_shr(PSTQ_data_shr),
  .wret_II0(mOpY4_II),.wret_en0(mOpY4_hit),
  .wret_II1(mOpY5_II),.wret_en1(mOpY5_hit),

  .ret_has_ldst(retM_data_shr_reg[`lsqshare_II]==mem_II_upper),
  .ret_data_shr(retM_data_shr_reg),
  .ret_mask(xbreak),
  .ret_retire(doRetire_d),

  .new_conflictx(new_conflictx),
  .new_conflicty(new_conflicty),
  .m_mask(m_mask),
  .n_mask(n_mask),
  .new_conflictA(new_conflictA),.p1_new_conflictA_b(p1_new_conflictA_b),.new_conflictA_has(new_conflictA_has),
  .new_conflictB(new_conflictB),.p1_new_conflictB_b(p1_new_conflictB_b),.new_conflictB_has(new_conflictB_has),
  .lstep1_owndataA(lstep1_owndataA),
  .lstep1_owndataB(lstep1_owndataB),
  .new_conflict2_acc(new_conflict2_acc),
  .p1_nChNextA0(p1_nChNextA0),.p1_nChNextA1(p1_nChNextA1),.p1_nChNextA2(p1_nChNextA2),
  .p1_ins_addr0(p1_ins_addr0),.p1_pos_dataA0(p1_pos_dataA0),.p1_pos_en0(p1_pos_en0),
  .p1_ins_addr1(p1_ins_addr1),.p1_pos_dataA1(p1_pos_dataA1),.p1_pos_en1(p1_pos_en1),
  .p1_ins_addr2(p1_ins_addr2),.p1_pos_dataA2(p1_pos_dataA2),.p1_pos_en2(p1_pos_en2),
  .new_en_reg2(new_en_reg2),.new_enP_reg2(new_enP_reg2),.p1_peek_aStall(p1_peek_aStall),
  .confl_first(confl_first),.confl_last(confl_last),.confl_cnt(confl_cnt),.chmo_bolotnoe2(p1_inhibit)

);
  

  storq_p1 p1_mod(
  .clk(clk),
  .rst(rst),
  .lStall(lStall_STQ),
  .lDoStall(lDoStall_STQ),
  .except(except),
  .excpt_thread(1'b0),
  .new_conflictx(new_conflictx),
  .new_conflicty(new_conflicty),
  .new_conflictA(new_conflictA),.new_conflictA_b(p1_new_conflictA_b),.new_conflictA_has(new_conflictA_has),
  .new_conflictB(new_conflictB),.new_conflictB_b(p1_new_conflictB_b),.new_conflictB_has(new_conflictB_has),
  .m_mask(m_mask),
  .n_mask(n_mask),
  .lstep1_owndataA(lstep1_owndataA),
  .lstep1_owndataB(lstep1_owndataB),
  .new_conflict1_acc(new_conflict2_acc),
  .nChNextA0(p1_nChNextA0),.nChNextA1(p1_nChNextA1),.nChNextA2(p1_nChNextA2),
  .ins_addr0(p1_ins_addr0),.pos_dataA0(p1_pos_dataA0),.pos_en0(p1_pos_en0),
  .ins_addr1(p1_ins_addr1),.pos_dataA1(p1_pos_dataA1),.pos_en1(p1_pos_en1),
  .ins_addr2(p1_ins_addr2),.pos_dataA2(p1_pos_dataA2),.pos_en2(p1_pos_en2),
  .new_en_reg2(new_en_reg2),.new_enP_reg2(new_enP_reg2),.peek_aStall(p1_peek_aStall),
  .confl_first(confl_first),.confl_last(confl_last),.confl_cnt(confl_cnt),.chmo_bolotnoe2(p1_inhibit),
  .std_addrA0(stqd_addrA0),.std_addrA1(stqd_addrA1),  
  .std_addrB0(stqd_addrB0),.std_addrB1(stqd_addrB1),  
  
  .std_byBankA0(stqd_xdataA0[`lsfxdata_byBank]),
  .std_MexactA0(stqd_xdataA0[`lsfxdata_Mexact]),
  .std_MshiftA0(stqd_xdataA0[`lsfxdata_Mshift]),
  .std_banksA0(stqd_xdataA0[`lsfxdata_banks]),
  .std_hasA0(stqd_xdataA0[`lsfxdata_has]),
  .std_byBankA1(stqd_xdataA1[`lsfxdata_byBank]),
  .std_MexactA1(stqd_xdataA1[`lsfxdata_Mexact]),
  .std_MshiftA1(stqd_xdataA1[`lsfxdata_Mshift]),
  .std_banksA1(stqd_xdataA1[`lsfxdata_banks]),
  .std_hasA1(stqd_xdataA1[`lsfxdata_has]),

  .std_byBankB0(stqd_xdataB0[`lsfxdata_byBank]),
  .std_MexactB0(stqd_xdataB0[`lsfxdata_Mexact]),
  .std_MshiftB0(stqd_xdataB0[`lsfxdata_Mshift]),
  .std_banksB0(stqd_xdataB0[`lsfxdata_banks]),
  .std_hasB0(stqd_xdataB0[`lsfxdata_has]),
  .std_byBankB1(stqd_xdataB1[`lsfxdata_byBank]),
  .std_MexactB1(stqd_xdataB1[`lsfxdata_Mexact]),
  .std_MshiftB1(stqd_xdataB1[`lsfxdata_Mshift]),
  .std_banksB1(stqd_xdataB1[`lsfxdata_banks]),
  .std_hasB1(stqd_xdataB1[`lsfxdata_has]),


  .std_mOpA(stqd_mOpA),.std_mOpB(stqd_mOpB)//,
  ); 
  wire aStall_LSQ;
  wire lStall;
  wire stall_LDQ;
  wire [5:0] LDQ_ldconfl;
  wire [5:0] LDQ_insconfl;
  wire [`lsqxcept_width-2:0] ret_xdata[5:0];
  wire [5:0] ret_xenab;
  wire [5:0] ret_xldconfl;
  wire [5:0] ret_xsmpconfl;
  wire retB_en;
  wire retB_clkEn;
  wire mem_II_stall;
  wire [`lsaddr_width-1:0] wreq_data[1:0];
  reg [`lsaddr_width-1:0] wreq_data_reg[1:0];
  wire [1:0] wreq_en;
  reg [1:0] wreq_en_reg;
  wire [3:0] wreq_bben[1:0];
  wire [3:0] wreq_endben[1:0];
  wire [4:0] wreq_dcEnd[1:0];
  wire PSTQ_has_store;
  wire [1:0] wreq_has;
  wire stall_LSQ;
  wire [5:0] LSQ_upper;
  wire lStall_lsfw;
  wire wreq_stall;

  assign PSTQ_has_store=PSTQ_data_shr!=6'h3f;

  ldq ldq_mod(
  .clk(clk),
  .rst(rst),
  .except(except),.except_thread(1'b0),
  .aStall(aStall_LSQ|lStall),
  .stall(stall_LDQ),.doStall(doStall_LDQ),
  .new0_data(p0_adata_x),.new0_rsEn(p0_rsEn),
   .new0_isFlag(p0_adata_x[`lsaddr_flag]),.new0_thread(1'b0),
  .new1_data(p1_adata_x),.new1_rsEn(p1_rsEn),
    .new1_isFlag(p1_adata_x[`lsaddr_flag]),.new1_thread(1'b0),
  .new2_data(p2_adata_x),.new2_rsEn(p2_rsEn),
    .new2_isFlag(p2_adata_x[`lsaddr_flag]),.new2_thread(1'b0),
  .new3_data(p3_adata_x),.new3_rsEn(p3_rsEn),
    .new3_isFlag(p3_adata_x[`lsaddr_flag]),.new3_thread(1'b0),
  .newI_mask(ldq_new_mask_reg),.newI_en(bundle_in_reg2),.newI_thr(1'b0),
  .chk0_dataA(LSQ_dataA0),.chk0_enA(LSQ_enA[0]),
  .chk1_dataA(LSQ_dataA1),.chk1_enA(LSQ_enA[1]),
  .chk2_dataA(LSQ_dataA2),.chk2_enA(LSQ_enA[2]),
  .chk3_dataA(LSQ_dataA3),.chk3_enA(LSQ_enA[3]),
  .chk4_dataA(LSQ_dataA4),.chk4_enA(LSQ_enA[4]),
  .chk5_dataA(LSQ_dataA5),.chk5_enA(LSQ_enA[5]),
  .chk_data_shr(LSQ_shr_dataA),
  .chk_en(LSQ_rdy_A),
  .chk_enP(LSQ_rdy_AP),
  .confl(LDQ_ldconfl),
  .confl_smp(LDQ_insconfl),
  .expun_addr(MSI_exp_addr),
  .expun_en(MSI_en)
  );


  lsq_req lsqReq_mod(
  .clk(clk),
  .rst(rst),

  .stall(stall_LSQ),
  .doStall(doStall_LSQ),
  .doRsPause(WDoRsPause),
  .except(except),
  .except_thread(1'b0),
  .aStall(aStall_LSQ&~lStall),

  .readA_clkEn(LSQ_rdy_A&~aStall_LSQ),
  .readA_rdy(LSQ_rdy_A),
  .readA_rdyP(LSQ_rdy_AP),
  .read0A_data(LSQ_dataA0),.read0A_enOut(LSQ_enA[0]),
  .read1A_data(LSQ_dataA1),.read1A_enOut(LSQ_enA[1]),
  .read2A_data(LSQ_dataA2),.read2A_enOut(LSQ_enA[2]),
  .read3A_data(LSQ_dataA3),.read3A_enOut(LSQ_enA[3]),
  .read4A_data(LSQ_dataA4),.read4A_enOut(LSQ_enA[4]),
  .read5A_data(LSQ_dataA5),.read5A_enOut(LSQ_enA[5]),
  
  .readA_conflIn_l(LDQ_ldconfl),
  .readA_conflInMSI(LDQ_insconfl),
  //.readA_conflIn_s(STQ_confl), //purpose??

  .readA_thr(),

  .read_data_shr(LSQ_shr_dataA),
  .write_thread_shr(1'b0),
  .write_data_shr(LSQ_shr_data),
  .write_wen_shr((lsi0_reg!=3'd6 || lsi1_reg!=3'd6 || lsi2_reg!=3'd6) && bundle_in_reg2),
  .write_addr_shr(LSQ_upper),
//verilator lint_off WIDTH
  .read0B_xdata(ret_xdata[0]),.read0B_enOut(ret_xenab[0]),
  .read1B_xdata(ret_xdata[1]),.read1B_enOut(ret_xenab[1]),
  .read2B_xdata(ret_xdata[2]),.read2B_enOut(ret_xenab[2]),
  .read3B_xdata(ret_xdata[3]),.read3B_enOut(ret_xenab[3]),
  .read4B_xdata(ret_xdata[4]),.read4B_enOut(ret_xenab[4]),
  .read5B_xdata(ret_xdata[5]),.read5B_enOut(ret_xenab[5]),
//verilator lint_on WIDTH
  .read_data_shrB(retM_data_shr),
  .readB_ldconfl(ret_xldconfl),
  .readB_smpconfl(ret_xsmpconfl),
  .readB_rdy_en(retB_en),.readB_clkEn(retB_clkEn),
  //.write_thread,
  //loads 0-3, xdata +2 clocks
  .write0_addr(p0_LSQ),.write0_data(p0_adata_x),
    .write0_xdata({p0_adata_x[`lsaddr_II],p0_adata_x[`lsaddr_except],2'b0,p0_adata_x[`lsaddr_etype]}),
    .write0_thr(1'b0),.write0_wen(p0_en && ~p0_adata_x[`lsaddr_flag] & ~p0_lsfwd),
  .write1_addr(p1_LSQ),.write1_data(p1_adata_x),
    .write1_xdata({p1_adata_x[`lsaddr_II],p1_adata_x[`lsaddr_except],2'b0,p1_adata_x[`lsaddr_etype]}),
    .write1_thr(1'b0),.write1_wen(p1_en && ~p1_adata_x[`lsaddr_flag] & ~p1_lsfwd),
  .write2_addr(p2_LSQ),.write2_data(p2_adata_x),
    .write2_xdata({p2_adata_x[`lsaddr_II],p2_adata_x[`lsaddr_except],2'b0,p2_adata_x[`lsaddr_etype]}),
    .write2_thr(1'b0),.write2_wen(p2_en && ~p2_adata_x[`lsaddr_flag] & ~p2_lsfwd),
  .write3_addr(p3_LSQ),.write3_data(p3_adata_x),
    .write3_xdata({p3_adata_x[`lsaddr_II],p3_adata_x[`lsaddr_except],2'b0,p3_adata_x[`lsaddr_etype]}),
    .write3_thr(1'b0),.write3_wen(p3_en && ~p3_adata_x[`lsaddr_flag] & ~p3_lsfwd),
  //stores 0-1
  .write4_addr(p4_LSQ),.write4_data(p4_adata),.write4_xdata({p4_adata[`lsaddr_II],p4_adata[`lsaddr_except],2'b0,p4_adata[`lsaddr_etype]}),
  .write4_thr(1'b0),.write4_wen(p4_en),
  .write5_addr(p5_LSQ),.write5_data(p5_adata),.write5_xdata({p5_adata[`lsaddr_II],p5_adata[`lsaddr_except],2'b0,p5_adata[`lsaddr_etype]}),
  .write5_thr(1'b0),.write5_wen(p5_en),
  .FU0Hit(FU0Hit),.FU1Hit(FU1Hit),.FU2Hit(FU2Hit),.FU3Hit(FU3Hit),
  .smpc0(p0_smpc),.smpc1(p1_smpc),.smpc2(p2_smpc),.smpc3(p3_smpc),
  .rsEn0(p0_rsEn&&~p0_lsfwd),.rsEn1(p1_rsEn&&~p1_lsfwd),.rsEn2(p2_rsEn&&~p2_lsfwd),.rsEn3(p3_rsEn&&~p3_lsfwd)
  );  
  
  storq_reqSpit reqSpit_mod(
  .clk(clk),
  .rst(rst),
  .bDoStall(mem_II_stall),
  .read_data0(wreq_data[0]),
  .read_data1(wreq_data[1]),
  .write_data0(PSTQ_data[0]),.write_data1(PSTQ_data[1]),.write_data2(PSTQ_data[2]),
  .write_data_shr(PSTQ_data_shr),
  .write_data_shrB(retM_data_shr_reg),
  .write_wen(retM_data_shr_reg[`lsqshare_II]==mem_II_upper && PSTQ_has_store && ~except),
  .has1(wreq_has[0]),.has2(wreq_has[1]),
  .en0(wreq_en[0]),.en1(wreq_en[1])
  );

  wrtdata_combine wcomb0_mod(.data(dc_wdataP_reg[0]),.en(1'b1),
    .odata(st0_data),.low(wreq_data_reg[0][`lsaddr_low]),.sz(wreq_data_reg[0][`lsaddr_sz]));
  wrtdata_combine wcomb1_mod(.data(dc_wdataP_reg[1]),.en(1'b1),
      .odata(st1_data),.low(wreq_data_reg[1][`lsaddr_low]),.sz(wreq_data_reg[1][`lsaddr_sz]));

  
  wire [127+8:0]           wb1_dataA;
  wire [127+8:0]           wb1_dataB;
  wire [`lsfxdata_width-1:0] wb1_xdataA;
  wire [`lsfxdata_width-1:0] wb1_xdataB;
  wire [127+8:0]           wb0_dataA;
  wire [127+8:0]           wb0_dataB;
  wire [`lsfxdata_width-1:0] wb0_xdataA;
  wire [`lsfxdata_width-1:0] wb0_xdataB;
  wire [127+8:0]           sso_data;
  wire [3:0]               sso_bnkread;

  lsf_array lsfwd_mod(
  .clk(clk),
  .rst(rst),
  .except(except),
  .excpt_thread(1'b0),
  .stall(lStall_lsfw),
  .doStall(lDoStall_lsfw),
  .newAData0(stqd_mOpA),.newEn0(stqd_xdataA0[`lsfxdata_has]),
  .newDataXA0(stqd_xdataA0),.newDataXB0(stqd_xdataA1),
  .newReqWQA0(stqd_addrA0),
  .newReqWQB0(stqd_addrA1),
  .newDataA0(stqd_dataA0),.newRdyA0(stqd_rdyA0),
  .newDataB0(stqd_dataA1),.newRdyB0(stqd_rdyA1),
  .newAData1(stqd_mOpB),.newEn1(stqd_xdataB0[`lsfxdata_has]),
  .newDataXA1(stqd_xdataB0),.newDataXB1(stqd_xdataB1),
  .newReqWQA1(stqd_addrB0),
  .newReqWQB1(stqd_addrB1),
  .newDataA1(stqd_dataB0),.newRdyA1(stqd_rdyB0),
  .newDataB1(stqd_dataB1),.newRdyB1(stqd_rdyB1),
  .out0PortEn(~pause_agu),
  .out1PortEn(~pause_agu),
  .out0Adata(wb0_adata),.out0XdataA(wb0_xdataA),.out0XdataB(wb0_xdataB),
  .out0DataA(wb0_dataA),.out0DataB(wb0_dataB),
  .out1Adata(wb1_adata),.out1XdataA(wb1_xdataA),.out1XdataB(wb1_xdataB),
  .out1DataA(wb1_dataA),.out1DataB(wb1_dataB),
  .InpWQA(lsw_wq0),.InpEnA(lsw_rs_en0[0]),.InpDataA(lsw_wdata0),
  .InpWQB(lsw_wq1),.InpEnB(lsw_rs_en1[0]),.InpDataB(lsw_wdata1)
  );

  assign wb0_en=wb0_xdataA[`lsfxdata_has];
  assign wb1_en=wb1_xdataA[`lsfxdata_has];

  lsfw_combine hlwcombB_mod(
  .xdataA(wb1_xdataA),.xdataB(wb1_xdataB),
  .dataA(wb1_dataA),.dataB(wb1_dataB),
  .data_req(wb1_adata),
  .outData(wb1_data),
  .outBnRead(wb1_brdbanks)
  );

  lsfw_combine hlwcombA_mod(
  .xdataA(wb0_xdataA),.xdataB(wb0_xdataB),
  .dataA(wb0_dataA),.dataB(wb0_dataB),
  .data_req(wb0_adata),
  .outData(wb0_data),
  .outBnRead(wb0_brdbanks)
  );


  lsw_data sdata_mod(
  .clk(clk),
  .rst(rst),

  .read_addr0(stqd_addrA0),.read_data0({stqd_rdyA0,stqd_dataA0}),
  .read_addr1(stqd_addrA1),.read_data1({stqd_rdyA1,stqd_dataA1}),
  .read_addr2(stqd_addrB0),.read_data2({stqd_rdyB0,stqd_dataB0}),
  .read_addr3(stqd_addrB1),.read_data3({stqd_rdyB1,stqd_dataB1}),
  .read_addr4(wreq_data[0][`lsaddr_WQ]),.read_data4({sdata_rdy[0],dc_wdataP[0]}),
  .read_addr5(wreq_data[1][`lsaddr_WQ]),.read_data5({sdata_rdy[1],dc_wdataP[1]}),


  .write0_addr(lsw_wq0),.write0_data({1'b1,lsw_wdata0}),.write0_wen(lsw_rs_en0[0]),
  .write1_addr(lsw_wq1),.write1_data({1'b1,lsw_wdata1}),.write1_wen(lsw_rs_en1[0]),
  .new0_addr(WQS0_reg),.new0_en(LSQ_shr_data[`lsqshare_wrt0]!=3'd7 && 
      bundle_in_reg2 && ~stall),.new0_odd(WQS0_reg[0]),
  .new1_addr(WQS1_reg),.new1_en(LSQ_shr_data[`lsqshare_wrt1]!=3'd7 &&
      bundle_in_reg2 && ~stall),.new1_odd(WQS1_reg[0]),
  .new2_addr(WQS2_reg),.new2_en(LSQ_shr_data[`lsqshare_wrt2]!=3'd7 &&
      bundle_in_reg2 && ~stall),.new2_odd(WQS2_reg[0])
  );
  
  lsq_decide_ret help_to_retire_mod(
  .clk(clk),
  .rst(rst),
  .bStall(mem_II_stall||mem_II_stall2),
  .dataB_ret_mask(ret_xenab),
  .dataB_ld_confl(ret_xldconfl),
  .dataB_wait_confl(ret_xsmpconfl),
  .dataB_excpt({ret_xdata[5][`lsqxcept_xcept],ret_xdata[4][`lsqxcept_xcept],
    ret_xdata[3][`lsqxcept_xcept],ret_xdata[2][`lsqxcept_xcept],
    ret_xdata[1][`lsqxcept_xcept],ret_xdata[0][`lsqxcept_xcept]}),
  .dataB_exbits({ret_xdata[5][3:0],ret_xdata[4][3:0],ret_xdata[3][3:0],
    ret_xdata[2][3:0],ret_xdata[1][3:0],ret_xdata[0][3:0]}),
  .dataB_thread(1'b0), 
  .dataB_II(retM_data_shr[`lsqshare_II]),
  .dataB_data_shr(retM_data_shr),
  .dataB_II0(ret_xdata[0][-6+`lsqxcept_II]),.dataB_II1(ret_xdata[1][-6+`lsqxcept_II]),
  .dataB_II2(ret_xdata[2][-6+`lsqxcept_II]),.dataB_II3(ret_xdata[3][-6+`lsqxcept_II]),
  .dataB_II4(ret_xdata[4][-6+`lsqxcept_II]),.dataB_II5(ret_xdata[5][-6+`lsqxcept_II]),
  .dataB_ready(retB_en),
  .dataB_enOut(retB_clkEn),
  .cntrl_II(mem_II_upper_in),
  .out_II(mem_II_upper),
  .retire_enOut(mem_II_bits_ret),  .retire_fine(mem_II_bits_fine), .retire_ldconfl(mem_II_bits_ldconfl), .retire_except(mem_II_bits_except),
  .retire_exbitsx6(mem_II_exbitsx6),.retire_waitconfl(mem_II_bits_waitconfl),
  .dataB_shr_out(retM_data_shr_reg),
  .doRetire(doRetire_d),
  .except(except),
  .except_thread(1'b0)
  );



  get_ben_een getBen0_mod(
  .low(wreq_data_reg[0][`lsaddr_low]),
  .sz(wreq_data_reg[0][`lsaddr_sz]),
  .bgn0(wreq_data_reg[0][`lsaddr_bank0]),
  .end0(wreq_dcEnd[0]),
  .bgnBen(wreq_bben[0]),
  .endBen(wreq_endben[0])
  );
      
  get_ben_een getBen1_mod(
  .low(wreq_data_reg[1][`lsaddr_low]),
  .sz(wreq_data_reg[1][`lsaddr_sz]),
  .bgn0(wreq_data_reg[1][`lsaddr_bank0]),
  .end0(wreq_dcEnd[1]),
  .bgnBen(wreq_bben[1]),
  .endBen(wreq_endben[1])
  );
  
  assign stall_LSQ=|{doStall_rs[3:0],doStall_alloc,doStall_cntrl,doStall_LDQ,doStall_STQ | doStall_WQ};
  assign stall_cntrl=|{doStall_rs[3:0],doStall_alloc,doStall_LSQ,doStall_LDQ,doStall_STQ | doStall_WQ};
  assign stall_LDQ=|{doStall_rs[3:0],doStall_alloc,doStall_cntrl,doStall_LSQ,doStall_STQ | doStall_WQ};
  assign stall_STQ=|{doStall_rs[3:0],doStall_alloc,doStall_cntrl,doStall_LSQ,doStall_LDQ | doStall_WQ};
  assign stall_WQ=|{doStall_rs[3:0],doStall_alloc,doStall_cntrl,doStall_LSQ,doStall_LDQ,doStall_STQ};
  assign stall=|{doStall_rs[3:0],doStall_alloc,doStall_cntrl,doStall_LSQ,doStall_LDQ,doStall_STQ | doStall_WQ};

  assign aStall_STQ=1'b0;
  assign aStall_LSQ=aDoStall_STQ;
  assign lStall_STQ=lDoStall_lsfw;
  assign lStall_lsfw=1'b0;//lDoStall_STQ;
  assign lStall=lDoStall_lsfw|lDoStall_STQ;

  assign wreq_en[0]=~wreq_stall & wreq_has[0] & sdata_rdy[0];
  assign wreq_en[1]=~wreq_stall && wreq_has[1] && sdata_rdy[0] && sdata_rdy[1] && 
    (wreq_data[0][`lsaddr_banks]&wreq_data[1][`lsaddr_banks])==0;


  assign wreq_stall=bus_holds_agu_reg2|miss_holds_agu_reg2|miss_pause_agu_reg2|insert_isData_reg2|st_stall_reg;
      
  assign st0_adata=wreq_data_reg[0];
  assign st0_en=wreq_en_reg[0];
  assign st0_bank1=wreq_dcEnd[0];
  assign st0_bgn_ben=wreq_bben[0];
  assign st0_end_ben=wreq_endben[0];

  assign st1_adata=wreq_data_reg[1];
  assign st1_en=wreq_en_reg[1];
  assign st1_bank1=wreq_dcEnd[1];
  assign st1_bgn_ben=wreq_bben[1];
  assign st1_end_ben=wreq_endben[1];

  always @(posedge clk) begin
    st_stall_reg<=st_stall;
    wreq_en_reg<=wreq_en;
    wreq_data_reg[0]<=wreq_data[0];
    wreq_data_reg[1]<=wreq_data[1];
  end

endmodule
