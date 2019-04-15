module DIVISOR_A 
(
	// Input 
	input  [15:0]  Condition,
	input 			init,
	input  [15:0]	A,
	// Output 
	output [15:0] 	OUT,
	output [15:0]	OUT_ref
);

reg [15:0] OUT_TEMP;
reg [15:0] OUT_REF_TEMP;
always_comb
	begin
		if (init)
			begin
				if (Condition < 0)
					begin
						OUT_TEMP = 16'b1; 
						OUT_REF_TEMP = 16'b1;
					end
				else
					begin
						OUT_TEMP = 16'b0;
						OUT_REF_TEMP = 16'b0;
					end
			end
		else
			begin
				OUT_TEMP <= A;
				if (Condition < 0)
					begin
						OUT_REF_TEMP <= 16'b1;
					end
				else
					begin
					OUT_REF_TEMP <= 16'b0;
					end

				
			end
	end
assign OUT = OUT_TEMP;
assign	OUT_ref = OUT_REF_TEMP;
endmodule


