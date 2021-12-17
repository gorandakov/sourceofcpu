`include "../struct.sv"

module instrQ_buf(
  clk,
  rst,
  write_instrEn,
  write_thread,
  write_wen,
  write_addr0,write_instr0,write_other0,
  write_addr1,write_instr1,write_other1,
  write_addr2,write_instr2,write_other2,
  write_addr3,write_instr3,write_other3,
  write_addr4,write_instr4,write_other4,
  write_addr5,write_instr5,write_other5,
  read_thread,
  read_clkEn,
  read_addr0,read_instr0,read_other0,
  read_addr1,read_instr1,read_other1,
  read_addr2,read_instr2,read_other2,
  read_addr3,read_instr3,read_other3,
  read_addr4,read_instr4,read_other4
  );
  localparam WIDTH=80;
  localparam OTHER=`instrQ_width;
  localparam ADDR_WIDTH=3;
  localparam WADDR_WIDTH=6;
  parameter INDEX=0;
  parameter INITEN=0;
  
  input clk;
  input rst;
  input [11:0] write_instrEn;
  input write_thread;
  input write_wen;
  input [WADDR_WIDTH-1:0] write_addr0;
  input [WIDTH-1:0] write_instr0;
  input [OTHER-1:0] write_other0;
  input [WADDR_WIDTH-1:0] write_addr1;
  input [WIDTH-1:0] write_instr1;
  input [OTHER-1:0] write_other1;
  input [WADDR_WIDTH-1:0] write_addr2;
  input [WIDTH-1:0] write_instr2;
  input [OTHER-1:0] write_other2;
  input [WADDR_WIDTH-1:0] write_addr3;
  input [WIDTH-1:0] write_instr3;
  input [OTHER-1:0] write_other3;
  input [WADDR_WIDTH-1:0] write_addr4;
  input [WIDTH-1:0] write_instr4;
  input [OTHER-1:0] write_other4;
  input [WADDR_WIDTH-1:0] write_addr5;
  input [WIDTH-1:0] write_instr5;
  input [OTHER-1:0] write_other5;

  input read_thread;
  input read_clkEn;
  
  input [ADDR_WIDTH-1:0] read_addr0;
  output [WIDTH-1:0] read_instr0;
  output [OTHER-1:0] read_other0;
  input [ADDR_WIDTH-1:0] read_addr1;
  output [WIDTH-1:0] read_instr1;
  output [OTHER-1:0] read_other1;
  input [ADDR_WIDTH-1:0] read_addr2;
  output [WIDTH-1:0] read_instr2;
  output [OTHER-1:0] read_other2;
  input [ADDR_WIDTH-1:0] read_addr3;
  output [WIDTH-1:0] read_instr3;
  output [OTHER-1:0] read_other3;
  input [ADDR_WIDTH-1:0] read_addr4;
  output [WIDTH-1:0] read_instr4;
  output [OTHER-1:0] read_other4;
  
  reg [WIDTH-1:0] instr;
  reg [OTHER-1:0] other;
  reg read_en[4:0];
  integer k;
  wire [WIDTH-1:0] instr_rd;
  wire [OTHER-1:0] other_rd;
  wire [WIDTH-1:0] instr_wr;
  wire [OTHER-1:0] other_wr;
  wire [5:0] instr_wren;
  wire instr_wrAny;

  assign instr_rd=instr;
  assign other_rd=other;
  
  assign read_instr0=read_en[0] ? instr_rd : {WIDTH{1'BZ}};
  assign read_other0=read_en[0] ? other_rd : {OTHER{1'BZ}};
  assign read_instr1=read_en[1] ? instr_rd : {WIDTH{1'BZ}};
  assign read_other1=read_en[1] ? other_rd : {OTHER{1'BZ}};
  assign read_instr2=read_en[2] ? instr_rd : {WIDTH{1'BZ}};
  assign read_other2=read_en[2] ? other_rd : {OTHER{1'BZ}};
  assign read_instr3=read_en[3] ? instr_rd : {WIDTH{1'BZ}};
  assign read_other3=read_en[3] ? other_rd : {OTHER{1'BZ}};
  assign read_instr4=read_en[4] ? instr_rd : {WIDTH{1'BZ}};
  assign read_other4=read_en[4] ? other_rd : {OTHER{1'BZ}};
 
 //verilator lint_off WIDTH 
  assign instr_wren[0]=write_addr0==INDEX && write_instrEn[0];
  assign instr_wren[1]=write_addr1==INDEX && write_instrEn[1];
  assign instr_wren[2]=write_addr2==INDEX && write_instrEn[2];
  assign instr_wren[3]=write_addr3==INDEX && write_instrEn[3];
  assign instr_wren[4]=write_addr4==INDEX && write_instrEn[4];
  assign instr_wren[5]=write_addr5==INDEX && write_instrEn[5];
 //verilator lint_on WIDTH
  
  assign instr_wr=instr_wren[0] ? write_instr0 : {WIDTH{1'BZ}};
  assign instr_wr=instr_wren[1] ? write_instr1 : {WIDTH{1'BZ}};
  assign instr_wr=instr_wren[2] ? write_instr2 : {WIDTH{1'BZ}};
  assign instr_wr=instr_wren[3] ? write_instr3 : {WIDTH{1'BZ}};
  assign instr_wr=instr_wren[4] ? write_instr4 : {WIDTH{1'BZ}};
  assign instr_wr=instr_wren[5] ? write_instr5 : {WIDTH{1'BZ}};
  assign instr_wr=(!instr_wrAny) ? {WIDTH{1'B0}} : {WIDTH{1'BZ}};  

  assign other_wr=instr_wren[0] ? write_other0 : {OTHER{1'BZ}};
  assign other_wr=instr_wren[1] ? write_other1 : {OTHER{1'BZ}};
  assign other_wr=instr_wren[2] ? write_other2 : {OTHER{1'BZ}};
  assign other_wr=instr_wren[3] ? write_other3 : {OTHER{1'BZ}};
  assign other_wr=instr_wren[4] ? write_other4 : {OTHER{1'BZ}};
  assign other_wr=instr_wren[5] ? write_other5 : {OTHER{1'BZ}};
  assign other_wr=(!instr_wrAny) ? {OTHER{1'B0}} : {OTHER{1'BZ}};  

  assign instr_wrAny=|instr_wren;
  
  always @(posedge clk) 
  begin
      if (write_wen&instr_wrAny) begin
          instr<=instr_wr;
          other<=other_wr;
      end
      if (rst) begin
          for(k=0;k<4;k=k+1) read_en[k]<=INITEN;
      end else if (read_clkEn) begin
          read_en[0]<=read_addr0==INDEX[2:0];
          read_en[1]<=read_addr1==INDEX[2:0];
          read_en[2]<=read_addr2==INDEX[2:0];
          read_en[3]<=read_addr3==INDEX[2:0];
          read_en[4]<=read_addr4==INDEX[2:0];
      end
  end
  
endmodule



module instrQ_box(
  clk,
  rst,
  write_instrEn,
  write_thread,
  write_wen,
  write_addr0,write_instr0,write_other0,
  write_addr1,write_instr1,write_other1,
  write_addr2,write_instr2,write_other2,
  write_addr3,write_instr3,write_other3,
  write_addr4,write_instr4,write_other4,
  write_addr5,write_instr5,write_other5,
  write_addr6,write_instr6,write_other6,
  write_addr7,write_instr7,write_other7,
  write_addr8,write_instr8,write_other8,
  write_addr9,write_instr9,write_other9,
  write_addr10,write_instr10,write_other10,
  write_addr11,write_instr11,write_other11,
  read_thread,
  read_clkEn,
  read_addr0,read_instr0,read_other0,
  read_addr1,read_instr1,read_other1,
  read_addr2,read_instr2,read_other2,
  read_addr3,read_instr3,read_other3,
  read_addr4,read_instr4,read_other4,
  read_addr5,read_instr5,read_other5,
  read_addr6,read_instr6,read_other6,
  read_addr7,read_instr7,read_other7,
  read_addr8,read_instr8,read_other8,
  read_addr9,read_instr9,read_other9
  );
  localparam WIDTH=80;
  localparam OTHER=`instrQ_width;
  localparam ADDR_WIDTH=6;
  parameter INDEX=0;
  
  input clk;
  input rst;
  input [11:0] write_instrEn;
  input write_thread;
  input write_wen;
  input [ADDR_WIDTH-1:0] write_addr0;
  input [WIDTH-1:0] write_instr0;
  input [OTHER-1:0] write_other0;
  input [ADDR_WIDTH-1:0] write_addr1;
  input [WIDTH-1:0] write_instr1;
  input [OTHER-1:0] write_other1;
  input [ADDR_WIDTH-1:0] write_addr2;
  input [WIDTH-1:0] write_instr2;
  input [OTHER-1:0] write_other2;
  input [ADDR_WIDTH-1:0] write_addr3;
  input [WIDTH-1:0] write_instr3;
  input [OTHER-1:0] write_other3;
  input [ADDR_WIDTH-1:0] write_addr4;
  input [WIDTH-1:0] write_instr4;
  input [OTHER-1:0] write_other4;
  input [ADDR_WIDTH-1:0] write_addr5;
  input [WIDTH-1:0] write_instr5;
  input [OTHER-1:0] write_other5;
  input [ADDR_WIDTH-1:0] write_addr6;
  input [WIDTH-1:0] write_instr6;
  input [OTHER-1:0] write_other6;
  input [ADDR_WIDTH-1:0] write_addr7;
  input [WIDTH-1:0] write_instr7;
  input [OTHER-1:0] write_other7;
  input [ADDR_WIDTH-1:0] write_addr8;
  input [WIDTH-1:0] write_instr8;
  input [OTHER-1:0] write_other8;
  input [ADDR_WIDTH-1:0] write_addr9;
  input [WIDTH-1:0] write_instr9;
  input [OTHER-1:0] write_other9;
  input [ADDR_WIDTH-1:0] write_addr10;
  input [WIDTH-1:0] write_instr10;
  input [OTHER-1:0] write_other10;
  input [ADDR_WIDTH-1:0] write_addr11;
  input [WIDTH-1:0] write_instr11;
  input [OTHER-1:0] write_other11;

  input read_thread;
  input read_clkEn;
  input [ADDR_WIDTH-1:0] read_addr0;
  output [WIDTH-1:0] read_instr0;
  output [OTHER-1:0] read_other0;
  input [ADDR_WIDTH-1:0] read_addr1;
  output [WIDTH-1:0] read_instr1;
  output [OTHER-1:0] read_other1;
  input [ADDR_WIDTH-1:0] read_addr2;
  output [WIDTH-1:0] read_instr2;
  output [OTHER-1:0] read_other2;
  input [ADDR_WIDTH-1:0] read_addr3;
  output [WIDTH-1:0] read_instr3;
  output [OTHER-1:0] read_other3;
  input [ADDR_WIDTH-1:0] read_addr4;
  output [WIDTH-1:0] read_instr4;
  output [OTHER-1:0] read_other4;
  input [ADDR_WIDTH-1:0] read_addr5;
  output [WIDTH-1:0] read_instr5;
  output [OTHER-1:0] read_other5;
  input [ADDR_WIDTH-1:0] read_addr6;
  output [WIDTH-1:0] read_instr6;
  output [OTHER-1:0] read_other6;
  input [ADDR_WIDTH-1:0] read_addr7;
  output [WIDTH-1:0] read_instr7;
  output [OTHER-1:0] read_other7;
  input [ADDR_WIDTH-1:0] read_addr8;
  output [WIDTH-1:0] read_instr8;
  output [OTHER-1:0] read_other8;
  input [ADDR_WIDTH-1:0] read_addr9;
  output [WIDTH-1:0] read_instr9;
  output [OTHER-1:0] read_other9;
  

  reg [5:0] read_en0;
  reg [5:0] read_en1;
  reg [5:0] read_en2;
  reg [5:0] read_en3;
  reg [5:0] read_en4;
  reg [5:0] read_en5;
  reg [5:0] read_en6;
  reg [5:0] read_en7;
  reg [5:0] read_en8;
  reg [5:0] read_en9;
  
  
  integer k;
  generate
      genvar l,m;
      
      for (m=0;m<6;m=m+1) begin : tile_gen
          wire [9:0][WIDTH-1:0] read_instrm;
          wire [9:0][OTHER-1:0] read_otherm;
          
          for (l=0;l<8;l=l+2) begin : buf_gen
              instrQ_buf #(l+m*8,l==0) buf0_mod(
              clk,
              rst,
              write_instrEn[5:0],
              write_thread,
              write_wen,
              write_addr0[0] ? write_addr1 : write_addr0,
	          write_addr0[0] ? write_instr1 : write_instr0,
		  write_addr0[0] ? write_other1 : write_other0,
              write_addr2[0] ? write_addr3 : write_addr2,
	          write_addr2[0] ? write_instr3 : write_instr2,
		  write_addr2[0] ? write_other3 : write_other2,
              write_addr4[0] ? write_addr5 : write_addr4,
	          write_addr4[0] ? write_instr5 : write_instr4,
		  write_addr4[0] ? write_other5 : write_other4,
              write_addr6[0] ? write_addr7 : write_addr6,
	          write_addr6[0] ? write_instr7 : write_instr6,
		  write_addr6[0] ? write_other7 : write_other6,
              write_addr8[0] ? write_addr9 : write_addr8,
	          write_addr8[0] ? write_instr9 : write_instr8,
		  write_addr8[0] ? write_other9 : write_other8,
              write_addr10[0] ? write_addr11 : write_addr10,
	          write_addr10[0] ? write_instr11 : write_instr10,
		  write_addr10[0] ? write_other11 : write_other10,
              read_thread,
              read_clkEn,
              read_addr0[0] ? read_addr1[2:0] : read_addr0[2:0],read_instrm[0],read_otherm[0],
              read_addr2[0] ? read_addr3[2:0] : read_addr2[2:0],read_instrm[2],read_otherm[2],
              read_addr4[0] ? read_addr5[2:0] : read_addr4[2:0],read_instrm[4],read_otherm[4],
              read_addr6[0] ? read_addr7[2:0] : read_addr6[2:0],read_instrm[6],read_otherm[6],
              read_addr8[0] ? read_addr9[2:0] : read_addr8[2:0],read_instrm[8],read_otherm[8]
              );
              
	      instrQ_buf #(l+m*8+1,l==1) buf1_mod(
              clk,
              rst,
              write_instrEn[11:6],
              write_thread,
              write_wen,
              ~write_addr0[0] ? write_addr1 : write_addr0,
	          ~write_addr0[0] ? write_instr1 : write_instr0,
		  ~write_addr0[0] ? write_other1 : write_other0,
              ~write_addr2[0] ? write_addr3 : write_addr2,
	          ~write_addr2[0] ? write_instr3 : write_instr2,
		  ~write_addr2[0] ? write_other3 : write_other2,
              ~write_addr4[0] ? write_addr5 : write_addr4,
	          ~write_addr4[0] ? write_instr5 : write_instr4,
		  ~write_addr4[0] ? write_other5 : write_other4,
              ~write_addr6[0] ? write_addr7 : write_addr6,
	          ~write_addr6[0] ? write_instr7 : write_instr6,
		  ~write_addr6[0] ? write_other7 : write_other6,
              ~write_addr8[0] ? write_addr9 : write_addr8,
	          ~write_addr8[0] ? write_instr9 : write_instr8,
		  ~write_addr8[0] ? write_other9 : write_other8,
              ~write_addr10[0] ? write_addr11 : write_addr10,
	          ~write_addr10[0] ? write_instr11 : write_instr10,
		  ~write_addr10[0] ? write_other11 : write_other10,
              read_thread,
              read_clkEn,
              read_addr0[0] ? read_addr1[2:0] : read_addr0[2:0],read_instrm[0],read_otherm[0],
              read_addr2[0] ? read_addr3[2:0] : read_addr2[2:0],read_instrm[2],read_otherm[2],
              read_addr4[0] ? read_addr5[2:0] : read_addr4[2:0],read_instrm[4],read_otherm[4],
              read_addr6[0] ? read_addr7[2:0] : read_addr6[2:0],read_instrm[6],read_otherm[6],
              read_addr8[0] ? read_addr9[2:0] : read_addr8[2:0],read_instrm[8],read_otherm[8]
              );


          end
          
          
          assign read_instr0x=read_en0[m] ? read_instrm[0] : {WIDTH{1'BZ}};
          assign read_instr1x=read_en1[m] ? read_instrm[1] : {WIDTH{1'BZ}};
          assign read_instr2x=read_en2[m] ? read_instrm[2] : {WIDTH{1'BZ}};
          assign read_instr3x=read_en3[m] ? read_instrm[3] : {WIDTH{1'BZ}};
          assign read_instr4x=read_en4[m] ? read_instrm[4] : {WIDTH{1'BZ}};
          assign read_instr5x=read_en5[m] ? read_instrm[5] : {WIDTH{1'BZ}};
          assign read_instr6x=read_en6[m] ? read_instrm[6] : {WIDTH{1'BZ}};
          assign read_instr7x=read_en7[m] ? read_instrm[7] : {WIDTH{1'BZ}};
          assign read_instr8x=read_en8[m] ? read_instrm[8] : {WIDTH{1'BZ}};
          assign read_instr9x=read_en9[m] ? read_instrm[9] : {WIDTH{1'BZ}};

          assign read_other0x=read_en0[m] ? read_otherm[0] : {OTHER{1'BZ}};
          assign read_other1x=read_en1[m] ? read_otherm[1] : {OTHER{1'BZ}};
          assign read_other2x=read_en2[m] ? read_otherm[2] : {OTHER{1'BZ}};
          assign read_other3x=read_en3[m] ? read_otherm[3] : {OTHER{1'BZ}};
          assign read_other4x=read_en4[m] ? read_otherm[4] : {OTHER{1'BZ}};
          assign read_other5x=read_en5[m] ? read_otherm[5] : {OTHER{1'BZ}};
          assign read_other6x=read_en6[m] ? read_otherm[6] : {OTHER{1'BZ}};
          assign read_other7x=read_en7[m] ? read_otherm[7] : {OTHER{1'BZ}};
          assign read_other8x=read_en8[m] ? read_otherm[8] : {OTHER{1'BZ}};
          assign read_other9x=read_en9[m] ? read_otherm[9] : {OTHER{1'BZ}};
          
	  assign read_instr0y=read_en0[m] ? read_instrm[1] : {WIDTH{1'BZ}};
          assign read_instr1y=read_en1[m] ? read_instrm[0] : {WIDTH{1'BZ}};
          assign read_instr2y=read_en2[m] ? read_instrm[3] : {WIDTH{1'BZ}};
          assign read_instr3y=read_en3[m] ? read_instrm[2] : {WIDTH{1'BZ}};
          assign read_instr4y=read_en4[m] ? read_instrm[5] : {WIDTH{1'BZ}};
          assign read_instr5y=read_en5[m] ? read_instrm[4] : {WIDTH{1'BZ}};
          assign read_instr6y=read_en6[m] ? read_instrm[7] : {WIDTH{1'BZ}};
          assign read_instr7y=read_en7[m] ? read_instrm[6] : {WIDTH{1'BZ}};
          assign read_instr8y=read_en8[m] ? read_instrm[9] : {WIDTH{1'BZ}};
          assign read_instr9y=read_en9[m] ? read_instrm[8] : {WIDTH{1'BZ}};

          assign read_other0y=read_en0[m] ? read_otherm[1] : {OTHER{1'BZ}};
          assign read_other1y=read_en1[m] ? read_otherm[0] : {OTHER{1'BZ}};
          assign read_other2y=read_en2[m] ? read_otherm[3] : {OTHER{1'BZ}};
          assign read_other3y=read_en3[m] ? read_otherm[2] : {OTHER{1'BZ}};
          assign read_other4y=read_en4[m] ? read_otherm[5] : {OTHER{1'BZ}};
          assign read_other5y=read_en5[m] ? read_otherm[4] : {OTHER{1'BZ}};
          assign read_other6y=read_en6[m] ? read_otherm[7] : {OTHER{1'BZ}};
          assign read_other7y=read_en7[m] ? read_otherm[6] : {OTHER{1'BZ}};
          assign read_other8y=read_en8[m] ? read_otherm[9] : {OTHER{1'BZ}};
          assign read_other9y=read_en9[m] ? read_otherm[9] : {OTHER{1'BZ}};
      end
  endgenerate

  assign read_instr0=read_addr0[0] ? read_instr0y : read_instr0x;
  assign read_instr1=read_addr1[0] ? read_instr1y : read_instr1x;
  assign read_instr2=read_addr2[0] ? read_instr2y : read_instr2x;
  assign read_instr3=read_addr3[0] ? read_instr3y : read_instr3x;
  assign read_instr4=read_addr4[0] ? read_instr4y : read_instr4x;
  assign read_instr5=read_addr5[0] ? read_instr5y : read_instr5x;
  assign read_instr6=read_addr6[0] ? read_instr6y : read_instr6x;
  assign read_instr7=read_addr7[0] ? read_instr7y : read_instr7x;
  assign read_instr8=read_addr8[0] ? read_instr8y : read_instr8x;
  assign read_instr9=read_addr9[0] ? read_instr9y : read_instr9x;
  
  assign read_other0=read_addr0[0] ? read_other0y : read_other0x;
  assign read_other1=read_addr1[0] ? read_other1y : read_other1x;
  assign read_other2=read_addr2[0] ? read_other2y : read_other2x;
  assign read_other3=read_addr3[0] ? read_other3y : read_other3x;
  assign read_other4=read_addr4[0] ? read_other4y : read_other4x;
  assign read_other5=read_addr5[0] ? read_other5y : read_other5x;
  assign read_other6=read_addr6[0] ? read_other6y : read_other6x;
  assign read_other7=read_addr7[0] ? read_other7y : read_other7x;
  assign read_other8=read_addr8[0] ? read_other8y : read_other8x;
  assign read_other9=read_addr9[0] ? read_other9y : read_other9x;
  
  always @(posedge clk) begin
  
      if (rst) begin
          read_en0<=6'd1;
          read_en1<=6'd1;
          read_en2<=6'd1;
          read_en3<=6'd1;
          read_en4<=6'd1;
          read_en5<=6'd1;
          read_en6<=6'd1;
          read_en7<=6'd1;
          read_en8<=6'd1;
          read_en9<=6'd1;
      end else if (read_clkEn) begin
          for (k=0;k<6;k=k+1) begin
              read_en0[k]<=read_addr0[5:3]==k[2:0];
              read_en1[k]<=read_addr1[5:3]==k[2:0];
              read_en2[k]<=read_addr2[5:3]==k[2:0];
              read_en3[k]<=read_addr3[5:3]==k[2:0];
              read_en4[k]<=read_addr4[5:3]==k[2:0];
              read_en5[k]<=read_addr5[5:3]==k[2:0];
              read_en6[k]<=read_addr6[5:3]==k[2:0];
              read_en7[k]<=read_addr7[5:3]==k[2:0];
              read_en8[k]<=read_addr8[5:3]==k[2:0];
              read_en9[k]<=read_addr9[5:3]==k[2:0];
          end
      end
  
  end
endmodule



module instrQ(
  clk,
  rst,
  write_instrEn,
  write_thread,
  write_wen,
  doFStall,
  except,except_thread,
  write_instr0,write_other0,
  write_instr1,write_other1,
  write_instr2,write_other2,
  write_instr3,write_other3,
  write_instr4,write_other4,
  write_instr5,write_other5,
  write_instr6,write_other6,
  write_instr7,write_other7,
  write_instr8,write_other8,
  write_instr9,write_other9,
  write_instr10,write_other10,
  write_instr11,write_other11,
  read_thread,
  read_clkEn,
  read_instrEn,
  read_avail,
  read_instr0,read_other0,
  read_instr1,read_other1,
  read_instr2,read_other2,
  read_instr3,read_other3,
  read_instr4,read_other4,
  read_instr5,read_other5,
  read_instr6,read_other6,
  read_instr7,read_other7,
  read_instr8,read_other8,
  read_instr9,read_other9
  );
  localparam WIDTH=80;
  localparam OTHER=`instrQ_width;
  localparam ADDR_WIDTH=6;
  parameter INDEX=0;
  
  input clk;
  input rst;
  input [11:0] write_instrEn;
  input write_thread;
  input write_wen;
  output doFStall;
  input except;
  input except_thread;
  input [WIDTH-1:0] write_instr0;
  input [OTHER-1:0] write_other0;
  input [WIDTH-1:0] write_instr1;
  input [OTHER-1:0] write_other1;
  input [WIDTH-1:0] write_instr2;
  input [OTHER-1:0] write_other2;
  input [WIDTH-1:0] write_instr3;
  input [OTHER-1:0] write_other3;
  input [WIDTH-1:0] write_instr4;
  input [OTHER-1:0] write_other4;
  input [WIDTH-1:0] write_instr5;
  input [OTHER-1:0] write_other5;
  input [WIDTH-1:0] write_instr6;
  input [OTHER-1:0] write_other6;
  input [WIDTH-1:0] write_instr7;
  input [OTHER-1:0] write_other7;
  input [WIDTH-1:0] write_instr8;
  input [OTHER-1:0] write_other8;
  input [WIDTH-1:0] write_instr9;
  input [OTHER-1:0] write_other9;
  input [WIDTH-1:0] write_instr10;
  input [OTHER-1:0] write_other10;
  input [WIDTH-1:0] write_instr11;
  input [OTHER-1:0] write_other11;

  input read_thread;
  input read_clkEn;
  input [9:0] read_instrEn;
  output [9:0] read_avail;
  output [WIDTH-1:0] read_instr0;
  output [OTHER-1:0] read_other0;
  output [WIDTH-1:0] read_instr1;
  output [OTHER-1:0] read_other1;
  output [WIDTH-1:0] read_instr2;
  output [OTHER-1:0] read_other2;
  output [WIDTH-1:0] read_instr3;
  output [OTHER-1:0] read_other3;
  output [WIDTH-1:0] read_instr4;
  output [OTHER-1:0] read_other4;
  output [WIDTH-1:0] read_instr5;
  output [OTHER-1:0] read_other5;
  output [WIDTH-1:0] read_instr6;
  output [OTHER-1:0] read_other6;
  output [WIDTH-1:0] read_instr7;
  output [OTHER-1:0] read_other7;
  output [WIDTH-1:0] read_instr8;
  output [OTHER-1:0] read_other8;
  output [WIDTH-1:0] read_instr9;
  output [OTHER-1:0] read_other9;

  wire [WIDTH-1:0] read_instrZ0;
  wire [OTHER-1:0] read_otherZ0;
  wire [WIDTH-1:0] read_instrZ1;
  wire [OTHER-1:0] read_otherZ1;
  wire [WIDTH-1:0] read_instrZ2;
  wire [OTHER-1:0] read_otherZ2;
  wire [WIDTH-1:0] read_instrZ3;
  wire [OTHER-1:0] read_otherZ3;
  wire [WIDTH-1:0] read_instrZ4;
  wire [OTHER-1:0] read_otherZ4;
  wire [WIDTH-1:0] read_instrZ5;
  wire [OTHER-1:0] read_otherZ5;
  wire [WIDTH-1:0] read_instrZ6;
  wire [OTHER-1:0] read_otherZ6;
  wire [WIDTH-1:0] read_instrZ7;
  wire [OTHER-1:0] read_otherZ7;
  wire [WIDTH-1:0] read_instrZ8;
  wire [OTHER-1:0] read_otherZ8;
  wire [WIDTH-1:0] read_instrZ9;
  wire [OTHER-1:0] read_otherZ9;
  
  reg [ADDR_WIDTH-1:0] write_addrA[11:0];
  wire [11:0][ADDR_WIDTH-1:0] write_addrA_d;
  reg [ADDR_WIDTH-1:0] write_addrB[11:0];
  wire [11:0][ADDR_WIDTH-1:0] write_addrB_d;
  wire [ADDR_WIDTH-1:0] write_addr[11:0];

  reg [ADDR_WIDTH-1:0] read_addrA[9:0];
  wire [9:0][ADDR_WIDTH-1:0] read_addrA_d;
  reg [ADDR_WIDTH-1:0] read_addrB[9:0];
  wire [9:0][ADDR_WIDTH-1:0] read_addrB_d;
  wire [ADDR_WIDTH-1:0] read_addr_d[9:0];

  integer k;
  
  reg [5:0] busy[1:0];
  wire [1:0][5:0] busy_d;
  wire doFStall0,doFStall1;
  
  reg read_thread_reg;

  reg [6:0] initCount;
  reg init;
  wire [6:0] initCount_d;
  
  generate
  
      genvar w,r;
      for(w=0;w<12;w=w+1) begin : wrt_gen
          instrQ_bndAdd wrAddr0_mod(write_addrA[w],write_addrA_d[w],
            {write_instrEn&~{1'b0,write_instrEn[11:1]},write_instrEn==12'b0});
          instrQ_bndAdd wrAddr1_mod(write_addrB[w],write_addrB_d[w],
            {write_instrEn&~{1'b0,write_instrEn[11:1]},write_instrEn==12'b0});
          assign write_addr[w]=write_thread ? write_addrB[w] : write_addrA[w];
      end
      for(r=0;r<10;r=r+1) begin : rd_gen
          instrQ_bndAdd #(10) rdAddr0_mod(read_addrA[r],read_addrA_d[r],
            {read_instrEn&~{1'b0,read_instrEn[9:1]},read_instrEn==10'b0});
          instrQ_bndAdd #(10) rdAddr1_mod(read_addrB[r],read_addrB_d[r],
            {read_instrEn&~{1'b0,read_instrEn[9:1]},read_instrEn==10'b0});
          assign read_addr_d[r]=read_thread ? read_addrB_d[r] : read_addrA_d[r];
          
          get_carry #(6) cmp_mod(busy[read_thread_reg],~(r[5:0]+6'd1),1'b1,read_avail[r]);
      end
  endgenerate
  
  assign doFStall=write_thread ? doFStall1 : doFStall0;

  assign read_instr0=read_instrZ0 & {WIDTH{~init}};
  assign read_instr1=read_instrZ1 & {WIDTH{~init}};
  assign read_instr2=read_instrZ2 & {WIDTH{~init}};
  assign read_instr3=read_instrZ3 & {WIDTH{~init}};
  assign read_instr4=read_instrZ4 & {WIDTH{~init}};
  assign read_instr5=read_instrZ5 & {WIDTH{~init}};
  assign read_instr6=read_instrZ6 & {WIDTH{~init}};
  assign read_instr7=read_instrZ7 & {WIDTH{~init}};
  assign read_instr8=read_instrZ8 & {WIDTH{~init}};
  assign read_instr9=read_instrZ9 & {WIDTH{~init}};
  
  assign read_other0=read_otherZ0 & {OTHER{~init}};
  assign read_other1=read_otherZ1 & {OTHER{~init}};
  assign read_other2=read_otherZ2 & {OTHER{~init}};
  assign read_other3=read_otherZ3 & {OTHER{~init}};
  assign read_other4=read_otherZ4 & {OTHER{~init}};
  assign read_other5=read_otherZ5 & {OTHER{~init}};
  assign read_other6=read_otherZ6 & {OTHER{~init}};
  assign read_other7=read_otherZ7 & {OTHER{~init}};
  assign read_other8=read_otherZ8 & {OTHER{~init}};
  assign read_other9=read_otherZ9 & {OTHER{~init}};
  
  instrQ_box box_mod(
  clk,
  rst,
  write_instrEn|{11'b0,init},
  init ? initCount[0] : write_thread,
  (write_wen & ~doFStall) | init,
  init ? initCount[6:1] : write_addr[0],
  write_instr0 & {WIDTH{~init}},
  write_other0 & {OTHER{~init}},
  write_addr[1],write_instr1,write_other1,
  write_addr[2],write_instr2,write_other2,
  write_addr[3],write_instr3,write_other3,
  write_addr[4],write_instr4,write_other4,
  write_addr[5],write_instr5,write_other5,
  write_addr[6],write_instr6,write_other6,
  write_addr[7],write_instr7,write_other7,
  write_addr[8],write_instr8,write_other8,
  write_addr[9],write_instr9,write_other9,
  write_addr[10],write_instr10,write_other10,
  write_addr[11],write_instr11,write_other11,
  read_thread_reg,
  read_clkEn,
  read_addr_d[0],read_instrZ0,read_otherZ0,
  read_addr_d[1],read_instrZ1,read_otherZ1,
  read_addr_d[2],read_instrZ2,read_otherZ2,
  read_addr_d[3],read_instrZ3,read_otherZ3,
  read_addr_d[4],read_instrZ4,read_otherZ4,
  read_addr_d[5],read_instrZ5,read_otherZ5,
  read_addr_d[6],read_instrZ6,read_otherZ6,
  read_addr_d[7],read_instrZ7,read_otherZ7,
  read_addr_d[8],read_instrZ8,read_otherZ8,
  read_addr_d[9],read_instrZ9,read_otherZ9
  );
  
  instrQ_upDown busy0_mod(busy[0],busy_d[0],~write_wen | write_thread | doFStall,write_instrEn,~read_clkEn | read_thread_reg,read_instrEn,doFStall0);
  instrQ_upDown busy1_mod(busy[1],busy_d[1],~write_wen | ~write_thread | doFStall,write_instrEn,~read_clkEn | ~read_thread_reg,read_instrEn,doFStall1);
  
  adder_inc #(7) initAdd_mod(initCount,initCount_d,1'b1,);
  
  always @(posedge clk) begin
      for (k=0;k<10;k=k+1) if (rst) begin
          read_addrA[k]<=k[5:0];
          read_addrB[k]<=k[5:0]; 
      end else if (except) begin
          if (read_thread) read_addrB[k]<=k[5:0];
          else read_addrA[k]<=k[5:0];
      end else if (read_clkEn) begin
          if (read_thread) read_addrB[k]<=read_addrB_d[k];
          else read_addrA[k]<=read_addrA_d[k];
      end
      for (k=0;k<12;k=k+1) if (rst) begin
          write_addrB[k]<=k[5:0];
          write_addrA[k]<=k[5:0]; 
      end else if (except) begin
          if (except_thread) write_addrB[k]<=k[5:0];
          else write_addrA[k]<=k[5:0];
      end else if (write_wen & ~doFStall) begin
          if (write_thread) write_addrB[k]<=write_addrB_d[k];
          else write_addrA[k]<=write_addrA_d[k];
      end
      if (rst) begin
          busy[0]<=6'd0;
          busy[1]<=6'd0;
          read_thread_reg<=1'b0;
      end else if (except) begin
          if (~except_thread) busy[0]<=6'd0;
          else busy[1]<=6'd0;
          read_thread_reg<=read_thread;
      end else begin
          busy[0]<=busy_d[0];
          busy[1]<=busy_d[1];
          read_thread_reg<=read_thread;
      end
      if (rst) begin
          init<=1'b1;
          initCount<=7'b0;
      end else if (init) begin
          initCount<=initCount_d;
          if (initCount==7'd95) init<=1'b0;
      end
  end

endmodule

module instrQ_bndAdd(addr,addr_new,cnt);

  parameter CNT_COUNT=12;
  
  input [5:0] addr;
  output [5:0] addr_new;
  input [CNT_COUNT:0] cnt;
  
  generate
    genvar n;
    for (n=0;n<=CNT_COUNT;n=n+1) begin : add_gen
         wire [5:0] addr1;
         adder #(6) add_mod(addr,n[5:0],addr1,1'b0,1'b1,,,,);
        assign addr_new=cnt[n] ? addr1 &{~{2{&addr1[5:4]}},4'b1111} : 6'bz;
    end
  endgenerate
endmodule


module instrQ_upDown(addr,addr_new,fstall,inEn,stall,outEn,doFStall);

  
  input [5:0] addr;
  output [5:0] addr_new;
  input fstall;
  input [11:0] inEn;
  input stall;
  input [9:0] outEn;
  output doFStall;
  
  
  wire [12:0] cntIn;
  wire [10:0] cntOut;
  
  wire [12:-10] cnt;
  
  assign cntIn[12:1]=~{1'b0,inEn[11:1]}&inEn[11:0]&{12{~(fstall|doFStall)}};
  assign cntIn[0]=~inEn[0] || fstall|doFStall;

  assign cntOut[10:1]=~{1'b0,outEn[9:1]}&outEn[9:0]&{10{~stall}};
  assign cntOut[0]=~outEn[0] || stall;
  
  assign cnt[0]=|(cntIn[10:0]&cntOut[10:0]);
  assign cnt[1]=|(cntIn[11:1]&cntOut[10:0]);
  assign cnt[2]=|(cntIn[12:2]&cntOut[10:0]);
  
  assign cnt[-1]=|(cntIn[9:0]&cntOut[10:1]);
  generate
      genvar k,j;
      for(k=0;k<10;k=k+1) begin 
          assign cnt[3+k]=|(cntIn[12:3+k]&cntOut[9-k:0]);
          assign cnt[-1-k]=|(cntIn[9-k:0]&cntOut[10:1+k]);
      end
      for(j=-10;j<=12;j=j+1) begin : add_gen
          adder #(6) add_mod(addr,j[5:0],addr_new,1'b0,cnt[j],,,,);
      end
  endgenerate
  
  get_carry #(6) cmp_mod(~6'd37,addr,1'b1,doFStall);
endmodule
