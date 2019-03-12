import Parameter_Definitions::*;

module Adder(
	//input
	input clk,
	input rst,
	input [2*NBits-1:0]Number,					//2N to N bits on the register example just the multiplicand part of the register carri Multiplicand Multiplier
	input Enable,					//Enables the sum if its not enabled it gives the number 2 in the output
	//Output
	output [2*NBits:0]Sum_Output			//Output of the sum
);
logic [2*NBits:0] SUM_Register;				//This register is the one that feed the Shift Register



always@(posedge clk or negedge rst) 
	begin
	//SUM_Register <= {2*NBits{1'b0}};

	if (!rst)
		begin
		if(Enable == 1'b1) 
				begin
				SUM_Register <= SUM_Register + Number;
				end
			
		end
	else 
		begin
			
								SUM_Register <= {2*NBits{1'b0}};

	end
end
assign Sum_Output = SUM_Register;

endmodule
