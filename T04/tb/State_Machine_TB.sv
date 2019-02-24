
timeunit 1ms; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ms;// It specifies the resolution in the simulation.

module State_Machine_TB;


parameter CLK_FPGA = 500;		// Frecuencia del sistema.
parameter FREQ_DIVISOR = 1;				// Frecuencia deseada.

bit reset;
bit clk = 0;
//logic clk_Signal;



state_machine DUT

(
 .clk(clk),
 .rst(reset),
 .start(start),
 .out(out), 
 .clk_1hz(clk_1hz)
); 


//localparam DESIRED_FREQ = (CLK_FPGA/FREQ_DIVISOR)/2;	
//localparam BITS_CALCULATED = Calc_Bits(DESIRED_FREQ);	// Numero de bits que requerira el contador.
//logic [BITS_CALCULATED-1:0]i;			// Contador para generar la frecuencia deseada.

// Clock_Generator 
//
////  # (
////	 .CLK_FPGA(CLK_FPGA),		// Frecuencia del sistema.
////	 .FREQ_DIVISOR(FREQ_DIVISOR)			// Frecuencia deseada.
////	 )
//	 
//DUT
//(
//   .clk(clk),
//   .reset(reset),
//   .clk_Signal(clk_Signal)
//
//);



/*********************************************************/
initial // Clock generator
  begin
    forever #1 clk = !clk;
  end
/*********************************************************/
initial begin // reset generator
	#0 reset = 0;
	#5 reset = 1;

end
endmodule 