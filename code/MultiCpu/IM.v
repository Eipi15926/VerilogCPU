module IM(addr,w,r,wd,rd);/*input : address in IM, output : instruction in address addr*/
    input [31:0] addr,wd;
    input w,r;
    output reg[31:0] rd;
    reg[31:0]Rom[31:0];
    initial begin
        Rom[5'h00]=32'b00000000001000100001100000011010;//add $1,$2,$3
        Rom[5'h01]=32'b00000000011000100001100000011010;//add $3,$2,$3
        Rom[5'h02]=32'b00001000000000000000000000000000;//J 0(correct)
    end
    always @(*)begin
        if (r)
            rd = Rom[addr[6:2]];
    end
    always @(*)begin
        if (w)
            Rom[addr[6:2]]=wd;
    end
endmodule
