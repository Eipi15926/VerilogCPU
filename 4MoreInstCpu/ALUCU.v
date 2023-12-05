module ALUCU(inst,aluop,ctrl,opcode);
	input[5:0] inst;
	input[1:0] aluop;
    input[5:0] opcode;
	output reg[3-1:0] ctrl;
    always @(inst or aluop) begin
        casex(aluop) 
            2'b00: ctrl <= 100;
            2'b01: ctrl <= 110;
            2'b10: begin
                case (inst)
                    6'b100000: ctrl <= 100;//add
                    6'b100001: ctrl <= 101;//addu
                    6'b100010: ctrl <= 110;//sub
                    6'b100100: ctrl <= 000;//and
                    6'b100101: ctrl <= 001;//or
                    6'b101010: ctrl <= 011;//slt
                    6'b100110: ctrl <= 010;//xor
                    6'b100111: ctrl <= 111;//nor

                endcase
            end
            2'b11: begin//编码11表示寄存器和立即数相关的操作
                case(opcode)
                    6'b001100: ctrl <= 000;//andi
                    6'b001101: ctrl <= 001;//ori
                    6'b001010: ctrl <= 011;//slti
                    6'b001110: ctrl <= 010;//xori
                endcase
            end
        endcase
    end
endmodule