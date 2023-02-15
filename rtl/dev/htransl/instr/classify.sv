/*
Copyright 2022 Goran Dakov

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/


`include "../struct.sv"

module prefix_single(
	bits,
	mode64,
	is_pref,
	pref,
        last);
  localparam PREF=`pref_width;
  input [7:0] bits;
  input mode64;
  output reg is_pref;
  output reg [PREF-1:0] pref;
  output reg last;

  always @* begin
    is_pref=1'b1;
    pref={PREF{1'b0}};
    last=1'b0;
    casex(bits)
    8'hf0: begin pref[`pref_lock]=1'b1; end
    8'hf3: begin pref[`pref_repE]=1'b1; end
    8'hf2: begin pref[`pref_repNE]=1'b1; end
    8'h2e: begin pref[`pref_HASSEG]=1'b1; pref[`pref_SEG]=3'd0; end
    8'h36: begin pref[`pref_HASSEG]=1'b1; pref[`pref_SEG]=3'd1; end
    8'h3e: begin pref[`pref_HASSEG]=1'b1; pref[`pref_SEG]=3'd2; end
    8'h26: begin pref[`pref_HASSEG]=1'b1; pref[`pref_SEG]=3'd3; end
    8'h64: begin pref[`pref_HASSEG]=1'b1; pref[`pref_SEG]=3'd4; end
    8'h65: begin pref[`pref_HASSEG]=1'b1; pref[`pref_SEG]=3'd5; end
    8'h66: begin pref[`pref_data]=1'b1; end
    8'h67: begin pref[`pref_addr]=1'b1; end
    8'h0f: begin pref[`pref_2byte]=1'b1; end
    8'b0100xxxx: if (mode64) begin
        pref[`pref_rex]=1'b1;
        pref[`pref_W]=bits[3];
        pref[`pref_R]=bits[2];
        pref[`pref_X]=bits[1];
        pref[`pref_B]=bits[0];	
	last=1'b1;
    end
    default: is_pref=1'b0;
    endcase
  end

endmodule

module prefix(
	bits,
	mode64,
	prf_bytes,
	pref);
  localparam PREF=`pref_width;
  input [31:0] bits;
  input mode64;
  output [3:0] prf_bytes;
  output [PREF-1:0] pref;


  generate
    genvar tl;
    for(tl=0;tl<4;tl=tl+1) begin : rpef
        prefix_single p_mod(
	.bits(bits[tl*8+:8]),
	.mode64(mode64),
	.is_pref(is_pref[tl]),
	.pref(prefx[tl]),
        .last(lastx[tl]));
    end
  endgenerate

  assign pref=first[0] ? {PREF{1'b0}} : 'z;
  assign pref=first[1] ? prefx[0] : 'z;
  assign pref=first[2] ? prefx[0]|prefx[1] : 'z;
  assign pref=first[3] ? prefx[0]|prefx[1]|prefx[2] : 'z;
  assign pref=~has ? prefx[0]|prefx[1]|prefx[2]|prefx[3] : 'z;

  assign prf_bytes=~(first | {first[2:0],1'b0} | {first[1:0],2'b0} | 
	  {first[0],3'b0}; 
  bit_find_first_bit #(4) cnt_mod(~is_pref|{1'b0,last[3:1]}, first, has);
endmodule
