
import definitions_pkg::*;


 module Booth_Mult( 
 
	 input  clk,i_enb, rst,				   // clock & start: flag for loading mc, mp.
	 input  int8_t i_mc, i_mp,          // Multiplicand, Multiplier, 16bits result.
	 input  int8_t i_sum, i_diff,       // Results of the adder_subtracter module.
	 input logic [3:0] i_cnt,
	 input logic i_load,
	 input  i_ovf, i_clr,
	 output int16_t o_prod, 			   // result of the multiplication. 
	 output int8_t o_m, o_acc	 		   //	m:stores Multiplier for always loop, and Accumulator.
	  ); 
	 
	 int8_t q; 								  // q:stores Multiplicand, 											    
	 logic qn; 							     // LSB of the array.
	 
	 
	 
	 //or posedge i_clr
	 always_ff @( posedge clk or negedge rst or posedge i_clr ) begin

	  if ( !rst )
			begin
		     qn     <=   '0;						  // Initialize LSB to 0.
			  o_acc  <=   '0; 					     // Initialize acumulator to 0.
			  o_prod <=   '0;
			  q      <=   '0;						  // Load of Multiplier.
			  o_m    <=   '0;
	   end

	else if ( i_clr )
		  begin
		  
           qn     <=   '0;						  // Initialize LSB to 0.
			  o_acc  <=   '0; 					     // Initialize acumulator to 0.
			  o_prod <=   '0;
			  q      <=   '0;						  // Load of Multiplier.
			  o_m    <=   '0;
	    end
		
    
//	
//	  if ( i_load )
//	  begin 
//	  

	  
//	  end 
	  
	   else begin 
		
	  q<= i_mp;						     // Load of Multiplier.
	  o_m <= i_mc; 					  // Load of Multiplicand.
		
	  if ( i_enb ) 
			begin 					 
			
	 if ( !i_ovf ) begin
	 
	 case ({q[0], qn}) 													   // 2 LSB of the array (case).	
		 2'b0_1 : { o_acc, q, qn} <= { i_sum [7], i_sum , q}; 	      // acc + m & then SR.
		 2'b1_0 : { o_acc, q, qn} <= { i_diff[7], i_diff, q};      // acc - m & then SR. 
	    default: { o_acc, q, qn} <= { o_acc [7], o_acc , q}; 	   // SR acc without sum or substract in case (00 or 11).
	 endcase
	 
	 o_prod <= {o_acc, q};
	 
				end  // end of ovf
			end     // end of enable 
		 end       // end of else 
	 end          // end of alwyas_ff
	 
	 
	 endmodule 