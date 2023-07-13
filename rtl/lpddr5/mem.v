
module lpddr5_channel(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_req,
  read_busID,
  readOut_addr,
  readOut_req,
  readOut_busID,
  readOut_en,
  mem_clk,
  RAS,
  CAS,
  CS0,
  ADDR15,
  DATA18A,DATA18B);
  parameter [14:0] ADDR15_refresh=0x700f;
  parameter [0:0] CS0_refresh=1'b1;
  parameter [14:0] ADDR15_RDREG=0x7e00;//append reg no
  parameter [0:0] CS0_RDREG=1'b1;
  parameter [14:0] ADDR15_WRREG=0x7f00;//append reg no
  parameter [0:0] CS0_WRREG=1'b1;
endmodule  
