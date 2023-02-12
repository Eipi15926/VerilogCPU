module IR(w,clk,d,inst);
    input w,clk;
    input[31:0]d;
    output reg[31:0]inst;
    always @(posedge clk)begin
        if(w)
            inst=d;
    end
endmodule