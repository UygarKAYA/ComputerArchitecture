`timescale 1ns / 1ps
module tb_upDownCounter7seg();

	reg clk;
	reg rst;
	reg upDown;
	
	wire [3:0] anode;
	wire [7:0] seg;

	//clock generation
	always #5 clk = !clk; //5ns 1, 5ns 0, so period is 10ns
	
	upDownCounter7seg uut (.clk(clk), .reset(rst), .upDown(upDown), 
			       .anode(anode),.seg(seg));

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		upDown = 0;

		// Wait 100 ns for reset to finish
		#100;
      		rst = 0;
		upDown = 1; //6 times increase
		#60; 
		upDown = 0; //3 times decrease
		#30;
		upDown = 1; //7 times increase
		#70;
		upDown = 0; //2 times decrease
		#20;
		upDown = 1; //7 times increase
		#70;
		if(seg==8'b10001110) //nuber is 15, seg 8'b10001110
			$display("Done!");
		else $display("Fail!");
		#5;
		$finish;
	end
      
endmodule

