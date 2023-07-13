
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

module lpddr5_queue_ram(
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
  input [3:0] read_addr;
  output [`ramQ_width-1:0] read_data;
  input [3:0] write_addr;
  input [`ramQ_width-1:0] write_data;
  input write_wen;

  reg [`ramQ_width-1:0] RAM[15:0];

  assign read_data=RAM[read_addr_reg];

  always @(posedge clk) begin
      if (rst) read_addr_reg<=0;
      else if (read_clkEn) read_addr_reg<=read_addr;
      if (write_wen) RAM[write_addr]<=write_data;
  end

endmodule
module lpddr5_Rqueue(
  clk,
  rst,
  doStall,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen);
  input clk;
  input rst;
  output reg doStall;
  input read_clkEn;
  input [3:0] read_addr;
  output [`ramQ_width-1:0] read_data;
  input [3:0] write_addr;
  input [`ramQ_width-1:0] write_data;
  input write_wen;
  
  reg [3:0] cur_pos;
  reg [4:0] cnt;

  always @(posedge clk) begin
      if (rst) begin
          cur_pos<=0;
          cnt<=0;
          doStall<=0;
      end else begin
          if (read_clkEn) cur_pos<=cur_pos_inc;
          if (read_clkEn & ~ write_wen) cnt<=cnt_dec;
          if (~read_clkEn & write_wen) cnt<=cnt_inc;
          doStall<=cnt==15 || cnt==16;
      end
  end
endmodule
module lpddr5_cache(
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


