`timescale 1ps / 1ps

import Parameter_Definitions::*;

module TOP_MOD_TB;

	// Input Ports
	logic clk;
	logic rst;
	logic start;
	reg [NBits-1:0]Multiplier;
	reg [NBits-1:0]Multiplicand;
	
	// Output Ports 
	wire ready;
	
	wire [6:0] ONES;
	wire [6:0]TENS;
	wire [6:0]HUNDREDS;
	wire [6:0]THOUSAND;
	wire [6:0]TEN_THOUSAND;
	
	logic sign;

//WIRES
wire ovf_WIRE;
wire Force_reset_WIRE;
wire Ready_WIRE;
wire [2*NBits-1:0]Shifter_Left_WIRE;
wire [NBits-1:0]Shifter_Right_WIRE;

wire [2*NBits:0]Sum_WIRE;

wire SIGN_WIRE;
wire ADD_EN_WIRE;
wire [2*NBits-1:0] A2Comp_WIRE;

wire [2*NBits-1:0]Mult_Result_WIRE;

//assigns
wire [3:0]ONES_WIRE;
wire [3:0]TENS_WIRE;
wire [3:0]HUNDREDS_WIRE;
wire [3:0]THOUSAND_WIRE;
wire [1:0]TEN_THOUSAND_WIRE;

wire [6:0]ONES_DISP_WIRE;
wire [6:0]TENS_DISP_WIRE;
wire [6:0]HUNDREDS_DISP_WIRE;
wire [6:0]THOUSAND_DISP_WIRE;
wire [6:0]TEN_THOUSAND_DISP_WIRE;

wire [NBits-1:0] Multiplier_WIRE;
wire [NBits-1:0] Multiplicand_WIRE;
//assigns
assign ready = Ready_WIRE;
assign ONES = ONES_DISP_WIRE;
assign TENS = TENS_DISP_WIRE;
assign HUNDREDS = HUNDREDS_DISP_WIRE;
assign THOUSAND = THOUSAND_DISP_WIRE;
assign TEN_THOUSAND = TEN_THOUSAND_DISP_WIRE;

assign sign = SIGN_WIRE;

assign ADD_EN_WIRE = Shifter_Right_WIRE[0];

TOP_MOD uut
(
	.clk(clk),
	.rst(rst),
	.start(start),
	.Multiplier(Multiplier),
	.Multiplicand(Multiplicand),

	.ready(ready),
//						output LED DISPLAY			// ESTO SE DEBE QUE VER EN EL DISPLAY DE 7 Segmentos
	.ONES(ONES),
	.TENS(TENS),
	.HUNDREDS(HUNDREDS),
	.THOUSAND(THOUSAND),
	.TEN_THOUSAND(TEN_THOUSAND),
	.sign(sign)
);


/************************/
/*** Control Unit     ***/
/************************/


Control_Unit   Control_SM(
	//inputs
	.clk(clk),						//Internal clock
	.rst(rst),						//Master_Reset
	.start(start),					//Start the multiplication
	.counter_Flag(ovf_WIRE),
	//outputs
	.Force_reset(Force_reset_WIRE),				//Resets the register
	.ready(Ready_WIRE)					//Tells you when the multiplication has finished
);

/************************/
/***   Counter        ***/
/************************/



Counter		N_Bit_Counter
(
	//Inputs			
	.clk(clk),						
	.rst(Force_reset_WIRE),						//Reset the counter
	//.bits_till_ovf()				//Size of N-1 (number of bits to count -1) number of shifts
	//Output	
	.overflow(ovf_WIRE) 					//negated_shift_enable Tells you when it has finished so it stops the shifting
);

/************************/
/***   Shifter        ***/
/************************/

Register_Shifter		Reg_Shifter(
	.clk(clk),
	.rst(Force_reset_WIRE),
	.enb(ovf_WIRE),
	.inp_Multiplier(Multiplier_WIRE),
	.inp_Multiplicand(Multiplicand_WIRE),
	.out_Multiplier(Shifter_Left_WIRE),
	.out_Multiplicand(Shifter_Right_WIRE)
);


/************************/
/***   Sum Unit       ***/
/************************/


Adder		Adder_Unit_For_Multiplier(	
	//input
	.clk(clk),
	.rst(Force_reset_WIRE),
	.Number(Shifter_Left_WIRE),					//Multiplier
	.Enable(ADD_EN_WIRE),					//Enables the sum if its not enabled it gives the number 2 in the output
	//Output
	.Sum_Output(Sum_WIRE)				//Output of the sum
);

/************************/
/*** Sign Module      ***/
/************************/

SIGN		SIGN_MODULE(
	.Multiplicand(Multiplicand[NBits-1]),
	.Multiplier(Multiplier[NBits-1]),
	.start(start),
	.clk(clk),
	.rst(rst),
	.sign(SIGN_WIRE)
);

/************************/
/*** Two's complement ***/
/************************/


A2Comp		A2_output(
	//inputs	
	.Number_to_2_complement(Sum_WIRE),
	//outputs					
	.Result(A2Comp_WIRE)					//I need better names	
);

A2Comp_Multiplicands		A2_Multiplier(
	//inputs	
	.clk(clk),
	.rst(Force_reset_WIRE),
	.start(start),
	.Number_to_2_complement(Multiplier),

	//outputs					
	.Result(Multiplier_WIRE)					//I need better names	
);
A2Comp_Multiplicands		A2_Multiplicand(
	//inputs	
	.clk(clk),
	.rst(Force_reset_WIRE),
	.start(start),
	.Number_to_2_complement(Multiplicand),
	//outputs					
	.Result(Multiplicand_WIRE)					//I need better names	
);

/************************/
/***   Multiplexor    ***/
/************************/

Multiplexor		Multiplexor_Module(
	// Input 
	.Reg_Part1(Sum_WIRE),
	.CompA2(A2Comp_WIRE),
	.Selector(SIGN_WIRE),
	.Enable(Ready_WIRE),
	// Output 
	.Output(Mult_Result_WIRE)
);



binary_to_BCD_14   Display(
	.A(Sum_WIRE),
	.ONES(ONES_WIRE),
	.TENS(TENS_WIRE),
	.HUNDREDS(HUNDREDS_WIRE),
	.THOUSAND(THOUSAND_WIRE),
	.TEN_THOUSAND(TEN_THOUSAND_WIRE)
	);
	
BCD_7seg ones
(
	// Input Ports
	.BCD_input(ONES_WIRE),
	// Output Ports
	.segmento_output(ONES_DISP_WIRE)
);

BCD_7seg tens
(
	// Input Ports
	.BCD_input(TENS_WIRE),
	// Output Ports
	.segmento_output(TENS_DISP_WIRE)
);

BCD_7seg hundreds
(
	// Input Ports
	.BCD_input(HUNDREDS_WIRE),
	// Output Ports
	.segmento_output(HUNDREDS_DISP_WIRE)
);

BCD_7seg thousand
(
	// Input Ports
	.BCD_input(THOUSAND_WIRE),
	// Output Ports
	.segmento_output(THOUSAND_DISP_WIRE)
);
BCD_7seg ten_thousand
(
	// Input Ports
	.BCD_input(TEN_THOUSAND_WIRE),
	// Output Ports
	.segmento_output(TEN_THOUSAND_DISP_WIRE)
);
/*********************************************************/

/*********************************************************/
initial begin // reset generator
		clk = 0;
		start = 0;	
		rst = 1;
		Multiplier		= -3;
		Multiplicand   = -2;
	#4 rst = 0;
	#4 rst = 1;
	
	#20 start = 1;
	#4 start = 0;	
	
	Multiplier		= 5;
	Multiplicand   = 7;

	#50 start = 1;
	#4  start = 0;
	
	#50 Multiplier		= -1;
	    Multiplicand   = 2;

	
	#50   start = 1;
	#4  start = 0;
	
end/*********************************************************/

always begin
    #1 clk = ~clk;
end
endmodule 