module MUXTWO (I0,I1,ctrl,out);
	input[width-1:0] I0,I1;
	input ctrl;
	output reg[width-1:0] out;
	parameter width=32;

	always @(I0 or I1 or ctrl) begin
		if (ctrl==0)
			out=I0;
		else
			out=I1;
	end
endmodule
