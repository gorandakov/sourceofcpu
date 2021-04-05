module mulgen_FA(A,B,C,out,cout);
    input A,B,C;
    output out,cout;
    assign {cout,out}=A+B+C;
endmodule

module mulgen_HA(A,B,out,cout);
    input A,B;
    output out,cout;
    assign {cout,out}=A+B;
endmodule

module nnXor(R,C,and1,sig,val);
    input R;
    input C;
    input and1;
    input sig;
    output val;

    assign val=((R&C&and1)^sig);
endmodule
