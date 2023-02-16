module PC(clk,w,d,q);
    input clk,w;
    input[31:0]d;
    output reg[31:0]q;
    reg[31:0]tmp;
    initial begin
        q=0;tmp=0;
    end
    always@(posedge clk)
    begin
        # 0.1
        if (w) begin
            q <= tmp;
        end
    end
    always @(d)begin
        tmp<=d;
    end
endmodule
