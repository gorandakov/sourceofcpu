/*
Copyright 2022 Goran Dakov

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

`include "../struct.sv"


module rrf_buf(
  clk,
  rst,
  read0_addr,read0_data,
  read1_addr,read1_data,
  read2_addr,read2_data,
  read3_addr,read3_data,
  read4_addr,read4_data,
  read5_addr,read5_data,
  read6_addr,read6_data,
  read7_addr,read7_data,
  read8_addr,read8_data,
  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen,
  write2_addr,write2_data,write2_wen,
  write3_addr,write3_data,write3_wen,
  write4_addr,write4_data,write4_wen,
  write5_addr,write5_data,write5_wen,
  write6_addr,write6_data,write6_wen,
  write7_addr,write7_data,write7_wen,
  write8_addr,write8_data,write8_wen,
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
  input [ADDR_WIDTH-1:0] read4_addr;
  output [DATA_WIDTH-1:0] read4_data;
  input [ADDR_WIDTH-1:0] read5_addr;
  output [DATA_WIDTH-1:0] read5_data;
  input [ADDR_WIDTH-1:0] read6_addr;
  output [DATA_WIDTH-1:0] read6_data;
  input [ADDR_WIDTH-1:0] read7_addr;
  output [DATA_WIDTH-1:0] read7_data;
  input [ADDR_WIDTH-1:0] read8_addr;
  output [DATA_WIDTH-1:0] read8_data;

  
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
  input [ADDR_WIDTH-1:0] write6_addr;
  input [DATA_WIDTH-1:0] write6_data;
  input                  write6_wen;
  input [ADDR_WIDTH-1:0] write7_addr;
  input [DATA_WIDTH-1:0] write7_data;
  input                  write7_wen;
  input [ADDR_WIDTH-1:0] write8_addr;
  input [DATA_WIDTH-1:0] write8_data;
  input                  write8_wen;

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
  wire write6_hit;
  wire write7_hit;
  wire write8_hit;
  wire write_hit;
  
  assign data=~data0;
  
  assign read0_data=(read0_addr==INDEX) ? ~data : {DATA_WIDTH{{1{1'bz}}}};
  assign read1_data=(read1_addr==INDEX) ? ~data : {DATA_WIDTH{{1{1'bz}}}};
  assign read2_data=(read2_addr==INDEX) ? ~data : {DATA_WIDTH{{1{1'bz}}}};
  assign read3_data=(read3_addr==INDEX) ? ~data : {DATA_WIDTH{{1{1'bz}}}};
  assign read4_data=(read4_addr==INDEX) ? ~data : {DATA_WIDTH{{1{1'bz}}}};
  assign read5_data=(read5_addr==INDEX) ? ~data : {DATA_WIDTH{{1{1'bz}}}};
  assign read6_data=(read6_addr==INDEX) ? ~data : {DATA_WIDTH{{1{1'bz}}}};
  assign read7_data=(read7_addr==INDEX) ? ~data : {DATA_WIDTH{{1{1'bz}}}};
  assign read8_data=(read8_addr==INDEX) ? ~data : {DATA_WIDTH{{1{1'bz}}}};
  
  assign write0_hit=write0_wen && write0_addr==INDEX;
  assign write1_hit=write1_wen && write1_addr==INDEX;
  assign write2_hit=write2_wen && write2_addr==INDEX;
  assign write3_hit=write3_wen && write3_addr==INDEX;
  assign write4_hit=write4_wen && write4_addr==INDEX;
  assign write5_hit=write5_wen && write5_addr==INDEX;
  assign write6_hit=write6_wen && write6_addr==INDEX;
  assign write7_hit=write7_wen && write7_addr==INDEX;
  assign write8_hit=write8_wen && write8_addr==INDEX;
  assign write_hit=write0_hit | write1_hit | write2_hit | write3_hit | write4_hit
    | write5_hit | write6_hit  | write7_hit | write8_hit;

  assign wData=(write0_hit) ? write0_data : {DATA_WIDTH{{1{1'bz}}}};
  assign wData=(write1_hit) ? write1_data : {DATA_WIDTH{{1{1'bz}}}};
  assign wData=(write2_hit) ? write2_data : {DATA_WIDTH{{1{1'bz}}}};
  assign wData=(write3_hit) ? write3_data : {DATA_WIDTH{{1{1'bz}}}};
  assign wData=(write4_hit) ? write4_data : {DATA_WIDTH{{1{1'bz}}}};
  assign wData=(write5_hit) ? write5_data : {DATA_WIDTH{{1{1'bz}}}};
  assign wData=(write6_hit) ? write6_data : {DATA_WIDTH{{1{1'bz}}}};
  assign wData=(write7_hit) ? write7_data : {DATA_WIDTH{{1{1'bz}}}};
  assign wData=(write8_hit) ? write8_data : {DATA_WIDTH{{1{1'bz}}}};
  assign wData=(write_hit) ? {DATA_WIDTH{{1{1'bz}}}} : {DATA_WIDTH{1'B0}};

  always @(posedge clk)
    begin
	  if (rst) begin data0<={DATA_WIDTH{1'B0}}; end
	  else 
	    begin
		  if (write_hit) data0<=wData;
		end
    end	
	
endmodule


module rrf(
  clk,
  rst,
  read_clkEn,
  read0_addr,read0_data,read0_dataN,read0_oe,
  read1_addr,read1_data,read1_dataN,read1_oe,
  read2_addr,read2_data,read2_dataN,read2_oe,
  read3_addr,read3_data,read3_dataN,read3_oe,
  read4_addr,read4_data,read4_dataN,read4_oe,
  read5_addr,read5_data,read5_dataN,read5_oe,
  read6_addr,read6_data,read6_dataN,read6_oe,
  read7_addr,read7_data,read7_dataN,read7_oe,
  read8_addr,read8_data,read8_dataN,read8_oe,
  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen,
  write2_addr,write2_data,write2_wen,
  write3_addr,write3_data,write3_wen,
  write4_addr,write4_data,write4_wen,
  write5_addr,write5_data,write5_wen,
  write6_addr,write6_data,write6_wen,
  write7_addr,write7_data,write7_wen,
  write8_addr,write8_data,write8_wen,
  read_thread,
  write_thread
  );
  
  parameter DATA_WIDTH=`alu_width;
  parameter EXTRA=0;
  localparam ADDR_WIDTH=6;
  localparam ADDR_COUNT=32+16*EXTRA;
/*verilator hier_block*/ 
  
  input clk;
  input rst;
  input read_clkEn;
  
  input [ADDR_WIDTH-1:0] read0_addr;
  output [DATA_WIDTH-1:0] read0_data;
  output [DATA_WIDTH-1:0] read0_dataN;
  input read0_oe;
  input [ADDR_WIDTH-1:0] read1_addr;
  output [DATA_WIDTH-1:0] read1_data;
  output [DATA_WIDTH-1:0] read1_dataN;
  input read1_oe;
  input [ADDR_WIDTH-1:0] read2_addr;
  output [DATA_WIDTH-1:0] read2_data;
  output [DATA_WIDTH-1:0] read2_dataN;
  input read2_oe;
  input [ADDR_WIDTH-1:0] read3_addr;
  output [DATA_WIDTH-1:0] read3_data;
  output [DATA_WIDTH-1:0] read3_dataN;
  input read3_oe;
  input [ADDR_WIDTH-1:0] read4_addr;
  output [DATA_WIDTH-1:0] read4_data;
  output [DATA_WIDTH-1:0] read4_dataN;
  input read4_oe;
  input [ADDR_WIDTH-1:0] read5_addr;
  output [DATA_WIDTH-1:0] read5_data;
  output [DATA_WIDTH-1:0] read5_dataN;
  input read5_oe;
  input [ADDR_WIDTH-1:0] read6_addr;
  output [DATA_WIDTH-1:0] read6_data;
  output [DATA_WIDTH-1:0] read6_dataN;
  input read6_oe;
  input [ADDR_WIDTH-1:0] read7_addr;
  output [DATA_WIDTH-1:0] read7_data;
  output [DATA_WIDTH-1:0] read7_dataN;
  input read7_oe;
  input [ADDR_WIDTH-1:0] read8_addr;
  output [DATA_WIDTH-1:0] read8_data;
  output [DATA_WIDTH-1:0] read8_dataN;
  input read8_oe;

  
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
  input [ADDR_WIDTH-1:0] write6_addr;
  input [DATA_WIDTH-1:0] write6_data;
  input                  write6_wen;
  input [ADDR_WIDTH-1:0] write7_addr;
  input [DATA_WIDTH-1:0] write7_data;
  input                  write7_wen;
  input [ADDR_WIDTH-1:0] write8_addr;
  input [DATA_WIDTH-1:0] write8_data;
  input                  write8_wen;
  
  input read_thread;
  input write_thread;

  reg [ADDR_WIDTH-1:0] read0_addr_reg;
  reg [ADDR_WIDTH-1:0] read1_addr_reg;
  reg [ADDR_WIDTH-1:0] read2_addr_reg;
  reg [ADDR_WIDTH-1:0] read3_addr_reg;
  reg [ADDR_WIDTH-1:0] read4_addr_reg;
  reg [ADDR_WIDTH-1:0] read5_addr_reg;
  reg [ADDR_WIDTH-1:0] read6_addr_reg;
  reg [ADDR_WIDTH-1:0] read7_addr_reg;
  reg [ADDR_WIDTH-1:0] read8_addr_reg;
  
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
  reg read4_oe_reg;
  reg read5_oe_reg;
  reg read6_oe_reg;
  reg read7_oe_reg;
  reg read8_oe_reg;

  genvar bufNo,tileNo;
  
/*  assign read0_data=(read0_oe_reg) ? read0_data_ram : {DATA_WIDTH{{1{1'bz}}}};
  assign read1_data=(read1_oe_reg) ? read1_data_ram : {DATA_WIDTH{{1{1'bz}}}};
  assign read2_data=(read2_oe_reg) ? read2_data_ram : {DATA_WIDTH{{1{1'bz}}}};
  assign read3_data=(read3_oe_reg) ? read3_data_ram : {DATA_WIDTH{{1{1'bz}}}};
  assign read4_data=(read4_oe_reg) ? read4_data_ram : {DATA_WIDTH{{1{1'bz}}}};
  assign read5_data=(read5_oe_reg) ? read5_data_ram : {DATA_WIDTH{{1{1'bz}}}};
  assign read6_data=(read6_oe_reg) ? read6_data_ram : {DATA_WIDTH{{1{1'bz}}}};
  assign read7_data=(read7_oe_reg) ? read7_data_ram : {DATA_WIDTH{{1{1'bz}}}};
  assign read8_data=(read8_oe_reg) ? read8_data_ram : {DATA_WIDTH{{1{1'bz}}}};
*/  
  always @(posedge clk)
    begin
	  if (rst)
	    begin
		  read0_addr_reg<={ADDR_WIDTH{1'B0}};
		  read1_addr_reg<={ADDR_WIDTH{1'B0}};
		  read2_addr_reg<={ADDR_WIDTH{1'B0}};
		  read3_addr_reg<={ADDR_WIDTH{1'B0}};
		  read4_addr_reg<={ADDR_WIDTH{1'B0}};
		  read5_addr_reg<={ADDR_WIDTH{1'B0}};
		  read6_addr_reg<={ADDR_WIDTH{1'B0}};
		  read7_addr_reg<={ADDR_WIDTH{1'B0}};
		  read8_addr_reg<={ADDR_WIDTH{1'B0}};

		  read_thread_reg<=1'b0;
		  
		  read0_oe_reg<=1'b1;
		  read1_oe_reg<=1'b1;
		  read2_oe_reg<=1'b1;
		  read3_oe_reg<=1'b1;
		  read4_oe_reg<=1'b1;
		  read5_oe_reg<=1'b1;
		  read6_oe_reg<=1'b1;
		  read7_oe_reg<=1'b1;
		  read8_oe_reg<=1'b1;
		end
	  else if (read_clkEn)
	    begin
		  read0_addr_reg<=read0_addr;
		  read1_addr_reg<=read1_addr;
		  read2_addr_reg<=read2_addr;
		  read3_addr_reg<=read3_addr;
		  read4_addr_reg<=read4_addr;
		  read5_addr_reg<=read5_addr;
		  read6_addr_reg<=read6_addr;
		  read7_addr_reg<=read7_addr;
		  read8_addr_reg<=read8_addr;

		  read_thread_reg<=read_thread;
		  
		  read0_oe_reg<=read0_oe;
		  read1_oe_reg<=read1_oe;
		  read2_oe_reg<=read2_oe;
		  read3_oe_reg<=read3_oe;
		  read4_oe_reg<=read4_oe;
		  read5_oe_reg<=read5_oe;
		  read6_oe_reg<=read6_oe;
		  read7_oe_reg<=read7_oe;
		  read8_oe_reg<=read8_oe;
		end
	end
	
  generate
    for (tileNo=0;tileNo<2+EXTRA;tileNo=tileNo+1) begin : tiles_gen
        wire [DATA_WIDTH-1:0] read0_data_ramA;
        wire [DATA_WIDTH-1:0] read1_data_ramA;
        wire [DATA_WIDTH-1:0] read2_data_ramA;
        wire [DATA_WIDTH-1:0] read3_data_ramA;
        wire [DATA_WIDTH-1:0] read4_data_ramA;
        wire [DATA_WIDTH-1:0] read5_data_ramA;
        wire [DATA_WIDTH-1:0] read6_data_ramA;
        wire [DATA_WIDTH-1:0] read7_data_ramA;
        wire [DATA_WIDTH-1:0] read8_data_ramA;
    for (bufNo=0;bufNo<16;bufNo=bufNo+1)  begin : buffers
        rrf_buf #(bufNo,DATA_WIDTH,4) buf_mod(
        clk,
        rst,
        read0_addr_reg[3:0],read0_data_ramA,
        read1_addr_reg[3:0],read1_data_ramA,
        read2_addr_reg[3:0],read2_data_ramA,
        read3_addr_reg[3:0],read3_data_ramA,
        read4_addr_reg[3:0],read4_data_ramA,
        read5_addr_reg[3:0],read5_data_ramA,
        read6_addr_reg[3:0],read6_data_ramA,
        read7_addr_reg[3:0],read7_data_ramA,
        read8_addr_reg[3:0],read8_data_ramA,
        write0_addr[3:0],write0_data,write0_wen && write0_addr[5:4]==tileNo,
        write1_addr[3:0],write1_data,write1_wen && write1_addr[5:4]==tileNo,
        write2_addr[3:0],write2_data,write2_wen && write2_addr[5:4]==tileNo,
        write3_addr[3:0],write3_data,write3_wen && write3_addr[5:4]==tileNo,
        write4_addr[3:0],write4_data,write4_wen && write4_addr[5:4]==tileNo,
        write5_addr[3:0],write5_data,write5_wen && write5_addr[5:4]==tileNo,
        write6_addr[3:0],write6_data,write6_wen && write6_addr[5:4]==tileNo,
        write7_addr[3:0],write7_data,write7_wen && write7_addr[5:4]==tileNo,
        write8_addr[3:0],write8_data,write8_wen && write8_addr[5:4]==tileNo,
        read_thread_reg,
        write_thread
        );
    end
        assign read0_data=(read0_addr_reg[5:4]==tileNo && read0_oe_reg) ? read0_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read1_data=(read1_addr_reg[5:4]==tileNo && read1_oe_reg) ? read1_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read2_data=(read2_addr_reg[5:4]==tileNo && read2_oe_reg) ? read2_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read3_data=(read3_addr_reg[5:4]==tileNo && read3_oe_reg) ? read3_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read4_data=(read4_addr_reg[5:4]==tileNo && read4_oe_reg) ? read4_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read5_data=(read5_addr_reg[5:4]==tileNo && read5_oe_reg) ? read5_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read6_data=(read6_addr_reg[5:4]==tileNo && read6_oe_reg) ? read6_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read7_data=(read7_addr_reg[5:4]==tileNo && read7_oe_reg) ? read7_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read8_data=(read8_addr_reg[5:4]==tileNo && read8_oe_reg) ? read8_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read0_dataN=(read0_addr_reg[5:4]==tileNo && read0_oe_reg) ? ~read0_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read1_dataN=(read1_addr_reg[5:4]==tileNo && read1_oe_reg) ? ~read1_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read2_dataN=(read2_addr_reg[5:4]==tileNo && read2_oe_reg) ? ~read2_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read3_dataN=(read3_addr_reg[5:4]==tileNo && read3_oe_reg) ? ~read3_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read4_dataN=(read4_addr_reg[5:4]==tileNo && read4_oe_reg) ? ~read4_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read5_dataN=(read5_addr_reg[5:4]==tileNo && read5_oe_reg) ? ~read5_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read6_dataN=(read6_addr_reg[5:4]==tileNo && read6_oe_reg) ? ~read6_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read7_dataN=(read7_addr_reg[5:4]==tileNo && read7_oe_reg) ? ~read7_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
        assign read8_dataN=(read8_addr_reg[5:4]==tileNo && read8_oe_reg) ? ~read8_data_ramA : {DATA_WIDTH{{1{1'bz}}}};
    end
  endgenerate

endmodule



