
module debouncer 
(
	//Inputs			
	input		clk,
	input 	start,
	input 	rst,						//Reset the counter
	output 	debouncer_out 					//negated_shift_enable Tells you when it has finished so it stops the shifting
);

logic [27:0] count;							
logic ovf;
logic start_count;
always @ (posedge clk or negedge rst) 
	begin
	
		if (!rst)
			begin	
				count <= {{27'b0}};
				start_count <= 0;
			end
		else 
			begin		
				ovf <= 0;
				if(start)
					begin
						ovf <= 0;
						count <= {27'b0};		
						start_count <= 1;
					end
				if (start_count == 1)
				begin
					if(count < 10000000 )	
							begin

								count <= count + 1'b1;
								ovf <= 0;
							end
					else
						begin
							ovf <= 1;
							start_count <= 0;
							count <= {27'b0};		
						end
				end
			end
end
assign debouncer_out = ovf;
endmodule

