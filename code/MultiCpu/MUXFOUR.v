module MUXFOUR (I0,I1,I2,I3,ctrl,out);
	input[width-1:0] I0,I1,I2,I3;
	input [1:0]ctrl;
	output reg[width-1:0] out;
	parameter width=32;

	always @(I0 or I1 or I2 or I3 or ctrl) begin
		case(ctrl)
			3'b000: out=I0;
			3'b001: out=I1;
			//3'b010: out=a+b;
			3'b010: out=I2;
            3'b011: out=I3;
		endcase
	end
endmodule
