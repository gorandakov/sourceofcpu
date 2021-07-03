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

  //assign subIsBasicLDST=instr[14:13]!=2'b0 && instr[1:0]==2'b0;
  //assign subIsStackLDST=instr[14:13]!=2'b0 && instr[1:0]==2'b10 && !(intr[15:14]=2'b01 && instr[11:7]==5'b0);
  
  assign subIsBasicImmAluReg5=(instr[1:0]==2'b01 && (instr[15:13]==3'b0 || (instr[15:13]==3'b1 &&
   instr[11:7]!=5'b0) || (instr[15:14]==2'b1 && instr[11:7]!=5'b0 && 
   instr[12]| |instr[6:2] |~instr[13])))||(instr[1:0]==2'b10 && instr[15:13]==3'b0 && instr[11:7]!=5'b0);  
  //assign subIs2xReg5Alu=instr[1:0]==2'b10 && instr[15:13]==3'b100;
  //assign subIsReg3Alu=instr[1:0]==2'b1 && instr[15:13]==3'b100 && !(instr[12:10]==3'b111 && instr[6]);
  assign subIsJMP=instr[1:0]==2'b1 && (instr[15:13]==3'b101 || instr[15:14]==2'b11);

  //assign isLoad=opcode_main[6:3]==4'b0 && opcode_main[1:0]==2'b11;
  //assign isStore=opcode_main[6:3]==4'b0100 && opcode_main[1:0]==2'b11;
  //assign isBasicALU=!opcode_main[6] && opcode_main[4:2]==3'b100 && opcode_main[1:0]==2'b11;
  //assign isBasicALU32=!opcode_main[6] && opcode_main[4:2]==3'b110 && opcode_main[1:0]==2'b11;
  assign isAdvALUorJump=(instr[6:5]==2'b11 && !instr[4] && instr[2] && !(!instr[3] && instr[14:12]!=3'b0)) |
	  (!instr[6] && instr[4:2]==3'b101) && opcode_main[1:0]==2'b11;
  //assign isOpFp=instr[6:2]==5'b10100 && opcode_main[1:0]==2'b11;
  //assign isFpFma=opcode_main[6:4]==2'b100 && opcode_main[1:0]==2'b11;
  assign isJump=opcode_main[6:0]==7'b1100011;
  assign isSys=opcode_main[6:0]==7'b1110011;

  
  
  
  always @*
  begin
      constant[31:0]=constantDef;
      constant[63:32]={32{constant[31]}};
      isIPRel=1'b0;
      error=1'b0; 
      jumpType=5'b10000;
      pushCallStack=1'b0;
      popCallStack=1'b0;
      if (isJump) begin
          pconstant[7]={{52{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};
	  isIPRel=1'b1;
          casex(instr[14:12])
              3'b00x: jumptype={4'b0,instr[12]};
              3'b100: jumptype=5'd11;
	      3'b101: jumptype=5'd10;
	      3'b110: jumptype=5'd7;
	      3'b111: jumptype=5'd6;
          endcase
      end else if (subIsJMP) begin
          if (instr[15:14]==2'b11) begin
	      jump_type={4'b0,instr[13]};
	      is_jump=1'b1;
	      constant={{56{instr[12]}},instr[6:5],instr[2],instr[11:10],instr[4:3],1'b0};
          end else if (instr[15:14]) begin
	      is_jump=1'b1;
	      jump_type=5'h10;
	      constant={{54{instr[12]}},instr[10:9],instr[6],instr[7],instr[2],instr[11],instr[5:3],1'b0};
          end
      end else if (subIs2xReg5Alu) begin
          casex({instr[12],instr[11:7]!=0,instr[6:2]!=0})
	  3'b010: begin
	      jump_type=5'h11;
	      is_jump=1'b1;
	  end
	  3'b110: begin
	      jump_type=5'h11;
	      is_jump=1'b1;
	      constant={32'b0,32'd4};
	      isIPRel=1'b1;
	  end
          endcase
      end else if (isAdvALUorJump) begin
          case(instr[6:2])
          5'b11011: begin
	      constant=64'd4;
	      isIPRel=1'b1;
	      is_jump=1'b1;
	      jump_type=5'b10000;
	  end
	  5'b11001: begin
	      constant={{12{instr[31]}},instr[31:12],32'd4};
	      isIPRel=1'b1;
	      is_jump=1'b1;
	      jump_type=5'b11000;
	  end
          endcase
     end

  end


endmodule

