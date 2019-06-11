
// Coder:           Robin Salgado   
// Date:            29 may 2019
// Name:            definitions_pkg.sv
// Description:     This is the package of definitions for MDR

`ifndef DEFINITIONS_PKG_SV 
	`define DEFINITIONS_PKG_SV

package definitions_pkg;

	 localparam  W_BIT        =        1;
	 localparam  W_BCD        =        4;
	 localparam  W_INT4       =        4;	 
	 localparam  W_DISP_SEG   =        7;
	 localparam  w_INT8       =        8;
	 localparam  W_ADDR       =       12;
    localparam  w_INT16      =       16;
    localparam  W_DEPTH      = 		 32;
	 
	 typedef logic [W_BIT:0] 	        bit_t;	
	 typedef logic [W_BCD-1:0] 	     bcd_t;	
	 typedef logic [W_INT4-1:0] 	     int4_t;	
	 typedef logic [w_INT8-1:0]  		  int8_t;
    typedef logic [w_INT16-1:0]       int16_t;
	 typedef logic [W_DEPTH-1:0] 	     prod_t;
	 typedef logic [W_DISP_SEG-1:0] 	  disp_seg_t;
	               
	 
	 typedef enum logic [6:0]{
	 
	   ZERO  = 7'b1000000,
      ONE   = 7'b1111001,
      TWO   = 7'b0100100,
      TREE  = 7'b0110000,
	   FOUR  = 7'b0011001,
      FIVE  = 7'b0010010,
      SIX   = 7'b0000010,
      SEVEN = 7'b1111000,
      EIGHT = 7'b0000000,
      NINE  = 7'b0010000,
      OFF   = 7'b1111111,
		SIGN  = 7'b0111111,
		TEN   = 7'b0001010
	 } segment_e;
   
localparam DW       	= 4;
localparam MAXCNT   	= 4;
typedef logic [DW-1:0] cnt_t;
typedef logic          ovf_t;

typedef struct {
cnt_t       count;
ovf_t       ovf;
} cntr_t;

	localparam W_ST = 1; 

	 
     
    typedef enum logic [1:0]{
        IDLE        = 2'b00,
        PROCESING   = 2'b01,
		  READY       = 2'b10
    } state_e;

    typedef enum logic {
        U_ZERO  = 1'b0,
        U_ONE   = 1'b1
    } value_e;
	
	
	
	
endpackage

`endif