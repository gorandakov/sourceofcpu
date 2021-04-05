`include "../struct.sv"


module storq_reqSpit_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );
  localparam ADDR_WIDTH=4;
  localparam ADDR_COUNT=12;
  localparam DATA_WIDTH=`lsaddr_width;

  input clk;
  input rst;
  input read_clkEn;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram[ADDR_COUNT-1:0];

  reg [ADDR_WIDTH-1:0] read_addr_reg;

  assign read_data=ram[read_addr_reg];

  always @(posedge clk) begin
      if (rst) begin
          read_addr_reg<={ADDR_WIDTH{1'B0}};
      end else begin
          if (read_clkEn) read_addr_reg<=read_addr;
          if (write_wen) ram[write_addr]<=write_data;
      end
  end

endmodule

module reqSpit_up_down(
  clk,
  rst,
  adv,adv2,en,
  has1,has2,
  doStall
  );

  input clk;
  input rst;
  input adv;
  input adv2;
  input en;
  output has1;
  output has2;
  output doStall;

  reg [4:0] cnt;
  wire [4:0] cnt_d;

  wire [1:-2] cnt2;
  wire [0:-2] cnta;

  assign cnta[0]=~adv;
  assign cnta[-1]=adv & ~adv2;
  assign cnta[-2]=adv2;

  assign cnt2=en ? {cnta,1'b0} : {1'b0,cnta};

  assign has1=cnt!=5'd0;
  assign has2=cnt[4:1]!=4'd0;

  assign doStall=cnt==5'd24;

  generate
    genvar t;
    for(t=-2;t<=1;t=t+1) begin : incdec_gen
        adder #(5) add_mod(cnt,t[4:0],cnt_d,1'b0,cnt2[t],,,,);
    end
  endgenerate

  always @(posedge clk) begin
      if (rst) cnt<=5'd0;
      else cnt<=cnt_d;
  end
endmodule
 
module storq_reqSpit(
  clk,
  rst,
  bDoStall,
  read_data0,
  read_data1,
  write_data0,write_data1,write_data2,
  write_data_shr,
  write_data_shrB,
  write_wen,
  has1,has2,en0,en1
  );
  localparam ADDR_WIDTH=4;
  localparam DATA_WIDTH=`lsaddr_width;
  localparam BDATA_WIDTH=`lsqshare_width;

  input clk;
  input rst;
  output bDoStall;
  output [DATA_WIDTH-1:0] read_data0;
  output [DATA_WIDTH-1:0] read_data1;
  input [DATA_WIDTH-1:0] write_data0;
  input [DATA_WIDTH-1:0] write_data1;
  input [DATA_WIDTH-1:0] write_data2;
  input [5:0] write_data_shr;
  input [BDATA_WIDTH-1:0] write_data_shrB;

  input write_wen;
  output has1,has2;
  input en0,en1;

  wire [DATA_WIDTH-1:0] read_dataE[2:0];
  wire [DATA_WIDTH-1:0] read_dataO[2:0];
  wire [DATA_WIDTH-1:0] write_data[2:0];

  wire hhas1,hhas2;

  reg [1:0] dfb_pos;
  wire [1:0] dfb_feed;

  wire [5:0] dfb_rddataE;
  reg  [3:0] dfb_rdaddrE;
  wire [3:0] dfb_rdaddrE_d;
  wire [5:0] dfb_rddataO;
  reg  [3:0] dfb_rdaddrO;
  wire [3:0] dfb_rdaddrO_d;
  reg dfb_odd,dfb_wrodd;
  wire dfb_advance;
  wire dfb_advance2;
  wire [DATA_WIDTH-1:0] dfb_first;
  wire [DATA_WIDTH-1:0] dfb_second;
  wire [2:0][DATA_WIDTH-1:0] dfb_firstA;
  wire [2:0][DATA_WIDTH-1:0] dfb_secondA;
  wire [2:0][DATA_WIDTH-1:0] dfb_firstB;
  wire [2:0][DATA_WIDTH-1:0] dfb_secondB;
  
  wire [3:0] dfbE_cnt;
  wire [3:0] dfbO_cnt;
  wire [3:0] dfb_cntA;
  wire [3:0] dfb_cntB;
  
  reg  [3:0] write_addrO;
  wire [3:0] write_addrO_d;
  reg  [3:0] write_addrE;
  wire [3:0] write_addrE_d;
  
  wire read_clkEnE=dfb_advance & ~dfb_odd || dfb_advance2;
  wire read_clkEnO=dfb_advance & dfb_odd || dfb_advance2;
 

  reg init;
  reg [3:0] initCount;
  wire [3:0] initCount_d;
 
  generate
    genvar c,d;
    for(c=0;c<3;c=c+1) begin : rams_gen
        storq_reqSpit_ram ramE_mod(
        clk,
        rst,
        read_clkEnE,
        dfb_rdaddrE_d,
        read_dataE[c],
        init ? initCount : write_addrE,
        write_data[c]&{DATA_WIDTH{~init}},
        (write_wen && ~dfb_wrodd)|init
        );
        storq_reqSpit_ram ramO_mod(
        clk,
        rst,
        read_clkEnO,
        dfb_rdaddrO_d,
        read_dataO[c],
        init ? initCount : write_addrO,
        write_data[c]&{DATA_WIDTH{~init}},
        (write_wen && dfb_wrodd)|init
        );
        
        assign dfb_firstA[0]=(~dfb_odd && dfb_rddataE[2*c+:2]==2'd0) ? read_dataE[c] : {DATA_WIDTH{1'BZ}};
        assign dfb_secondA[0]=(~dfb_odd && dfb_rddataE[2*c+:2]==2'd1) ? read_dataE[c] : {DATA_WIDTH{1'BZ}};
        assign dfb_secondA[1]=(~dfb_odd && dfb_rddataE[2*c+:2]==2'd2) ? read_dataE[c] : {DATA_WIDTH{1'BZ}};
        assign dfb_firstA[0]=(dfb_odd && dfb_rddataO[2*c+:2]==2'd0) ? read_dataO[c] : {DATA_WIDTH{1'BZ}};
        assign dfb_secondA[0]=(dfb_odd && dfb_rddataO[2*c+:2]==2'd1) ? read_dataO[c] : {DATA_WIDTH{1'BZ}};
        assign dfb_secondA[1]=(dfb_odd && dfb_rddataO[2*c+:2]==2'd2) ? read_dataO[c] : {DATA_WIDTH{1'BZ}};
        
        assign dfb_firstB[0]=(dfb_odd && dfb_rddataE[2*c+:2]==2'd0) ? read_dataE[c] : {DATA_WIDTH{1'BZ}};
        assign dfb_secondB[0]=(dfb_odd && dfb_rddataE[2*c+:2]==2'd1) ? read_dataE[c] : {DATA_WIDTH{1'BZ}};
        assign dfb_secondB[1]=(dfb_odd && dfb_rddataE[2*c+:2]==2'd2) ? read_dataE[c] : {DATA_WIDTH{1'BZ}};
        assign dfb_firstB[0]=(~dfb_odd && dfb_rddataO[2*c+:2]==2'd0) ? read_dataO[c] : {DATA_WIDTH{1'BZ}};
        assign dfb_secondB[0]=(~dfb_odd && dfb_rddataO[2*c+:2]==2'd1) ? read_dataO[c] : {DATA_WIDTH{1'BZ}};
        assign dfb_secondB[1]=(~dfb_odd && dfb_rddataO[2*c+:2]==2'd2) ? read_dataO[c] : {DATA_WIDTH{1'BZ}};

    end
  endgenerate
  assign dfb_feed[0]=en0 & ~en1;
  assign dfb_feed[1]=en0 & en1;
  
  assign dfb_firstA[0]=dfb_cntA[0] ? {DATA_WIDTH{1'B0}} : {DATA_WIDTH{1'Bz}};
  assign dfb_secondA[0]=dfb_cntA[1:0]!=0 ? {DATA_WIDTH{1'B0}} : {DATA_WIDTH{1'Bz}};
  assign dfb_secondA[1]=(~dfb_cntA[3]) ? {DATA_WIDTH{1'B0}} : {DATA_WIDTH{1'Bz}};
  assign dfb_firstA[1]=dfb_secondA[0];
  assign dfb_firstA[2]=dfb_secondA[1];
  assign dfb_secondA[2]={DATA_WIDTH{1'B0}};

  assign dfb_firstB[0]=dfb_cntB[0] ? {DATA_WIDTH{1'B0}} : {DATA_WIDTH{1'Bz}};
  assign dfb_secondB[0]=dfb_cntB[1:0]!=0 ? {DATA_WIDTH{1'B0}} : {DATA_WIDTH{1'Bz}};
  assign dfb_secondB[1]=(~dfb_cntB[3]) ? {DATA_WIDTH{1'B0}} : {DATA_WIDTH{1'Bz}};
  assign dfb_firstB[1]=dfb_secondB[0];
  assign dfb_firstB[2]=dfb_secondB[1];
  assign dfb_secondB[2]={DATA_WIDTH{1'B0}};
  
  assign dfb_first=dfb_firstA[dfb_pos];
  assign dfb_second=((dfb_pos==2'd0 && dfb_cntA[3:2]!=0) || (dfb_pos==2'd1 && dfb_cntA[3])) ? 
    dfb_secondA[dfb_pos] : dfb_firstB[0];

  assign read_data0=dfb_first;
  assign read_data1=dfb_second;

  assign write_data[0]=write_data0;
  assign write_data[1]=write_data1;
  assign write_data[2]=write_data2;
  
  assign dfb_cntA=dfb_odd ? dfbO_cnt : dfbE_cnt;
  assign dfb_cntB=dfb_odd ? dfbE_cnt : dfbO_cnt;

  assign dfb_rdaddrE_d=(dfb_rdaddrE==4'd11) ? 4'd0 : 4'bz;
  assign dfb_rdaddrO_d=(dfb_rdaddrO==4'd11) ? 4'd0 : 4'bz;
  
  assign write_addrE_d=(write_addrE==4'd11) ? 4'd0 : 4'bz;
  assign write_addrO_d=(write_addrO==4'd11) ? 4'd0 : 4'bz;
  
  assign dfb_advance=(dfb_pos==0 && dfb_cntA[1] && dfb_feed[0]) || 
    (dfb_pos==0 && dfb_cntA[2:1]!=0 && dfb_feed[1]) ||
    (dfb_pos==1 && dfb_cntA[2] && dfb_feed[0]) ||
    (dfb_pos==1 && dfb_cntA[3:2]!=0 && dfb_feed[1]) ||
    (dfb_pos==2 && dfb_cntA[3] && dfb_feed!=0);
  assign dfb_advance2=dfb_feed[1] && dfb_cntB[1] && (
    (dfb_pos==0 && dfb_cntA[1]) || (dfb_pos==1 && dfb_cntA[2]) ||
    (dfb_pos==2 && dfb_cntA[3]));


  assign has1=hhas1;
  assign has2=hhas2 || hhas1 & ((dfb_pos==2'd0 && dfb_cntA[2]) || (dfb_pos==2'd1 && dfb_cntA[3]));



  popcnt3 dbf_cntE_mod({dfb_rddataE[1:0]!=2'd3,dfb_rddataE[3:2]!=2'd3,dfb_rddataE[5:4]!=2'd3},dfbE_cnt);
  popcnt3 dbf_cntO_mod({dfb_rddataO[1:0]!=2'd3,dfb_rddataO[3:2]!=2'd3,dfb_rddataO[5:4]!=2'd3},dfbO_cnt);
  
  reqSpit_up_down ud_mod(
  clk,
  rst,
  dfb_advance,dfb_advance2,write_wen,
  hhas1,hhas2,bDoStall
  );

  storq_reqSpit_shared_ram ramES_mod(
  clk,
  rst,
  read_clkEnE,
  dfb_rdaddrE_d,
  dfb_rddataE,
  init ? initCount : write_addrE,
  write_data_shr|{6{init}},
  (write_wen && ~dfb_wrodd)|init
  );
  storq_reqSpit_shared_ram ramOS_mod(
  clk,
  rst,
  read_clkEnO,
  dfb_rdaddrO_d,
  dfb_rddataO,
  init ? initCount : write_addrO,
  write_data_shr|{6{init}},
  (write_wen && dfb_wrodd)|init
  );

  adder_inc #(4) dfbEadd_mod(dfb_rdaddrE,dfb_rdaddrE_d,dfb_rdaddrE!=4'd11,);
  adder_inc #(4) dfbOadd_mod(dfb_rdaddrO,dfb_rdaddrO_d,dfb_rdaddrO!=4'd11,);
  adder_inc #(4) wrtEadd_mod(write_addrE,write_addrE_d,write_addrE!=4'd11,);
  adder_inc #(4) wrtOadd_mod(write_addrO,write_addrO_d,write_addrO!=4'd11,);
  
  adder_inc #(4) initAdd_mod(initCount,initCount_d,1'b1,); 
  always @(posedge clk) begin
    if (rst) begin
        dfb_rdaddrE<=4'b0;
        dfb_rdaddrO<=4'b0;
        write_addrE<=4'b0;
        write_addrO<=4'b0;
        dfb_wrodd<=1'b0;
        dfb_odd<=1'b0;
        dfb_pos<=2'd0;
    end else begin
	if (dfb_advance & ~dfb_odd || dfb_advance2) dfb_rdaddrE<=dfb_rdaddrE_d;
	if (dfb_advance & dfb_odd || dfb_advance2) dfb_rdaddrO<=dfb_rdaddrO_d;
        if (~dfb_wrodd & write_wen) write_addrE<=write_addrE_d;
        if (dfb_wrodd & write_wen) write_addrO<=write_addrO_d;
        if (write_wen) dfb_wrodd<=~dfb_wrodd;
        if (dfb_advance & ~dfb_advance2) dfb_odd<=~dfb_odd;
        if (dfb_advance2) dfb_pos<=2'd0;
	else if (dfb_advance & dfb_feed[0]) dfb_pos<=2'd0;
	else if (dfb_advance & dfb_feed[1]) dfb_pos<={1'b0,(dfb_pos==0 && dfb_cntA[1])||
		(dfb_pos==1 && dfb_cntA[2]) || (dfb_pos==2 && dfb_cntA[3])};
        else if (dfb_feed[0]) dfb_pos<=(dfb_pos!=0) ? 2'd2 : 2'd1;
        else if (dfb_feed[1]) dfb_pos<=2'd2;
    end
    if (rst) begin
        init<=1'b1;
        initCount<=4'b0;
    end else if (init) begin
        initCount<=initCount_d;
        if (initCount==4'd11) init<=1'b0;
    end
  end
endmodule
  
module storq_reqSpit_shared_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );
  localparam ADDR_WIDTH=4;
  localparam ADDR_COUNT=12;
  localparam DATA_WIDTH=6;

  input clk;
  input rst;
  input read_clkEn;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram[ADDR_COUNT-1:0];

  reg [ADDR_WIDTH-1:0] read_addr_reg;

  assign read_data=ram[read_addr_reg];

  always @(posedge clk) begin
      if (rst) begin
          read_addr_reg<={ADDR_WIDTH{1'B0}};
      end else begin
          if (read_clkEn) read_addr_reg<=read_addr;
          if (write_wen) ram[write_addr]<=write_data;
      end
  end

endmodule

