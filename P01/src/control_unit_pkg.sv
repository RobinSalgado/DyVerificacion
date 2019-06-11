
`ifndef DEFINITIONS_PKG_SV 
	`define DEFINITIONS_PKG_SV

package control_unit_pkg;

    localparam W_ST = 1; 

	 
    typedef enum logic {
        IDLE        = 1'b0,
        PROCESING   = 1'b1
    } state_e;

    typedef enum logic {
        ZERO  = 1'b0,
        ONE   = 1'b1
    } value_e;

endpackage 


`endif
