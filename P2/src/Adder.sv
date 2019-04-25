module Adder(
	//input
	input clk,
	input rst,
	//input start,
	input [15:0]Number,
	input [15:0]Number2,
	input Enable,					//Enables the sum if its not enabled it gives the number 2 in the output
	//Output
	output [15:0]Sum_Output,			//Output of the sum
	output FLAG
);
//logic [15:0] SUM_Register;				//This register is the one that feed the Shift Register
//logic temp_FLG;

//always_comb//@(posedge clk or negedge rst) 
//	begin
//		if (!rst)
//			begin
//				SUM_Register <= {15{1'b0}};	
//				temp_FLG <= 0;
//			end
//	else
//		begin
//			if(Enable == 1'b1) 
//				begin
//					SUM_Register <= Number2 + Number;
//					temp_FLG <= 1;
//				end
//			else
//				SUM_Register <= SUM_Register;
//				temp_FLG <= 0;
	//	end
//end

//assign Sum_Output = SUM_Register;
//assign FLAG = temp_FLG;
assign Sum_Output = Number2 + Number;
assign FLAG = 0;
endmodule
