
module testcase(
  input clk,
  input rst);

  wire IRQ;
  wire [16:0] IRQ_data;
  wire IRQ_thr;
  wire [67:0] obusIn;
  wire [81:0] obusOut;
  wire obusOut_want;
  wire obusOut_can;
  wire [37:0] obusDIns;
  wire [511+56:0] obusDIn_data;
  wire [511+56:0] obusDOut_dataAUD;
  wire [75:0] obusDOut_iosig;
  wire obusDOut_can;
  wire obusDOut_want;
  wire obusDOut_replay;

  reg [1023:0] RAM[1024*1024*5-1:0];
  reg [15:0] RAM_PTR[1024*1024*5-1:0];
  reg [4*33-1:0] RAM_RETIRE[1024*1024*8-1:0]


  heptane_core core_mod(
  clk,
  rst,
  IRQ,
  IRQ_data,
  IRQ_thr,
  obusIn,
  obusOut,
  obusOut_want,
  obusOut_can,
  obusDIns,
  obusDIn_data,
  obusDOut_dataAUD,
  obusDOut_iosig,
  obusDOut_can,
  inout obusDOut_want,
  obusDOut_replay,
  ret_en,ret_enX,ret_data
  );

endmodule
