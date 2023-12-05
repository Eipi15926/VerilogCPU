module  CM(addr,tiny_inst);
parameter Tilen = 20;
    input[3:0]addr;
    output reg [Tilen-1:0]tiny_inst;
    initial begin
        tiny_inst=Rom[5'h00];
    end
    wire [Tilen-1:0]Rom[15:0];

    assign Rom[5'h00]=20'bx1xx_x101_x000_0001_0001;
    assign Rom[5'h01]=20'bxxxx_xxxx_x0xx_0011_1101;
    assign Rom[5'h02]=20'bxxxx_xxxx_x1xx_0010_1110;
    assign Rom[5'h03]=20'bx1xx_xx1x_xxxx_xxxx_0100;
    assign Rom[5'h04]=20'b1xx0_1xxx_xxxx_xxxx_0000;
    assign Rom[5'h05]=20'bxx1x_xx1x_xxxx_xxxx_0000;
    assign Rom[5'h06]=20'bxxxx_xxxx_x1xx_1000_0111;
    assign Rom[5'h07]=20'b1xx1_0xxx_xxxx_xxxx_0000;
    assign Rom[5'h08]=20'bxxxx_xxxx_1101_0100_0000;
    assign Rom[5'h09]=20'bxxxx_xxx1_xx10_xxxx_0000;

    always @(*)begin
        tiny_inst = Rom[addr];
    end
endmodule
module NEXT(opcode,opt,addr);
    input[5:0]opcode;
    input[3:0]opt;
    //output[3:0]addr;
    //assign addr=opt+opcode[3:0];
    output reg[3:0]addr;
    initial addr=0;
    always @(*)begin
        case(opt)
            4'b0000: addr=opt;
            4'b0001: addr=opt;
            4'b0010: addr=opt;
            4'b0011: addr=opt;
            4'b0100: addr=opt;
            4'b0101: addr=opt;
            4'b0110: addr=opt;
            4'b0111: addr=opt;
            4'b1000: addr=opt;
            4'b1001: addr=opt;
            4'b1101: begin//stage 1
                case(opcode)
                    6'b0:   addr=4'b0110;//R-type
                    6'h23:  addr=4'b0010;//lw
                    6'h2B:  addr=4'b0010;//sw
                    6'h4:   addr=4'b1000;//beq
                    6'h2:   addr=4'b1001;//j
                endcase
            end
            4'b1110: begin//stage 2
                case(opcode)
                    6'h23:  addr=4'b0011;//lw
                    6'h2B:  addr=4'b0101;//sw
                endcase
            end
        endcase
    end
    
endmodule

module CU(clock,regwr,memrd,memwr,regdst,memtoreg,irwr,iord,pcwr,pcwrcond,alusrca,pcsrc,aluop,alusrcb,opcode);
parameter Tilen = 20;
    input clock;
    input[5:0]opcode;
    output regwr,memrd,memwr,regdst,memtoreg,irwr,iord,pcwr,pcwrcond,alusrca;
    output [1:0]pcsrc,aluop,alusrcb;
    
    wire[3:0]addr,Opt;
    wire[Tilen-1:0]Ir;
    reg reset;

    assign regwr=uIR[19:19];
    assign memrd=uIR[18:18];
    assign memwr=uIR[17:17];
    assign regdst=uIR[16:16];
    assign memtoreg=uIR[15:15];
    assign irwr=uIR[14:14];
    assign iord=uIR[13:13];
    assign pcwr=uIR[12:12];
    assign pcwrcond=uIR[11:11];
    assign alusrca=uIR[10:10];
    assign pcsrc=uIR[9:8];
    assign aluop=uIR[7:6];
    assign alusrcb=uIR[5:4];
    assign Opt=uIR[3:0];

    CM Cm(addr,Ir);
    NEXT Next(opcode,Opt,addr);
    reg[Tilen-1:0]uIR;

    initial begin
        reset=1;
        #8;
        reset=0;
    end

    always @(posedge clock)begin
        if(reset)
            uIR=20'b01000101000000010001;
        else
            uIR=Ir;
    end

endmodule