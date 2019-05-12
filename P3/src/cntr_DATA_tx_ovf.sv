
// Coders:           Esteban González Moreno, Robin Moises Salgado

// Date:            07 Mayo 2019

// Name:            cntr_DATA_tx_ovf.sv

// Description:     Counter used for counting the transmited bits in the data frame

module cntr_DATA_tx_ovf
	import Definitions_Package::*;
(
	input                   clk,
	input                   rst,
	input                   enb,
	input							clear,
	output     ovf_frame_t  ovf
);

cntr_frame_t cntr;

always_ff@(posedge clk, negedge rst) begin: counter
	if (!rst)
        cntr.TX_Frame_count    <=  '0;
  	else if (clear)
		  cntr.TX_Frame_count    <=  '0;

   else if (enb)
		if (cntr.TX_Frame_count >= MAXCNT)
            cntr.TX_Frame_count    <= '0;
		else
            cntr.TX_Frame_count    <= cntr.TX_Frame_count + 1'b1;
	else
			cntr.TX_Frame_count    <=  cntr.TX_Frame_count;
end:counter

always_comb begin: comparator
    if (cntr.TX_Frame_count >= MAXCNT)
        cntr.frame_ovf     =   1'b1;    
    else
        cntr.frame_ovf     =   1'b0;
end:comparator

assign ovf      =   cntr.frame_ovf;

endmodule
