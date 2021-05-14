module mem1R1W(clk, addrRd, dataRd, addrWr, dataWr, wrEn);

input clk;
input wrEn;
input [7:0] addrRd;
input [7:0] addrWr;
input [15:0] dataWr;
output reg [15:0] dataRd;

reg [15:0] array [0:255];

initial begin
    `include "init.v"
end

always@(posedge clk) begin
	dataRd <= array[addrRd];
	if(wrEn)
		array[addrWr] <= dataWr;
end

endmodule
