module calc(clk, rst, validIn, dataIn, dataOut);
input clk, rst, validIn;
input  [7:0] dataIn;
output reg [7:0] dataOut;

reg [1:0] state, stateNext;
reg [7:0] number, numberNext, dataOutNext;
reg [2:0] operation, operationNext;

reg validIn_d; // validIn delayed by single clk cycle
wire validIn_pos; // positve edge of validIn

assign validIn_pos = validIn & ~validIn_d; // Use this as the "enter" button

always @(posedge clk) begin
    state       <= #1 stateNext;
    number      <= #1 numberNext;
    operation   <= #1 operationNext;
    dataOut     <= #1 dataOutNext;
    validIn_d   <= #1 validIn;
end

always @(*) begin
    stateNext     = state;
    numberNext    = number;
    operationNext = operation;
    dataOutNext   = dataOut;
    if(rst) begin
		stateNext = 0;
		numberNext = 0;
		dataOutNext = 0;
		operationNext = 0;
    end else begin
        case(state)
            0:
			begin 
				if(validIn_pos == 0) begin 
					dataOutNext = dataOut;
					stateNext = 0;
				end
				else if(validIn_pos == 1) begin
					dataOutNext = dataIn;
					numberNext = dataIn;
					stateNext = 1;
				end
			end
            1:
			begin 
				if(validIn_pos == 0) begin 
					dataOutNext = number;
					stateNext = 1;
				end
				else if((validIn_pos == 1) && (dataIn == 3 || dataIn == 4 || dataIn == 5)) begin
					stateNext = 0;
					case(dataIn) 
						3: dataOutNext = number * number;
						4: dataOutNext = number + 2;
						5: dataOutNext = number - 2;
					endcase
				end
				else if(validIn_pos == 1 && dataIn == 0 || dataIn == 1 || dataIn == 2) begin
					operationNext = dataIn;
					stateNext = 2;
				end
			end
            2:
			begin 
				if(validIn_pos == 0) begin
					dataOutNext = operation;
					stateNext = 2;
				end
				else if(validIn_pos == 1) begin
					stateNext = 0;
					case(operation)
						0: dataOutNext = number * dataIn;
						1: dataOutNext = number + dataIn;
						2: dataOutNext = number - dataIn;
					endcase
				end
			end 
        endcase
    end
end
endmodule
