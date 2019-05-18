module Mult_RAM 
(
	input 	[3:0]	   Selector,
	input		[3:0]		Proc,
	output				RAM1,
	output				RAM2
	
);
reg RAM1_reg;
reg RAM2_reg;

always@(*)//ff @(posedge clk)
	begin
	RAM1_reg <= 0;
	RAM2_reg <= 0;
		if(Selector == Proc)
			RAM1_reg <= 1;
		else if(Selector == (Proc+4))
			RAM2_reg <= 1;
		else
			begin
				RAM1_reg <= 0;
				RAM2_reg <= 0;
			end
		
	end
assign RAM1 = RAM1_reg;
assign RAM2 = RAM2_reg;
endmodule
