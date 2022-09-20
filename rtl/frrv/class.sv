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

module predec_RV_class(instr,flag,class_,isLNK,isRet,LNK2);
  input [31:0] instr;
  input flag;
  output [12:0] class_;
  output isLNK;
  output isRet;
  output [1:0] LNK2;

  wire clsIndir;
  wire clsJump;
  wire clsALU;
  wire clsShift;
  wire clsMul;
  wire clsLoad;
  wire clsStore;
  wire clsStore2;
  wire clsFPU;
  wire clsLoadFPU;
  wire clsSys;
  wire clsPos0;
  
  assign subIsBasicLDST=instr[14:13]!=2'b0 && instr[1:0]==2'b0;
  assign subIsStackLDST=instr[14:13]!=2'b0 && instr[1:0]==2'b10 && !(intr[15:14]=2'b01 && instr[11:7]==5'b0);
  
  assign subIsBasicImmAluReg5=(instr[1:0]==2'b01 && (instr[15:13]==3'b0 || (instr[15:13]==3'b1 &&
   instr[11:7]!=5'b0) || (instr[15:14]==2'b1 && instr[11:7]!=5'b0 && 
   instr[12]| |instr[6:2] |~instr[13])))||(instr[1:0]==2'b10 && instr[15:13]==3'b0 && instr[11:7]!=5'b0);  
  assign subIs2xReg5Alu=instr[1:0]==2'b10 && instr[15:13]==3'b100;
  assign subIsReg3Alu=instr[1:0]==2'b1 && instr[15:13]==3'b100 && !(instr[12:10]==3'b111 && instr[6]);
  assign subIsJMP=instr[1:0]==2'b1 && (instr[15:13]==3'b101 || instr[15:14]==2'b11);

  assign isLoad=opcode_main[6:3]==4'b0 && opcode_main[1:0]==2'b11;
  assign isStore=opcode_main[6:3]==4'b0100 && opcode_main[1:0]==2'b11;
  assign isBasicALU=!opcode_main[6] && opcode_main[4:2]==3'b100 && opcode_main[1:0]==2'b11;
  assign isBasicALU32=!opcode_main[6] && opcode_main[4:2]==3'b110 && opcode_main[1:0]==2'b11;
  assign isAdvALUorJump=(instr[6:5]==2'b11 && instr[4] && instr[2]) |
	  (instr[6] && instr[4:2]==3'b101) && opcode_main[1:0]==2'b11;
  assign isOpFp=instr[6:2]==5'b10100 && opcode_main[1:0]==2'b11;
  assign isFpFma=opcode_main[6:4]==2'b100 && opcode_main[1:0]==2'b11;

  assign clsStore=|{subIsBasicLDST|subIsStackLDST && instr[15],
      isStore};
  assign clsLoad=|{subIsBasicLDST|subIsStackLDST && ~instr[15],
      isLoad};
  assign clsLoadFPU=|{subIsBasicLDST|subIsStackLDST && instr[15:13]==3'd1,
      isLoad & opcode_main[2]};

  assign clsShift=|{subIsReg3Alu && instr[11:10]!=2'b11};
  assign clsMul=|{isntr[15:13]=3'b100 && instr[1:0]==2'b10 && instr[6:2]==5'b0 && instr[11:7]!=5'b0};
  assign clsALU=|{subIsReg3Alu && instr[11:10]==2'b11,
    subIsBasicImmAluReg5 && !(isntr[15:13]=3'b100 && instr[1:0]==2'b10 && instr[6:2]==5'b0 && instr[11:7]!=5'b0),
    subIs2xReg5Alu,subIsReg3Alu && instr[11:10]==2'b11,
    subIsJMP & instr[14]};
endmodule
