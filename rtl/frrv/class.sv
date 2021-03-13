

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
  assign subIsAddI4=instr[15:13]==3'b0 && instr[1:0]==2'b0 && instr[12:5]!=8'b0;

  assign isLoad=opcode_main[6:3]==4'b0 && opcode_main[1:0]==2'b11;
  assign isStore=opcode_main[6:3]==4'b0100 && opcode_main[1:0]==2'b11;
  assign isBasicALU=!opcode_main[6] && opcode_main[4:2]==3'b100 && opcode_main[1:0]==2'b11;
  assign isBasicALU32=!opcode_main[6] && opcode_main[4:2]==3'b110 && opcode_main[1:0]==2'b11;
  assign isAdvALUorJump=(instr[6:5]==2'b11 && !instr[4] && instr[2] && !(!instr[3] && instr[14:12]!=3'b0)) |
	  (!instr[6] && instr[4:2]==3'b101) && opcode_main[1:0]==2'b11;
  assign isOpFp=instr[6:2]==5'b10100 && opcode_main[1:0]==2'b11;
  assign isFpFma=opcode_main[6:4]==2'b100 && opcode_main[1:0]==2'b11;
  assign isJump=opcode_main[6:0]==5'b1100011;
  assign isSys=opcode_main[6:0]==5'b1110011;

  assign clsStore=|{subIsBasicLDST|subIsStackLDST && instr[15],
      isStore};
  assign clsLoad=|{subIsBasicLDST|subIsStackLDST && ~instr[15],
      isLoad};
  assign clsLoadFPU=|{subIsBasicLDST|subIsStackLDST && instr[15:13]==3'd1,
      isLoad & opcode_main[2]};

  assign clsShift=|{subIsReg3Alu && instr[11:10]!=2'b11,isFpFma,
      isBasicALU && instr[6:5]==2'b0 && instr[13:12]==2'b01 && !instr[31] && instr[29:26]==4'b0,
      isBasicALU && instr[6:5]==2'b0 && instr[13:12]!=2'b01 && instr[14:13]==2'b01};
  assign clsMul=|{isntr[15:13]=3'b100 && instr[1:0]==2'b10 && instr[6:2]==5'b0 && instr[11:7]!=5'b0};
  assign clsALU=|{subIsReg3Alu && instr[11:10]==2'b11,
    subIsBasicImmAluReg5 && !(isntr[15:13]=3'b100 && instr[1:0]==2'b10 && instr[6:2]==5'b0 && instr[11:7]!=5'b0),
    subIs2xReg5Alu,subIsReg3Alu && instr[11:10]==2'b11,
    subIsJMP & instr[14],
    subIsAddI4,
    isLoad & !opcode_main[2] & !instr[14] & ~&instr[13:12],
    isFpFma,isJump,
    isBasicALU && instr[6:5]==2'b0 && instr[13:12]!=2'b01};
  assign clsJump=|{isJump,subIsJMP,
    instr[15:13]==3'b100 && instr[1:0]==2'b10 && instr[6:2]==5'b0 && instr[11:7]!=5'b0,
    instr[6:5]==2'b11 && !instr[4] && instr[2] && !(!instr[3] && instr[14:12]!=3'b0)};
  assign clsIndir=|{instr[15:13]==3'b100 && instr[1:0]==2'b10 && instr[6:2]==5'b0 && instr[11:7]!=5'b0,
    instr[6:5]==2'b11 && !instr[4] && instr[2] && !instr[3]};
endmodule
