`include "../struct.sv"

module bob_ram(
  clk,
  read_clkEn,
  read_addr, read_data,
  write_addr, write_data, write_wen
  );
  
  parameter ADDR_WIDTH=`bob_addr_width;
  parameter DATA_WIDTH=`bob_width;
  parameter ADDR_COUNT=`bob_count;
  
  input clk;
  
  input read_clkEn;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;
  
  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  reg [ADDR_WIDTH-1:0] read_addr_reg;
  
  
  assign read_data=ram[read_addr_reg];
  
    
  always @(posedge clk)
    begin
      if (write_wen) ram[write_addr]<=write_data;
      if (read_clkEn) read_addr_reg<=read_addr;
    end
    
endmodule

module bob_addr(
  clk,
  rst,
  except,
  except_thread,
  except_both,
  new_en,
  new_thread,
  new_addr,
  stall,
  doStall,
  hasRetire,
  hasRetireX,
  doRetire,
  retire_addr,
  retire_addr_reg,
  retire_thread,
  both,thread0,thread1
  );
  
  input clk;
  input rst;
  input except;
  input except_thread;
  input except_both;
  input new_en;
  input new_thread;
  output reg [5:0] new_addr;
  input stall;
  output doStall;
  output hasRetire,hasRetireX;
  input doRetire;
  output [5:0] retire_addr;
  input [5:0] retire_addr_reg;
  output retire_thread;
  output reg both,thread0,thread1;

  wire [5:0] new_addr_d;
  wire [47:0] avail;
  reg [47:0] availN;
  reg [47:0] availP;
  reg availOnP;

  wire [47:0] retire_first;
  wire [47:0] retire_first_alt;
  wire [5:0] retire_first_bank;
  wire [5:0] retire_first_alt_bank;
  wire retire_has,retire_has_alt;
  reg [47:0] teh_thr;
  reg [47:0] retire_first_reg;
  wire [47:0] retire_new;
  wire last_ret;
  
  integer k;

  generate
    genvar y,x;
    for(y=0;y<6;y=y+1) begin : bank_gen
        wire [5:0] addrA;
        wire [5:0] addrB;
        wire [7:0] new_bits;
        for(x=0;x<8;x=x+1) begin : item_gen
            assign addrA=retire_first[y*8+x] ? y*8+x : 6'bz;
            assign addrB=retire_first_alt[y*8+x] ? y*8+x : 6'bz;
            assign new_bits[x]=new_addr[2:0]==x;
        end
        assign addrA=retire_first_bank[y] ? 6'bz : 6'b0;
        assign addrB=retire_first_alt_bank[y] ? 6'bz : 6'b0;
        assign retire_addr=(retire_first_bank[y] & ~last_ret) ? addrA : 6'bz;
        assign retire_addr=(retire_first_alt_bank[y] & last_ret) ? addrB : 6'bz;
        assign retire_new[y*8+:8]=(new_addr[5:3]==y) ? new_bits : 8'b0;
    end
  endgenerate

  adder_inc #(6) addrAdd_mod(new_addr,new_addr_d,new_addr!=6'd47,); 
  bit_find_first_bit #(48) bfb_mod(~availN&~retire_first_reg,retire_first,retire_has);
  bit_find_first_bit #(48) bfb2_mod(~availP,retire_first_alt,retire_has_alt);

  bit_find_first_bit #(6) bff_mod({|(~availN[47:40]&~retire_first_reg[47:40]),
  |(~availN[39:32]&~retire_first_reg[39:32]),|(~availN[31:24]&~retire_first_reg[31:24]),
  |(~availN[23:16]&~retire_first_reg[23:16]),|(~availN[15:8]&~retire_first_reg[15:8]),
  |(~availN[7:0]&~retire_first_reg[7:0])},retire_first_bank,);
  
  bit_find_first_bit #(6) bff2_mod({|(~availP[47:40]),|(~availP[39:32]),|(~availP[31:24]),
  |(~availP[23:16]),|(~availP[15:8]),|(~availP[7:0])},retire_first_alt_bank,);

  assign retire_addr=(retire_has & ~last_ret || retire_has_alt & last_ret) ? 6'bz : 6'b0;

  assign avail=availN&availP;
  assign new_addr_d=(new_addr==6'd47) ? 6'd0 : 6'bz;
  assign doStall=~avail[new_addr];
  assign last_ret=retire_first_reg==48'h8000_0000_0000 && availOnP && doRetire;

  assign retire_thread=last_ret ? (teh_thr & retire_first_alt)!=48'b0 : (teh_thr & retire_first)!=48'b0;
  assign hasRetire=~availP[retire_addr_reg] || ~availN[retire_addr_reg]; // || ~retire_has & ~retire_has_alt;
  assign hasRetireX=~availP[retire_addr_reg] || ~availN[retire_addr_reg];

  always @(posedge clk) begin
    if (rst) begin
        both<=1'b0;
        thread0<=1'b1;
        thread1<=1'b0;
    end else if (except) begin
        if (except_both) begin
            both<=1'b1;
            thread0<=1'b1;
            thread1<=1'b1;
        end else begin
            if (~except_thread) begin
                thread0<=1'b1;
                thread1<=1'b0;
            end
            if (except_thread) begin
                thread1<=1'b1;
                thread0<=1'b0;
            end
        end
    end
    if (rst) begin
        availOnP<=1'b0;
	teh_thr<=48'b0;
	availN=48'hffff_ffff_ffff;
	availP=48'hffff_ffff_ffff;
	retire_first_reg<=48'b0;
	new_addr<=6'd0;
    end else begin
        if (new_en && ~stall && ~doStall) begin
            new_addr<=new_addr_d;
            if (new_addr==6'd47) availOnP<=1'b1;
        end
        
        if (doRetire) begin 
            availN=availN|retire_first_reg;
            retire_first_reg<=retire_first;
        end else if (~hasRetire&new_en&~stall&~doStall) begin
            retire_first_reg<=48'b0;//retire_new;
        end else if (retire_first_reg==0) begin
            retire_first_reg<=retire_first;
        end
                
        if (availOnP) begin
            if (new_en && ~stall && ~doStall) availP[new_addr]=1'b0;
        end else begin
            if (new_en && ~stall && ~doStall) availN[new_addr]=1'b0;
        end
        
        if (new_en && ~stall && ~doStall) teh_thr[new_addr]<=new_thread;
        if (last_ret||~retire_has&availOnP&(retire_first_reg==0)) begin
            availOnP<=1'b0;
            availN=availP;
            retire_first_reg<=retire_first_alt;
            availP=48'hffff_ffff_ffff;
        end
   
        if (except) begin 
            for(k=0;k<48;k=k+1) 
            if (except_thread==teh_thr[k]) begin
                availN[k]=1'b1;
                availP[k]=1'b1;
            end
            if ((~last_ret &&except_thread==((retire_first&teh_thr)!=0))
              || (last_ret &&except_thread==((retire_first_alt&teh_thr)!=0))) retire_first_reg<=48'b0;
        end
    end
  end
endmodule
