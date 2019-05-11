// Coder:           Esteban González Moreno

// Date:            07 Mayo 2019

// Name:            Definition Package.sv

// Description:     This is the definition package for the TOP Module


package Definitions_Package;

	 localparam  	W_WORD_LENGHT  = 8;
 	 typedef logic [W_WORD_LENGHT-1:0] 	  word_lenght_t; 

/**** FOR UART*****/
	 localparam  	W_Empty_TX_REG  = 8'b1;
	 localparam  	W_FRAME_LENGHT  = 10;
 	 typedef logic [W_FRAME_LENGHT-1:0] 	  FRAME_LENGHT_t; 
	// SIPO
	 typedef logic [W_WORD_LENGHT:0] 	  sipo_lenght_t; 
	// UART_TX_COUNTERS 
	
	localparam 		BAUD      	= 434;
	localparam 		HALF_BAUD   = 217;
	typedef logic 	[BAUD-1:0] 	cnt_baud_t;
	typedef logic          		ovf_baud_t;
	typedef struct {
		cnt_baud_t       TX_BAUD_count;
		ovf_baud_t       baud_ovf;
	} cntr_baud_t;
	
	localparam 		MAXCNT   	= 11;	
	typedef logic 	[MAXCNT-1:0] 	cnt_frame_t;
	typedef logic          			ovf_frame_t;
	typedef struct {
		cnt_frame_t       TX_Frame_count;
		ovf_frame_t       frame_ovf;
	} cntr_frame_t;
	


	
endpackage