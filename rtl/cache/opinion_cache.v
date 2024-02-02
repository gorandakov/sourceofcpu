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

module cc_ram(
  clk,
  rst,
  readA_clkEn,
  readA_addr,
  readA_data,
  readB_clkEn,
  readB_addr,
  readB_data,
  write_addr,
  write_data,
  write_wen,
  write_ben
  );

  localparam DATA_WIDTH=36;
  localparam ADDR_WIDTH=7;
  localparam ADDR_COUNT=128;

  input clk;
  input rst;
  input readA_clkEn;
  input [ADDR_WIDTH-1:0] readA_addr;
  output [DATA_WIDTH-1:0] readA_data;
  input readB_clkEn;
  input [ADDR_WIDTH-1:0] readB_addr;
  output [DATA_WIDTH-1:0] readB_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;
  input [3:0] write_ben;

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  reg [ADDR_WIDTH-1:0] readA_addr_reg;
  reg [ADDR_WIDTH-1:0] readB_addr_reg;
  
  assign readA_data=ram[readA_addr_reg];
  assign readB_data=ram[readB_addr_reg];

  always @(negedge clk)
    begin
      if (rst) readA_addr_reg<={ADDR_WIDTH{1'b0}};
      else if (readA_clkEn) readA_addr_reg<=readA_addr;
      if (rst) readB_addr_reg<={ADDR_WIDTH{1'b0}};
      else if (readB_clkEn) readB_addr_reg<=readB_addr;
      if (write_wen) ram[write_addr]<=write_data;
      if (write_wen & write_ben[0]) ram[write_addr][8:0]<=write_data[8:0];
      if (write_wen & write_ben[1]) ram[write_addr][17:9]<=write_data[17:9];
      if (write_wen & write_ben[2]) ram[write_addr][26:18]<=write_data[26:18];
      if (write_wen & write_ben[3]) ram[write_addr][35:27]<=write_data[35:27];
    end

endmodule

module cc_ram_block(
  clk,
  rst,
  readA_clkEn,
  readA_addr,
  readA_data,
  readB_clkEn,
  readB_addr,
  readB_data,
  write_addr,
  write_data,
  write_wen
  );

  parameter INDEX=0;
  localparam DATA_WIDTH=72*8;
  localparam ADDR_WIDTH=7;
  localparam ADDR_COUNT=128;

  input clk;
  input rst;
  input readA_clkEn;
  input [ADDR_WIDTH-1:0] readA_addr;
  output [DATA_WIDTH-1:0] readA_data;
  input readB_clkEn;
  input [ADDR_WIDTH-1:0] readB_addr;
  output [DATA_WIDTH-1:0] readB_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  wire [15:0][3:0] write_ben;

  generate
    genvar t;
    for(t=0;t<16;t=t+1) begin : ram_gen
        cc_ram ram_mod(
        clk,
        rst,
        readA_clkEn,
        readA_addr,
        readA_data[36*t+:36],
        readB_clkEn,
        readB_addr,
        readB_data[36*t+:36],
        write_addr,
        write_data[36*t+:36],
        write_wen,
        write_ben[t]
        );
    end
  endgenerate
endmodule

module ccX_ram(
  clk,
  rst,
  readA_clkEn,
  readA_addr,
  readA_data,
  readB_clkEn,
  readB_addr,
  readB_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=60;
  localparam ADDR_WIDTH=7;
  localparam ADDR_COUNT=128;

  input clk;
  input rst;
  input readA_clkEn;
  input [ADDR_WIDTH-1:0] readA_addr;
  output [DATA_WIDTH-1:0] readA_data;
  input readB_clkEn;
  input [ADDR_WIDTH-1:0] readB_addr;
  output [DATA_WIDTH-1:0] readB_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  reg [ADDR_WIDTH-1:0] readA_addr_reg;
  reg [ADDR_WIDTH-1:0] readB_addr_reg;
  
  assign readA_data=ram[readA_addr_reg];
  assign readB_data=ram[readB_addr_reg];

  always @(negedge clk)
    begin
      if (rst) readA_addr_reg<={ADDR_WIDTH{1'b0}};
      else if (readA_clkEn) readA_addr_reg<=readA_addr;
      if (rst) readB_addr_reg<={ADDR_WIDTH{1'b0}};
      else if (readB_clkEn) readB_addr_reg<=readB_addr;
      if (write_wen) ram[write_addr]<=write_data;
    end

endmodule


module ccRam_way(
  clk,
  rst,
  readA_clkEn,
  readA_IP,
  readA_IP_low,
  readA_set_flag,
  readA_data,readA_data_in,
  readA_dataX,readA_dataX_in,
  expun_addr,expun_addr_in,
  readA_hit,expun_hit,
  readB_clkEn,
  readB_IP,
  readB_IP_low,
  readB_set_flag,
  readB_data,readB_data_in,
  readB_dataX,readB_dataX_in,
  readB_hit,
  read_NRU,read_NRU_in,read_NRU_reg,
  chkCL_IP,
  chkCL_clkEn,
  chkCL_hit,
  write_IP,
  write_data,
  write_wen,
  invalidate,
  ErrA,ErrB
  );

  localparam DATA_WIDTH=65*16;
  localparam ADDR_WIDTH=7;
  localparam IP_WIDTH=44;
  localparam PHYS_WIDTH=44;
  parameter [2:0] INDEX=0;
  parameter UPPER=0;

  input clk;
  input rst;
  input readA_clkEn;
  input [IP_WIDTH-6:0] readA_IP;
  input [3:0] readA_IP_low;
  input readA_set_flag;
  output [DATA_WIDTH-1:0] readA_data;
  input [DATA_WIDTH-1:0] readA_data_in;
  output [59:0] readA_dataX;
  input [59:0] readA_dataX_in;
  output [36:0] expun_addr;
  input [36:0] expun_addr_in;
  output readA_hit;
  output expun_hit;
  input readB_clkEn;
  input [IP_WIDTH-6:0] readB_IP;
  input [3:0] readB_IP_low;
  input readB_set_flag;
  output [DATA_WIDTH-1:0] readB_data;
  input [DATA_WIDTH-1:0] readB_data_in;
  output [59:0] readB_dataX;
  input [59:0] readB_dataX_in;
  output readB_hit;
  output [2:0] read_NRU;
  input [2:0] read_NRU_in;
  input [2:0] read_NRU_reg;
  input [IP_WIDTH-6:0] chkCL_IP;
  input chkCL_clkEn;
  output chkCL_hit;
  input [IP_WIDTH-6:0] write_IP;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;
  input invalidate;

  output ErrA,ErrB;

  reg init;

  wire [DATA_WIDTH-1:0] readA_data_ram;
  wire [DATA_WIDTH-1:0] readB_data_ram;
  reg [IP_WIDTH-6:0] write_IP_reg;
  
  wire [59:0] readXA_data_ram;
  wire [59:0] readXB_data_ram;
  reg [59:0] writeX_data;
  wire [6:0] writeX_addr;

  integer k,j;
  reg readA_clkEn_reg;
  reg readA_set_flag_reg;
  reg readB_clkEn_reg;
  reg readB_set_flag_reg;
  reg [3:0] readA_IP_low_reg;
  reg [9:0] readA_IP_reg;
  wire read_hitC0; 
  reg [3:0] readB_IP_low_reg;
  reg [9:0] readB_IP_reg;
  wire write_hit; 

  wire [36:0] expun_naddr;

  wire [6:0] initCountNext;
  reg [6:0] initCount;

  reg [DATA_WIDTH-1:0] write_data_reg;

  generate
    if (~INDEX[0]) begin
        assign readA_data=~(({DATA_WIDTH{readA_hit}} & readA_data_ram) | readA_data_in);
        assign readA_dataX=~(({60{readA_hit}} & readA_dataX[59:0]) | readA_dataX_in);
        assign expun_addr=~(({37{write_hit}} & expun_naddr[36:0]) | expun_addr_in);
        assign readB_data=~(({DATA_WIDTH{readB_hit}} & readB_data_ram) | readB_data_in);
        assign readB_dataX=~(({60{readB_hit}} & readB_dataX[59:0]) | readB_dataX_in);
    end else begin
        assign readA_data=~(~({DATA_WIDTH{readA_hit}} & readA_data_ram) & readA_data_in);
        assign readA_dataX=~(~({60{readA_hit}} & readA_dataX[59:0]) & readA_dataX_in);
        assign expun_addr=~(~({37{write_hit}} & expun_naddr[36:0]) & expun_addr_in);
        assign readB_data=~(~({DATA_WIDTH{readB_hit}} & readB_data_ram) & readB_data_in);
        assign readB_dataX=~(~({60{readB_hit}} & readB_dataX[59:0]) & readB_dataX_in);
    end
  endgenerate

  assign writeX_addr=init ? initCount : 7'bz;
  assign writeX_addr=(~init & readA_clkEn_reg) ? readA_IP_reg[8:2] : 7'bz;
  assign writeX_addr=(~init & readB_clkEn_reg) ? readB_IP_reg[8:2] : 7'bz;
  assign writeX_addr=(~init & ~readA_clkEn_reg & ~readB_clkEn_reg) ? write_IP_reg[8:2] : 7'bz;

  assign chkCL_hit=read_hitC0;

  ccX_ram ramX0_mod(
  .clk(clk),
  .rst(rst),
  .readA_clkEn(readA_clkEn),
  .readA_addr(readA_IP[8:2]),
  .readA_data(readXA_data_ram),
  .readB_clkEn(readB_clkEn),
  .readB_addr(readB_IP[8:2]),
  .readB_data(readXB_data_ram),
  .write_addr(writeX_addr),
  .write_data(init ? 60'b0 : writeX_data),
  .write_wen(write_hit|init|readA_clkEn_reg|readB_clkEn_reg)
  );


  cc_ram_block #(1) ram0_mod(
  .clk(clk),
  .rst(rst),
  .readA_clkEn(readA_clkEn),
  .readA_addr(readA_IP[8:2]),
  .readA_data(readA_data_ram[DATA_WIDTH/2-1:0]),
  .readB_clkEn(readB_clkEn),
  .readB_addr(readB_IP[8:2]),
  .readB_data(readB_data_ram[DATA_WIDTH/2-1:0]),
  .write_addr(init ? initCount : write_IP_reg[8:2]),
  .write_data(write_data_reg[DATA_WIDTH/2-1:0] & {DATA_WIDTH/2{~init}}),
  .write_wen(write_hit|init)
  );
  
  cc_ram_block #(0) ram1_mod(
  .clk(clk),
  .rst(rst),
  .readA_clkEn(readA_clkEn),
  .readA_addr(readA_IP[8:2]),
  .readA_data(readA_data_ram[DATA_WIDTH-1:DATA_WIDTH/2]),
  .readB_clkEn(readB_clkEn),
  .readB_addr(readB_IP[8:2]),
  .readB_data(readB_data_ram[DATA_WIDTH-1:DATA_WIDTH/2]),
  .write_addr(init ? initCount : write_IP_reg[8:2]),
  .write_data(write_data_reg[DATA_WIDTH-1:DATA_WIDTH/2] & {DATA_WIDTH/2{~init}}),
  .write_wen(write_hit|init)
  );

  wire errAx,errBx;

  assign errA=^readA_data_ram[64:0] || ^readA_data_ram[64+65:0+65] || ^readA_data_ram[64+130:0+130] || ^readA_data_ram[64+195:195] || 
    ^readA_data_ram[64+260:260] || ^readA_data_ram[64+325:325] || ^readA_data_ram[64+390:390] || ^readA_data_ram[64+455:455] || 
    ^readA_data_ram[64+520:520] || ^readA_data_ram[64+585:585] || ^readA_data_ram[64+650:650] || ^readA_data_ram[64+715:715] || 
    ^readA_data_ram[64+780:780] || ^readA_data_ram[64+845:845] || ^readA_data_ram[64+920:920] || ^readA_data_ram[64+985:985] || errAx;
  assign errB=^readB_data_ram[64:0] || ^readB_data_ram[64+65:0+65] || ^readB_data_ram[64+130:0+130] || ^readB_data_ram[64+195:195] || 
    ^readB_data_ram[64+260:260] || ^readB_data_ram[64+325:325] || ^readB_data_ram[64+390:390] || ^readB_data_ram[64+455:455] || 
    ^readB_data_ram[64+520:520] || ^readB_data_ram[64+585:585] || ^readB_data_ram[64+650:650] || ^readB_data_ram[64+715:715] || 
    ^readB_data_ram[64+780:780] || ^readB_data_ram[64+845:845] || ^readB_data_ram[64+920:920] || ^readB_data_ram[64+985:985] || errBx;

//verilator lint_off WIDTH
  ccTag #(INDEX) tag_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(readA_clkEn),
  .read_phys_addr(init ? {initCount} : readA_IP[38:2]),
  .read_hit(readA_hit),
  .read_err(ErrAx),
  .write_phys_addr(init ? {initCount} : write_IP[38:2]),
  .write_wen(write_wen),
  .invalidate(invalidate),
  .hitNRU(read_NRU),
  .hitNRU_in(read_NRU_in),
  .hitNRU_reg(read_NRU_reg),
  .write_hit(write_hit),
  .write_expun_addr(expun_naddr),
  .write_exp_en(expun_hit),
  .init(init)
  );
  
  ccTag #(INDEX) tagB_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(readB_clkEn),
  .read_phys_addr(init ? {initCount} : readB_IP[38:2]),
  .read_hit(readB_hit),
  .read_err(ErrBx),
  .write_phys_addr(init ? {initCount} : write_IP[38:2]),
  .write_wen(write_wen),
  .invalidate(invalidate),
  .hitNRU(),
  .hitNRU_in(),
  .hitNRU_reg(),
  .write_hit(write_hit),
  .write_expun_addr(),
  .write_exp_en(),
  .init(init)
  );
  
  
  ccTag #(INDEX,1'b1) tagC_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(chkCL_clkEn),
  .read_phys_addr(init ? {initCount} : chkCL_IP[38:2]),
  .read_hit(read_hitC0),
  .read_err(),
  .write_phys_addr(init ? {initCount} : write_IP[38:2]),
  .write_wen(write_wen),
  .invalidate(invalidate),
  .hitNRU(),
  .hitNRU_in(read_NRU_in),
  .hitNRU_reg(read_NRU_reg),
  .write_hit(write_hit),
  .write_expun_addr(),
  .write_exp_en(),
  .init(init)
  );
//verilator lint_on WIDTH  
  
  adder_inc #(7) initAdd_mod(initCount,initCountNext,1'b1,);
    
  always @* begin
      writeX_data=readA_clkEn_reg ? readXA_data_ram : readXB_data_ram;
      for (k=0;k<4;k=k+1)
          for (j=0;j<15;j=j+1) begin
              writeX_data[k*15+j]=writeX_data[k*15+j]||(readA_set_flag_reg && readA_IP_low_reg==j[3:0] 
                && readA_IP_reg[1:0]==k[1:0])||(readB_set_flag_reg && readB_IP_low_reg==j[3:0]
                && readB_IP_reg[1:0]==k[1:0]);
          end
  end
  
  always @(negedge clk)
  begin
      if (rst) begin
          write_IP_reg<=39'b0;
        //  hitNRU_reg<=3'b0;
          write_data_reg<={DATA_WIDTH{1'B0}};
          readA_clkEn_reg<=1'b0;
          readA_set_flag_reg<=1'b0;
          readA_IP_low_reg<=4'b0;
          readA_IP_reg<=10'b0;
          readB_clkEn_reg<=1'b0;
          readB_set_flag_reg<=1'b0;
          readB_IP_low_reg<=4'b0;
          readB_IP_reg<=10'b0;
      end
      else begin
          write_IP_reg<=write_IP;
        //  hitNRU_reg<=hitNRU;
          write_data_reg<=write_data;
          for(z=0;z<16;z=z+1) begin
              write_data_reg[65*z+64]<=^write_data[65*z+:64];
          end
          readA_clkEn_reg<=readA_clkEn;
          readA_set_flag_reg<=readA_set_flag;
          readA_IP_low_reg<=readA_IP_low;
          readA_IP_reg<=readA_IP[9:0];
          readB_clkEn_reg<=readB_clkEn;
          readB_set_flag_reg<=readB_set_flag;
          readB_IP_low_reg<=readB_IP_low;
          readB_IP_reg<=readB_IP[9:0];
      end
      if (rst) begin
          init<=1'b1;
          initCount<=7'b0;
      end else if (init) begin
         initCount<=initCountNext;
         if (initCount==7'd127)
             init<=1'b0;
      end
      if (write_hit) begin
	  $display("WH ",{write_data_reg[258:195],write_data_reg[193:130],write_data_reg[128:65],write_data_reg[63:0]});
	  $display("WH ",{write_data_reg[260+258:260+195],write_data_reg[260+193:260+130],
	      write_data_reg[260+128:260+65],write_data_reg[260+63:260+0]});
          $display("WA ",write_IP_reg[9:2]);
      end
  end
    
endmodule



module ccRam_half(
  clk,
  rst,
  readA_clkEn,
  readA_IP,
  readA_set_flag,
  readA_data,
  readA_dataX,
  readB_clkEn,
  readB_IP,
  readB_set_flag,
  readB_data,
  readB_dataX,
  expun_addr,
  readA_hit,readB_hit,expun_hit,
  chkCL_IP,
  chkCL_clkEn,
  chkCL_hit,
  write_IP,
  write_data,
  write_wen,
  invalidate,
  tagErrA,tagErrB
  );

  localparam DATA_WIDTH=65*16;
  localparam ADDR_WIDTH=7;
  localparam IP_WIDTH=44;
  localparam PHYS_WIDTH=44;

  input clk;
  input rst;
  input readA_clkEn;
  input [IP_WIDTH-2:0] readA_IP;
  input readA_set_flag;
  output [DATA_WIDTH-1:0] readA_data;
  output [59:0] readA_dataX;
  output [7:0] readA_hit_way;
  input readB_clkEn;
  input [IP_WIDTH-2:0] readB_IP;
  input readB_set_flag;
  output [DATA_WIDTH-1:0] readB_data;
  output [59:0] readB_dataX;
  output [7:0] readB_hit_way;
  output [36:0] expun_addr;
  output readA_hit,readB_hit,expun_hit;
  input [IP_WIDTH-6:0] chkCL_IP;
  input chkCL_clkEn;
  output chkCL_hit;
  input [IP_WIDTH-6:0] write_IP;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;
  input invalidate;
  output [7:0] tagErrA;
  output [7:0] tagErrB;
  
  wire [7:0] chkCL_hit_way;
  wire [7:0] readA_hit_way;
  wire [7:0] readB_hit_way;
  wire [7:0] expun_hit_way;
  

  reg [2:0] read_NRU_reg;
 
  
  generate
      genvar k;
      for(k=0;k<9;k=k+1) begin : way_gen
          wire [DATA_WIDTH-1:0] readA_dataP;
          wire [59:0] readA_dataXP;
          wire [DATA_WIDTH-1:0] readB_dataP;
          wire [59:0] readB_dataXP;
          wire [2:0] read_NRUP;
          wire [36:0] expun_addrP;
          if (k) ccRam_way #(k-1) way_mod(
          .clk(clk),
          .rst(rst),
          .readA_clkEn(readA_clkEn),
          .readA_IP(readA_IP[IP_WIDTH-2:4]),
          .readA_IP_low(readA_IP[3:0]),
          .readA_set_flag(readA_set_flag),
          .readA_data(ways_gen[k].readA_dataP),
          .readA_data_in(ways_gen[k-1].readA_dataP),
          .readA_dataX(ways_gen[k].readA_dataXP),
          .readA_dataX_in(ways_gen[k-1].readA_dataXP),
          .readB_clkEn(readB_clkEn),
          .readB_IP(readB_IP[IP_WIDTH-2:4]),
          .readB_IP_low(readB_IP[3:0]),
          .readB_set_flag(readB_set_flag),
          .readB_data(ways_gen[k].readB_dataP),
          .readB_data_in(ways_gen[k-1].readB_dataP),
          .readB_dataX(ways_gen[k].readB_dataXP),
          .readB_dataX_in(ways_gen[k-1].readB_dataXP),
          .expun_addr(ways_gen[k].expun_addrP),
          .expun_addr_in(ways_gen[k-1].expun_addrP),
          .readA_hit(readA_hit_way[k-1]),
          .readB_hit(readB_hit_way[k-1]),
	  .expun_hit(expun_hit_way[k-1]),
          .chkCL_IP(chkCL_IP),
          .chkCL_clkEn(chkCL_clkEn),
          .chkCL_hit(chkCL_hit_way[k-1]),
          .read_NRU(read_NRUP[k]),
          .read_NRU_in(read_NRUP[k-1]),
	  .read_NRU_reg(read_NRU_reg),
          .write_IP(write_IP),
          .write_data(write_data),
          .write_wen(write_wen),
          .invalidate(invalidate),
          .ErrA(tagErrA[k-1]),
          .ErrB(tagErrB[k-1])
//	  .read_next_hit()
          );
      end
  endgenerate
  
  assign readA_hit=|readA_hit_way;
  assign readB_hit=|readB_hit_way;
  assign expun_hit=|expun_hit_way;
  assign chkCL_hit=|chkCL_hit_way;

  assign way_mod[0].readA_dataP=0;
  assign way_mod[0].readA_dataXP=0;
  assign way_mod[0].readB_dataP=0;
  assign way_mod[0].readB_dataXP=0;
  assign way_mod[0].read_NRUP=0;
  assign way_mod[0].expun_addrP=0;

  assign readA_data=way_mod[8].readA_dataP;
  assign readA_dataX=way_mod[8].readA_dataXP;
  assign readB_data=way_mod[8].readB_dataP;
  assign readB_dataX=way_mod[8].readB_dataXP;
  assign expun_addr=way_mod[8].expun_addrP;
  

  always @(*) begin
    read_NRU_reg=way_mod[8].read_NRUP;
  end

endmodule


