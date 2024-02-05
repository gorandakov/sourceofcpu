
module foreign_imul(
  clk,
  rst,
  dataEn,
  subreg_dataEn,
  A,B,res);
  input clk;
  input rst;
  input dataEn;
  input subreg_dataEn,
  input [64:0] A;
  input [64:0] B;
  output [64:0] res;

  function [20:0] mask_insn;
     input [7:0] byte;
     input [7:0] byte_prev;
     input level;
     input is64;
     begin
         mask_insn[15:0]=0;
         if (byte==8'h66 && ~level) mask_insn[11:10]=2'b01;
         if ((byte==8'hf2 || byte==8'h67) && ~level) mask_insn[11:10]=2'b10;
         if ((byte==8'hf3 || byte==8'hf0) && ~level) mask_insn[11:10]=2'b11;
         if (byte[7:4]==4'b0100 && byte_prev[7:4]!=4'b0100 && is64 && ~level) mask_insn[15:12]=byte[3:0];
         if (byte[7:4]==4'b0100 && byte_prev[7:4]==4'b0100 && is64 && ~level) mask_insn[20:16]={1'b1,byte[3:0]}; //third register operand
         if (~level && byte==8'hf) mask_insn[9:8]=2'b01;
         if (level && byte==8'h38) mask_insn[9:8]=2'b10;
         if (level && byte==8'h3a) mask_insn[9:8]=2'b11;
     end
  endfunction

  wire [6:0][20:0] prfx_nolevel;
  wire [6:0][20:0] prfx;
  wire [6:0] lads;
  wire [6:0] lvl;
  wire [7:1] opcode_pos; 
  wire opcode_has_prfx;
  reg [11:0] subreg_need; //only xx and 0f xx supported with subreg!
  generate
    genvar pos;
    for(pos=0;pos<7;pos=pos+1) begin : pfx_dtct
        assign prfx_nolevel[pos]=mask_insn(A[8*pos+:pos],
          pos ? A[8*pos-8+:8] : 8'b0,1'b0,1'b1);
        assign lvl[pos]=prfx_nolevel[pos][9:8]==2'b01;
        if (pos) assign prfx[pos]=mask_insn(A[8*pos+:pos],
          pos ? A[8*pos-8+:8] : 8'b0,|lvl[pos-1:0],1'b1);
        else assign prfx[pos]=prfx_nolevel[pos];
        assign lads[pos]=|prfx[pos];
        assign opcode=opcode_pos[pos] ? A[8*pos+:8] : 8'bz;
        assign modrm=opcode_pos[pos] ? A[8*pos+8+:8] : 8'bz;
        assign pfx[pos]=prfx[pos] & {21{~opcode_pos0[pos+1]}};
    end
  endgenerate
  bit_find_first_bit #(7) find_mod(~lads,opcode_pos,opcode_has_prfx);
  bit_find_first_bit_tail #(7) find_mod(~lads,opcode_pos0,opcode_has_prfx0);

  assign opcode=opcode_has_prfx ? 8'bz : A[63:56];
  assign modrm=opcode_has_prfx ? 8'bz : B[7:0];
  assign res0[7:0]=opcode;
  assign res0[20:8]=pfx[0][20:8] | pfx[1][20:8] | pfx[2][20:8] |
    pfx[3][20:8] | pfx[4][20:8] | pfx[5][20:8] |pfx[6][20:8];

  always @(posedge clk) begin
    if (rst) begin
        subreg_need<=0;
    end else if (subreg_dataEn) begin
        subreg_need[b[5:0]*64+:64]=A[63:0];
    end
    if (rst) begin
        res0_reg<=0;
    end else begin
        res0_reg<={modrm,1'b0,res0[20:12],1'b0,res0[11:0]};
        if (subreg_need[res0[11:0]]) begin
            res0[12]=1'b1;
            res0[22]=res0[11:0]==2'b01; //not fed into table! slow path!
            res0[11:9]=modrm[5:3];
            res0[25:23]=2'b0; //xmm0/ymm0 or rax/eax/ax/al
        end
    end
  end
endmodule
