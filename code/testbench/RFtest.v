`include "RF.v"
module t;
    reg clock,Regwr;
    wire[31:0] Wd=32'h01;
    wire[4:0] Rr1=5'h02,Rr2=5'h03,Wr=5'h04;
    wire[31:0]Rd1,Rd2;

    initial begin
        $dumpfile("RF_test.vcd");  // vcd name   
        $dumpvars(0,t); // testbench module name
        clock =0;
        Regwr = 0;
    end
    always # 50 clock = ~clock;
    RF rf(.wd(Wd),.rr1(Rr1),.rr2(Rr2),.wr(Wr),.rd1(Rd1),.rd2(Rd2),.clk(clock),.regwr(Regwr));
endmodule