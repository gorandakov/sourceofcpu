module ttag_op_bit(
  clk,
  rst,
  csrss_en,csrss_no,csrss_data,
  addr,
  val);

  parameter [15:0] CSR_ADDR=16'b0;
  parameter [1023:0] initval;

  input clk;
  input rst;
  input csrss_en;
  input [15:0] csrss_no;
  input [64:0] csrss_data;
  input [9:0] addr;
  output val;

  reg [15:0][63:0] data;
  integer t;

  assign val=data[addr[9:6]][addr[5:0]];

  always @(posedge clk) begin
      if (rst) data<=initval;
      else if (csrss_en && csrss_no==CSR_ADDR) begin
          for(t=1;t<16;t=t+1) data[t]<=data[t-1];
	  data[0]<=csrss_data;
      end
  end
endmodule
