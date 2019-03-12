module SIGN(
	input 	Multiplicand,
	input 	Multiplier,
	input clk,
	input rst,
	input start,
	output sign
);

logic S;
always_ff@(posedge clk or negedge rst) 
	begin
	if (!rst)
		begin
			S <= Multiplicand ^ Multiplier;
		end
	else if(start == 1)
		begin
			S <= Multiplicand ^ Multiplier;
		end
	else
		S <= S;
end
assign sign = S;

endmodule
