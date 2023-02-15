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

`include "struct.sv"

module dwtlb_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=`dwtlb_width;
  localparam ADDR_WIDTH=5;
  localparam ADDR_COUNT=32;
  
  input clk;
  input rst;
  input read_clkEn;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  reg [ADDR_WIDTH-1:0] read_addr_reg;
  
  assign read_data=ram[read_addr_reg];

  always @(posedge clk)
    begin
      if (rst) read_addr_reg<={ADDR_WIDTH{1'b0}};
      else if (read_clkEn) read_addr_reg<=read_addr;
      if (write_wen) ram[write_addr]<=write_data;
    end

endmodule


module dwtlb_way(
  clk,
  rst,
  read_clkEn,
  addr,
  read_data0,
  read_data1,
  read_lru,
  read_hit,
  write_data0,
  write_data1,
  write_wen,
  newLRU
  );

  parameter WAYNO=0;
  localparam DATA_WIDTH=`dwtlb_width;
  localparam OUTDATA_WIDTH=`dtlbData_width;
  localparam IP_WIDTH=63-13;
  localparam ADDR_WIDTH=5;

  
  input clk;
  input rst;
  input read_clkEn;
  input [IP_WIDTH-1:0] addr;
  output [OUTDATA_WIDTH-1:0] read_data0;
  output [OUTDATA_WIDTH-1:0] read_data1;
  output [1:0] read_lru;
  output read_hit;
  input [1:0] write_way;
  input [OUTDATA_WIDTH-1:0] write_data0;
  input [OUTDATA_WIDTH-1:0] write_data1;
  input write_wen;
  input [2:0] newLRU;
  
  wire valid;
  wire [IP_WIDTH-1:0] ip;
  wire write_wen_ram;
  wire [DATA_WIDTH-1:0] read_data_ram;
  wire [DATA_WIDTH-1:0] write_data_ram;
  wire [DATA_WIDTH-1:0] write_data_new;
  wire [DATA_WIDTH-1:0] write_data_same;

  reg [IP_WIDTH-1:0] addr_reg;
  reg write_wen_reg;

  reg [OUTDATA_WIDTH-1:0] write_data0_reg;
  reg [OUTDATA_WIDTH-1:0] write_data1_reg;
  
  assign ip=read_data_ram[`dwtlb_ip];
  assign valid=read_data_ram[`dwtlb_valid];
  assign read_lru=read_data_ram[`dwtlb_lru];
  
  assign read_hit=valid && ip==addr_reg;
  
  assign write_wen_ram=(write_wen_reg && INDEX==write_way) || read_clkEn_reg;
  
  assign read_data0=read_hit ? read_data_ram[`dwtlb_data1] : {OUTDATA_WIDTH{{1{1'bz}}}};
  assign read_data1=read_hit ? read_data_ram[`dwtlb_data2] : {OUTDATA_WIDTH{{1{1'bz}}}};
  assign write_data_new[`dwtlb_ip]=addr_reg;
  assign write_data_new[`dwtlb_valid]=1'b1;
  assign write_data_new[`dwtlb_data1]=write_data0_reg;
  assign write_data_new[`dwtlb_data2]=write_data1_reg;
  assign write_data_new[`dwtlb_lru]=2'b11;

  assign write_data_same[`dwtlb_ip]=ip;
  assign write_data_same[`dwtlb_valid]=valid;
  assign write_data_same[`dwtlb_data1]=read_data_ram[`dwtlb_data1];
  assign write_data_same[`dwtlb_data2]=read_data_ram[`dwtlb_data2];

  assign write_data_same[`dwtlb_lru]=newLRU;
  
  
  assign write_data_ram=write_wen_reg ? write_data_new : write_data_same;
  
  dtlb_ram ram_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(read_clkEn),
  .read_addr(addr[17:13]),
  .read_data(read_data_ram),
  .write_addr(addr_reg[17:13]),
  .write_data(write_data_ram),
  .write_wen(write_wen_ram)
  );

  always @(posedge clk)
    begin
	  if (rst)
	    begin
		  write_wen_reg<=1'b0;
		  addr_reg<={ADDR_WIDTH{1'B0}};
		  write_data0_reg<={OUTDATA_WIDTH{1'B0}};
		  write_data1_reg<={OUTDATA_WIDTH{1'B0}};
		end
	  else
	    begin
		  addr_reg<=addr;
		  write_wen_reg<=write_wen;
		  write_data0_reg<=write_data0;
		  write_data1_reg<=write_data1;
		end
    end
  
endmodule




