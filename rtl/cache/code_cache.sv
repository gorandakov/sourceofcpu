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
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=65*2;
  `ifdef ICACHE_256K
  localparam ADDR_WIDTH=8;
  localparam ADDR_COUNT=256;
  `else
  localparam ADDR_WIDTH=7;
  localparam ADDR_COUNT=128;
  `endif

  input clk;
  input rst;
  input read_clkEn;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  reg [ADDR_WIDTH-1:0] read_addr_reg;
  
  assign read_data=ram[read_addr_reg];

  always @(negedge clk)
    begin
      if (rst) read_addr_reg<={ADDR_WIDTH{1'b0}};
      else if (read_clkEn) read_addr_reg<=read_addr;
      if (write_wen) ram[write_addr]<=write_data;
    end

endmodule

module cc_ram_block(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  parameter INDEX=0;
  localparam DATA_WIDTH=65*8;
  `ifdef ICACHE_256K
  localparam ADDR_WIDTH=8;
  localparam ADDR_COUNT=256;
  `else
  localparam ADDR_WIDTH=7;
  localparam ADDR_COUNT=128;
  `endif

  input clk;
  input rst;
  input read_clkEn;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  generate
    genvar t;
    for(t=0;t<4;t=t+1) begin : ram_gen
        cc_ram ram_mod(
        clk,
        rst,
        read_clkEn,
        read_addr,
        read_data[130*t+:130],
        write_addr,
        write_data[130*t+:130],
        write_wen
        );
    end
  endgenerate
endmodule

module ccX_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=60;
  `ifdef ICACHE_256K
  localparam ADDR_WIDTH=8;
  localparam ADDR_COUNT=256;
  `else
  localparam ADDR_WIDTH=7;
  localparam ADDR_COUNT=128;
  `endif

  input clk;
  input rst;
  input read_clkEn;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  reg [ADDR_WIDTH-1:0] read_addr_reg;
  
  assign read_data=ram[read_addr_reg];

  always @(negedge clk)
    begin
      if (rst) read_addr_reg<={ADDR_WIDTH{1'b0}};
      else if (read_clkEn) read_addr_reg<=read_addr;
      if (write_wen) ram[write_addr]<=write_data;
    end

endmodule


module ccRam_way(
  clk,
  rst,
  read_clkEn,
  read_IP,
  read_IP_low,
  read_set_flag,
  read_data,read_data_in,
  read_dataX,read_dataX_in,
  expun_addr,expun_addr_in,
  read_hit,read_next_hit,expun_hit,
  read_NRU,read_NRU_in,read_NRU_reg,
  chkCL_IP,
  chkCL_clkEn,
  chkCL_hit,
  write_IP,
  write_data,
  write_wen,
  invalidate,
  Err
  );

  localparam DATA_WIDTH=65*16;
  `ifdef ICACHE_256K
  localparam ADDR_WIDTH=8;
  `else
  localparam ADDR_WIDTH=7;
  `endif
  localparam IP_WIDTH=44;
  localparam PHYS_WIDTH=44;
  parameter [2:0] INDEX=0;
  parameter UPPER=0;

  input clk;
  input rst;
  input read_clkEn;
  input [IP_WIDTH-6:0] read_IP;
  input [3:0] read_IP_low;
  input read_set_flag;
  output [DATA_WIDTH-1:0] read_data;
  input [DATA_WIDTH-1:0] read_data_in;
  output [59:0] read_dataX;
  input [59:0] read_dataX_in;
  output [36:0] expun_addr;
  input [36:0] expun_addr_in;
  output read_hit;
  output read_next_hit;
  output expun_hit;
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

  output Err;

  reg init;

  wire [DATA_WIDTH-1:0] read_data_ram;
  reg [IP_WIDTH-6:0] write_IP_reg;
  
  wire [59:0] readX_data_ram;
  reg [59:0] writeX_data;
  `ifdef ICACHE_256K
  wire [7:0] writeX_addr;
  `else
  wire [6:0] writeX_addr;
  `endif
  integer k,j;
  reg read_clkEn_reg;
  reg read_set_flag_reg;
  reg [3:0] read_IP_low_reg;
  reg [9:0] read_IP_reg;
  wire read_hitC0; 
  wire write_hit; 

  wire [36:0] expun_naddr;

  `ifdef ICACHE_256K
  wire [7:0] initCountNext;
  reg [7:0] initCount;
  `else
  wire [6:0] initCountNext;
  reg [6:0] initCount;
  `endif

  reg [DATA_WIDTH-1:0] write_data_reg;

  generate
    if (~INDEX[0]) begin
        assign read_data=~(({DATA_WIDTH{read_hit}} & read_data_ram) | read_data_in);
        assign read_dataX=~(({60{read_hit}} & writeX_data[59:0]) | read_dataX_in);
        assign expun_addr=~(({37{write_hit}} & expun_naddr[36:0]) | expun_addr_in);
   //     assign read_physOut=~(({32{read_hit}} & read_physOutP)&read_physOut_in);
   //     assign read_NRU=~(({32{read_hit}} & read_NRUP)&read_NRU_in);
    end else begin
        assign read_data=~(~({DATA_WIDTH{read_hit}} & read_data_ram) & read_data_in);
        assign read_dataX=~(~({60{read_hit}} & writeX_data[59:0]) & read_dataX_in);
        assign expun_addr=~(~({37{write_hit}} & expun_naddr[36:0]) & expun_addr_in);
   //     assign read_physOut=~(~({32{read_hit}} & read_physOutP)|read_physOut_in);
   //     assign read_NRU=~(~({32{read_hit}} & read_NRUP)|read_NRU_in);
    end
  endgenerate

  `ifdef ICACHE_256K
  assign writeX_addr=init ? initCount : 8'bz;
  assign writeX_addr=(~init & read_clkEn_reg) ? read_IP_reg[9:2] : 8'bz;
  assign writeX_addr=(~init & ~read_clkEn_reg) ? write_IP_reg[9:2] : 8'bz;
  `else
  assign writeX_addr=init ? initCount : 7'bz;
  assign writeX_addr=(~init & read_clkEn_reg) ? read_IP_reg[8:2] : 7'bz;
  assign writeX_addr=(~init & ~read_clkEn_reg) ? write_IP_reg[8:2] : 7'bz;
  `endif

  assign chkCL_hit=read_hitC0;

  ccX_ram ramX0_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(read_clkEn),
  `ifdef ICACHE_256K
  .read_addr(read_IP[9:2]),
  `else
  .read_addr(read_IP[8:2]),
  `endif
  .read_data(readX_data_ram),
  .write_addr(writeX_addr),
  .write_data(init ? 60'b0 : writeX_data),
  .write_wen(write_hit|init|read_clkEn_reg)
  );


  cc_ram_block #(1) ram0_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(read_clkEn),
  `ifdef ICACHE_256K
  .read_addr(read_IP[9:2]),
  `else
  .read_addr(read_IP[8:2]),
  `endif
  .read_data(read_data_ram[DATA_WIDTH/2-1:0]),
  `ifdef ICACHE_256K
  .write_addr(init ? initCount : write_IP_reg[9:2]),
  `else
  .write_addr(init ? initCount : write_IP_reg[8:2]),
  `endif
  .write_data(write_data_reg[DATA_WIDTH/2-1:0] & {DATA_WIDTH/2{~init}}),
  .write_wen(write_hit|init)
  );

  cc_ram_block #(0) ram1_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(read_clkEn),
  `ifdef ICACHE_256K
  .read_addr(read_IP[9:2]),
  `else
  .read_addr(read_IP[8:2]),
  `endif
  .read_data(read_data_ram[DATA_WIDTH-1:DATA_WIDTH/2]),
  `ifdef ICACHE_256K
  .write_addr(init ? initCount : write_IP_reg[9:2]),
  `else
  .write_addr(init ? initCount : write_IP_reg[8:2]),
  `endif
  .write_data(write_data_reg[DATA_WIDTH-1:DATA_WIDTH/2] & {DATA_WIDTH/2{~init}}),
  .write_wen(write_hit|init)
  );

//verilator lint_off WIDTH
  ccTag #(INDEX) tag_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(read_clkEn),
  .read_phys_addr(init ? {initCount} : read_IP[38:2]),
  .read_hit(read_hit),
  .read_err(Err),
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
  
  `ifdef ICACHE_256K  
  adder_inc #(8) initAdd_mod(initCount,initCountNext,1'b1,);
  `else
  adder_inc #(7) initAdd_mod(initCount,initCountNext,1'b1,);
  `endif
    
  always @* begin
      writeX_data=readX_data_ram;
      for (k=0;k<4;k=k+1)
          for (j=0;j<15;j=j+1) begin
              writeX_data[k*15+j]=writeX_data[k*15+j]||(read_set_flag_reg && read_IP_low_reg==j[3:0] 
                && read_IP_reg[1:0]==k[1:0]);
          end
  end
  
  always @(negedge clk)
  begin
      if (rst) begin
          write_IP_reg<=39'b0;
        //  hitNRU_reg<=3'b0;
          write_data_reg<={DATA_WIDTH{1'B0}};
          read_clkEn_reg<=1'b0;
          read_set_flag_reg<=1'b0;
          read_IP_low_reg<=4'b0;
          read_IP_reg<=10'b0;
      end
      else begin
          write_IP_reg<=write_IP;
        //  hitNRU_reg<=hitNRU;
          write_data_reg<=write_data;
          read_clkEn_reg<=read_clkEn;
          read_set_flag_reg<=read_set_flag;
          read_IP_low_reg<=read_IP_low;
          read_IP_reg<=read_IP[9:0];
      end
      `ifdef ICACHE_256K
      if (rst) begin
          init<=1'b1;
          initCount<=8'b0;
      end else if (init) begin
         initCount<=initCountNext;
         if (initCount==8'd255)
             init<=1'b0;
      end
      `else
      if (rst) begin
          init<=1'b1;
          initCount<=7'b0;
      end else if (init) begin
         initCount<=initCountNext;
         if (initCount==7'd127)
             init<=1'b0;
      end
      `endif
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
  read_clkEn,
  read_IP,
  read_set_flag,
  read_data,
  read_dataX,
  expun_addr,
  read_hit,expun_hit,
  chkCL_IP,
  chkCL_clkEn,
  chkCL_hit,
  write_IP,
  write_data,
  write_wen,
  invalidate,
  tagErr
  );

  localparam DATA_WIDTH=65*16;
  `ifdef ICACHE_256K
  localparam ADDR_WIDTH=8;
  `else 
  localparam ADDR_WIDTH=7;
  `endif
  localparam IP_WIDTH=44;
  localparam PHYS_WIDTH=44;

  input clk;
  input rst;
  input read_clkEn;
  input [IP_WIDTH-2:0] read_IP;
  input read_set_flag;
  output [DATA_WIDTH-1:0] read_data;
  output [59:0] read_dataX;
  output [36:0] expun_addr;
  output read_hit,expun_hit;
  input [IP_WIDTH-6:0] chkCL_IP;
  input chkCL_clkEn;
  output chkCL_hit;
  input [IP_WIDTH-6:0] write_IP;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;
  input invalidate;
  output [7:0] tagErr;
  
  wire [7:0] chkCL_hit_way;
  wire [7:0] read_hit_way;
  wire [7:0] expun_hit_way;
  
  wire [DATA_WIDTH-1:0] read_dataP[8:0];
  wire [59:0] read_dataXP[8:0];
  wire [2:0] read_NRUP[8:0];
  wire [36:0] expun_addrP[8:0];

  reg [2:0] read_NRU_reg;
 
  
  generate
      genvar k;
      for(k=0;k<8;k=k+1) begin : wayMod_gen
          ccRam_way #(k) way_mod(
          .clk(clk),
          .rst(rst),
          .read_clkEn(read_clkEn),
          .read_IP(read_IP[IP_WIDTH-2:4]),
          .read_IP_low(read_IP[3:0]),
          .read_set_flag(read_set_flag),
          .read_data(read_dataP[k+1]),
          .read_data_in(read_dataP[k]),
          .read_dataX(read_dataXP[k+1]),
          .read_dataX_in(read_dataXP[k]),
          .expun_addr(expun_addrP[k+1]),
          .expun_addr_in(expun_addrP[k]),
          .read_hit(read_hit_way[k]),
	  .expun_hit(expun_hit_way[k]),
          .chkCL_IP(chkCL_IP),
          .chkCL_clkEn(chkCL_clkEn),
          .chkCL_hit(chkCL_hit_way[k]),
          .read_NRU(read_NRUP[k+1]),
          .read_NRU_in(read_NRUP[k]),
	  .read_NRU_reg(read_NRU_reg),
          .write_IP(write_IP),
          .write_data(write_data),
          .write_wen(write_wen),
          .invalidate(invalidate),
          .Err(tagErr[k]),
	  .read_next_hit()
          );
      end
  endgenerate
  
  assign read_hit=|read_hit_way;
  assign expun_hit=|expun_hit_way;
  assign chkCL_hit=|chkCL_hit_way;

  assign read_dataP[0]=0;
  assign read_dataXP[0]=0;
  assign read_NRUP[0]=0;
  assign expun_addrP[0]=0;

  assign read_data=read_dataP[8];
  assign read_dataX=read_dataXP[8];
  assign expun_addr=expun_addrP[8];
  

  always @(*) begin
    read_NRU_reg=read_NRUP[8];
  end

endmodule


