`timescale 1ns / 1ps
module tb_calc;

	reg clk;
	reg rst;
	reg valid;
	reg [7:0] dataIn;
	
	wire [7:0] out;

	//clock generation
	always #5 clk = !clk; //5ns 1, 5ns 0, so period is 10ns
	
	calc uut (.clk(clk), .rst(rst),.valid(valid), .dataIn(dataIn),.out(out));
	
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		valid = 0;
		#10;
		rst = 0;
		
		
		//addition testing 
		dataIn = 5;
		valid = 1;
		#10;
		dataIn = 0;
		valid = 1;
		#10;
		dataIn = 4;
		valid = 1;		
		#10;
		valid = 0;
		
		if(out==9)
			$display("Done! correct addition operation");
		else $display("Fail! wrong addition operation");
		
		//subtraction testing 
		dataIn = 10;
		valid = 1;
		#10;
		dataIn = 1;
		valid = 1;
		#10;
		dataIn = 3;
		valid = 1;		
		#10;
		valid = 0;
		
		if(out==7)
			$display("Done! correct subtraction operation");
		else $display("Fail! wrong subtraction operation");
		
		//multiplication testing 
		dataIn = 4;
		valid = 1;
		#10;
		dataIn = 2;
		valid = 1;
		#10;
		dataIn = 3;
		valid = 1;		
		#10;
		valid = 0;
		
		if(out==12)
			$display("Done! correct multiplication operation");
		else $display("Fail! wrong multiplication operation");
		
		
		//square operation testing 
		dataIn = 2;
		valid = 1;
		#10;
		dataIn = 3;
		valid = 1;
		#10;
		dataIn = 2;
		valid = 1;		
		#10;
		valid = 0;
		
		if(out==4)
			$display("Done! correct square operation");
		else $display("Fail! wrong square operation");
		
		#5;
		$finish;
	end
      
endmodule

