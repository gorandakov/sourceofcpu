`include "../struct.sv"


//dcache1_tag_ram read during write behaviour: write first
module dcache2_tag_ram(
  clk,
  rst,
  read_clkEn,
  read_addr,
  read_data,
  write_addr,
  write_data,
  write_wen
  );
  localparam ADDR_WIDTH=8;
  localparam DATA_WIDTH=`dc2Tag_width;
  localparam ADDR_COUNT=256;
  
  input clk;
  input rst;
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
      if (rst) read_addr_reg<={ADDR_WIDTH{1'b0}};
      else if (read_clkEn) read_addr_reg<=read_addr;
      if (write_wen) ram[write_addr]<=write_data;
    end

endmodule

module dcache2_tag(
  clk,
  rst,
  req_en,
  req_wrtEn,
  req_addrE,
  req_addrO,
  req_odd,
  req_split,
  req_hitE,req_hitO,req_exclE,req_exclO,
  req_dir_ins_E,req_dir_ins_O,
  req_hitEL,req_hitOL,
  req_hitEH,req_hitOH,
  req_LRUe,req_LRUo,
  write_wen,
  write_dupl,
  write_hit,
  write_excl,write_dir_ins,
  expun_addrE,expun_addrO,
  init,
  initCount
  );
  localparam PADDR_WIDTH=44;
  input clk;
  input rst;
  input req_en;
  input req_wrtEn;
  input [PADDR_WIDTH-9:0] req_addrE;
  input [PADDR_WIDTH-9:0] req_addrO;
  input req_odd;
  input req_split;
  output req_hitE,req_hitO;
  output req_exclE,req_exclO;
  output req_dir_ins_E,req_dir_ins_O;
  output reg req_hitEL;
  output reg req_hitOL;
  output reg req_hitEH;
  output reg req_hitOH;
  input [4:0] req_LRUe;
  input [4:0] req_LRUo;
  input write_wen;
  input write_dupl;
  output write_hit;
  input write_excl;
  input write_dir_ins;
  output [35:0] expun_addrE;
  output [35:0] expun_addrO;
  input init;
  input [7:0] initCount;

  wire hitE,hitO;
  wire write_hitE,write_hitO;
  reg [PADDR_WIDTH-9:0] req_addrE_reg;
  reg [PADDR_WIDTH-9:0] req_addrO_reg;
  reg req_odd_reg,req_split_reg;
  reg write_wen_reg,req_wrtEn_reg;
  reg write_excl_reg,write_dir_ins_reg;
  wire [`dc2Tag_width-1:0] tag_dataE;
  wire [`dc2Tag_width-1:0] tag_dataO;
  wire [`dc2Tag_width-1:0] tag_wDataE;
  wire [`dc2Tag_width-1:0] tag_wDataO;
  reg req_en_reg;
  reg write_dupl_reg;
  
  dcache2_tag_ram ramE_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(req_en),
  .read_addr(req_addrE[7:0]),
  .read_data(tag_dataE),
  .write_addr(init ? initCount : req_addrE_reg[7:0]),
  .write_data(tag_wDataE & {`dc2Tag_width{~init}}),
  .write_wen(write_wen_reg & write_hit & ~req_odd_reg || req_en_reg || init)
  );

  dcache2_tag_ram ramO_mod(
  .clk(clk),
  .rst(rst),
  .read_clkEn(req_en),
  .read_addr(req_addrO[7:0]),
  .read_data(tag_dataO),
  .write_addr(init ? initCount : req_addrO_reg[7:0]),
  .write_data(tag_wDataO & {`dc2Tag_width{~init}}),
  .write_wen(write_wen_reg & write_hit & ~req_odd_reg || req_en_reg || init)
  );

  assign hitE=req_addrE_reg[PADDR_WIDTH-9:8]==tag_dataE[`dc2Tag_addr_43_16] &&
    tag_dataE[`dc2Tag_valid] && req_en_reg;
  assign hitO=req_addrO_reg[PADDR_WIDTH-9:8]==tag_dataO[`dc2Tag_addr_43_16] &&
    tag_dataO[`dc2Tag_valid] && req_en_reg;
 
  assign req_hitE=hitE && ~req_odd_reg | req_split_reg;
  assign req_hitO=hitO && req_odd_reg | req_split_reg;

  assign write_hit=write_dupl_reg ? req_hitE|req_hitO : write_wen_reg && (req_odd_reg ? req_LRUo==5'd23 : req_LRUe==5'd23);
  assign write_hitE=write_dupl_reg ? req_hitE : write_wen_reg && req_LRUo==5'd23 && ~req_odd_reg;
  assign write_hitO=write_dupl_reg ? req_hitO : write_wen_reg && req_LRUe==5'd23 && req_odd_reg;
  
  assign req_exclE=tag_dataE[`dc2Tag_exclusive];
  assign req_exclO=tag_dataO[`dc2Tag_exclusive];
  assign req_dir_ins_E=tag_dataE[`dc2Tag_ins_dirty];
  assign req_dir_ins_O=tag_dataO[`dc2Tag_ins_dirty];
 
  assign expun_addrE={tag_dataE[`dc2Tag_addr_43_16],req_addrE_reg[7:0]};
  assign expun_addrO={tag_dataO[`dc2Tag_addr_43_16],req_addrO_reg[7:0]};
  
  assign tag_wDataE[`dc2Tag_addr_43_16]=(~write_wen_reg || ~write_hitE) ? tag_dataE[`dc2Tag_addr_43_16] : req_addrE_reg[PADDR_WIDTH-9:8]; 
  assign tag_wDataO[`dc2Tag_addr_43_16]=(~write_wen_reg || ~write_hitO) ? tag_dataO[`dc2Tag_addr_43_16] : req_addrO_reg[PADDR_WIDTH-9:8];
  assign tag_wDataE[`dc2Tag_valid]=(write_wen_reg & write_hitE) ? 1'b1 : tag_dataE[`dc2Tag_valid]; 
  assign tag_wDataO[`dc2Tag_valid]=(write_wen_reg & write_hitO) ? 1'b1 : tag_dataO[`dc2Tag_valid]; 
  assign tag_wDataE[`dc2Tag_exclusive]=(write_wen_reg & write_hitE) ? write_excl_reg  : tag_dataE[`dc2Tag_exclusive]; 
  assign tag_wDataO[`dc2Tag_exclusive]=(write_wen_reg & write_hitO) ? write_excl_reg  : tag_dataO[`dc2Tag_exclusive]; 
  assign tag_wDataE[`dc2Tag_ins_dirty]=(write_wen_reg & write_hitE) ? write_dir_ins_reg  : 
    tag_dataE[`dc2Tag_ins_dirty] || req_hitE & req_wrtEn_reg; 
  assign tag_wDataO[`dc2Tag_ins_dirty]=(write_wen_reg & write_hitO) ? write_dir_ins_reg  : 
    tag_dataO[`dc2Tag_ins_dirty] || req_hitO & req_wrtEn_reg; 

  
  always @* begin
      req_hitOH=req_odd_reg && hitO;
      req_hitEH=~req_odd_reg && hitE;
      req_hitOL=req_split_reg ? req_hitEH : req_hitOH;
      req_hitEL=req_split_reg ? req_hitOH : req_hitEH;
  end

  always @(posedge clk) begin
      if (rst) begin
          req_addrE_reg<=36'b0;
          req_addrO_reg<=36'b0;
          req_odd_reg<=1'b0;
          req_split_reg<=1'b0;
          write_wen_reg<=1'b0;
          write_excl_reg<=1'b0;
          write_dir_ins_reg<=1'b0;
          req_wrtEn_reg<=1'b0;
          req_en_reg<=1'b0;
          write_dupl_reg<=1'b0;
      end else begin
          req_addrE_reg<=req_addrE;
          req_addrO_reg<=req_addrO;
          req_odd_reg<=req_odd;
          req_split_reg<=req_split;
          write_wen_reg<=write_wen;
          write_excl_reg<=write_excl;
          write_dir_ins_reg<=write_dir_ins;
          req_wrtEn_reg<=req_wrtEn;
          req_en_reg<=req_en;
          write_dupl_reg<=write_dupl;
      end
  end
endmodule

