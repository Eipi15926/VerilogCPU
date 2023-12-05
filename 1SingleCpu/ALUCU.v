module ALUCU(inst,aluop,ctrl);
	input[5:0] inst;
	input[1:0] aluop;
	output reg[3-1:0] ctrl;
    always @(inst or aluop) begin
        casex(aluop) 
            2'b00: ctrl <= 100;
            2'b01: ctrl <= 110;
            2'b1x: begin
                case (inst)
                    6'b100000: ctrl <= 100;//add
                    6'b100001: ctrl <= 101;//addu
                    6'b100010: ctrl <= 110;//sub
                    6'b100100: ctrl <= 000;//and
                    6'b100101: ctrl <= 001;//or
                    6'b101010: ctrl <= 011;//slt
                endcase
            end
        endcase
    end
endmodule