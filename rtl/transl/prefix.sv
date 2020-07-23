

module trl_is_pref(
  data,is_pref,pref);
  input [7:0] data;
  output is_pref;
  output [11:0] pref;

  assign is_pref=data==8'hf0 || data==8'hf2 || data==8'hf3 || data==8'h64 ||
      data==8'h2e || data==8'h3e || data==8'h66 || data==8'h26 ||
      data==8'h36 || data[7:4]==4'h4;
  assign pref={data==8'hf0 ,data==8'hf2 ,data==8'hf3 ,data==8'h64,
     data==8'h2e ,data==8'h3e ,data==8'h66,{5{data[7:4]==4'h4}}&{1'b1,data[3:0]}}
endmodule


module detect_prefix(data,bits,prf);
  input [31:0] data;
  output [4:0] bits;
  output [11:0] prf;

  wire [3:0] bits0;
  wire [11:0] pref[3:0];

  trl_is_pref pref0_mod(data[7:0],bits0[0],pref[0]);
  trl_is_pref pref1_mod(data[15:8],bits0[1],pref[1]);
  trl_is_pref pref2_mod(data[23:16],bits0[2],pref[2]);
  trl_is_pref pref3_mod(data[31:24],bits0[3],pref[3]);

  bit_find_first_bit #(4) ff_mod(~bits0,bits[3:0],bits[4]);

  assign prf=bits[0] ? 12'b0 : 12'bz;
  assign prf=bits[1] ? pref[0] : 12'bz;
  assign prf=bits[2] ? pref[1]|pref[0] : 12'bz;
  assign prf=bits[3] ? pref[2]|pref[1]|pref[0] : 12'bz;
  assign prf=bits[4] ? pref[3]|pref[2]|pref[1]|pref[0];

endmodule


