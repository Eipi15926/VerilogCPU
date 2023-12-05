module PC(Clock,Reset,Address_in,Pc_reg);
    input Clock;
    input Reset;
    input [31:0] Address_in;
    output reg[31:0] Pc_reg;

    initial begin
        Pc_reg <= 0;
    end
    always@(posedge Clock or posedge Reset)
    begin
        if (Reset) //如果为0则初始化PC，否则接受新地址
        begin  
            Pc_reg <= 0;  
        end  
        else   
        begin
            Pc_reg <= Address_in;  
        end
    end
endmodule
