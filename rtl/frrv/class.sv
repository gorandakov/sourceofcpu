

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

  assign clsStore=|{subIsBasicLDST|subIsStackLDST && instr[15]};
  assign clsLoad=|{subIsBasicLDST|subIsStackLDST && ~instr[15]};
  assign clsLoadFPU=|{subIsBasicLDST|subIsStackLDST && instr[15:13]==3'd1};

  assign clsShift=|{subIsReg3Alu && instr[11:10]!=2'b11};
  assign clsMul=|{isntr[15:13]=3'b100 && instr[1:0]==2'b10 && instr[6:2]==5'b0 && instr[11:7]!=5'b0};
  assign clsALU=|{subIsReg3Alu && instr[11:10]==2'b11,
    subIsBasicImmAluReg5 && !(isntr[15:13]=3'b100 && instr[1:0]==2'b10 && instr[6:2]==5'b0 && instr[11:7]!=5'b0),
    subIs2xReg5Alu,subIsReg3Alu && instr[11:10]==2'b11,
    subIsJMP & instr[14]};
endmodule
