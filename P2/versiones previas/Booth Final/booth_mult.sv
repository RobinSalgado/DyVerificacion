
module booth_mult(Sum_Output,difference_Output,prod,ovf, mc, mp, clk, start, out_acc, count_till_ovf); 
		
		
	 output [31:0] prod; 			   // result of the multiplication.
	 output [15:0]out_acc;
	 input reg ovf;
	 input reg [15:0]count_till_ovf;
	 input reg [15:0]Sum_Output;
	 input reg [15:0]difference_Output;
	 input [15:0] mc, mp;  		 	   // Multiplicand &  Multiplier. 
	 input clk, start;			      // clock & start: flag for loading mc, mp.
	 reg  [15:0] acc, acc_ff, q, m; 	// Accumulator, q:stores Multiplicand, m:stores Multiplier for always loop.
	 reg qn; 				            // LSB of the array.
	 reg  [15:0] count;			      // Counter of clk cycles.
	 reg Enable = 0,Enable2 = 0;
	 reg flag,flag2;
	 reg [15:0] q_ff;
	 reg qn_ff;
	 
	
	 always_ff @(posedge clk) 
	 begin
		q_ff <=q;
		qn_ff <=qn;
		acc_ff <= acc;
		
		
	   if (start) 
			begin 
  			 count <= 5'b0; 			// Initialize counter to 0.
			end

	 end 

always @ * begin	 

  if (start) begin
	 m = mc; 			   // Load of Multiplicand.
	 acc = 16'b0; 			// Initialize acumulator to 0.
	 q = mp;			      // Load of Multiplier.
	 qn = 1'b0;			   // Initialize LSB to 0.	
             end 
  
  else begin
  
        Enable = 1;
	     Enable2 = 1;
			
	if (!ovf) begin
			
	 case ({q_ff[0], qn_ff}) 														   // 2 LSB of the array (case).	
		 2'b0_1 :begin	
		         {acc, q, qn} = {Sum_Output[15], Sum_Output, q_ff}; 			// acc + m & then SR.
			 end 
		 2'b1_0 :begin 
			 {acc, q, qn} = {difference_Output[15], difference_Output, q_ff};      // acc - m & then SR.
		         end
	 default: begin 
		 {acc, q, qn} = {acc_ff[15], acc_ff, q_ff}; 			 // SR acc without sum or substract in case (00 or 11).
		end
	 endcase 
    end //end if
		
  end
end


	 assign prod = {acc, q};
	 assign out_acc = acc; 

 
endmodule  
