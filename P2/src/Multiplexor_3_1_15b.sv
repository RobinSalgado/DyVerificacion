
module Multiplexor_3_1_15b
(
	// Input 
	input [15:0] REG1,
	input [15:0] REG2,
	input [15:0] REG3,
	input [1:0]Selector,
	input Enable,
	// Output 
	output [15:0] Output
);

logic [15:0] Reg_Output;

always_comb
	begin
		Reg_Output = {15{1'b0}};
		if(Enable ==1)
			begin
				if (Selector == 0)
					begin
						Reg_Output = REG1;
					end
				else if (Selector == 1)
					begin
						Reg_Output = REG2;
					end
				else if (Selector == 2)
					begin
						Reg_Output = REG3;
					end
				else
						Reg_Output = {15{1'b0}};
			end
		else
			begin
				Reg_Output = {15{1'b0}};
			end
	end
	
assign Output = Reg_Output;

endmodule
