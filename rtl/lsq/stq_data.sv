`include "../struct.sv"

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
        end
    end
  endgenerate
endmodule  
