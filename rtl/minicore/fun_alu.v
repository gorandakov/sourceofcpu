
module alu_block(
  clk,
  rst,
  stall,
  do_stall,
  do_split,
  alu0_index,alu0_en,alu0_rA,alu0_rB,alu0_rT,alu0_flwen,alu0_wen,alu0_op,alu0_cond,
  alu1_index,alu1_en,alu1_rA,alu1_rB,alu1_rT,alu1_flwen,alu1_wen,alu1_op,alu1_cond,
  alu2_index,alu2_en,alu2_rA,alu2_rB,alu2_rT,alu2_flwen,alu2_wen,alu2_op,alu2_cond,
  ld0_index,ld0_rT,ld0_wen,
  ld1_index,ld1_rT,ld1_wen,
  ld2_index,ld2_rT,ld2_wen,
  wrA0_data,wrA0_wen,
  wrA1_data,wrA1_wen,
  wrA2_data,wrA2_wen
);
  input clk;
  input rst;
  input stall;
  output do_stall;
  output [2:0] do_split;
  input [1:0] alu0_index;
  input       alu0_en;
  input [5:0] alu0_rA;
  input [5:0] alu0_rB;
  input [5:0] alu0_rT;
  input       alu0_flwen;
  input       alu0_wen;
  input [12:0]alu0_op;
  input [4:0] alu0_cond;
  input [1:0] alu1_index;
  input       alu1_en;
  input [5:0] alu1_rA;
  input [5:0] alu1_rB;
  input [5:0] alu1_rT;
  input       alu1_flwen;
  input       alu1_wen;
  input [12:0]alu1_op;
  input [4:0] alu1_cond;
  input [1:0] alu2_index;
  input       alu2_en;
  input [5:0] alu2_rA;
  input [5:0] alu2_rB;
  input [5:0] alu2_rT;
  input       alu2_flwen;
  input       alu2_wen;
  input [12:0]alu2_op;
  input [4:0] alu2_cond;
  input [1:0] ld0_index;
  input [5:0] ld0_rT;
  input ld0_wen'
  input [1:0] ld1_index;
  input [5:0] ld1_rT;
  input ld1_wen;
  output [64:0] wrA0_data;
  output wrA0_wen;
  output [64:0] wrA1_data;
  output wrA1_wen;
  output [64:0] wrA2_data;
  output wrA2_wen;

`define aluneg
  alu alu0(clk,rst,except,except_thread,thread,operation[0],cond[0],sub[0],cary_invert[0],dataEn[0],nDataAlt[0],retData[0],retEn[0],
    val1,val2,valS,valRes,valRes_N);
  alu_shift shf0(clk,rst,except,except_thread,operation[0],cond[0],sz[0],bit_en[0],arith[0],dir[0],dataEn[0],nDataAlt[0],
    retData[0], valS, val1, val2, valRes);
  alu alu2(clk,rst,except,except_thread,thread,operation[2],cond[2],sub[2],cary_invert[2],dataEn[2],nDataAlt[2],retData[2],retEn[2],
    val1Y,val2Y,valSY,valResY,valResY_N);
  alu_shift shf2(clk,rst,except,except_thread,operation[2],cond[2],sz[2],bit_en[2],arith[2],dir[2],dataEn[2],nDataAlt[2],
    retData[2], valSY, val1Y, val2Y, valRes);
`undef aluneg
  alu alu1(clk,rst,except,except_thread,thread,operation_reg[1],cond_reg[1],sub_reg[1],cary_invert_reg[1],dataEn_reg[1],
    nDataAlt_reg[1],retData[1],retEn[1], val1X,val2X,valSX,valResX,valResX_N);
  alu_shift shf1(clk,rst,except,except_thread,operation_reg[1],cond_reg[1],sz_reg[1],bit_en_reg[1],arith_reg[1],dir_reg[1],
   dataEn_reg[1],nDataAlt_reg[1], retData[1], valSX, val1X, val2X, valResX);

  always @(negedge clk) begin
    if (A_dep_alu[1]) val1X<=valRes;
    else if (A_dep_ld0[1]) val1X<=valLD0;
    else if (A_dep_ld1[1]) val1X<=valLD1;
    else val1X<=dataA1;
    if (B_dep_alu[1]) val2X<=valRes;
    else if (B_dep_ld0[1]) val2X<=valLD0;
    else if (B_dep_ld1[1]) val2X<=valLD1;
    else val2X<=dataB1;
    if S_dep_alu[1] valSX<=retData[0][8:3];
    else if S_depY_alu[1] valSX<=retData[2][8:3];
  end
  always @(posedge clk) begin
    if (A_dep_alu[0]) val1<=valResX;
    else if (A_dep_ld0[0]) val1<=valLD0;
    else if (A_dep_ld1[0]) val1<=valLD1;
    else val1<=dataA0;
    if (B_dep_alu[0]) val2<=valResX;
    else if (B_dep_ld0[0]) val2<=valLD0;
    else if (B_dep_ld1[0]) val2<=valLD1;
    else val2<=dataB0;
    valS<=S_dep_alu[0] ? retData[1][8:3] : valSX;
    (A_dep_ld0[2]) val1Y<=valLD0;
    else if (A_dep_ld1[2]) val1Y<=valLD1;
    else val1Y<=dataA2;
    if (B_dep_ld0[2]) val2Y<=valLD0;
    else if (B_dep_ld1[2]) val2Y<=valLD1;
    else val2Y<=dataB2;
  end

  alu_regfile regf(
  clk,
  rst,
  stall,
  readA0_addr,dataA0,
  readA1_addr,dataA1,
  readA2_addr,dataA2,
  readB0_addr,dataB0,
  readB1_addr,dataB1,
  readB2_addr,dataB2,
  write0_addr,valResX,write0_wen,
  write1_addr,valRes,write1_wen,
  write2_addr,valLD0,write2_wen,
  write3_addr,valLD1,write3_wen,
  write4_addr,valLD2,write4_wen,
  write5_addr,valResY,write5_wen
  );

  always @* begin
    if (alu1_rA=={1'b1,3'b100,alu0_index} || alu1_rB=={1'b1,3'b100,alu0_index} && alu1_wen && alu0_wen) begin
    end else if (alu2_rA=={1'b1,3'b100,alu0_index} || alu2_rB=={1'b1,3'b100,alu0_index} && alu2_wen && alu0_wen) begin
    end else if (alu2_rA=={1'b1,3'b100,alu1_index} || alu2_rB=={1'b1,3'b100,alu1_index} && alu2_wen && alu1_wen) begin
    end else if (!alu2_wen) begin
    end else begin
    end
    alu_alu_dual_dep=(alu1_rA=={1'b1,3'b100,alu0_index} || alu1_rB=={1'b1,3'b100,alu0_index} && alu1_wen && alu0_wen) && (
      (alu2_rA=={1'b1,3'b100,alu0_index} || alu2_rB=={1'b1,3'b100,alu0_index} && alu2_wen && alu0_wen) ||
      (alu2_rA=={1'b1,3'b100,alu1_index} || alu2_rB=={1'b1,3'b100,alu1_index} && alu2_wen && alu1_wen));
  end

endmodule

module alu_regfile(
  clk,
  rst,
  stall,
  readA0_addr,readA0_data,
  readA1_addr,readA1_data,
  readA2_addr,readA2_data,
  readB0_addr,readB0_data,
  readB1_addr,readB1_data,
  readB2_addr,readB2_data,
  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen,
  write2_addr,write2_data,write2_wen,
  write3_addr,write3_data,write3_wen,
  write4_addr,write4_data,write4_wen,
  write5_addr,write5_data,write5_wen);

  input clk;
  input rst;
  input stall;
  input [4:0]   readA0_addr;
  output [65:0] readA0_data;
  input [4:0]   readA1_addr;
  output [65:0] readA1_data;
  input [4:0]   readA2_addr;
  output [65:0] readA2_data;
  input [4:0]   readB0_addr;
  output [65:0] readB0_data;
  input [4:0]   readB1_addr;
  output [65:0] readB1_data;
  input [4:0]   readB2_addr;
  output [65:0] readB2_data;
  input [4:0]   write0_addr;
  input  [65:0] write0_data;
  input         write0_wen;
  input [4:0]   write1_addr;
  input  [65:0] write1_data;
  input         write1_wen;
  input [4:0]   write2_addr;
  input  [65:0] write2_data;
  input         write2_wen;
  input [4:0]   write3_addr;
  input  [65:0] write3_data;
  input         write3_wen;
  input [4:0]   write4_addr;
  input  [65:0] write4_data;
  input         write4_wen;
  input [4:0]   write5_addr;
  input  [65:0] write5_data;
  input         write5_wen;

  reg [65:0] ram[19:0];

  reg [4:0] readA0_addr_reg;
  reg [4:0] readB0_addr_reg;
  reg [4:0] readA1_addr_reg;
  reg [4:0] readB1_addr_reg;
  reg [4:0] readA2_addr_reg;
  reg [4:0] readB2_addr_reg;

 
  
  always @(posedge clk) begin
      if (!stall) begin
          readA0_addr_reg<=readA0_addr;
          readB0_addr_reg<=readB0_addr;
          readA2_addr_reg<=readA2_addr;
          readB2_addr_reg<=readB2_addr;
      end
      if (write1_wen) ram[write1_addr]<=write1_data;
      if (write2_wen) ram[write2_addr]<=write2_data;
      if (write3_wen) ram[write3_addr]<=write3_data;
      if (write4_wen) ram[write4_addr]<=write4_data;
      if (write5_wen) ram[write5_addr]<=write5_data;
  end
  always @(negedge clk) begin
      if (!stall) begin
          readA1_addr_reg<=readA1_addr;
          readB1_addr_reg<=readB1_addr;
      end
      if (write0_wen) ram[write0_addr]<=write0_data;
  end
endmodule
