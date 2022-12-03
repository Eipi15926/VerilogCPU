module t;
    reg [31:0] ain,bin,select;
    reg [25:0]intest;
    reg clock;
    wire[27:0] outtest;

    initial begin
        $dumpfile("shl2_test.vcd");  // vcd name   
        $dumpvars(0,t); // testbench module name
        intest=23;
        bin=34;
        select=0;
        clock=0;
        
    end

    always # 50 clock = ~clock;
    always # 10000  select=!select;

    shl2 shlt(.src(intest),.dst(outtest));
endmodule
