`include "../../struct.sv"

module rport_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );
  parameter WIDTH=65;
  input clk;
  input rst;
  input read_clkEn;
  input [4:0] read_addr;
  input [WIDTH-1:0] write_data;
  output [WIDTH-1:0] read_data;
  input [4:0] write_addr;
  input write_wen;

  reg [WIDTH-1:0] RAM;

  assign read_data=RAM[read_addr];

  always @(posedge clk) begin
      if (write_wen) RAM[write_addr]<=write_data;
  end

endmodule

module rport_mx_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write0_addr,
  write0_data,
  write0_wen,
  write1_addr,
  write1_data,
  write1_wen,
  write2_addr,
  write2_data,
  write2_wen,
  write3_addr,
  write3_data,
  write3_wen,
  write4_addr,
  write4_data,
  write4_wen
  );
  parameter WIDTH=3;
  input clk;
  input rst;
  input read_clkEn;
  input [4:0] read_addr;
  output [WIDTH-1:0] read_data;
  input [WIDTH-1:0] write0_data;
  input [4:0] write0_addr;
  input write0_wen;
  input [WIDTH-1:0] write1_data;
  input [4:0] write1_addr;
  input write1_wen;
  input [WIDTH-1:0] write2_data;
  input [4:0] write2_addr;
  input write2_wen;
  input [WIDTH-1:0] write3_data;
  input [4:0] write3_addr;
  input write3_wen;
  input [WIDTH-1:0] write4_data;
  input [4:0] write4_addr;
  input write4_wen;

  reg [WIDTH-1:0] RAM;

  assign read_data=RAM[read_addr];

  always @(posedge clk) begin
      if (write0_wen) RAM[write0_addr]<=write0_data;
      if (write1_wen) RAM[write1_addr]<=write1_data;
      if (write2_wen) RAM[write2_addr]<=write2_data;
      if (write3_wen) RAM[write3_addr]<=write3_data;
      if (write4_wen) RAM[write4_addr]<=write4_data;
  end

endmodule

module rport_mx(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write0_addr,
  write0_data,
  write0_wen,
  write1_addr,
  write1_data,
  write1_wen,
  write2_addr,
  write2_data,
  write2_wen,
  write3_addr,
  write3_data,
  write3_wen,
  write4_addr,
  write4_data,
  write4_wen
  );
  parameter WIDTH=65;
  input clk;
  input rst;
  input read_clkEn;
  input [4:0] read_addr;
  output [WIDTH-1:0] read_data;
  input [WIDTH-1:0] write0_data;
  input [4:0] write0_addr;
  input write0_wen;
  input [WIDTH-1:0] write1_data;
  input [4:0] write1_addr;
  input write1_wen;
  input [WIDTH-1:0] write2_data;
  input [4:0] write2_addr;
  input write2_wen;
  input [WIDTH-1:0] write3_data;
  input [4:0] write3_addr;
  input write3_wen;
  input [WIDTH-1:0] write4_data;
  input [4:0] write4_addr;
  input write4_wen;
  
  rport_mx_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data_mk,
  write0_addr,
  3'b0,
  write0_wen,
  write1_addr,
  3'b1,
  write1_wen,
  write2_addr,
  3'b2,
  write2_wen,
  write3_addr,
  3'b3,
  write3_wen,
  write4_addr,
  3'b4,
  write4_wen
  );

  generate
    genvar wport;
    for(wport=0;wport<=4;wport=wport+1) begin : vert_stack
	wire [WIDTH-1:0] read_datak;
        rport_ram #(WIDTH) (
        clk,
        rst,
        read_clkEn,
        read_addr,
        read_datak,
        write_addr[wport],
        write_data[wport],
        write_wen[wport]
        );
	if (wport!=4)
            assign read_data=read_data_mk==wport ? read_datak : {WIDTH{1'bz}};
        else
            assign read_data=read_data_mk[2] ? read_datak : {WIDTH{1'bz}};
    end
  endgenerate
endmodule
