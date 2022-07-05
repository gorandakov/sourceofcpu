`include "../struct.sv"

// main modules: regfile
// the rest are parts of it


//regfile_ram read during write behaviour: write first; untiled memory
//WARNING: data output needs to be updated even if no clkEn; clkEn is only for the addresses.
module regfile_ram(
  clk,
  rst,
  retire_clkEn,

  read0_addr,read0_data,read0_clkEn,
  read1_addr,read1_data,read1_clkEn,
  read2_addr,read2_data,read2_clkEn,
  read3_addr,read3_data,read3_clkEn,
  read4_addr,read4_data,read4_clkEn,
  read5_addr,read5_data,read5_clkEn,
  read6_addr,read6_data,read6_clkEn,
  read7_addr,read7_data,read7_clkEn,
  read8_addr,read8_data,read8_clkEn,
  read9_addr,read9_data,read9_clkEn,

  retireRead_addr,retireRead_data,

  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen,
  write2_addr,write2_data,write2_wen,
  write3_addr,write3_data,write3_wen
  );

  parameter DATA_WIDTH=`alu_width;
  localparam ADDR_WIDTH=4;
  localparam ADDR_COUNT=16;
  
  input clk;
  input rst;
  input retire_clkEn;


  input [ADDR_WIDTH-1:0] read0_addr;
  output [DATA_WIDTH-1:0] read0_data;
  input read0_clkEn;
  
  input [ADDR_WIDTH-1:0] read1_addr;
  output [DATA_WIDTH-1:0] read1_data;
  input read1_clkEn;

  input [ADDR_WIDTH-1:0] read2_addr;
  output [DATA_WIDTH-1:0] read2_data;
  input read2_clkEn;

  input [ADDR_WIDTH-1:0] read3_addr;
  output [DATA_WIDTH-1:0] read3_data;
  input read3_clkEn;

  input [ADDR_WIDTH-1:0] read4_addr;
  output [DATA_WIDTH-1:0] read4_data;
  input read4_clkEn;

  input [ADDR_WIDTH-1:0] read5_addr;
  output [DATA_WIDTH-1:0] read5_data;
  input read5_clkEn;

  input [ADDR_WIDTH-1:0] read6_addr;
  output [DATA_WIDTH-1:0] read6_data;
  input read6_clkEn;

  input [ADDR_WIDTH-1:0] read7_addr;
  output [DATA_WIDTH-1:0] read7_data;
  input read7_clkEn;

  input [ADDR_WIDTH-1:0] read8_addr;
  output [DATA_WIDTH-1:0] read8_data;
  input read8_clkEn;

  input [ADDR_WIDTH-1:0] read9_addr;
  output [DATA_WIDTH-1:0] read9_data;
  input read9_clkEn;


  input [ADDR_WIDTH-1:0] retireRead_addr;
  output [DATA_WIDTH-1:0] retireRead_data;


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

  reg [ADDR_WIDTH-1:0] read0_addr_reg;
  reg [ADDR_WIDTH-1:0] read1_addr_reg;
  reg [ADDR_WIDTH-1:0] read2_addr_reg;
  reg [ADDR_WIDTH-1:0] read3_addr_reg;
  reg [ADDR_WIDTH-1:0] read4_addr_reg;
  reg [ADDR_WIDTH-1:0] read5_addr_reg;
  reg [ADDR_WIDTH-1:0] read6_addr_reg;
  reg [ADDR_WIDTH-1:0] read7_addr_reg;
  reg [ADDR_WIDTH-1:0] read8_addr_reg;
  reg [ADDR_WIDTH-1:0] read9_addr_reg;

  reg [ADDR_WIDTH-1:0] retireRead_addr_reg;

  assign read0_data=ram[read0_addr_reg];
  assign read1_data=ram[read1_addr_reg];
  assign read2_data=ram[read2_addr_reg];
  assign read3_data=ram[read3_addr_reg];
  assign read4_data=ram[read4_addr_reg];
  assign read5_data=ram[read5_addr_reg];
  assign read6_data=ram[read6_addr_reg];
  assign read7_data=ram[read7_addr_reg];
  assign read8_data=ram[read8_addr_reg];
  assign read9_data=ram[read9_addr_reg];


  assign retireRead_data=ram[retireRead_addr_reg][DATA_WIDTH-1:0];

  always @(posedge clk)
    begin
      if (rst)
        begin
          read0_addr_reg<={ADDR_WIDTH{1'b0}};
          read1_addr_reg<={ADDR_WIDTH{1'b0}};
          read2_addr_reg<={ADDR_WIDTH{1'b0}};
          read3_addr_reg<={ADDR_WIDTH{1'b0}};
          read4_addr_reg<={ADDR_WIDTH{1'b0}};
          read5_addr_reg<={ADDR_WIDTH{1'b0}};
          read6_addr_reg<={ADDR_WIDTH{1'b0}};
          read7_addr_reg<={ADDR_WIDTH{1'b0}};
          read8_addr_reg<={ADDR_WIDTH{1'b0}};
          read9_addr_reg<={ADDR_WIDTH{1'b0}};
          retireRead_addr_reg<={ADDR_WIDTH{1'b0}};
        end
      else
      begin
        if (read0_clkEn)
            read0_addr_reg<=read0_addr;
        if (read1_clkEn)
            read1_addr_reg<=read1_addr;
        if (read2_clkEn)
            read2_addr_reg<=read2_addr;
        if (read3_clkEn)
            read3_addr_reg<=read3_addr;
        if (read4_clkEn)
            read4_addr_reg<=read4_addr;
        if (read5_clkEn)
            read5_addr_reg<=read5_addr;
        if (read6_clkEn)
            read6_addr_reg<=read6_addr;
        if (read7_clkEn)
            read7_addr_reg<=read7_addr;
        if (read8_clkEn)
            read8_addr_reg<=read8_addr;
        if (read9_clkEn)
            read9_addr_reg<=read9_addr;
      end
      
      if (retire_clkEn & ~rst)
        begin
          retireRead_addr_reg<=retireRead_addr;
        end

      if (write0_wen) ram[write0_addr]<=write0_data;
      if (write1_wen) ram[write1_addr]<=write1_data;
      if (write2_wen) ram[write2_addr]<=write2_data;
      if (write3_wen) ram[write3_addr]<=write3_data;
    end      
    
endmodule


module regfile_ram_placeholder(
  clk,
  rst,
  read_clkEn,
  retire_clkEn,

  read0_addr,read0_data,
  read1_addr,read1_data,
  read2_addr,read2_data,
  read3_addr,read3_data,
  read4_addr,read4_data,
  read5_addr,read5_data,
  read6_addr,read6_data,
  read7_addr,read7_data,
  read8_addr,read8_data,
  read9_addr,read9_data,

  read0_constEn,
  read1_constEn,
  read2_constEn,
  read3_constEn,
  read4_constEn,
  read5_constEn,
  read6_constEn,
  read7_constEn,
  read8_constEn,
  read9_constEn,

  retireRead_addr,retireRead_data,

  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen,
  write2_addr,write2_data,write2_wen,
  write3_addr,write3_data,write3_wen
  );

  localparam ADDR_WIDTH=`reg_addr_width;
  parameter [3:0] INDEX=4'd15; //this is to be overriden to match tile index; range 0-8
  parameter DATA_WIDTH=`alu_width;
  
  input clk;
  input rst;
  input read_clkEn;
  input retire_clkEn;


  input [ADDR_WIDTH-1:0] read0_addr;
  output [DATA_WIDTH-1:0] read0_data;
  
  input [ADDR_WIDTH-1:0] read1_addr;
  output [DATA_WIDTH-1:0] read1_data;

  input [ADDR_WIDTH-1:0] read2_addr;
  output [DATA_WIDTH-1:0] read2_data;

  input [ADDR_WIDTH-1:0] read3_addr;
  output [DATA_WIDTH-1:0] read3_data;

  input [ADDR_WIDTH-1:0] read4_addr;
  output [DATA_WIDTH-1:0] read4_data;

  input [ADDR_WIDTH-1:0] read5_addr;
  output [DATA_WIDTH-1:0] read5_data;

  input [ADDR_WIDTH-1:0] read6_addr;
  output [DATA_WIDTH-1:0] read6_data;

  input [ADDR_WIDTH-1:0] read7_addr;
  output [DATA_WIDTH-1:0] read7_data;

  input [ADDR_WIDTH-1:0] read8_addr;
  output [DATA_WIDTH-1:0] read8_data;

  input [ADDR_WIDTH-1:0] read9_addr;
  output [DATA_WIDTH-1:0] read9_data;

  input read0_constEn;
  input read1_constEn;
  input read2_constEn;
  input read3_constEn;
  input read4_constEn;
  input read5_constEn;
  input read6_constEn;
  input read7_constEn;
  input read8_constEn;
  input read9_constEn;
  
  input [ADDR_WIDTH-1:0] retireRead_addr;
  output [DATA_WIDTH-1:0] retireRead_data;

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

  reg [ADDR_WIDTH-1:0] read0_addr_reg;
  reg [ADDR_WIDTH-1:0] read1_addr_reg;
  reg [ADDR_WIDTH-1:0] read2_addr_reg;
  reg [ADDR_WIDTH-1:0] read3_addr_reg;
  reg [ADDR_WIDTH-1:0] read4_addr_reg;
  reg [ADDR_WIDTH-1:0] read5_addr_reg;
  reg [ADDR_WIDTH-1:0] read6_addr_reg;
  reg [ADDR_WIDTH-1:0] read7_addr_reg;
  reg [ADDR_WIDTH-1:0] read8_addr_reg;
  reg [ADDR_WIDTH-1:0] read9_addr_reg;

  reg [ADDR_WIDTH-1:0] retireRead_addr_reg;


  wire [DATA_WIDTH-1:0] ram_read0A_data;
  wire [DATA_WIDTH-1:0] ram_read1A_data;
  wire [DATA_WIDTH-1:0] ram_read2A_data;
  wire [DATA_WIDTH-1:0] ram_read3A_data;
  wire [DATA_WIDTH-1:0] ram_read4A_data;
  wire [DATA_WIDTH-1:0] ram_read5A_data;
  wire [DATA_WIDTH-1:0] ram_read6A_data;
  wire [DATA_WIDTH-1:0] ram_read7A_data;
  wire [DATA_WIDTH-1:0] ram_read8A_data;
  wire [DATA_WIDTH-1:0] ram_read9A_data;

  wire [DATA_WIDTH-1:0] ram_read0B_data;
  wire [DATA_WIDTH-1:0] ram_read1B_data;
  wire [DATA_WIDTH-1:0] ram_read2B_data;
  wire [DATA_WIDTH-1:0] ram_read3B_data;
  wire [DATA_WIDTH-1:0] ram_read4B_data;
  wire [DATA_WIDTH-1:0] ram_read5B_data;
  wire [DATA_WIDTH-1:0] ram_read6B_data;
  wire [DATA_WIDTH-1:0] ram_read7B_data;
  wire [DATA_WIDTH-1:0] ram_read8B_data;
  wire [DATA_WIDTH-1:0] ram_read9B_data;

  wire ram_write0A_wen;
  wire ram_write1A_wen;
  wire ram_write2A_wen;
  wire ram_write3A_wen;

  wire ram_write0B_wen;
  wire ram_write1B_wen;
  wire ram_write2B_wen;
  wire ram_write3B_wen;

  wire read0_clkEn;
  wire read1_clkEn;
  wire read2_clkEn;
  wire read3_clkEn;
  wire read4_clkEn;
  wire read5_clkEn;
  wire read6_clkEn;
  wire read7_clkEn;
  wire read8_clkEn;
  wire read9_clkEn;


  reg read0A_en;
  reg read1A_en;
  reg read2A_en;
  reg read3A_en;
  reg read4A_en;
  reg read5A_en;
  reg read6A_en;
  reg read7A_en;
  reg read8A_en;
  reg read9A_en;

  reg read0B_en;
  reg read1B_en;
  reg read2B_en;
  reg read3B_en;
  reg read4B_en;
  reg read5B_en;
  reg read6B_en;
  reg read7B_en;
  reg read8B_en;
  reg read9B_en;

  reg retA_en;
  wire [DATA_WIDTH-1:0] retireReadA_data;
  wire [DATA_WIDTH-1:0] retireReadB_data;

  regfile_ram #(DATA_WIDTH) ramA_mod(
  clk,
  rst,
  retire_clkEn,

  read0_addr[8:5],ram_read0A_data,read0_clkEn & ~read0_addr[4],
  read1_addr[8:5],ram_read1A_data,read1_clkEn & ~read1_addr[4],
  read2_addr[8:5],ram_read2A_data,read2_clkEn & ~read2_addr[4],
  read3_addr[8:5],ram_read3A_data,read3_clkEn & ~read3_addr[4],
  read4_addr[8:5],ram_read4A_data,read4_clkEn & ~read4_addr[4],
  read5_addr[8:5],ram_read5A_data,read5_clkEn & ~read5_addr[4],
  read6_addr[8:5],ram_read6A_data,read6_clkEn & ~read6_addr[4],
  read7_addr[8:5],ram_read7A_data,read7_clkEn & ~read7_addr[4],
  read8_addr[8:5],ram_read8A_data,read8_clkEn & ~read8_addr[4],
  read9_addr[8:5],ram_read9A_data,read9_clkEn & ~read9_addr[4],

  retireRead_addr[8:5],retireReadA_data,

  write0_addr[8:5],write0_data,ram_write0A_wen,
  write1_addr[8:5],write1_data,ram_write1A_wen,
  write2_addr[8:5],write2_data,ram_write2A_wen,
  write3_addr[8:5],write3_data,ram_write3A_wen
  );

  regfile_ram #(DATA_WIDTH) ramB_mod(
  clk,
  rst,
  retire_clkEn,

  read0_addr[8:5],ram_read0B_data,read0_clkEn & read0_addr[4],
  read1_addr[8:5],ram_read1B_data,read1_clkEn & read1_addr[4],
  read2_addr[8:5],ram_read2B_data,read2_clkEn & read2_addr[4],
  read3_addr[8:5],ram_read3B_data,read3_clkEn & read3_addr[4],
  read4_addr[8:5],ram_read4B_data,read4_clkEn & read4_addr[4],
  read5_addr[8:5],ram_read5B_data,read5_clkEn & read5_addr[4],
  read6_addr[8:5],ram_read6B_data,read6_clkEn & read6_addr[4],
  read7_addr[8:5],ram_read7B_data,read7_clkEn & read7_addr[4],
  read8_addr[8:5],ram_read8B_data,read8_clkEn & read8_addr[4],
  read9_addr[8:5],ram_read9B_data,read9_clkEn & read9_addr[4],

  retireRead_addr[8:5],retireReadB_data,

  write0_addr[8:5],write0_data,ram_write0B_wen,
  write1_addr[8:5],write1_data,ram_write1B_wen,
  write2_addr[8:5],write2_data,ram_write2B_wen,
  write3_addr[8:5],write3_data,ram_write3B_wen
  );
  
  assign read0_data=read0A_en ? ram_read0A_data : {DATA_WIDTH{1'bz}};
  assign read1_data=read1A_en ? ram_read1A_data : {DATA_WIDTH{1'bz}};
  assign read2_data=read2A_en ? ram_read2A_data : {DATA_WIDTH{1'bz}};
  assign read3_data=read3A_en ? ram_read3A_data : {DATA_WIDTH{1'bz}};
  assign read4_data=read4A_en ? ram_read4A_data : {DATA_WIDTH{1'bz}};
  assign read5_data=read5A_en ? ram_read5A_data : {DATA_WIDTH{1'bz}};
  assign read6_data=read6A_en ? ram_read6A_data : {DATA_WIDTH{1'bz}};
  assign read7_data=read7A_en ? ram_read7A_data : {DATA_WIDTH{1'bz}};
  assign read8_data=read8A_en ? ram_read8A_data : {DATA_WIDTH{1'bz}};
  assign read9_data=read9A_en ? ram_read9A_data : {DATA_WIDTH{1'bz}};

  assign read0_data=read0B_en ? ram_read0B_data : {DATA_WIDTH{1'bz}};
  assign read1_data=read1B_en ? ram_read1B_data : {DATA_WIDTH{1'bz}};
  assign read2_data=read2B_en ? ram_read2B_data : {DATA_WIDTH{1'bz}};
  assign read3_data=read3B_en ? ram_read3B_data : {DATA_WIDTH{1'bz}};
  assign read4_data=read4B_en ? ram_read4B_data : {DATA_WIDTH{1'bz}};
  assign read5_data=read5B_en ? ram_read5B_data : {DATA_WIDTH{1'bz}};
  assign read6_data=read6B_en ? ram_read6B_data : {DATA_WIDTH{1'bz}};
  assign read7_data=read7B_en ? ram_read7B_data : {DATA_WIDTH{1'bz}};
  assign read8_data=read8B_en ? ram_read8B_data : {DATA_WIDTH{1'bz}};
  assign read9_data=read9B_en ? ram_read9B_data : {DATA_WIDTH{1'bz}};
  
  assign retireRead_data=retA_en ? retireReadA_data : retireReadB_data;
  
  assign ram_write0A_wen=write0_wen && write0_addr[3:0]==INDEX && ~write0_addr[4];
  assign ram_write1A_wen=write1_wen && write1_addr[3:0]==INDEX && ~write1_addr[4];
  assign ram_write2A_wen=write2_wen && write2_addr[3:0]==INDEX && ~write2_addr[4];
  assign ram_write3A_wen=write3_wen && write3_addr[3:0]==INDEX && ~write3_addr[4];

  assign ram_write0B_wen=write0_wen && write0_addr[3:0]==INDEX && write0_addr[4];
  assign ram_write1B_wen=write1_wen && write1_addr[3:0]==INDEX && write1_addr[4];
  assign ram_write2B_wen=write2_wen && write2_addr[3:0]==INDEX && write2_addr[4];
  assign ram_write3B_wen=write3_wen && write3_addr[3:0]==INDEX && write3_addr[4];

  assign read0_clkEn=(read0_addr[3:0]==INDEX) & read_clkEn;
  assign read1_clkEn=(read1_addr[3:0]==INDEX) & read_clkEn;
  assign read2_clkEn=(read2_addr[3:0]==INDEX) & read_clkEn;
  assign read3_clkEn=(read3_addr[3:0]==INDEX) & read_clkEn;
  assign read4_clkEn=(read4_addr[3:0]==INDEX) & read_clkEn;
  assign read5_clkEn=(read5_addr[3:0]==INDEX) & read_clkEn;
  assign read6_clkEn=(read6_addr[3:0]==INDEX) & read_clkEn;
  assign read7_clkEn=(read7_addr[3:0]==INDEX) & read_clkEn;
  assign read8_clkEn=(read8_addr[3:0]==INDEX) & read_clkEn;
  assign read9_clkEn=(read9_addr[3:0]==INDEX) & read_clkEn;

  always @(posedge clk)
    begin
      if (rst)
        begin
          read0A_en<=1'b0;
          read1A_en<=1'b0;
          read2A_en<=1'b0;
          read3A_en<=1'b0;
          read4A_en<=1'b0;
          read5A_en<=1'b0;
          read6A_en<=1'b0;
          read7A_en<=1'b0;
          read8A_en<=1'b0;
          read9A_en<=1'b0;

          read0B_en<=1'b0;
          read1B_en<=1'b0;
          read2B_en<=1'b0;
          read3B_en<=1'b0;
          read4B_en<=1'b0;
          read5B_en<=1'b0;
          read6B_en<=1'b0;
          read7B_en<=1'b0;
          read8B_en<=1'b0;
          read9B_en<=1'b0;

        end
      else
        if (read_clkEn) begin
          read0A_en<=read0_addr[3:0]==INDEX && ~read0_constEn && ~read0_addr[4];
          read1A_en<=read1_addr[3:0]==INDEX && ~read1_constEn && ~read1_addr[4];
          read2A_en<=read2_addr[3:0]==INDEX && ~read2_constEn && ~read2_addr[4];
          read3A_en<=read3_addr[3:0]==INDEX && ~read3_constEn && ~read3_addr[4];
          read4A_en<=read4_addr[3:0]==INDEX && ~read4_constEn && ~read4_addr[4];
          read5A_en<=read5_addr[3:0]==INDEX && ~read5_constEn && ~read5_addr[4];
          read6A_en<=read6_addr[3:0]==INDEX && ~read6_constEn && ~read6_addr[4];
          read7A_en<=read7_addr[3:0]==INDEX && ~read7_constEn && ~read7_addr[4];
          read8A_en<=read8_addr[3:0]==INDEX && ~read8_constEn && ~read8_addr[4];
          read9A_en<=read9_addr[3:0]==INDEX && ~read9_constEn && ~read9_addr[4];

          read0B_en<=read0_addr[3:0]==INDEX && ~read0_constEn && read0_addr[4];
          read1B_en<=read1_addr[3:0]==INDEX && ~read1_constEn && read1_addr[4];
          read2B_en<=read2_addr[3:0]==INDEX && ~read2_constEn && read2_addr[4];
          read3B_en<=read3_addr[3:0]==INDEX && ~read3_constEn && read3_addr[4];
          read4B_en<=read4_addr[3:0]==INDEX && ~read4_constEn && read4_addr[4];
          read5B_en<=read5_addr[3:0]==INDEX && ~read5_constEn && read5_addr[4];
          read6B_en<=read6_addr[3:0]==INDEX && ~read6_constEn && read6_addr[4];
          read7B_en<=read7_addr[3:0]==INDEX && ~read7_constEn && read7_addr[4];
          read8B_en<=read8_addr[3:0]==INDEX && ~read8_constEn && read8_addr[4];
          read9B_en<=read9_addr[3:0]==INDEX && ~read9_constEn && read9_addr[4];
        end
      if (rst) begin
          retA_en<=1'b0;
      end else if (retire_clkEn) begin
          retA_en<=~retireRead_addr[4];
      end
    end
endmodule


module regfile_ram_block(
  clk,
  rst,
  read_clkEn,
  retire_clkEn,

  read0_addr,read0_data,
  read1_addr,read1_data,
  read2_addr,read2_data,
  read3_addr,read3_data,
  read4_addr,read4_data,
  read5_addr,read5_data,
  read6_addr,read6_data,
  read7_addr,read7_data,
  read8_addr,read8_data,
  read9_addr,read9_data,

  read0_constEn,
  read1_constEn,
  read2_constEn,
  read3_constEn,
  read4_constEn,
  read5_constEn,
  read6_constEn,
  read7_constEn,
  read8_constEn,

  read0_const,
  read1_const,
  read2_const,
  read3_const,
  read4_const,
  read5_const,
  read6_const,
  read7_const,
  read8_const,

  retireRead0_addr,retireRead0_data,
  retireRead1_addr,retireRead1_data,
  retireRead2_addr,retireRead2_data,
  retireRead3_addr,retireRead3_data,
  retireRead4_addr,retireRead4_data,
  retireRead5_addr,retireRead5_data,
  retireRead6_addr,retireRead6_data,
  retireRead7_addr,retireRead7_data,
  retireRead8_addr,retireRead8_data,

  write0_addr,write0_data,write0_wen,
  write1_addr,write1_data,write1_wen,
  write2_addr,write2_data,write2_wen,
  write3_addr,write3_data,write3_wen,
  write4_addr,write4_data,write4_wen,
  write5_addr,write5_data,write5_wen,
  write6_addr,write6_data,write6_wen,
  write7_addr,write7_data,write7_wen,
  write8_addr,write8_data,write8_wen,
  write9_addr,write9_data,write9_wen
  );

  parameter DATA_WIDTH=`alu_width;
  localparam ADDR_WIDTH=`reg_addr_width;
  
  input clk;
  input rst;
  input read_clkEn;
  input retire_clkEn;


  input [ADDR_WIDTH-1:0] read0_addr;
  output [DATA_WIDTH-1:0] read0_data;
  
  input [ADDR_WIDTH-1:0] read1_addr;
  output [DATA_WIDTH-1:0] read1_data;

  input [ADDR_WIDTH-1:0] read2_addr;
  output [DATA_WIDTH-1:0] read2_data;

  input [ADDR_WIDTH-1:0] read3_addr;
  output [DATA_WIDTH-1:0] read3_data;

  input [ADDR_WIDTH-1:0] read4_addr;
  output [DATA_WIDTH-1:0] read4_data;

  input [ADDR_WIDTH-1:0] read5_addr;
  output [DATA_WIDTH-1:0] read5_data;

  input [ADDR_WIDTH-1:0] read6_addr;
  output [DATA_WIDTH-1:0] read6_data;

  input [ADDR_WIDTH-1:0] read7_addr;
  output [DATA_WIDTH-1:0] read7_data;

  input [ADDR_WIDTH-1:0] read8_addr;
  output [DATA_WIDTH-1:0] read8_data;

  input [ADDR_WIDTH-1:0] read9_addr;
  output [DATA_WIDTH-1:0] read9_data;


  input read0_constEn;
  input read1_constEn;
  input read2_constEn;
  input read3_constEn;
  input read4_constEn;
  input read5_constEn;
  input read6_constEn;
  input read7_constEn;
  input read8_constEn;
  
  input [DATA_WIDTH-1:0] read0_const;
  input [DATA_WIDTH-1:0] read1_const;
  input [DATA_WIDTH-1:0] read2_const;
  input [DATA_WIDTH-1:0] read3_const;
  input [DATA_WIDTH-1:0] read4_const;
  input [DATA_WIDTH-1:0] read5_const;
  input [DATA_WIDTH-1:0] read6_const;
  input [DATA_WIDTH-1:0] read7_const;
  input [DATA_WIDTH-1:0] read8_const;

  input [ADDR_WIDTH-1:0] retireRead0_addr;
  output [DATA_WIDTH-1:0] retireRead0_data;

  input [ADDR_WIDTH-1:0] retireRead1_addr;
  output [DATA_WIDTH-1:0] retireRead1_data;

  input [ADDR_WIDTH-1:0] retireRead2_addr;
  output [DATA_WIDTH-1:0] retireRead2_data;

  input [ADDR_WIDTH-1:0] retireRead3_addr;
  output [DATA_WIDTH-1:0] retireRead3_data;

  input [ADDR_WIDTH-1:0] retireRead4_addr;
  output [DATA_WIDTH-1:0] retireRead4_data;

  input [ADDR_WIDTH-1:0] retireRead5_addr;
  output [DATA_WIDTH-1:0] retireRead5_data;

  input [ADDR_WIDTH-1:0] retireRead6_addr;
  output [DATA_WIDTH-1:0] retireRead6_data;

  input [ADDR_WIDTH-1:0] retireRead7_addr;
  output [DATA_WIDTH-1:0] retireRead7_data;

  input [ADDR_WIDTH-1:0] retireRead8_addr;
  output [DATA_WIDTH-1:0] retireRead8_data;


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

  input [ADDR_WIDTH-1:0] write4_addr;
  input [DATA_WIDTH-1:0] write4_data;
  input write4_wen;

  input [ADDR_WIDTH-1:0] write5_addr;
  input [DATA_WIDTH-1:0] write5_data;
  input write5_wen;

  input [ADDR_WIDTH-1:0] write6_addr;
  input [DATA_WIDTH-1:0] write6_data;
  input write6_wen;

  input [ADDR_WIDTH-1:0] write7_addr;
  input [DATA_WIDTH-1:0] write7_data;
  input write7_wen;

  input [ADDR_WIDTH-1:0] write8_addr;
  input [DATA_WIDTH-1:0] write8_data;
  input write8_wen;

  input [ADDR_WIDTH-1:0] write9_addr;
  input [DATA_WIDTH-1:0] write9_data;
  input write9_wen;

 

  wire [ADDR_WIDTH-1:0] write0_addr_ram[2:0];
  wire [DATA_WIDTH-1:0] write0_data_ram[2:0];
  wire write0_wen_ram[2:0];
  
  wire [ADDR_WIDTH-1:0] write1_addr_ram[2:0];
  wire [DATA_WIDTH-1:0] write1_data_ram[2:0];
  wire write1_wen_ram[2:0];
  
  wire [ADDR_WIDTH-1:0] write2_addr_ram[2:0];
  wire [DATA_WIDTH-1:0] write2_data_ram[2:0];
  wire write2_wen_ram[2:0];

  wire [ADDR_WIDTH-1:0] retireRead_addr[8:0];
  wire [DATA_WIDTH-1:0] retireRead_data[8:0];


  wire [ADDR_WIDTH-5:0] initRegCount_next;
  
  reg [ADDR_WIDTH-1:0] initRegCount;
  reg doInit;

  wire [4:0] newAddr [8:0];
  wire [8:0] newEn;

  reg [DATA_WIDTH-1:0] read0_const_reg;
  reg [DATA_WIDTH-1:0] read1_const_reg;
  reg [DATA_WIDTH-1:0] read2_const_reg;
  reg [DATA_WIDTH-1:0] read3_const_reg;
  reg [DATA_WIDTH-1:0] read4_const_reg;
  reg [DATA_WIDTH-1:0] read5_const_reg;
  reg [DATA_WIDTH-1:0] read6_const_reg;
  reg [DATA_WIDTH-1:0] read7_const_reg;
  reg [DATA_WIDTH-1:0] read8_const_reg;
  
  reg [ADDR_WIDTH-1:0]  read0_addr_reg;
  wire [2:0][DATA_WIDTH-1:0] read0_dataP;
  reg [ADDR_WIDTH-1:0]  read1_addr_reg;
  wire [2:0][DATA_WIDTH-1:0] read1_dataP;
  reg [ADDR_WIDTH-1:0]  read2_addr_reg;
  wire [2:0][DATA_WIDTH-1:0] read2_dataP;
  reg [ADDR_WIDTH-1:0]  read3_addr_reg;
  wire [2:0][DATA_WIDTH-1:0] read3_dataP;
  reg [ADDR_WIDTH-1:0]  read4_addr_reg;
  wire [2:0][DATA_WIDTH-1:0] read4_dataP;
  reg [ADDR_WIDTH-1:0]  read5_addr_reg;
  wire [2:0][DATA_WIDTH-1:0] read5_dataP;
  reg [ADDR_WIDTH-1:0]  read6_addr_reg;
  wire [2:0][DATA_WIDTH-1:0] read6_dataP;
  reg [ADDR_WIDTH-1:0]  read7_addr_reg;
  wire [2:0][DATA_WIDTH-1:0] read7_dataP;
  reg [ADDR_WIDTH-1:0]  read8_addr_reg;
  wire [2:0][DATA_WIDTH-1:0] read8_dataP;
  reg [ADDR_WIDTH-1:0]  read9_addr_reg;
  wire [2:0][DATA_WIDTH-1:0] read9_dataP;

  reg read0_constEn_reg;
  reg read1_constEn_reg;
  reg read2_constEn_reg;
  reg read3_constEn_reg;
  reg read4_constEn_reg;
  reg read5_constEn_reg;
  reg read6_constEn_reg;
  reg read7_constEn_reg;
  reg read8_constEn_reg;
  
  genvar x;

  assign retireRead_addr[0]=retireRead0_addr;
  assign retireRead_addr[1]=retireRead1_addr;
  assign retireRead_addr[2]=retireRead2_addr;
  assign retireRead_addr[3]=retireRead3_addr;
  assign retireRead_addr[4]=retireRead4_addr;
  assign retireRead_addr[5]=retireRead5_addr;
  assign retireRead_addr[6]=retireRead6_addr;
  assign retireRead_addr[7]=retireRead7_addr;
  assign retireRead_addr[8]=retireRead8_addr;

  assign retireRead0_data=retireRead_data[0];
  assign retireRead1_data=retireRead_data[1];
  assign retireRead2_data=retireRead_data[2];
  assign retireRead3_data=retireRead_data[3];
  assign retireRead4_data=retireRead_data[4];
  assign retireRead5_data=retireRead_data[5];
  assign retireRead6_data=retireRead_data[6];
  assign retireRead7_data=retireRead_data[7];
  assign retireRead8_data=retireRead_data[8];
  
  assign write0_addr_ram[0]=doInit ? initRegCount : write0_addr;
  assign write0_data_ram[0]=doInit ? {DATA_WIDTH{1'b0}} : write0_data;
  assign write0_wen_ram[0]=write0_wen | doInit;

  assign write0_addr_ram[1]=doInit ? initRegCount : write1_addr;
  assign write0_data_ram[1]=doInit ? {DATA_WIDTH{1'b0}} : write1_data;
  assign write0_wen_ram[1]=write1_wen | doInit;
  
  assign write0_addr_ram[2]=doInit ? initRegCount : write2_addr;
  assign write0_data_ram[2]=doInit ? {DATA_WIDTH{1'b0}} : write2_data;
  assign write0_wen_ram[2]=write2_wen | doInit;

  assign write1_addr_ram[0]=write4_addr;
  assign write1_data_ram[0]=write4_data;
  assign write1_wen_ram[0]=write4_wen;

  assign write2_addr_ram[0]=write7_addr;
  assign write2_data_ram[0]=write7_data;
  assign write2_wen_ram[0]=write7_wen;

  assign write1_addr_ram[1]=write5_addr;
  assign write1_data_ram[1]=write5_data;
  assign write1_wen_ram[1]=write5_wen;

  assign write2_addr_ram[1]=write8_addr;
  assign write2_data_ram[1]=write8_data;
  assign write2_wen_ram[1]=write8_wen;
  
  assign write1_addr_ram[2]=write6_addr;
  assign write1_data_ram[2]=write6_data;
  assign write1_wen_ram[2]=write6_wen;

  assign write2_addr_ram[2]=write9_addr;
  assign write2_data_ram[2]=write9_data;
  assign write2_wen_ram[2]=write9_wen;
   
  assign read0_dataP[0]=((read0_addr_reg[3:0]!=4'd0 && read0_addr_reg[3:0]!=4'd1 &&
    read0_addr_reg[3:0]!=4'd2) || read0_constEn_reg) ? read0_const_reg : {DATA_WIDTH{1'BZ}};
  assign read0_dataP[1]=((read0_addr_reg[3:0]!=4'd3 && read0_addr_reg[3:0]!=4'd4 &&
    read0_addr_reg[3:0]!=4'd5) || read0_constEn_reg) ? read0_dataP[0] : {DATA_WIDTH{1'BZ}};
  assign read0_dataP[2]=((read0_addr_reg[3:0]!=4'd6 && read0_addr_reg[3:0]!=4'd7 &&
    read0_addr_reg[3:0]!=4'd8) || read0_constEn_reg) ? read0_dataP[1] : {DATA_WIDTH{1'BZ}};

  assign read1_dataP[0]=((read1_addr_reg[3:0]!=4'd0 && read1_addr_reg[3:0]!=4'd1 &&
    read1_addr_reg[3:0]!=4'd2) || read1_constEn_reg) ? read1_const_reg : {DATA_WIDTH{1'BZ}};
  assign read1_dataP[1]=((read1_addr_reg[3:0]!=4'd3 && read1_addr_reg[3:0]!=4'd4 &&
    read1_addr_reg[3:0]!=4'd5) || read1_constEn_reg) ? read1_dataP[0] : {DATA_WIDTH{1'BZ}};
  assign read1_dataP[2]=((read1_addr_reg[3:0]!=4'd6 && read1_addr_reg[3:0]!=4'd7 &&
    read1_addr_reg[3:0]!=4'd8) || read1_constEn_reg) ? read1_dataP[1] : {DATA_WIDTH{1'BZ}};

  assign read2_dataP[0]=((read2_addr_reg[3:0]!=4'd0 && read2_addr_reg[3:0]!=4'd1 &&
    read2_addr_reg[3:0]!=4'd2) || read2_constEn_reg) ? read2_const_reg : {DATA_WIDTH{1'BZ}};
  assign read2_dataP[1]=((read2_addr_reg[3:0]!=4'd3 && read2_addr_reg[3:0]!=4'd4 &&
    read2_addr_reg[3:0]!=4'd5) || read2_constEn_reg) ? read2_dataP[0] : {DATA_WIDTH{1'BZ}};
  assign read2_dataP[2]=((read2_addr_reg[3:0]!=4'd6 && read2_addr_reg[3:0]!=4'd7 &&
    read2_addr_reg[3:0]!=4'd8) || read2_constEn_reg) ? read2_dataP[1] : {DATA_WIDTH{1'BZ}};

  assign read3_dataP[0]=((read3_addr_reg[3:0]!=4'd0 && read3_addr_reg[3:0]!=4'd1 &&
    read3_addr_reg[3:0]!=4'd2) || read3_constEn_reg) ? read3_const_reg : {DATA_WIDTH{1'BZ}};
  assign read3_dataP[1]=((read3_addr_reg[3:0]!=4'd3 && read3_addr_reg[3:0]!=4'd4 &&
    read3_addr_reg[3:0]!=4'd5) || read3_constEn_reg) ? read3_dataP[0] : {DATA_WIDTH{1'BZ}};
  assign read3_dataP[2]=((read3_addr_reg[3:0]!=4'd6 && read3_addr_reg[3:0]!=4'd7 &&
    read3_addr_reg[3:0]!=4'd8) || read3_constEn_reg) ? read3_dataP[1] : {DATA_WIDTH{1'BZ}};

  assign read4_dataP[0]=((read4_addr_reg[3:0]!=4'd0 && read4_addr_reg[3:0]!=4'd1 &&
    read4_addr_reg[3:0]!=4'd2) || read4_constEn_reg) ? read4_const_reg : {DATA_WIDTH{1'BZ}};
  assign read4_dataP[1]=((read4_addr_reg[3:0]!=4'd3 && read4_addr_reg[3:0]!=4'd4 &&
    read4_addr_reg[3:0]!=4'd5) || read4_constEn_reg) ? read4_dataP[0] : {DATA_WIDTH{1'BZ}};
  assign read4_dataP[2]=((read4_addr_reg[3:0]!=4'd6 && read4_addr_reg[3:0]!=4'd7 &&
    read4_addr_reg[3:0]!=4'd8) || read4_constEn_reg) ? read4_dataP[1] : {DATA_WIDTH{1'BZ}};

  assign read5_dataP[0]=((read5_addr_reg[3:0]!=4'd0 && read5_addr_reg[3:0]!=4'd1 &&
    read5_addr_reg[3:0]!=4'd2) || read5_constEn_reg) ? read5_const_reg : {DATA_WIDTH{1'BZ}};
  assign read5_dataP[1]=((read5_addr_reg[3:0]!=4'd3 && read5_addr_reg[3:0]!=4'd4 &&
    read5_addr_reg[3:0]!=4'd5) || read5_constEn_reg) ? read5_dataP[0] : {DATA_WIDTH{1'BZ}};
  assign read5_dataP[2]=((read5_addr_reg[3:0]!=4'd6 && read5_addr_reg[3:0]!=4'd7 &&
    read5_addr_reg[3:0]!=4'd8) || read5_constEn_reg) ? read5_dataP[1] : {DATA_WIDTH{1'BZ}};

  assign read6_dataP[0]=((read6_addr_reg[3:0]!=4'd0 && read6_addr_reg[3:0]!=4'd1 &&
    read6_addr_reg[3:0]!=4'd2) || read6_constEn_reg) ? read6_const_reg : {DATA_WIDTH{1'BZ}};
  assign read6_dataP[1]=((read6_addr_reg[3:0]!=4'd3 && read6_addr_reg[3:0]!=4'd4 &&
    read6_addr_reg[3:0]!=4'd5) || read6_constEn_reg) ? read6_dataP[0] : {DATA_WIDTH{1'BZ}};
  assign read6_dataP[2]=((read6_addr_reg[3:0]!=4'd6 && read6_addr_reg[3:0]!=4'd7 &&
    read6_addr_reg[3:0]!=4'd8) || read6_constEn_reg) ? read6_dataP[1] : {DATA_WIDTH{1'BZ}};

  assign read7_dataP[0]=((read7_addr_reg[3:0]!=4'd0 && read7_addr_reg[3:0]!=4'd1 &&
    read7_addr_reg[3:0]!=4'd2) || read7_constEn_reg) ? read7_const_reg : {DATA_WIDTH{1'BZ}};
  assign read7_dataP[1]=((read7_addr_reg[3:0]!=4'd3 && read7_addr_reg[3:0]!=4'd4 &&
    read7_addr_reg[3:0]!=4'd5) || read7_constEn_reg) ? read7_dataP[0] : {DATA_WIDTH{1'BZ}};
  assign read7_dataP[2]=((read7_addr_reg[3:0]!=4'd6 && read7_addr_reg[3:0]!=4'd7 &&
    read7_addr_reg[3:0]!=4'd8) || read7_constEn_reg) ? read7_dataP[1] : {DATA_WIDTH{1'BZ}};

  assign read8_dataP[0]=((read8_addr_reg[3:0]!=4'd0 && read8_addr_reg[3:0]!=4'd1 &&
    read8_addr_reg[3:0]!=4'd2) || read8_constEn_reg) ? read8_const_reg : {DATA_WIDTH{1'BZ}};
  assign read8_dataP[1]=((read8_addr_reg[3:0]!=4'd3 && read8_addr_reg[3:0]!=4'd4 &&
    read8_addr_reg[3:0]!=4'd5) || read8_constEn_reg) ? read8_dataP[0] : {DATA_WIDTH{1'BZ}};
  assign read8_dataP[2]=((read8_addr_reg[3:0]!=4'd6 && read8_addr_reg[3:0]!=4'd7 &&
    read8_addr_reg[3:0]!=4'd8) || read8_constEn_reg) ? read8_dataP[1] : {DATA_WIDTH{1'BZ}};

  assign read9_dataP[0]=((read9_addr_reg[3:0]!=4'd0 && read9_addr_reg[3:0]!=4'd1 &&
    read9_addr_reg[3:0]!=4'd2)) ? {DATA_WIDTH{1'b0}} : {DATA_WIDTH{1'BZ}};
  assign read9_dataP[1]=((read9_addr_reg[3:0]!=4'd3 && read9_addr_reg[3:0]!=4'd4 &&
    read9_addr_reg[3:0]!=4'd5)) ? read9_dataP[0] : {DATA_WIDTH{1'BZ}};
  assign read9_dataP[2]=((read9_addr_reg[3:0]!=4'd6 && read9_addr_reg[3:0]!=4'd7 &&
    read9_addr_reg[3:0]!=4'd8)) ? read9_dataP[1] : {DATA_WIDTH{1'BZ}};

  adder_inc #(ADDR_WIDTH-4) initInc_mod(initRegCount[ADDR_WIDTH-1:4],initRegCount_next,1'b1,);

  assign read0_data=read0_dataP[2]; 
  assign read1_data=read1_dataP[2]; 
  assign read2_data=read2_dataP[2]; 
  assign read3_data=read3_dataP[2]; 
  assign read4_data=read4_dataP[2]; 
  assign read5_data=read5_dataP[2]; 
  assign read6_data=read6_dataP[2]; 
  assign read7_data=read7_dataP[2]; 
  assign read8_data=read8_dataP[2]; 
  assign read9_data=read9_dataP[2]; 
  
  generate
    for(x=0;x<=8;x=x+1)
	  begin : rams
		
        regfile_ram_placeholder #(x,DATA_WIDTH) ram_mod(
          clk,
	 // clkX,
          rst,
          read_clkEn,
          retire_clkEn,

          read0_addr,read0_dataP[x/3],
          read1_addr,read1_dataP[x/3],
          read2_addr,read2_dataP[x/3],
          read3_addr,read3_dataP[x/3],
          read4_addr,read4_dataP[x/3],
          read5_addr,read5_dataP[x/3],
          read6_addr,read6_dataP[x/3],
          read7_addr,read7_dataP[x/3],
          read8_addr,read8_dataP[x/3],
          read9_addr,read9_dataP[x/3],

          read0_constEn,
          read1_constEn,
          read2_constEn,
          read3_constEn,
          read4_constEn,
          read5_constEn,
          read6_constEn,
          read7_constEn,
          read8_constEn,
	  1'b0,

          retireRead_addr[x],retireRead_data[x],

          write0_addr_ram[x%3],write0_data_ram[x%3],write0_wen_ram[x%3],
          write1_addr_ram[x%3],write1_data_ram[x%3],write1_wen_ram[x%3],
          write2_addr_ram[x%3],write2_data_ram[x%3],write2_wen_ram[x%3],
          write3_addr,write3_data,write3_wen
        );
      end
  endgenerate

  always @(posedge clk)
    begin
      if (rst)
        begin
          doInit<=1'b1;
          initRegCount<={ADDR_WIDTH{1'b0}};
		  read0_const_reg<={DATA_WIDTH{1'B0}};
		  read1_const_reg<={DATA_WIDTH{1'B0}};
		  read2_const_reg<={DATA_WIDTH{1'B0}};
		  read3_const_reg<={DATA_WIDTH{1'B0}};
		  read4_const_reg<={DATA_WIDTH{1'B0}};
		  read5_const_reg<={DATA_WIDTH{1'B0}};
		  read6_const_reg<={DATA_WIDTH{1'B0}};
		  read7_const_reg<={DATA_WIDTH{1'B0}};
		  read8_const_reg<={DATA_WIDTH{1'B0}};
		  read0_constEn_reg<=1'b0;
		  read1_constEn_reg<=1'b0;
		  read2_constEn_reg<=1'b0;
		  read3_constEn_reg<=1'b0;
		  read4_constEn_reg<=1'b0;
		  read5_constEn_reg<=1'b0;
		  read6_constEn_reg<=1'b0;
		  read7_constEn_reg<=1'b0;
		  read8_constEn_reg<=1'b0;
        end
      else
        begin
          if (doInit)
            case(initRegCount[3:0])
              0: initRegCount[3:0]<=4'd1;
              1: initRegCount[3:0]<=4'd2;
              2: initRegCount[3:0]<=4'd3;
              3: initRegCount[3:0]<=4'd4;
              4: initRegCount[3:0]<=4'd5;
              5: initRegCount[3:0]<=4'd6;
              6: initRegCount[3:0]<=4'd7;
              7: initRegCount[3:0]<=4'd8;
              8: initRegCount<={initRegCount_next,4'd0};          
            endcase
          if ((initRegCount[ADDR_WIDTH-1:4]==(31)) & (initRegCount[3:0]==4'd8))
            doInit<=1'b0; 
		  if (read_clkEn)
		    begin
			  read0_const_reg<=read0_const;
			  read1_const_reg<=read1_const;
			  read2_const_reg<=read2_const;
			  read3_const_reg<=read3_const;
			  read4_const_reg<=read4_const;
			  read5_const_reg<=read5_const;
			  read6_const_reg<=read6_const;
			  read7_const_reg<=read7_const;
			  read8_const_reg<=read8_const;
			  
			  read0_constEn_reg<=read0_constEn;
			  read1_constEn_reg<=read1_constEn;
			  read2_constEn_reg<=read2_constEn;
			  read3_constEn_reg<=read3_constEn;
			  read4_constEn_reg<=read4_constEn;
			  read5_constEn_reg<=read5_constEn;
			  read6_constEn_reg<=read6_constEn;
			  read7_constEn_reg<=read7_constEn;
			  read8_constEn_reg<=read8_constEn;
			end
        end
	if (rst) begin
            read0_addr_reg<=9'b0;
            read1_addr_reg<=9'b0;
            read2_addr_reg<=9'b0;
            read3_addr_reg<=9'b0;
            read4_addr_reg<=9'b0;
            read5_addr_reg<=9'b0;
            read6_addr_reg<=9'b0;
            read7_addr_reg<=9'b0;
            read9_addr_reg<=9'b0;
            read8_addr_reg<=9'b0;
	end else if (read_clkEn) begin
            read0_addr_reg<=read0_addr;
            read1_addr_reg<=read1_addr;
            read2_addr_reg<=read2_addr;
            read3_addr_reg<=read3_addr;
            read4_addr_reg<=read4_addr;
            read5_addr_reg<=read5_addr;
            read6_addr_reg<=read6_addr;
            read7_addr_reg<=read7_addr;
            read9_addr_reg<=read9_addr;
            read8_addr_reg<=read8_addr;
	end
    end
  
endmodule


//module to create correct write-first behaviour
//shared with flags registers by overriding data parameter
module regfile_zero_cycle_write(
  clk,rst,
  read_clkEn,
  read_data_ram,read_data_new,read_addr,
  read_constEn,read_oe,
  match_w,
  write0_addr_reg,write0_wen_reg,
  write1_addr_reg,write1_wen_reg,
  write2_addr_reg,write2_wen_reg,
  write3_addr_reg,write3_wen_reg,
  write4_addr_reg,write4_wen_reg,
  write5_addr_reg,write5_wen_reg,
  write6_addr_reg,write6_wen_reg,
  write7_addr_reg,write7_wen_reg,
  write8_addr_reg,write8_wen_reg,
  write9_addr_reg,write9_wen_reg,
  write0_addr_reg2,write0_wen_reg2,
  write1_addr_reg2,write1_wen_reg2,
  write2_addr_reg2,write2_wen_reg2,
  write3_addr_reg2,write3_wen_reg2,
  write4_addr_reg2,write4_wen_reg2,
  write5_addr_reg2,write5_wen_reg2,
  write6_addr_reg2,write6_wen_reg2,
  write7_addr_reg2,write7_wen_reg2,
  write8_addr_reg2,write8_wen_reg2,
  write9_addr_reg2,write9_wen_reg2,
  write0_data_reg,
  write1_data_reg,
  write2_data_reg,
  write3_data_reg,
  write4_data_reg,
  write5_data_reg,
  write6_data_reg,
  write7_data_reg,
  write8_data_reg,
  write9_data_reg
  );
  parameter DATA_WIDTH=`alu_width;
  localparam ADDR_WIDTH=`reg_addr_width;

  input clk;
  input rst;

  input read_clkEn;
  
  input [DATA_WIDTH-1:0] read_data_ram;
  output [DATA_WIDTH-1:0] read_data_new;
  input [ADDR_WIDTH-1:0] read_addr;

  input read_constEn;
  input read_oe;
  
  output [10:0] match_w;
  
  input [ADDR_WIDTH-1:0] write0_addr_reg;
  input write0_wen_reg;

  input [ADDR_WIDTH-1:0] write1_addr_reg;
  input write1_wen_reg;

  input [ADDR_WIDTH-1:0] write2_addr_reg;
  input write2_wen_reg;

  input [ADDR_WIDTH-1:0] write3_addr_reg;
  input write3_wen_reg;

  input [ADDR_WIDTH-1:0] write4_addr_reg;
  input write4_wen_reg;

  input [ADDR_WIDTH-1:0] write5_addr_reg;
  input write5_wen_reg;

  input [ADDR_WIDTH-1:0] write6_addr_reg;
  input write6_wen_reg;

  input [ADDR_WIDTH-1:0] write7_addr_reg;
  input write7_wen_reg;

  input [ADDR_WIDTH-1:0] write8_addr_reg;
  input write8_wen_reg;

  input [ADDR_WIDTH-1:0] write9_addr_reg;
  input write9_wen_reg;

  input [ADDR_WIDTH-1:0] write0_addr_reg2;
  input write0_wen_reg2;

  input [ADDR_WIDTH-1:0] write1_addr_reg2;
  input write1_wen_reg2;

  input [ADDR_WIDTH-1:0] write2_addr_reg2;
  input write2_wen_reg2;

  input [ADDR_WIDTH-1:0] write3_addr_reg2;
  input write3_wen_reg2;

  input [ADDR_WIDTH-1:0] write4_addr_reg2;
  input write4_wen_reg2;

  input [ADDR_WIDTH-1:0] write5_addr_reg2;
  input write5_wen_reg2;

  input [ADDR_WIDTH-1:0] write6_addr_reg2;
  input write6_wen_reg2;

  input [ADDR_WIDTH-1:0] write7_addr_reg2;
  input write7_wen_reg2;

  input [ADDR_WIDTH-1:0] write8_addr_reg2;
  input write8_wen_reg2;

  input [ADDR_WIDTH-1:0] write9_addr_reg2;
  input write9_wen_reg2;


  input [DATA_WIDTH-1:0] write0_data_reg;
  input [DATA_WIDTH-1:0] write1_data_reg;
  input [DATA_WIDTH-1:0] write2_data_reg;
  input [DATA_WIDTH-1:0] write3_data_reg;
  input [DATA_WIDTH-1:0] write4_data_reg;
  input [DATA_WIDTH-1:0] write5_data_reg;
  input [DATA_WIDTH-1:0] write6_data_reg;
  input [DATA_WIDTH-1:0] write7_data_reg;
  input [DATA_WIDTH-1:0] write8_data_reg;
  input [DATA_WIDTH-1:0] write9_data_reg;
  
  
  wire match_r0;
  wire match_r1;
  wire match_r2;
  wire match_r3;
  wire match_r4;
  wire match_r5;
  wire match_r6;
  wire match_r7;
  wire match_r8;
  wire match_r9;

  wire match;

  reg read_constEn_reg;

  reg read_oe_reg;
  reg [ADDR_WIDTH-1:0] read_addr_reg;


  assign match=|{match_r0,match_r1,match_r2,match_r3,match_r4,match_r5,match_r6,match_r7,match_r8,match_r9};

  assign read_data_new=(match_r0 & read_oe_reg) ? write0_data_reg : {DATA_WIDTH{1'bz}};
  assign read_data_new=(match_r1 & read_oe_reg) ? write1_data_reg : {DATA_WIDTH{1'bz}};
  assign read_data_new=(match_r2 & read_oe_reg) ? write2_data_reg : {DATA_WIDTH{1'bz}};
  assign read_data_new=(match_r3 & read_oe_reg) ? write3_data_reg : {DATA_WIDTH{1'bz}};
  assign read_data_new=(match_r4 & read_oe_reg) ? write4_data_reg : {DATA_WIDTH{1'bz}};
  assign read_data_new=(match_r5 & read_oe_reg) ? write5_data_reg : {DATA_WIDTH{1'bz}};
  assign read_data_new=(match_r6 & read_oe_reg) ? write6_data_reg : {DATA_WIDTH{1'bz}};
  assign read_data_new=(match_r7 & read_oe_reg) ? write7_data_reg : {DATA_WIDTH{1'bz}};
  assign read_data_new=(match_r8 & read_oe_reg) ? write8_data_reg : {DATA_WIDTH{1'bz}};
  assign read_data_new=(match_r9 & read_oe_reg) ? write9_data_reg : {DATA_WIDTH{1'bz}};

  assign read_data_new=(match | ~read_oe_reg) ? {DATA_WIDTH{1'bz}} : read_data_ram;
  
  assign match_w[0]=read_addr_reg==write0_addr_reg && write0_wen_reg &&
     ~read_constEn_reg && read_oe_reg;
  assign match_w[1]=read_addr_reg==write1_addr_reg && write1_wen_reg &&
     ~read_constEn_reg  && read_oe_reg;
  assign match_w[2]=read_addr_reg==write2_addr_reg && write2_wen_reg &&
     ~read_constEn_reg && read_oe_reg;
  assign match_w[3]=read_addr_reg==write3_addr_reg && write3_wen_reg &&
     ~read_constEn_reg && read_oe_reg;
  assign match_w[4]=read_addr_reg==write4_addr_reg && write4_wen_reg &&
     ~read_constEn_reg && read_oe_reg;
  assign match_w[5]=read_addr_reg==write5_addr_reg && write5_wen_reg &&
     ~read_constEn_reg && read_oe_reg;
  assign match_w[6]=read_addr_reg==write6_addr_reg && write6_wen_reg &&
     ~read_constEn_reg && read_oe_reg;
  assign match_w[7]=read_addr_reg==write7_addr_reg && write7_wen_reg &&
     ~read_constEn_reg && read_oe_reg;
  assign match_w[8]=read_addr_reg==write8_addr_reg && write8_wen_reg &&
     ~read_constEn_reg && read_oe_reg;
  assign match_w[9]=read_addr_reg==write9_addr_reg && write9_wen_reg &&
     ~read_constEn_reg && read_oe_reg;
  
  assign match_w[10]=~(|{match_w[0],match_w[1],match_w[2],match_w[3],match_w[4],match_w[5],
    match_w[6],match_w[7],match_w[8],match_w[9]});

 assign match_r0=read_addr_reg==write0_addr_reg2 && write0_wen_reg2 &&
     ~read_constEn_reg && read_oe_reg;
  assign match_r1=read_addr_reg==write1_addr_reg2 && write1_wen_reg2 &&
     ~read_constEn_reg  && read_oe_reg;
  assign match_r2=read_addr_reg==write2_addr_reg2 && write2_wen_reg2 &&
     ~read_constEn_reg && read_oe_reg;
  assign match_r3=read_addr_reg==write3_addr_reg2 && write3_wen_reg2 &&
     ~read_constEn_reg && read_oe_reg;
  assign match_r4=read_addr_reg==write4_addr_reg2 && write4_wen_reg2 &&
     ~read_constEn_reg && read_oe_reg;
  assign match_r5=read_addr_reg==write5_addr_reg2 && write5_wen_reg2 &&
     ~read_constEn_reg && read_oe_reg;
  assign match_r6=read_addr_reg==write6_addr_reg2 && write6_wen_reg2 &&
     ~read_constEn_reg && read_oe_reg;
  assign match_r7=read_addr_reg==write7_addr_reg2 && write7_wen_reg2 &&
     ~read_constEn_reg && read_oe_reg;
  assign match_r8=read_addr_reg==write8_addr_reg2 && write8_wen_reg2 &&
     ~read_constEn_reg && read_oe_reg;
  assign match_r9=read_addr_reg==write9_addr_reg2 && write9_wen_reg2 &&
     ~read_constEn_reg && read_oe_reg;

  always @(posedge clk)
    begin
      if (rst)
        begin
          read_constEn_reg<=1'b0;
          read_oe_reg<=1'b0;
	  read_addr_reg<={ADDR_WIDTH{1'B0}};
        end
      else 
        begin 
          if (read_clkEn)
            begin
              read_constEn_reg<=read_constEn;
              read_oe_reg<=read_oe;
     	      read_addr_reg<=read_addr;
            end
        end
    end
endmodule


module regfile(
  clk,
  rst,
  read_clkEn,
  retire_clkEn,

  read0_addr,read0_data,read0_oe,read0_match,
  read1_addr,read1_data,read1_oe,read1_match,
  read2_addr,read2_data,read2_oe,read2_match,
  read3_addr,read3_data,read3_oe,read3_match,
  read4_addr,read4_data,read4_oe,read4_match,
  read5_addr,read5_data,read5_oe,read5_match,
  read6_addr,read6_data,read6_oe,read6_match,
  read7_addr,read7_data,read7_oe,read7_match,
  read8_addr,read8_data,read8_oe,read8_match,
  read9_addr,read9_data,read9_oe,read9_match,

  read0_constEn,
  read1_constEn,
  read2_constEn,
  read3_constEn,
  read4_constEn,
  read5_constEn,
  read6_constEn,
  read7_constEn,
  read8_constEn,

  read0_const,
  read1_const,
  read2_const,
  read3_const,
  read4_const,
  read5_const,
  read6_const,
  read7_const,
  read8_const,

  retireRead0_addr,retireRead0_data,
  retireRead1_addr,retireRead1_data,
  retireRead2_addr,retireRead2_data,
  retireRead3_addr,retireRead3_data,
  retireRead4_addr,retireRead4_data,
  retireRead5_addr,retireRead5_data,
  retireRead6_addr,retireRead6_data,
  retireRead7_addr,retireRead7_data,
  retireRead8_addr,retireRead8_data,

  write0_addr_reg,write0_data_reg,write0_wen_reg,
  write1_addr_reg,write1_data_reg,write1_wen_reg,
  write2_addr_reg,write2_data_reg,write2_wen_reg,
  write3_addr_reg,write3_data_reg,write3_wen_reg,
  write4_addr_reg,write4_data_reg,write4_wen_reg,
  write5_addr_reg,write5_data_reg,write5_wen_reg,
  write6_addr_reg,write6_data_reg,write6_wen_reg,
  write7_addr_reg,write7_data_reg,write7_wen_reg,
  write8_addr_reg,write8_data_reg,write8_wen_reg,
  write9_addr_reg,write9_data_reg,write9_wen_reg
  );
  parameter DATA_WIDTH=`alu_width;
  localparam ADDR_WIDTH=`reg_addr_width;
 
  
  input clk;
  input rst;
  input read_clkEn;
  input retire_clkEn;


  input [ADDR_WIDTH-1:0] read0_addr;
  output [DATA_WIDTH-1:0] read0_data;
  input read0_oe;
  output [10:0] read0_match;

  input [ADDR_WIDTH-1:0] read1_addr;
  output [DATA_WIDTH-1:0] read1_data;
  input read1_oe;
  output [10:0] read1_match;

  input [ADDR_WIDTH-1:0] read2_addr;
  output [DATA_WIDTH-1:0] read2_data;
  input read2_oe;
  output [10:0] read2_match;

  input [ADDR_WIDTH-1:0] read3_addr;
  output [DATA_WIDTH-1:0] read3_data;
  input read3_oe;
  output [10:0] read3_match;

  input [ADDR_WIDTH-1:0] read4_addr;
  output [DATA_WIDTH-1:0] read4_data;
  input read4_oe;
  output [10:0] read4_match;

  input [ADDR_WIDTH-1:0] read5_addr;
  output [DATA_WIDTH-1:0] read5_data;
  input read5_oe;
  output [10:0] read5_match;

  input [ADDR_WIDTH-1:0] read6_addr;
  output [DATA_WIDTH-1:0] read6_data;
  input read6_oe;
  output [10:0] read6_match;

  input [ADDR_WIDTH-1:0] read7_addr;
  output [DATA_WIDTH-1:0] read7_data;
  input read7_oe;
  output [10:0] read7_match;

  input [ADDR_WIDTH-1:0] read8_addr;
  output [DATA_WIDTH-1:0] read8_data;
  input read8_oe;
  output [10:0] read8_match;

  input [ADDR_WIDTH-1:0] read9_addr;
  output [DATA_WIDTH-1:0] read9_data;
  input read9_oe;
  output [10:0] read9_match;

  input read0_constEn;
  input read1_constEn;
  input read2_constEn;
  input read3_constEn;
  input read4_constEn;
  input read5_constEn;
  input read6_constEn;
  input read7_constEn;
  input read8_constEn;

  input [DATA_WIDTH-1:0] read0_const;
  input [DATA_WIDTH-1:0] read1_const;
  input [DATA_WIDTH-1:0] read2_const;
  input [DATA_WIDTH-1:0] read3_const;
  input [DATA_WIDTH-1:0] read4_const;
  input [DATA_WIDTH-1:0] read5_const;
  input [DATA_WIDTH-1:0] read6_const;
  input [DATA_WIDTH-1:0] read7_const;
  input [DATA_WIDTH-1:0] read8_const;
  
  input [ADDR_WIDTH-1:0] retireRead0_addr;
  output [DATA_WIDTH-1:0] retireRead0_data;

  input [ADDR_WIDTH-1:0] retireRead1_addr;
  output [DATA_WIDTH-1:0] retireRead1_data;

  input [ADDR_WIDTH-1:0] retireRead2_addr;
  output [DATA_WIDTH-1:0] retireRead2_data;

  input [ADDR_WIDTH-1:0] retireRead3_addr;
  output [DATA_WIDTH-1:0] retireRead3_data;

  input [ADDR_WIDTH-1:0] retireRead4_addr;
  output [DATA_WIDTH-1:0] retireRead4_data;

  input [ADDR_WIDTH-1:0] retireRead5_addr;
  output [DATA_WIDTH-1:0] retireRead5_data;

  input [ADDR_WIDTH-1:0] retireRead6_addr;
  output [DATA_WIDTH-1:0] retireRead6_data;

  input [ADDR_WIDTH-1:0] retireRead7_addr;
  output [DATA_WIDTH-1:0] retireRead7_data;

  input [ADDR_WIDTH-1:0] retireRead8_addr;
  output [DATA_WIDTH-1:0] retireRead8_data;


  input [ADDR_WIDTH-1:0] write0_addr_reg;
  input [DATA_WIDTH-1:0] write0_data_reg;
  input write0_wen_reg;

  input [ADDR_WIDTH-1:0] write1_addr_reg;
  input [DATA_WIDTH-1:0] write1_data_reg;
  input write1_wen_reg;

  input [ADDR_WIDTH-1:0] write2_addr_reg;
  input [DATA_WIDTH-1:0] write2_data_reg;
  input write2_wen_reg;

  input [ADDR_WIDTH-1:0] write3_addr_reg;
  input [DATA_WIDTH-1:0] write3_data_reg;
  input write3_wen_reg;

  input [ADDR_WIDTH-1:0] write4_addr_reg;
  input [DATA_WIDTH-1:0] write4_data_reg;
  input write4_wen_reg;

  input [ADDR_WIDTH-1:0] write5_addr_reg;
  input [DATA_WIDTH-1:0] write5_data_reg;
  input write5_wen_reg;

  input [ADDR_WIDTH-1:0] write6_addr_reg;
  input [DATA_WIDTH-1:0] write6_data_reg;
  input write6_wen_reg;

  input [ADDR_WIDTH-1:0] write7_addr_reg;
  input [DATA_WIDTH-1:0] write7_data_reg;
  input write7_wen_reg;

  input [ADDR_WIDTH-1:0] write8_addr_reg;
  input [DATA_WIDTH-1:0] write8_data_reg;
  input write8_wen_reg;

  input [ADDR_WIDTH-1:0] write9_addr_reg;
  input [DATA_WIDTH-1:0] write9_data_reg;
  input write9_wen_reg;

  wire [9:0][DATA_WIDTH-1:0] ram_read_data;
  wire [9:0][DATA_WIDTH-1:0] read_data;
  wire [9:0][ADDR_WIDTH-1:0] read_addr;
  wire [8:0][DATA_WIDTH-1:0] ram_retireRead_data;
  wire [8:0][DATA_WIDTH-1:0] retireRead_data;
  wire [8:0][ADDR_WIDTH-1:0] retireRead_addr;


  wire read_constEn[8:0];
  wire read_oe[8:0];

  reg [ADDR_WIDTH-1:0] write0_addr_reg2;
  reg write0_wen_reg2;

  reg [ADDR_WIDTH-1:0] write1_addr_reg2;
  reg write1_wen_reg2;

  reg [ADDR_WIDTH-1:0] write2_addr_reg2;
  reg write2_wen_reg2;

  reg [ADDR_WIDTH-1:0] write3_addr_reg2;
  reg write3_wen_reg2;

  reg [ADDR_WIDTH-1:0] write4_addr_reg2;
  reg write4_wen_reg2;

  reg [ADDR_WIDTH-1:0] write5_addr_reg2;
  reg write5_wen_reg2;

  reg [ADDR_WIDTH-1:0] write6_addr_reg2;
  reg write6_wen_reg2;

  reg [ADDR_WIDTH-1:0] write7_addr_reg2;
  reg write7_wen_reg2;

  reg [ADDR_WIDTH-1:0] write8_addr_reg2;
  reg write8_wen_reg2;

  reg [ADDR_WIDTH-1:0] write9_addr_reg2;
  reg write9_wen_reg2;
  
  wire [10:0] read_match[8:0];
  
  genvar b;

  
  regfile_ram_block #(DATA_WIDTH) ram_mod(
  clk,
  rst,
  read_clkEn,
  retire_clkEn,

  read0_addr,ram_read_data[0],
  read1_addr,ram_read_data[1],
  read2_addr,ram_read_data[2],
  read3_addr,ram_read_data[3],
  read4_addr,ram_read_data[4],
  read5_addr,ram_read_data[5],
  read6_addr,ram_read_data[6],
  read7_addr,ram_read_data[7],
  read8_addr,ram_read_data[8],
  read9_addr,ram_read_data[9],

  read0_constEn,
  read1_constEn,
  read2_constEn,
  read3_constEn,
  read4_constEn,
  read5_constEn,
  read6_constEn,
  read7_constEn,
  read8_constEn,

  read0_const,
  read1_const,
  read2_const,
  read3_const,
  read4_const,
  read5_const,
  read6_const,
  read7_const,
  read8_const,

  retireRead0_addr,ram_retireRead_data[0],
  retireRead1_addr,ram_retireRead_data[1],
  retireRead2_addr,ram_retireRead_data[2],
  retireRead3_addr,ram_retireRead_data[3],
  retireRead4_addr,ram_retireRead_data[4],
  retireRead5_addr,ram_retireRead_data[5],
  retireRead6_addr,ram_retireRead_data[6],
  retireRead7_addr,ram_retireRead_data[7],
  retireRead8_addr,ram_retireRead_data[8],

  write0_addr_reg2,write0_data_reg,write0_wen_reg2,
  write1_addr_reg2,write1_data_reg,write1_wen_reg2,
  write2_addr_reg2,write2_data_reg,write2_wen_reg2,
  write3_addr_reg2,write3_data_reg,write3_wen_reg2,

  write4_addr_reg2,write4_data_reg,write4_wen_reg2,
  write5_addr_reg2,write5_data_reg,write5_wen_reg2,
  write6_addr_reg2,write6_data_reg,write6_wen_reg2,
  write7_addr_reg2,write7_data_reg,write7_wen_reg2,
  write8_addr_reg2,write8_data_reg,write8_wen_reg2,
  write9_addr_reg2,write9_data_reg,write9_wen_reg2
 );

  assign read0_data=read_data[0];
  assign read1_data=read_data[1];
  assign read2_data=read_data[2];
  assign read3_data=read_data[3];
  assign read4_data=read_data[4];
  assign read5_data=read_data[5];
  assign read6_data=read_data[6];
  assign read7_data=read_data[7];
  assign read8_data=read_data[8];
  assign read9_data=read_data[9];

  assign read_addr[0]=read0_addr;
  assign read_addr[1]=read1_addr;
  assign read_addr[2]=read2_addr;
  assign read_addr[3]=read3_addr;
  assign read_addr[4]=read4_addr;
  assign read_addr[5]=read5_addr;
  assign read_addr[6]=read6_addr;
  assign read_addr[7]=read7_addr;
  assign read_addr[8]=read8_addr;
  assign read_addr[9]=read8_addr;

  assign read_constEn[0]=read0_constEn;
  assign read_constEn[1]=read1_constEn;
  assign read_constEn[2]=read2_constEn;
  assign read_constEn[3]=read3_constEn;
  assign read_constEn[4]=read4_constEn;
  assign read_constEn[5]=read5_constEn;
  assign read_constEn[6]=read6_constEn;
  assign read_constEn[7]=read7_constEn;
  assign read_constEn[8]=read8_constEn;

  assign read_oe[0]=read0_oe;
  assign read_oe[1]=read1_oe;
  assign read_oe[2]=read2_oe;
  assign read_oe[3]=read3_oe;
  assign read_oe[4]=read4_oe;
  assign read_oe[5]=read5_oe;
  assign read_oe[6]=read6_oe;
  assign read_oe[7]=read7_oe;
  assign read_oe[8]=read8_oe;
  
  assign read0_match=read_match[0];
  assign read1_match=read_match[1];
  assign read2_match=read_match[2];
  assign read3_match=read_match[3];
  assign read4_match=read_match[4];
  assign read5_match=read_match[5];
  assign read6_match=read_match[6];
  assign read7_match=read_match[7];
  assign read8_match=read_match[8];
  assign read9_match=read_match[9];
  
  assign retireRead0_data=retireRead_data[0];
  assign retireRead1_data=retireRead_data[1];
  assign retireRead2_data=retireRead_data[2];
  assign retireRead3_data=retireRead_data[3];
  assign retireRead4_data=retireRead_data[4];
  assign retireRead5_data=retireRead_data[5];
  assign retireRead6_data=retireRead_data[6];
  assign retireRead7_data=retireRead_data[7];
  assign retireRead8_data=retireRead_data[8];

  assign retireRead_addr[0]=retireRead0_addr;
  assign retireRead_addr[1]=retireRead1_addr;
  assign retireRead_addr[2]=retireRead2_addr;
  assign retireRead_addr[3]=retireRead3_addr;
  assign retireRead_addr[4]=retireRead4_addr;
  assign retireRead_addr[5]=retireRead5_addr;
  assign retireRead_addr[6]=retireRead6_addr;
  assign retireRead_addr[7]=retireRead7_addr;
  assign retireRead_addr[8]=retireRead8_addr;

  generate for(b=0;b<=9;b=b+1)
    begin
      regfile_zero_cycle_write #(DATA_WIDTH) zcw_mod(
      clk,rst,
      read_clkEn,
      ram_read_data[b],read_data[b],read_addr[b],

      read_constEn[b],read_oe[b], read_match[b],
      
      write0_addr_reg,write0_wen_reg,
      write1_addr_reg,write1_wen_reg,
      write2_addr_reg,write2_wen_reg,
      write3_addr_reg,write3_wen_reg,
      write4_addr_reg,write4_wen_reg,
      write5_addr_reg,write5_wen_reg,
      write6_addr_reg,write6_wen_reg,
      write7_addr_reg,write7_wen_reg,
      write8_addr_reg,write8_wen_reg,
      write9_addr_reg,write9_wen_reg,
      write0_addr_reg2,write0_wen_reg2,
      write1_addr_reg2,write1_wen_reg2,
      write2_addr_reg2,write2_wen_reg2,
      write3_addr_reg2,write3_wen_reg2,
      write4_addr_reg2,write4_wen_reg2,
      write5_addr_reg2,write5_wen_reg2,
      write6_addr_reg2,write6_wen_reg2,
      write7_addr_reg2,write7_wen_reg2,
      write8_addr_reg2,write8_wen_reg2,
      write9_addr_reg2,write9_wen_reg2,
      write0_data_reg,
      write1_data_reg,
      write2_data_reg,
      write3_data_reg,
      write4_data_reg,
      write5_data_reg,
      write6_data_reg,
      write7_data_reg,
      write8_data_reg,
      write9_data_reg
      );
      
      if (b<9) regfile_zero_cycle_write #(DATA_WIDTH) zcwiR_mod(
      clk,rst,
      read_clkEn,
      ram_retireRead_data[b],retireRead_data[b],retireRead_addr[b],

      1'b0,1'b1,,
      
      write0_addr_reg,write0_wen_reg,
      write1_addr_reg,write1_wen_reg,
      write2_addr_reg,write2_wen_reg,
      write3_addr_reg,write3_wen_reg,
      write4_addr_reg,write4_wen_reg,
      write5_addr_reg,write5_wen_reg,
      write6_addr_reg,write6_wen_reg,
      write7_addr_reg,write7_wen_reg,
      write8_addr_reg,write8_wen_reg,
      write9_addr_reg,write9_wen_reg,
      write0_addr_reg2,write0_wen_reg2,
      write1_addr_reg2,write1_wen_reg2,
      write2_addr_reg2,write2_wen_reg2,
      write3_addr_reg2,write3_wen_reg2,
      write4_addr_reg2,write4_wen_reg2,
      write5_addr_reg2,write5_wen_reg2,
      write6_addr_reg2,write6_wen_reg2,
      write7_addr_reg2,write7_wen_reg2,
      write8_addr_reg2,write8_wen_reg2,
      write9_addr_reg2,write9_wen_reg2,
      write0_data_reg,
      write1_data_reg,
      write2_data_reg,
      write3_data_reg,
      write4_data_reg,
      write5_data_reg,
      write6_data_reg,
      write7_data_reg,
      write8_data_reg,
      write9_data_reg
      );
    end
  endgenerate

  always @(posedge clk) begin
      if (rst) begin
          write0_addr_reg2<={ADDR_WIDTH{1'B0}};
          write1_addr_reg2<={ADDR_WIDTH{1'B0}};
          write2_addr_reg2<={ADDR_WIDTH{1'B0}};
          write3_addr_reg2<={ADDR_WIDTH{1'B0}};
          write4_addr_reg2<={ADDR_WIDTH{1'B0}};
          write5_addr_reg2<={ADDR_WIDTH{1'B0}};
          write6_addr_reg2<={ADDR_WIDTH{1'B0}};
          write7_addr_reg2<={ADDR_WIDTH{1'B0}};
          write8_addr_reg2<={ADDR_WIDTH{1'B0}};
          write9_addr_reg2<={ADDR_WIDTH{1'B0}};
          
          
          write0_wen_reg2<=1'b0;
          write1_wen_reg2<=1'b0;
          write2_wen_reg2<=1'b0;
          write3_wen_reg2<=1'b0;
          write4_wen_reg2<=1'b0;
          write5_wen_reg2<=1'b0;
          write6_wen_reg2<=1'b0;
          write7_wen_reg2<=1'b0;
          write8_wen_reg2<=1'b0;
          write9_wen_reg2<=1'b0;
      end else begin
          if (write0_wen_reg) write0_addr_reg2<=write0_addr_reg;
          if (write1_wen_reg) write1_addr_reg2<=write1_addr_reg;
          if (write2_wen_reg) write2_addr_reg2<=write2_addr_reg;
          if (write3_wen_reg) write3_addr_reg2<=write3_addr_reg;
          if (write4_wen_reg) write4_addr_reg2<=write4_addr_reg;
          if (write5_wen_reg) write5_addr_reg2<=write5_addr_reg;
          if (write6_wen_reg) write6_addr_reg2<=write6_addr_reg;
          if (write7_wen_reg) write7_addr_reg2<=write7_addr_reg;
          if (write8_wen_reg) write8_addr_reg2<=write8_addr_reg;
          if (write9_wen_reg) write9_addr_reg2<=write9_addr_reg;
          
          
          write0_wen_reg2<=write0_wen_reg;
          write1_wen_reg2<=write1_wen_reg;
          write2_wen_reg2<=write2_wen_reg;
          write3_wen_reg2<=write3_wen_reg;
          write4_wen_reg2<=write4_wen_reg;
          write5_wen_reg2<=write5_wen_reg;
          write6_wen_reg2<=write6_wen_reg;
          write7_wen_reg2<=write7_wen_reg;
          write8_wen_reg2<=write8_wen_reg;
          write9_wen_reg2<=write9_wen_reg;
      end
  end
endmodule



