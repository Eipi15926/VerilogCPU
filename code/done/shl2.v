module SHL2(src,dst);
    input [25:0]src;
    output [27:0]dst;
    parameter s2 = 2'b00;
    assign dst = {src, s2};
endmodule