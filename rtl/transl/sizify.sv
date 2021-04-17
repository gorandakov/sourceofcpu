module ttag_sizify(
  clk,
  rst,
  data_in,
  szbytes,
  csrss_en,csrss_no,csrss_data);
  input clk;
  input rst;
  input [14*8-1:0] data_in;
  output [3:0] szbytes;
  input csrss_en;
  input [15:0] csrss_no;
  input [63:0] csrss_data;
  
  wire [4:0] prf_bits;
  wire [10:0] prf;
  wire [4:0][9:0] opc;
  wire [4:0][2:0] bytes;
  wire [4:0] has_mem;
  wire [4:0][1:0] has_imm;

  detect_prefix prf_mod(data[31:0],prf_bits,prf);
  generate 
    genvar ty;
    for(ty=0;ty<=4;ty=ty+1) begin : opc
        ttag_is_opcode op_mod(
           data[ty*8+:24],opc[ty],bytes[ty]);
        ttag_op_bit #(`csr_has_mem) (
          clk,
          rst,
          csrss_en,csrss_no,csrss_data,
          opc[ty],
          has_mem[ty]);
        ttag_op_bit #(`csr_immsz0) (
          clk,
          rst,
          csrss_en,csrss_no,csrss_data,
          opc[ty],
          has_imm[ty][0]);
        ttag_op_bit #(`csr_immsz1) (
          clk,
          rst,
          csrss_en,csrss_no,csrss_data,
          opc[ty],
          has_imm[ty][1]);
        assign op_sz=prf_bits[ty] ? {4'b0,bytes[ty]}<<ty : 7'bz;
    end
  endgenerate

endmodule
