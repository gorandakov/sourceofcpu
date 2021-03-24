

module ttag_mem(
  data,
  is_sib,imm_bytes,
  size,
  rA,rB,imm,rInd,scale,
  imm_has,base_has,IPRel);
  input [15:0] data;
  output reg is_sib;
  output reg [2:0] imm_bytes;
  output reg [5:0] size;
//  output reg ronly;

  always @(data) begin
    is_bytes=0;
    rA=data[2:0];
    rB=data[5:3];
    rInd=data[8+5:8+3];
    scale=[15:14];
    case(data[7:6])
        2'b11:imm_bytes=1;
        2'b0: imm_bytes=1;
        2'b1: imm_bytes=2;
        2'b10: imm_bytes=4;
    endcase
    is_sib=data[7:6]!=2'b11 && rA==3'b100;
    IPrel=data[7:6]==2'b0 && rA==101;
//    base_has=!(data[7:6]==2'b0 && rA==101);
    if (is_sib) rA=data[10:8];
    base_has=!(data[7:6]==2'b0 && rA==101);
    if (IPrel||!base_has) imm_bytes=4;
    size={1'b0,imm_bytes[2],2'b0,imm_bytes[1],imm_bytes[0]};
    if (is_sib) size={size[4:0],1'b0};
  end

endmodule
