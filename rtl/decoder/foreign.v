
module foreign_imul(
  clk,
  rst,
  dataEn,
  A,B,res);
  input clk;
  input rst;
  input dataEn;
  input [64:0] A;
  input [64:0] B;
  output [64:0] res;

  function [15:0] mask_insn;
     input [7:0] byte;
     input level;
     input is64;
     begin
         mask_insn[15:0]=0;
         if (byte==8'h66 && ~level) mask_insn[11:10]=2'b01;
         if (byte==8'hf2 && ~level) mask_insn[11:10]=2'b10;
         if (byte==8'hf3 && ~level) mask_insn[11:10]=2'b11;
         if (byte[7:4]==4'b0100 && is64 && ~level) mask_insn[15:12]=byte[3:0];
         if (~level && byte==8'hf) mask_insn[9:8]=2'b01;
         if (level && byte==8'h38) mask_insn[9:8]=2'b10;
         if (level && byte==8'h3a) mask_insn[9:8]=2'b11;
     end
  endfunction
endmodule
