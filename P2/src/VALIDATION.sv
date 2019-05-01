
import definitions_pkg::*;

module VALIDATION
(
input clk,
input rst,
input  op_t		OP,
input  [31:0] 	   PROD_OVF,
input  data_t     DATAX,
input  data_t		DATAY,
input 				Enable,
output 		      ERROR
);

logic E_Temp;
always_ff@(posedge clk or negedge rst) begin
    if(!rst)
        E_Temp  <= '0;
    else if (Enable)
		 begin
			if(OP == 1)	//division
				begin
					if( DATAY == 0)
						E_Temp <= 1;
					else
						E_Temp <= 0;
				end
			else if (OP == 2) //SQRT
				begin
					if (DATAY[15])
						E_Temp <= 1;
					else
						E_Temp <= 0;
				end
			else if (OP == 0)
			
				if (PROD_OVF[31:16] > 0)
					begin
						E_Temp <= 1;
					end			
				else 
					E_Temp <= 0;
			else
				E_Temp <= 0;
		 end
end

assign ERROR  = E_Temp;

endmodule
    