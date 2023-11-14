
//one "cycle" in four clk cycles; 4 cycles from read to wb; always wb
module edram(
  clk,
  clkREF1,
  clkREF2,
  rst,
  port_en,
  port_ref_plus2,
  port_read_addr,
  port_read_data,
  port_write_addr,
  port_write_data,
  port_wen_plus3,
  port_data_plus3);

  input clk;
  input clkREF1;
  input clkREF2;
  input rst;
  input port_en;
  input port_ref_plus2;
  input [4:0] port_read_addr;
  output [324:0] port_read_data; 
  input [4:0] port_write_addr;
  input [324:0] port_write_data;
  input port_wen_plus3;
  input port_data_plus5;

  reg [31:0] edram[324:0];

  reg [324:0] data1;

  block_ecc_decode(
  data1,
  324'b0,
  ,
  xore1);

  always @(posedge clk) begin
      if (port_en | port_ref_plus2) data1<=edram[port_addr_reg];
      else if (port_wen_plus3 | port_ref_plus5) edram[port_write_addr]<=data3;
      xore1_reg<=xore;
      data2<=data1;
      port_ref_plus3<=port_ref_plus2 && (port_read_addr_reg2!=port_read_addr)|~port_en_reg2;
      port_ref_plus3<=port_ref_plus3;
      port_ref_plus5<=port_ref_plus5;
  end
endmodule
