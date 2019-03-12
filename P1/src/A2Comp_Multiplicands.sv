import Parameter_Definitions::*;

module A2Comp_Multiplicands(
	//inputs	
	input clk,
	input rst,
	input start,
	input  [NBits-1:0]Number_to_2_complement,		
	//outputs					
	output [NBits-1:0]	Result					//I need better names	
);

reg [NBits-1:0]Number;

always_ff@(posedge clk or negedge rst) 
	begin
	if (!rst)
		begin
			Number <= {NBits{1'b0}};
		end
	else if(start == 1)
		begin
			if(Number_to_2_complement[NBits-1] == 1'b1) 
				begin
					Number = ((~Number_to_2_complement ) + 1'b1);
				end
			else
				begin
					Number =Number_to_2_complement;
				end
		end
	else
		Number = Number;
end
assign Result =  Number  ;
endmodule
