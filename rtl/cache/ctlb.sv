`include "../struct.sv"

module ctlb_ram(
  clk,
  rst,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );

  localparam DATA_WIDTH=`ctlb_width;
  localparam ADDR_WIDTH=6;
  localparam ADDR_COUNT=64;
  
  input clk;
  input rst;
  input [ADDR_WIDTH-1:0] read_addr;
  output [DATA_WIDTH-1:0] read_data;
  input [ADDR_WIDTH-1:0] write_addr;
  input [DATA_WIDTH-1:0] write_data;
  input write_wen;

  reg [DATA_WIDTH-1:0] ram [ADDR_COUNT-1:0];
  
  assign read_data=ram[read_addr];

  always @(posedge clk)
    begin
      if (write_wen) ram[write_addr]<=write_data;
    end

endmodule


module ctlb_way(
  clk,
  rst,
  read_clkEn,
  fStall,
  addr,
  nat_jump,
  sproc,
  read_data,
  read_lru,
  read_hit,
  write_data,
  write_wen,
  write_nat,
  invalidate,
  init,
  newLRU
  );

  parameter WAYNO=0;
  localparam DATA_WIDTH=`ctlb_width;
  localparam OUTDATA_WIDTH=`ctlbData_width;
  localparam IP_WIDTH=64;
  localparam ADDR_WIDTH=5;

  
  input clk;
  input rst;
  input read_clkEn;
  input fStall;
  input [IP_WIDTH-1:0] addr;
  input nat_jump;
  input [15:0] sproc;
  output [OUTDATA_WIDTH-1:0] read_data;
  output [1:0] read_lru;
  output read_hit;
  input [OUTDATA_WIDTH-1:0] write_data;
  input write_wen;
  input write_nat;
  input invalidate;
  input init;
  input [1:0] newLRU;
  
  wire valid;
  wire [IP_WIDTH-1:0] ip;
  wire write_wen_ram;
  wire [DATA_WIDTH-1:0] read_data_ram;
  wire [DATA_WIDTH-1:0] write_data_ram;
  wire [DATA_WIDTH-1:0] write_data_new;
  wire [DATA_WIDTH-1:0] write_data_same;
  wire [DATA_WIDTH-1:0] write_data_init;

  wire [OUTDATA_WIDTH-1:0] tlb_data;

  reg write_wen_reg;

  reg write_nat_reg;

  reg [OUTDATA_WIDTH-1:0] write_data_reg;
  
  reg invalidate_reg;
  
  reg read_clkEn_reg;
  
  assign ip=read_data_ram[`ctlb_ip];
  assign valid=read_data_ram[`ctlb_valid];
  assign validN=read_data_ram[`ctlb_validN];
  assign read_lru=read_data_ram[`ctlb_lru];
  
  assign read_hit=(valid&~nat_jump||validN&nat_jump) && ((ip|{12{~nat_jump}})==(addr|{12{~nat_jump}}) ||
    ((ip|{12{~nat_jump}})=={sproc,addr[47:0]|{12{~nat_jump}}} && tlb_data[`ctlbData_global])) && ~invalidate_reg;
  
  assign write_wen_ram=(write_wen_reg && read_lru==2'b11) || read_clkEn&~fStall;
  
  assign tlb_data=read_data_ram[`ctlb_data];
  assign read_data=read_hit ? read_data_ram[`ctlb_data] : {OUTDATA_WIDTH{1'BZ}};
  assign write_data_new[`ctlb_ip]=addr;
  assign write_data_new[`ctlb_valid]=~write_nat_reg;
  assign write_data_new[`ctlb_validN]=write_nat_reg;
  assign write_data_new[`ctlb_data]=write_data_reg;
  assign write_data_new[`ctlb_lru]=2'b11;
  
  assign write_data_init[`ctlb_ip]=0;
  assign write_data_init[`ctlb_valid]=0;
  assign write_data_init[`ctlb_validN]=0;
  assign write_data_init[`ctlb_data]=0;
  assign write_data_init[`ctlb_lru]=WAYNO[1:0];

  assign write_data_same[`ctlb_ip]=ip;
  assign write_data_same[`ctlb_valid]=valid && ~(invalidate_reg&read_hit);
  assign write_data_same[`ctlb_validN]=validN && ~(invalidate_reg&read_hit);
  assign write_data_same[`ctlb_data]=read_data_ram[`ctlb_data];

  assign write_data_same[`ctlb_lru]=newLRU;
  
  
  assign write_data_ram=write_wen_reg & ~init ? write_data_new : {DATA_WIDTH{1'BZ}};
  assign write_data_ram=~write_wen_reg & ~init ? write_data_same : {DATA_WIDTH{1'BZ}};
  assign write_data_ram=init ? write_data_init : {DATA_WIDTH{1'BZ}};
  
  ctlb_ram ram_mod(
  .clk(clk),
  .rst(rst),
  .read_addr(nat_jump ? addr[9:4] : addr[17:12]),
  .read_data(read_data_ram),
  .write_addr(nat_jump ? addr[9:4] : addr[17:12]),
  .write_data(write_data_ram),
  .write_wen(write_wen_ram|init)
  );

  always @(posedge clk)
    begin
	  if (rst)
	    begin
		  write_wen_reg<=1'b0;
	//	  addr_reg<={ADDR_WIDTH{1'B0}};
		  write_data_reg<={OUTDATA_WIDTH{1'B0}};
		  invalidate_reg<=1'b0;
		  read_clkEn_reg<=1'b0;
		  write_nat_reg<=1'b0;
		end
	  else if (~fStall)
	    begin 
	//	  addr_reg<=addr;
		  write_wen_reg<=write_wen;
		  write_data_reg<=write_data;
		  invalidate_reg<=invalidate;
		  read_clkEn_reg<=read_clkEn;
		  write_nat_reg<=write_nat;
		end
    end
  
endmodule


module ctlb(
  clk,
  rst,
  read_clkEn,
  fStall,
  addr,
  read_data,
  nat_jump,
  read_hit,
  write_data,
  write_wen,
  csrss_en,
  csrss_addr,
  csrss_data
  );

  localparam DATA_WIDTH=`ctlb_width;
  localparam OUTDATA_WIDTH=`ctlbData_width;
  localparam IP_WIDTH=64-12;
  localparam ADDR_WIDTH=5;

  
  input clk;
  input rst;
  input read_clkEn;
  input fStall;
  input [IP_WIDTH-1:0] addr;
  output [OUTDATA_WIDTH-1:0] read_data;
  input nat_jump;
  output read_hit;
  input [OUTDATA_WIDTH-1:0] write_data;
  input write_wen;
  input csrss_en;
  input [15:0] csrss_addr;
  input [63:0] csrss_data;
  
  wire [3:0][1:0] newLRU;
  wire [3:0][1:0] oldLRU;
  wire [1:0] hitLRU;
  wire [3:0] read_hit_way;
  reg init_pending;
  reg [5:0] init_count;
  reg init_pending_reg;
  wire [5:0] init_count_d;
  wire [15:0] sproc;
  wire [47:0] dummy_sproc;

  reg [IP_WIDTH-1:0] addr_reg;
  
  reg read_clkEn_reg;

  assign read_hit=(|read_hit_way) & ~init_pending;
  assign hitLRU=read_hit ? 2'bz : 2'b11;
  assign read_data=read_hit ? {OUTDATA_WIDTH{1'BZ}} : {OUTDATA_WIDTH{1'B0}};

  generate
    genvar k;
    for(k=0;k<4;k=k+1)
      begin : ways_gen
        ctlb_way #(k) way_mod(
        clk,
        rst,
        read_clkEn,
        fStall,
        init_pending ? init_count : addr,
	nat_jump,
	sproc,
        read_data,
        oldLRU[k],
        read_hit_way[k],
        write_data,
        write_wen,
	nat_jump,
        1'B0,
        init_pending,
        newLRU[k]
        );
        
        lru_single #(2,k) lru_mod(oldLRU[k],newLRU[k],hitLRU,init_pending,read_clkEn);
        
        assign hitLRU=read_hit_way[k] ? oldLRU[k] : 2'bz;
        
      end
  endgenerate
  
  adder_inc #(6) initAdd_mod(init_count,init_count_d,1'b1,);
  csrss_watch #(`csr_spage) csrSproc_mod(
  clk,
  rst,
  csrss_addr,
  csrss_data,
  csrss_en,
  {sproc,dummy_sproc});
  
  always @(posedge clk)
    begin
   /*   if (rst)
        read_clkEn_reg<=1'b0;
      else if (~fStall)
        read_clkEn_reg<=read_clkEn;
     */ 
      if (rst)
        begin 
          init_pending<=1'b1;
          init_count<=0;
        end
      else if (init_pending)
        begin
          init_count<=init_count_d;
          if (init_count==63)
            init_pending<=1'b0;
        end
        
     /* if (rst)
        init_pending_reg<=1'b0;
      else
        init_pending_reg<=init_pending;*/
    end
  
endmodule


