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

`include "../../rtl/struct.sv"


module heptane_cores(
  input clk,
  input rst,
  input IRQ,
  input [16:0] IRQ_data,
  input IRQ_thr,
  input [67:0] obusIn,
  output [81:0] obusOut,
  inout obusOut_want,
  output obusOut_can,
  input [37:0] obusDIns,
  input [511+56:0] obusDIn_data,
  output [511+56:0] obusDOut_dataAUD,
  output [75:0] obusDOut_iosig,
  output obusDOut_can,
  inout obusDOut_want,
  output obusDOut_replay
);
  parameter [2:0] IDX;
  parameter [7:0][4:0] BUS_ID=0;
  parameter [7:0][5:0] BUS_ID2=0;

  localparam PHYS_WIDTH=44;
  localparam VIRT_WIDTH=64;
  localparam IP_WIDTH=48;
  localparam [31:0] INIT_IP=32'h20;
  localparam BUS_BANK=32;
  localparam BUS_WIDTH=BUS_BANK*16;
  localparam DATA_WIDTH=65*4;
  localparam INSTR_WIDTH=80;
  localparam IN_REG_WIDTH=6;
  localparam OPERATION_WIDTH=`operation_width+5;
  localparam PORT_WIDTH=4;
  localparam RS_WIDTH=65;
  localparam REQ_WIDTH=10;

  generate
    genvar core_IDX;
    for(core_IDX=0;core_IDX<7;core_IDX=core_IDX+1) begin : cores
      heptane_core unit_mod(
      clk,
      rst,
      IRQ[core_IDX],
      IRQ_data,
      IRQ_thr,
      obusInX_reg[(core_IDX-1)&7],
      obusInX[core_IDX],
      obusInX_want[(core_IDX+1)&7],
      obusInX_can_reg[(core_IDX+1)&7],
      obusDInsX_reg[core_IDX],
      obusDInX_data_reg[core_IDX],
      obusDInX_data[core_IDX+1],
      obusDInsX[core_IDX+1],
  output obusDOut_can,
  inout obusDOut_want,
  output obusDOut_replay
);
    end
  endgenerate

endmodule



