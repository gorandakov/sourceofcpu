`include "../struct.sv"



module rs_write_forward(
  clk,rst,
  stall,
  oldData,newData,
  oldDataN,newDataN,
  fuFwd,fuuFwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  parameter DATA_WIDTH=`alu_width;
  input clk;
  input rst;
  input stall;
  
  input [DATA_WIDTH-1:0] oldData;
  output reg [DATA_WIDTH-1:0] newData;
  input [DATA_WIDTH-1:0] oldDataN;
  output reg [DATA_WIDTH-1:0] newDataN;
  input [3:0] fuFwd;
  input [3:0] fuuFwd;
  
  input [DATA_WIDTH-1:0] FU0;
  input [DATA_WIDTH-1:0] FU0_reg;
  input [DATA_WIDTH-1:0] FU1;
  input [DATA_WIDTH-1:0] FU1_reg;
  input [DATA_WIDTH-1:0] FU2;
  input [DATA_WIDTH-1:0] FU2_reg;
  input [DATA_WIDTH-1:0] FU3;
  input [DATA_WIDTH-1:0] FU3_reg;
  input [DATA_WIDTH-1:0] FU4;
  input [DATA_WIDTH-1:0] FU4_reg;
  input [DATA_WIDTH-1:0] FU5;
  input [DATA_WIDTH-1:0] FU5_reg;
  input [DATA_WIDTH-1:0] FU6;
  input [DATA_WIDTH-1:0] FU6_reg;
  input [DATA_WIDTH-1:0] FU7;
  input [DATA_WIDTH-1:0] FU7_reg;
  input [DATA_WIDTH-1:0] FU8;
  input [DATA_WIDTH-1:0] FU8_reg;
  input [DATA_WIDTH-1:0] FU9;
  input [DATA_WIDTH-1:0] FU9_reg;

  wire [DATA_WIDTH-1:0] newData_d;
  wire [DATA_WIDTH-1:0] newDataN_d;
  wire [DATA_WIDTH-1:0] newDataFu_d;
  wire [DATA_WIDTH-1:0] newDataFuu_d;
  
  assign newDataFu_d=(fuFwd==4'd0) ? FU0 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd0) ? FU0_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd1) ? FU1 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd1) ? FU1_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd2) ? FU2 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd2) ? FU2_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd3) ? FU3 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd3) ? FU3_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd4) ? FU4 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd4) ? FU4_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd5) ? FU5 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd5) ? FU5_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd6) ? FU6 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd6) ? FU6_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd7) ? FU7 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd7) ? FU7_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd8) ? FU8 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd8) ? FU8_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd[3] && |fuFwd[2:0]) ? FU9 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd[3] && |fuuFwd[2:0]) ? FU9_reg : {DATA_WIDTH{1'BZ}};  


  assign newData_d=({fuFwd,fuuFwd}==8'hff) ? oldData : {DATA_WIDTH{1'BZ}};  
  assign newData_d=(fuFwd!=4'hf) ? newDataFu_d : {DATA_WIDTH{1'BZ}};  
  assign newData_d=(fuuFwd!=4'hf) ? newDataFuu_d : {DATA_WIDTH{1'BZ}};  
  
  assign newDataN_d=({fuFwd,fuuFwd}==8'hff) ? oldDataN : {DATA_WIDTH{1'BZ}};  
  assign newDataN_d=(fuFwd!=4'hf) ? ~newDataFu_d : {DATA_WIDTH{1'BZ}};  
  assign newDataN_d=(fuuFwd!=4'hf) ? ~newDataFuu_d : {DATA_WIDTH{1'BZ}};  

  always @(posedge clk) 
  begin
      if (rst) newData<={DATA_WIDTH{1'B0}};
      else if (~stall)
        newData<=newData_d;
      if (rst) newDataN<={DATA_WIDTH{1'B1}};
      else if (~stall)
        newDataN<=newDataN_d;
  end
endmodule

module rs_write_forward_JALR(
  clk,rst,
  stall,
  oldData,newData,auxData,auxEn,
  fuFwd,fuuFwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  parameter DATA_WIDTH=`alu_width;
  input clk;
  input rst;
  input stall;
  
  input [DATA_WIDTH-1:0] oldData;
  output reg [DATA_WIDTH-1:0] newData;
  input [DATA_WIDTH-1:0] auxData;
  input auxEn;
  input [3:0] fuFwd;
  input [3:0] fuuFwd;
  
  input [DATA_WIDTH-1:0] FU0;
  input [DATA_WIDTH-1:0] FU0_reg;
  input [DATA_WIDTH-1:0] FU1;
  input [DATA_WIDTH-1:0] FU1_reg;
  input [DATA_WIDTH-1:0] FU2;
  input [DATA_WIDTH-1:0] FU2_reg;
  input [DATA_WIDTH-1:0] FU3;
  input [DATA_WIDTH-1:0] FU3_reg;
  input [DATA_WIDTH-1:0] FU4;
  input [DATA_WIDTH-1:0] FU4_reg;
  input [DATA_WIDTH-1:0] FU5;
  input [DATA_WIDTH-1:0] FU5_reg;
  input [DATA_WIDTH-1:0] FU6;
  input [DATA_WIDTH-1:0] FU6_reg;
  input [DATA_WIDTH-1:0] FU7;
  input [DATA_WIDTH-1:0] FU7_reg;
  input [DATA_WIDTH-1:0] FU8;
  input [DATA_WIDTH-1:0] FU8_reg;
  input [DATA_WIDTH-1:0] FU9;
  input [DATA_WIDTH-1:0] FU9_reg;

  wire [DATA_WIDTH-1:0] newData_d;
  wire [DATA_WIDTH-1:0] newDataFu_d;
  wire [DATA_WIDTH-1:0] newDataFuu_d;
  
  assign newDataFu_d=(fuFwd==4'd0) ? FU0 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd0 && ~auxEn) ? FU0_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd1) ? FU1 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd1 && ~auxEn) ? FU1_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd2) ? FU2 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd2 && ~auxEn) ? FU2_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd3) ? FU3 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd3 && ~auxEn) ? FU3_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd4) ? FU4 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd4 && ~auxEn) ? FU4_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd5) ? FU5 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd5 && ~auxEn) ? FU5_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd6) ? FU6 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd6 && ~auxEn) ? FU6_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd7) ? FU7 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd7 && ~auxEn) ? FU7_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd8) ? FU8 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd8) && ~auxEn ? FU8_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd[3] && |fuFwd[2:0]) ? FU9 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd[3] && |fuuFwd[2:0] && ~auxEn) ? FU9_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(auxEn) ? auxData : {DATA_WIDTH{1'BZ}};  


  assign newData_d=({fuFwd,fuuFwd}==8'hff) ? oldData : {DATA_WIDTH{1'BZ}};  
  assign newData_d=(fuFwd!=4'hf) ? newDataFu_d : {DATA_WIDTH{1'BZ}};  
  assign newData_d=(fuuFwd!=4'hf) ? newDataFuu_d : {DATA_WIDTH{1'BZ}};  

  always @(posedge clk) 
  begin
      if (rst) newData<={DATA_WIDTH{1'B0}};
      else if (~stall)
        newData<=newData_d;
  end
endmodule


module rs_writeiS_forward(
  clk,rst,
  stall,
  oldData,newData,
  oldDataN,newDataN,
  fuFwd,fuuFwd,
  FU0,FU0_reg,
  FU1,FU1_reg,
  FU2,FU2_reg,
  FU3,FU3_reg,
  FU4,FU4_reg,
  FU5,FU5_reg,
  FU6,FU6_reg,
  FU7,FU7_reg,
  FU8,FU8_reg,
  FU9,FU9_reg
  );
  parameter DATA_WIDTH=6;
  input clk;
  input rst;
  input stall;
  
  input [DATA_WIDTH-1:0] oldData;
  output [DATA_WIDTH-1:0] newData;
  input [DATA_WIDTH-1:0] oldDataN;
  output [DATA_WIDTH-1:0] newDataN;
  input [3:0] fuFwd;
  input [3:0] fuuFwd;
  
  input [DATA_WIDTH-1:0] FU0;
  input [DATA_WIDTH-1:0] FU0_reg;
  input [DATA_WIDTH-1:0] FU1;
  input [DATA_WIDTH-1:0] FU1_reg;
  input [DATA_WIDTH-1:0] FU2;
  input [DATA_WIDTH-1:0] FU2_reg;
  input [DATA_WIDTH-1:0] FU3;
  input [DATA_WIDTH-1:0] FU3_reg;
  input [DATA_WIDTH-1:0] FU4;
  input [DATA_WIDTH-1:0] FU4_reg;
  input [DATA_WIDTH-1:0] FU5;
  input [DATA_WIDTH-1:0] FU5_reg;
  input [DATA_WIDTH-1:0] FU6;
  input [DATA_WIDTH-1:0] FU6_reg;
  input [DATA_WIDTH-1:0] FU7;
  input [DATA_WIDTH-1:0] FU7_reg;
  input [DATA_WIDTH-1:0] FU8;
  input [DATA_WIDTH-1:0] FU8_reg;
  input [DATA_WIDTH-1:0] FU9;
  input [DATA_WIDTH-1:0] FU9_reg;

  wire [DATA_WIDTH-1:0] newData_d;
  wire [DATA_WIDTH-1:0] newDataN_d;
  wire [DATA_WIDTH-1:0] newDataFu_d;
  wire [DATA_WIDTH-1:0] newDataFuu_d;
  reg [DATA_WIDTH-1:0] oldData_reg;
  reg [DATA_WIDTH-1:0] oldDataN_reg;
  
  assign newDataFu_d=(fuFwd==4'd0) ? FU0 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd0) ? FU0_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd1) ? FU1 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd1) ? FU1_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd2) ? FU2 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd2) ? FU2_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd3) ? FU3 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd3) ? FU3_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd4) ? FU4 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd4) ? FU4_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd5) ? FU5 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd5) ? FU5_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd6) ? FU6 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd6) ? FU6_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd7) ? FU7 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd7) ? FU7_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd==4'd8) ? FU8 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd==4'd8) ? FU8_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd[3] && |fuFwd[2:0]) ? FU9 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd[3] && |fuuFwd[2:0]) ? FU9_reg : {DATA_WIDTH{1'BZ}};  


  assign newData=({fuFwd,fuuFwd}==8'hff) ? oldData_reg : {DATA_WIDTH{1'BZ}};  
  assign newData=(fuFwd!=4'hf) ? newDataFu_d : {DATA_WIDTH{1'BZ}};  
  assign newData=(fuuFwd!=4'hf) ? newDataFuu_d : {DATA_WIDTH{1'BZ}};  
  
  assign newDataN=({fuFwd,fuuFwd}==8'hff) ? oldDataN_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataN=(fuFwd!=4'hf) ? ~newDataFu_d : {DATA_WIDTH{1'BZ}};  
  assign newDataN=(fuuFwd!=4'hf) ? ~newDataFuu_d : {DATA_WIDTH{1'BZ}};  

  always @(posedge clk) begin
	  oldData_reg<=oldData;
	  oldDataN_reg<=oldNData;
  end

endmodule




