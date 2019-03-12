

module BCD_7seg
(
	// Input Ports
	input [3:0]BCD_input,
	
	// Output Ports
	output [6:0]segmento_output
	
);

reg [6:0]Wire;

//Case encargado de mostrar el numero correspondiente de la entra al display 
always_comb 
begin
	case (BCD_input)
	   0 : Wire = 7'b1000000;
      1 : Wire = 7'b1111001;
      2 : Wire = 7'b0100100;
      3 : Wire = 7'b0110000;
	   4 : Wire = 7'b0011001;
      5 : Wire = 7'b0010010;
      6 : Wire = 7'b0000010;
      7 : Wire = 7'b1111000;
      8 : Wire = 7'b0000000;
      9 : Wire = 7'b0010000;
      default : Wire = 7'b1111111; 
    endcase
end 

assign segmento_output = Wire;

endmodule
