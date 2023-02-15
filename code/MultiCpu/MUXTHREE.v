module MUXTHREE (I0,I1,I2,ctrl,out);
	input[width-1:0] I0,I1,I2;
	input [1:0]ctrl;
	output reg[width-1:0] out;
	parameter width=32;

	always @(I0 or I1 or I2 or ctrl) begin
		case(ctrl)
			3'b000: out=I0;
			3'b001: out=I1;
			3'b010: out=I2;
		endcase
	end
endmodule
