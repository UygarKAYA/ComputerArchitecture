`timescale 1ns / 1ps
module CombiCircuit(a,b,c,y);

	input a,b,c;
	output reg y;
	
	always@(*)begin
		if(c==1) begin
			y=1;
		end else if(a==1 & b==1) begin
			y=1;
		end else begin
			y=0;
		end	
	end
	
endmodule
