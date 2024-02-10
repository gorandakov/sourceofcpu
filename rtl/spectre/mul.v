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

module agusec_mul(
  A,B,res);

  input [63:0] A;
  input [11:0] B;
  output [63:0] res;

  wire [7:0] low;
  wire C;
  wire [6:0] hi;

  agusec_shift8 shf_mod(B[11:7],A[43:4],low);

  adder #(7) add_mod(low[7:1],B[6:0],hi,1'b0,1'b1,C,,,);

  

  assign res[`ptr_exp]=B[11:7];
  assign res[`ptr_low]=low[7:1];
  assign res[`ptr_hi]=hi;
  assign res[`ptr_on_low]=1'b1;
  assign res[43:0]=A[43:0];
endmodule
