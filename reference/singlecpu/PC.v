`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/28 22:00:56
// Design Name: 
// Module Name: PC
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


module PC(Clk,Reset,Result,Address);  
input Clk;//时钟
input Reset;//是否重置地址。0-初始化PC，否则接受新地址       
input[31:0] Result;
output reg[31:0] Address;
//reg[31:0] Address;
initial begin
	Address  <= 0;
end
always @(posedge Clk or negedge Reset)  //将时钟信号的上升沿和控制信号Reset作为敏感变量，使得pc在上升沿的时候发生改变或被重置。
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

module PCadd4(PC_o,PCadd4);
input [31:0] PC_o;//偏移量
output [31:0] PCadd4;//新指令地址
output Cout;
assign in=0;//in=0
CLA_32 cla32(PC_o,4,in,PCadd4,Cout);
//CLA_32 cla32(PC_o,4,0,PCadd4,Cout);
endmodule
