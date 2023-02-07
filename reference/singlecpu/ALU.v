`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/28 21:07:07
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module ALU(X,Y,Aluc,R,Z);//ALU代码
input [31:0]X,Y;
input [1:0]Aluc;
output [31:0]R;
output Z;
wire[31:0]d_as,d_and,d_or,d_and_or;
output Cout;
ADDSUB_32 as(X,Y,Aluc[0],d_as,Cout);//Cout自己加的
assign d_and=X&Y;
assign d_or=X|Y;
MUX2X32 select1(d_and,d_or,Aluc[0],d_and_or);
MUX2X32 seleted(d_as,d_and_or,Aluc[1],R);
assign Z=~|R;
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
