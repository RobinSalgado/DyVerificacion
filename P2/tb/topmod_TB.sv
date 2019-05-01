
import definitions_pkg::*;

timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.


module topmod_TB;
	//Inputs			
	bit clk;
	bit rst;										
	data_t Data;
	logic start;
	logic load;
	op_t op;
	logic ready;
	disp_seg_t ONES;
	disp_seg_t TENS;
	disp_seg_t HUNDREDS;
	disp_seg_t THOUSAND;
	disp_seg_t TEN_THOUSAND;
	logic sign;
	logic ERROR;
	data_t RESIDUE;

// WIRES
data_t Data_X_wire;
data_t Data_Y_wire;

logic WIRE_ERROR;
logic WIRE_LOAD_EN_X;
logic WIRE_LOAD_EN_Y;
logic WIRE_OP_EN;
logic WIRE_RDY_EN;
logic WIRE_ERROR_EN;
logic WIRE_VAL_EN;


logic start_WIRE;


data_t SUM_wire;
data_t SUB_wire;
data_t SQRT_Result_wire;
data_t SQRT_Residue_wire;
logic SQRT_RDY_wire;
data_t SQRT_TO_SUM_Y_Rest_wire;
data_t SQRT_TO_REST_wire;
data_t SQRT_TO_SUM_wire;

data_t DIV_Result_wire;
data_t DIV_Residue_wire;
logic DIV_RDY_wire;
data_t DIV_WIRE;
data_t DIV_WIRE_A;

data_t rest_part_1_wire;
data_t sum_part_1_wire;
data_t sum_part_2_wire;


logic [31:0] prod_wire;
logic MULT_RDY_wire;
data_t result_16_wire;
data_t m_wire;
data_t acc_wire;

data_t SQRT_result_wire;
data_t DIV_result_wire;
data_t MULT_result_wire;
data_t Out_mux_result_wire;

data_t SQRT_residue_wire;
data_t DIV_residue_wire;
data_t MULT_residue_wire;
data_t Out_mux_Residue_wire;
data_t Data_result_wire;
data_t Data_residue_wire;

bcd_t ONES_WIRE;
bcd_t TENS_WIRE;
bcd_t HUNDREDS_WIRE;
bcd_t THOUSAND_WIRE;
bcd_t TEN_THOUSAND_WIRE;

disp_seg_t ONES_DISP_WIRE;
disp_seg_t TENS_DISP_WIRE;
disp_seg_t HUNDREDS_DISP_WIRE;
disp_seg_t THOUSAND_DISP_WIRE;
disp_seg_t TEN_THOUSAND_DISP_WIRE;



logic RDY_wire;

topmod DUT
(
	.clk(clk),
	.rst(rst),
	.Data(Data),
	.start(start),
	.load(load),
	.op(op),
	
	
	.ready(ready),	
	.ONES(ONES),
	.TENS(TENS),
	.HUNDREDS(HUNDREDS),
	.THOUSAND(THOUSAND),
	.TEN_THOUSAND(TEN_THOUSAND),
	.sign(sign),
	.ERROR(ERROR),
	.RESIDUE(RESIDUE)


	//						output LED DISPLAY			// ESTO SE DEBE QUE VER EN EL DISPLAY DE 7 Segmentos
);

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
.LOAD(RDY_wire & ~WIRE_ERROR),
.DATA(Out_mux_result_wire),
.OUT(Data_result_wire)
);



PIPO PIPO_RESIDUE (
.clk(clk),
.rst(rst),
.LOAD(RDY_wire & ~WIRE_ERROR),
.DATA(Out_mux_Residue_wire),
.OUT(Data_residue_wire)
);


// VALIDATION

VALIDATION VAL_MODULE(
	.clk(clk),
	.rst(rst),
	.OP(op),
	.PROD_OVF(prod_wire),
	.DATAX(Data_X_wire),
	.DATAY(Data_Y_wire),
	.Enable(1'b1),//WIRE_VAL_EN),
	.ERROR(WIRE_ERROR)
);

// SQRT
SQRT SQRT_MOD
(
	//Inputs			
	.clk(clk),
	.rst(rst),										
	.enable(WIRE_VAL_EN), //Cambiar por enable de mux
	.Data(Data_Y_wire),
	
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
	.Residue(DIV_Residue_wire),//negated_shift_enable Tells you when it has finished so it stops the shifting
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
	.result_16b(MULT_result_wire), 
	.sum(SUM_wire), 
	.difference(SUB_wire), 
	.m(m_wire), 
	.acc(acc_wire)
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
	.REG2(DIV_WIRE_A ),
	.REG3(SQRT_TO_SUM_Y_Rest_wire),
	.Selector(op),
	.Enable(1'b1),
	// Output 
	.Output(sum_part_1_wire)
);


Multiplexor_3_1_15b   Mux_to_SUM_P2_MOD
(
	// Input 
	.REG1(m_wire),
	.REG2(DIV_WIRE ),
	.REG3(SQRT_TO_SUM_wire),
	.Selector(op),
	.Enable(1'b1),
	// Output 
	.Output(sum_part_2_wire)
);



Multiplexor_3_1_15b   Mux_to_REST_MOD
(
	// Input 
	.REG1(Data_X_wire),
	.REG2(DIV_WIRE ),
	.REG3(SQRT_TO_REST_wire),
	.Selector(op),
	.Enable(1'b1),
	// Output 
	.Output(rest_part_1_wire)
);



 
/*************/
/**************/
/***************/

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
	 .in2(DIV_Result_wire), 
	 .in3(SQRT_Result_wire), 
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
/*********************************************************/
initial // Clock generator
  begin
	 forever #2 clk = !clk;
  end


initial begin // multiplicand generator
		rst = 0;
		load = 0;
		Data = 0;
		start = 1;
		op = 2;
#10	rst = 1;
#10	Data = 7;
#20	load = 1;
		
#5		load = 0;
#10	Data = -50;
//#10	Data = 127;	//SQRT CHECK
		
#20	load = 1;
#5		load = 0;

#20	start = 0;
#5		start = 1;

end

  
endmodule 
