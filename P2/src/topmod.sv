
//import Parameter_Definitions::*;

module topmod
(
	input clk,
	input rst,
	input [15:0]Data,
	input start,
	input load,
	input [1:0]op,
	
	
	output ready,	
	output [6:0]ONES,
	output [6:0]TENS,
	output [6:0]HUNDREDS,
	output [6:0]THOUSAND,
	output [6:0]TEN_THOUSAND,
	output sign,
	output ERROR

	//						output LED DISPLAY			// ESTO SE DEBE QUE VER EN EL DISPLAY DE 7 Segmentos
);
// WIRES
wire [15:0] Data_X_wire;
wire [15:0] Data_Y_wire;

wire WIRE_ERROR;
wire WIRE_LOAD_EN_X;
wire WIRE_LOAD_EN_Y;
wire WIRE_OP_EN;
wire WIRE_RDY_EN;
wire WIRE_ERROR_EN;
wire WIRE_VAL_EN;


wire start_WIRE;


wire [15:0]SUM_wire;
wire [15:0]SUB_wire;
wire [15:0] SQRT_Result_wire;
wire [15:0] SQRT_Residue_wire;
wire SQRT_RDY_wire;
wire [15:0]SQRT_TO_SUM_Y_Rest_wire;
wire [15:0]SQRT_TO_REST_wire;
wire [15:0]SQRT_TO_SUM_wire;

wire [15:0] DIV_Result_wire;
wire [15:0] DIV_Residue_wire;
wire DIV_RDY_wire;
wire [15:0] DIV_WIRE;
wire [15:0] DIV_WIRE_A;

wire [15:0] sum_part_1_wire;
wire [15:0] rest_part_1_wire;
wire [15:0] sum_part_2_wire;


wire [31:0] prod_wire;
wire MULT_RDY_wire;
wire [15:0] result_16_wire;
wire [15:0] m_wire;
wire [15:0] acc_wire;

wire [15:0] SQRT_result_wire;
wire [15:0] DIV_result_wire;
wire [15:0] MULT_result_wire;
wire [15:0] Out_mux_result_wire;

wire [15:0] SQRT_residue_wire;
wire [15:0] DIV_residue_wire;
wire [15:0] MULT_residue_wire;
wire [15:0] Out_mux_residue_wire;
wire [15:0] Data_result_wire;

wire [3:0]ONES_WIRE;
wire [3:0]TENS_WIRE;
wire [3:0]HUNDREDS_WIRE;
wire [3:0]THOUSAND_WIRE;
wire [3:0]TEN_THOUSAND_WIRE;

wire [5:0] ONES_DISP_WIRE;
wire [5:0] TENS_DISP_WIRE;
wire [5:0] HUNDREDS_DISP_WIRE;
wire [5:0] THOUSAND_DISP_WIRE;
wire [5:0] TEN_THOUSAND_DISP_WIRE;

wire RDY_wire;

// ASSIGNS

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


//Control Unit

Control_Unit CU_MODULE
(
	//inputs
	. clk(clk),							//Internal clock
	. rst(rst),							//Master_Reset
	. start(start_WIRE),						//Start the operation
	. done(RDY_wire),							//Tell the control when the operation has finished
	. error(WIRE_ERROR),
	. Load(load),
	//outputs
	. Load_X(WIRE_LOAD_EN_X),					//Load x register
	. Load_y(WIRE_LOAD_EN_Y),					//Load y register
	. op_EN(WIRE_OP_EN),
	. ready(WIRE_RDY_EN),						//Tells you when the multiplication has finished
	. error_OUT(WIRE_ERROR_EN),
	. val(WIRE_VAL_EN)
);
/**********/

//PIPO MODULES
PIPO PIPO_X (
.clk(clk),
.rst(rst),
.LOAD(WIRE_LOAD_EN_X),
.DATA(Data),
.OUT(Data_X_wire)
);

PIPO PIPO_Y (
.clk(clk),
.rst(rst),
.LOAD(WIRE_LOAD_EN_Y),
.DATA(Data),
.OUT(Data_Y_wire)
);

PIPO PIPO_RESULT (
.clk(clk),
.rst(rst),
.LOAD(WIRE_RDY_EN),
.DATA(Out_mux_result_wire),
.OUT(Data_result_wire)
);



// VALIDATION

VALIDATION VAL_MODULE(
	.clk(clk),
	.rst(rst),
	.OP(op),
	.DATAX(Data_X_wire),
	.DATAY(Data_Y_wire),
	.Enable(WIRE_VAL_EN),
	.ERROR(WIRE_ERROR)
);

// SQRT
SQRT SQRT_MOD
(
	//Inputs			
	.clk(clk),
	.rst(rst),										
	.enable(WIRE_VAL_EN), //Cambiar por enable de mux
	.Data({Data_X_wire,Data_Y_wire}),
	
	.SUM(SUM_wire),
	.SUB(SUB_wire),

	.Result(SQRT_Result_wire),
	.Residue(SQRT_Residue_wire),//negated_shift_enable Tells you when it has finished so it stops the shifting
	.ready(SQRT_RDY_wire),	
	
	.Num_To_Sum_Y_Rest(SQRT_TO_SUM_Y_Rest_wire),
	.Num_To_rest2(SQRT_TO_REST_wire),
	.Num_To_Sum2(SQRT_TO_SUM_wire)
	);
	
//DIVISOR
DIVISOR DIV_MOD
(
	//Inputs			
	.clk(clk),
	.rst(rst),
	.start(start_WIRE),
	.enable(WIRE_OP_EN),
	.LOAD_Dividend(WIRE_LOAD_EN_X),
	.LOAD_Divisor(WIRE_LOAD_EN_Y),
	.Data(Data),
	
	.SUM(SUM_wire),
	.SUB(SUB_wire),
	
	.A(DIV_WIRE_A),
	.DIVISO(DIV_WIRE),
	
	.Result(DIV_Result_wire),
	.Residue(DIV_remainder_wire),//negated_shift_enable Tells you when it has finished so it stops the shifting
	.ready(DIV_RDY_wire)
);
//multiplicador

 Booth_Mult MULTIPLICATION_MOD
 (
	.prod(prod_wire), 
	.ready(MULT_RDY_wire), 
	.mc(Data_X_wire), 
	.mp(Data_Y_wire), 
	.clk(clk), 
	.start(WIRE_VAL_EN),
	.result_16b(result_16_wire), 
	.sum(SUM_wire), 
	.difference(SUB_wire), 
	.m(m_wire), 
	.acc(acc_wire),
	.residue(MULT_Residue_wire)
); 
 
//sumador
alu SUM_MOD(
	.a(sum_part_1_wire),
	.b(sum_part_2_wire),
	.cin(1'b0),
	.out(SUM_wire)
	);
//Restador
alu REST_MOD(
	.a(sum_part_1_wire),
	.b(~rest_part_1_wire),
	.cin(1'b1),
	.out(SUB_wire)
);


Multiplexor_3_1_15b   Mux_to_SUM_P1_MOD
(
	// Input 
	.REG1(acc_wire),
	.REG2(SQRT_TO_SUM_Y_Rest_wire),
	.REG3(DIV_WIRE_A),
	.Selector(op),
	.Enable(1'b1),
	// Output 
	.Output(sum_part_1_wire)
);


Multiplexor_3_1_15b   Mux_to_SUM_P2_MOD
(
	// Input 
	.REG1(m_wire),
	.REG2(SQRT_TO_SUM_wire),
	.REG3(DIV_WIRE),
	.Selector(op),
	.Enable(1'b1),
	// Output 
	.Output(sum_part_2_wire)
);



Multiplexor_3_1_15b   Mux_to_REST_MOD
(
	// Input 
	.REG1(16'b0),
	.REG2(SQRT_TO_REST_wire),
	.REG3(DIV_WIRE),
	.Selector(op),
	.Enable(1'b1),
	// Output 
	.Output(rest_part_1_wire)
);

// SEÑAL DE FINALIZADO
Multiplexor_3_1_15b   Mux_RDY_MOD
(
	// Input 
	.REG1({15'b0,MULT_RDY_wire}),
	.REG2({15'b0,DIV_RDY_wire}),
	.REG3({15'b0,SQRT_RDY_wire}),
	.Selector(op),
	.Enable(1'b1),
	// Output 
	.Output(RDY_wire)
);

 Multiplexer_With_Case Mux_results
 (
 
	 .in1(MULT_result_wire), 
	 .in2(DIV_result_wire), 
	 .in3(SQRT_result_wire), 
	 .sel(op), 
	 .out(Out_mux_result_wire)
 );

 Multiplexer_With_Case Mux_Residues
 (
 
	 .in1(MULT_Residue_wire), 
	 .in2(DIV_Residue_wire), 
	 .in3(SQRT_Residue_wire), 
	 .sel(op), 
	 .out(Out_mux_Residue_wire)
 );

 
 
/*************/
/**************/
/***************/

Binary_BCD_16  B_BCD(
	.A(Data_result_wire),
	.ONES(ONES_WIRE),
	.TENS(TENS_WIRE),
	.HUNDREDS(HUNDREDS_WIRE),
	.THOUSANDS(THOUSAND_WIRE),
	.TEN_THOUSANDS(TEN_THOUSAND_WIRE)
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

         assign  ONES = ONES_DISP_WIRE;
	 assign  TENS = TENS_DISP_WIRE;
	 assign  HUNDREDS = HUNDREDS_DISP_WIRE;
	 assign  THOUSAND = THOUSAND_DISP_WIRE;
	 assign  TEN_THOUSAND = TEN_THOUSAND_DISP_WIRE;

 endmodule
