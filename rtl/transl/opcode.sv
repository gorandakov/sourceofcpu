module ttag_is_opcode(
  data,opc,bytes);
  input [23:0] data;
  output reg [9:0] opc;
  output reg [2:0] bytes;

  always @(data) begin
      if (data[15:0]==16'h3af0) begin
	  opc={2'b11,data[23:16]};
	  bytes=4;
      end else if (data[15:0]==16'h3af0) begin
	  opc={2'b10,data[23:16]};
	  bytes=4;
      end else if (data[7:0]==8'hf0) begin
	  opc={2'b1,data[15:8]};
	  bytes=2;
      end else begin
	  opc={2'b0,data[7:0]};
	  bytes=1;
      end
  end
  
endmodule
