
module frrv_rom_stage(
  bytes_in,
  startoff,
  bite_tail,
  bits_out
  );
  input [255:0] bytes_in;
  input [3:0] startoff;
  input bite_tail;
  output [15:0] bits_out;

  wire [15:0] bits_in;
  wire [14:0] bits_in_mask;
  wire [14:0] bits_out0;

  generate
    genvar p;
    for(p=0;p<16;p=p+1) begin : cmp
	if (p<15) get_carry #(4) cry_mod(p[3:0],~{startoff},1'b1,bits_in_mask[p]);
	assign bits_in[p]=~&bytes_in[16*p+:2];
    end
  endgenerate

  frrv_rom rom_mod(
  bits_in[14:0]|~bits_in_mask|{14'b0,bite_tail},
  bits_out0[14:0]);

  assign bits_out[14:0]=bits_out0&(bits_in_mask|{14'b0,bite_tail});
  assign bits_out[15]=~(bits_out0[14]&bits_in_mask[14]) || bits_in[15];
endmodule

