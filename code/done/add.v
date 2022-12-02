module add (a,b,sum,c);
    input[31:0] a,b;
    output[31:0] sum;
    output c;
    assign {c, sum} = a+b;
endmodule