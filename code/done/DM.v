module DM(R,W,Addr,W_data,R_data,clk);
	input clk;
	input R,W;
	input[addr_width-1:0] Addr;
	input[data_width-1:0] W_data;
	output reg[data_width-1:0] R_data;//use reg for writing "if" later
	reg[data_width-1:0] mem[(1<<addr_width)-1:0];
	parameter addr_width=16;
	parameter data_width=32;
	
	initial begin
		//just for testing: mem[i]=i
		for (integer i=1;i<(1<<addr_width);i=i+1)
			mem[i]=i;
	end

	always @(posedge clk) begin
		if (R) begin
			R_data=mem[Addr];//does <= and = matters?
		end
		if (W) begin
			mem[Addr]<=W_data;//does <= and = matters?
		end
	end
endmodule
