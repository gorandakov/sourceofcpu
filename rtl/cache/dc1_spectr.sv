`include "../struct.sv"

module spectr_ram(
  clk,
  rst,
  read0_addr,read0_data,read0_clkEn,read0_thr,
  read1_addr,read1_data,read1_clkEn,read1_thr,
  read2_addr,read2_data,read2_clkEn,read2_thr,
  read3_addr,read3_data,read3_clkEn,read3_thr,
  read4_addr,read4_data,read4_clkEn,read4_thr,
  read5_addr,read5_data,read5_clkEn,read5_thr,
  write0_addr,write0_data,write0_thr,write0_new,write0_wen,
  write1_addr,write1_data,write1_wen,
  write2_addr,write2_data,write2_wen,
  write3_addr,write3_data,write3_wen,
  write4_addr,write4_data,write4_wen,
  write5_addr,write5_data,write5_wen,
  write6_addr,write6_data,write6_wen,
  except,except_thread
  );
  `ifdef DCACHE_256K
  localparam ADDR_WIDTH=5;
  localparam ADDR_COUNT=32;
  `else
  localparam ADDR_WIDTH=4;
  localparam ADDR_COUNT=16;
  `endif

  localparam DATA_WIDTH=32;
  input clk;
  input rst;
  input [ADDR_WIDTH-1:0] read0_addr;
  output [DATA_WIDTH-1:0] read0_data;
  input read0_clkEn;
  input read0_thr;
  input [ADDR_WIDTH-1:0] read1_addr;
  output [DATA_WIDTH-1:0] read1_data;
  input read1_clkEn;
  input read1_thr;
  input [ADDR_WIDTH-1:0] read2_addr;
  output [DATA_WIDTH-1:0] read2_data;
  input read2_clkEn;
  input read2_thr;
  input [ADDR_WIDTH-1:0] read3_addr;
  output [DATA_WIDTH-1:0] read3_data;
  input read3_clkEn;
  input read3_thr;
  input [ADDR_WIDTH-1:0] read4_addr;
  output [DATA_WIDTH-1:0] read4_data;
  input read4_clkEn;
  input read4_thr;
  input [ADDR_WIDTH-1:0] read5_addr;
  output [DATA_WIDTH-1:0] read5_data;
  input read5_clkEn;
  input read5_thr;

  input [ADDR_WIDTH-1:0] write0_addr;
  input [DATA_WIDTH-1:0] write0_data;
  input write0_thr;
  input write0_new;
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

  input except;
  input except_thread;

  reg [DATA_WIDTH-1:0] enabl [ADDR_COUNT-1:0]; 
  reg [DATA_WIDTH-1:0] confirm [ADDR_COUNT-1:0]; 
  reg [DATA_WIDTH-1:0] thread [ADDR_COUNT-1:0]; 
  
  reg [ADDR_WIDTH-1:0] read0_addr_reg;
  reg [ADDR_WIDTH-1:0] read1_addr_reg;
  reg [ADDR_WIDTH-1:0] read2_addr_reg;
  reg [ADDR_WIDTH-1:0] read3_addr_reg;
  reg [ADDR_WIDTH-1:0] read4_addr_reg;
  reg [ADDR_WIDTH-1:0] read5_addr_reg;
  reg read0_thr_reg;
  reg read1_thr_reg;
  reg read2_thr_reg;
  reg read3_thr_reg;
  reg read4_thr_reg;
  reg read5_thr_reg;

  assign read0_data=enabl[read0_addr_reg]&({{32}read0_thr_reg}~^thread[read0_addr_reg]) |
    confirm[read0_addr_reg];
  assign read1_data=enabl[read1_addr_reg]&({{32}read1_thr_reg}~^thread[read1_addr_reg]) |
    confirm[read1_addr_reg];
  assign read2_data=enabl[read2_addr_reg]&({{32}read2_thr_reg}~^thread[read2_addr_reg]) |
    confirm[read2_addr_reg];
  assign read3_data=enabl[read3_addr_reg]&({{32}read3_thr_reg}~^thread[read3_addr_reg]) |
    confirm[read3_addr_reg];
  assign read4_data=enabl[read4_addr_reg]&({{32}read4_thr_reg}~^thread[read4_addr_reg]) |
    confirm[read4_addr_reg];
  assign read5_data=enabl[read5_addr_reg]&({{32}read5_thr_reg}~^thread[read5_addr_reg]) |
    confirm[read5_addr_reg];

  integer j;

  always @(posedge clk) begin
    if(rst) begin
    end else begin
        if (read0_clkEn) read0_addr_reg<=read0_addr;
        if (read1_clkEn) read1_addr_reg<=read1_addr;
        if (read2_clkEn) read2_addr_reg<=read2_addr;
        if (read3_clkEn) read3_addr_reg<=read3_addr;
        if (read4_clkEn) read4_addr_reg<=read4_addr;
        if (read5_clkEn) read5_addr_reg<=read5_addr;

        if (read0_clkEn) read0_thr_reg<=read0_thr;
        if (read1_clkEn) read1_thr_reg<=read1_thr;
        if (read2_clkEn) read2_thr_reg<=read2_thr;
        if (read3_clkEn) read3_thr_reg<=read3_thr;
        if (read4_clkEn) read4_thr_reg<=read4_thr;
        if (read5_clkEn) read5_thr_reg<=read5_thr;
        
        if (except) begin
            for(j=0;j<ADDR_COUNT;j=j+1) begin
                enabl[j]<=enabl[j] & ((thread ^ {32{except_thread}})|confirm[j]);
            end
        end
    end
  end
endmodule

