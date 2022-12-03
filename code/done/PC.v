module PC(addr,new_addr);
    input [31:0] addr;
    output [31:0] new_addr;
    assign new_addr = addr + 32'd4;
endmodule