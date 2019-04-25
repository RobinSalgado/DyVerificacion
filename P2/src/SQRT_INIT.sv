module SQRT_INIT 
(
	// Input 	
	input clk,
	input rst,
	input RDY,
	input 			init,
	input  [15:0]	R,
	input  [15:0]	Q,

	// Output 
	output [15:0] 	OUT_R,
	output [15:0] 	OUT_Q

);

reg [15:0] OUT_TEMP_R;
reg [15:0] OUT_TEMP_Q;

always_ff @(posedge clk or negedge rst)
	begin
		if(!rst)
			begin
				OUT_TEMP_R = 16'b0; 
				OUT_TEMP_Q = 16'b0;
			end
		else if (init)
			begin
				OUT_TEMP_R = 16'b0; 
				OUT_TEMP_Q = 16'b0;
			end
		else if(!RDY)
			begin
				OUT_TEMP_R = R; 
				OUT_TEMP_Q = Q;
			end
		else
			begin
				OUT_TEMP_R = OUT_TEMP_R;
				OUT_TEMP_Q = OUT_TEMP_Q;
			end
				
end
	
assign OUT_R = OUT_TEMP_R;
assign OUT_Q = OUT_TEMP_Q;
endmodule


