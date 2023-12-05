module SHL2(src,dst);
    input [31:0]src;
    output [31:0]dst;
    parameter s2 = 2'b00;
    assign dst = {src[29:0], s2};
endmodule