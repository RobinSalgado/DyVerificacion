
// Coders:           Esteban González Moreno, Robin Moises Salgado

// Date:            08 Mayo 2019

// Name:            cntr_half_baud_tx_ovf.sv

// Description:     Counter used for the TX BAUD RATE

import Definitions_Package::*;
module cntr_half_baud_ovf
	
(
	input                   clk,
	input                   rst,
	input                   enb,
	input							clear,
	output     ovf_baud_t   ovf

);

cntr_baud_t cntr;

always_ff@(posedge clk, negedge rst) begin: counter
   if (!rst)
        cntr.TX_BAUD_count    <=  '0;
	else if (clear)
		  cntr.TX_BAUD_count    <=  '0;
   else if (enb)
		if (cntr.TX_BAUD_count >= HALF_BAUD-1'b1)
            cntr.TX_BAUD_count    <= '0;
		else
            cntr.TX_BAUD_count    <= cntr.TX_BAUD_count + 1'b1;
	else
			cntr.TX_BAUD_count    <=  '0;
end:counter

always_comb begin: comparator
    if (cntr.TX_BAUD_count >= HALF_BAUD-1'b1)
        cntr.baud_ovf     =   1'b1;    
    else
        cntr.baud_ovf     =   1'b0;
end:comparator

assign ovf      =   cntr.baud_ovf;

endmodule
