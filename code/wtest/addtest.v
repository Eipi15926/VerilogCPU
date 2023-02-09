module add (a,b,sum,c);
    input[31:0] a,b;
    output [31:0] sum;
    output c;
    assign {c, sum} = a+b;
endmodule
module t;
    reg [31:0] ain,bin,select;
    reg clock;
    wire[31:0] sumtest;
    wire ctest;

    initial begin
        $dumpfile("add_test.vcd");  // vcd name   
        $dumpvars(0,t); // testbench module name
        ain=23;
        bin=34;
        select=0;
        clock=0;
    end
    always # 50 clock = ~clock;
    always @(posedge clock) begin
        #1 ain={$random}%2;
        #3 bin={$random}%2;
    end
    always # 10000  select=!select;
    add ad161(.a(ain),.b(bin),.sum(sumtest),.c(ctest));
endmodule
