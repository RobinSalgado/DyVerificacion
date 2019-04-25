
timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.


module topmod_TB;
	//Inputs			
	bit clk;
	bit rst;										
	logic [15:0]Data;
	logic start;
	logic load;
	logic [1:0]op;
	logic ready;
	logic [6:0]ONES;
	logic [6:0]TENS;
	logic [6:0]HUNDREDS;
	logic [6:0]THOUSAND;
	logic [6:0]TEN_THOUSAND;
	logic sign;
	logic ERROR;
	
// WIRES
logic [15:0] Data_X_wire;
logic [15:0] Data_Y_wire;

logic WIRE_ERROR;
logic WIRE_LOAD_EN_X;
logic WIRE_LOAD_EN_Y;
logic WIRE_OP_EN;
logic WIRE_RDY_EN;
logic WIRE_ERROR_EN;
logic WIRE_VAL_EN;


logic start_WIRE;


logic [15:0]SUM_wire;
logic [15:0]SUB_wire;
logic [15:0] SQRT_Result_wire;
logic [15:0] SQRT_Residue_wire;
logic SQRT_RDY_wire;
logic [15:0]SQRT_TO_SUM_Y_Rest_wire;
logic [15:0]SQRT_TO_REST_wire;
logic [15:0]SQRT_TO_SUM_wire;

logic [15:0] DIV_Result_wire;
logic [15:0] DIV_Residue_wire;
logic DIV_RDY_wire;
logic [15:0] DIV_WIRE;
logic [15:0] DIV_WIRE_A;

logic [15:0] rest_part_1_wire;
logic [15:0] sum_part_1_wire;
logic [15:0] sum_part_2_wire;


logic [31:0] prod_wire;
logic MULT_RDY_wire;
logic [15:0] result_16_wire;
logic [15:0] m_wire;
logic [15:0] acc_wire;

wire [15:0] SQRT_result_wire;
wire [15:0] DIV_result_wire;
wire [15:0] MULT_result_wire;
wire [15:0] Out_mux_result_wire;

wire [15:0] SQRT_residue_wire;
wire [15:0] DIV_residue_wire;
wire [15:0] MULT_residue_wire;
wire [15:0] Out_mux_residue_wire;
wire [15:0] Data_result_wire;

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
	.ERROR(ERROR)

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
	.REG1(16'b0),
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
	.REG1(16'b0),
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
#10	Data = 3;
		
#20	load = 1;
#5		load = 0;

#20	start = 0;
#5		start = 1;

end

  
endmodule 
