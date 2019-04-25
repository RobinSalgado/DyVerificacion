module FIFO(
	//Inputs			
	input clk,
	input rst,	//Reset the counter
	input LOAD,
	input [15:0] DATA,				//Size of N-1 (number of bits to count -1) number of shifts
	//Output	
	output [15:0] DATA_OUT
);

reg [15:0] Register;

always @ (posedge clk or negedge rst) 
	begin
		if(!rst)  							//Restart the whole system
			Register <= {15*{1'b0}};	
		else
			begin
				if (LOAD)
					Register <= DATA;
				else
					Register <= Register;
			end
	end
	
endmodule