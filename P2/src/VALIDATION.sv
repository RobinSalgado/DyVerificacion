module VALIDATION
(
input clk,
input rst,
input  [1:0]		OP,
input  [15:0]     DATAX,
input  [15:0]		DATAY,
input 				Enable,
output 		      ERROR
);

logic E_Temp;
always_ff@(posedge clk or negedge rst) begin
    if(!rst)
        E_Temp  <= '0;
    else if (Enable)
		 begin
			if(OP == 2)	//division
				begin
					if( DATAY == 0)
						E_Temp <= 1;
					else
						E_Temp <= 0;
				end
		 end
end

assign ERROR  = E_Temp;

endmodule
    