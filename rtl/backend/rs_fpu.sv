
`include "../struct.sv"

 





module rs_aux(
  clk,
  dataRst,nonDataRst,rst_thread,
  stall,
  doStall,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  new_thread,
// wires to store new values in a buffer
  newDataA0,newDataB0,newRegA0,newRegB0,
    newANeeded0,newBNeeded0,newReg0,newOp0,newPort0,newInstrIndex0,
    rsAlloc0,newGazumpA0,newGazumpB0,newFunitA0,newFunitB0,
  newDataA1,newDataB1,newRegA1,newRegB1,
    newANeeded1,newBNeeded1,newReg1,newRegSimd1,newOp1,newPort1,
    newInstrIndex1,rsAlloc1,newGazumpA1,newGazumpB1,
    newFunitA1,newFunitB1,
  newDataA2,newDataB2,newRegA2,newRegB2,
    newANeeded2,newBNeeded2,newReg2,newRegSimd2,newOp2,newPort2,
    newInstrIndex2,rsAlloc2,newGazumpA2,newGazumpB2,
    newFunitA2,newFunitB2,
// wires to get values out of buffer
  outDataA0,outDataB0,outReg0,outOp0,outInstrIndex0,
    outFuFwdA0,outFuFwdB0,outFuuFwdA0,outFuuFwdB0,outDataEn0,outThread0,
  outDataA1,outDataB1,outReg1,outOp1,outInstrIndex1,
    outFuFwdA1,outFuFwdB1,outFuuFwdA1,outFuuFwdB1,outDataEn1,outThread1,
  outDataA2,outDataB2,outReg2,outOp2,outInstrIndex2,
    outFuFwdA2,outFuFwdB2,outFuuFwdA2,outFuuFwdB2,outDataEn2,outThread2,
// wires from functional units  
  FU0,FUreg0,FUwen0,
  FU1,FUreg1,FUwen1,
  FU2,FUreg2,FUwen2,
  FU3,FUreg3,FUwen3,
  FU4,FUreg4,FUwen4,
  FU5,FUreg5,FUwen5,
  FU6,FUreg6,FUwen6,
  FU7,FUreg7,FUwen7,
  FU8,FUreg8,FUwen8,
  FU9,FUreg9,FUwen9,
  
  newDataVA0H,newDataVB0H,newDataVA0L,newDataVB0L,
  newDataFA0H,newDataFB0H,newDataFA0L,newDataFB0L,
  newDataVA1H,newDataVB1H,newDataVA1L,newDataVB1L,
  newDataFA1H,newDataFB1H,newDataFA1L,newDataFB1L,
  newDataVA2H,newDataVB2H,newDataVA2L,newDataVB2L,
  newDataFA2H,newDataFB2H,newDataFA2L,newDataFB2L,

  outDataVA0H,outDataVB0H,outDataVA0L,outDataVB0L,
  outDataFA0H,outDataFB0H,outDataFA0L,outDataFB0L,
  outDataVA1H,outDataVB1H,outDataVA1L,outDataVB1L,
  outDataFA1H,outDataFB1H,outDataFA1L,outDataFB1L,
  outDataVA2H,outDataVB2H,outDataVA2L,outDataVB2L,
  outDataFA2H,outDataFB2H,outDataFA2L,outDataFB2L,

  FUV0H,FUV0L,FUF0H,FUF0L,
  FUV1H,FUV1L,FUF1H,FUF1L,
  FUV2H,FUV2L,FUF2H,FUF2L,
  FUV3H,FUV3L,FUF3H,FUF3L,
  FUV4H,FUV4L,FUF4H,FUF4L,
  FUV5H,FUV5L,FUF5H,FUF5L,
  FUV6H,FUV6L,FUF6H,FUF6L,
  FUV7H,FUV7L,FUF7H,FUF7L,
  FUV8H,FUV8L,FUF8H,FUF8L,
  FUV9H,FUV9L,FUF9H,FUF9L,

// 1 if buffer is free  
  pause0,pause1,pause2
);
  localparam DATA_WIDTH=`alu_width;
  localparam SIMD_WIDTH=68;//half-width
  localparam REG_WIDTH=`reg_addr_width;
  localparam OPERATION_WIDTH=`operation_width;
  localparam LSQ_WIDTH=`lsqRsNo_width;
  localparam CONST_WIDTH=32;
  localparam FLAGS_WIDTH=6;  
  localparam BUF_COUNT=`rs_buf_count;
  localparam II_WIDTH=10;  
  localparam FN_WIDTH=10;
  localparam WQ_WIDTH=8;
  
  input clk;
  input dataRst;
  input nonDataRst;
  input rst_thread;
  input stall;
  output doStall;
  input FU0Hit;
  input FU1Hit;
  input FU2Hit;
  input FU3Hit;
//Input of new data from registeres
  input new_thread;
  input [DATA_WIDTH-1:0]       newDataA0;
  input [DATA_WIDTH-1:0]       newDataB0;
  input [REG_WIDTH-1:0] newRegA0; 
  input [REG_WIDTH-1:0] newRegB0; 
  input newANeeded0;
  input newBNeeded0;
  input [REG_WIDTH-1:0] newReg0;
  input [OPERATION_WIDTH-1:0]   newOp0;
  input [3:0] newPort0;
  input [II_WIDTH-1:0] newInstrIndex0;  
  input rsAlloc0;
  input [10:0] newGazumpA0;
  input [10:0] newGazumpB0;
  input [FN_WIDTH-1:0] newFunitA0;
  input [FN_WIDTH-1:0] newFunitB0;

  input [DATA_WIDTH-1:0]       newDataA1;
  input [DATA_WIDTH-1:0]       newDataB1;
  input [REG_WIDTH-1:0] newRegA1; 
  input [REG_WIDTH-1:0] newRegB1; 
  input newANeeded1;
  input newBNeeded1;
  input [REG_WIDTH-1:0] newReg1;
  input [OPERATION_WIDTH-1:0]   newOp1;
  input [3:0] newPort1;  
  input [II_WIDTH-1:0] newInstrIndex1;
  input rsAlloc1;
  input [10:0] newGazumpA1;
  input [10:0] newGazumpB1;
  input [FN_WIDTH-1:0] newFunitA1;
  input [FN_WIDTH-1:0] newFunitB1;

  input [DATA_WIDTH-1:0]       newDataA2;
  input [DATA_WIDTH-1:0]       newDataB2;
  input [REG_WIDTH-1:0] newRegA2; 
  input [REG_WIDTH-1:0] newRegB2; 
  input newANeeded2;
  input newBNeeded2;
  input [REG_WIDTH-1:0] newReg2;
  input [OPERATION_WIDTH-1:0]   newOp2;
  input [3:0] newPort2;  
  input [II_WIDTH-1:0] newInstrIndex2;
  input rsAlloc2;
  input [10:0] newGazumpA2;
  input [10:0] newGazumpB2;
  input [FN_WIDTH-1:0] newFunitA2;
  input [FN_WIDTH-1:0] newFunitB2;
  
// output data to functional units

  output wire [DATA_WIDTH-1:0]       outDataA0;
  output wire [DATA_WIDTH-1:0]       outDataB0;//b USED AS BASE REG
  output wire [REG_WIDTH-1:0] outReg0;
  output wire [OPERATION_WIDTH-1:0]   outOp0;
  output wire [II_WIDTH-1:0] outInstrIndex0;
  output [3:0] outFuFwdA0;
  output [3:0] outFuFwdB0;
  output [3:0] outFuuFwdA0;
  output [3:0] outFuuFwdB0;
  output [3:0] outDataEn0;
  output outThread0;
    
  output wire [DATA_WIDTH-1:0]       outDataA1;
  output wire [DATA_WIDTH-1:0]       outDataB1;
  output wire [REG_WIDTH-1:0] outReg1;
  output wire [OPERATION_WIDTH-1:0]   outOp1;
  output wire [II_WIDTH-1:0] outInstrIndex1;
  output [3:0] outFuFwdA1;
  output [3:0] outFuFwdB1;
  output [3:0] outFuuFwdA1;
  output [3:0] outFuuFwdB1;
  output [3:0] outDataEn1;
  output outThread1;

  output wire [DATA_WIDTH-1:0]       outDataA2;
  output wire [DATA_WIDTH-1:0]       outDataB2;
  output wire [REG_WIDTH-1:0] outReg2;
  output wire [OPERATION_WIDTH-1:0]   outOp2;
  output wire [II_WIDTH-1:0] outInstrIndex2;
  output [3:0] outFuFwdA2;
  output [3:0] outFuFwdB2;
  output [3:0] outFuuFwdA2;
  output [3:0] outFuuFwdB2;
  output [3:0] outDataEn2;
  output outThread2;

  

//functional units inputs/outputs
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
  
//SIMD
  input [SIMD_WIDTH-1:0] newDataVA0H;
  input [SIMD_WIDTH-1:0] newDataVB0H;
  input [SIMD_WIDTH-1:0] newDataVA0L;
  input [SIMD_WIDTH-1:0] newDataVB0L;
  
  input [SIMD_WIDTH-1:0] newDataFA0H;
  input [SIMD_WIDTH-1:0] newDataFB0H;
  input [SIMD_WIDTH-1:0] newDataFA0L;
  input [SIMD_WIDTH-1:0] newDataFB0L;

  input [SIMD_WIDTH-1:0] newDataVA1H;
  input [SIMD_WIDTH-1:0] newDataVB1H;
  input [SIMD_WIDTH-1:0] newDataVA1L;
  input [SIMD_WIDTH-1:0] newDataVB1L;
  
  input [SIMD_WIDTH-1:0] newDataFA1H;
  input [SIMD_WIDTH-1:0] newDataFB1H;
  input [SIMD_WIDTH-1:0] newDataFA1L;
  input [SIMD_WIDTH-1:0] newDataFB1L;

  input [SIMD_WIDTH-1:0] newDataVA2H;
  input [SIMD_WIDTH-1:0] newDataVB2H;
  input [SIMD_WIDTH-1:0] newDataVA2L;
  input [SIMD_WIDTH-1:0] newDataVB2L;
  
  input [SIMD_WIDTH-1:0] newDataFA2H;
  input [SIMD_WIDTH-1:0] newDataFB2H;
  input [SIMD_WIDTH-1:0] newDataFA2L;
  input [SIMD_WIDTH-1:0] newDataFB2L;

  output [SIMD_WIDTH-1:0] outDataVA0H;
  output [SIMD_WIDTH-1:0] outDataVB0H;
  output [SIMD_WIDTH-1:0] outDataVA0L;
  output [SIMD_WIDTH-1:0] outDataVB0L;
  
  output [SIMD_WIDTH-1:0] outDataFA0H;
  output [SIMD_WIDTH-1:0] outDataFB0H;
  output [SIMD_WIDTH-1:0] outDataFA0L;
  output [SIMD_WIDTH-1:0] outDataFB0L;

  output [SIMD_WIDTH-1:0] outDataVA1H;
  output [SIMD_WIDTH-1:0] outDataVB1H;
  output [SIMD_WIDTH-1:0] outDataVA1L;
  output [SIMD_WIDTH-1:0] outDataVB1L;
  
  output [SIMD_WIDTH-1:0] outDataFA1H;
  output [SIMD_WIDTH-1:0] outDataFB1H;
  output [SIMD_WIDTH-1:0] outDataFA1L;
  output [SIMD_WIDTH-1:0] outDataFB1L;

  output [SIMD_WIDTH-1:0] outDataVA2H;
  output [SIMD_WIDTH-1:0] outDataVB2H;
  output [SIMD_WIDTH-1:0] outDataVA2L;
  output [SIMD_WIDTH-1:0] outDataVB2L;
  
  output [SIMD_WIDTH-1:0] outDataFA2H;
  output [SIMD_WIDTH-1:0] outDataFB2H;
  output [SIMD_WIDTH-1:0] outDataFA2L;
  output [SIMD_WIDTH-1:0] outDataFB2L;

  input [SIMD_WIDTH-1:0] FUV0H;
  input [SIMD_WIDTH-1:0] FUV0L;
  
  input [SIMD_WIDTH-1:0] FUF0H;
  input [SIMD_WIDTH-1:0] FUF0L;

  input [SIMD_WIDTH-1:0] FUV1H;
  input [SIMD_WIDTH-1:0] FUV1L;
  
  input [SIMD_WIDTH-1:0] FUF1H;
  input [SIMD_WIDTH-1:0] FUF1L;

  input [SIMD_WIDTH-1:0] FUV2H;
  input [SIMD_WIDTH-1:0] FUV2L;
  
  input [SIMD_WIDTH-1:0] FUF2H;
  input [SIMD_WIDTH-1:0] FUF2L;

  input [SIMD_WIDTH-1:0] FUV3H;
  input [SIMD_WIDTH-1:0] FUV3L;
  
  input [SIMD_WIDTH-1:0] FUF3H;
  input [SIMD_WIDTH-1:0] FUF3L;

  input [SIMD_WIDTH-1:0] FUV4H;
  input [SIMD_WIDTH-1:0] FUV4L;
  
  input [SIMD_WIDTH-1:0] FUF4H;
  input [SIMD_WIDTH-1:0] FUF4L;

  input [SIMD_WIDTH-1:0] FUV5H;
  input [SIMD_WIDTH-1:0] FUV5L;
  
  input [SIMD_WIDTH-1:0] FUF5H;
  input [SIMD_WIDTH-1:0] FUF5L;

  input [SIMD_WIDTH-1:0] FUV6H;
  input [SIMD_WIDTH-1:0] FUV6L;
  
  input [SIMD_WIDTH-1:0] FUF6H;
  input [SIMD_WIDTH-1:0] FUF6L;

  input [SIMD_WIDTH-1:0] FUV7H;
  input [SIMD_WIDTH-1:0] FUV7L;
  
  input [SIMD_WIDTH-1:0] FUF7H;
  input [SIMD_WIDTH-1:0] FUF7L;

  input [SIMD_WIDTH-1:0] FUV8H;
  input [SIMD_WIDTH-1:0] FUV8L;
  
  input [SIMD_WIDTH-1:0] FUF8H;
  input [SIMD_WIDTH-1:0] FUF8L;

  input [SIMD_WIDTH-1:0] FUV9H;
  input [SIMD_WIDTH-1:0] FUV9L;
  
  input [SIMD_WIDTH-1:0] FUF9H;
  input [SIMD_WIDTH-1:0] FUF9L;

  
  
  input pause0;
  input pause1;
  input pause2;

  wire [BUF_COUNT-1:0] bufFree;
  
  wire [BUF_COUNT-1:0] newRsSelect0;
  wire [BUF_COUNT-1:0] newRsSelect1;
  wire [BUF_COUNT-1:0] newRsSelect2;
  
  wire [BUF_COUNT-1:0] outRsSelect[2:0];
  wire [BUF_COUNT-1:0] portReady[2:0];
  wire [3:0] outBank[2:0];
  wire [2:0] portEn;
  wire [2:0] rsFound;
  
  wire [127:0] fuFwdA;
  wire [127:0] fuFwdB;
  wire [BUF_COUNT-1:0] isDataA;
  wire [BUF_COUNT-1:0] isDataB;

  wire [FLAGS_WIDTH-1:0] outDataS0;
  wire [3:0] outFuFwdS0;
  wire [3:0] outFuuFwdS0;
  wire [127:0] fuFwdS;

  
  wire [6*BUF_COUNT-1:0] outEqA;
  wire [6*BUF_COUNT-1:0] outEqB;
  wire [6*BUF_COUNT-1:0] outEqA_reg;
  wire [6*BUF_COUNT-1:0] outEqB_reg;
  wire [6*BUF_COUNT-1:0] outEqA_reg2;
  wire [6*BUF_COUNT-1:0] outEqB_reg2;
  wire [6*BUF_COUNT-1:0] outEqA_reg3;
  wire [6*BUF_COUNT-1:0] outEqB_reg3;
  wire [BUF_COUNT-1:0] newRsSelect0_reg;
  wire [BUF_COUNT-1:0] newRsSelect1_reg;
  wire [BUF_COUNT-1:0] newRsSelect2_reg;
  wire [BUF_COUNT-1:0] newRsSelect0_reg2;
  wire [BUF_COUNT-1:0] newRsSelect1_reg2;
  wire [BUF_COUNT-1:0] newRsSelect2_reg2;
  wire [BUF_COUNT-1:0] newRsSelect0_reg3;
  wire [BUF_COUNT-1:0] newRsSelect1_reg3;
  wire [BUF_COUNT-1:0] newRsSelect2_reg3;
  wire [BUF_COUNT-1:0] outRsSelect_reg[2:0];
  wire [BUF_COUNT-1:0] outRsSelect_reg2[2:0];
  wire [BUF_COUNT-1:0] outRsSelect_reg3[2:0];
  wire [3:0] outBank_reg[2:0];
  wire [3:0] outBank_reg2[2:0];
  wire [3:0] outBank_reg3[2:0];
  wire [2:0] rsFound_reg;
  wire [2:0] rsFound_reg2;
  wire [2:0] rsFound_reg3;
  

  rs_array rs_mod(
  clk,
  dataRst,nonDataRst,rst_thread,
  stall|doStall,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  new_thread,
// wires to store new values in a buffer
  newANeeded0,newBNeeded0,1'b0,newRsSelect0,newPort0,
  newANeeded1,newBNeeded1,1'b0,newRsSelect1,newPort1,
  newANeeded2,newBNeeded2,1'b0,newRsSelect2,newPort2,
// wires to get values out of buffer
  outRsSelect[0],outBank[0],rsFound[0],portReady[0],outDataEn0,outThread0,
  outRsSelect[1],outBank[1],rsFound[1],portReady[1],outDataEn1,outThread1,
  outRsSelect[2],outBank[2],rsFound[2],portReady[2],outDataEn2,outThread2,
  fuFwdA,fuFwdB,
  isDataA,isDataB,32'b0,
// 1 if buffer is free  
  bufFree
  );
 

  
  DFF2 #(32*6) outEqA_mod(clk,dataRst,1'b1,outEqA,outEqA_reg);
  DFF2 #(32*6) outEqB_mod(clk,dataRst,1'b1,outEqB,outEqB_reg);
  DFF2 #(32*6) outEqA2_mod(clk,dataRst,1'b1,outEqA_reg,outEqA_reg2);
  DFF2 #(32*6) outEqB2_mod(clk,dataRst,1'b1,outEqB_reg,outEqB_reg2);
  DFF2 #(32*6) outEqA3_mod(clk,dataRst,1'b1,outEqA_reg2,outEqA_reg3);
  DFF2 #(32*6) outEqB3_mod(clk,dataRst,1'b1,outEqB_reg2,outEqB_reg3);

  DFF2 #(32) outNew0_mod(clk,dataRst,1'b1,newRsSelect0,newRsSelect0_reg);
  DFF2 #(32) outNew1_mod(clk,dataRst,1'b1,newRsSelect1,newRsSelect1_reg);
  DFF2 #(32) outNew2_mod(clk,dataRst,1'b1,newRsSelect2,newRsSelect2_reg);
  DFF2 #(32) outSel0_mod(clk,dataRst,1'b1,outRsSelect[0],outRsSelect_reg[0]);
  DFF2 #(32) outSel1_mod(clk,dataRst,1'b1,outRsSelect[1],outRsSelect_reg[1]);
  DFF2 #(32) outSel2_mod(clk,dataRst,1'b1,outRsSelect[2],outRsSelect_reg[2]);
  DFF2 #(4) outBnk0_mod(clk,dataRst,1'b1,outBank[0],outBank_reg[0]);
  DFF2 #(4) outBnk1_mod(clk,dataRst,1'b1,outBank[1],outBank_reg[1]);
  DFF2 #(4) outBnk2_mod(clk,dataRst,1'b1,outBank[2],outBank_reg[2]);
  DFF2 #(1) outFnd0_mod(clk,dataRst,1'b1,rsFound[0],rsFound_reg[0]);
  DFF2 #(1) outFnd1_mod(clk,dataRst,1'b1,rsFound[1],rsFound_reg[1]);
  DFF2 #(1) outFnd2_mod(clk,dataRst,1'b1,rsFound[2],rsFound_reg[2]);

  DFF2 #(32) out2New0_mod(clk,dataRst,1'b1,newRsSelect0_reg,newRsSelect0_reg2);
  DFF2 #(32) out2New1_mod(clk,dataRst,1'b1,newRsSelect1_reg,newRsSelect1_reg2);
  DFF2 #(32) out2New2_mod(clk,dataRst,1'b1,newRsSelect2_reg,newRsSelect2_reg2);
  DFF2 #(32) out2Sel0_mod(clk,dataRst,1'b1,outRsSelect_reg[0],outRsSelect_reg2[0]);
  DFF2 #(32) out2Sel1_mod(clk,dataRst,1'b1,outRsSelect_reg[1],outRsSelect_reg2[1]);
  DFF2 #(32) out2Sel2_mod(clk,dataRst,1'b1,outRsSelect_reg[2],outRsSelect_reg2[2]);
  DFF2 #(4) out2Bnk0_mod(clk,dataRst,1'b1,outBank_reg[0],outBank_reg2[0]);
  DFF2 #(4) out2Bnk1_mod(clk,dataRst,1'b1,outBank_reg[1],outBank_reg2[1]);
  DFF2 #(4) out2Bnk2_mod(clk,dataRst,1'b1,outBank_reg[2],outBank_reg2[2]);
  DFF2 #(1) out2Fnd0_mod(clk,dataRst,1'b1,rsFound_reg[0],rsFound_reg2[0]);
  DFF2 #(1) out2Fnd1_mod(clk,dataRst,1'b1,rsFound_reg[1],rsFound_reg2[1]);
  DFF2 #(1) out2Fnd2_mod(clk,dataRst,1'b1,rsFound_reg[2],rsFound_reg2[2]);

  DFF2 #(32) out3New0_mod(clk,dataRst,1'b1,newRsSelect0_reg2,newRsSelect0_reg3);
  DFF2 #(32) out3New1_mod(clk,dataRst,1'b1,newRsSelect1_reg2,newRsSelect1_reg3);
  DFF2 #(32) out3New2_mod(clk,dataRst,1'b1,newRsSelect2_reg2,newRsSelect2_reg3);
  DFF2 #(32) out3Sel0_mod(clk,dataRst,1'b1,outRsSelect_reg2[0],outRsSelect_reg3[0]);
  DFF2 #(32) out3Sel1_mod(clk,dataRst,1'b1,outRsSelect_reg2[1],outRsSelect_reg3[1]);
  DFF2 #(32) out3Sel2_mod(clk,dataRst,1'b1,outRsSelect_reg2[2],outRsSelect_reg3[2]);
  DFF2 #(4) out3Bnk0_mod(clk,dataRst,1'b1,outBank_reg2[0],outBank_reg3[0]);
  DFF2 #(4) out3Bnk1_mod(clk,dataRst,1'b1,outBank_reg2[1],outBank_reg3[1]);
  DFF2 #(4) out3Bnk2_mod(clk,dataRst,1'b1,outBank_reg2[2],outBank_reg3[2]);
  DFF2 #(1) out3Fnd0_mod(clk,dataRst,1'b1,rsFound_reg2[0],rsFound_reg3[0]);
  DFF2 #(1) out3Fnd1_mod(clk,dataRst,1'b1,rsFound_reg2[1],rsFound_reg3[1]);
  DFF2 #(1) out3Fnd2_mod(clk,dataRst,1'b1,rsFound_reg2[2],rsFound_reg3[2]);

  generate
      genvar k;
      for (k=0;k<3;k=k+1) begin : sel_gen
          rsSelectFifo #(1'b0) sel0_mod(
          clk,
          dataRst,
          nonDataRst,
          portReady[k],
          portEn[k],
          rsFound[k],
          outRsSelect[k],
          outBank[k]
          );
      end
  
  endgenerate

  rsAlloc3 alloc_mod(
  clk,
  rsAlloc0,rsAlloc1,rsAlloc2,
  bufFree,
  newRsSelect0,
  newRsSelect1,
  newRsSelect2,
  doStall,
  stall
  );
  
  rs_wakeUp_logic_array #(DATA_WIDTH) dataA_L_mod(
  clk,dataRst,stall|doStall,
  isDataA,
  outEqA,
  bufFree,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  FUreg0,FUwen0,
  FUreg1,FUwen1,
  FUreg2,FUwen2,
  FUreg3,FUwen3,
  FUreg4,FUwen4,
  FUreg5,FUwen5,
  FUreg6,FUwen6,
  FUreg7,FUwen7,
  FUreg8,FUwen8,
  FUreg9,FUwen9,
  newRsSelect0,newRegA0,newFunitA0,newGazumpA0,newPort0[3],newPort0[2],
  newRsSelect1,newRegA1,newFunitA1,newGazumpA1,newPort1[3],newPort1[2],
  newRsSelect2,newRegA2,newFunitA2,newGazumpA2,newPort2[3],newPort2[2],
  fuFwdA,
  outRsSelect[0],outDataEn0[0],outBank[0],rsFound[0],outFuFwdA0,outFuuFwdA0,
  outRsSelect[1],outDataEn1[0],outBank[1],rsFound[1],outFuFwdA1,outFuuFwdA1,
  outRsSelect[2],outDataEn2[0],outBank[2],rsFound[2],outFuFwdA2,outFuuFwdA2
  );

  rs_wakeUp_logic_array #(DATA_WIDTH) dataB_L_mod(
  clk,dataRst,stall|doStall,
  isDataB,
  outEqB,
  bufFree,
  FU0Hit,FU1Hit,FU2Hit,FU3Hit,
  FUreg0,FUwen0,
  FUreg1,FUwen1,
  FUreg2,FUwen2,
  FUreg3,FUwen3,
  FUreg4,FUwen4,
  FUreg5,FUwen5,
  FUreg6,FUwen6,
  FUreg7,FUwen7,
  FUreg8,FUwen8,
  FUreg9,FUwen9,
  newRsSelect0,newRegB0,newFunitB0,newGazumpB0,newPort0[3],newPort0[2],
  newRsSelect1,newRegB1,newFunitB1,newGazumpB1,newPort1[3],newPort1[2],
  newRsSelect2,newRegB2,newFunitB2,newGazumpB2,newPort2[3],newPort2[2],
  fuFwdB,
  outRsSelect[0],outDataEn0[0],outBank[0],rsFound[0],outFuFwdB0,outFuuFwdB0,
  outRsSelect[1],outDataEn1[0],outBank[1],rsFound[1],outFuFwdB1,outFuuFwdB1,
  outRsSelect[2],outDataEn2[0],outBank[2],rsFound[2],outFuFwdB2,outFuuFwdB2
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
  outRsSelect[0],outBank[0],rsFound[0],outDataA0,
  outRsSelect[1],outBank[1],rsFound[1],outDataA1,
  outRsSelect[2],outBank[2],rsFound[2],outDataA2
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
  outRsSelect[0],outBank[0],rsFound[0],outDataB0,
  outRsSelect[1],outBank[1],rsFound[1],outDataB1,
  outRsSelect[2],outBank[2],rsFound[2],outDataB2
  );

  rs_wakeUp_data_array #(SIMD_WIDTH) dataA_VH_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg,newDataVA0H,
  newRsSelect1_reg,newDataVA1H,
  newRsSelect2_reg,newDataVA2H,
  outEqA_reg,
  FUV0H,FUV1H,FUV2H,FUV3H,
  FUV4H,FUV5H,FUV6H,
  FUV7H,FUV8H,FUV9H,
  outRsSelect_reg[0],outBank_reg[0],rsFound_reg[0],outDataVA0H,
  outRsSelect_reg[1],outBank_reg[1],rsFound_reg[1],outDataVA1H,
  outRsSelect_reg[2],outBank_reg[2],rsFound_reg[2],outDataVA2H
  );
  
  rs_wakeUp_data_array #(SIMD_WIDTH) dataB_VH_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg,newDataVB0H,
  newRsSelect1_reg,newDataVB1H,
  newRsSelect2_reg,newDataVB2H,
  outEqB_reg,
  FUV0H,FUV1H,FUV2H,FUV3H,
  FUV4H,FUV5H,FUV6H,
  FUV7H,FUV8H,FUV9H,
  outRsSelect_reg[0],outBank_reg[0],rsFound_reg[0],outDataVB0H,
  outRsSelect_reg[1],outBank_reg[1],rsFound_reg[1],outDataVB1H,
  outRsSelect_reg[2],outBank_reg[2],rsFound_reg[2],outDataVB2H
  );

  rs_wakeUp_data_array #(SIMD_WIDTH) dataA_VL_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg,newDataVA0L,
  newRsSelect1_reg,newDataVA1L,
  newRsSelect2_reg,newDataVA2L,
  outEqA_reg,
  FUV0L,FUV1L,FUV2L,FUV3L,
  FUV4L,FUV5L,FUV6L,
  FUV7L,FUV8L,FUV9L,
  outRsSelect_reg[0],outBank_reg[0],rsFound_reg[0],outDataVA0L,
  outRsSelect_reg[1],outBank_reg[1],rsFound_reg[1],outDataVA1L,
  outRsSelect_reg[2],outBank_reg[2],rsFound_reg[2],outDataVA2L
  );
  
  rs_wakeUp_data_array #(SIMD_WIDTH) dataB_VL_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg,newDataVB0L,
  newRsSelect1_reg,newDataVB1L,
  newRsSelect2_reg,newDataVB2L,
  outEqB_reg,
  FUV0L,FUV1L,FUV2L,FUV3L,
  FUV4L,FUV5L,FUV6L,
  FUV7L,FUV8L,FUV9L,
  outRsSelect_reg[0],outBank_reg[0],rsFound_reg[0],outDataVB0L,
  outRsSelect_reg[1],outBank_reg[1],rsFound_reg[1],outDataVB1L,
  outRsSelect_reg[2],outBank_reg[2],rsFound_reg[2],outDataVB2L
  );

  rs_wakeUp_data_array #(SIMD_WIDTH) dataA_FH_mod(
  clk,dataRst,stall|doStall,`
  newRsSelect0_reg2,newDataFA0H,
  newRsSelect1_reg2,newDataFA1H,
  newRsSelect2_reg2,newDataFA2H,
  outEqA_reg2,
  FUF0H,FUF1H,FUF2H,FUF3H,
  FUF4H,FUF5H,FUF6H,
  FUF7H,FUF8H,FUF9H,
  outRsSelect_reg2[0],outBank_reg2[0],rsFound_reg2[0],outDataFA0H,
  outRsSelect_reg2[1],outBank_reg2[1],rsFound_reg2[1],outDataFA1H,
  outRsSelect_reg2[2],outBank_reg2[2],rsFound_reg2[2],outDataFA2H
  );
  
  rs_wakeUp_data_array #(SIMD_WIDTH) dataB_FH_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg2,newDataFB0H,
  newRsSelect1_reg2,newDataFB1H,
  newRsSelect2_reg2,newDataFB2H,
  outEqB_reg2,
  FUF0H,FUF1H,FUF2H,FUF3H,
  FUF4H,FUF5H,FUF6H,
  FUF7H,FUF8H,FUF9H,
  outRsSelect_reg2[0],outBank_reg2[0],rsFound_reg2[0],outDataFB1H,
  outRsSelect_reg2[1],outBank_reg2[1],rsFound_reg2[1],outDataFB1H,
  outRsSelect_reg2[2],outBank_reg2[2],rsFound_reg2[2],outDataFB2H
  );

  rs_wakeUp_data_array #(SIMD_WIDTH) dataA_FL_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg2,newDataFA0L,
  newRsSelect1_reg2,newDataFA1L,
  newRsSelect2_reg2,newDataFA2L,
  outEqA_reg2,
  FUF0L,FUF1L,FUF2L,FUF3L,
  FUF4L,FUF5L,FUF6L,
  FUF7L,FUF8L,FUF9L,
  outRsSelect_reg2[0],outBank_reg2[0],rsFound_reg2[0],outDataFA0L,
  outRsSelect_reg2[1],outBank_reg2[1],rsFound_reg2[1],outDataFA1L,
  outRsSelect_reg2[2],outBank_reg2[2],rsFound_reg2[2],outDataFA2L
  );
  
  rs_wakeUp_data_array #(SIMD_WIDTH) dataB_FL_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0_reg2,newDataFB0L,
  newRsSelect1_reg2,newDataFB1L,
  newRsSelect2_reg2,newDataFB2L,
  outEqB_reg2,
  FUF0L,FUF1L,FUF2L,FUF3L,
  FUF4L,FUF5L,FUF6L,
  FUF7L,FUF8L,FUF9L,
  outRsSelect_reg2[0],outBank_reg2[0],rsFound_reg2[0],outDataFB0L,
  outRsSelect_reg2[1],outBank_reg2[1],rsFound_reg2[1],outDataFB1L,
  outRsSelect_reg2[2],outBank_reg2[2],rsFound_reg2[2],outDataFB2L
  );


  
  rs_nonWakeUp_array #(OPERATION_WIDTH) op_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newOp0,
  newRsSelect1,newOp1,
  newRsSelect2,newOp2,
  
  outRsSelect[0],outBank[0],rsFound[0],outOp0,
  outRsSelect[1],outBank[1],rsFound[1],outOp1,
  outRsSelect[2],outBank[2],rsFound[2],outOp2
  );
  
  
  rs_nonWakeUp_array #(REG_WIDTH) reg_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newReg0,
  newRsSelect1,newReg1,
  newRsSelect2,newReg2,
  
  outRsSelect[0],outBank[0],rsFound[0],outReg0,
  outRsSelect[1],outBank[1],rsFound[1],outReg1,
  outRsSelect[2],outBank[2],rsFound[2],outReg2
  );



  rs_nonWakeUp_array #(II_WIDTH) ii_mod(
  clk,dataRst,stall|doStall,
  newRsSelect0,newInstrIndex0,
  newRsSelect1,newInstrIndex1,
  newRsSelect2,newInstrIndex2,
  
  outRsSelect[0],outBank[0],rsFound[0],outInstrIndex0,
  outRsSelect[1],outBank[1],rsFound[1],outInstrIndex1,
  outRsSelect[2],outBank[2],rsFound[2],outInstrIndex2
  );

  
  assign portEn[0]=~pause0;
  assign portEn[1]=~pause1;
  assign portEn[2]=~pause2;
  
  
endmodule

