module funct_gen(
//functional units inputs/outputs
 //top to bottom
  input [DATA_WIDTH-1:0] FU0;
  input [REG_WIDTH-1:0] FUreg0;
  input FUwen0;
  
  input [DATA_WIDTH-1:0] FU1;
  input [REG_WIDTH-1:0] FUreg1;
  input FUwen1;

  input [DATA_WIDTH-1:0] FU2;
  input [REG_WIDTH-1:0] FUreg2;
  input FUwen2;

  input [DATA_WIDTH-1:0] FU3;
  input [REG_WIDTH-1:0] FUreg3;
  input FUwen3;

  input [DATA_WIDTH-1:0] FU4;
  input [REG_WIDTH-1:0] FUreg4;
  input FUwen4;

  input [DATA_WIDTH-1:0] FU5;
  input [REG_WIDTH-1:0] FUreg5;
  input FUwen5;

  input [DATA_WIDTH-1:0] FU6;
  input [REG_WIDTH-1:0] FUreg6;
  input FUwen6;

  input [DATA_WIDTH-1:0] FU7;
  input [REG_WIDTH-1:0] FUreg7;
  input FUwen7;

  input [DATA_WIDTH-1:0] FU8;
  input [REG_WIDTH-1:0] FUreg8;
  input FUwen8;

  input [DATA_WIDTH-1:0] FU9;
  input [REG_WIDTH-1:0] FUreg9;
  input FUwen9;
  
//FLAGS FU*
  input [FLAGS_WIDTH-1:0] FUS0;
  input [FLAGS_WIDTH-1:0] FUS1;
  input [FLAGS_WIDTH-1:0] FUS2;
  input [FLAGS_WIDTH-1:0] FUS3;
  input [FLAGS_WIDTH-1:0] FUS4;
  input [FLAGS_WIDTH-1:0] FUS5;
  input [FLAGS_WIDTH-1:0] FUS6;
  input [FLAGS_WIDTH-1:0] FUS7;
  input [FLAGS_WIDTH-1:0] FUS8;

  input [DATA_WIDTH-1:0] newDataA0;
  input [DATA_WIDTH-1:0] newDataB0;
  input [DATA_WIDTH-1:0] newDataA1;
  input [DATA_WIDTH-1:0] newDataB1;
  input [DATA_WIDTH-1:0] newDataA2;
  input [DATA_WIDTH-1:0] newDataB2;
  input [5:0] newDataS1;
  input [5:0] newDataS2;
//left to right; in->left out->right 
  input [BUF_COUNT-1:0] newRsSelect0;
  input [BUF_COUNT-1:0] newRsSelect1;
  input [BUF_COUNT-1:0] newRsSelect2;

  input [2:0][BUF_COUNT-1:0] outRsSelect;
  input [2:0][3:0] outBank;
  input [2:0] rsFound;
  input [2:0] rsFoundNZ;
  
  input [6*BUF_COUNT-1:0] outEqA;
  input [6*BUF_COUNT-1:0] outEqB;
  input [6*BUF_COUNT-1:0]  outEqS;
  
  input [BUF_COUNT-1:0] newRsSelect0;
  input [BUF_COUNT-1:0] newRsSelect1;
  input [BUF_COUNT-1:0] newRsSelect2;

  input [2:0][BUF_COUNT-1:0] outRsSelect;
  input [2:0][3:0] outBank;
  input [2:0] rsFound;
  input [2:0] rsFoundNZ;
  
  input [6*BUF_COUNT-1:0] outEqA;
  input [6*BUF_COUNT-1:0] outEqB;
  input [6*BUF_COUNT-1:0]  outEqS;
  
  input [BUF_COUNT-1:0] newRsSelect0_reg;
  input [BUF_COUNT-1:0] newRsSelect1_reg;
  input [BUF_COUNT-1:0] newRsSelect2_reg;

  input [2:0][BUF_COUNT-1:0] outRsSelect_reg;
  input [2:0][3:0] outBank_reg;
  input [2:0] rsFound_reg;
  input [2:0] rsFoundNZ_reg;
  
  input [6*BUF_COUNT-1:0] outEqA_reg;
  input [6*BUF_COUNT-1:0] outEqB_reg;
  input [6*BUF_COUNT-1:0]  outEqS_reg;
  
  input [BUF_COUNT-1:0] newRsSelect0_reg;
  input [BUF_COUNT-1:0] newRsSelect1_reg;
  input [BUF_COUNT-1:0] newRsSelect2_reg;

  input [2:0][BUF_COUNT-1:0] outRsSelect_reg;
  input [2:0][3:0] outBank_reg;
  input [2:0] rsFound_reg;
  input [2:0] rsFoundNZ_reg;
  
  input [6*BUF_COUNT-1:0] outEqA_reg;
  input [6*BUF_COUNT-1:0] outEqB_reg;
  input [6*BUF_COUNT-1:0]  outEqS_reg;
  
  rs_wakeUp_data_array #(6) dataS_G_mod(
  clk,dataRst,stall|doStall,
  32'b0,,
  newRsSelect1,newDataS1,
  newRsSelect2,newDataS2,
  outEqS_reg,
  FUS0,FUS1,FUS2,
  FUS3,FUS4,FUS5,
  FUS6,FUS7,FUS8,6'b0,
  32'B0,4'b0,1'b0,,
  outRsSelect[1],outBank[1],rsFoundNZ[1],outDataS1,
  outRsSelect[2],outBank[2],rsFoundNZ[2],outDataS2
  );
  
  rs_wakeUp_data_array #(DATA_WIDTH) dataA_G_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newDataA0,
  newRsSelect1,newDataA1,
  newRsSelect2,newDataA2,
  outEqA,
  FU0,FU1,FU2,FU3,
  FU4,FU5,FU6,
  FU7,FU8,FU9,
  outRsSelect[0],outBank[0],rsFoundNZ[0],outDataA0,
  outRsSelect[1],outBank[1],rsFoundNZ[1],outDataA1,
  outRsSelect[2],outBank[2],rsFoundNZ[2],outDataA2
  );
  
  rs_wakeUp_data_array #(DATA_WIDTH) dataB_G_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newDataB0,
  newRsSelect1,newDataB1,
  newRsSelect2,newDataB2,
  outEqB,
  FU0,FU1,FU2,FU3,
  FU4,FU5,FU6,
  FU7,FU8,FU9,
  outRsSelect[0],outBank[0],rsFoundNZ[0],outDataB0,
  outRsSelect[1],outBank[1],rsFoundNZ[1],outDataB1,
  outRsSelect[2],outBank[2],rsFoundNZ[2],outDataB2
  );


