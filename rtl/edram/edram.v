
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
  output [342:0] port_read_data; 
  input [4:0] port_write_addr;
  input [342:0] port_write_data;
  input port_wen_plus3;
  input port_data;
`ifned synth_edram
  reg [31:0] edram[341:0];
`else
  reg [31:0] edram[170:0];
`endif
  reg [341:0] data1;
  reg [341:0] data2;
  wire [341:0] data3;
  wire [341:0] data3x;

  block_ecc_decode corr0_mod(
  data1,
  342'b0,
  ,
  xore1);
  block_ecc_correct corr_mod( 
  data2,
  xore1_reg,
  ,
  data3);

  assign data3x=clkREF1 ? data3 : 'z;
  assign data3x=clkREF2 ? data3 : 'z;


  always @(posedge clk) begin
`ifndef synth_edram
      if (port_en | port_ref_plus2) data1<=edram[port_addr_reg];
      else if (port_wen_plus3 | port_ref_plus5) edram[port_write_addr]<=data3;
`else
      if (port_en | port_ref_plus2) begin
           data1[161:0]<=clkREF1 ? edram[port_addr_reg] : 'z;
           data1[323:162]<=clkREF2 ? edram[port_addr_reg] : 'z;
      end else if (port_wen_plus3 | port_ref_plus5) begin
           edram[port_write_addr]<= data3x;
      end
`endif
      if ((port_en && (port_read_addr_reg2!=port_read_addr)|~port_ref_plus2_reg2)
         || (port_ref_plus2 && (port_read_addr_reg2!=port_read_addr)|~port_en_reg2)) begin
          data1<=data2;
      end
      if (port_data) data1<=port_write_data;
      xore1_reg<=xore;
      data2<=data1;
      port_ref_plus3<=port_ref_plus2;
      port_ref_plus3<=port_ref_plus3;
      port_ref_plus5<=port_ref_plus5;
  end
endmodule
