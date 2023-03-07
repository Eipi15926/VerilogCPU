module CU(clock, regwr,memrd,memwr,regdst,memtoreg,irwr,iord,pcwr,pcwrcond,alusrca,pcsrc,aluop,alusrcb,opcode);
    input clock;
    input[5:0]opcode;
    output reg regwr,memrd,memwr,regdst,memtoreg,irwr,iord,pcwr,pcwrcond,alusrca;
    output reg[1:0]pcsrc,aluop,alusrcb;
    reg[31:0]stage,stage1,stage2;
    initial begin 
        stage=0;
    end
    always @(posedge clock)begin
        {regwr,memrd,memwr,regdst,memtoreg,irwr,iord,pcwr,pcwrcond,alusrca,pcsrc,aluop,alusrcb}=16'bzzzz_zzzz_zzzz_zzzz;
        case(stage)
            4'b0000: begin
                memrd=1;alusrca=0;iord=0;irwr=1;alusrcb=2'b01;aluop=2'b00;pcwr=1;pcsrc=2'b00;
                stage<=4'd1;
            end
            4'b0001: begin
                alusrca=0;alusrcb=2'b11;aluop=2'b00;
                # 0.5//等待op_code信号稳定
                case(opcode)
                    6'b0: begin//R-type
                        stage1=4'd6;stage2=4'd7;
                    end
                    6'h23: begin//lw
                        stage1=4'd2;stage2=4'd3;
                    end
                    6'h2B: begin//sw
                        stage1=4'd2;stage2=4'd5;
                    end
                    6'h4: begin//beq
                        stage1=4'd8;stage2=4'd0;
                    end
                    6'h2: begin//j
                        stage1=4'd9;stage2=4'd0;
                    end
                endcase
                stage<=stage1;
            end
            4'd2: begin
                alusrca=1;alusrcb=2'b10;aluop=2'b00;
                stage<=stage2;
            end
            4'd3: begin
                memrd=1;iord=1;
                stage<=4'd4;
            end
            4'b0100:begin
                regdst=0;regwr=1;memtoreg=1;
                stage<=0;
            end
            4'd5: begin
                memwr=1;iord=1;
                stage<=0;
            end            
            4'd6: begin
                alusrca=1;alusrcb=2'b00;aluop=2'b10;
                stage<=4'd7;
            end
            4'd7: begin
                regdst=1;regwr=1;memtoreg=0;
                stage<=0;
            end
            4'd8: begin
                alusrca=1;alusrcb=2'b00;aluop=01;pcwrcond=1;pcsrc=01;
                stage<=0;
            end
            4'd9: begin
                pcwr=1;pcsrc=2'b10;
                stage<=0;
            end
        endcase
    end
endmodule