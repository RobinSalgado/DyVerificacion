

timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module Clock_Generator_TB;


parameter CLK_FPGA = 50_000_000;		// Frecuencia del sistema.
parameter FREQ_DIVISOR = 5_000_000;				// Frecuencia deseada.

	bit reset;
    bit clk = 0;
    logic clk_Signal;



localparam DESIRED_FREQ = CLK_FPGA/FREQ_DIVISOR;	
localparam BITS_CALCULATED = Calc_Bits(10);	// Numero de bits que requerira el contador.
logic [BITS_CALCULATED-1:0]i;			// Contador para generar la frecuencia deseada.

 Clock_Generator  

  # (
	 .CLK_FPGA(CLK_FPGA),		// Frecuencia del sistema.
	 .FREQ_DIVISOR(FREQ_DIVISOR)			// Frecuencia deseada.
	 )
	 
DUT
(
   .clk(clk),
   .reset(reset),
   .clk_Signal(clk_Signal)

);

/*********************************************************/
initial // Clock generator
  begin
    forever #2 clk = !clk;
  end
/*********************************************************/
initial begin // reset generator
	#0 reset = 0;
	#5 reset = 1;

end

function integer Calc_Bits;
	input integer input_Freq;
	integer i,bits;
   
	begin
		for(i=0; 2**i < input_Freq; i=i+1)
			bits = i + 1;
			Calc_Bits = bits;
	end
	
endfunction

endmodule 


