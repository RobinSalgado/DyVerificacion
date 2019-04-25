 
 module Booth_Mult(prod, ready, mc, mp, clk, rst, start,result_16b, sum, difference, m, acc); 
 
    input  logic [15:0] sum, difference;    // Results of the adder_subtracter module.
	 input  clk,rst, start;				     // clock & start: flag for loading mc, mp.
	 input  [15:0] mc, mp;             // Multiplicand, Multiplier, 16bits result.
	 output [31:0] prod; 			     // result of the multiplication.
	 output [15:0] result_16b;				//result limited to 16 bits.
	 output logic [15:0] m,acc; 			// Multiplicand and accumulator out to adder_subtractor.
	 output ready; 						   // become 1 when 16 cycles have passed. 
	  
	 reg  [15:0]q; 		// Accumulator, q:stores Multiplicand, m:stores Multiplier for always loop.
	 reg qn; 							// LSB of the array.
	 reg  [4:0] count;				// Counter of clk cycles.
	
	 
	 
	 always_ff @(posedge clk) 
		 begin
		 
		 if (!rst)
			begin
			acc <= 16'b0; 			// Initialize acumulator to 0.
			m <= 1'b0; 					// Load of Multiplicand.
			q <= 1'b0;					// Load of Multiplier.
			qn <= 1'b0;				// Initialize LSB to 0.
			count <= 5'b0; 			// Initialize counter to 0.
			
			end
			
		 else 
				begin
		 
			if (start) 
				begin 
					 acc <= 16'b0; 			// Initialize acumulator to 0.
					 m <= mc; 					// Load of Multiplicand.
					 q <= mp;					// Load of Multiplier.
					 qn <= 1'b0;				// Initialize LSB to 0.
					 count <= 5'b0; 			// Initialize counter to 0.
				end				
			 else 
				begin
			  
					if ( count < 16 )
						begin
		 
							 case ({q[0], qn}) 														   // 2 LSB of the array (case).	
									2'b0_1 : 
										begin 
											{acc, q, qn} <= {sum[15], sum, q}; 					// acc + m & then SR.
										end
									2'b1_0: 
										begin
											{acc, q, qn} <= {difference[15], difference, q};  // acc - m & then SR. 
										end
									default:   
										begin
											{acc, q, qn} <= {acc[15], acc, q}; 					// SR acc without sum or substract in case (00 or 11).
										end
							 endcase 			 
							 count <= count + 1'b1; 		 
						end 
					else
						begin
							count <= count;															//Stop counting					
								end
					end 
			end
	 end

	 assign prod = {acc, q}; 
	 assign result_16b = prod[15:0];
	 assign ready = (count < 16);	// ready will tell when multiplication is ready,will be equal to 0 when count=16.
	 
	 endmodule 