module Multiplexor_RAM 
(
	input 	[3:0]	   Selector,
	output				RAM1,
	output				RAM2,
	output				RAM3,
	output				RAM4,
	output				RAM5,
	output				RAM6,
	output				RAM7,
	output				RAM8
	
);
reg RAM1_reg;
reg RAM2_reg;
reg RAM3_reg;
reg RAM4_reg;
reg RAM5_reg;
reg RAM6_reg;
reg RAM7_reg;
reg RAM8_reg;

always@(*)//ff @(posedge clk)
	begin
	RAM1_reg <= 0;
	RAM2_reg <= 0;
	RAM3_reg <= 0;
	RAM4_reg <= 0;
	RAM5_reg <= 0;
	RAM6_reg <= 0;
	RAM7_reg <= 0;
	RAM8_reg <= 0;
		if(Selector == 0)
			RAM1_reg <= 1;
		else if(Selector == 1)
			RAM2_reg <= 1;
		else if(Selector == 2)
			RAM3_reg <= 1;
		else if(Selector == 3)
			RAM4_reg <= 1;
		else if(Selector == 4)
			RAM5_reg <= 1;
		else if(Selector == 5)
			RAM6_reg <= 1;
		else if(Selector == 6)
			RAM7_reg <= 1;
		else if(Selector == 7)
			RAM8_reg <= 1;
		else
			begin
				RAM1_reg <= 0;
				RAM2_reg <= 0;
				RAM3_reg <= 0;
				RAM4_reg <= 0;
				RAM5_reg <= 0;
				RAM6_reg <= 0;
				RAM7_reg <= 0;
				RAM8_reg <= 0;
			end
		
	end
assign RAM1 = RAM1_reg;
assign RAM2 = RAM2_reg;
assign RAM3 = RAM3_reg;
assign RAM4 = RAM4_reg;
assign RAM5 = RAM5_reg;
assign RAM6 = RAM6_reg;
assign RAM7 = RAM7_reg;
assign RAM8 = RAM8_reg;
endmodule