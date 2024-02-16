/*
Copyright 2022-2024 Goran Dakov, see additional restriction in copying.txt

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


module mulgen_FA(A,B,C,out,cout);
    input A,B,C;
    output out,cout;
    assign {cout,out}=A+B+C;
endmodule

module mulgen_HA(A,B,out,cout);
    input A,B;
    output out,cout;
    assign {cout,out}=A+B;
endmodule

module nnXor(R,C,and1,sig,val);
    input R;
    input C;
    input and1;
    input sig;
    output val;

    assign val=((R&C&and1)^sig);
endmodule
