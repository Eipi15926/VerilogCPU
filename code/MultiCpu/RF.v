module RF(wd,rr1,rr2,wr,rd1,rd2,clk,w);
    input[31:0]wd;
    input[4:0] rr1,rr2,wr;
    input clk,w;
    output reg[31:0] rd1,rd2;

    reg [31:0]RD1,RD2;
    reg [31:0]RFReg[31:0];//寄存器号五位。RF内部有32个长度为32位的寄存器。
    reg [4:0]i;

    wire[31:0]show0;
    wire[31:0]show1;
    wire[31:0]show2;
    wire[31:0]show3;
    assign show3=RFReg[5'h03];
    assign show2=RFReg[5'h02];
    assign show1=RFReg[5'h01];
    assign show0=RFReg[5'h00];
    
    initial begin//将寄存器组初始化为0
        i=0;
        while(i<5'h10)
            begin
                RFReg[i]=0;
                i = i + 1;
            end
        RFReg[5'h02]=32'h0123;
    end
    always @(*)begin
        RD1 = RFReg[rr1];
        RD2 = RFReg[rr2];
        rd1=RD1;
        rd2=RD2; 
    end
    always @(posedge clk)begin        
        #0.1
        if (w)
            #0.1
            RFReg[wr] = wd;
    end

endmodule