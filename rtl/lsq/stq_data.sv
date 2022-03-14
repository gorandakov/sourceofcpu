`include "../struct.sv"
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
module stq_data(
  clk,
  rst,
  wrt0_en,wrt0_data,
  wrt1_en,wrt1_data,
  chk0_en,chk0_data,
  chk1_en,chk1_data,
  chk2_en,chk2_data,
  chk3_en,chk3_data,
  chk4_en,chk4_data,
  chk5_en,chk5_data)
  parameter WIDTH=32;
  input clk;
  input rst;
  input wrt0_en;
  input [WIDTH-1:0] wrt0_data;
  input wrt1_en;
  input [WIDTH-1:0] wrt1_data;
  input chk0_en;
  output [WIDTH-1:0] chk0_data;
  input chk1_en;
  output [WIDTH-1:0] chk1_data;
  input chk2_en;
  output [WIDTH-1:0] chk2_data;
  input chk3_en;
  output [WIDTH-1:0] chk3_data;
  input chk4_en;
  output [WIDTH-1:0] chk4_data;
  input chk5_en;
  output [WIDTH-1:0] chk5_data;
  
  assign chk0_data=chk0_en ? data : {WIDTH{1'bz}};
  assign chk1_data=chk1_en ? data : {WIDTH{1'bz}};
  assign chk2_data=chk2_en ? data : {WIDTH{1'bz}};
  assign chk3_data=chk3_en ? data : {WIDTH{1'bz}};
  assign chk4_data=chk4_en ? data : {WIDTH{1'bz}};
  assign chk5_data=chk5_en ? data : {WIDTH{1'bz}};
  
  always @(posedge clk) begin
      if (wrt0_en) data<=wrt0_data;
      if (wrt1_en) data<=wrt1_data;
  end
  
endmodule  
  

module stq_data_array(
  clk,
  rst,
  wrt0_en,wrt0_data,
  wrt1_en,wrt1_data,
  chk0_en,chk0_data,
  chk1_en,chk1_data,
  chk2_en,chk2_data,
  chk3_en,chk3_data,
  chk4_en,chk4_data,
  chk5_en,chk5_data)
  parameter WIDTH=32;
  localparam BUF_COUNT=64;
  input clk;
  input rst;
  input [BUF_COUNT-1:0] wrt0_en;
  input [WIDTH-1:0] wrt0_data;
  input [BUF_COUNT-1:0] wrt1_en;
  input [WIDTH-1:0] wrt1_data;
  input [BUF_COUNT-1:0] chk0_en;
  output [WIDTH-1:0] chk0_data;
  input [BUF_COUNT-1:0] chk1_en;
  output [WIDTH-1:0] chk1_data;
  input [BUF_COUNT-1:0] chk2_en;
  output [WIDTH-1:0] chk2_data;
  input [BUF_COUNT-1:0] chk3_en;
  output [WIDTH-1:0] chk3_data;
  input [BUF_COUNT-1:0] chk4_en;
  output [WIDTH-1:0] chk4_data;
  input [BUF_COUNT-1:0] chk5_en;
  output [WIDTH-1:0] chk5_data;
  
  generate
    genvar bank,row;
    for(bank=0;bank<8;bank=bank+1) begin : bnk_gen
        wire [WIDTH-1:0] chk0_dataK;
        wire [WIDTH-1:0] chk1_dataK;
        wire [WIDTH-1:0] chk2_dataK;
        wire [WIDTH-1:0] chk3_dataK;
        wire [WIDTH-1:0] chk4_dataK;
        wire [WIDTH-1:0] chk5_dataK;
        for(row=0;row<8;row=row+1) begin : row_gen
            stq_data(
            clk,
            rst,
            wrt0_en[bank*8+row],wrt0_data,
            wrt1_en[bank*8+row],wrt1_data,
            chk0_en[bank*8+row],chk0_dataK,
            chk1_en[bank*8+row],chk1_dataK,
            chk2_en[bank*8+row],chk2_dataK,
            chk3_en[bank*8+row],chk3_dataK,
            chk4_en[bank*8+row],chk4_dataK,
            chk5_en[bank*8+row],chk5_dataK);
        end
        assign chk0_dataK=|chk0_en[bank*8+:8] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
        assign chk1_dataK=|chk1_en[bank*8+:8] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
        assign chk2_dataK=|chk2_en[bank*8+:8] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
        assign chk3_dataK=|chk3_en[bank*8+:8] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
        assign chk4_dataK=|chk4_en[bank*8+:8] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};
        assign chk5_dataK=|chk5_en[bank*8+:8] ? {WIDTH{1'BZ}} : {WIDTH{1'B0}};

        assign chk0_data=|chk0_en[bank*8+:8] ? chk0_dataK : {WIDTH{1'BZ}};
        assign chk1_data=|chk1_en[bank*8+:8] ? chk1_dataK : {WIDTH{1'BZ}};
        assign chk2_data=|chk2_en[bank*8+:8] ? chk2_dataK : {WIDTH{1'BZ}};
        assign chk3_data=|chk3_en[bank*8+:8] ? chk3_dataK : {WIDTH{1'BZ}};
        assign chk4_data=|chk4_en[bank*8+:8] ? chk4_dataK : {WIDTH{1'BZ}};
        assign chk5_data=|chk5_en[bank*8+:8] ? chk5_dataK : {WIDTH{1'BZ}};
    end
  endgenerate
endmodule  
