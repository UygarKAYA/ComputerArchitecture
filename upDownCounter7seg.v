`timescale 1ns / 1ps
module upDownCounter7seg(upDown,reset,clk,seg,anode);
	input upDown;
	input reset;
	input clk;
	output reg [7:0] seg;
   	output reg [3:0] anode;
	
	reg [3:0] number,numberNext;
	
	//flip flops
	always@(posedge clk)begin
		number <= #1 numberNext;
	end
	
	//combinational circuit 1
	always@(*)begin
		numberNext = number;
		
		if(reset) begin
			numberNext = 0;
		end
		else begin
			//check if upDown is 1 then increase numberNext
			//if upDown is 0 then decrease numberNext
			
			if (upDown==1) begin
				numberNext=number+1;
			end	
				
			if (upDown==0) begin
				numberNext=number-1;
			end	
			
		end
		
	end
	
	//sevenSegdriver combinational circuit 2
	always@(*)begin
		anode = 4'b0111;
		seg = 8'b1111_1111;
		
		if(reset) begin
			anode= 4'b1111;
			seg = 8'b1111_1111;
		end
		else begin
			case(number)
				0: seg = 8'b11000000;//0
				1: seg = 8'b11111001;//1
				2: seg = 8'b10100100;//2
				3: seg = 8'b10110000;//3
				4: seg = 8'b10011001;//4
				5: seg = 8'b10010010;//5
				6: seg = 8'b10000010;//6
				7: seg = 8'b11111000;//7
				8: seg = 8'b10000000;//8
				9: seg = 8'b10010000;//9
				10: seg = 8'b10001000;//A
				11: seg = 8'b10000011;//b
				12: seg = 8'b11000110;//C
				13: seg = 8'b10100001;//d
				14: seg = 8'b10000110;//e
				15: seg = 8'b10001110;//f
				// in hexadecimal format 10,11,12,13,14,15 are a,b,c,d,e,f respectively
				default: seg = 8'b1111_1111;  //display nothing
			endcase
		end
	end

endmodule
