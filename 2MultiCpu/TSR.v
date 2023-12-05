module TSR (clk,D,Q);//A,B and MDR and ALU can use this
    parameter data_width=32;
    input clk;
    input[data_width-1:0] D;
    output reg[data_width-1:0] Q;

    always @(posedge clk) begin
        Q=D;
    end
endmodule