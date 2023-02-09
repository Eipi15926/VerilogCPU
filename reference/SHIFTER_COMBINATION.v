module SHIFTER_COMBINATION(X,PCADD4,Sh);
    input [26:0] X;
    input [31:0] PCADD4;
    output [31:0] Sh;
    parameter z=2'b00;
    assign Sh={PCADD4[3:0],X[26:0],z};
endmodule
