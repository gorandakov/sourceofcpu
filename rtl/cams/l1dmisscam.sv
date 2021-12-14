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



module dmisscam(
  clk,
  rst,
  fill_en,
  fill_addr,
  fill_st,
  fill_req,
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
          begin_replay
          );
          assign fill_req=first[k] ? k[3:0] : 4'bz;
      end
  endgenerate
  
  assign fill_en_way=first & {16{fill_en&~locked&~begin_replay}};
  assign fill_match=|fill_match_o;
  assign has_free=found;
  assign fill_req=found ? 4'bz : 4'b0;
  assign ins_addr_o=ins_en ? 37'bz : 37'b0;
  
  assign begin_replay=started & ~(|filled);

  
  bit_find_first_bit #(16) first_mod(~busy,first,found);
  
  always @(posedge clk) begin
      if (rst) locked<=1'b0;
      else locked<=locked|~found|begin_replay && ~unlock;
      if (rst) started<=1'b0;
      else if (begin_replay) started<=1'b0;
      else if (fill_en&~locked) started<=1'b1;
  end
  
endmodule

