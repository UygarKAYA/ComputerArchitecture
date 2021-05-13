module LedCPUcore( 
	clk,
	rst,
	addrRd,
	dataRd,
	outPattern
    );
input clk,rst; 
input [15:0] dataRd;
output reg [7:0] addrRd;
output reg [7:0] outPattern; 

wire enable;

parameter FREQ_DELAY = 50_000_000/16;
Delay #(FREQ_DELAY) dly(.rst(rst), .mclk(clk), .out(enable)); 

reg state, stateNext;
reg [7:0] addrRdNext;
reg [7:0] outPatternNext;
reg [7:0] processTime, processTimeNext;

always@(posedge clk) begin
	state  <= #1 stateNext;
	addrRd <= #1 addrRdNext;
	outPattern  <= #1 outPatternNext;
	processTime <= #1 processTimeNext;
end

always@(*)begin
	stateNext  = state;
	addrRdNext = addrRd;
	outPatternNext  = outPattern;
	processTimeNext = processTime;
	if(rst)begin
		stateNext  = 0;
		addrRdNext = 0;
		outPatternNext  = 0;
		processTimeNext = 0;
	end
	else begin
		if(dataRd[7:0] != 0) begin
			outPatternNext = dataRd[15:8];
			if(enable == 1)
				processTimeNext = processTime + 1;
			if(processTime == dataRd[7:0]) begin
				processTimeNext = 0;
				addrRdNext = addrRd + 1;
			end
		end
		else if(dataRd[7:0] == 0) begin
			addrRdNext = dataRd[15:8];
		end
	end
end
endmodule
