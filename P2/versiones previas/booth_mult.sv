
module booth_mult(prod, busy, mc, mp, clk, start); 

	 output [31:0] prod; 			// result of the multiplication.
	 output busy; 				// become 1 when 16 cycles have passed. 
	 input [15:0] mc, mp;  		 	// Multiplicand &  Multiplier. 
	 input clk, start;			// clock & start: flag for loading mc, mp.
	 reg  [15:0] acc, acc_ff, q, m; 	// Accumulator, q:stores Multiplicand, m:stores Multiplier for always loop.
	 reg qn; 				// LSB of the array.
	 reg  [4:0] count;			// Counter of clk cycles.
	 wire [15:0] sum, difference;           // Results of the adder_subtracter module.
	 reg Enable = 0,Enable2 = 0;
	 reg flag,flag2;
	 reg [15:0] q_ff;
	 reg qn_ff;
	 
	 always_ff @(posedge clk) 
	 begin
		q_ff <=q;
		qn_ff <=qn;
		acc_ff <= acc;
		
		if(count == 16) count<= 0;
		
	   if (start) 
			begin 
  			 count <= 5'b0; 			// Initialize counter to 0.
			end
	
	   else  begin
	     count <= count + 1'b1; 
				end 
	 end 

always @ * begin	 

  if (start) begin
	 m = mc; 			// Load of Multiplicand.
	 acc = 16'b0; 			// Initialize acumulator to 0.
	 q = mp;			// Load of Multiplier.
	 qn = 1'b0;			// Initialize LSB to 0.	
             end 
  
  else begin
  
        Enable = 1;
	Enable2 = 1;
			
	if (count < 16) begin
			
	 case ({q_ff[0], qn_ff}) 														   // 2 LSB of the array (case).	
		 2'b0_1 :begin	
		         {acc, q, qn} = {sum[15], sum, q_ff}; 			// acc + m & then SR.
			 end 
		 2'b1_0 :begin 
			 {acc, q, qn} = {difference[15], difference, q_ff};      // acc - m & then SR.
		         end
	 default: begin 
		 {acc, q, qn} = {acc_ff[15], acc_ff, q_ff}; 			 // SR acc without sum or substract in case (00 or 11).
		end
	 endcase 
    end 
  end
end
	 Adder A  (clk,rst,acc,m,Enable,sum,flag);
	 substactor S (clk,rst,acc,m,Enable2,difference,flag2);

	 assign prod = {acc, q}; 
	 assign busy = (count < 16);	// busy will tell when multiplication is ready,will be equal to 0 when count=16.
 
endmodule  
