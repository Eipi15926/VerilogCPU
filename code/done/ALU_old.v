module ALU (a,b,ctrl,out,zero);
	input[width-1:0] a,b;
	input[3-1:0] ctrl;
	output reg[width-1:0] out;
	output reg[1:0]zero;
	parameter width=32;

	always @(a or b or ctrl) begin
		case(ctrl)
			3'b000: out=a&b;
			3'b001: out=a|b;
			3'b010: out=a+b;
			3'b011: out=a-b;
			3'b100: begin
				if (a<b)
					out=1;
				else
					out=0;
			end
			default: out=~a;//not��һԪ���㣬����Ĭ�����ֻ��һ���������a����
		endcase
		if (out==0)
			zero=1;
		else
			zero=0;
	end
endmodule
