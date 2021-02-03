`timescale 1ns / 1ps
module CombiCircuit(a,b,c,y);
	input a,b,c;
	output reg y;
	
	always@(*)begin
		if (c==1)
			y=1;
		else 
		if (a==1 & b==1)
			y=1;
		else 
			y=0;
	end
endmodule
