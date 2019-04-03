
timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation. 

module tb_division;
    parameter WIDTH = 8;
    // Inputs
    reg [WIDTH-1:0] Q;
    reg [WIDTH-1:0] M;
	 reg clk;
	 reg rst;
    // Outputs
    wire [WIDTH-1:0] Rem;
	 wire  [WIDTH-1:0] Quo;

    // Instantiate the division module (UUT)
    division #(WIDTH) uut (
		  .clk(clk),
		  .rst(rst),
        .Q(Q), 
        .M(M), 
		  .Quo(Quo),
        .Rem(Rem)
    );

	 /*********************************************************/
initial // Clock generator
  begin
    forever #2 clk = !clk;
  end
/*********************************************************/
initial begin // reset generator
	#0 rst = 0;
	#5 rst = 1;
end

    initial begin
        // Initialize Inputs and wait for 100 ns
        Q = 0;  M = 0;  #100;  //Undefined inputs
        //Apply each set of inputs and wait for 100 ns.
        Q = -100;M = 10; #100;
        Q = -200;M = 40; #100;
        Q = -90; M = 9;  #100;
        Q = -70; M = 10; #100;
        Q = -16; M = 3;  #100;
        Q = -255;M = 5;  #100;
    end
      
endmodule
