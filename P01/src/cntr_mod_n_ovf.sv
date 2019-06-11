// Coder:       Abisai Ramirez Perez
// Date:        June 2th, 2019
// Name:        cntr_mod_n_ovf.sv
// Description: This is a counter mod-n with a flag for indicating 
//              overflow.

// This is a Mod-n counter with overflow indication and its package. 
module cntr_mod_n_ovf

(
input                   clk,
input                   rst,
input                   i_enb,
input 						i_clr,
output  logic   o_ovf,
output  logic [3:0]   o_count
);

/********* PKG **************/

localparam MAXCNT   	= 9;


typedef struct {
logic [3:0]       count;
logic       ovf;
} cntr_t;

	
/********* PKG **************/
	
cntr_t cntr;

always_ff@(posedge clk, negedge rst, posedge i_clr) begin: counter

    if ( !rst )
        cntr.count    <=  '0;
	
    else if ( i_clr )
	 cntr.count    <=  '0;
	 
    else if (i_enb)
	 
        if (cntr.count >= MAXCNT)
            cntr.count    <= '0;
        else
            cntr.count    <= cntr.count + 1'b1;
end:counter

always_comb begin: comparator
    if (cntr.count >= MAXCNT)
        cntr.ovf     =   1'b1;    
    else
        cntr.ovf     =   1'b0;
end:comparator

assign o_count    =   cntr.count;
assign o_ovf      =   cntr.ovf;

endmodule


