
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
  clk,rst,doStall,stall,
  read_data,read_bank,read_clkEn,
  write_addr,write_data,write_bank,write_wen);
  localparam data_width=32;
  localparam addr_width=5;
  localparam addr_count=32;
  input clk;
  input rst;
  output doStall;
  input stall;
  output reg [16*data_width-1:0] read_data;
  input read_bank;
  input read_clkEn;
  input [4:0] write_addr;
  input [16*data_width-1:0] write_data;
  input write_bank;
  input write_wen;
  
  wire [data_width*2-1:0] write_ben;
  reg [16*data_width*2-1:0] read_data0;
  reg [16*data_width*2-1:0] write_data0;
  reg read_bank_reg;
  reg [4:0] front;
  reg [5:0] cnt;
  reg [4:0] read_addr;
  wire [4:0] read_addr_d;
  wire [5:0] cnt_inc;
  wire [5:0] cnt_dec;

  always @(posedge clk) begin
      read_bank_reg<=read_bank;
      if (cnt!=6'd0 && read_clkEn) read_addr<=read_addr_d;
      if (write_wen && !read_clkEn) cnt<=cnt_inc;
      if (read_clkEn && !write_wen) cnt<=cnt_dec;
  end

  get_carry #(6) cmp_mod(cnt,~6'd24,1'b1,doStall);
  adder_inc #(5) inc_mod(read_addr,read_addr_d,1'b1,);
  adder_inc #(6) inc_cnt_mod(cnt,cnt_inc,1'b1,);
  adder #(6) dec_cnt_mod(cnt,6'h3f,cnt_dec,1'b0,1'b1,,,);

  generate
    genvar x;
    for(x=0;x<16;x=x+1) begin : h_ram
        MSI_bus_data_ram ram_mod(
        clk,rst,
        read_addr,read_data0[x*data_width*2+:data_width*2],read_clkEn,
        write_addr,write_data0[x*data_width*2+:data_width*2],write_ben,write_wen);
    end
  endgenerate

  assign write_ben={data_width{{~write_bank,write_bank}}};
  integer k;
  always @(read_data0) begin
	  for(k=0;k<(16*data_width);k=k+1) begin
		  read_data[k]=read_bank_reg ? read_data0[k*2+1] : read_data0[k*2];
		  write_data0[k*2+:2]={2{write_data[k]}};
	  end
  end
endmodule

