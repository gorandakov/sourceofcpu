`include "../struct.sv"


/*
Lifetime of a buffer

1.cache miss buffer fill.

2.cache miss resolved. 

3. wait for 3 cycles. Then store write_index*

3.wait till read_index reaches the stored write_index

5. free miss buffer
*/

module dmisscam_buf(
  clk,
  rst,
  fill_match,
  fill_match_o,
  fill_en,
  fill_addr,
  fill_st,
  ins_en,
  ins_req,
  ins_addr_o,
  filled,
  busy,
  unlock
  );
    
  localparam PADDR_WIDTH=44;
  localparam OPERATION_WIDTH=`operation_width;
  localparam BANK_COUNT=32;
  localparam INDEX_WIDTH=6;
  parameter [3:0] REQ=0;

  input clk;
  input rst;

  input fill_match;
  output fill_match_o;
  input fill_en;
  input [PADDR_WIDTH-8:0] fill_addr;
  input fill_st;
  input ins_en;
  input [3:0] ins_req;
  output [PADDR_WIDTH-8:0] ins_addr_o;
  output reg filled;
  output reg busy;
  input unlock;
  
  reg [PADDR_WIDTH-8:0] addr;
  reg store;
  reg [INDEX_WIDTH-1:0] wrin;
  reg [2:0] steps;
  reg stepin;
  
  assign fill_match_o=fill_addr==addr && busy;
 
  assign ins_addr_o=(ins_en && ins_req==REQ) ? addr : 37'bz;

  always @(posedge clk) begin
      if (rst) begin
          filled<=1'b0;
          busy<=1'b0;
          addr<={PADDR_WIDTH-7{1'B0}};
          store<=1'B0;
          wrin<={INDEX_WIDTH{1'B0}};
          steps<=3'b0;
          stepin<=1'b0;
      end else if (fill_en && ~fill_match) begin
          filled<=1'b1;
          busy<=1'b1;
          addr<=fill_addr;
          store<=fill_st;
      end else begin
          if (ins_en && ins_req==REQ) begin
              filled<=1'b0;
          end
          if (unlock) busy<=1'b0;
      end
  end
    
endmodule

module dm_alloc(
  busy,en,en_out,
  bit0,
  bit1,
  bit2,
  bit3,
  bit4,
  bit5);
  input [7:0] busy;
  input [5:0] en;
  output [5:0] en_out;
  output [7:0] bit0;
  output [7:0] bit1;
  output [7:0] bit2;
  output [7:0] bit3;
  output [7:0] bit4;
  output [7:0] bit5;

  wire en_outX0,en_outP0;
  wire en_outX1,en_outP1;
  wire en_outX2,en_outP2;
  wire en_outX3,en_outP3;
  wire en_outX4,en_outP4;
  wire en_outX5,en_outP5;
  wire [10:1] busy_cnt;
  wire [5:0] cnt2;
  wire [5:0] cnt5;

  bit_find_first_bit #(8) bit0_mod(~busy&{8{en[0]}},bit0,en_outP0);
  bit_find_first_bit #(8) bit1_mod(~busy&{8{en[1]}}&~bit0,bit1,en_outP1);
  bit_find_first_bit #(8) bit2_mod(~busy&{8{en[2]}}&~bit0&~bit1,bit2,en_outP2);
  bit_find_last_bit #(8) bit3_mod(~busy&{8{en[3]}},bit3,en_outP3);
  bit_find_last_bit #(8) bit4_mod(~busy&{8{en[4]}}&~bit3,bit4,en_outP4);
  bit_find_last_bit #(8) bit5_mod(~busy&{8{en[5]}}&~bit3&~bit4,bit5,en_outP5);

  popcnt10_or_more cpop_mod({2'b0,~busy},busy_cnt);
  popcnt5 cpop2_mod({en[0],en[3],en[1],en[4],1'b0},cnt2);
  popcnt5 cpop5_mod({en[0],en[3],en[1],en[4],en[2]},cnt5);
  
  assign en_outX0=en_out0 & busy_cnt[1];
  assign en_outX3=en_out0 & en_out3 & busy_cnt[2] || ~en_out0 & en_out3 & busy_cnt[1];
  assign en_outX1=en_out0 & en_out3 & en_out1 & busy_cnt[3] || ~en_out0 & en_out3 & en_out1 & busy_cnt[2] ||
      en_out0 & ~en_out3 & en_out1 & busy_cnt[2] || ~en_out0 & ~en_out3 & en_out1 & busy_cnt[1]; 
  assign en_outX4=en_out0 & en_out3 & en_out1 & en_out4 & busy_cnt[4] ||~en_out0 & en_out3 & en_out1 & en_out4 & busy_cnt[3] ||
	  en_out0 & ~en_out3 & en_out1 & en_out4 & busy_cnt[3] ||en_out0 & en_out3 & ~en_out1 & en_out4 & busy_cnt[3] ||
	  ~en_out0 & ~en_out3 & en_out1 & en_out4 & busy_cnt[2] || ~en_out0 & en_out3 & ~en_out1 & en_out4 & busy_cnt[2] ||
	  en_out0 & ~en_out3 & ~en_out1 & en_out4 & busy_cnt[2] ||~en_out0 & ~en_out3 & ~en_out1 & en_out4 & busy_cnt[1]; 
  assign en_outX2=cnt2[4]&busy_cnt[5] || cnt2[3]&busy_cnt[4] || cnt2[2]&busy_cnt[3] || cnt2[1] & busy_cnt[2] || cnt2[0] &busy_cnt[1];
  assign en_outX5=cnt5[5]&busy_cnt[6] || cnt5[4]&busy_cnt[5] || cnt5[3]&busy_cnt[4] || cnt5[2] & busy_cnt[3] || cnt5[1] &busy_cnt[2] ||
	  cnt5[0]&busy_cnt[1];
  assign en_out0=en_outP0 & en_outX0;
  assign en_out1=en_outP1 & en_outX1;
  assign en_out2=en_outP2 & en_outX2;
  assign en_out3=en_outP3 & en_outX3;
  assign en_out4=en_outP4 & en_outX4;
  assign en_out5=en_outP5 & en_outX5;



endmodule

module dmisscam(
  clk,
  rst,
  fill_en0,fill_addrE0,fill_addrO0,fill_st0,
  fill_en1,fill_addrE1,fill_addrO1,fill_st1,
  fill_en2,fill_addrE2,fill_addrO2,fill_st2,
  fill_en3,fill_addrE3,fill_addrO3,fill_st3,
  fill_en4,fill_addrE4,fill_addrO4,fill_st4,
  fill_en5,fill_addrE5,fill_addrO5,fill_st5,
  read_en0,read_addrE0,read_addrO0,read_st0,read_req0,
  ins_en,
  ins_req,
  ins_addr_o,
  has_free,
  fill_match,
  locked,
  begin_replay,
  unlock
  );
    
  localparam PADDR_WIDTH=44;
  localparam OPERATION_WIDTH=`operation_width;
  localparam BANK_COUNT=32;
  localparam INDEX_WIDTH=6;

  input clk;
  input rst;

  input fill_en;
  input fill_en_pre;
  input [PADDR_WIDTH-8:0] fill_addr;
  input fill_st;
  output [3:0] fill_req;
  input ins_en;
  input [3:0] ins_req;
  output [PADDR_WIDTH-8:0] ins_addr_o;
  output has_free;
  output fill_match;
  output reg locked;
  output begin_replay;
  input unlock;

  wire [15:0] fill_match_o;
  wire [15:0] filled;
  wire [15:0] busy;
  wire [15:0] fill_en_way;
  
  wire [15:0] first;
  wire found;
  
  reg started;
    
  generate
      genvar k;
      for(k=0;k<16;k=k+1) begin : buffers_gen
          dmisscam_buf #(k) buf_mod(
          clk,
          rst,
          fill_match,
          fill_match_o[k],
          fill_en_way[k],
          fill_addr,
          fill_st,
          ins_en,
          ins_req,
	  ins_addr_o,
          filled[k],
          busy[k],
          unlock
          );
          assign fill_req=first[k] ? k[3:0] : 4'bz;
      end
  endgenerate
  
  assign fill_en_way=first & {16{fill_en&~locked&~begin_replay}};
  assign fill_match=|fill_match_o;
  assign has_free=found;
  assign fill_req=found ? 4'bz : 4'b0;
  assign ins_addr_o=ins_en ? 37'bz : 37'b0;
  
  assign begin_replay=started & ~(|filled) && (~fill_en & ~fill_en_pre || (&busy));

  
  bit_find_first_bit #(16) first_mod(~busy,first,found);
  
  always @(posedge clk) begin
      if (rst) locked<=1'b0;
      else locked<=locked|~found|begin_replay && ~unlock;
      if (rst) started<=1'b0;
      else if (begin_replay) started<=1'b0;
      else if (fill_en&~locked) started<=1'b1;
  end
  
endmodule

