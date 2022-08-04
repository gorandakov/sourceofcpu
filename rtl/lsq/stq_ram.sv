`include "../struct.sv"
module stq_adata_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_wen,
  write_addr,
  write_data);
  localparam WIDTH=`lsaddr_width+1;//adata+en
  
  input clk;
  input rst;
  input read_clkEn;
  input [4:0] read_addr;
  output [WIDTH-1:0] read_data;
  input write_wen;
  input [4:0] write_addr;
  input [WIDTH-1:0] write_data;

  reg [WIDTH-1:0] ram[31:0];
  reg [4:0] read_addr_reg;

  assign read_data=ram[read_addr_reg];

  always @(posedge clk) begin
      if (rst) read_addr_reg<=5'b0;
      else if (read_clkEn) read_addr_reg<=read_addr;
      if (write_wen) ram[write_addr]<=write_data;
  end
endmodule
