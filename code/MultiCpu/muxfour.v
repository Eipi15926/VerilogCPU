
module muxfour(I0,I1,I2,I3,ctrl,out);
    parameter width=32;
    input[width-1:0] I0,I1,I2,I3;
    input[2-1:0] ctrl;
    output reg[width-1:0] out;

    always@(I0 or I1 or I2 or ctrl) begin
        case(ctrl)
            2'b00:out=I0;
            2'b01:out=I1;
            2'b10:out=I2;
            2'b11:out=I3;
        endcase
    end
endmodule