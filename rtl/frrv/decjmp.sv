`include "../struct.sv"
`include "../operations.sv"
`include "../memop.sv"


module jump_decoder(
  clk,
  rst,
  mode64,
  instr,
  class_,
  constant,
  
  pushCallStack,
  popCallStack,
  isJump,
  jumpType,
  jumpIndir,
  isIPRel
  );
  
  localparam INSTR_WIDTH=32;
  localparam INSTRQ_WIDTH=`instrQ_width;
  localparam OPERATION_WIDTH=`operation_width;
  localparam REG_WIDTH=6;
  localparam IP_WIDTH=64;
  localparam PORT_LOAD=3'd1;
  localparam PORT_STORE=3'd2;
  localparam PORT_SHIFT=3'd3;
  localparam PORT_ALU=3'd4;
  localparam PORT_MUL=3'd5;
  
  input clk;
  input rst;
  input mode64;
  
  input [INSTR_WIDTH-1:0] instr;
  input [11:0] class_;
  
  output reg [63:0] constant;
  
  output reg pushCallStack;
  output reg popCallStack;
  output isJump;
  output reg [4:0] jumpType;
  output jumpIndir;
  
  output reg isIPRel;
  
  wire [7:0] opcode_main;

  reg error;
  
  reg keep2instr;
  
  wire [31:0] constantDef;


  reg isBigConst;

  
  
  
  always @*
  begin
      constant[31:0]=constantDef;
      constant[63:32]={32{constant[31]}};
      isIPRel=1'b0;
      error=1'b0; 
      jumpType=5'b10000;
      pushCallStack=1'b0;
      popCallStack=1'b0;

  end


endmodule

