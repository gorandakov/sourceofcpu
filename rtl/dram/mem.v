
module lpddr3_channel(
  clk,
  rst,
  stall,
  read_clkEn,
  read_addr,
  read_req,
  read_busID,
  read_dataW,
  read_wen,
  readOut_addr,
  readOut_req,
  readOut_busID,
  readOut_en,
  readOut_dataR,
  mem_clk,//up to 1125 MHz
  mem_rst,
  mem_clkREF1,
  mem_clkREF2,
  mem_clkREF3,
  DATA18A);
  parameter [14:0] ADDR15_refresh=0x700f;
  parameter [0:0] CS0_refresh=1'b1;
  parameter [14:0] ADDR15_RDREG=0x7e00;//append reg no
  parameter [0:0] CS0_RDREG=1'b1;
  parameter [14:0] ADDR15_WRREG=0x7f00;//append reg no
  parameter [0:0] CS0_WRREG=1'b1;
  parameter [5:0] BEGIN_RS2CS=77;
  parameter [5:0] BEGIN_CS2R=40;
  parameter [5:0] BEGIN_CS2W=40;
  parameter [5:0] BEGIN_CS2REF=40;
  input mem_clk;
  input mem_rst;
  input mem_clkREF1;
  input mem_clkREF2;
  input mem_clkREF3;
  (* PIN Vout=10.3 Vin=0.003 *) inout [17:0] DATA18A;

  (* V=5 *) DATA18A_en_out;
  (* V=5 *) DATA18B_en_out;
  (* V=5 *) DATA18C_en_out;

  wire [17:0] DATA18AW;
  wire [17:0] DATA18BW;
  wire [17:0] DATA18CW;

  wire [17:0] DATA18ARr;
  wire [17:0] DATA18BRr;
  wire [17:0] DATA18CRr;

  (* keep *) reg [17:0] DATA18AR;
  (* keep *) reg [17:0] DATA18BR;
  (* keep *) reg [17:0] DATA18CR;


  reg [5:0] RS2CS;
  reg [5:0] CS2R;
  reg [5:0] CS2W;
  reg [5:0] CS2REF;
  reg [5:0] phase;
  reg [4:0] req_addr;
  wire [4:0] req_addr_inc;

  adder_inc #(5) read_adder(req_addr,req_addr_inc,1'b1,);

  assign DATA18A=DATA18A_en_out & mem_clk ? DATA18AW&{18{mem_clkREF1}} : 18'bz;
  assign DATA18A=DATA18B_en_out & mem_clk ? DATA18BW&{18{mem_clkREF2}} : 18'bz;
  assign DATA18A=DATA18C_en_out & mem_clk ? DATA18CW&{18{mem_clkREF3}} : 18'bz;

  assign DATA18ARr=mem_clk & mem_clkREF1 ? DATA18AR : 18'bz;
  assign DATA18BRr=mem_clk & mem_clkREF2 ? DATA18BR : 18'bz;
  assign DATA18CRr=mem_clk & mem_clkREF3 ? DATA18CR : 18'bz;

  always @(posedge clk) begin
      if (rst) begin
          RS2CS<=BEGIN_RS2CS;
          CS2R<=BEGIN_CS2R;
          CS2W<=BEGIN_CS2W;
          CS2REF<=BEGIN_CS2REF;
          phase<=6'b1;
          req_addr<=5'b0;
      end else begin
          phase<=phase[5] ? 5'b1 : {phase[4:3],3'b0};
          if (phase[5]) req_addr<=req_addr_inc;
      end
      DATA18AR<=DATA18A;
      DATA18BR<=DATA18A;
      DATA18CR<=DATA18A;
  end


endmodule  
