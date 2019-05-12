// Coders:           Esteban González Moreno, Robin Moises Salgado

// Date:            08 Mayo 2019

// Name:            UART_TX_SM.sv

// Description:     UART transmition CONTROL PATH


import Definitions_Package::*;

module UART_RX_SM (
	input clk,
	input rst,
	input DATA,
	input DONE,
	input FC_done,
	output First_Count_EN,
	output BAUD_Count_EN,
	output Clear
);

/** This can be put on the Definition package**/
enum logic [2:0]{ 		RX_IDLE,
								RX_START,
								RX_RECEIVE,
								RX_STOP
						} RX_state;  	//State Declaration
reg COUNT1_EN;
reg COUNT2_EN;
reg CLEAR_EN;
always@(*)	
begin
		if(!rst)  							//Restart the whole system
				begin		
						COUNT1_EN <= 0;
						COUNT2_EN <= 0;
						CLEAR_EN  <= 1;
				end
		else
			begin
				case (RX_state)
					RX_IDLE: 
						begin
							COUNT1_EN <= 0;
							COUNT2_EN <= 0;
							CLEAR_EN  <= 1;

						end
					RX_START: 
						begin
							COUNT1_EN <= 1;
							COUNT2_EN <= 0;
							CLEAR_EN  <= 0;

						end
					RX_RECEIVE: 
						begin
							COUNT1_EN <= 0;
							COUNT2_EN <= 1;
							CLEAR_EN  <= 0;

						end	
					RX_STOP: 
						begin
							COUNT1_EN <= 0;
							COUNT2_EN <= 0;
							CLEAR_EN  <= 0;
						end
					default:
						begin
							COUNT1_EN <= COUNT1_EN;
							COUNT2_EN <= COUNT2_EN;
							CLEAR_EN  <= CLEAR_EN;
						end
					endcase		
			end
end

always_ff@(posedge clk or negedge rst)
	begin
		if(!rst)  							//Restart the whole system
			RX_state <= RX_IDLE;	
		else
			begin
				case (RX_state)
					RX_IDLE: 
						begin
							if (!DATA)
								RX_state <= RX_START;
							else
								RX_state <= RX_IDLE;
						end
					RX_START: 
						begin
							if (FC_done == 1)
								RX_state <= RX_RECEIVE;
						end
					RX_RECEIVE: 
						begin
							if( DONE  ==  1)
								RX_state <= RX_STOP;
							else
								RX_state <= RX_state;
						end
					RX_STOP: 
						begin
							RX_state <= RX_IDLE;
						end
					default:
						begin
							RX_state <= RX_state;
						end
					endcase
						
			end
	end

assign First_Count_EN = COUNT1_EN;
assign BAUD_Count_EN = COUNT2_EN;
assign Clear = CLEAR_EN;

endmodule
