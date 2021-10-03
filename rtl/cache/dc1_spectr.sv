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
  input [1:0] write_ins;
  input [15:0] write_data;

  wire [35:0] read0_data_ram[1:0];
  wire [35:0] read1_data_ram[1:0];
  wire [35:0] read2_data_ram[1:0];
  wire [35:0] read3_data_ram[1:0];
  wire [35:0] readA_data_ram[1:0];
  wire [35:0] readB_data_ram[1:0];
  wire [35:0] write_dataA;
  wire [35:0] write_dataB;
  
  wire [31:0] read0_data_ramx;
  wire [31:0] read1_data_ramx;
  wire [31:0] read2_data_ramx;
  wire [31:0] read3_data_ramx;
  wire [31:0] readA_data_ramx;
  wire [31:0] readB_data_ramx;
  wire [31:0] write_dataAx;
  wire [31:0] write_dataBx;

  reg write0_clkEn_reg[1:0];
  reg write1_clkEn_reg[1:0];
  reg write_ins_reg[1:0];
  
  reg [ADDR_WIDTH+4:0] write1_addr_reg;
  reg [ADDR_WIDTH+4:0] write0_addr_reg;

function [35:0] en_ECC;
  input [31:0] data;
  en_ECC={^data[31:24],data[31:24],^data[23:16],data[23:16],^data[15:8],data[15:8],^data[7:0],data[7:0]};
endfunction
function [31:0] un_ECC;
  input [35:0] data;
  un_ECC={data[34:27],data[25:18],data[16:9],data[7:0]};
endfunction
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
  write0_clkEn_reg[x]|write_ins[x],
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
  write1_clkEn_reg[x]&~write_ins[x],
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

assign write_dataAx=write_ins_reg!=2'b0 ? {write_data_reg,write_data_reg} : 
	write0_data_pbit_reg<<{write0_addr_reg[ADDR_WIDTH+4],write0_addr_reg[3:0]};
assign write_dataBx=write1_data_pbit_reg<<{write1_addr_reg[ADDR_WIDTH+4],write1_addr_reg[3:0]};

assign write_dataA[17:0]=write0_addr_reg[ADDR_WIDTH+4] ? en_ECC(read_dataA_ramx[17:0]) : en_ECC(write_dataAx)[17:0];
assign write_dataA[35:18]=~write0_addr_reg[ADDR_WIDTH+4] ? en_ECC(read_dataA_ramx[35:18]) : en_ECC(write_dataAx)[35:18];
assign write_dataB[17:0]=write1_addr_reg[ADDR_WIDTH+4] ? en_ECC(read_dataB_ramx[17:0]) : en_ECC(write_dataBx)[17:0];
assign write_dataB[35:18]=~write1_addr_reg[ADDR_WIDTH+4] ? en_ECC(read_dataB_ramx[35:18]) : en_ECC(write_dataBx)[35:18];
  
assign read0_data_ramx=un_ECC(read0_data_ram[read0_odd_reg]);
assign read1_data_ramx=un_ECC(read1_data_ram[read1_odd_reg]);
assign read2_data_ramx=un_ECC(read2_data_ram[read2_odd_reg]);
assign read3_data_ramx=un_ECC(read3_data_ram[read3_odd_reg]);
assign readA_data_ramx=un_ECC(readA_data_ram[write0_odd_reg]);
assign readB_data_ramx=un_ECC(readB_data_ram[write1_odd_reg]);

assign read0_pbit=read0_data_ramx[{read0_addr_reg[ADDR_WIDTH+4],read0_addr_reg[3:0]}];
assign read1_pbit=read1_data_ramx[{read1_addr_reg[ADDR_WIDTH+4],read1_addr_reg[3:0]}];
assign read2_pbit=read2_data_ramx[{read2_addr_reg[ADDR_WIDTH+4],read2_addr_reg[3:0]}];
assign read3_pbit=read3_data_ramx[{read3_addr_reg[ADDR_WIDTH+4],read3_addr_reg[3:0]}];

always @(posedge clk) begin
  if (rst) begin
      write0_clkEn_reg<=2'b0;
      write1_clkEn_reg<=2'b0;
      write_ins_reg<=2'b0;
      write_data_reg<=0;
      write0_addr_reg<=0;
      write1_addr_reg<=0;
      read0_addr_reg<=0;
      read1_addr_reg<=0;
      read2_addr_reg<=0;
      read3_addr_reg<=0;
      read0_odd_reg<=1'b0;
      read1_odd_reg<=1'b0;
      read2_odd_reg<=1'b0;
      read3_odd_reg<=1'b0;
      write0_odd_reg<=1'b0;
      write1_odd_reg<=1'b0;

  end else begin
      write0_clkEn_reg<={write0_odd,~write0_odd}&{2{write0_clkEn}};
      write1_clkEn_reg<={write1_odd,~write1_odd}&{2{write1_clkEn}};
      write_ins_reg<={write0_odd,~write0_odd}&{2{write_ins}};
      write_data_reg<=write_data;
      write0_addr_reg<=write0_addr;
      write1_addr_reg<=write1_addr;
      read0_addr_reg<=read0_addr;
      read1_addr_reg<=read1_addr;
      read2_addr_reg<=read2_addr;
      read3_addr_reg<=read3_addr;
      read0_odd_reg<=read0_odd;
      read1_odd_reg<=read1_odd;
      read2_odd_reg<=read2_odd;
      read3_odd_reg<=read3_odd;
      write0_odd_reg<=write0_odd;
      write1_odd_reg<=write1_odd;
  end
end
endmodule
