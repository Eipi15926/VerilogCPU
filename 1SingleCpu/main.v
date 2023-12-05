`include "ADD.v"
`include "ALU.v"
`include "ALUCU.v"
`include "CU.v"
`include "DM.v"
`include "IM.v"
`include "MUXTWO.v"
`include "PC.v"
`include "RF.v"
`include "SHL2.v"
`include "SIG16_32.v"
`include "AND.v"

module main(Clock,Reset);
    input Clock,Reset;

    wire RegDst,Jump,RegWr,Branch,MemtoReg,MemWr,MemRd,ALUSrc;
    wire AluZ,MuxCtrl;    
    wire [1:0] ALUOp;
    wire [2:0]AluCtrl;
    wire [4:0]WRi;
    wire [27:0]ShlOut;
    wire [31:0]PcI,PcAddr,Inst,Add1C,TransAddr;
    wire [31:0]Data,RdO,AluC,WdI,AluA,AluB,Sig32,Add2B,Add2C,MuxOut;

    assign TransAddr={Add1C[31:28],ShlOut};

    PC Pc(Clock,Reset,PcI,PcAddr);
    CU Cu(Inst[31:26],RegDst, RegWr, ALUSrc, MemRd, MemWr, MemtoReg, Branch, Jump, ALUOp);
    ALUCU Alucu(.inst(Inst[5:0]),.aluop(ALUOp),.ctrl(AluCtrl));

    MUXTWO Mt1(Inst[20:16],Inst[15:11],RegDst,WRi);
    MUXTWO Mt2(Data,Sig32,ALUSrc,AluB);
    MUXTWO MT3(AluC,RdO,MemtoReg,WdI);
    MUXTWO MT4(Add1C,Add2C,MuxCtrl,MuxOut);
    MUXTWO MT5(MuxOut,TransAddr,Jump,PcI);

    SHL2 Shl21(Inst[25:0],ShlOut);
    SHL2 SHl22(Sig32,Add2B);

    AND And(Branch,AluZ,MuxCtrl);

    SIG16_32 Sig1632(Inst[15:0],Sig32);

    ADD Add1(.a(32'h4),.b(PcAddr),.sum(Add1C));
    ADD Add2(.a(Add1C),.b(Add2B),.sum(Add2C));

    ALU Alu(AluA,AluB,AluCtrl,AluC,AluZ);

    IM Im(PcAddr,Inst);
    DM Dm(MemRd,MemWr,AluC,Data,Rdo,Clock);
    RF Rf(WdI,Inst[25:21],Inst[20:16],WRi,AluA,Data,Clock,RegWr);
    
endmodule

module t;
    reg clock;
    reg reset;
    main cpu(clock,reset);

    initial begin
        $dumpfile("main_test.vcd");  // vcd name   
        $dumpvars(0,t); // testbench module name
        clock=0;
        reset=1;
        #5;
        clock=1;reset=1;
        #5;
        reset=0;
        clock=0;
        forever #5 clock =~ clock;
    end
endmodule
