

// Coder			: Robin Salgado 
// Name 			: twos_comp.sv
// Date 			: 30 May 2019
// Description : Converts a binary number into a twos comp respresentation.
import definitions_pkg::*;

module twos_comp_out ( i_data, o_data, o_sign);

input  int16_t i_data;
output int16_t o_data;
output sgmnt_e o_sign; 

int16_t data_temp;

 always@* begin 
  
 if (i_data[15]) begin 
 o_sign = TEN;	
 data_temp = ~(i_data);
 data_temp = data_temp + 1'b1;  
	end // end of if 

 else begin 
	data_temp = i_data;
	o_sign = OFF;

	end // end of else 
end // end of always 

assign o_data = data_temp;

endmodule 