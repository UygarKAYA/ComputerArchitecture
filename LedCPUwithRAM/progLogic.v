module progLogic(clk, rst, switch, enter, dataWr, addrWr, wrEn);

input [7:0] switch;
input clk, rst, enter;
output reg wrEn;
output reg [7:0] addrWr;
output reg [15:0] dataWr;

reg state, stateNext;
reg wrEnNext, enterD;
reg [7:0] addrWrNext;
reg [7:0] number, numberNext;
reg [15:0] dataWrNext;

wire enter_pos;
assign enter_pos = enter & ~enterD;

always @(posedge clk) begin
	wrEn   <= #1 wrEnNext;
	state  <= #1 stateNext;
	number <= #1 numberNext;
	dataWr <= #1 dataWrNext;
	addrWr <= #1 addrWrNext;
	enterD <= #1 enter;
end

always @(*) begin
	wrEnNext   = wrEn;
	stateNext  = state;
	numberNext = number;
	dataWrNext = dataWr;
	addrWrNext = addrWr;
	if(rst) begin
		wrEnNext   = 0;
		stateNext  = 0;
		numberNext = 0;
		dataWrNext = 0;
		addrWrNext = 0;
	end else begin
		case(state)
			0:
			begin
				if(enter_pos == 0) begin
					wrEnNext = 0;
					stateNext = 0;
					dataWrNext = dataWr;
				end
				else if(enter_pos == 1) begin
					wrEnNext = 0;
					stateNext = 1;
					dataWrNext = switch;
					numberNext = switch;
				end
			end
			1:
			begin
				if(enter_pos == 0) begin
					wrEnNext = 0;
					stateNext = 1;
					dataWrNext = dataWr;
				end
				else if(enter_pos == 1) begin
					wrEnNext = 1;
					dataWrNext = {number, switch};
				end
				if(wrEn == 1) begin
					wrEnNext = 0;
					stateNext = 0;
					addrWrNext = addrWr + 1;
				end
			end
		endcase
	end
end

endmodule
