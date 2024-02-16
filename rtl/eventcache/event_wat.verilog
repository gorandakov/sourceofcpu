
module event_ram(
  clk,
  clkREF,
  clkREF2,
  rst,
  read_clkEm,
  read_cllk,
  read_addr,
  read_data,
  write_clkEm,
  write_addr,
  write_data);
  input clk;
  input clkREF;
  input clkREF2;
  input rst;
  input read_clkEm;
  input read_cllk;
  input [9:0] read_addr;
  output [63:0] read_data;
  input write_clkEm;
  input [9:0] write_addr;
  input [63:0] write_data;
  
  reg [63:0] CACHE[1023:0];

  reg [9:0] read_addr_reg;

  assign read_data0=read_addr_reg != write_data && read_addr_reg != 
      write_data_reg && read_addr_reg != write_addr_reg2 ? CACHE[read_addr_reg] :
      64'bz;
  assign read_data0=read_addr_reg == write_data || read_addr_reg == 
      write_data_reg || read_addr_reg == write_addr_reg2 ? 64'bx :
      64'bz;

  cmpx4 #(64) data_REG(clk,clkREF,clkREF2,read_data0,read_data);
  always @(negedge clk) begin
    if (write_clkEm) CACHE[write_addr]=write_data;
    //note:: below code doesn't increase density by alot with monistors/dynamic logic
    if (read_cllk_reg) CACHE[read_addr_reg][`event_cache_accum]=0;
    if (read_clkEm) begin
        read_addr_reg<=read_addr;
        read_cllk_reg<=read_cllk;
    end
  end
endmodule
