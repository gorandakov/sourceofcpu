
`include "../struct.sv"

module MSI_bus_data_ram(
  clk,rst,
  read_addr,read_data,read_clkEn,
  write_addr,write_data,write_ben,write_wen);
  localparam data_width=64;
  localparam addr_width=5;
  localparam addr_count=32;
  input clk;
  input rst;
  input [4:0] read_addr;
  output [data_width-1:0] read_data;
  input read_clkEn;
  input [4:0] write_addr;
  input [data_width-1:0] write_data;
  input [data_width-1:0] write_ben;
  input write_wen;

  reg [4:0] read_addr_reg;
  reg [data_width-1:0] ram[31:0];

  assign read_data=ram[read_addr_reg];

  integer b;
  always @(posedge clk) begin
      if (read_clkEn) read_addr_reg<=read_addr;
      if (write_wen) for(b=0;b<data_width/2;b=b+1)
	  if (write_ben[b]) ram[write_addr][b]<=write_data[b];
  end
endmodule

module MSI_bus_data_ram_box(
  clk,rst,
  read_addr,read_data,read_bank,read_clkEn,
  write_addr,write_data,write_bank,write_wen);
  localparam data_width=32;
  localparam addr_width=5;
  localparam addr_count=32;
  input clk;
  input rst;
  input [4:0] read_addr;
  output reg [data_width-1:0] read_data;
  input read_bank;
  input read_clkEn;
  input [4:0] write_addr;
  input [data_width-1:0] write_data;
  input write_bank;
  input write_wen;
  
  wire [data_width*2-1:0] write_ben;
  reg [data_width*2-1:0] read_data0;

  assign write_ben={data_width{{~write_bank,write_bank}}};
  integer k;
  always @(read_data0) begin
      for(k=0;k<data_width;k=k+1) read_data[k]=read_bank_reg ? read_data0[k*2+1] : read_data0[k*2];
  end
endmodule

