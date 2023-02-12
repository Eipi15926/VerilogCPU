module PC(clk,w,d,q);
    input clk,w;
    input[31:0]d;
    output reg[31:0]q;
    initial q=0;
    always@(posedge clk)
    begin
        if (w) begin
            q <= d;
        end
    end
endmodule
