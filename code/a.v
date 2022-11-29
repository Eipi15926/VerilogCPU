module muxtwo (out,a,b,sl);
    input a,b,sl;
    output out;

    not u1(nsl,sl);
    and #1 u2(sela,a,nsl);
    and #1 u3(selb,b,sl);
    or #1 u4(out,sela,selb);
endmodule

module t;
    reg ain,bin,select;
    reg clock;
    wire outw;

    initial begin
        $dumpfile("test.vcd");  // vcd name   
        $dumpvars(0,t); // testbench module name
        ain=0;
        bin=0;
        select=0;
        clock=0;
    end
    always # 50 clock = ~clock;
    always @(posedge clock) begin
        #1 ain={$random}%2;
        #3 bin={$random}%2;
    end
    always # 10000  select=!select;
    muxtwo m(.out(outw),.a(ain),.b(bin),.sl(select));
endmodule
