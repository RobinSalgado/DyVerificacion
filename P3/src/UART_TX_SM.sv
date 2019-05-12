// Coders:           Esteban González Moreno, Robin Moises Salgado

// Date:            07 Mayo 2019

// Name:            UART_TX_SM.sv

// Description:     UART transmition CONTROL PATH


import Definitions_Package::*;

module UART_TX_SM (
	input clk,
	input rst,
	input	LOAD,
	input DONE,
	
	output LOAD_EN,
	output TRANSMIT_EN
);

/** This can be put on the Definition package**/
enum logic [2:0]{ 		TX_IDLE,
								TX_START,
								TX_TRANSMIT,
								TX_STOP
						} TX_state;  	//State Declaration
reg EN_START;
reg EN_TRANSMIT;

always@(*)	
begin
		if(!rst)  							//Restart the whole system
				begin		
						EN_START <= 0;
						EN_TRANSMIT <= 0;
				end
		else
			begin
				case (TX_state)
					TX_IDLE: 
						begin
							EN_START <= 0;
							EN_TRANSMIT <= 0;

						end
					TX_START: 
						begin
							EN_START <= 1;
							EN_TRANSMIT <= 0;

						end
					TX_TRANSMIT: 
						begin
							EN_START <= 0;
							EN_TRANSMIT <= 1;

						end	
					TX_STOP: 
						begin
							EN_START <= 0;
							EN_TRANSMIT <= 0;
						end
					default:
						begin
							EN_START = 0;
							EN_TRANSMIT = 0;
						end
					endcase		
			end
end

always_ff@(posedge clk or negedge rst)
	begin
		if(!rst)  							//Restart the whole system
			TX_state <= TX_IDLE;	
		else
			begin
				case (TX_state)
					TX_IDLE: 
						begin
							if(LOAD == 1)
								TX_state <= TX_START;
							else
								TX_state <= TX_state;
						end
					TX_START: 
						begin
								TX_state <= TX_TRANSMIT;
						end
					TX_TRANSMIT: 
						begin
							if( DONE  ==  1)
								TX_state <= TX_STOP;
							else
								TX_state <= TX_state;
						end
					TX_STOP: 
						begin
							TX_state <= TX_IDLE;
						end
					default:
						begin
							TX_state <= TX_state;
						end
					endcase
						
			end
	end
assign LOAD_EN = EN_START;
assign TRANSMIT_EN = EN_TRANSMIT;
endmodule
