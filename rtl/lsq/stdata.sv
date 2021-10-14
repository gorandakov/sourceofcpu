`include "../struct.sv"

module lsw_data_ram(
  clk,
  rst,

  read_addr0,read_data0,
  read_addr1,read_data1,
  read_addr2,read_data2,
  read_addr3,read_data3,
  read_addr4,read_data4,
  read_addr5,read_data5,


  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen,
  write2_addr,write2_data,write2_wen,
  write3_addr,write3_data,write3_wen
  );

  localparam DATA_WIDTH=2*64+1+8+2;
  localparam ADDR_WIDTH=7;
  localparam ADDR_COUNT=120;
  
  input clk;
  input rst;


  input [ADDR_WIDTH-1:0] read_addr0;
  output [DATA_WIDTH-1:0] read_data0;
  input [ADDR_WIDTH-1:0] read_addr1;
  output [DATA_WIDTH-1:0] read_data1;
  input [ADDR_WIDTH-1:0] read_addr2;
  output [DATA_WIDTH-1:0] read_data2;
  input [ADDR_WIDTH-1:0] read_addr3;
  output [DATA_WIDTH-1:0] read_data3;
  input [ADDR_WIDTH-1:0] read_addr4;
  output [DATA_WIDTH-1:0] read_data4;
  input [ADDR_WIDTH-1:0] read_addr5;
  output [DATA_WIDTH-1:0] read_data5;
  


  input [ADDR_WIDTH-1:0] write0_addr;
  input [DATA_WIDTH-1:0] write0_data;
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

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];


  assign read_data0=ram[read_addr0];
  assign read_data1=ram[read_addr1];
  assign read_data2=ram[read_addr2];
  assign read_data3=ram[read_addr3];
  assign read_data4=ram[read_addr4];
  assign read_data5=ram[read_addr5];


  always @(posedge clk)
    begin
      if (write0_wen) ram[write0_addr]<=write0_data;
      if (write1_wen) ram[write1_addr]<=write1_data;
      if (write2_wen) ram[write2_addr]<=write2_data;
      if (write3_wen) ram[write3_addr]<=write3_data;
    end      
    
endmodule
module lsw_data(
  clk,
  rst,

  read_addr0,read_data0,
  read_addr1,read_data1,
  read_addr2,read_data2,
  read_addr3,read_data3,
  read_addr4,read_data4,
  read_addr5,read_data5,


  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen,
  new0_addr,new0_en,new0_odd,
  new1_addr,new1_en,new1_odd,
  new2_addr,new2_en,new2_odd
  );

  localparam DATA_WIDTH=2*64+1+8+2;
  localparam ADDR_WIDTH=8;
  
  input clk;
  input rst;


  input [ADDR_WIDTH-1:0] read_addr0;
  output [DATA_WIDTH-1:0] read_data0;
  input [ADDR_WIDTH-1:0] read_addr1;
  output [DATA_WIDTH-1:0] read_data1;
  input [ADDR_WIDTH-1:0] read_addr2;
  output [DATA_WIDTH-1:0] read_data2;
  input [ADDR_WIDTH-1:0] read_addr3;
  output [DATA_WIDTH-1:0] read_data3;
  input [ADDR_WIDTH-1:0] read_addr4;
  output [DATA_WIDTH-1:0] read_data4;
  input [ADDR_WIDTH-1:0] read_addr5;
  output [DATA_WIDTH-1:0] read_data5;
  


  input [ADDR_WIDTH-1:0] write0_addr;
  input [DATA_WIDTH-1:0] write0_data;
  input write0_wen;

  input [ADDR_WIDTH-1:0] write1_addr;
  input [DATA_WIDTH-1:0] write1_data;
  input write1_wen;

  input [ADDR_WIDTH-1:0] new0_addr;
  input new0_en,new0_odd;
  input [ADDR_WIDTH-1:0] new1_addr;
  input new1_en,new1_odd;
  input [ADDR_WIDTH-1:0] new2_addr;
  input new2_en,new2_odd;

  wire [DATA_WIDTH-1:0] read_dataA5;
  wire [DATA_WIDTH-1:0] read_dataB5;
  wire [DATA_WIDTH-1:0] read_dataA4;
  wire [DATA_WIDTH-1:0] read_dataB4;
  wire [DATA_WIDTH-1:0] read_dataA3;
  wire [DATA_WIDTH-1:0] read_dataB3;
  wire [DATA_WIDTH-1:0] read_dataA2;
  wire [DATA_WIDTH-1:0] read_dataB2;
  wire [DATA_WIDTH-1:0] read_dataA1;
  wire [DATA_WIDTH-1:0] read_dataB1;
  wire [DATA_WIDTH-1:0] read_dataA0;
  wire [DATA_WIDTH-1:0] read_dataB0;
  
  wire oddN0_en,evenN0_en,oddN1_en,evenN1_en;
  wire [ADDR_WIDTH-1:0] oddN0_addr;
  wire [ADDR_WIDTH-1:0] evenN0_addr;

  reg init;
  reg [6:0] initCount;
  wire [6:0] initCount_next;
/*  reg read_addr0_reg;
  reg read_addr1_reg;
  reg read_addr2_reg;
  reg read_addr3_reg;
  reg read_addr4_reg;
  reg read_addr5_reg;*/
  assign oddN0_addr=new0_odd ? new0_addr : new1_addr;
  assign evenN0_addr=(~new0_odd) ? new0_addr : new1_addr;
  assign oddN0_en=new0_odd ? new0_en : new1_en;
  assign evenN0_en=(~new0_odd) ? new0_en : new1_en;

  assign oddN1_en=new0_odd & new2_en;
  assign evenN1_en=~new0_odd & new2_en;

  assign read_data0 = read_addr0[0] ? read_dataB0 : read_dataA0;
  assign read_data1 = read_addr1[0] ? read_dataB1 : read_dataA1;
  assign read_data2 = read_addr2[0] ? read_dataB2 : read_dataA2;
  assign read_data3 = read_addr3[0] ? read_dataB3 : read_dataA3;
  assign read_data4 = read_addr4[0] ? read_dataB4 : read_dataA4;
  assign read_data5 = read_addr5[0] ? read_dataB5 : read_dataA5;
  
  lsw_data_ram ramA_mod(
  clk,
  rst,

  read_addr0[7:1],read_dataA0,
  read_addr1[7:1],read_dataA1,
  read_addr2[7:1],read_dataA2,
  read_addr3[7:1],read_dataA3,
  read_addr4[7:1],read_dataA4,
  read_addr5[7:1],read_dataA5,


  write0_addr[7:1],write0_data,write0_wen && ~write0_addr[0],
  write1_addr[7:1],write1_data,write1_wen && ~write1_addr[0],
  evenN0_addr[7:1],{DATA_WIDTH{1'B0}},evenN0_en,
  init ? initCount : new2_addr[7:1],{DATA_WIDTH{1'b0}},evenN1_en|init
  );

  lsw_data_ram ramB_mod(
  clk,
  rst,

  read_addr0[7:1],read_dataB0,
  read_addr1[7:1],read_dataB1,
  read_addr2[7:1],read_dataB2,
  read_addr3[7:1],read_dataB3,
  read_addr4[7:1],read_dataB4,
  read_addr5[7:1],read_dataB5,


  write0_addr[7:1],write0_data,write0_wen && write0_addr[0],
  write1_addr[7:1],write1_data,write1_wen && write1_addr[0],
  oddN0_addr[7:1],{DATA_WIDTH{1'B0}},oddN0_en,
  init ? initCount : new2_addr[7:1],{DATA_WIDTH{1'b0}},oddN1_en|init
  );
  
  adder_inc #(7) initAdd_mod(initCount,initCount_next,1'b1,);
  always @(posedge clk) begin
    if (rst) begin
      init<=1'b1;
      initCount<=7'b0;
    end else if (init) begin
      initCount<=initCount_next;
      if (&initCount) init<=1'b0;
    end
  end
endmodule

