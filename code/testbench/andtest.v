`include "AND.v"
module t;
    reg clock,a,b;
    wire c;

    initial begin
        $dumpfile("and_test.vcd");  // vcd name   
        $dumpvars(0,t); // testbench module name
        clock =0;
        a=0;
        b=0;
    end
    always @(posedge clock) begin
        #1 a={$random}%2;
        #3 b={$random}%2;
    end
    always # 50 clock = ~clock;
    AND ad(a,b,c);
endmodule