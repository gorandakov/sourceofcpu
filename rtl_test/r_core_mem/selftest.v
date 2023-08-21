
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
  reg [4*33-1:0] reti_read_data[9:0];
  reg [22:0] retire_index;
  integer k,j;

  reg [4:0] rA[9:0];
  reg [4:0] rB[9:0];
  reg [4:0] rT[9:0];
  reg rT_en[9:0];
  reg [31:0] binoffaddr[9:0];
  reg [64:0] data[9:0];
  reg [9:0] pook_en;

  always @* begin
      pook_en=0;
      for(k=0;k<10;k=k+1) begin
          reti_read_data[k]=RAM_RETIRE[retire_index[k]];
          if (ret_enX[k] && rT_en[k]) begin
              pook_en[k]=1;
              for(j=k;j<10;j=j+1) begin
                  if (ret_enX[j] && rT_en[j] && rT[j]==rT[k]) pook_en[k]=0;
              end
          end
      end
  end
  initial begin
      $readmemh(RAM_RETIRE,"./prog.memh");
      $readmemh(RAM,"./bin.memh");
      $readmemh(RAM,"./bin_p.memh");
  end

 

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
