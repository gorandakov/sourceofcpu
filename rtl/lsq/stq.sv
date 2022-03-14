
module stq_buf_L(
  clk,
  rst,
  stallA,
  wrt0_en, wrt0_addrEO, wrt0_odd, wrt0_bytes, wrt0_subBNK,
  chk0_en, chk0_addrEO, chk0_odd, chk0_bytes, chk0_subBNK, chk0_match, chk0_partial,
  chk1_en, chk1_addrEO, chk1_odd, chk1_bytes, chk1_subBNK, chk1_match, chk1_partial,
  chk2_en, chk2_addrEO, chk2_odd, chk2_bytes, chk2_subBNK, chk2_match, chk2_partial,
  chk3_en, chk3_addrEO, chk3_odd, chk3_bytes, chk3_subBNK, chk3_match, chk3_partial,
  chk4_en, chk4_addrEO, chk4_odd, chk4_bytes, chk4_subBNK, chk4_match, chk4_partial,
  chk5_en, chk5_addrEO, chk5_odd, chk5_bytes, chk5_subBNK, chk5_match, chk5_partial,
  upd0_en, upd0_addrEO, upd0_odd, upd0_subBNK, upd0_match,
  upd1_en, upd1_addrEO, upd1_odd, upd1_subBNK, upd1_match,
  free_en,free,upd,passe,passe_en);
  localparam WIDTH=36;
  input clk;
  input rst;
  input stallA;
  input wrt0_en;
  input [WIDTH-1:0] wrt0_addrEO;
  input wrt0_odd;
  input [3:0] wrt0_bytes;
  input [7:0] wrt0_subBNK;

  input chk0_en;
  input [WIDTH-1:0] chk0_addrEO;
  input chk0_odd;
  input [3:0] chk0_bytes;
  input [7:0] chk0_subBNK;
  output chk0_match;
  output chk0_partial;

  input chk1_en;
  input [WIDTH-1:0] chk1_addrEO;
  input chk1_odd;
  input [3:0] chk1_bytes;
  input [7:0] chk1_subBNK;
  output chk1_match;
  output chk1_partial;

  input chk2_en;
  input [WIDTH-1:0] chk2_addrEO;
  input chk2_odd;
  input [3:0] chk2_bytes;
  input [7:0] chk2_subBNK;
  output chk2_match;
  output chk2_partial;

  input chk3_en;
  input [WIDTH-1:0] chk3_addrEO;
  input chk3_odd;
  input [3:0] chk3_bytes;
  input [7:0] chk3_subBNK;
  output chk3_match;
  output chk3_partial;

  input chk4_en;
  input [WIDTH-1:0] chk4_addrEO;
  input chk4_odd;
  input [3:0] chk4_bytes;
  input [7:0] chk4_subBNK;
  output chk4_match;
  output chk4_partial;

  input chk5_en;
  input [WIDTH-1:0] chk5_addrEO;
  input chk5_odd;
  input [3:0] chk5_bytes;
  input [7:0] chk5_subBNK;
  output chk5_match;
  output chk5_partial;

  input upd0_en;
  input [WIDTH-1:0] upd0_addrEO;
  input upd0_odd;
  input [7:0] upd0_subBNK;
  output upd0_match;

  input upd1_en;
  input [WIDTH-1:0] upd1_addrEO;
  input upd1_odd;
  input [7:0] upd1_subBNK;
  output upd1_match;

  input free_en;
  output reg free;
  output reg upd;
  output reg passe;
  input passe_en;
  
  reg [WIDTH-1:0] addrEO;
  reg [3:0] bytes;
  reg [7:0] subBNK;
  reg odd;
  reg upd;
  
  assign chk0_match0=chk0_addrEO==addrEO && (chk0_subBNK&subBNK)!=0 && chk0_odd==odd;
  assign chk1_match0=chk1_addrEO==addrEO && (chk1_subBNK&subBNK)!=0 && chk1_odd==odd;
  assign chk2_match0=chk2_addrEO==addrEO && (chk2_subBNK&subBNK)!=0 && chk2_odd==odd;
  assign chk3_match0=chk3_addrEO==addrEO && (chk3_subBNK&subBNK)!=0 && chk3_odd==odd;
  assign chk4_match0=chk4_addrEO==addrEO && (chk4_subBNK&subBNK)!=0 && chk4_odd==odd;
  assign chk5_match0=chk5_addrEO==addrEO && (chk5_subBNK&subBNK)!=0 && chk5_odd==odd;
  
  assign chk0_match=chk0_match0 && chk0_en && ~free && ~passe && (chk0_bytes&~bytes)==0;
  assign chk1_match=chk1_match0 && chk1_en && ~free && ~passe && (chk1_bytes&~bytes)==0;
  assign chk2_match=chk2_match0 && chk2_en && ~free && ~passe && (chk2_bytes&~bytes)==0;
  assign chk3_match=chk3_match0 && chk3_en && ~free && ~passe && (chk3_bytes&~bytes)==0;
  assign chk4_match=chk4_match0 && chk4_en && ~free && ~passe && (chk4_bytes&~bytes)==0;
  assign chk5_match=chk5_match0 && chk5_en && ~free && ~passe && (chk5_bytes&~bytes)==0;

  assign chk0_match=chk0_match0 && chk0_en && ~free && ~passe && (chk0_bytes&~bytes)!=0;
  assign chk1_match=chk1_match0 && chk1_en && ~free && ~passe && (chk1_bytes&~bytes)!=0;
  assign chk2_match=chk2_match0 && chk2_en && ~free && ~passe && (chk2_bytes&~bytes)!=0;
  assign chk3_match=chk3_match0 && chk3_en && ~free && ~passe && (chk3_bytes&~bytes)!=0;
  assign chk4_match=chk4_match0 && chk4_en && ~free && ~passe && (chk4_bytes&~bytes)!=0;
  assign chk5_match=chk5_match0 && chk5_en && ~free && ~passe && (chk5_bytes&~bytes)!=0;

  always @(posedge clk) begin
      if (rst) begin
          addrEO<=0;
          bytes<=0;
          subBNK<=0;
          free<=1'b1;
          upd<=1'b1;
          passe<=1'b0;
          odd<=1'b0;
      end else begin
          if (wrt0_en) begin
              addrEO<=wrt0_addrEO;
              bytes<=wrt0_bytes;
              subBNK<=wrt0_subBNK;
              odd<=wrt0_odd;
              free<=1'b0;
              upd<=1'b0;
              passe<=1'b0;
          end
          if (passe_en) passe<=1'b1;
          if (free_en) begin 
              free<=1'b1;
              passe<=1'b0;
          end
      end
  end
endmodule

