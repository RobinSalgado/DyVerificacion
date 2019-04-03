
module booth(

	input  [15:0] m,
	input  [15:0] q,
	input      clk,
	//input 	  rst,
	output [31:0] out);
	
	reg [15:0] acc = 4'b0000;
	reg qn = 1'b0; 
	
	
	integer i; 
	logic [32:0]temp; 

	always @(posedge clk)
	begin 
		temp = {acc,q,qn};
		
		for (i = 0; i<16; i = i+1)
			begin 
				if (temp [1:0] == 2'b01)
					begin 
						temp[32:17] = temp[32:17] + m;
						temp = {temp[32],temp[32:1]};
					end 
				
						else if(temp[1:0] == 2'b10)
							begin 
								temp[32:17] = temp[32:17] - m;
								temp = {temp[32],temp[32:1]};
							end 
				else 
				temp = {temp[32],temp[32:1]};
			end 
	end 
	
	assign  out = temp[15:1];

	endmodule 
	
