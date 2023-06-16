module fun_agu(
  clk,
  rst,
  stall,
  do_stall,
  do_collapse,
  ls0_index, ls0_op, ls0_en, ls0_basereg, ls0_indexreg, ls0_offset, ls0_rT, ls0_rrel_op, ls0_st_en_out,ls0_lsaddr,
  ls1_index, ls1_op, ls1_en, ls1_basereg, ls1_indexreg, ls1_offset, ls1_rT, ls1_rrel_op, ls1_st_en_out,ls1_lsaddr,
  ls2_index, ls2_op, ls2_en, ls2_basereg, ls2_indexreg, ls2_offset, ls2_rT, ls2_rrel_op, ls2_st_en_out,ls2_lsaddr,
  alu0_index, alu0_level, alu0_wen, alu0_rT, alu0_data,
  alu1_index, alu1_level, alu1_wen, alu1_rT, alu1_data,
  alu2_index, alu2_level, alu2_wen, alu2_rT, alu2_data,
  ld0_data_out,ld0_en_out,
  ld1_data_out,ld1_en_out,
  ld2_data_out,ld2_en_out
  );
  input clk;
  input rst;
  input stall;
  output do_stall;
  output do_collapse;
  input [2:0] ls0_index;
  input [5:0] ls0_op; 
  input       ls0_en; 
  input [5:0] ls0_basereg;
  input [5:0] ls0_indexreg; 
  input [64:0]ls0_offset; 
  input [5:0] ls0_rT; 
  input       ls0_rrel_op;
  output      ls0_st_en_out;
  output [`lsaddr_width-1:0] ls0_lsaddr;
  input [2:0] ls1_index;
  input [5:0] ls1_op; 
  input       ls1_en; 
  input [5:0] ls1_basereg;
  input [5:0] ls1_indexreg; 
  input [64:0]ls1_offset; 
  input [5:0] ls1_rT; 
  input       ls1_rrel_op;
  output      ls1_st_en_out;
  output [`lsaddr_width-1:0] ls1_lsaddr;
  input [2:0] ls2_index;
  input [5:0] ls2_op; 
  input       ls2_en; 
  input [5:0] ls2_basereg;
  input [5:0] ls2_indexreg; 
  input [64:0]ls2_offset; 
  input [5:0] ls2_rT; 
  input       ls2_rrel_op;
  output      ls2_st_en_out;
  output [`lsaddr_width-1:0] ls2_lsaddr;

  input [2:0] alu0_index;
  input       alu0_level;
  input       alu0_wen;
  input [5:0] alu0_rT;
  input [64:0]alu0_data,
  input [2:0] alu1_index;
  input       alu1_level;
  input       alu1_wen;
  input [5:0] alu1_rT;
  input [64:0]alu1_data,
  input [2:0] alu2_index;
  input       alu2_level;
  input       alu2_wen;
  input [5:0] alu2_rT;
  input [64:0]alu2_data,

  input [64:0] ld0_data_out;
  input ld0_en_out;
  input [64:0] ld1_data_out;
  input ld1_en_out;
  input [64:0] ld2_data_out;
  input ld2_en_out;

  agu agu0(
  clk,
  rst,
  except,
  attr[0],
  rsStall[0],
  read_clkEn[0],
  doStall[0],
  bus_hold[0],
  op[0],
  shiftSize[0],
  regno[0],
  LSQ_no[0],
  II_no[0],
  WQ_no[0],
  1'b0,//thread
  1'b0,//lsflag
  cmplxAddr[0],
  cin_secq[0],
  ~ndiff[0],
  other0_banks,
  other1_banks,
  32'b0,
  other_flip,
  conflict[0],
  tlbMiss[0],
  pageFault[0],
  faultCode[0],
  faultNo[0],
  mOp_register[0],
  mOp_type[0],
  mOp_LSQ[0],
  mOp_II[0],
  mOp_WQ[0],
  mOp_attr[0],
  mOp_addrEven[0],
  mOp_addrOdd[0],
  mOp_addrMain[0],
  mOp_sz[0],
  mOp_st[0],
  mOp_en[0],
  mOp_secq[0],
  mOp_invtlb[0],
  mOp_rsEn[0],
  mOp_thread[0],
  mOp_lsflag[0],
  mOp_banks[0],
  mOp_rsBanks[0],
  mOp_bank0[0],
  mOp_odd[0],
  mOp_addr_low[0],
  mOp_split[0],
  mOp_noBanks[0],
  csrss_no,
  csrss_en,
  csrss_thr,
  csrss_data,
  tlb_clkEn,
  cout_secq[0],
  addrTlb[0],
  sproc[0],
  tlb_data0[0],
  tlb_data1[0],
  tlb_hit[0] 
  );

  agu agu1(
  clk,
  rst,
  except,
  attr[1],
  rsStall[1],
  read_clkEn[1],
  doStall[1],
  bus_hold[0],
  op[1],
  shiftSize[1],
  regno[1],
  LSQ_no[1],
  II_no[1],
  WQ_no[1],
  1'b0,//thread
  1'b0,//lsflag
  cmplxAddr[1],
  cin_secq[1],
  ~ndiff[1],
  other1_banks[1],
  other0_banks[1],
  32'b0,
  other_flip,
  conflict[1],
  tlbMiss[1],
  pageFault[1],
  faultCode[1],
  faultNo[1],
  mOp_register[1],
  mOp_type[1],
  mOp_LSQ[1],
  mOp_II[1],
  mOp_WQ[1],
  mOp_attr[1],
  mOp_addrEven[1],
  mOp_addrOdd[1],
  mOp_addrMain[1],
  mOp_sz[1],
  mOp_st[1],
  mOp_en[1],
  mOp_secq[1],
  mOp_invtlb[1],
  mOp_rsEn[1],
  mOp_thread[1],
  mOp_lsflag[1],
  mOp_banks[1],
  mOp_rsBanks[1],
  mOp_bank0[1],
  mOp_odd[1],
  mOp_addr_low[1],
  mOp_split[1],
  mOp_noBanks[1],
  csrss_no,
  csrss_en,
  csrss_thr,
  csrss_data,
  ,
  cout_secq[1],
  addrTlb[1],
  sproc[1],
  tlb_data0[1],
  tlb_data1[1],
  tlb_hit[1] 
  );

  agu agu2(
  clk,
  rst,
  except,
  attr[2],
  rsStall[2],
  read_clkEn[2],
  doStall[2],
  bus_hold[0],
  op[2],
  shiftSize[2],
  regno[2],
  LSQ_no[2],
  II_no[2],
  WQ_no[2],
  1'b0,//thread
  1'b0,//lsflag
  cmplxAddr[2],
  cin_secq[2],
  ~ndiff[2],
  other1_banks[2],
  other0_banks[2],
  32'b0,
  other_flip,
  conflict[2],
  tlbMiss[2],
  pageFault[2],
  faultCode[2],
  faultNo[2],
  mOp_register[2],
  mOp_type[2],
  mOp_LSQ[2],
  mOp_II[2],
  mOp_WQ[2],
  mOp_attr[2],
  mOp_addrEven[2],
  mOp_addrOdd[2],
  mOp_addrMain[2],
  mOp_sz[2],
  mOp_st[2],
  mOp_en[2],
  mOp_secq[2],
  mOp_invtlb[2],
  mOp_rsEn[2],
  mOp_thread[2],
  mOp_lsflag[2],
  mOp_banks[2],
  mOp_rsBanks[2],
  mOp_bank0[2],
  mOp_odd[2],
  mOp_addr_low[2],
  mOp_split[2],
  mOp_noBanks[2],
  csrss_no,
  csrss_en,
  csrss_thr,
  csrss_data,
  ,
  cout_secq[2],
  addrTlb[2],
  sproc[2],
  tlb_data0[2],
  tlb_data1[2],
  tlb_hit[2] 
  );

  add_agu addr0(
  base[0],offset[0]index[0],
  cmplxAddr[0],
  cin_secq[0],
  ndiff[0],
  en[0],
  shift[0],
  sh2[0]
  );

  add_agu addr1(
  base[1],offset[1],index[1],
  cmplxAddr[1],
  cin_secq[1],
  ndiff[1],
  en[1],
  shift[1],
  sh2[1]
  );
  
  add_agu addr2(
  base[2],offset[2],index[2],
  cmplxAddr[2],
  cin_secq[2],
  ndiff[2],
  en[2],
  shift[2],
  sh2[2]
  );
  

endmodule
