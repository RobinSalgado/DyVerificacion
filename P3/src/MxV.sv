// Coder:           Esteban González Moreno

// Date:            07 Mayo 2019

// Name:            TOP_MODULE.sv

// Description:     This is the TOP Module



import Definitions_Package::*;

module MxV(
	input 					clk,
	input 					rst,
	input word_lenght_t 	REC_DATA,
	input 					REC_DONE,
	input 					ENABLE,
	output word_lenght_t DATA_OUT
);

wire [7:0] wire_ADDR;
wire wire_clk_DIV;
wire wire_RAM_OUT;
wire wire_TX_DONE;
wire wire_OP_DONE;
wire wire_SIZE_EN;
wire wire_ASSIGN_EN;
wire wire_OP_EN;
wire wire_TX_EN;
wire wire_CLEAR_EN;
wire wire_DL_EN;

wire [3:0]	wire_VEC_N;
wire [7:0]	wire_DATA_FEED;

wire EN_MAT;
wire EN_VEC;

wire [7:0] wire_REC_DATA;
// DATA ASSIGNMENT MODULE
DATA_FEEDER DATA_FEEDER_MOD(
	.clk(clk),
	.rst(rst),
	
	.SIZE_M_EN(wire_SIZE_EN & ENABLE),
	.REC_DATA(wire_REC_DATA),
	.ENB_ASSIGN(wire_ASSIGN_EN & ENABLE),
	.Enable_MAT(EN_MAT),
	.Enable_VEC(EN_VEC),
	.ADDR(wire_ADDR),
	.RAM_Num(wire_RAM_EN),
	.DATA(wire_DATA_FEED),
	.PIPO_VEC(wire_VEC_N)
);

//DATA PIPO

PIPO PIPO_MxV_MOD
(
	.clk(clk),
	.rst(rst),
	.LOAD(ENABLE),
	.DATA(REC_DATA),
	.OUT(wire_REC_DATA)
);


// MxV STATE MACHINE  NEED TO CHANGE THE NAME OF DATA_FEED_SM
MxV_SM MxV_SM_MOD(
	.clk(clk),
	.rst(rst),
	.REC_DATA(wire_REC_DATA),
	.Enable(ENABLE),
	.DONE_TRANSMITION(wire_TX_DONE),
	.OP_DONE(wire_OP_DONE),
	//outputs
	.MAT_SIZE_EN(wire_SIZE_EN),
	.DATA_ASSIGN_EN(wire_ASSIGN_EN),
	.OPERATION_EN(wire_OP_EN),
	.TRANSMIT_EN(wire_TX_EN),
	.CLEAR_EN(wire_CLEAR_EN),
	.DL_EN(wire_DL_EN),					//DATA LENGHT ENABLE
	.VEC_EN(EN_VEC),
	.MAT_EN(EN_MAT)
);

// TRANSMITION MODULE

//PIPO_ USED FOR....something

// OPERATION MODULE

//RAM



//
//DC_RAM DC_RAM_MOD(
//	.clk_A(clk)
//	.clk_B(wire_clk_DIV)
//	.ADDR(wire_ADDR)
//	.ENABLE(wire_RAM_EN)
//	.DATA_IN(REC_DATA)
//	.DATA_OUT(wire_RAM_OUT)
//);

endmodule
