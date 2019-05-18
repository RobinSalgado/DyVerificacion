

//PIPO TO SAVE THE MAT SIZE
module PIPO_MAT_SIZE ( //saves the value of the matrix
	//inputs
	input clk,
	input rst,
	input SIZE_M_EN,
	input [3:0]REC_DATA,
	//outputs
	output [3:0]MAT_SIZE
);


reg [3:0]Register;

always_ff@(posedge clk or negedge rst) 
	begin
		if(!rst)
			begin
				Register	= {4*{1'b0}};				
			end
		else 
			begin
				if (SIZE_M_EN)
					begin
						Register <= REC_DATA;
					end
				else
					begin
						Register	<= Register;
					end
			end
	end

assign MAT_SIZE = Register;

endmodule
