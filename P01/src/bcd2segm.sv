
// Coder:           Robin Salgado  
// Date:            29 may 2019
// Name:            bcd2segm.sv
// Description:     This is the package of definitions for MDR


import definitions_pkg::*;

module bcd2segm
(
	// Input Ports
	input bcd_t i_BCD,
	input logic i_rdy,
	// Output Ports
	output segment_e o_display
);



//Case encargado de mostrar el numero correspondiente de la entra al display 
always_comb 
begin


		if ( i_rdy )
		begin
		
	case (i_BCD)
	
	   0 : o_display = ZERO;
      1 : o_display = ONE;
      2 : o_display = TWO;
      3 : o_display = TREE;
	   4 : o_display = FOUR;
      5 : o_display = FIVE;
      6 : o_display = SIX;
      7 : o_display = SEVEN;
      8 : o_display = EIGHT;
      9 : o_display = NINE;
		10: o_display = SIGN;

      default : o_display = OFF; 
    endcase
	 end 
	 
	 else  o_display = OFF; 
end 



endmodule