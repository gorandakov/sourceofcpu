
module stq_buf_L(
  clk,
  rst,
  stallA,
  doStallA,
  wrt0_en, wrt0_addrEO, wrt0_odd, wrt0_bytes, wrt0_subBNK,
  chk0_en, chk0_addrEO, chk0_odd, chk0_bytes, chk0_subBNK, chk0_match, chk0_partial,
  chk1_en, chk1_addrEO, chk1_odd, chk1_bytes, chk1_subBNK, chk1_match, chk1_partial,
  chk2_en, chk2_addrEO, chk2_odd, chk2_bytes, chk2_subBNK, chk2_match, chk2_partial,
  chk3_en, chk3_addrEO, chk3_odd, chk3_bytes, chk3_subBNK, chk3_match, chk3_partial,
  chk4_en, chk4_addrEO, chk4_odd, chk4_bytes, chk4_subBNK, chk4_match, chk4_partial,
  chk5_en, chk5_addrEO, chk5_odd, chk5_bytes, chk5_subBNK, chk5_match, chk5_partial,
  upd0_en, upd0_addrEO, upd0_odd, upd0_subBNK, upd0_match,
  upd1_en, upd1_addrEO, upd1_odd, upd1_subBNK, upd1_match,
  free_en,free);
  
endmodule

