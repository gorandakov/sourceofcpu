module fun_lsq(
  clk,
  rst,
  stall,
  do_stall,
  except,
  p0_en,p0_LSQ,p0_lsaddr,
  p1_en,p1_LSQ,p1_lsaddr,
  p2_en,p2_LSQ,p2_lsaddr,
  has_dep,
  which_dep
  );

  lsq_req lsqreq_mod(
  clk,
  rst,
  
  stall,
  doStall,
  doRsPause,

  except,
  except_thread,

  aStall,
  readA_clkEn,
  readA_rdy,
  readA_rdyP,
  readA_thr,
  read0A_data,read0A_enOut,
  read1A_data,read1A_enOut,
  read2A_data,read2A_enOut,
  read3A_data,read3A_enOut,
  read4A_data,read4A_enOut,
  read5A_data,read5A_enOut,

  read0A_DATA,read0A_dEn,
  read1A_DATA,read1A_dEn,
  read2A_DATA,read2A_dEn,
  read3A_DATA,read3A_dEn,
  read4A_DATA,read4A_dEn,
  read5A_DATA,read5A_dEn,
  
  readA_conflIn_l,
  readA_conflInMSI,

  read_data_shr,
  write_thread_shr,
  write_data_shr,
  write_wen_shr,
  write_addr_shr,

  read0B_xdata,read0B_enOut,
  read1B_xdata,read1B_enOut,
  read2B_xdata,read2B_enOut,
  read3B_xdata,read3B_enOut,
  read4B_xdata,read4B_enOut,
  read5B_xdata,read5B_enOut,
  read_data_shrB,
  readB_ldconfl,readB_smpconfl,
  readB_rdy_en,readB_clkEn,

  //loads 0-3, xdata +2 clocks
  write0_addr,write0_data,write0_xdata,write0_thr,write0_wen,
  write1_addr,write1_data,write1_xdata,write1_thr,write1_wen,
  write2_addr,write2_data,write2_xdata,write2_thr,write2_wen,
  write3_addr,write3_data,write3_xdata,write3_thr,write3_wen,
  //stores 0-1
  write4_addr,write4_data,write4_xdata,write4_thr,write4_wen,
  write5_addr,write5_data,write5_xdata,write5_thr,write5_wen,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  FU0Data,FU1Data,FU2Data,FU3Data,
  smpc0,smpc1,smpc2,smpc3,
  rsEn0,rsEn1,rsEn2,rsEn3
  );

  ldq ldq_mod(
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

endmodule
