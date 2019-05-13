
// Coder:           Esteban González Moreno

// Date:            07 Mayo 2019

// Name:            UART_TX_SM.sv

// Description:     UART transmition CONTROL PATH


import Definitions_Package::*;
module MxV_SM (
	input 					clk,
	input 					rst,
	input word_lenght_t 	REC_DATA,
	input 					Enable,
	input 					DONE_TRANSMITION,
	input						OP_DONE,
	
	output 					MAT_SIZE_EN,
	output 					DATA_ASSIGN_EN,
	output 					OPERATION_EN,
	output 					TRANSMIT_EN,
	output 					CLEAR_EN,
	output 					DL_EN,					//DATA LENGHT ENABLE
	output					VEC_EN,
	output					MAT_EN
);

reg EN_MAT_SIZE;
reg EN_DATA_ASSIGN;
reg EN_OPERATION;
reg EN_TRANSMIT;
reg EN_CLEAR;
reg EN_DL;

reg VEC_FLAG;	
reg MAT_FLAG;
/** This can be put on the Definition package**/
//reg [3:0] FEED_state2;
enum logic [3:0]{ 		

							FEED_IDLE,
							FEED_START,
							FEED_F_LENGHT,
							FEED_F_CMD,
								//TAMAÑO MATRIX, RETRANSMITIR, COMENZAR CAPTURA DE datos, TRANSMICION, datos
							
							FEED_MAT_SIZE,
							
							FEED_RE_TRANSMIT,
							FEED_START_TRANSMITION,
							
							FEED_CAP_INIT,							
							
							FEED_TRANSMIT_CMD,
							
							FEED_OPERATION,
	
							FEED_CLEAR
								
								
						} FEED_state,FEED_state2;  	//State Declaration

always@(*)	
begin
		if(!rst)  							//Restart the whole system
				begin		
						EN_MAT_SIZE <= 0;
						EN_DATA_ASSIGN <= 0;
						EN_OPERATION <= 0;
						EN_TRANSMIT <= 0;
						EN_CLEAR <= 0;
						EN_DL <= 0;		

				end
		else
			begin
				
						case (FEED_state)
							FEED_IDLE: 
								begin
									EN_MAT_SIZE <= 0;
									EN_DATA_ASSIGN <= 0;
									EN_OPERATION <= 0;
									EN_TRANSMIT <= 0;
									EN_CLEAR <= 0;
									EN_DL <= 0;									
								end
							FEED_START:
								begin
									EN_MAT_SIZE <= 0;
									EN_DATA_ASSIGN <= 0;
									EN_OPERATION <= 0;
									EN_TRANSMIT <= 0;
									EN_CLEAR <= 0;
									EN_DL <= 0;			
								end
							FEED_F_LENGHT: 
								begin
									EN_MAT_SIZE <= 0;
									EN_DATA_ASSIGN <= 0;
									EN_OPERATION <= 0;
									EN_TRANSMIT <= 0;
									EN_CLEAR <= 0;
									EN_DL <= 1;
								end
							FEED_F_CMD:
								begin
									EN_MAT_SIZE <= 0;
									EN_DATA_ASSIGN <= 0;
									EN_OPERATION <= 0;
									EN_TRANSMIT <= 0;
									EN_CLEAR <= 0;
									EN_DL <= 1;
								end
							FEED_MAT_SIZE: 
								begin
									EN_MAT_SIZE <= 1;
									EN_DATA_ASSIGN <= 0;
									EN_OPERATION <= 0;
									EN_TRANSMIT <= 0;
									EN_CLEAR <= 0;
									EN_DL <= 0;
								end	
							FEED_RE_TRANSMIT: 
								begin
									EN_MAT_SIZE <= 0;
									EN_DATA_ASSIGN <= 0;
									EN_OPERATION <= 0;
									EN_TRANSMIT <= 0;
									EN_CLEAR <= 0;
									EN_DL <= 0;
								end
							FEED_START_TRANSMITION:
								begin
									EN_MAT_SIZE <= 0;
									EN_DATA_ASSIGN <= 0;
									EN_OPERATION <= 0;
									EN_TRANSMIT <= 1;
									EN_CLEAR <= 0;
									EN_DL <= 0;
								end
							FEED_CAP_INIT:
								begin
									EN_MAT_SIZE <= 0;
									EN_DATA_ASSIGN <= 0;
									EN_OPERATION <= 0;
									EN_TRANSMIT <= 0;
									EN_CLEAR <= 0;
									EN_DL <= 0;
								end
							FEED_TRANSMIT_CMD:
								begin
									EN_MAT_SIZE <= 0;
									EN_DATA_ASSIGN <= 1;
									EN_OPERATION <= 0;
									EN_TRANSMIT <= 0;
									EN_CLEAR <= 0;
									EN_DL <= 0;
								end
							FEED_OPERATION:
								begin
									EN_MAT_SIZE <= 0;
									EN_DATA_ASSIGN <= 0;
									EN_OPERATION <= 1;
									EN_TRANSMIT <= 0;
									EN_CLEAR <= 0;
									EN_DL <= 0;
								end	
							FEED_CLEAR:
								begin
									EN_MAT_SIZE <= 0;
									EN_DATA_ASSIGN <= 0;
									EN_OPERATION <= 0;
									EN_TRANSMIT <= 0;
									EN_CLEAR <= 1;
									EN_DL <= 0;
								end
							default:
								begin
									EN_MAT_SIZE <= 0;
									EN_DATA_ASSIGN <= 0;
									EN_OPERATION <= 0;
									EN_TRANSMIT <= 0;
									EN_CLEAR <= 0;
									EN_DL <= 0;
								end
						endcase						
				end	
			
end

always_ff@(posedge clk or negedge rst)
	begin
		if(!rst)  							//Restart the whole system
			begin
				FEED_state <= FEED_IDLE;
				VEC_FLAG <= 0;	
				MAT_FLAG <= 0;

			end
		else 				//si hubo transmición de datos
			begin
				case (FEED_state)
					FEED_IDLE: 
						begin
									if(REC_DATA == 8'hFE)
										FEED_state <= FEED_START;
									else
										FEED_state <= FEED_state;
						end
					FEED_START:
						begin
							if(Enable)	
								FEED_state <= FEED_F_LENGHT;
							else
								FEED_state <= FEED_state;
						end
					FEED_F_LENGHT: 
						begin
							if(Enable)
								FEED_state <= FEED_F_CMD;
							else
								FEED_state <= FEED_state;
						end
					FEED_F_CMD:
						begin
							if(Enable)
								begin
									if (REC_DATA == 1)
										FEED_state <= FEED_MAT_SIZE;
									else if (REC_DATA == 2)
										FEED_state <= FEED_RE_TRANSMIT;
									else if (REC_DATA == 3)
										FEED_state <= FEED_CAP_INIT;
									else if (REC_DATA == 4)
										FEED_state <= FEED_TRANSMIT_CMD;
							
									end
							else
								FEED_state <= FEED_state;
						end
					FEED_MAT_SIZE:
						begin
									if(REC_DATA == 8'hEF)
										FEED_state <= FEED_IDLE;
									else
										FEED_state <= FEED_state;
						end

					FEED_RE_TRANSMIT:
						begin
									if(REC_DATA == 8'hEF)
										FEED_state <= FEED_START_TRANSMITION;
									else 
										FEED_state <= FEED_state;
						end
					FEED_START_TRANSMITION:
						begin
							if (DONE_TRANSMITION)
								FEED_state <= FEED_IDLE;
							else 
								FEED_state <= FEED_state;				
						end
					FEED_CAP_INIT:
						begin
									if(REC_DATA == 8'hEF)
										begin
											FEED_state <= FEED_IDLE;
											
										end
									else 
										FEED_state <= FEED_state;
						end
					FEED_TRANSMIT_CMD: //Primero captura en el array de RAMS, depues en los pipo del vector
						begin
							
								
									if(!MAT_FLAG)
										begin
											if(!VEC_FLAG)
												VEC_FLAG <= 0;	
												MAT_FLAG <= 1;
										end
									else if (MAT_FLAG)
										begin
											
											
											if(REC_DATA == 8'hEF)
												FEED_state <= FEED_CLEAR;
											else 
												FEED_state <= FEED_state;
										end
									else if (VEC_FLAG)
										begin
											
											if(REC_DATA == 8'hEF)
												FEED_state <= FEED_OPERATION;
											else 
												FEED_state <= FEED_state;
											end
								
						end
						
						
					FEED_CLEAR:
						begin
							VEC_FLAG <= 1;	
							MAT_FLAG <= 0;
							FEED_state <= FEED_IDLE;
						end
					FEED_OPERATION:
						begin
							if(OP_DONE)
								begin
									VEC_FLAG <= 0;	
									MAT_FLAG <= 1;
									FEED_state <= FEED_START_TRANSMITION;
								end
							else 
								FEED_state <= FEED_state;
						end
					
					
					default:
						begin
							FEED_state <= FEED_state;
						end
					endcase
						
			end
		
			
	end


assign VEC_EN  = VEC_FLAG;	
assign MAT_EN = MAT_FLAG;					
assign MAT_SIZE_EN = EN_MAT_SIZE;
assign DATA_ASSIGN_EN = EN_DATA_ASSIGN;
assign OPERATION_EN = EN_OPERATION;
assign TRANSMIT_EN = EN_TRANSMIT;
assign CLEAR_EN = EN_CLEAR;
assign DL_EN = EN_DL;

endmodule