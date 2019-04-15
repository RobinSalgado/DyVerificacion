module Multiplexor_D 
(
	// Input 
//	input 				clk,
	input 				Selector,
	input 	[15:0]	REG1,
	input 	[15:0]	REG2,
	// Output 
	output	[15:0]	Output
);
reg [15:0] out_reg;
always_comb//ff @(posedge clk)
	begin
		if(Selector)
			out_reg = REG1;
		else
			out_reg = REG2;
	end
assign Output = out_reg;
endmodule