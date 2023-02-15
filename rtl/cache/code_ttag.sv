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

`include "../common.sv"


module ttag_ram(
  clk,
  rst,
  read_clkEn,
  read_data,
  read_addr,
  write_wen,
  write_data,
  write_addr);
  localparam DATA_WIDTH=`ttag_width;
  `ifdef ICACHE_256K
  localparam ADDR_WIDTH=8;
  localparam ADDR_COUNT=256;
  `else
  localparam ADDR_WIDTH=7;
  localparam ADDR_COUNT=128;
  `endif
  
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


module ttag(
  clk,
  rst,
  read_clkEn,
  read_IP,
  read_enOut,
  read_IP_next,
  write_IP,
  write_wen,
  write_way,
  write_rand,
  flush_all,
  doStall);

  parameter [2:0] INDEX=0;
  localparam DATA_WIDTH=`ttag_width;
  input clk;
  input rst;
  input read_clkEn;
  input [43:0] read_IP;
  output [3:0] read_enOut;
  output [43:0] read_IP_next;
  input [43:0] write_IP;
  input [1:0] write_way;
  input [4:0] write_rand;
  input flush_all;
  output reg doStall;

  reg [43:0] read_IP_reg;
  reg [43:0] write_IP_reg;
  reg write_wen_reg;
  reg [1:0] write_way_reg;

  reg flush_in_progress;

  wire [DATA_WIDTH-1:0] read_dataP;
  wire [DATA_WIDTH-1:0] write_data;

  generate
      genvar t;
      for(t=0;t<3;t=t+1) begin : rams_gen
          ttag_ram ram_mod(
          clk,
          rst,
          read_clkEn,
          read_dataP[t],
  `ifdef ICACHE_256K
          read_IP[14:7],
  `else
          read_IP[13:7],
  `endif 
          (write_wen_reg && write_way_reg==t) | flush_in_progress,
          write_data,
  `ifdef ICACHE_256K
          write_IP_reg[14:7]
  `else 
          write_IP_reg[13:7]
  `endif
          );
          assign read_enOut[t]=read_dataP[t][`ttag_IP_lower]==read_IP_reg[6:0] &&
              read_dataP[t][`ttag_IP_upper]==read_IP_reg[43:14] && 
              read_dataP[t][`ttag_valid];
          adder #(6) IP_inc_mod(read_IP_reg[5:0],read_dataP[t][`ttag_br],read_IP_next[5:0],read_enOut[t],c_IP[t],,,);
          adder_inc #(38) IP_inc2_mod(read_IP_reg[43:6],read_IP_next[43:6],c_IP[t]&read_enOut[t],);
          assign read_IP_next[43:6]=~c_IP[t]&read_enOut[t] ? read_IP_reg[43:6] : 38'b0;

      end
  endgenerate

  assign read_IP_next=read_enOut ? {44{1'bz}} : 44'b0;

  assign write_data[`ttag_IP_lower]=write_IP_reg[6:0];
  assign write_data[`ttag_IP_upper]=write_IP_reg[43:14];
  assign write_data[`ttag_valid]=~flush_in_progress;

  always @(posedge clk) begin
      if (rst) begin
          read_IP_reg<=44'b0;
      end else if (read_clkEn) begin
          read_IP_reg<=read_IP;
      end
      read_clkEn_reg<=read_clkEn;
  end
endmodule


