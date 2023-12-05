module CU(op_code, RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop,branch2);
input [5:0] op_code;
output reg RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, branch2;
output reg [1:0] aluop;

parameter R_type =  6'b000000,
          lw =      6'b100011,
          sw =      6'b101011,
          beq =     6'b000100,
          j =       6'b000010,
          addiu =   6'b001001,
          andi =    6'b001100,
          ori =     6'b001101,
          slti =    6'b001010,
          bne =     6'b000101;
always @(op_code) begin
    case(op_code)
        R_type:{RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop,branch2} <= 11'b11000000100;
        lw:{RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop,branch2} <=     11'b01110100000;
        sw:{RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop,branch2} <=     11'bx0101x00000;
        beq:{RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop,branch2} <=    11'bx0000x10010;
        j:{RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop,branch2} <=      11'bx0x00x01xx0;
        addiu:{RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop,branch2} <=  11'b01100000000;
        andi:{RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop,branch2} <=   11'b01100000110;
        ori:{RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop,branch2} <=    11'b01100000110;
        slti:{RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop,branch2} <=   11'b01100000110;
        bne:{RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop,branch2} <=    11'bx0000x10011;
    endcase
end
endmodule