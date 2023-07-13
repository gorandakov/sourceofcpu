
module lpddr5_data_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen);
  input clk;
  input rst;
  input read_clkEn;
  input [6:0] read_addr;
  output [255:0] read_data;
  input [6:0] write_addr;
  input [255:0] write_data;
  input write_wen;

  reg [255:0] RAM[127:0];

  assign read_data=RAM[read_addr_reg];

  always @(posedge clk) begin
      if (rst) read_addr_reg<=0;
      else if (read_clkEn) read_addr_reg<=read_addr;
      if (write_wen) RAM[write_addr]<=write_data;
  end

endmodule

module lpddr5_tag_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen);
  input clk;
  input rst;
  input read_clkEn;
  input [6:0] read_addr;
  output [4:0] read_data;
  input [6:0] write_addr;
  input [44:0] write_data;
  input write_wen;

  reg [30:0] RAM[127:0];

  assign read_data=RAM[read_addr_reg];

  always @(posedge clk) begin
      if (rst) read_addr_reg<=0;
      else if (read_clkEn) read_addr_reg<=read_addr;
      if (write_wen) RAM[write_addr]<=write_data;
  end

endmodule


module lpddr5_cache_way(
  clk,
  rst,
  reqRD_en,reqRD_req,reqRD_dirty,
  reqRD_out_en,reqRD_out_req,reqRD_out_dirty,
  reqWR_doStall,
  reqWR_en_in,reqWQ_req,reqWR_data,
  mem_clk,
  RAS,
  CAS,
  CS0,
  ADDR15,
  DATA18A,DATA18B);
  );

endmodule

module lpddr5_cache();
endmodule

