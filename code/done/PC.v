module PC(CLK,Address_in,Address_out);
    input CLK;
    input [31:0] Address_in;
    output reg [31:0] Address_out;

    always@(posedge CLK)
    begin
        Address_out<=Address_in;
    end

endmodule
