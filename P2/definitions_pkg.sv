

// Coder:           Robin  & Esteban 
// Date:            25 April 2019
// Name:            definitions_pkg.sv
// Description:     This is the package of definitions for MDR

package definitions_pkg;

	 localparam  W_DISP_SEG  = 6;
	 localparam  W_OP = 1;

    localparam  W_DATA      = 16;
    localparam  W_ADDR      = 12;
	 localparam  W_BCD  =  4;
    localparam  W_DEPTH     = 2*W_DATA;
	 
	 
	 typedef logic [W_DISP_SEG-1:0] 	  disp_seg_t;	
	 typedef logic [W_OP:0] 	        op_t;	
	 typedef logic [W_BCD-1:0] 	     bcd_t;	
	 typedef logic [W_DEPTH-1:0] 	     prod_t;	
         typedef logic [W_DATA-1:0]        data_t;
   

endpackage
