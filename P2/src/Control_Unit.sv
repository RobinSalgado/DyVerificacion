//import Parameter_Definitions::*;

module Control_Unit
(
	//inputs
	input clk,							//Internal clock
	input rst,							//Master_Reset
	input start,						//Start the operation
	input done,							//Tell the control when the operation has finished
	input error,
	input Load,
	//outputs
	output Load_X,					//Load x register
	output Load_y,					//Load y register
	output op_EN,
	output ready,						//Tells you when the multiplication has finished
	output error_OUT,
	output val
);


enum logic [3:0]{ IDLE,
						LOAD_X,
						WAIT_Y,
						LOAD_Y,
						VALIDATE,
						ERROR,
						START_OP,
						DO_OP,
						READY,
						WAIT
						} state;  	//State Declaration

						
logic		EN_X;
logic		EN_Y;
logic		EN_VAL;
logic		EN_ERROR;
logic		EN_OP;
logic		EN_RDY;

						
always@(*)
	begin
		if(rst == 0)  							//Restart the whole system
			state <= IDLE;	
		else
			begin
				case (state)
					IDLE: begin
						if(Load == 1)
							state = LOAD_X;
						else
							state = state;
					end
					LOAD_X: begin
						state = WAIT_Y;
//						if(Load == 1)
//							state = LOAD_Y;
//						else
//							state = state;
					end
					WAIT_Y: begin
						if(Load == 1)
							state = LOAD_Y;
						else
							state = state;
					end
					LOAD_Y: begin
							state = WAIT;
					end
					WAIT: begin
						if(start == 1)
							state = VALIDATE;
						else
							state = WAIT;
					end
					VALIDATE: begin
						if (error == 1)
							state = ERROR;
						else
							state = START_OP;
					end
					ERROR: begin
						if (Load == 1)
							state = LOAD_X;
						else 
							state = state;
					end
					START_OP: begin
							state = DO_OP;
					end
					DO_OP: begin
						if(done)
							state = READY;
						else
							state = state;
					end
					READY: 
						begin
							if(Load == 1)
								state = LOAD_X;
							else
								state = state;
						end
					default:
						begin
							state = state;
						end
					endcase
						
			end
	end
	
logic [1:0]OP_SEL;
always_ff@(posedge clk or negedge rst)	
begin
		if(rst == 0)  							//Restart the whole system
				begin
						EN_X = 0;
						EN_Y = 0;
						EN_VAL = 0;
						EN_ERROR = 0;
						EN_OP = 0;
						EN_RDY = 0;
				end
		else
			begin
				case (state)
					IDLE: begin
						EN_X = 0;
						EN_Y = 0;
						EN_VAL = 0;
						EN_ERROR = 0;
						EN_OP = 0;
						EN_RDY = 0;
					end
					LOAD_X: begin
						EN_X = 1;
						EN_Y = 0;
						EN_VAL = 0;
						EN_ERROR = 0;
						EN_OP = 0;
						EN_RDY = 0;
					end
					WAIT_Y: begin
						EN_X = 0;
						EN_Y = 0;
						EN_VAL = 0;
						EN_ERROR = 0;
						EN_OP = 0;
						EN_RDY = 0;
					end					
					LOAD_Y: begin
						EN_X = 0;
						EN_Y = 1;
						EN_VAL = 0;
						EN_ERROR = 0;
						EN_OP = 0;
						EN_RDY = 0;
					end
					WAIT: begin
						EN_X = 0;
						EN_Y = 0;
						EN_VAL = 0;
						EN_ERROR = 0;
						EN_OP = 0;
						EN_RDY = 0;
					end
					VALIDATE: begin
						EN_X = 0;
						EN_Y = 0;
						EN_VAL = 1;
						EN_ERROR = 0;
						EN_OP = 0;
						EN_RDY = 0;
					end
					ERROR: begin
						EN_X = 0;
						EN_Y = 0;
						EN_VAL = 0;
						EN_ERROR = 1;
						EN_OP = 0;
						EN_RDY = 0;
					end
					START_OP: begin
						EN_X = 0;
						EN_Y = 0;
						EN_VAL = 0;
						EN_ERROR = 0;
						EN_OP = 1;
						EN_RDY = 0;
						end
					DO_OP: begin
						EN_X = 0;
						EN_Y = 0;
						EN_VAL = 0;
						EN_ERROR = 0;
						EN_OP = 0;
						EN_RDY = 0;
					end
					READY: 
						begin
							EN_X = 0;
							EN_Y = 0;
							EN_VAL = 0;
							EN_ERROR = 0;
							EN_OP = 0;
							EN_RDY = 1;
						end
					default:
						begin
							EN_X = 0;
							EN_Y = 0;
							EN_VAL = 0;
							EN_ERROR = 0;
							EN_OP = 0;
							EN_RDY = 0;
						end
					endcase		
			end
end

assign Load_X = EN_X;					//Load x register
assign Load_y = EN_Y;					//Load y register
assign op_EN = EN_OP;
assign ready = EN_RDY;						//Tells you when the multiplication has finished
assign error_OUT = EN_ERROR;
assign val = EN_VAL;

endmodule
