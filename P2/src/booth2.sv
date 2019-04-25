 
 module booth21(prod, busy, mc, mp, clk, start); 
	 output [31:0] prod; 			// result of the multiplication.
	 output busy; 						// become 1 when 16 cycles have passed. 
	 input [15:0] mc, mp;  		 	// Multiplicand &  Multiplier. 
	 input clk, start;				// clock & start: flag for loading mc, mp.
	 reg  [15:0] acc, q, m; 		// Accumulator, q:stores Multiplicand, m:stores Multiplier for always loop.
	 reg qn; 							// LSB of the array.
	 reg  [4:0] count;				// Counter of clk cycles.
	 wire [15:0] sum, difference; // Results of the adder_subtracter module.
	 
	 always_ff @(posedge clk) 
	 begin
		if (start) 
			begin 
			 acc <= 16'b0; 			// Initialize acumulator to 0.
			 m <= mc; 					// Load of Multiplicand.
			 q <= mp;					// Load of Multiplier.
			 qn <= 1'b0;				// Initialize LSB to 0.
			 count <= 5'b0; 			// Initialize counter to 0.
			end
			
	 else begin
	 
	 case ({q[0], qn}) 														   // 2 LSB of the array (case).	
		 2'b0_1 : {acc, q, qn} <= {sum[15], sum, q}; 					// acc + m & then SR.
		 2'b1_0 : {acc, q, qn} <= {difference[15], difference, q};  // acc - m & then SR. 
	 default: {acc, q, qn} <= {acc[15], acc, q}; 					   // SR acc without sum or substract in case (00 or 11).
	 endcase 
	 
	 count <= count + 1'b1; 
	 
			end 
	 end 
	 
	 alu adder (sum, acc, m, 1'b0); 
	 
	 alu subtracter (difference, acc, ~m, 1'b1); 
	 
	 assign prod = {acc, q}; 
	 assign busy = (count < 16);	// busy will tell when multiplication is ready,will be equal to 0 when count=16.
	 
	 endmodule 