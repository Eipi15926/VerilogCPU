module RF(wd,rr1,rr2,wr,rd1,rd2,clk,regwr);
    input[31:0]wd;
    input[4:0] rr1,rr2,wr;
    input clk,regwr;
    output reg[31:0] rd1,rd2;

    reg [31:0]RD1,RD2;
    reg [31:0]RFReg[31:0];//寄存器号五位。RF内部有32个长度为32位的寄存器。
    reg [4:0]i;
    reg [31:0]show;

    initial begin//将寄存器组初始化为0
        i=0;
        while(i<5'h10)
            begin
                RFReg[i]=32'h0;
                i = i + 1;
            end
        RFReg[5'h02]=32'h0123;
    end

    always @(posedge clk)begin
        # 0.1
        RD1 = RFReg[rr1];
        RD2 = RFReg[rr2];
        # 0.1
        if (regwr)
            begin
                RFReg[wr] = wd;
                //RD1 = RFReg[WR];
                //RD2 = WD;
            end
        rd1=RD1;
        rd2=RD2;
        show = RFReg[5'h03];
    end

endmodule