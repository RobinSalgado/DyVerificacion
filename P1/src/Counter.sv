import Parameter_Definitions::*;

module Counter
(
	//Inputs			
	input clk,
	input EF,
	input rst,										//Reset the counter
	//input [N_BITS-1:0] bits_till_ovf,				//Size of N-1 (number of bits to count -1) number of shifts
	//Output	
	output overflow 								//negated_shift_enable Tells you when it has finished so it stops the shifting
);


logic [NBits-1:0] count;							
logic ovf;

always @ (posedge clk or negedge rst) 
	begin
	
		if (!rst)
			begin	
				
				count <= {NBits{1'b0}};	
			end
		else 
			begin		
				if(EF)
					begin
						ovf <= 0;
						count <= {NBits{1'b0}};		
					end
				else if(count < (NBits+1) )	
							begin
								count <= count + 1'b1;
								ovf <= 0;
							end
				else
						begin
							ovf <= 1;
						end
			end
end
assign overflow = ovf;
endmodule

