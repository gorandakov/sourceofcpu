`include "../struct.sv"

module fprnd(
  A,
  rbit,tail,
  rndbit,
  rmode,
  isDBL,
  isEXT,
  toDBL,
  toSNG,
  B);
//rnd first, then denormal handling
  input [80:0] A;
  input rbit;
  input tail;
  input rndbit;
  input [2:0] rmode;
  input isDBL;
  input isEXT;
  input toDBL;
  input toSNG;
  output [79:0] B;

  wire [63:0] Ax;
  wire do_rnd;
  wire cout;

  assign Ax={A[63:53]&{11{isEXT}},A[52]|isDBL,A[51:0]};

  adder #(64) rnd_mod(Ax,rbit,res0,1'b0,do_rnd,cout);

  assign res0=~do_rnd ? Ax : 64'bz;
endmodule
