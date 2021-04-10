module knightRiderLR(clk, rst, dataOut);

	input clk, rst;
	output reg [7:0] dataOut;
	
	reg [21:0] counter, counterNext;
	reg [ 7:0] dataOutNext;
	reg  flag,flagNext;
	
	parameter COUNT = 22'hF;
	
	// registers
	always @(posedge clk) begin
		counter <=  counterNext;
		dataOut <=  dataOutNext;
		flag <=  flagNext;
	end
	
	always @(*) begin
		dataOutNext = dataOut;
		counterNext = counter;
		flagNext = flag;
		if(rst) begin
			dataOutNext = 8'b10000001;
			counterNext = 0;
			flagNext = 0;
		end
		else if(counter == COUNT -1) begin
			if(flag == 0) begin 
				dataOutNext = {dataOut[4],dataOut[7:5],dataOut[2:0],dataOut[4]}; 
				if(dataOut[5] == 1)
					flagNext = 1;
				else
					flagNext = 0;
			end
			else if(flag == 1) begin 
				dataOutNext = {dataOut[6:4],dataOut[7],dataOut[0],dataOut[3:1]}; 
				if(dataOut[6] == 1)
					flagNext = 0;
				else
					flagNext = 1;
			end
			counterNext = 0;
		end
		else begin
			counterNext = counter +1;
		end
	end
endmodule

