
module anticipator_ram(
  clk,
  rst,
  read0_addr,read0_data,
  read1_addr,read1_data,
  read2_addr,read2_data,
  read3_addr,read3_data,
  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen);
  input clk;
  input rst;
  input [11:0] read0_addr;
  output [1:0] read0_data;
  input [11:0] read1_addr;
  output [1:0] read1_data;
  input [11:0] read2_addr;
  output [1:0] read2_data;
  input [11:0] read3_addr;
  output [1:0] read3_data;
  input [11:0] write0_addr;
  input [1:0]  write0_data;
  input        write0_en;
  input [11:0] write1_addr;
  input [1:0]  write1_data;
  input        write1_en;

  reg [1:0] ram[4095:0];

  reg [11:0] read0_addr_reg;
  reg [11:0] read1_addr_reg;
  reg [11:0] read2_addr_reg;
  reg [11:0] read3_addr_reg;

  assign read0_data=ram[read0_addr];
  assign read1_data=ram[read1_addr];
  assign read2_data=ram[read2_addr];
  assign read3_data=ram[read3_addr];

  always @(posedge clk) begin
    if (write0_wen) begin
        ram[write0_addr]<=write0_data;
    end
    if (write1_wen) begin
        ram[write1_addr]<=write1_data;
    end
  end

endmodule
