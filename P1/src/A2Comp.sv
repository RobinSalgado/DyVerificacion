import Parameter_Definitions::*;

module A2Comp(
	//inputs	
	input  [2*NBits-1:0]Number_to_2_complement,		
	//outputs					
	output [2*NBits-1:0]	Result					//I need better names	
);


assign Result = (~Number_to_2_complement) + 1'b1;
endmodule
