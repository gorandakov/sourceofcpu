
module alu_block();

  alu alu0(clk,rst,except,except_thread,thread,operation[0],cond[0],sub[0],cary_invert[0],dataEn[0],nDataAlt[0],retData[0],retEn[0],
    val1,val2,valS,valRes,valRes_N);
  alu alu1(clk,rst,except,except_thread,thread,operation_reg[1],cond_reg[1],sub_reg[1],cary_invert_reg[1],dataEn_reg[1],
    nDataAlt_reg[1],retData[1],retEn[1], val1X,val2X,valSX,valResX,valResX_N);

  always @(negedge clk) begin
    if (A_dep_alu[1]) val1X<=valRes;
    else if (A_dep_ld0[1]) val1X<=valLD0;
    else if (A_dep_ld1[1]) val1X<=valLD1;
    else val1X<=dataA1;
    if (B_dep_alu[1]) val2X<=valRes;
    else if (B_dep_ld0[1]) val2X<=valLD0;
    else if (B_dep_ld1[1]) val2X<=valLD1;
    else val2X<=dataB1;
  end
  always @(posedge clk) begin
    if (A_dep_alu[1]) val1<=valResX;
    else if (A_dep_ld0[1]) val1<=valLD0;
    else if (A_dep_ld1[1]) val1<=valLD1;
    else val1<=dataA0;
    if (B_dep_alu[1]) val2<=valResX;
    else if (B_dep_ld0[1]) val2<=valLD0;
    else if (B_dep_ld1[1]) val2<=valLD1;
    else val2<=dataB0;
  end

endmodule

module alu_regfile(
  clk,
  rst,
  stall,
  readA0_addr,readA0_data,
  readA1_addr,readA1_data,
  readB0_addr,readB0_data,
  readB1_addr,readB1_data,
  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen,
  write2_addr,write2_data,write2_wen,
  write3_addr,write3_data,write3_wen);

  input clk;
  input rst;
  input stall;
  input [4:0]   readA0_addr;
  output [64:0] readA0_data;
  input [4:0]   readA1_addr;
  output [64:0] readA1_data;
  input [4:0]   readB0_addr;
  output [64:0] readB0_data;
  input [4:0]   readB1_addr;
  output [64:0] readB1_data;
  input [4:0]   write0_addr;
  input  [64:0] write0_data;
  input         write0_wen;
  input [4:0]   write1_addr;
  input  [64:0] write1_data;
  input         write1_wen;
  input [4:0]   write2_addr;
  input  [64:0] write2_data;
  input         write2_wen;
  input [4:0]   write3_addr;
  input  [64:0] write3_data;
  input         write3_wen;
endmodule
