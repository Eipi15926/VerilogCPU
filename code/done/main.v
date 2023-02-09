`include "ADD.v"
`include "ALU.v"
`include "ALUcu.v"
`include "CU.v"
`include "DM.v"
`include "IM.v"
`include "muxtwo.v"
`include "PC.v"
`include "SHL2.v"
`include "sig16_32.v"
`include "PCadd4.v"

module main(clock,reset);
    input clock,reset;
    wire [31:0]addi,addo,inst;
    reg [31:0]addr_reg,ofst_reg;

    initial begin
        ofst_reg =0;
    end
    PC pc(clock,reset,addi,addo);
    ADD add1(.a(32'h4),.b(addo),.sum(addi));
    IM im(addo,inst);
    //PCadd4 pa4(ofst_reg,addi);
endmodule

module t;
    reg clock;
    reg reset;
    wire [31:0]add_i=7'h0,add_o=7'h0;
    reg [31:0]pcr;
    main cpu(clock,reset);

    initial begin
        $dumpfile("main_test.vcd");  // vcd name   
        $dumpvars(0,t); // testbench module name
        clock=0;
        reset=0;
        #10;
        clock=1;reset=0;
        #10;
        reset=1;
        clock=0;
        forever #5 clock =~ clock;
    end
endmodule
