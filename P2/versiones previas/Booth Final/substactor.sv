module substactor(
	//input
	input clk,
	input rst,
	//input start,
	input [15:0]Number,
	input [15:0]Number2,
	input Enable,					//Enables the sum if its not enabled it gives the number 2 in the output
	//Output
	output [15:0]Sub_Output,			//Output of the sum
	output FLAG
);

logic [15:0] SUB_Register;				//This register is the one that feed the Shift Register
logic temp_FLG;

always@(posedge clk) 
	begin
		if (!rst)
			begin
				SUB_Register <= {15{1'b0}};	
				temp_FLG <= 0;
			end
//	else if(start)
//		begin
//			SUM_Register <= {15{1'b0}};
//		end
//	else
//		begin
//			if(Enable == 1'b1) 
//				begin
					SUB_Register <= Number - Number2;
					temp_FLG <= 1;
//				end
//			else
//				begin
//					SUB_Register <= SUB_Register;
//					temp_FLG <= 0;
//				end
		end
//end

assign Sub_Output = SUB_Register;
assign FLAG = temp_FLG;
endmodule
