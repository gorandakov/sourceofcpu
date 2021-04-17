module ttag_is_opcode(
  data,opc,bytes);
  input [23:0] data;
  output reg [9:0] opc;
  output reg [2:0] bytes;

  always @(data) begin
      if (data[15:0]==16'h3af0) begin
      end else if (data[15:0]==16'h3af0) begin
      end else if (data[7:0]==8'hf0) begin
      end else begin
      end
  end
  
endmodule
