module heptane_chiplet(
  clk,
  rst,
  rbusIn_signals,rbusIn_src_req,rbusIn_dst_req,rbusIn_address,
  rbusOut_signals,rbusOut_src_req,rbusOut_dst_req,rbusOut_address,rbusOut_can,rbusOut_want,rbusOut_sz,rbusOut_bank0,rbusOut_low,
  rbusDIn_signals,rbusDIn_src_req,rbusDIn_dst_req,rbusDIn_data,
  rbusDOut_signals,rbusDOut_src_req,rbusDOut_dst_req,rbusDOut_data,rbusDOut_can,rbusDOut_want,rbusDOut_replay
);
  parameter [2:0] CHIP_ID=0;
  localparam PHYS_WIDTH=44;
  localparam VIRT_WIDTH=64;
  localparam IP_WIDTH=48;
  localparam [31:0] INIT_IP=32'h20;
  localparam BUS_BANK=32;
  localparam BUS_WIDTH=BUS_BANK*16;
  localparam DATA_WIDTH=65*4;
  localparam INSTR_WIDTH=80;
  localparam IN_REG_WIDTH=6;
  localparam OPERATION_WIDTH=`operation_width;
  localparam PORT_WIDTH=4;
  localparam RS_WIDTH=65;
  localparam REQ_WIDTH=10;

  input clk;
  input rst;
  input [`rbus_width-1:0] rbusIn_signals;
  input [9:0] rbusIn_src_req;
  input [9:0] rbusIn_dst_req;
  input [36:0] rbusIn_address;
  output [`rbus_width-1:0] rbusOut_signals;
  output [9:0] rbusOut_src_req;
  output [9:0] rbusOut_dst_req;
  output [36:0] rbusOut_address;
  output rbusOut_want;
  input rbusOut_can;
  output [4:0] rbusOut_sz;
  output [4:0] rbusOut_bank0;
  output [1:0] rbusOut_low;
  input [`rbusD_width-1:0] rbusDIn_signals;
  input [9:0] rbusDIn_src_req;
  input [9:0] rbusDIn_dst_req;
  input [511:0] rbusDIn_data;
  output [`rbusD_width-1:0] rbusDOut_signals;
  output [9:0] rbusDOut_src_req;
  output [9:0] rbusDOut_dst_req;
  output [511:0] rbusDOut_data;
  input rbusDOut_can;
  output rbusDOut_want;
  output rbusDOut_replay;

  generate
    genvar core;
    for(core=0;core<16;core=core+1) begin : core
        heptane_core #(core) hk(
        clk,
        rst_reg4,
        rbusIn_signalsk[core],rbusIn_src_reqk[core],rbusIn_dst_reqk[core],rbusIn_addressk[core],
        rbusOut_signalsk[core+1],rbusOut_src_reqk[core+1],rbusOut_dst_reqk[core+1],rbusOut_addressk[core+1],rbusOut_cank[core+1],
	rbusOut_wantk[core+1],rbusOut_szk[core+1],rbusOut_bank0k[core+1],rbusOut_lowk[core+1],
        rbusDIn_signalsk[core],rbusDIn_src_reqk[core],rbusDIn_dst_reqk[core],rbusDIn_datak[core],
        rbusDOut_signalsk[core+1],rbusDOut_src_reqk[core+1],rbusDOut_dst_reqk[core+1],
	rbusDOut_datak[core+1],rbusDOut_cank[core+1],rbusDOut_wantk[core+1],rbusDOut_replay
        );
    end
  endgenerate
endmodule
