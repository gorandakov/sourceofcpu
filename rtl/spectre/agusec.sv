

module agusec_check_upper3(
  input [63:0] ptr,
  input [39:0] A,
  input [39:0] B,
  output [2:0] pos_ack,
  output [2:0] neg_ack,
  output [1:0] pos_flip,
  output [1:0] neg_flip,
  output nhi_less
  );
  parameter [0:0] AGU=0;
  wire [4:0] exp=ptr[`ptr_exp];

  wire [3:0] posx;
  wire do_pos,do_pos2,do_neg,do_neg2,do_neg1;
  wire do_pos3,do_neg3;
  wire [7:0] msk;
  wire [40:0] O={1'b0,A|B};
  wire [40:0] X={1'b1,A^B};
  wire [40:0] And={1'b1,A&B};
  wire diff=~nhi_less;
  wire on_hi=~ptr[`ptr_on_low];
  wire hiff=~AGU && &ptr[`ptr_hi];
  wire max=&exp;

  assign posx[3]=~&exp[4:3];
  assign posx[2]=~exp[4];
  assign posx[1]=~|exp[4:3];
  assign posx[0]=1'b0;
  
  assign msk[1]=&exp[2:0];
  assign msk[2]=~&exp[2:0];
  assign msk[3]=exp[2:1]==2'b10 || exp[1:0]==2'b0;
  assign msk[4]=exp[2:0]==3'b100 || ~exp[2];
  assign msk[5]=~exp[2];
  assign msk[6]=~exp[2]&&exp[1:0]!=2'b1;
  assign msk[7]=~exp[2]&&~^exp[1:0];
  assign msk[0]=1'b0; //

  assign pos_ack[1]=(do_pos && ~on_hi && diff|hiff) || max ; //c==1
  assign pos_ack[0]=do_pos || do_pos2 & ~on_hi & (diff||hiff) || max; //c==0
  assign pos_ack[2]=do_pos3 || max;
  assign neg_ack[0]=do_neg && on_hi && diff; //c==0
  assign neg_ack[1]=do_neg || (do_neg2|do_neg1) & on_hi & diff; //c==1
  assign neg_ack[2]=do_neg3 || max;

  assign pos_flip[0]=do_pos2 & ~do_pos & ~on_hi & diff ||
    do_pos & ~on_hi & hiff;
  assign pos_flip[1]=do_pos & ~on_hi & diff || do_pos2 & ~on_hi & hiff;

  assign neg_flip[0]=do_neg && on_hi && diff;
  assign neg_flip[1]=(do_neg2|do_neg1) & ~do_neg & on_hi & diff;

  get_carry #(7) cmp_mod(ptr[`ptr_hi],~ptr[`ptr_low],1'b1,nhi_less);
  generate
    genvar p;
    wire [3:0] pos0;
    wire [3:0] pos2;
    wire [3:0] pos3;
    wire [3:0] neg2;
    wire [3:0] neg1;
    wire [3:0] neg0;
    wire [3:0] neg3;
    wire [3:0] xpos0;
    wire [3:0] xpos2;
    wire [3:0] xpos3;
    wire [3:0] xneg2;
    wire [3:0] xneg1;
    wire [3:0] xneg0;
    wire [3:0] xneg3;
    for(p=0;p<4;p=p+1) begin : offs
       
        assign pos0[p]= ~posx[p] ||  ~|O[p*8+8+:8];
        assign pos2[p]= ~posx[p] ||  ~|O[p*8+9+:8];
        assign pos3[p]= ~posx[p] ||  ~|O[p*8+1+:8];
        assign neg0[p]= ~posx[p] ||  &X[p*8+8+:8];
        assign neg1[p]= ~posx[p] ||  &And[p*8+8+:8];
        assign neg2[p]= ~posx[p] ||  &X[p*8+9+:8];
        assign neg3[p]= ~posx[p] ||  &X[p*8+1+:8];
       
        
        assign xpos0[p]= p!=exp[4:3] ||  ~|(O[p*8+8+:8]&msk);
        assign xpos2[p]= p!=exp[4:3] ||  ~|(O[p*8+9+:8]&msk);
        assign xpos3[p]= p!=exp[4:3] ||  ~|(O[p*8+1+:8]&msk);
        assign xneg3[p]= p!=exp[4:3] ||  &(X[p*8+1+:8]|~msk);
        assign xneg0[p]= p!=exp[4:3] ||  &(X[p*8+8+:8]|~msk);
        assign xneg1[p]= p!=exp[4:3] ||  &(And[p*8+8+:8]|~msk);
        assign xneg2[p]= p!=exp[4:3] ||  &(X[p*8+9+:8]|~msk);
    end
    assign do_pos=&pos0 && &xpos0;
    assign do_pos2=&pos2 && &xpos2;
    assign do_pos3=&pos0 && &xpos0 && &pos3 && &xpos3;
    assign do_neg=&neg0 && &xneg0;
    assign do_neg2=&neg2 && &xneg2;
    assign do_neg1=&neg1 && & xneg1;
    assign do_neg3=&neg0 && &xneg0 && &neg3 && &xneg3;
  endgenerate

endmodule

module agusec_range(
  input [63:0] ptr,
  input cin_secq,
  input diff,
  output cout_secq);

  wire [7:0] low={ptr[`ptr_low],1'b0};
  wire [7:0] high={ptr[`ptr_hi],1'b1};
  //wire diff=ptr[`ptr_hi_less];
  wire hi_pass=diff && ptr[`ptr_on_low];
  wire lo_lass=diff && ~ptr[`ptr_on_low];
  wire [7:0] bits;
  wire cout_low,cout_hio;

  get_carry #(8) cmpLow_mod(~low,bits,1'b1,cout_low);
  get_carry #(8) cmpHio_mod(high,~bits,1'b1,cout_hio);
  agusec_shift8  sh_mod(ptr[`ptr_exp],ptr[43:4],bits);
  assign cout_secq=cin_secq && cout_low|lo_lass && cout_hio|hi_pass;
endmodule
