`include "ADD.v"
`include "ALU.v"
`include "ALUCU.v"
`include "AND.v"
`include "CU.v"
`include "IM.v"
`include "IR.v"
`include "MUXTWO.v"
`include "MUXTHREE.v"
`include "MUXFOUR.v"
`include "OR.v"
`include "PC.v"
`include "RF.v"
`include "SHL2.v"
`include "SIG16_32.v"
`include "TSR.v"


module main(Clock);
    input Clock;
    wire IorD,IRWr,PCWr,PCWrCond,RegDst,RegWr,ALUSrcA,MemtoReg,MemRd,MemWr,PcW,AO,AluZ;
    wire[1:0]ALUOp,ALUSrcB,PCSrc;
    wire [2:0]AluCtrl;
    wire [27:0]ShlOut;
    wire [31:0]PcD,PcQ;
    wire [31:0]Inst;
    wire [31:0]Addr,Rd,MdrQ,AluOut,Sig32,Mux2;
    wire [31:0]AQ,AluA,AluB,AluC,MuxB;
    wire [31:0]WR,Wd,Rd1,Rd2,Bqwd;

    assign Mux2={PcQ[31:28],ShlOut};

    PC Pc(Clock,PcW,PcD,PcQ);
    IR Ir(IRWr,Clock,Rd,Inst);
    IM Im(Addr,MemWr,MemRd,Bqwd,Rd);
    RF Rf(Wd,Inst[25:21],Inst[20:16],WR,Rd1,Rd2,Clock,RegWr);
    ALU Alu(AluA,AluB,AluCtrl,AluC,AluZ);
    ALUCU Alucu(Inst,ALUOp,AluCtrl);
    CU Cu(Clock, RegWr,MemRd,MemWr,RegDst,MemtoReg,IRWr,IorD,PCWr,PCWrCond,ALUSrcA,PCSrc,ALUOp,ALUSrcB,Inst[31:26]);

    SHL2 Shl21(Inst[25:0],ShlOut);
    SHL2 Shl22(Sig32,MuxB);
    MUXTWO Muxtwo1(PcQ,AluOut,IorD,Addr);
    MUXTWO Muxtwo2(Inst[20:16],Inst[15:11],RegDst,WR);
    MUXTWO Muxtwo3(AluOut,MdrQ,MemtoReg,Wd);
    MUXTWO Muxtwo4(PcQ,AQ,ALUSrcA,AluA);
    MUXTHREE Muxthree(AluC,AluOut,Mux2,PCSrc,PcD);
    MUXFOUR Muxfour(Bqwd,32'b100,Sig32,MuxB,ALUSrcB,AluB);

    TSR A(Clock,Rd1,AQ);
    TSR B(Clock,Rd2,Bqwd);
    TSR MDR(Clock,Rd,MdrQ);
    TSR ALUOut(Clock,AluC,AluOut);
    SIG16_32 Sig1632(Inst[15:0],Sig32);
    AND And(PCWrCond,AluZ,AO);
    OR Or(PCWr,AO,PcW);


endmodule

module t;
    reg clock;
    reg reset;
    main cpu(clock);

    initial begin
        $dumpfile("main_test.vcd");  // vcd name   
        $dumpvars(0,t); // testbench module name
        clock=0;
        forever #5 clock =~ clock;
    end
endmodule
