module ALUcu(inst,ALUop,ctrl);
	input[5:0] inst;
	input[1:0] ALUop;
	output[3-1:0] ctrl;
	assign ctrl=2;
endmodule
