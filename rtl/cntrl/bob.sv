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
  new_en,
  new_addr,
  stall,
  doStall,
  hasRetire,
  doRetire,
  retire_addr
  );
  
  input clk;
  input rst;
  input except;
  input new_en;
  output reg [5:0] new_addr;
  input stall;
  output doStall;
  output hasRetire;
  input doRetire;
  output [5:0] retire_addr;

  reg [5:0] retire_addr0;
  wire [5:0] retire0_inc;
  reg [5:0] cnt;
  wire [5:0] cnt_inc;
  wire [5:0] cnt_dec;
  wire [5:0] new_addr_d;
  adder_inc #(5) add1_mod(retire_addr0,retire0_inc,1'b1,);
  adder_inc #(5) add2_mod(cnt,cnt_inc,1'b1,);
  adder_inc #(5) add3_mod(new_addr,new_addr_d,new_addr!=6'd47,);

  assign new_addr_d=new_addr==6'd47 ? 6'd0 : 6'bz;

  adder #(5) add4_mod(cnt,6'h3f,cnt_dec,1'b0,1'b1,,,);

  assign retire_addr=retire_addr0;

  assign hasRetire=cnt!=6'd0;
  assign doStall=cnt==6'd48;

  always @(posedge clk) begin
      if (rst) begin
	  retire_addr0<=6'd0;
	  cnt<=6'd0;
	  new_addr<=6'd0;
      end else if (except) begin
          retire_addr<=new_addr;
	  cnt<=6'd0;
      end else begin
	  if (new_en && !stall && !doStall) new_addr<=new_addr_d;
	  if (new_en && !stall && !doStall && !doRetire) cnt=cnt_inc;
	  if (!new_en | stall | doStall && doRetire) cnt=cnt_dec;
	  if (doRetire && retire_addr0!=6'd47) retire_add0<=retire0_inc;
	  if (doRetire && retire_addr0==6'd47) retire_add0<=6'b0;
      end
  end

endmodule
