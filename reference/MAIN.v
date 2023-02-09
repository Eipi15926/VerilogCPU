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