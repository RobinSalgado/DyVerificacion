module P_cntrl 	
(
	input clk,
	input rst,
	input Enable,	//Enable del procesador (compartido con todos)
	input [3:0] MAT_SIZE,			
	output P1_EN,	//Enable del procesador (compartido con todos)
	output P2_EN,	//Enable del procesador (compartido con todos)
	output P3_EN,	//Enable del procesador (compartido con todos)
	output P4_EN	//Enable del procesador (compartido con todos)
);

reg [3:0] counter;
reg p1_reg;
reg p2_reg;
reg p3_reg;
reg p4_reg;

always_ff@(posedge clk or negedge rst)
	begin
		if(!rst)
			begin
				counter <= 4'b0;
				p1_reg <= '0;
				p2_reg <= '0;
				p3_reg <= '0;
				p4_reg <= '0;
			end
		else
			begin
				if(Enable)
					begin
						if(counter >=MAT_SIZE)
							counter <= counter;
						else
							begin
								counter = counter+1'b1;
						
								if(counter == 1)
									p1_reg <= 1;
								else if(counter == 2)
									p2_reg <= 1;
								else if(counter == 3)
									p3_reg <= 1;
								else if(counter == 4)
									p4_reg <= 1;
								else
									begin
									p1_reg <= p1_reg;
									p2_reg <= p2_reg;
									p3_reg <= p3_reg;
									p4_reg <= p4_reg;
									end
							end
					end
				else
					begin
						counter <= 4'b0;
						p1_reg <= '0;
						p2_reg <= '0;
						p3_reg <= '0;
						p4_reg <= '0;
					end
			end
	end

assign P1_EN = p1_reg;	//Enable del procesador (compartido con todos)
assign P2_EN = p2_reg;	//Enable del procesador (compartido con todos)
assign P3_EN = p3_reg;	//Enable del procesador (compartido con todos)
assign P4_EN = p4_reg;	//Enable del procesador (compartido con todos)

endmodule

