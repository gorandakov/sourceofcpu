

module texture_cache_ram(
  clk,
  rst,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen);
  input clk;
  input rst;
  input [1:0] read_addr;
  output [255+44-5+1:0] read_data;
  input [1:0] write_addr;
  input [255+44-5+1:0]  write_data;
  input write_wen;

  reg [255+44-5+1:0] RAM[3:0];

  assign read_data=RAM[read_addr];

  always @(posedge clk) begin
    if (rst) begin
        RAM<=0;
    end else begin
        if (write_wen) RAM[write_addr]<=write_data;
    end
  end
	
endmodule

module texture_cache(
  clk,
  rst,
  except,
  read_clkEn,
  read_addr,
  read_data,
  read_hit,
  write_addr,
  write_data,
  write_wen);
  input clk;
  input rst;
  input except;
  input read_clkEn;
  input [43-5:0] read_addr;
  output [255+44-5+1:0] read_data;
  output read_hit;
  input [43-5:0] write_addr;
  input [255+44-5+1:0]  write_data;
  input write_wen;
  
  wire [43-5:0] addr;
  wire valid;

  texture_cache_ram  ram_mod(
  clk,
  rst|except,
  read_addr[1:0],
  {valid,addr,read_data},
  write_addr[1:0],
  {1'b1,write_addr,write_data},
  write_wen);

  assign read_hit=read_clkEn && addr==read_addr && valid;

endmodule
