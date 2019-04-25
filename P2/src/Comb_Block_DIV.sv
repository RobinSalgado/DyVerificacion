// combinational module
module Comb_Block_DIV (
	input start_over,
	input [15:0]Start_Data,
	input clk,
	input S,
	input [15:0]Q,
	input [31:0]A_SHIFT1,
	input [15:0]A_AFTER_OP,
	input [15:0]A_REF,
	output [31:0]AQ,
	output QN

	
);

reg	[31:0]	AQ_TEMP;
reg				QN_TEMP;	
always_ff @(posedge clk)
begin
	if (start_over)
		begin
			QN_TEMP <= 1'b0;
			AQ_TEMP <= {A_SHIFT1[31:15],Start_Data};
		end
	else if(S != A_AFTER_OP[15])
		begin
			if (A_AFTER_OP != A_REF)
				begin
					AQ_TEMP <= A_SHIFT1;
					QN_TEMP <= 1'b0;
				end
			else
				begin
					AQ_TEMP <= {A_AFTER_OP,A_SHIFT1[15:0]};
					QN_TEMP <= 1'b0;
				end
		end
	else
		begin
			if (A_AFTER_OP == A_REF)
				begin
					QN_TEMP <= 1'b1;
					AQ_TEMP <= {A_AFTER_OP,Q[15:1],1'b1};

				end
			else 
				begin
					QN_TEMP <= 1'b0;
					AQ_TEMP <= {A_AFTER_OP,A_SHIFT1[15:0]};
				end
		end
end

assign QN = QN_TEMP;
assign AQ = AQ_TEMP;
endmodule