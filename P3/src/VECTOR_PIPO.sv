module VECTOR_PIPO 
(
	input 			clk,
	input 			rst,
	input 			LOAD,
	input  [3:0]	Section_SEL,
	input  [7:0]	DATA,
	output [63:0]	OUT
);

reg [63:0]Register;

always_ff@(posedge clk or negedge rst) 
	begin
		if(!rst)
			begin
				Register	= {64*{1'b0}};				
			end
		else 
			begin
				if (LOAD)
					begin
						if(Section_SEL == 0)
							Register[7:0] <= DATA;
						else if	(Section_SEL == 1)
							Register[15:8] <= DATA;
						else if	(Section_SEL == 2)
							Register[23:16] <= DATA;
						else if	(Section_SEL == 3)
							Register[31:24] <= DATA;
						else if	(Section_SEL == 4)
							Register[39:32] <= DATA;
						else if	(Section_SEL == 5)
							Register[47:40] <= DATA;
						else if	(Section_SEL == 6)
							Register[55:48] <= DATA;
						else if	(Section_SEL == 7)
							Register[63:56] <= DATA;
						else
							Register <= Register;

					end
				else
					begin
						Register	<= Register;
					end
			end
	end

assign OUT = Register;

endmodule