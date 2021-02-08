`timescale 1ns / 1ps
module tb_CombiCircuit();
	
	// inputs
	reg a,b,c;
	
	// outputs
	wire y;
	
	// instantiate the unit under test (UTT)
	CombiCircuit uut (.a(a), .b(b), .c(c), .y(y));
	
	// initialize the inputs
	initial begin 
	
	a = 0;
	b = 0;
	c = 0;
	
	#50 // waiting 50 ns. ns--> Nano Second.
	
	a = 0;
	b = 0;
	c = 1;
	
	#50
	
	a = 1;
	b = 0;
	c = 0;
	
	#50
	
	a = 1;
	b = 1;
	c = 0;
	
	#50	
	
	$finish; // Stop the simulation
	end 
endmodule
