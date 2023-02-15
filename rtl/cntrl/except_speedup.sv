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

`include "../common.v"


module cntrl_speedup(
  clk,
  rst,
  except,
  read_clkEn,
  read_addr,
  read_data_in,
  read_data,
  write_addr,
  write_data,
  write_wen);
  localparam ADDR_WIDTH=6;
  localparam DATA_WIDTH=`except_width;
  input clk;
  input rst;
  input except;
  input read_clkEn;
  input [ADDR_WIDTH-1:0] read_addr;
  input [DATA_WIDTH-1:0] read_data_in;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;


  reg [DATA_WIDTH-1:0] data[5:0];
  reg [ADDR_WIDTH-1:0] addr[5:0];
  reg [5:0] match;
  reg [ADDR_WIDTH-1:0] read_addr_reg;
  integer k,k1;

  assign read_data0=match[0] ? data[0] : {DATA_WIDTH{{1{1'bz}}}};
  assign read_data0=match[1] ? data[1] : {DATA_WIDTH{{1{1'bz}}}};
  assign read_data0=match[2] ? data[2] : {DATA_WIDTH{{1{1'bz}}}};
  assign read_data0=match[3] ? data[3] : {DATA_WIDTH{{1{1'bz}}}};
  assign read_data0=match[4] ? data[4] : {DATA_WIDTH{{1{1'bz}}}};
  assign read_data0=(!match[4:0]) ? data[5] : {DATA_WIDTH{{1{1'bz}}}};
  assign read_data=(match) ? read_data0 : read_data_in;

  always @* begin
    for(k1=0;k1<6;k1=k1+1) match[k1]=addr[k1]==read_addr_reg;
  end

  always @(posedge clk) begin
    if (rst) begin
        for(k=0;k<6;k=k+1) begin
            addr[k]<=6'h3f;
            data[k]<=0;
        end
        read_addr_reg<=0;
    end else if (except) begin
        for(k=0;k<6;k=k+1) begin
            addr[k]<=6'h3f;
            data[k]<=0;
        end
    end else begin
        for(k=0;k<6;k=k+1) begin
            if (k) addr[k]<=addr[k-1];
            addr[0]<=write_wen ? write_addr : 6'h3f;
            if (k) data[k]<=data[k-1];
            data[0]<=write_wen ? write_data : 0;
            if (k<5) if (match[k] && read_clkEn) addr[k+1]<=6'h3f;
        end
        if (read_clkEn) read_addr_reg<=read_addr;
    end

  end
endmodule
