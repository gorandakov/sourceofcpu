
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

module MSI_bus_nondata_ram(
  clk,rst,
  read_addr,read_data,read_clkEn,
  write_addr,write_data,write_ben,write_wen);
  localparam data_width=2*`rbusD_width+40;
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
  clk,rst,doStall,doStallR,
  read_data,read_bank,read_clkEn,read_signals,read_src_req,read_dst_req,
  write_addr,write_data,write_bank,write_wen,write_signals,write_src_req,write_dst_req,write_wait);
  localparam data_width=32;
  localparam addr_width=5;
  localparam addr_count=32;
  localparam waitcnt=15;
  localparam sigwidth=`rbusD_width+20;
  input clk;
  input rst;
  output doStall;
  output doStallR;
  output reg [16*data_width-1:0] read_data;
  input read_bank;
  input read_clkEn;
  output [`rbusD_width-1:0] read_signals;
  output [9:0] read_src_req;
  output [9:0] read_dst_req;
  input [4:0] write_addr;
  input [16*data_width-1:0] write_data;
  input write_bank;
  input write_wen;
  input [`rbusD_width-1:0] write_signals;
  input [9:0] write_src_req;
  input [9:0] write_dst_req;
  input write_wait;
  
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
  wire [sigwidth*2-1:0] read_data_non;
  wire [sigwidth*2-1:0] write_data_non;
  wire [sigwidth*2-1:0] write_ben_non;
  wire wait_non_full;
  wire [5:0] cnt_wait;
  wire doStall0;
  wire [5:0] wcnt_d;
  reg [5:0] wcnt;

  always @(posedge clk) begin
      if (rst) begin
	  read_bank_reg<=1'b0;
	  cnt<=6'd0;
	  wcnt<=6'd0;
      end else begin
          read_bank_reg<=read_bank;
          if (cnt!=6'd0 && read_clkEn) read_addr<=read_addr_d;
          if (write_wen && !(read_clkEn&&read_bank) && write_bank) cnt<=cnt_inc;
          if (read_clkEn && read_bank && !(write_wen && write_bank)) cnt<=cnt_dec;
          if (write_wen && !write_bank && write_wait) begin
	      if (!wait_non_full) begin
	          wcnt<=waitcnt[5:0];
	      end else begin
	          wcnt<=cnt_wait;
	      end
          end else begin
	      if (wcnt!=6'd0) wcnt<=wcnt_d;
          end
      end
  end

  get_carry #(6) cmp_mod(cnt,~6'd24,1'b1,doStall0);
  adder_inc #(5) inc_mod(read_addr,read_addr_d,1'b1,);
  adder_inc #(6) inc_cnt_mod(cnt,cnt_inc,1'b1,);
  adder #(6) dec_cnt_mod(cnt,6'h3f,cnt_dec,1'b0,1'b1,,,);
  adder #(6) cntAdd_mod(waitcnt[5:0],~cnt,cnt_wait,read_clkEn,1'b1,wait_non_full,,);
  adder #(6) cntDec_mod(wcnt,6'h3f,wcnt_d,1'b0,1'b1,,,);
  generate
    genvar x;
    for(x=0;x<16;x=x+1) begin : h_ram
        MSI_bus_data_ram ram_mod(
        clk,rst,
        read_addr,read_data0[x*data_width*2+:data_width*2],read_clkEn,
        write_addr,write_data0[x*data_width*2+:data_width*2],write_ben,write_wen);
    end
  endgenerate
  
  MSI_bus_nondata_ram ramN_mod(
  clk,rst,
  read_addr,read_data_non,read_clkEn,
  write_addr,write_data_non,write_ben_non,write_wen);

  assign write_ben={data_width{{~write_bank,write_bank}}};
  integer k;
  always @(read_data0,write_data) begin
	  for(k=0;k<(16*data_width);k=k+1) begin
		  read_data[k]=read_bank_reg ? read_data0[k*2+1] : read_data0[k*2];
		  write_data0[k*2+:2]={2{write_data[k]}};
	  end
	  for(k=0;k<`rbusD_width;k++) begin
		  write_data_non[k*2+:2]={2{write_data_non9[k]}};
		  read_data_non9[k]=read_bank_reg ? read_data_non[k*2+1] : read_data_non[k*2]
	  end
  end
  assign write_data_non9={write_signals,write_src_req,write_dst_req};
  assign {read_signals,read_src_req,read_dst_req}=read_data_non9;
  assign doStall=doStall0;
  assign doStallR=wcnt!=6'd0 || cnt==6'd0;
endmodule

