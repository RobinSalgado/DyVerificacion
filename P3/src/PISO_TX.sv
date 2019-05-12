// Coders:           Esteban González Moreno, Robin Moises Salgado

// Date:            07 Mayo 2019

// Name:            PISO_TX.sv

// Description:    piso for UART TX


import Definitions_Package::*;


module PISO_TX(
	input								clk,    				// Clock
	input 							rst,    				// asynchronous reset low active 
	input 							TX_EN,    			// Enable
	input 							LOAD_EN,   			// load or shift
	input  word_lenght_t  		DATA,    			// data input
	output            			TX     				// Serial output
);

FRAME_LENGHT_t      rgstr_r;							// N bit register (using 16 by default)
reg					 PISO_OUt_r;						// Output register

always_ff@(posedge clk or negedge rst) 			
	begin: rgstr_label
	
    if(!rst)
		begin
			rgstr_r  <= W_Empty_TX_REG;				//all ones
			PISO_OUt_r <= 1;
		end
	else if (LOAD_EN) 
		begin
			PISO_OUt_r <= PISO_OUt_r;
			rgstr_r  <= {1'b0,DATA,1'b1};				
		end
   else if (TX_EN)
		begin
			PISO_OUt_r <= rgstr_r[W_FRAME_LENGHT-1];
			rgstr_r  <= {rgstr_r[W_FRAME_LENGHT-2:0], 1'b1};	//SHIFT to the left
		end
	else
		begin
			rgstr_r <= rgstr_r;
			PISO_OUt_r <= PISO_OUt_r;
		end
end:rgstr_label

assign TX  = PISO_OUt_r;    // MSB bit is the first to leave

endmodule
