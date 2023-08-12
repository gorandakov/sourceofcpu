

module tblD(
  clk,
  rst,
  A,
  B,
  xtra,
  is_read,
  is_write,
  res);

  input clk;
  input rst;
  input [67:0] A;
  input [67:0] B;
  input [1:0] xtra;
  input is_read;
  input is_write;
  output [67:0] res;

  reg [255:0][67:0] ram;

  reg [6:0] bits;

  assign res=is_read ? ram[xtra+bits*4] : 68'bz;

  always @* begin
      bits=6'd0;
      if (xtra==2'd0) bits= A[53:48] : 6'bz;
      if (xtra==2'd1) bits= {A[54],A[53:49]} : 6'bz;
      if (xtra[1] && A[65:54]==2044) bits= {5'b0,A[53]} : 6'bz;  
      if (xtra[1] && A[65:54]==2045) bits= {4'b0,A[53:52]} : 6'bz;  
      if (xtra[1] && A[65:54]==2046) bits= {3'b0,A[53:51]} : 6'bz;  
      if (xtra[1] && A[65:54]==2047) bits= {2'b0,A[53:50]} : 6'bz;  
      if (xtra[1] && A[65:54]==2048) bits= {1'b0,A[53:49]} : 6'bz;  
      if (xtra[1] && A[65:54]==2049) bits= A[53:48] : 6'bz;
  end  

  always @(posedge clk) begin
     if (is_write) ram[B[53:46]]=A;
  end
endmodule
