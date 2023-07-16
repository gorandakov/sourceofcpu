
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

// main modules: regfilef
// the rest are parts of it


//please note that the compiler is likely to split the regifle into 3 identical blocks with less read ports e.g. 3 data / 
//[1 ram/9 wire] retire
module regfilef(
  clk,
  rst,
  read_clkEn,
  retire_clkEn,

  read0_addr,read0_addr_rrf,read0_data,read0_oe,read0_match,
  read1_addr,read1_addr_rrf,read1_data,read1_oe,read1_match,
  read2_addr,read2_addr_rrf,read2_data,read2_oe,read2_match,
  read3_addr,read3_addr_rrf,read3_data,read3_oe,read3_match,
  read4_addr,read4_addr_rrf,read4_data,read4_oe,read4_match,
  read5_addr,read5_addr_rrf,read5_data,read5_oe,read5_match,
  read6_addr,read6_addr_rrf,read6_data,read6_oe,read6_match,
  read7_addr,read7_addr_rrf,read7_data,read7_oe,read7_match,
  read8_addr,read8_addr_rrf,read8_data,read8_oe,read8_match,

  read0_constEn,
  read1_constEn,
  read2_constEn,
  read3_constEn,
  read4_constEn,
  read5_constEn,
  read6_constEn,
  read7_constEn,
  read8_constEn,

  read0_const,
  read1_const,
  read2_const,
  read3_const,
  read4_const,
  read5_const,
  read6_const,
  read7_const,
  read8_const,

  write0_addr_rrf,write0_wen_rrf,
  write1_addr_rrf,write1_wen_rrf,
  write2_addr_rrf,write2_wen_rrf,
  write3_addr_rrf,write3_wen_rrf,
  write4_addr_rrf,write4_wen_rrf,
  write5_addr_rrf,write5_wen_rrf,
  write6_addr_rrf,write6_wen_rrf,
  write7_addr_rrf,write7_wen_rrf,
  write8_addr_rrf,write8_wen_rrf,

  retireRead0_addr,
  retireRead1_addr,
  retireRead2_addr,
  retireRead3_addr,
  retireRead4_addr,
  retireRead5_addr,
  retireRead6_addr,
  retireRead7_addr,
  retireRead8_addr,

  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen,
  write2_addr,write2_data,write2_wen,
  write3_addr,write3_data,write3_wen,
  write4_addr,write4_data,write4_wen,
  write5_addr,write5_data,write5_wen,
  write6_addr,write6_data,write6_wen,
  write7_addr,write7_data,write7_wen,
  write8_addr,write8_data,write8_wen,
  write9_addr,write9_data,write9_wen
  );
  parameter DATA_WIDTH=`alu_width;
  localparam ADDR_WIDTH=`reg_addr_width;
  
  input clk;
  input rst;
  input read_clkEn;
  input retire_clkEn;


  input [ADDR_WIDTH-1:0] read0_addr;
  input [5:0] read0_addr_rrf;
  (* register equiload *) output [DATA_WIDTH-1:0] read0_data;
  input read0_oe;
  output [10:0] read0_match;

  input [ADDR_WIDTH-1:0] read1_addr;
  input [5:0] read1_addr_rrf;
  (* register equiload *) output [DATA_WIDTH-1:0] read1_data;
  input read1_oe;
  output [10:0] read1_match;

  input [ADDR_WIDTH-1:0] read2_addr;
  input [5:0] read2_addr_rrf;
  (* register equiload *) output [DATA_WIDTH-1:0] read2_data;
  input read2_oe;
  output [10:0] read2_match;

  input [ADDR_WIDTH-1:0] read3_addr;
  input [5:0] read3_addr_rrf;
  (* register equiload *) output [DATA_WIDTH-1:0] read3_data;
  input read3_oe;
  output [10:0] read3_match;

  input [ADDR_WIDTH-1:0] read4_addr;
  input [5:0] read4_addr_rrf;
  (* register equiload *) output [DATA_WIDTH-1:0] read4_data;
  input read4_oe;
  output [10:0] read4_match;

  input [ADDR_WIDTH-1:0] read5_addr;
  input [5:0] read5_addr_rrf;
  (* register equiload *) output [DATA_WIDTH-1:0] read5_data;
  input read5_oe;
  output [10:0] read5_match;

  input [ADDR_WIDTH-1:0] read6_addr;
  input [5:0] read6_addr_rrf;
  (* register equiload *) output [DATA_WIDTH-1:0] read6_data;
  input read6_oe;
  output [10:0] read6_match;

  input [ADDR_WIDTH-1:0] read7_addr;
  input [5:0] read7_addr_rrf;
  (* register equiload *) output [DATA_WIDTH-1:0] read7_data;
  input read7_oe;
  output [10:0] read7_match;

  input [ADDR_WIDTH-1:0] read8_addr;
  input [5:0] read8_addr_rrf;
  (* register equiload *) output [DATA_WIDTH-1:0] read8_data;
  input read8_oe;
  output [10:0] read8_match;

  input read0_constEn;
  input read1_constEn;
  input read2_constEn;
  input read3_constEn;
  input read4_constEn;
  input read5_constEn;
  input read6_constEn;
  input read7_constEn;
  input read8_constEn;

  input [DATA_WIDTH-1:0] read0_const;
  input [DATA_WIDTH-1:0] read1_const;
  input [DATA_WIDTH-1:0] read2_const;
  input [DATA_WIDTH-1:0] read3_const;
  input [DATA_WIDTH-1:0] read4_const;
  input [DATA_WIDTH-1:0] read5_const;
  input [DATA_WIDTH-1:0] read6_const;
  input [DATA_WIDTH-1:0] read7_const;
  input [DATA_WIDTH-1:0] read8_const;


  input [5:0] write0_addr_rrf;
  input       write0_wen_rrf;  
  input [5:0] write1_addr_rrf;
  input       write1_wen_rrf;  
  input [5:0] write2_addr_rrf;
  input       write2_wen_rrf;  
  input [5:0] write3_addr_rrf;
  input       write3_wen_rrf;  
  input [5:0] write4_addr_rrf;
  input       write4_wen_rrf;  
  input [5:0] write5_addr_rrf;
  input       write5_wen_rrf;  
  input [5:0] write6_addr_rrf;
  input       write6_wen_rrf;  
  input [5:0] write7_addr_rrf;
  input       write7_wen_rrf;  
  input [5:0] write8_addr_rrf;
  input       write8_wen_rrf;  

  input [8:0] retireRead0_addr;
  input [8:0] retireRead1_addr;
  input [8:0] retireRead2_addr;
  input [8:0] retireRead3_addr;
  input [8:0] retireRead4_addr;
  input [8:0] retireRead5_addr;
  input [8:0] retireRead6_addr;
  input [8:0] retireRead7_addr;
  input [8:0] retireRead8_addr;

  input [ADDR_WIDTH-1:0] write0_addr;
  input [DATA_WIDTH-1:0] write0_data;
  input write0_wen;

  input [ADDR_WIDTH-1:0] write1_addr;
  input [DATA_WIDTH-1:0] write1_data;
  input write1_wen;

  input [ADDR_WIDTH-1:0] write2_addr;
  input [DATA_WIDTH-1:0] write2_data;
  input write2_wen;

  input [ADDR_WIDTH-1:0] write3_addr;
  input [DATA_WIDTH-1:0] write3_data;
  input write3_wen;

  input [ADDR_WIDTH-1:0] write4_addr;
  input [DATA_WIDTH-1:0] write4_data;
  input write4_wen;

  input [ADDR_WIDTH-1:0] write5_addr;
  input [DATA_WIDTH-1:0] write5_data;
  input write5_wen;

  input [ADDR_WIDTH-1:0] write6_addr;
  input [DATA_WIDTH-1:0] write6_data;
  input write6_wen;

  input [ADDR_WIDTH-1:0] write7_addr;
  input [DATA_WIDTH-1:0] write7_data;
  input write7_wen;

  input [ADDR_WIDTH-1:0] write8_addr;
  input [DATA_WIDTH-1:0] write8_data;
  input write8_wen;

  input [ADDR_WIDTH-1:0] write9_addr;
  input [DATA_WIDTH-1:0] write9_data;
  input write9_wen;

  wire [8:0][DATA_WIDTH-1:0] ram_read_data;
  wire [8:0][DATA_WIDTH-1:0] read_data;
  wire [8:0][ADDR_WIDTH-1:0] read_addr;
  wire [8:0][DATA_WIDTH-1:0] ram_retireRead_data;
  wire [8:0][DATA_WIDTH-1:0] retireRead_data;
  wire [8:0][ADDR_WIDTH-1:0] retireRead_addr;


  wire read_constEn[8:0];
  wire read_oe[8:0];

  reg [ADDR_WIDTH-1:0] write0_addr_reg2;
  reg write0_wen_reg2;

  reg [ADDR_WIDTH-1:0] write1_addr_reg2;
  reg write1_wen_reg2;

  reg [ADDR_WIDTH-1:0] write2_addr_reg2;
  reg write2_wen_reg2;

  reg [ADDR_WIDTH-1:0] write3_addr_reg2;
  reg write3_wen_reg2;

  reg [ADDR_WIDTH-1:0] write4_addr_reg2;
  reg write4_wen_reg2;

  reg [ADDR_WIDTH-1:0] write5_addr_reg2;
  reg write5_wen_reg2;

  reg [ADDR_WIDTH-1:0] write6_addr_reg2;
  reg write6_wen_reg2;

  reg [ADDR_WIDTH-1:0] write7_addr_reg2;
  reg write7_wen_reg2;

  reg [ADDR_WIDTH-1:0] write8_addr_reg2;
  reg write8_wen_reg2;

  reg [ADDR_WIDTH-1:0] write9_addr_reg2;
  reg write9_wen_reg2;

  reg [ADDR_WIDTH-1:0] write0_addr_reg;
  reg write0_wen_reg;

  reg [ADDR_WIDTH-1:0] write1_addr_reg;
  reg write1_wen_reg;

  reg [ADDR_WIDTH-1:0] write2_addr_reg;
  reg write2_wen_reg;

  reg [ADDR_WIDTH-1:0] write3_addr_reg;
  reg write3_wen_reg;

  reg [ADDR_WIDTH-1:0] write4_addr_reg;
  reg write4_wen_reg;

  reg [ADDR_WIDTH-1:0] write5_addr_reg;
  reg write5_wen_reg;

  reg [ADDR_WIDTH-1:0] write6_addr_reg;
  reg write6_wen_reg;

  reg [ADDR_WIDTH-1:0] write7_addr_reg;
  reg write7_wen_reg;

  reg [ADDR_WIDTH-1:0] write8_addr_reg;
  reg write8_wen_reg;

  reg [ADDR_WIDTH-1:0] write9_addr_reg;
  reg write9_wen_reg;

  reg [DATA_WIDTH-1:0] write0_data_reg;
  reg [DATA_WIDTH-1:0] write1_data_reg;
  reg [DATA_WIDTH-1:0] write2_data_reg;
  reg [DATA_WIDTH-1:0] write3_data_reg;
  reg [DATA_WIDTH-1:0] write4_data_reg;
  reg [DATA_WIDTH-1:0] write5_data_reg;
  reg [DATA_WIDTH-1:0] write6_data_reg;
  reg [DATA_WIDTH-1:0] write7_data_reg;
  reg [DATA_WIDTH-1:0] write8_data_reg;
  reg [DATA_WIDTH-1:0] write9_data_reg;
  
  wire [10:0] read_match[8:0];
  
  genvar b;

  
  regfile_ram_block #(DATA_WIDTH) ram_mod(
  clk,
  rst,
  read_clkEn,
  retire_clkEn,

  read0_addr,ram_read_data[0],
  read1_addr,ram_read_data[1],
  read2_addr,ram_read_data[2],
  read3_addr,ram_read_data[3],
  read4_addr,ram_read_data[4],
  read5_addr,ram_read_data[5],
  read6_addr,ram_read_data[6],
  read7_addr,ram_read_data[7],
  read8_addr,ram_read_data[8],

  read0_constEn,
  read1_constEn,
  read2_constEn,
  read3_constEn,
  read4_constEn,
  read5_constEn,
  read6_constEn,
  read7_constEn,
  read8_constEn,

  read0_const,
  read1_const,
  read2_const,
  read3_const,
  read4_const,
  read5_const,
  read6_const,
  read7_const,
  read8_const,

  retireRead0_addr,ram_retireRead_data[0],
  retireRead1_addr,ram_retireRead_data[1],
  retireRead2_addr,ram_retireRead_data[2],
  retireRead3_addr,ram_retireRead_data[3],
  retireRead4_addr,ram_retireRead_data[4],
  retireRead5_addr,ram_retireRead_data[5],
  retireRead6_addr,ram_retireRead_data[6],
  retireRead7_addr,ram_retireRead_data[7],
  retireRead8_addr,ram_retireRead_data[8],

  write0_addr_reg2,write0_data_reg,write0_wen_reg2,
  write1_addr_reg2,write1_data_reg,write1_wen_reg2,
  write2_addr_reg2,write2_data_reg,write2_wen_reg2,
  write3_addr_reg2,write3_data_reg,write3_wen_reg2,

  write4_addr_reg2,write4_data_reg,write4_wen_reg2,
  write5_addr_reg2,write5_data_reg,write5_wen_reg2,
  write6_addr_reg2,write6_data_reg,write6_wen_reg2,
  write7_addr_reg2,write7_data_reg,write7_wen_reg2,
  write8_addr_reg2,write8_data_reg,write8_wen_reg2,
  write9_addr_reg2,write9_data_reg,write9_wen_reg2
 );

  rrf #(DATA_WIDTH) rrf_m(
  clk,
  rst,
  read_clkEn,
  read0_addr_rrf,read0_data,~read0_oe,
  read1_addr_rrf,read1_data,~read1_oe,
  read2_addr_rrf,read2_data,~read2_oe,
  read3_addr_rrf,read3_data,~read3_oe,
  read4_addr_rrf,read4_data,~read4_oe,
  read5_addr_rrf,read5_data,~read5_oe,
  read6_addr_rrf,read6_data,~read6_oe,
  read7_addr_rrf,read7_data,~read7_oe,
  read8_addr_rrf,read8_data,~read8_oe,
  write0_addr_rrf,reatireRead_data[0],write0_wen_rrf,
  write1_addr_rrf,reatireRead_data[1],write1_wen_rrf,
  write2_addr_rrf,reatireRead_data[2],write2_wen_rrf,
  write3_addr_rrf,reatireRead_data[3],write3_wen_rrf,
  write4_addr_rrf,reatireRead_data[4],write4_wen_rrf,
  write5_addr_rrf,reatireRead_data[5],write5_wen_rrf,
  write6_addr_rrf,reatireRead_data[6],write6_wen_rrf,
  write7_addr_rrf,reatireRead_data[7],write7_wen_rrf,
  write8_addr_rrf,reatireRead_data[8],write8_wen_rrf,
  read_thread,
  write_thread
  );

  assign read0_data=read_data[0];
  assign read1_data=read_data[1];
  assign read2_data=read_data[2];
  assign read3_data=read_data[3];
  assign read4_data=read_data[4];
  assign read5_data=read_data[5];
  assign read6_data=read_data[6];
  assign read7_data=read_data[7];
  assign read8_data=read_data[8];

  assign read_addr[0]=read0_addr;
  assign read_addr[1]=read1_addr;
  assign read_addr[2]=read2_addr;
  assign read_addr[3]=read3_addr;
  assign read_addr[4]=read4_addr;
  assign read_addr[5]=read5_addr;
  assign read_addr[6]=read6_addr;
  assign read_addr[7]=read7_addr;
  assign read_addr[8]=read8_addr;

  assign read_constEn[0]=read0_constEn;
  assign read_constEn[1]=read1_constEn;
  assign read_constEn[2]=read2_constEn;
  assign read_constEn[3]=read3_constEn;
  assign read_constEn[4]=read4_constEn;
  assign read_constEn[5]=read5_constEn;
  assign read_constEn[6]=read6_constEn;
  assign read_constEn[7]=read7_constEn;
  assign read_constEn[8]=read8_constEn;

  assign read_oe[0]=read0_oe;
  assign read_oe[1]=read1_oe;
  assign read_oe[2]=read2_oe;
  assign read_oe[3]=read3_oe;
  assign read_oe[4]=read4_oe;
  assign read_oe[5]=read5_oe;
  assign read_oe[6]=read6_oe;
  assign read_oe[7]=read7_oe;
  assign read_oe[8]=read8_oe;
  
  assign read0_matchV=read_matchV[0];
  assign read1_matchV=read_matchV[1];
  assign read2_matchV=read_matchV[2];
  assign read3_matchV=read_matchV[3];
  assign read4_matchV=read_matchV[4];
  assign read5_matchV=read_matchV[5];
  assign read6_matchV=read_matchV[6];
  assign read7_matchV=read_matchV[7];
  assign read8_matchV=read_matchV[8];

  assign read0_matchF=read_matchF[0];
  assign read1_matchF=read_matchF[1];
  assign read2_matchF=read_matchF[2];
  assign read3_matchF=read_matchF[3];
  assign read4_matchF=read_matchF[4];
  assign read5_matchF=read_matchF[5];
  assign read6_matchF=read_matchF[6];
  assign read7_matchF=read_matchF[7];
  assign read8_matchF=read_matchF[8];
  
  assign retireRead_addr[0]=retireRead0_addr;
  assign retireRead_addr[1]=retireRead1_addr;
  assign retireRead_addr[2]=retireRead2_addr;
  assign retireRead_addr[3]=retireRead3_addr;
  assign retireRead_addr[4]=retireRead4_addr;
  assign retireRead_addr[5]=retireRead5_addr;
  assign retireRead_addr[6]=retireRead6_addr;
  assign retireRead_addr[7]=retireRead7_addr;
  assign retireRead_addr[8]=retireRead8_addr;

  generate for(b=0;b<=8;b=b+1)
    begin
      regfile_zero_cycle_write #(DATA_WIDTH) zcw_mod(
      clk,rst,
      read_clkEn,
      ram_read_data[b],read_dataX[b],read_addr[b],

      read_constEn[b],read_oe[b], read_matchV[b],
      
      write0_addr_reg,write0_wen_reg,
      write1_addr_reg,write1_wen_reg,
      write2_addr_reg,write2_wen_reg,
      write3_addr_reg,write3_wen_reg,
      write4_addr_reg,write4_wen_reg,
      write5_addr_reg,write5_wen_reg,
      write6_addr_reg,write6_wen_reg,
      write7_addr_reg,write7_wen_reg,
      write8_addr_reg,write8_wen_reg,
      write9_addr_reg,write9_wen_reg,
      write0_addr_reg2,write0_wen_reg2,
      write1_addr_reg2,write1_wen_reg2,
      write2_addr_reg2,write2_wen_reg2,
      write3_addr_reg2,write3_wen_reg2,
      write4_addr_reg2,write4_wen_reg2,
      write5_addr_reg2,write5_wen_reg2,
      write6_addr_reg2,write6_wen_reg2,
      write7_addr_reg2,write7_wen_reg2,
      write8_addr_reg2,write8_wen_reg2,
      write9_addr_reg2,write9_wen_reg2,
      write0_data_reg,
      write1_data_reg,
      write2_data_reg,
      write3_data_reg,
      write4_data_reg,
      write5_data_reg,
      write6_data_reg,
      write7_data_reg,
      write8_data_reg,
      write9_data_reg
      );

      regfile_zero_cycle_write #(DATA_WIDTH) zcwX_mod(
      clk,rst,
      read_clkEn,
      read_dataX[b],read_data[b],read_addr[b],

      read_constEn[b],read_oe[b], read_matchF[b],
      
      write0_addr,write0_wen,
      write1_addr,write1_wen,
      write2_addr,write2_wen,
      write3_addr,write3_wen,
      write4_addr,write4_wen,
      write5_addr,write5_wen,
      write6_addr,write6_wen,
      write7_addr,write7_wen,
      write8_addr,write8_wen,
      write9_addr,write9_wen,
      write0_addr_reg,write0_wen_reg,
      write1_addr_reg,write1_wen_reg,
      write2_addr_reg,write2_wen_reg,
      write3_addr_reg,write3_wen_reg,
      write4_addr_reg,write4_wen_reg,
      write5_addr_reg,write5_wen_reg,
      write6_addr_reg,write6_wen_reg,
      write7_addr_reg,write7_wen_reg,
      write8_addr_reg,write8_wen_reg,
      write9_addr_reg,write9_wen_reg,
      write0_data,
      write1_data,
      write2_data,
      write3_data,
      write4_data,
      write5_data,
      write6_data,
      write7_data,
      write8_data,
      write9_data
      );
      
      regfile_zero_cycle_write #(DATA_WIDTH) zcwiR_mod(
      clk,rst,
      read_clkEn,
      ram_retireRead_data[b],retireRead_data[b],retireRead_addr[b],

      1'b0,1'b1,,
      
      write0_addr_reg,write0_wen_reg,
      write1_addr_reg,write1_wen_reg,
      write2_addr_reg,write2_wen_reg,
      write3_addr_reg,write3_wen_reg,
      write4_addr_reg,write4_wen_reg,
      write5_addr_reg,write5_wen_reg,
      write6_addr_reg,write6_wen_reg,
      write7_addr_reg,write7_wen_reg,
      write8_addr_reg,write8_wen_reg,
      write9_addr_reg,write9_wen_reg,
      write0_addr_reg2,write0_wen_reg2,
      write1_addr_reg2,write1_wen_reg2,
      write2_addr_reg2,write2_wen_reg2,
      write3_addr_reg2,write3_wen_reg2,
      write4_addr_reg2,write4_wen_reg2,
      write5_addr_reg2,write5_wen_reg2,
      write6_addr_reg2,write6_wen_reg2,
      write7_addr_reg2,write7_wen_reg2,
      write8_addr_reg2,write8_wen_reg2,
      write9_addr_reg2,write9_wen_reg2,
      write0_data_reg,
      write1_data_reg,
      write2_data_reg,
      write3_data_reg,
      write4_data_reg,
      write5_data_reg,
      write6_data_reg,
      write7_data_reg,
      write8_data_reg,
      write9_data_reg
      );
    end
  endgenerate

  always @(posedge clk) begin
      if (rst) begin
          write0_addr_reg2<={ADDR_WIDTH{1'B0}};
          write1_addr_reg2<={ADDR_WIDTH{1'B0}};
          write2_addr_reg2<={ADDR_WIDTH{1'B0}};
          write3_addr_reg2<={ADDR_WIDTH{1'B0}};
          write4_addr_reg2<={ADDR_WIDTH{1'B0}};
          write5_addr_reg2<={ADDR_WIDTH{1'B0}};
          write6_addr_reg2<={ADDR_WIDTH{1'B0}};
          write7_addr_reg2<={ADDR_WIDTH{1'B0}};
          write8_addr_reg2<={ADDR_WIDTH{1'B0}};
          write9_addr_reg2<={ADDR_WIDTH{1'B0}};
          
          
          write0_wen_reg2<=1'b0;
          write1_wen_reg2<=1'b0;
          write2_wen_reg2<=1'b0;
          write3_wen_reg2<=1'b0;
          write4_wen_reg2<=1'b0;
          write5_wen_reg2<=1'b0;
          write6_wen_reg2<=1'b0;
          write7_wen_reg2<=1'b0;
          write8_wen_reg2<=1'b0;
          write9_wen_reg2<=1'b0;

          write0_addr_reg<={ADDR_WIDTH{1'B0}};
          write1_addr_reg<={ADDR_WIDTH{1'B0}};
          write2_addr_reg<={ADDR_WIDTH{1'B0}};
          write3_addr_reg<={ADDR_WIDTH{1'B0}};
          write4_addr_reg<={ADDR_WIDTH{1'B0}};
          write5_addr_reg<={ADDR_WIDTH{1'B0}};
          write6_addr_reg<={ADDR_WIDTH{1'B0}};
          write7_addr_reg<={ADDR_WIDTH{1'B0}};
          write8_addr_reg<={ADDR_WIDTH{1'B0}};
          write9_addr_reg<={ADDR_WIDTH{1'B0}};
          
          write0_data_reg<={DATA_WIDTH{1'B0}};
          
          write0_wen_reg<=1'b0;
          write1_wen_reg<=1'b0;
          write2_wen_reg<=1'b0;
          write3_wen_reg<=1'b0;
          write4_wen_reg<=1'b0;
          write5_wen_reg<=1'b0;
          write6_wen_reg<=1'b0;
          write7_wen_reg<=1'b0;
          write8_wen_reg<=1'b0;
          write9_wen_reg<=1'b0;
      end else begin
          if (write0_wen_reg) write0_addr_reg2<=write0_addr_reg;
          if (write1_wen_reg) write1_addr_reg2<=write1_addr_reg;
          if (write2_wen_reg) write2_addr_reg2<=write2_addr_reg;
          if (write3_wen_reg) write3_addr_reg2<=write3_addr_reg;
          if (write4_wen_reg) write4_addr_reg2<=write4_addr_reg;
          if (write5_wen_reg) write5_addr_reg2<=write5_addr_reg;
          if (write6_wen_reg) write6_addr_reg2<=write6_addr_reg;
          if (write7_wen_reg) write7_addr_reg2<=write7_addr_reg;
          if (write8_wen_reg) write8_addr_reg2<=write8_addr_reg;
          if (write9_wen_reg) write9_addr_reg2<=write9_addr_reg;
          
          
          write0_wen_reg2<=write0_wen_reg;
          write1_wen_reg2<=write1_wen_reg;
          write2_wen_reg2<=write2_wen_reg;
          write3_wen_reg2<=write3_wen_reg;
          write4_wen_reg2<=write4_wen_reg;
          write5_wen_reg2<=write5_wen_reg;
          write6_wen_reg2<=write6_wen_reg;
          write7_wen_reg2<=write7_wen_reg;
          write8_wen_reg2<=write8_wen_reg;
          write9_wen_reg2<=write9_wen_reg;

          write0_addr_reg<=write0_addr;
          write0_data_reg<=write0_data;
          write0_wen_reg <=write0_wen;
          write1_addr_reg<=write1_addr;
          write1_data_reg<=write1_data;
          write1_wen_reg <=write1_wen;
          write2_addr_reg<=write2_addr;
          write2_data_reg<=write2_data;
          write2_wen_reg <=write2_wen;
          write3_addr_reg<=write3_addr;
          write3_data_reg<=write3_data;
          write3_wen_reg <=write3_wen;
          write4_addr_reg<=write4_addr;
          write4_data_reg<=write4_data;
          write4_wen_reg <=write4_wen;
          write5_addr_reg<=write5_addr;
          write5_data_reg<=write5_data;
          write5_wen_reg <=write5_wen;
          write6_addr_reg<=write6_addr;
          write6_data_reg<=write6_data;
          write6_wen_reg <=write6_wen;
          write7_addr_reg<=write7_addr;
          write7_data_reg<=write7_data;
          write7_wen_reg <=write7_wen;
          write8_addr_reg<=write8_addr;
          write8_data_reg<=write8_data;
          write8_wen_reg <=write8_wen;
          write9_addr_reg<=write9_addr;
          write9_data_reg<=write9_data;
          write9_wen_reg <=write9_wen;
      end
  end
endmodule





