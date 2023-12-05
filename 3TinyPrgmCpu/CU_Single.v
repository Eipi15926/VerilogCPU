module CU(op_code, RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop);
input [5:0] op_code;
output reg RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump;
output reg [1:0] aluop;

parameter R_type = 6'b000000,
          lw = 6'b100011,
          sw = 6'b101011,
          beq = 6'b000100,
          j = 6'b000010,
          addiu = 6'b001001;
always @(op_code) begin
    #0.1
    case(op_code)
        R_type: {RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop} <= 10'b1100000010;
        lw: {RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop} <= 10'b0111010000;
        sw: {RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop} <= 10'bx0101x0000;
        beq: {RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop} <= 10'bx0000x1001;
        j: {RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop} <= 10'bx0x00x01xx;
        addiu:{RegDst, regw, alusrc, memr, memw, memtoreg, branch, jump, aluop} <= 10'b0110000000;
    endcase
end
endmodule