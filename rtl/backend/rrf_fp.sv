`include "../struct.sv"


module rrfF_buf(
  clk,
  rst,
  read0_addr,read0_data,
  read1_addr,read1_data,
  read2_addr,read2_data,
  read3_addr,read3_data,
  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen,
  write2_addr,write2_data,write2_wen,
  write3_addr,write3_data,write3_wen,
  write4_addr,write4_data,write4_wen,
  write5_addr,write5_data,write5_wen,
  read_thread,
  write_thread
  );
  
  parameter [3:0] INDEX=0;
  parameter DATA_WIDTH=`alu_width;
  parameter ADDR_WIDTH=4;
  
  input clk;
  input rst;
  
  input [ADDR_WIDTH-1:0] read0_addr;
  output [DATA_WIDTH-1:0] read0_data;
  input [ADDR_WIDTH-1:0] read1_addr;
  output [DATA_WIDTH-1:0] read1_data;
  input [ADDR_WIDTH-1:0] read2_addr;
  output [DATA_WIDTH-1:0] read2_data;
  input [ADDR_WIDTH-1:0] read3_addr;
  output [DATA_WIDTH-1:0] read3_data;

  
  input [ADDR_WIDTH-1:0] write0_addr;
  input [DATA_WIDTH-1:0] write0_data;
  input                  write0_wen;
  input [ADDR_WIDTH-1:0] write1_addr;
  input [DATA_WIDTH-1:0] write1_data;
  input                  write1_wen;
  input [ADDR_WIDTH-1:0] write2_addr;
  input [DATA_WIDTH-1:0] write2_data;
  input                  write2_wen;
  input [ADDR_WIDTH-1:0] write3_addr;
  input [DATA_WIDTH-1:0] write3_data;
  input                  write3_wen;
  input [ADDR_WIDTH-1:0] write4_addr;
  input [DATA_WIDTH-1:0] write4_data;
  input                  write4_wen;
  input [ADDR_WIDTH-1:0] write5_addr;
  input [DATA_WIDTH-1:0] write5_data;
  input                  write5_wen;

  input read_thread;
  input write_thread;

  reg [DATA_WIDTH-1:0] data0;
  wire [DATA_WIDTH-1:0] data;
  wire [DATA_WIDTH-1:0] wData;

  wire write0_hit;
  wire write1_hit;
  wire write2_hit;
  wire write3_hit;
  wire write4_hit;
  wire write5_hit;
  wire write_hit;
  
  assign data=~data0;
  
  assign read0_data=(read0_addr==INDEX) ? ~data : {DATA_WIDTH{1'BZ}};
  assign read1_data=(read1_addr==INDEX) ? ~data : {DATA_WIDTH{1'BZ}};
  assign read2_data=(read2_addr==INDEX) ? ~data : {DATA_WIDTH{1'BZ}};
  assign read3_data=(read3_addr==INDEX) ? ~data : {DATA_WIDTH{1'BZ}};
  
  assign write0_hit=write0_wen && write0_addr==INDEX;
  assign write1_hit=write1_wen && write1_addr==INDEX;
  assign write2_hit=write2_wen && write2_addr==INDEX;
  assign write3_hit=write3_wen && write3_addr==INDEX;
  assign write4_hit=write4_wen && write4_addr==INDEX;
  assign write5_hit=write5_wen && write5_addr==INDEX;
  assign write_hit=write0_hit | write1_hit | write2_hit | write3_hit | write4_hit
    | write5_hit;

  assign wData=(write0_hit) ? write0_data : {DATA_WIDTH{1'BZ}};
  assign wData=(write1_hit) ? write1_data : {DATA_WIDTH{1'BZ}};
  assign wData=(write2_hit) ? write2_data : {DATA_WIDTH{1'BZ}};
  assign wData=(write3_hit) ? write3_data : {DATA_WIDTH{1'BZ}};
  assign wData=(write4_hit) ? write4_data : {DATA_WIDTH{1'BZ}};
  assign wData=(write5_hit) ? write5_data : {DATA_WIDTH{1'BZ}};
  assign wData=(write_hit) ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};

  always @(posedge clk)
    begin
	  if (rst) begin data0<={DATA_WIDTH{1'B0}}; end
	  else 
	    begin
		  if (write_hit) data0<=wData;
		end
    end	
	
endmodule


module rrfF(
  clk,
  rst,
  read_clkEn,
  read0_addr,read0_data,read0_oe,
  read1_addr,read1_data,read1_oe,
  read2_addr,read2_data,read2_oe,
  read3_addr,read3_data,read3_oe,
  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen,
  write2_addr,write2_data,write2_wen,
  write3_addr,write3_data,write3_wen,
  write4_addr,write4_data,write4_wen,
  write5_addr,write5_data,write5_wen,
  read_thread,
  write_thread
  );
  
  parameter DATA_WIDTH=`alu_width;
  parameter EXTRA=0;
  localparam ADDR_WIDTH=6;
  localparam ADDR_COUNT=32+16*EXTRA;
  
  input clk;
  input rst;
  input read_clkEn;
  
  input [ADDR_WIDTH-1:0] read0_addr;
  output [DATA_WIDTH-1:0] read0_data;
  input read0_oe;
  input [ADDR_WIDTH-1:0] read1_addr;
  output [DATA_WIDTH-1:0] read1_data;
  input read1_oe;
  input [ADDR_WIDTH-1:0] read2_addr;
  output [DATA_WIDTH-1:0] read2_data;
  input read2_oe;
  input [ADDR_WIDTH-1:0] read3_addr;
  output [DATA_WIDTH-1:0] read3_data;
  input read3_oe;
  
  input [ADDR_WIDTH-1:0] write0_addr;
  input [DATA_WIDTH-1:0] write0_data;
  input                  write0_wen;
  input [ADDR_WIDTH-1:0] write1_addr;
  input [DATA_WIDTH-1:0] write1_data;
  input                  write1_wen;
  input [ADDR_WIDTH-1:0] write2_addr;
  input [DATA_WIDTH-1:0] write2_data;
  input                  write2_wen;
  input [ADDR_WIDTH-1:0] write3_addr;
  input [DATA_WIDTH-1:0] write3_data;
  input                  write3_wen;
  input [ADDR_WIDTH-1:0] write4_addr;
  input [DATA_WIDTH-1:0] write4_data;
  input                  write4_wen;
  input [ADDR_WIDTH-1:0] write5_addr;
  input [DATA_WIDTH-1:0] write5_data;
  input                  write5_wen;
  
  input read_thread;
  input write_thread;

  reg [ADDR_WIDTH-1:0] read0_addr_reg;
  reg [ADDR_WIDTH-1:0] read1_addr_reg;
  reg [ADDR_WIDTH-1:0] read2_addr_reg;
  reg [ADDR_WIDTH-1:0] read3_addr_reg;
  
  reg read_thread_reg;

/*  wire [DATA_WIDTH-1:0] read0_data_ram;
  wire [DATA_WIDTH-1:0] read1_data_ram;
  wire [DATA_WIDTH-1:0] read2_data_ram;
  wire [DATA_WIDTH-1:0] read3_data_ram;
  wire [DATA_WIDTH-1:0] read4_data_ram;
  wire [DATA_WIDTH-1:0] read5_data_ram;
  wire [DATA_WIDTH-1:0] read6_data_ram;
  wire [DATA_WIDTH-1:0] read7_data_ram;
  wire [DATA_WIDTH-1:0] read8_data_ram;
*/

  reg read0_oe_reg;
  reg read1_oe_reg;
  reg read2_oe_reg;
  reg read3_oe_reg;

  genvar bufNo,tileNo;
  
/*  assign read0_data=(read0_oe_reg) ? read0_data_ram : {DATA_WIDTH{1'BZ}};
  assign read1_data=(read1_oe_reg) ? read1_data_ram : {DATA_WIDTH{1'BZ}};
  assign read2_data=(read2_oe_reg) ? read2_data_ram : {DATA_WIDTH{1'BZ}};
  assign read3_data=(read3_oe_reg) ? read3_data_ram : {DATA_WIDTH{1'BZ}};
  assign read4_data=(read4_oe_reg) ? read4_data_ram : {DATA_WIDTH{1'BZ}};
  assign read5_data=(read5_oe_reg) ? read5_data_ram : {DATA_WIDTH{1'BZ}};
  assign read6_data=(read6_oe_reg) ? read6_data_ram : {DATA_WIDTH{1'BZ}};
  assign read7_data=(read7_oe_reg) ? read7_data_ram : {DATA_WIDTH{1'BZ}};
  assign read8_data=(read8_oe_reg) ? read8_data_ram : {DATA_WIDTH{1'BZ}};
*/  
  always @(posedge clk)
    begin
	  if (rst)
	    begin
		  read0_addr_reg<={ADDR_WIDTH{1'B0}};
		  read1_addr_reg<={ADDR_WIDTH{1'B0}};
		  read2_addr_reg<={ADDR_WIDTH{1'B0}};
		  read3_addr_reg<={ADDR_WIDTH{1'B0}};

		  read_thread_reg<=1'b0;
		  
		  read0_oe_reg<=1'b1;
		  read1_oe_reg<=1'b1;
		  read2_oe_reg<=1'b1;
		  read3_oe_reg<=1'b1;
		end
	  else if (read_clkEn)
	    begin
		  read0_addr_reg<=read0_addr;
		  read1_addr_reg<=read1_addr;
		  read2_addr_reg<=read2_addr;
		  read3_addr_reg<=read3_addr;

		  read_thread_reg<=read_thread;
		  
		  read0_oe_reg<=read0_oe;
		  read1_oe_reg<=read1_oe;
		  read2_oe_reg<=read2_oe;
		  read3_oe_reg<=read3_oe;
		end
	end

  assign write0P_wen=write0_wen ? write0_wen : write3_wen;
  assign write0P_addr=write0_wen ? write0_addr : write3_addr;
  assign write0P_data=write0_wen ? write0_data : write3_data;

  assign write3P_wen=write0_wen&write6_wen ? write6_wen : write3_wen;
  assign write3P_addr=write0_wen&write6_wen ? write6_addr : write3_addr;
  assign write3P_data=write0_wen&write6_wen ? write6_data : write3_data;

  assign write1P_wen=write1_wen ? write1_wen : write4_wen;
  assign write1P_addr=write1_wen ? write1_addr : write4_addr;
  assign write1P_data=write1_wen ? write1_data : write4_data;

  assign write4P_wen=write1_wen&write7_wen ? write7_wen : write4_wen;
  assign write4P_addr=write1_wen&write7_wen ? write7_addr : write4_addr;
  assign write4P_data=write1_wen&write7_wen ? write7_data : write4_data;

  assign write2P_wen=write2_wen ? write2_wen : write5_wen;
  assign write2P_addr=write2_wen ? write2_addr : write5_addr;
  assign write2P_data=write2_wen ? write2_data : write5_data;

  assign write5P_wen=write2_wen&write8_wen ? write8_wen : write5_wen;
  assign write5P_addr=write2_wen&write8_wen ? write8_addr : write5_addr;
  assign write5P_data=write2_wen&write8_wen ? write8_data : write5_data;

  generate
    for (tileNo=0;tileNo<2+EXTRA;tileNo=tileNo+1) begin : tiles_gen
        wire [DATA_WIDTH-1:0] read0_data_ramA;
        wire [DATA_WIDTH-1:0] read1_data_ramA;
        wire [DATA_WIDTH-1:0] read2_data_ramA;
        wire [DATA_WIDTH-1:0] read3_data_ramA;
    for (bufNo=0;bufNo<16;bufNo=bufNo+1)  begin : buffers
        rrfF_buf #(bufNo,DATA_WIDTH,4) buf_mod(
        clk,
        rst,
        read0_addr_reg[3:0],read0_data_ramA,
        read1_addr_reg[3:0],read1_data_ramA,
        read2_addr_reg[3:0],read2_data_ramA,
        read3_addr_reg[3:0],read3_data_ramA,
        write0P_addr[3:0],write0P_data,write0P_wen && write0P_addr[5:4]==tileNo,
        write1P_addr[3:0],write1P_data,write1P_wen && write1P_addr[5:4]==tileNo,
        write2P_addr[3:0],write2P_data,write2P_wen && write2P_addr[5:4]==tileNo,
        write3P_addr[3:0],write3P_data,write3P_wen && write3P_addr[5:4]==tileNo,
        write4P_addr[3:0],write4P_data,write4P_wen && write4P_addr[5:4]==tileNo,
        write5P_addr[3:0],write5P_data,write5P_wen && write5P_addr[5:4]==tileNo,
        read_thread_reg,
        write_thread
        );
    end
        assign read0_data=(read0_addr_reg[5:4]==tileNo && read0_oe_reg) ? read0_data_ramA : {DATA_WIDTH{1'BZ}};
        assign read1_data=(read1_addr_reg[5:4]==tileNo && read1_oe_reg) ? read1_data_ramA : {DATA_WIDTH{1'BZ}};
        assign read2_data=(read2_addr_reg[5:4]==tileNo && read2_oe_reg) ? read2_data_ramA : {DATA_WIDTH{1'BZ}};
        assign read3_data=(read3_addr_reg[5:4]==tileNo && read3_oe_reg) ? read3_data_ramA : {DATA_WIDTH{1'BZ}};
    end
  endgenerate

endmodule



