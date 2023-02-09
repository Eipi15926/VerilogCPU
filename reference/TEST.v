module CLA_4(X, Y, Cin, S, Cout);
input [3:0] X;
input [3:0] Y;
input Cin;
output [3:0] S;
output Cout;
and get_0_0_0(tmp_0_0_0, X[0], Y[0]);
or get_0_0_1(tmp_0_0_1, X[0], Y[0]);
and get_0_1_0(tmp_0_1_0, X[1], Y[1]);
or get_0_1_1(tmp_0_1_1, X[1], Y[1]);
and get_0_2_0(tmp_0_2_0, X[2], Y[2]);
or get_0_2_1(tmp_0_2_1, X[2], Y[2]);
and get_0_3_0(tmp_0_3_0, X[3], Y[3]);
or get_0_3_1(tmp_0_3_1, X[3], Y[3]);
and get_1_0_0(tmp_1_0_0, ~tmp_0_0_0, tmp_0_0_1);
xor getS0(S0, tmp_1_0_0, Cin);
and get_1_1_0(tmp_1_1_0, ~tmp_0_1_0, tmp_0_1_1);
not get_1_1_1(tmp_1_1_1, tmp_0_0_0);
nand get_1_1_2(tmp_1_1_2, Cin, tmp_0_0_1);
nand get_2_0_0(tmp_2_0_0, tmp_1_1_1, tmp_1_1_2);
xor getS1(S1, tmp_1_1_0, tmp_2_0_0);
and get_1_2_0(tmp_1_2_0, ~tmp_0_2_0, tmp_0_2_1);
not get_1_2_1(tmp_1_2_1, tmp_0_1_0);
nand get_1_2_2(tmp_1_2_2, tmp_0_1_1, tmp_0_0_0);
nand get_1_2_3(tmp_1_2_3, tmp_0_1_1, tmp_0_0_1, Cin);
nand get_2_1_0(tmp_2_1_0, tmp_1_2_1, tmp_1_2_2, tmp_1_2_3);
xor getS2(S2, tmp_1_2_0, tmp_2_1_0);
and get_1_3_0(tmp_1_3_0, ~tmp_0_3_0, tmp_0_3_1);
not get_1_3_1(tmp_1_3_1, tmp_0_2_0);
nand get_1_3_2(tmp_1_3_2, tmp_0_2_1, tmp_0_1_0);
nand get_1_3_3(tmp_1_3_3, tmp_0_2_1, tmp_0_1_1, tmp_0_0_0);
nand get_1_3_4(tmp_1_3_4, tmp_0_2_1, tmp_0_1_1, tmp_0_0_1, Cin); 
nand get_2_2_0(tmp_2_2_0, tmp_1_3_1, tmp_1_3_2, tmp_1_3_3, tmp_1_3_4);
xor getS3(S3, tmp_1_3_0, tmp_2_2_0);
not get_1_4_0(tmp_1_4_0, tmp_0_3_0);
nand get_1_4_1(tmp_1_4_1, tmp_0_3_1, tmp_0_2_0);
nand get_1_4_2(tmp_1_4_2, tmp_0_3_1, tmp_0_2_1, tmp_0_1_0);
nand get_1_4_3(tmp_1_4_3, tmp_0_3_1, tmp_0_2_1, tmp_0_1_1, tmp_0_0_0);
nand get_1_4_4(tmp_1_4_4, tmp_0_3_1, tmp_0_2_1, tmp_0_1_1, tmp_0_0_1, Cin);
nand getCout(Cout, tmp_1_4_0, tmp_1_4_1, tmp_1_4_2, tmp_1_4_3,tmp_1_4_4);
assign S = {S3,S2,S1,S0};
endmodule

module CLA_32(X, Y, Cin, S, Cout);
input [31:0] X, Y; 
input Cin;   
output [31:0] S;
output Cout;
wire Cout0, Cout1, Cout2, Cout3, Cout4, Cout5, Cout6;    
CLA_4 add0 (X[3:0], Y[3:0], Cin, S[3:0], Cout0);
CLA_4 add1 (X[7:4], Y[7:4], Cout0, S[7:4], Cout1);
CLA_4 add2 (X[11:8], Y[11:8], Cout1, S[11:8], Cout2);
CLA_4 add3 (X[15:12], Y[15:12], Cout2, S[15:12], Cout3);
CLA_4 add4 (X[19:16], Y[19:16], Cout3, S[19:16], Cout4);
CLA_4 add5 (X[23:20], Y[23:20], Cout4, S[23:20], Cout5);
CLA_4 add6 (X[27:24], Y[27:24], Cout5, S[27:24], Cout6);
CLA_4 add7 (X[31:28], Y[31:28], Cout6, S[31:28], Cout);
endmodule

module PCadd4(PC_o,PCadd4);
input [31:0] PC_o;//偏移量
output [31:0] PCadd4;//新指令地址
CLA_32 cla32(PC_o,4,0, PCadd4, Cout);
endmodule

module PC(Clk,Reset,Result,Address);  
input Clk;//时钟
input Reset;//是否重置地址。0-初始化PC，否则接受新地址       
input[31:0] Result;
output reg[31:0] Address;
//reg[31:0] Address;
initial begin
Address  <= 0;
end
always @(posedge Clk or negedge Reset)  
begin  
if (!Reset) //如果为0则初始化PC，否则接受新地址
begin  
Address <= 0;  
end  
else   
begin
Address =  Result;  
end  
end  
endmodule

module INSTMEM(Addr,Inst);//指令存储器
input[31:0]Addr;
//input InsMemRW;//状态为'0'，写指令寄存器，否则为读指令寄存器
output[31:0]Inst;
wire[7:0]Rom[31:0];
assign Rom[5'h00]=32'h20010008;//addi $1,$0,8 $1=8
assign Rom[5'h01]=32'h3402000C;//ori $2,$0,12 $2=12
assign Rom[5'h02]=32'h00221820;//add $3,$1,$2 $3=20
assign Rom[5'h03]=32'h00412022;//sub $4,$2,$1 $4=4
assign Rom[5'h04]=32'h00222824;//and $5,$1,$2
assign Rom[5'h05]=32'h00223025;//or $6,$1,$2
assign Rom[5'h06]=32'h14220002;//bne $1,$2,2
assign Rom[5'h07]=32'hXXXXXXXX;
assign Rom[5'h08]=32'hXXXXXXXX;
assign Rom[5'h09]=32'h10220002;// beq $1,$2,2
assign Rom[5'h0A]=32'h0800000D;// J 0D 
assign Rom[5'h0B]=32'hXXXXXXXX;
assign Rom[5'h0C]=32'hXXXXXXXX;
assign Rom[5'h0D]=32'hAD02000A;// sw $2 10($8) memory[$8+10]=12
assign Rom[5'h0E]=32'h8D04000A;//lw $4 10($8) $4=12
assign Rom[5'h0F]=32'h10440003;//beq $2,$4,3
assign Rom[5'h10]=32'hXXXXXXXX;
assign Rom[5'h11]=32'hXXXXXXXX;
assign Rom[5'h12]=32'hXXXXXXXX;
assign Rom[5'h13]=32'h30470009;//andi $2,9,$7
assign Rom[5'h14]=32'hXXXXXXXX;
assign Rom[5'h15]=32'hXXXXXXXX;
assign Rom[5'h16]=32'hXXXXXXXX;
assign Rom[5'h17]=32'hXXXXXXXX;
assign Rom[5'h18]=32'hXXXXXXXX;
assign Rom[5'h19]=32'hXXXXXXXX;
assign Rom[5'h1A]=32'hXXXXXXXX;
assign Rom[5'h1B]=32'hXXXXXXXX;
assign Rom[5'h1C]=32'hXXXXXXXX;
assign Rom[5'h1D]=32'hXXXXXXXX;
assign Rom[5'h1E]=32'hXXXXXXXX;
assign Rom[5'h1F]=32'hXXXXXXXX;
assign Inst=Rom[Addr[6:2]];
endmodule
module DATAMEM(Addr,Din,Clk,We,Dout);
input[31:0]Addr,Din;
input Clk,We;
output[31:0]Dout;
reg[31:0]Ram[31:0];
assign Dout=Ram[Addr[6:2]];
always@(posedge Clk)begin
if(We)Ram[Addr[6:2]]<=Din;
end
integer i;
initial begin
for(i=0;i<32;i=i+1)
Ram[i]=0;
end
endmodule
module SHIFTER32_L2(X,Sh);
input [31:0] X;
output [31:0] Sh;
parameter z=2'b00;
assign Sh={X[29:0],z};
endmodule
module SHIFTER_COMBINATION(X,PCADD4,Sh);
input [26:0] X;
input [31:0] PCADD4;
output [31:0] Sh;
parameter z=2'b00;
assign Sh={PCADD4[3:0],X[26:0],z};
endmodule
module MUX4X32 (A0, A1, A2, A3, S, Y);
input [31:0] A0, A1, A2, A3;
input [1:0] S;
output [31:0] Y;
function [31:0] select;
input [31:0] A0, A1, A2, A3;
input [1:0] S;
case(S)
2'b00: select = A0;
2'b01: select = A1;
2'b10: select = A2;
2'b11: select = A3;
endcase
endfunction
assign Y = select (A0, A1, A2, A3, S);
endmodule

module MUX2X5(A0,A1,S,Y);
input [4:0] A0,A1;
input S;
output [4:0] Y;
function [4:0] select;
input [4:0] A0,A1;
input S;
case(S)
0:select=A0;
1:select=A1;
endcase
endfunction
assign Y=select(A0,A1,S);
endmodule

module EXT16T32 (X, Se, Y);
input [15:0] X;
input Se;
output [31:0] Y;
wire [31:0] E0, E1;
wire [15:0] e = {16{X[15]}};
parameter z = 16'b0;
assign E0 = {z, X};
assign E1 = {e, X};
MUX2X32 i(E0, E1, Se, Y);
endmodule   
module MUX2X32(A0,A1,S,Y);
input [31:0] A0,A1;
input S;
output [31:0] Y;
function [31:0] select;
input [31:0] A0,A1;
input S;
case(S)
0:select=A0;
1:select=A1;
endcase
endfunction
assign Y=select(A0,A1,S);
endmodule
module CONUNIT(Op,Func,Z,Regrt,Se,Wreg,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg);
input[5:0]Op,Func;
input Z;
output Regrt,Se,Wreg,Aluqb,Wmem,Reg2reg;
output[1:0]Pcsrc,Aluc;
wire R_type=~|Op;
wire I_add=R_type&Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&~Func[0];
wire I_sub=R_type&Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0];
wire I_and=R_type&Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&~Func[0];
wire I_or=R_type&Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&Func[0];
wire I_addi=~Op[5]&~Op[4]&Op[3]&~Op[2]&~Op[1]&~Op[0];
wire I_andi=~Op[5]&~Op[4]&Op[3]&Op[2]&~Op[1]&~Op[0];
wire I_ori=~Op[5]&~Op[4]&Op[3]&Op[2]&~Op[1]&Op[0];
wire I_lw=Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0];
wire I_sw=Op[5]&~Op[4]&Op[3]&~Op[2]&Op[1]&Op[0];
wire I_beq=~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&~Op[0];
wire I_bne=~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&Op[0];
wire I_J=~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&~Op[0];
assign Regrt=I_addi|I_andi|I_ori|I_lw|I_sw|I_beq|I_bne|I_J;
assign Se=I_addi|I_lw|I_sw|I_beq|I_bne;
assign Wreg=I_add|I_sub|I_and|I_or|I_addi|I_andi|I_ori|I_lw;
assign Aluqb=I_add|I_sub|I_and|I_or|I_beq|I_bne|I_J;
assign Aluc[1]=I_and|I_or|I_andi|I_ori;
assign Aluc[0]=I_sub|I_or|I_ori|I_beq|I_bne;
assign Wmem=I_sw;
assign Pcsrc[1]=I_beq&Z|I_bne&~Z|I_J;
assign Pcsrc[0]=I_J;
assign Reg2reg=I_add|I_sub|I_and|I_or|I_addi|I_andi|I_ori|I_sw|I_beq|I_bne|I_J;
endmodule    
module REGFILE(Ra,Rb,D,Wr,We,Clk,Clrn,Qa,Qb);
input [4:0]Ra,Rb,Wr;
input [31:0]D;
input We,Clk,Clrn;
output [31:0]Qa,Qb;
wire [31:0]Y_mux,Q31_reg32,Q30_reg32,Q29_reg32,Q28_reg32,Q27_reg32,Q26_reg32,Q25_reg32,Q24_reg32,Q23_reg32,Q22_reg32,Q21_reg32,Q20_reg32,Q19_reg32,Q18_reg32,Q17_reg32,Q16_reg32,Q15_reg32,Q14_reg32,Q13_reg32,Q12_reg32,Q11_reg32,Q10_reg32,Q9_reg32,Q8_reg32,Q7_reg32,Q6_reg32,Q5_reg32,Q4_reg32,Q3_reg32,Q2_reg32,Q1_reg32,Q0_reg32;
DEC5T32E dec(Wr,We,Y_mux);
REG32  A(D,Y_mux,Clk,Clrn,Q31_reg32,Q30_reg32,Q29_reg32,Q28_reg32,Q27_reg32,Q26_reg32,Q25_reg32,Q24_reg32,Q23_reg32,Q22_reg32,Q21_reg32,Q20_reg32,Q19_reg32,Q18_reg32,Q17_reg32,Q16_reg32,Q15_reg32,Q14_reg32,Q13_reg32,Q12_reg32,Q11_reg32,Q10_reg32,Q9_reg32,Q8_reg32,Q7_reg32,Q6_reg32,Q5_reg32,Q4_reg32,Q3_reg32,Q2_reg32,Q1_reg32,Q0_reg32);
MUX32X32 select1(Q0_reg32,Q1_reg32,Q2_reg32,Q3_reg32,Q4_reg32,Q5_reg32,Q6_reg32,Q7_reg32,Q8_reg32,Q9_reg32,Q10_reg32,Q11_reg32,Q12_reg32,Q13_reg32,Q14_reg32,Q15_reg32,Q16_reg32,Q17_reg32,Q18_reg32,Q19_reg32,Q20_reg32,Q21_reg32,Q22_reg32,Q23_reg32,Q24_reg32,Q25_reg32,Q26_reg32,Q27_reg32,Q28_reg32,Q29_reg32,Q30_reg32,Q31_reg32,Ra,Qa);
MUX32X32 select2(Q0_reg32,Q1_reg32,Q2_reg32,Q3_reg32,Q4_reg32,Q5_reg32,Q6_reg32,Q7_reg32,Q8_reg32,Q9_reg32,Q10_reg32,Q11_reg32,Q12_reg32,Q13_reg32,Q14_reg32,Q15_reg32,Q16_reg32,Q17_reg32,Q18_reg32,Q19_reg32,Q20_reg32,Q21_reg32,Q22_reg32,Q23_reg32,Q24_reg32,Q25_reg32,Q26_reg32,Q27_reg32,Q28_reg32,Q29_reg32,Q30_reg32,Q31_reg32,Rb,Qb);
endmodule

module ALU(X,Y,Aluc,R,Z);
input [31:0]X,Y;
input [1:0]Aluc;
output [31:0]R;
output Z;
wire[31:0]d_as,d_and,d_or,d_and_or;
ADDSUB_32 as(X,Y,Aluc[0],d_as);
assign d_and=X&Y;
assign d_or=X|Y;
MUX2X32 select1(d_and,d_or,Aluc[0],d_and_or);
MUX2X32 seleted(d_as,d_and_or,Aluc[1],R);
assign Z=~|R;
endmodule

module MAIN(Clk,Reset,Addr,Inst,Qa,Qb,ALU_R,NEXTADDR,D);
input Clk,Reset;
output [31:0] Inst,NEXTADDR,ALU_R,Qb,Qa,Addr,D;

wire [31:0]Result,PCadd4,EXTIMM,InstL2,EXTIMML2,D,Y,Dout,mux4x32_2,R;
wire Z,Regrt,Se,Wreg,Aluqb,Reg2reg,Cout,Wmem;
wire [1:0]Aluc,Pcsrc;
wire [4:0]Wr;

PC pc(Clk,Reset,Result,Addr);
PCadd4 pcadd4(Addr,PCadd4);
INSTMEM instmem(Addr,Inst);

CONUNIT conunit(Inst[31:26],Inst[5:0],Z,Regrt,Se,Wreg,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg);
MUX2X5 mux2x5(Inst[15:11],Inst[20:16],Regrt,Wr);
EXT16T32 ext16t32(Inst[15:0],Se,EXTIMM);
SHIFTER_COMBINATION shifter1(Inst[26:0],PCadd4,InstL2);
SHIFTER32_L2 shifter2(EXTIMM,EXTIMML2);
REGFILE regfile(Inst[25:21],Inst[20:16],D,Wr,Wreg,Clk,Reset,Qa,Qb);
MUX2X32 mux2x321(EXTIMM,Qb,Aluqb,Y);
ALU alu(Qa,Y,Aluc,R,Z);
DATAMEM datamem(R,Qb,Clk,Wmem,Dout);
MUX2X32 mux2x322(Dout,R,Reg2reg,D);
CLA_32 cla_32(PCadd4,EXTIMML2,0,mux4x32_2, Cout);
MUX4X32 mux4x32(PCadd4,0,mux4x32_2,InstL2,Pcsrc,Result);
assign NEXTADDR=Result;
assign ALU_R=R;
endmodule

module testbench;
    reg Reset;
    wire [31:0] Addr,Inst,Qa,Qb,ALU_R,NEXTADDR;

    initial begin
        $dumpfile("ref_test.vcd");  // vcd name   
        $dumpvars(0,testbench); // testbench module name
        ain=23;
        bin=34;
        select=0;
        clock=0;
        tet = 1;
    end
    always # 50 clock = ~clock;
    always @(posedge clock) begin
        #1 ain={$random}%2;
        #3 bin={$random}%2;
    end
    
    MAIN uut(
        .Clk(clock),
        .Reset(Reset),
        .Addr(Addr),
        .Inst(Inst),
        .Qa(Qa),
        .Qb(Qb),
        .ALU_R(ALU_R),
        .NEXTADDR(NEXTADDR),
        .D(D)
    );
endmodule