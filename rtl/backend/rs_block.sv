`include "../struct.sv"



module rs_write_forward(
  clk,rst,
  stall,
  oldData,newData,
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

  always @(posedge clk) 
  begin
      if (rst) newData<={DATA_WIDTH{1'B0}};
      else if (~stall)
        newData<=newData_d;
  end
endmodule


module rs_write_forward_save(
  clk,rst,
  oldData,newData,
  fuFwd,fuuFwd,
  save,en,
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
  
  input [DATA_WIDTH-1:0] oldData;
  output [DATA_WIDTH-1:0] newData;
  input [3:0] fuFwd;
  input [3:0] fuuFwd;
  input save;
  input en;
  
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

  wire [DATA_WIDTH-1:0] oldDataX;
  wire [3:0] fuFwdX;
  wire [3:0] fuuFwdX;

  reg saved;

  reg [DATA_WIDTH-1:0] oldData_reg;
  reg [3:0] fuFwd_reg;
  reg [3:0] fuuFwd_reg;

  rs_write_forward_nxt fwd_mod(
  clk,rst,
  save,
  oldDataX,newData,
  fuFwdX,fuuFwdX,
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
  
  assign oldDataX=saved ? oldData_reg : oldData;
  assign fuFwdX=saved ? fuFwd_reg : fuFwd;
  assign fuuFwdX=saved ? fuuFwd_reg : fuuFwd;
  
  always @(posedge clk) begin
      if (rst) saved<=1'b0;
      else saved<=saved | save && en;
      oldData_reg<=oldData;
      fuFwd_reg<=fuuFwd;
      fuuFwd_reg<=4'hf;
  end
  
endmodule



module rs_save(
  clk,rst,
  oldData,newData,
  save,en
  );
  parameter DATA_WIDTH=`alu_width;
  input clk;
  input rst;
  
  input [DATA_WIDTH-1:0] oldData;
  output reg [DATA_WIDTH-1:0] newData;
  input save;
  input en;
  

  wire [DATA_WIDTH-1:0] oldDataX;

  reg saved;

  reg [DATA_WIDTH-1:0] oldData_reg;

 
  assign oldDataX=saved ? oldData_reg : oldData;
  
  always @(posedge clk) begin
      if (rst) saved<=1'b0;
      else saved<=saved | save && en;
      oldData_reg<=oldData;
      if (rst) newData<={DATA_WIDTH{1'B0}};
      else if (~save) newData<=oldDataX;
  end
  
endmodule



module rs_write_forward_nxt(
  clk,rst,
  stall,
  oldData,newData,
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
  output [DATA_WIDTH-1:0] newData;
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

  reg  [DATA_WIDTH-1:0] oldData_reg;
  wire [DATA_WIDTH-1:0] newDataFu_d;
  wire [DATA_WIDTH-1:0] newDataFuu_d;
  reg [3:0] fuFwd_reg;
  reg [3:0] fuuFwd_reg;
  
  assign newDataFu_d=(fuFwd_reg==4'd0) ? FU0 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd_reg==4'd0) ? FU0_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd_reg==4'd1) ? FU1 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd_reg==4'd1) ? FU1_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd_reg==4'd2) ? FU2 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd_reg==4'd2) ? FU2_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd_reg==4'd3) ? FU3 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd_reg==4'd3) ? FU3_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd_reg==4'd4) ? FU4 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd_reg==4'd4) ? FU4_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd_reg==4'd5) ? FU5 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd_reg==4'd5) ? FU5_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd_reg==4'd6) ? FU6 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd_reg==4'd6) ? FU6_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd_reg==4'd7) ? FU7 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd_reg==4'd7) ? FU7_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd_reg==4'd8) ? FU8 : {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd_reg==4'd8) ? FU8_reg : {DATA_WIDTH{1'BZ}};  
  assign newDataFu_d=(fuFwd_reg[3] && fuFwd_reg[2:0]!=0) ? FU9 : 
    {DATA_WIDTH{1'BZ}};  
  assign newDataFuu_d=(fuuFwd_reg[3] && fuuFwd_reg[2:0]!=0) ? FU9_reg : 
    {DATA_WIDTH{1'BZ}};  


  assign newData=({fuFwd_reg,fuuFwd_reg}==8'hff) ? oldData_reg : {DATA_WIDTH{1'BZ}};  
  assign newData=(fuFwd_reg!=4'hf) ? newDataFu_d : {DATA_WIDTH{1'BZ}};  
  assign newData=(fuuFwd_reg!=4'hf) ? newDataFuu_d : {DATA_WIDTH{1'BZ}};  

  always @(posedge clk) begin 
      if (rst) oldData_reg<={DATA_WIDTH{1'B0}};
      else if (~stall)
        oldData_reg<=oldData;
      if (rst) begin
          fuFwd_reg<=4'hf;
          fuuFwd_reg<=4'hf;
      end else if (~stall) begin
          fuFwd_reg<=fuFwd;
          fuuFwd_reg<=fuuFwd;
      end
  end
endmodule


