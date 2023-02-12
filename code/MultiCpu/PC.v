module PC(clock,address_in,pc_reg);
    input clock;
    input [31:0] address_in;
    output reg[31:0] pc_reg;

    initial begin
        pc_reg <= 0;
    end
    always@(posedge clock)
    begin  
        pc_reg <= address_in;  
    end

endmodule
