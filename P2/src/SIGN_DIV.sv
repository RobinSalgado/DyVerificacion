module SIGN_DIV (
	input Divisor_Sign,
	input Dividend_Sign,
	input [15:0]Result_RAW,
	input [15:0]Residue_RAW,
	output [15:0]Result,
	output [15:0]Residue
);
reg [15:0] REG_RESULT;
reg [15:0] REG_RESIDUE;
reg [1:0] temp;
always_comb
	begin
		temp = {Dividend_Sign,Divisor_Sign};
		if(Dividend_Sign == 1'b1)	//0 1
			begin
				if(Divisor_Sign == 1'b1)
					begin
						REG_RESULT = Result_RAW;						
						REG_RESIDUE = Residue_RAW;
					end
				else
					begin
						REG_RESULT = ~Result_RAW + 1'b1;
						REG_RESIDUE = Residue_RAW ;
					end
			end
		else
			begin
				if (Divisor_Sign == 1'b0)
					begin
						REG_RESULT  =  Result_RAW ;
						REG_RESIDUE = Residue_RAW;
					end
				else
					begin
						REG_RESULT = ~Result_RAW +1'b1;
						REG_RESIDUE = Residue_RAW;
					end
			end
	end
assign	Result	= REG_RESULT;
assign	Residue  = REG_RESIDUE;
endmodule