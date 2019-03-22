
import Parameter_Definitions::*;

module TOP_MOD
(
	input clk,
	input rst,
	input start,
	input [NBits-1:0]Multiplier,
	input [NBits-1:0]Multiplicand,

	output ready,
	output [6:0]ONES,
	output [6:0]TENS,
	output [6:0]HUNDREDS,
	output [6:0]THOUSAND,
	output [6:0]TEN_THOUSAND,
	output sign,
	output pll
//						output LED DISPLAY			// ESTO SE DEBE QUE VER EN EL DISPLAY DE 7 Segmentos
);

//WIRES
wire ovf_WIRE;
wire ENABLE_FLAG_WIRE;
wire Ready_WIRE;
wire [2*NBits-1:0]Shifter_Left_WIRE;
wire [NBits-1:0]Shifter_Right_WIRE;

wire [2*NBits:0]Sum_WIRE;

wire SIGN_WIRE;
wire ADD_EN_WIRE;
wire [2*NBits-1:0] A2Comp_WIRE;

wire [2*NBits-1:0]Mult_Result_WIRE;
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

wire start_WIRE;

//assigns
assign ready = Ready_WIRE;
assign ONES = ONES_DISP_WIRE;
assign TENS = TENS_DISP_WIRE;
assign HUNDREDS = HUNDREDS_DISP_WIRE;
assign THOUSAND = THOUSAND_DISP_WIRE;
assign TEN_THOUSAND = TEN_THOUSAND_DISP_WIRE;

assign ADD_EN_WIRE = Shifter_Right_WIRE[0];

assign sign = SIGN_WIRE;
wire PLL_OUT_WIRE;
assign pll = PLL_OUT_WIRE;


//
// pll pll_top(
//	.areset(~rst),
//	.inclk0(clk),
//	.c0(PLL_OUT_WIRE)
//	);
	
/************************/
/*** Debouncer start  ***/
/************************/
debouncer debouncer_mod
(
	//Inputs			
	.clk(clk),
	.start(~start),
	.rst(rst),						//Reset the counter
	.debouncer_out(start_WIRE) 					//negated_shift_enable Tells you when it has finished so it stops the shifting
);




/************************/
/*** Control Unit     ***/
/************************/


Control_Unit   Control_SM(
	//inputs
	.clk(clk),						//Internal clock
	.rst(rst),						//Master_Reset
	.start(start_WIRE),					//Start the multiplication
	.counter_Flag(ovf_WIRE),
	//outputs
	.ENABLE_FLAG(ENABLE_FLAG_WIRE),				//Resets the register
	.ready(Ready_WIRE)					//Tells you when the multiplication has finished
);

/************************/
/***   Counter        ***/
/************************/

Counter		Bit_Count
(
	//Inputs			
	.clk(clk),
	.EF(ENABLE_FLAG_WIRE),
	.rst(rst),						//Reset the counter
	//.bits_till_ovf()				//Size of N-1 (number of bits to count -1) number of shifts
	//Output	
	.overflow(ovf_WIRE) 					//negated_shift_enable Tells you when it has finished so it stops the shifting
);

/************************/
/***   Shifter        ***/
/************************/

Register_Shifter		Reg_Shifter(
	.clk(clk),
	.EF(ENABLE_FLAG_WIRE),
	.rst(rst),
	.start(start_WIRE),
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
	.rst(rst),
	.EF(ENABLE_FLAG_WIRE),
	.start(start_WIRE),
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
	.start(start_WIRE),
	.clk(clk),
	.rst(rst),
	.sign(SIGN_WIRE)
);


A2Comp_Multiplicands		A2_Multiplier(
	//inputs	
	.clk(clk),
	.rst(rst),
	
	.start(start_WIRE),
	.Number_to_2_complement(Multiplier),
	//outputs					
	.Result(Multiplier_WIRE)						
);
A2Comp_Multiplicands		A2_Multiplicand(
	//inputs	
	.clk(clk),
	.rst(rst),
	.start(start_WIRE),
	.Number_to_2_complement(Multiplicand),
	//outputs					
	.Result(Multiplicand_WIRE)						
);



/*************/
/**************/
/***************/

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


endmodule

