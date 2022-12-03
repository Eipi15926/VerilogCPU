module sig16_32(in,out);
	input[16-1:0] in;
	output[32-1:0] out;
	assign out={16'b0,in};
endmodule
