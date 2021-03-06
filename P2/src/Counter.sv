
module Counter
(
	//Inputs			
	input clk,
	input rst,	//Reset the counter
	input enb,
	output [15:0] count_till_ovf,				//Size of N-1 (number of bits to count -1) number of shifts
	//Output	
	output overflow 								//negated_shift_enable Tells you when it has finished so it stops the shifting

);


logic [16-1:0] count;							
logic ovf;


always @ (posedge clk or negedge rst) 
	begin
	
		if (!rst)
			begin	
				
				count <= 9;	
				ovf <= 0;
			end
		else 
			begin		
				if(enb)
					begin
						if(count > 0 )	
							begin
								count <= count - 1'b1;
								ovf <= 0;
								
							end
						else
							begin
								ovf <= 1;
								count <= 9;	
							end
					end
				 else
					begin
						ovf <= 0;
					end
			end
end
assign overflow = ovf;
assign count_till_ovf = count;
endmodule

