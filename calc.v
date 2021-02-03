`timescale 1ns / 1ps
module calc(clk, rst, valid, dataIn, out);
	input clk, rst, valid;
	input  [7:0] dataIn;
	output reg [7:0] out;

	reg [1:0] state, stateNext;
	reg [7:0] num1, num1Next,outNext;
	reg [2:0] operator, operatorNext;

	always @(posedge clk) begin
		state      <= #1 stateNext;
		num1       <= #1 num1Next;
		operator   <= #1 operatorNext;
		out        <= #1 outNext;
	end


	always @(*) begin
		stateNext    = state;
		num1Next     = num1;
		operatorNext = operator;
		outNext      = out;
		if(rst) begin
			stateNext    = 0;
			num1Next     = 0;
			operatorNext = 0;
			outNext  = 0;
		end else begin
			case(state)
			   0: begin
					if(valid) begin
						//takein num1Next from dataIn
						if (valid==0) begin
							outNext=0;
						end
						else if (valid==1) begin
							num1Next=dataIn;
						end	
						stateNext = 1;
					end	
				end
				1: begin
					if(valid) begin
						//takein operatorNext from dataIn
						if (valid==0) begin
							outNext=0;
						end
						else if (valid==1) begin
							operatorNext=dataIn;
						end	
						stateNext = 2;
					end
				end
				2: begin
					if(valid) begin
						stateNext = 0;
						case(operator)
							0: outNext = num1+dataIn; //for addition
							1: outNext = num1-dataIn; //for subtraction	
							2: outNext = num1*dataIn; //for multiplication
							3: outNext = num1*num1;   //for square operation
						endcase
					end
				end
			endcase
		end
	end
endmodule
