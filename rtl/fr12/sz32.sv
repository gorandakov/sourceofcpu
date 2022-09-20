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

module sz_submod8(
  sizes,
  bits
);
  input [15:0] sizes;
  output [7+5:0] bits;
  always @* begin
  casex(sizes)
    16'b00xx00xx00xx00xx:bits=13'haa;

    16'b01xxxx00xx00xx00:bits=13'h154;
    16'b00xx01xxxx00xx00:bits=13'h152;
    16'b00xx00xx01xxxx00:bits=13'h14a;
    16'b00xx00xx00xx01xx:bits=13'h12a;

    16'b10xxxxxx00xx00xx:bits=13'ha8;
    16'b00xx10xxxxxx00xx:bits=13'ha2;
    16'b00xx00xx10xxxxxx:bits=13'h8a;
    16'b00xx00xx00xx10xx:bits=13'h22a;
    
    16'b11xxxxxxxxxx00xx:bits=13'ha0;
    16'b00xx11xxxxxxxxxx:bits=13'h82;
    16'b00xx00xx11xxxxxx:bits=13'h20a;
    16'b00xx00xx00xx11xx:bits=13'h82a;

    //2x big
    //3-3
    16'b01xxxx01xxxx00xx:bits=13'ha4;
    16'b01xxxx00xx01xxxx:bits=13'h94;
    16'b01xxxx00xx00xx01:bits=13'h254;
    16'b00xx01xxxx01xxxx:bits=13'h92;
    16'b00xx01xxxx00xx01:bits=13'h252;
    16'b00xx00xx01xxxx01:bits=13'h24a;
    //4-4
    16'b10xxxxxx10xxxxxx:bits=13'h88;
    16'b10xxxxxx00xx10xx:bits=13'h228;
    16'b00xx10xxxxxx10xx:bits=13'h222;
    //6-6
    16'b11xxxxxxxxxx11xx:bits=13'h820;
    //3-4
    16'b01xxxx10xxxxxx00:bits=13'h144;
    16'b01xxxx00xx10xxxx:bits=13'h114;
    16'b01xxxx00xx00xx10:bits=13'h454;
    16'b00xx01xxxx00xx10:bits=13'h452;
    16'b00xx01xxxx10xxxx:bits=13'h112;
    16'b00xx00xx01xxxx10:bits=13'h44a;
    //4-3
    16'b10xxxxxx01xxxx00:bits=13'h148;
    16'b10xxxxxx00xx01xx:bits=13'h128;
    16'b00xx10xxxxxx01xx:bits=13'h122;
    //3-6
    16'b01xxxx11xxxxxxxx:bits=13'h104;
    16'b01xxxx00xx11xxxx:bits=13'h414;
    16'b01xxxx00xx00xx11:bits=13'h1054;
    16'b00xx01xxxx00xx11:bits=13'h1052;
    16'b00xx01xxxx11xxxx:bits=13'h412;
    16'b00xx00xx01xxxx11:bits=13'h104a;
    //6-3
    16'b11xxxxxxxxxx01xx:bits=13'h120;
    //4-6
    16'b10xxxxxx11xxxxxx:bits=13'h208;
    16'b10xxxxxx00xx11xx:bits=13'h828;
    16'b00xx10xxxxxx11xx:bits=13'h822;
    //6-4
    16'b11xxxxxxxxxx10xx:bits=13'h220;
  endcase
  end
endmodule

module sz32(
  offsz,
  sizes,
  outsz,
  bits);
  parameter WIDTH_IN_BYTES=8;

  generate
      genvar k;
      if (WIDTH_IN_BYTES>8) begin : pair
	  sz32 #(WIDTH_IN_BYTES/2) sz_A_mod(offsz,sizes[WIDTH_IN_BYTES-1:0],outsz_A,bits[WIDTH_IN_BYTES/2-1:0]);
	  sz32 #(WIDTH_IN_BYTES/2) sz_B_mod(outsz_A,sizes[WIDTH_IN_BYTES*2-1:WIDTH_IN_BYTES],outsz,
		  bits[WIDTH_IN_BYTES-1:WIDTH_IN_BYTES/2]);
      end else begin
	  for(k=0;k<5;k=k+1) begin : assignos
	      wire [5:0] first;
	      wire has;
	      sz_submod8({{k{2'b11}},sizes[WIDTH_IN_BYTES*2-1:k*2]},bitz[k]);
	      assign bits=offsz[k] ? bitz[WIDTH_IN_BYTES-1:0]<<k : {WIDTH_IN_BYTES{1'bz}};
	      bit_find_first_bit #(6) find_mmod(bitz[WIDTH_IN_BYTES+5-k:WIDTH_IN_BYTES-k],first,has);
	      assign outsz=offsz[k] ? first : 6'bz;
	  end
      end
  endgenerate
endmodule
