



module dtlb2_ram(
  clk,
  rst,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=`dtlb_width;
  localparam ADDR_WIDTH=7;
  localparam ADDR_COUNT=128;
  
  input clk;
  input rst;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  
  assign read_data=ram[read_addr];

  always @(posedge clk)
    begin
      if (write_wen) ram[write_addr]<=write_data;
    end

endmodule



module dtlb2_lru_ram(
  clk,
  rst,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=4;
  localparam ADDR_WIDTH=7;
  localparam ADDR_COUNT=128;
  
  input clk;
  input rst;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  
  assign read_data=ram[read_addr];

  always @(posedge clk)
    begin
      if (write_wen) ram[write_addr]<=write_data;
    end

endmodule

module l2_tlb(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_hit,
  read_hitH,
  read_data0,
  read_data1,
  read_data2,
  write_addr,
  write_data0,
  write_data1,
  write_data2,
  write_wen,
  write_wenH,
  write_invl
  );
endmodule

