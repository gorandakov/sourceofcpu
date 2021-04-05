`include "../struct.sv"
/*
module lswl_chk(
  check_against,
  checkee,
  full_match,
  full_match_off,
  bank_match,
  bank_match_off,
  bank_match_sz,
  waitfor_match,
  non_match);

endmodule
*/
module lsw_buf(
  clk,
  rst,
  read_data0,read_oe0,
  read_data1,read_oe1,
  read_data2,read_oe2,
  read_data3,read_oe3,
  read_data4,read_oe4,
  read_data5,read_oe5,


  write0_addr,write0_data,write0_wen
  );

  localparam DATA_WIDTH=`lsaddr_width;
  localparam ADDR_WIDTH=5;
  parameter INDEX=0;
  
  input clk;
  input rst;

  output [DATA_WIDTH-1:0] read_data0;
  input read_oe0;
  output [DATA_WIDTH-1:0] read_data1;
  input read_oe1;
  output [DATA_WIDTH-1:0] read_data2;
  input read_oe2;
  output [DATA_WIDTH-1:0] read_data3;
  input read_oe3;
  output [DATA_WIDTH-1:0] read_data4;
  input read_oe4;
  output [DATA_WIDTH-1:0] read_data5;
  input read_oe5;
  


  input [ADDR_WIDTH-1:0] write0_addr;
  input [DATA_WIDTH-1:0] write0_data;
  input write0_wen;



  reg [DATA_WIDTH-1:0] data;


  assign read_data0=read_oe0 ? data : {DATA_WIDTH{1'BZ}};
  assign read_data1=read_oe1 ? data : {DATA_WIDTH{1'BZ}};
  assign read_data2=read_oe2 ? data : {DATA_WIDTH{1'BZ}};
  assign read_data3=read_oe3 ? data : {DATA_WIDTH{1'BZ}};
  assign read_data4=read_oe4 ? data : {DATA_WIDTH{1'BZ}};
  assign read_data5=read_oe5 ? data : {DATA_WIDTH{1'BZ}};


  always @(posedge clk)
    if (rst) begin
        data<={DATA_WIDTH{1'B0}};
    end else begin
        if (write0_wen && write0_addr==INDEX[4:0]) begin data<=write0_data; end
    end      
    
endmodule

module lsw_array(
  clk,
  rst,
  read_data0,read_oe0,read_oe0_bank,read_oe0_any,
  read_data1,read_oe1,read_oe1_bank,read_oe1_any,
  read_data2,read_oe2,read_oe2_bank,read_oe2_any,
  read_data3,read_oe3,read_oe3_bank,read_oe3_any,
  read_data4,read_oe4,read_oe4_bank,read_oe4_any,
  read_data5,read_oe5,read_oe5_bank,read_oe5_any,


  write0_addr,write0_data,write0_wen
  );

  localparam DATA_WIDTH=`lsaddr_width;
  localparam ADDR_WIDTH=5;
  parameter INDEX=0;
  parameter BANK_COUNT=4;
  localparam BUF_COUNT=BANK_COUNT*8;
  
  input clk;
  input rst;

  output [DATA_WIDTH-1:0] read_data0;
  input [BUF_COUNT-1:0] read_oe0;
  input [BANK_COUNT-1:0] read_oe0_bank;
  input read_oe0_any;
  output [DATA_WIDTH-1:0] read_data1;
  input [BUF_COUNT-1:0] read_oe1;
  input [BANK_COUNT-1:0] read_oe1_bank;
  input read_oe1_any;
  output [DATA_WIDTH-1:0] read_data2;
  input [BUF_COUNT-1:0] read_oe2;
  input [BANK_COUNT-1:0] read_oe2_bank;
  input read_oe2_any;
  output [DATA_WIDTH-1:0] read_data3;
  input [BUF_COUNT-1:0] read_oe3;
  input [BANK_COUNT-1:0] read_oe3_bank;
  input read_oe3_any;
  output [DATA_WIDTH-1:0] read_data4;
  input [BUF_COUNT-1:0] read_oe4;
  input [BANK_COUNT-1:0] read_oe4_bank;
  input read_oe4_any;
  output [DATA_WIDTH-1:0] read_data5;
  input [BUF_COUNT-1:0] read_oe5;
  input [BANK_COUNT-1:0] read_oe5_bank;
  input read_oe5_any;
  


  input [ADDR_WIDTH-1:0] write0_addr;
  input [DATA_WIDTH-1:0] write0_data;
  input write0_wen;



  generate
    genvar a,b;
    for(a=0;a<4;a=a+1) begin : banks_gen
        wire [DATA_WIDTH-1:0] read_data0k;
        wire [DATA_WIDTH-1:0] read_data1k;
        wire [DATA_WIDTH-1:0] read_data2k;
        wire [DATA_WIDTH-1:0] read_data3k;
        wire [DATA_WIDTH-1:0] read_data4k;
        wire [DATA_WIDTH-1:0] read_data5k;
        for(b=0;b<8;b=b+1) begin : buffers_gen
            lsw_buf #(b+8*a) buf_mod(
            clk,
            rst,
            read_data0k,read_oe0[b+8*a],
            read_data1k,read_oe1[b+8*a],
            read_data2k,read_oe2[b+8*a],
            read_data3k,read_oe3[b+8*a],
            read_data4k,read_oe4[b+8*a],
            read_data5k,read_oe5[b+8*a],


            write0_addr,write0_data,write0_wen
            );
	end
	assign read_data0k=read_oe0_bank[a] ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
	assign read_data1k=read_oe1_bank[a] ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
	assign read_data2k=read_oe2_bank[a] ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
	assign read_data3k=read_oe3_bank[a] ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
	assign read_data4k=read_oe4_bank[a] ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
	assign read_data5k=read_oe5_bank[a] ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};


	assign read_data0=read_oe0_bank[a] ? read_data0k : {DATA_WIDTH{1'BZ}};
	assign read_data1=read_oe1_bank[a] ? read_data1k : {DATA_WIDTH{1'BZ}};
	assign read_data2=read_oe2_bank[a] ? read_data2k : {DATA_WIDTH{1'BZ}};
	assign read_data3=read_oe3_bank[a] ? read_data3k : {DATA_WIDTH{1'BZ}};
	assign read_data4=read_oe4_bank[a] ? read_data4k : {DATA_WIDTH{1'BZ}};
	assign read_data5=read_oe5_bank[a] ? read_data5k : {DATA_WIDTH{1'BZ}};
    end
  endgenerate

  assign read_data0=read_oe0_any ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign read_data1=read_oe1_any ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign read_data2=read_oe2_any ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign read_data3=read_oe3_any ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign read_data4=read_oe4_any ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
  assign read_data5=read_oe5_any ? {DATA_WIDTH{1'BZ}} : {DATA_WIDTH{1'B0}};
endmodule

module lsw_ram(
  clk,
  rst,
  read_data,read_bit,read_bank,read_en,
  write_addr,write_data,write_wen); 
  localparam DATA_WIDTH=`lsaddr_width;
  localparam ADDR_WIDTH=5;
  input clk;
  input rst;
  output [DATA_WIDTH-1:0] read_data;
  input [31:0] read_bit;
  input [3:0] read_bank;
  input read_en;
  input [4:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram[31:0];

  generate
    genvar a,b;
    for(a=0;a<4;a=a+1) begin : bank
        wire [DATA_WIDTH-1:0] data0k;
        for(b=0;b<8;b=b+1) begin 
            assign data0k=read_bit[a*8+b] ? ram[a*8+b] : {DATA_WIDTH{1'bz}};
        end
        assign data0k=read_bank[a] ? {DATA_WIDTH{1'bz}} : {DATA_WIDTH{1'b0}};
        assign read_data=read_bank[a] ? data0k : {DATA_WIDTH{1'bz}};
    end
    assign read_data=read_en ? {DATA_WIDTH{1'bz}} : {DATA_WIDTH{1'b0}};
  endgenerate

  always @(posedge clk) begin
    if (write_wen) ram[write_addr]<=write_data;
  end
endmodule
