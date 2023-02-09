module SHIFTER32_L2(X,Sh);
input [31:0] X;
output [31:0] Sh;
parameter z=2'b00;
assign Sh={X[29:0],z};
endmodule
