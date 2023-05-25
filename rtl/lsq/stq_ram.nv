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
module stq_adata_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_wen,
  write_addr,
  write_data);
  localparam WIDTH=`lsaddr_width+1;//adata+en
  
  input clk;
  input rst;
  input read_clkEn;
  input [4:0] read_addr;
  output [WIDTH-1:0] read_data;
  input write_wen;
  input [4:0] write_addr;
  input [WIDTH-1:0] write_data;

  reg [WIDTH-1:0] ram[31:0];
  reg [4:0] read_addr_reg;

  assign read_data=ram[read_addr_reg];

  always @(posedge clk) begin
      if (rst) read_addr_reg<=5'b0;
      else if (read_clkEn) read_addr_reg<=read_addr;
      if (write_wen) ram[write_addr]<=write_data;
  end
endmodule
