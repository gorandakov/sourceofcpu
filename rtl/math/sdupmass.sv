`include "../struct.sv"

module sdupmass(
  A,
  A_11,
  A_101,
  A_1001,
  A_111,
  A_1011,
  A_1101,
  A_1111);
  input [63:0] A;
  output [67:0] A_11;
  output [67:0] A_101;
  output [67:0] A_1001;
  output [67:0] A_111;
  output [67:0] A_1011;
  output [67:0] A_1101;
  output [67:0] A_1111;
  
  wire [67:0] part0_111;
  wire [67:0] part0_1011;
  wire [67:0] part0_1101;
  wire [67:0] part1_111;
  wire [67:0] part1_1011;
  wire [67:0] part1_1101;

  adder #(68) add11({4'b0,A},{3'b0,A,1'b0},A_11,1'b0,1'b1,,,,);
  adder #(68) add101({4'b0,A},{2'b0,A,2'b0},A_101,1'b0,1'b1,,,,);
  adder #(68) add1001({4'b0,A},{1'b0,A,3'b0},A_1001,1'b0,1'b1,,,,);

  adder_CSA #(67) add_111({3'b0,A},{2'b0,A,1'b0},{1'b0,A,2'b0},part0_111,part1_111);
  adder_CSA #(67) add_1011({3'b0,A},{2'b0,A,1'b0},{A,3'b0},part0_1011,part1_1011);
  adder_CSA #(67) add_1101({3'b0,A},{1'b0,A,2'b0},{A,3'b0},part0_1101,part1_1101);

  adder #(68) add111_mod(part0_111,part1_111,A_111,1'b0,1'b1,,,,);
  adder #(68) add1011_mod(part0_1011,part1_1011,A_1011,1'b0,1'b1,,,,);
  adder #(68) add1101_mod(part0_1101,part1_1101,A_1101,1'b0,1'b1,,,,);

  adder #(68) add1111({A,4'b0},~{4'b0,A},A_1111,1'b1,1'b1,,,,);
endmodule
