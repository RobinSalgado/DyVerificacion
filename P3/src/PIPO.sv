module PIPO 
(
	input 			clk,
	input 			rst,
	input 			LOAD,
	input  [7:0]	DATA,
	output [7:0]	OUT
);

reg [7:0]Register;

always_ff@(posedge clk or negedge rst) 
	begin
		if(!rst)
			begin
				Register	= {8*{1'b0}};				
			end
		else 
			begin
				if (LOAD)
					begin
						Register <= DATA;
					end
				else
					begin
						Register	<= Register;
					end
			end
	end

assign OUT = Register;

endmodule