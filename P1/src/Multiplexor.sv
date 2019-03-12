import Parameter_Definitions::*;

module Multiplexor
(
	// Input 
	input [2*NBits-1:0] Reg_Part1,

	input [2*NBits-1:0] CompA2,
	input Selector,
	input Enable,
	// Output 
	output [2*NBits-1:0] Output
);

logic [2*NBits-1:0] Reg_Output;

always_comb
	begin
		Reg_Output = {2*NBits{1'b0}};
		if(Enable ==1)
			begin
				if (Selector == 0)
					begin
						Reg_Output = Reg_Part1;
					end
				else 
					begin
						Reg_Output = CompA2;
					end
			end
		else
			begin
				Reg_Output = {2*NBits{1'b0}};
			end
	end
	
assign Output = Reg_Output;

endmodule
