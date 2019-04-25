module boothDIV(
	 //inputs
	input clk,
	input rst,
	input load,
	input enable,
	input [15:0] Dividend, 
	input [15:0] Divisor, 	 
	 //outputs
	output [15:0]Quotient,
	output [15:0]Remainder,
	output busy,
	output done
	); 

	reg [15:0] A;
	reg [15:0] M;
	reg [15:0] Q;
	reg S;
	reg [15:0] QN;
	reg [15:0] count;
	reg DONE_TEMP;
	reg [15:0] SUM_RESULT;
	reg [15:0] SUB_RESULT;
	
	 always_ff @(posedge clk) 
	 begin
		if(!rst)
			begin
				A <= 16'b0;
				Q <= 16'b0;
				S <= 1'b0;
				M <= 16'b0;
				count <= 16;
				QN <= 16'b0;
				DONE_TEMP <= 0;
				SUM_RESULT <= 16'b0;
				SUB_RESULT <= 16'b0;
			end
		if (load == 1) 
			begin 
			 A <= 16'b0; 			// Initialize acumulator to 0.
			 Q <= Dividend; 					// Load of Multiplicand.
			 S <= 1'b0;					// Load of Multiplier.
			 count <= 16; 			
			 M <= Divisor;
			 QN <= 16'b0;
			 DONE_TEMP <= 0;
			end
		else if (enable == 1) 
			begin
				if ((Q[15] == 1'b0) && (M[15] == 1'b0))
					begin
						count <= count-1;
						{A,Q} <= {A[14:0],Q,1'b0};
						S <= A[15];
						if(A[15]==M[15])
							begin
								A <= SUB_RESULT;
							end
						else
								A <= SUM_RESULT;
						if(S == A[15])
							begin
								if(A == Q)
									QN <= QN + 1;
							end
						else
							begin
								if((A != 0) || (Q != 0))
									A <= 16'b0;
							end
						if (count == 0)
							begin
								DONE_TEMP <= 1;
							end
					end
					
				// -x/y	
					
			end	 
	 end 

	 
	 alu adder (SUM_RESULT, A, M, 1'b0); 
	 
	 alu subtracter (SUB_RESULT, A, ~M, 1'b1); 
	 
	 assign Quotient = QN; 
	 assign Remainder = A;	
	 assign done = DONE_TEMP;
endmodule 