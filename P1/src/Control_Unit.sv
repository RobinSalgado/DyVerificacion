import Parameter_Definitions::*;

module Control_Unit
(
	//inputs
	input clk,							//Internal clock
	input rst,							//Master_Reset
	input start,						//Start the multiplication
	input counter_Flag,					//Tells you when the counter has finished
	//outputs
	output Force_reset,					//Resets the register
	output ready						//Tells you when the multiplication has finished
);


enum logic [1:0]{IDLE,MULTIPLY, READY,WAIT} state;  	//State Declaration


logic FR;
logic RDY;


always_ff@(posedge clk or negedge rst)	begin
	//	FR <= 1;
	//	RDY <= 0;
	if(rst == 0)  							//Restart the whole system
		state <= IDLE;	
	else
		begin
			case(state)
				IDLE:
					begin
						FR <= 1;			//Forces the Register to 0
						RDY <= 0;
						
						if(start == 1)  			//Put the numbers and start multiplying when start is activated 
							begin
								state <= WAIT;
							end
					end
				WAIT:
					begin
						FR <= 1;
						state <= MULTIPLY;
					end
				MULTIPLY:
					begin
						RDY <= 0;
						FR <= 0;			//Frees the register
						
						if(counter_Flag == 1)
							begin
								state <= READY;
							end
					end
				READY:
					begin
						RDY <= 1;
						
						if(!rst)
							begin
								state <= IDLE;
							end
						if(start == 1)
							begin
								FR <= 1;
								state <= WAIT;
							end
					end
				default:
					begin
						state <= IDLE;
					end
				endcase
		end
end
assign Force_reset = FR;
assign ready = RDY;
endmodule
