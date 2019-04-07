
module Multiplexor_R
(
	// Input 
	input clk,
	input rst,
	input [15:0] REG1,
	input [15:0] REG2,
	input signed [15:0] R,
	input Enable,
	// Output 
	output [15:0] Output,
	output FLAG
);

reg [15:0] Reg_Output;
reg FLAG_temp;

always_ff@(posedge clk or negedge rst)	
	begin
		
		if(!rst)
			begin
				Reg_Output = {15{1'b0}};
				FLAG_temp = 0;
			end
		else
			begin
				if(Enable ==1)
					begin
						if (R >= 0)
							begin
								Reg_Output = REG1;
								FLAG_temp = 1;
							end
						else 
							begin
								Reg_Output = REG2;
								FLAG_temp = 1;
							end
					end
				else
					begin
						Reg_Output = Reg_Output;
						FLAG_temp = 0;
					end
			end
end
	
assign Output = Reg_Output;
assign FLAG = FLAG_temp;
endmodule
