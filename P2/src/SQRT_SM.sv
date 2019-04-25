
module SQRT_SM
(
	input 				clk,
	input 				rst,
	input       		EN,
	input             COUNTER_FLAG,
	//input       		SHIFTER_FLAG,
	input 				MUX_FLAG,
	input 				MUX_FLAG2,
	input 				ADDR_OR_REST_FLAG,


	output				counter_EN,
	output				SHIFT_EN,
	output				MUX_EN,
	output 				MUX_EN2,
	output				OP_EN,
	output				OP_READY
);


enum logic [3:0]{ IDLE,
						Count_1,
						SHIFT,
						Multiplex,
						ADD_REST,
						Multiplex2,
						READY
						} state;  	//State Declaration

						
logic		EN_Counter;
logic		EN_SHIFT;
logic		EN_MUX;
logic 	EN_MUX2;
logic		EN_OP;
logic		EN_RDY;
//						
//always@(*)
//	begin
//		if(!rst)  							//Restart the whole system
//			state <= IDLE;	
//		else
//			begin
//				case (state)
//					IDLE: begin
//						if(EN == 1)
//							state = Count_1;
//						else
//							state = state;
//					end
//					Count_1: begin
//						if(OP_READY == 0)
//							state = SHIFT;
//						else
//							state = state;
//					end
//					SHIFT: begin
//						if( COUNTER_FLAG  == 1)
//							state = READY;
//						//else if (SHIFTER_FLAG == 1)
//						else
//							state = Multiplex;
//						//else
//						//	state = state;
//					end
//					Multiplex: begin
//						if(MUX_FLAG == 1)
//							state = ADD_REST;
//						else
//							state = state;
//					end
//					ADD_REST: begin
//						if (ADDR_OR_REST_FLAG == 1)
//							state = Multiplex2;
//						else
//							state = state;
//					end
//					Multiplex2: begin
//						if (MUX_FLAG2 == 1)
//							state = Count_1;
//						else 
//							state = state;
//					end
//					READY: 
//						begin
//							if(EN == 1)
//								state = IDLE;
//							else
//								state = state;
//						end
//					
//					
//					default:
//						begin
//							state = state;
//						end
//					endcase
//						
//			end
//	end
//	
//
//always_ff@(posedge clk or negedge rst)	
//begin
//		if(rst == 0)  							//Restart the whole system
//				begin		
//						EN_Counter = 0;
//						EN_SHIFT = 0;
//						EN_MUX = 0;
//						EN_MUX2 = 0;
//						EN_OP = 0;
//						EN_RDY = 0;
//				end
//		else
//			begin
//				case (state)
//					IDLE: begin
//						EN_Counter = 0;
//						EN_SHIFT = 0;
//						EN_MUX = 0;
//						
//						EN_OP = 0;
//						EN_RDY = 0;
//					end
//					Count_1: begin
//						EN_Counter = 1;
//						EN_SHIFT = 0;
//						EN_MUX = 0;
//						EN_MUX2 = 0;
//						EN_OP = 0;
//						EN_RDY = 0;
//					end
//					SHIFT: begin
//						EN_Counter = 0;
//						EN_SHIFT = 1;
//						EN_MUX = 0;
//						EN_MUX2 = 0;
//						EN_OP = 0;
//						EN_RDY = 0;
//					end
//					Multiplex: begin
//						EN_Counter = 0;
//						EN_SHIFT = 0;
//						EN_MUX = 1;
//						EN_MUX2 = 0;
//						EN_OP = 0;
//						EN_RDY = 0;
//					end
//					ADD_REST: begin
//						EN_Counter = 0;
//						EN_SHIFT = 0;
//						EN_MUX = 0;
//						EN_MUX2 = 0;
//						EN_OP = 1;
//						EN_RDY = 0;
//					end
//					Multiplex2: begin
//						EN_Counter = 0;
//						EN_SHIFT = 0;
//						EN_MUX = 0;
//						EN_MUX2 = 1;
//						EN_OP = 0;
//						EN_RDY = 0;
//					end
//					READY: begin
//						EN_Counter = 0;
//						EN_SHIFT = 0;
//						EN_MUX = 0;
//						EN_MUX2 = 0;
//						EN_OP = 0;
//						EN_RDY = 1;
//					end
//					default:
//						begin
//							EN_Counter = 0;
//							EN_SHIFT = 0;
//							EN_MUX = 0;
//							EN_MUX2 = 0;
//							EN_OP = 0;
//							EN_RDY = 0;
//						end
//					endcase		
//			end
//end

assign	counter_EN = EN_Counter;
assign	SHIFT_EN = EN_SHIFT;
assign	MUX_EN = EN_MUX;
assign	MUX_EN2 = EN_MUX2;
assign	OP_EN = EN_OP;
assign	OP_READY = EN_RDY;
endmodule
