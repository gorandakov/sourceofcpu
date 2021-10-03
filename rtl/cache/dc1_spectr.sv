`include "../struct.sv"


module dc1_xbit_ram(
  clk,
  rst,
  readA_clkEn,
  readA_addr,
  readA_data,
  readB_clkEn,
  readB_addr,
  readB_data,
  writeA_clkEn,
  writeA_addr,
  writeA_data,
  writeB_clkEn,
  writeB_addr,
  writeB_data);
  `ifdef DCACHE_256K
  localparam ADDR_WIDTH=6;
  localparam ADDR_COUNT=64;
  `else
  localparam ADDR_WIDTH=5;
  localparam ADDR_COUNT=32;
  `endif

  input clk;
  input rst;
  input                  readA_clkEn;
  input [ADDR_WIDTH-1:0] readA_addr;
  output [35:0]          readA_data;
  input                  readB_clkEn;
  input [ADDR_WIDTH-1:0] readB_addr;
  output [35:0]          readB_data;
  input                  writeA_clkEn;
  input [ADDR_WIDTH-1:0] writeA_addr;
  input  [35:0]          writeA_data;
  input                  writeB_clkEn;
  input [ADDR_WIDTH-1:0] writeB_addr;
  input  [35:0]          writeB_data;

  reg [35:0] RAM[ADDR_COUNT-1:0];
  reg [ADDR_WIDTH-1:0] readA_addr_reg;
  reg [ADDR_WIDTH-1:0] readB_addr_reg;

  assign readA_data=RAM[readA_addr_reg];
  assign readB_data=RAM[readB_addr_reg];

  always @(posedge clk) begin
      readA_addr_reg<=readA_addr;
      readB_addr_reg<=readB_addr;
      if (writeA_clkEn) RAM[writeA_addr]<=writeA_data;
      if (writeB_clkEn) RAM[writeB_addr]<=writeB_data;
  end
endmodule

module dc1_xbit(
  clk,
  rst,
  read0_clkEn,read0_addr,read0_odd,read0_pbit,
  read1_clkEn,read1_addr,read1_odd,read1_pbit,
  read2_clkEn,read2_addr,read2_odd,read2_pbit,
  read3_clkEn,read3_addr,read3_odd,read3_pbit,
  write0_clkEn,write0_addr,write0_odd,write0_pbit,
  write1_clkEn,write1_addr,write1_odd,write1_pbit,
  write_ins,write_data);
  `ifdef DCACHE_256K
  localparam ADDR_WIDTH=6;
  localparam ADDR_COUNT=64;
  `else
  localparam ADDR_WIDTH=5;
  localparam ADDR_COUNT=32;
  `endif
  input clk;
  input rst;
  input read0_clkEn;
  input [ADDR_WIDTH+4:0] read0_addr;
  input read0_odd;
  output read0_pbit;
  input read1_clkEn;
  input [ADDR_WIDTH+4:0] read1_addr;
  input read1_odd;read1_pbit;
  input read2_clkEn;
  input [ADDR_WIDTH+4:0] read2_addr;
  input read2_odd;read2_pbit;
  input read3_clkEn;
  input [ADDR_WIDTH+4:0] read3_addr;
  input read3_odd;read3_pbit;
  input write0_clkEn;
  input [ADDR_WIDTH+4:0] write0_addr;
  input write0_odd;
  input write0_pbit;
  input write1_clkEn;
  input [ADDR_WIDTH+4:0] write1_addr;
  input write1_odd;
  input write1_pbit;
  input write_ins;
  input [15:0] write_data;

  wire [35:0] read0_data_ram[1:0];
  wire [35:0] read1_data_ram[1:0];
  wire [35:0] read2_data_ram[1:0];
  wire [35:0] read3_data_ram[1:0];
  wire [35:0] readA_data_ram[1:0];
  wire [35:0] readB_data_ram[1:0];
  wire [35:0] write_dataA;
  wire [35:0] write_dataB;

  reg write0_clkEn_reg[1:0];
  reg write1_clkEn_reg[1:0];
  reg write_ins_reg[1:0];
  
  reg [ADDR_WIDTH+4:0] write1_addr_reg;
  reg [ADDR_WIDTH+4:0] write0_addr_reg;

generate
  genvar x;
  for(x=0;x<2;x=x+1)begin : ramset
  dc1_xbit_ram ramA0(
  clk,
  rst,
  read0_clkEn,
  read0_addr[ADDR_WIDTH+3:4],
  read0_data_ram[x],
  read1_clkEn,
  read1_addr[ADDR_WIDTH+3:4],
  read1_data_ram[x],
  write0_clkEn_reg[x]|write_ins_reg[x],
  write0_addr_reg[ADDR_WIDTH+3:4],
  write_dataA,
  write1_clkEn_reg[x]&~write_ins_reg[x],
  write1_addr_reg[ADDR_WIDTH+3:4],
  write_dataB);

  dc1_xbit_ram ramB0(
  clk,
  rst,
  read2_clkEn,
  read2_addr[ADDR_WIDTH+3:4],
  read2_data_ram[x],
  read3_clkEn,
  read3_addr[ADDR_WIDTH+3:4],
  read3_data_ram[x],
  write0_clkEn_reg[x]|write_ins_reg[x],
  write0_addr_reg[ADDR_WIDTH+3:4],
  write_dataA,
  write1_clkEn_reg[x]&~write_ins_reg[x],
  write1_addr_reg[ADDR_WIDTH+3:4],
  write_dataB);


  dc1_xbit_ram ramC0(
  clk,
  rst,
  write0_clkEn,
  write0_addr[ADDR_WIDTH+3:4],
  readA_data_ram[x],
  write1_clkEn,
  write1_addr[ADDR_WIDTH+3:4],
  readB_data_ram[x],
  write0_clkEn_reg[x]|write_ins_reg[x],
  write0_addr_reg[ADDR_WIDTH+3:4],
  write_dataA,
  write1_clkEn_reg[x]&~write_ins_reg[x],
  write1_addr_reg[ADDR_WIDTH+3:4],
  write_dataB);
  end
endgenerate


endmodule
