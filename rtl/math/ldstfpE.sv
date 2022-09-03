`include "../struct.sv"

module LDE2NativeE(
  A,An,
  en,
  res,
  res_n
  );
  input [79:0] A;
  input [79:0] An;
  input en;
  output [80:0] res;
  output [80:0] res_n;
  //assign except=A[78:64]==0 && A[63:0];//denormal
  assign res=(A[78:64]!=0 && A[78:64]!=15'hefff && en) ? {~A[78],A[79],A[77:64],A[78],A[63:0]} : 81'bz;
  assign res=(A[78:64]==15'hefff && en) ? {A[79:65],A[62:0]!=63'b0,A[78],A[63:0]} : 81'bz;
  assign res=(A[78:64]==0 && en) ? 81'b0 :  81'bz;//denormal loaded as zero for extended format
  
  assign res_n=(A[78:64]!=0 && A[78:64]!=15'hefff && en) ? {~An[78],An[79],An[77:64],An[78],An[63:0]} : 81'bz;
  assign res_n=(A[78:64]==15'hefff && en) ? {An[79:65],An[62:0]!=63'b0,An[78],An[63:0]} : 81'bz;
  assign res_n=(A[78:64]==0 && en) ? ~81'b0 :  81'bz;//denormal loaded as zero for extended format
endmodule

module stNativeE2E(
  A,
  en,
  res
  );
  localparam [15:0] DEN=16'h4000;
  localparam [15:0] OVFL=16'hbfff;
  input [80:0] A;
  input en;
  output [127:0] res;
 
  wire is_den;
  wire is_overflow;
  wire [15:0] expA={A[64],A[79:65]};
  wire is_unord=&expA;
  wire [15:0] expOff;
  adder #(16) expAddD_mod(DEN,~expA,expOff,1'b1,1'b1,is_den,,,);
  adder #(16) expAddO_mod(expA,~OVFL,,1'b1,1'b1,is_overflow,,,);


  assign res=is_den & en ? 128'b0 : 128'bz;
  assign res=is_overflow & ~is_unord & en ? {48'b0,A[80],15'hefff,64'b0} : 128'bz;
  assign res=is_unord & en ? {48'b0,A[80],15'hefff,A[63:0]} : 128'bz;
  assign res=~is_den & ~is_overflow & ~is_unord & en ? {48'b0,A[80],A[64],A[78:65],A[63:0]} : 128'bz;
endmodule

