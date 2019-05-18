
module Clock_Generator
#(
	parameter CLK_FPGA = 50_000_000,		        
	parameter FREQ_DIVISOR = 500_000				// Frequency divisor.
)
(
    input reset ,
    input clk,
    output reg clk_Signal
);

localparam DESIRED_FREQ = CLK_FPGA/FREQ_DIVISOR;    
													
localparam BITS_CALCULATED = Calc_Bits(DESIRED_FREQ/2);	
logic [BITS_CALCULATED-1:0]counter;			


always@(posedge clk or negedge reset)	begin: clk_Generator_always

	if(reset == 0)	begin		
		clk_Signal = 0;
		counter = 0;
	end
	else 
	 	if(counter < ((DESIRED_FREQ/2)-1))	
		begin
			counter = counter + 1;
		end
		else 
			if (clk_Signal == 1)
			begin
				clk_Signal = 0;
				counter = 0;
			end
			else
			begin
				clk_Signal = 1;
				counter = 0;
			end
	
end: clk_Generator_always



function integer Calc_Bits;
	input integer input_Freq;
	integer i,bits;
   
	begin
		for(i=0; 2**i < input_Freq; i=i+1)
			bits = i + 1;
			Calc_Bits = bits;
	end
endfunction


endmodule 