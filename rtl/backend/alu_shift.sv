`include "../struct.sv"
`include "../operations.sv"




module alu_shift(
  clk,
  rst,
  except,
  except_thread,
  operation,
  sz,bit_en,arith,dir,
  dataEn,
  nDataAlt,
  retData,
  valS,
  val1,
  val2,
  valRes
  );

  parameter REG_WIDTH=`reg_addr_width;
  parameter OPERATION_WIDTH=`operation_width;
  parameter EXCEPT_WIDTH=9;
  
  input clk;
  input rst;
  input except;
  input except_thread;
  input [OPERATION_WIDTH-1:0] operation;
  input [3:0] sz;
  input [3:0] bit_en;
  input arith;
  input dir;
  input dataEn;//1=coming data from rs
  input nDataAlt;//0=feeding data through multiclk unit
  output wire [EXCEPT_WIDTH-1:0] retData;
  input [5:0] valS;
  input [63:0] val1;
  input [63:0] val2;
  output [63:0] valRes;
  
  wire is_shift;
  wire is_8H;
  wire [63:0] valres0;
  wire [7:0] valres1;  
  reg is_shift_reg;
  reg [3:0] coutL_reg;
  reg coutR_reg;
  reg [63:0] valres0_reg;
  reg dir_reg;
  wire coutR;
  wire [3:0] coutL;
  wire [5:0] flags_COASZP;
  reg [3:0] sz_reg;

  assign is_shift=(operation[7:2]==6'd5 || operation[7:2]==6'd6 || operation[7:2]==6'd7) && nDataAlt && ~operation[11];
  
  shlr #(64) main_shift_mod(
  bit_en,
  sz,
  dir,
  arith,
  val1,
  val2[5:0],
  valres0,
  coutR,
  coutL
  );

  assign valRes[31:0]=is_shift ? valres0[31:0] : 32'bz;
  assign valRes[63:32]=is_shift&~operation[1] ? valres0[63:32] : 32'bz;
  assign valRes[63:32]=is_shift&operation[1] ? {32{valres0[31]}} : 32'bz;

  assign retData[`except_flags]=is_shift_reg ? flags_COASZP : 6'bz;

  assign flags_COASZP={ dir_reg ? coutR_reg : ((coutL_reg&sz_reg)!=0),1'b0,1'b0,
	  sz_reg[3] ? valres0_reg[63] : valres0_reg[31],~(|valres0_reg[31:0])&&
          (~sz_reg[3]||~(|valres0_reg[63:32])),~^valres0_reg[7:0]};

  always @(posedge clk) begin
      is_shift_reg<=is_shift;
      coutL_reg<=coutL;
      coutR_reg<=coutR;
      valres0_reg<=valres0;
      dir_reg<=dir;
      sz_reg<=sz;
  end
endmodule





