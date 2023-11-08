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
  readA_clkEn,
  readA_addr,
  readA_data,
  writeA_wen,
  writeA_addr,
  writeA_data,
  writeB_wen,
  writeB_addr,
  writeB_data
  );
  localparam WIDTH=`lsaddr_width+1;//adata+en
  
  input clk;
  input rst;
  input read_clkEn;
  input [5:0] read_addr;
  output [WIDTH-1:0] read_data;
  input write_wen;
  input [5:0] write_addr;
  input [WIDTH-1:0] write_data;

  reg [WIDTH-1:0] ram[63:0];
  reg [5:0] readA_addr_reg;

  assign readA_data=ram[readA_addr_reg];

  always @(posedge clk) begin
      if (rst) readA_addr_reg<=6'b0;
      else if (readA_clkEn) readA_addr_reg<=readA_addr;
      if (writeA_wen) ram[writeA_addr]<=writeA_data;
      if (writeB_wen) ram[writeB_addr]<=writeB_data;
  end
endmodule

