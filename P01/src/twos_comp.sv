// Coder			: Robin Salgado 
// Name 			: twos_comp.sv
// Date 			: 30 May 2019
// Description : Converts a binary number into a twos comp respresentation.
import definitions_pkg::*;

module twos_comp( i_data, o_data, o_sign);

input  int8_t i_data;
output int8_t o_data;
output segment_e o_sign; 

int8_t data_temp;

 always@* begin 
  
 if (i_data[7]) begin 
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