module Mult_ADDR
(
	input 			Selector,
	input [3:0]		in1,
	input [3:0]		in2,
	output [3:0] 	ADDR
	
);

reg [3:0] temp;
always@(*)//ff @(posedge clk)
	begin
	temp <= 8;
		if(Selector)
			temp <= in2;
		else
				temp <= in1;
		
	end
assign ADDR = temp;
endmodule
