
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
  input port_data;

  reg [31:0] edram[324:0];

  reg [324:0] data1;
  reg [324:0] data2;
  wire [324:0] data3;

  block_ecc_decode corr0_mod(
  data1,
  324'b0,
  ,
  xore1);
  block_ecc_correct corr_mod( 
  data2,
  xore1_reg,
  ,
  data3);

  always @(posedge clk) begin
      if (port_en | port_ref_plus2) data1<=edram[port_addr_reg];
      else if (port_wen_plus3 | port_ref_plus5) edram[port_write_addr]<=data3;
      if (port_en && (port_read_addr_reg2!=port_read_addr)|~port_ref_plus2_reg2) begin
          data1<=data2;
      end
      if (port_data) data1<=port_write_data;
      xore1_reg<=xore;
      data2<=data1;
      port_ref_plus3<=port_ref_plus2 && (port_read_addr_reg2!=port_read_addr)|~port_en_reg2;
      port_ref_plus3<=port_ref_plus3;
      port_ref_plus5<=port_ref_plus5;
  end
endmodule
