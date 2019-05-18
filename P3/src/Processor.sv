
// Coder:           Esteban González Moreno

// Date:            012 Mayo 2019

// Name:            Processor.sv

// Description:     This is the Processor Module



import Definitions_Package::*;

module Processor(
	//inputs
input clk,
input rst,
input ENABLE,				//Operation Enable
input SIZE_M_EN,			//Save the matrix size wire_SIZE_EN
input [3:0]REC_DATA,			//Se usa para guardar el tamaño de la matriz

input [63:0] DATA_VEC,			//DATA FROM VECTOR wire_VEC_DATA

input [31:0] DATA_M2P,			//Data from RAM 32 bits separated by 8 8 8 8 

//outputs
output [15:0]RAM_SEL_P,			//Select ram to read 16 bits 4 4 4 4
output [15:0]RAM_ADDR_P,		//addres of ram to read 16 bits 4 4 4 4


output OP_DONE,			//Tells when the operation is done
output [159:0] DATA_OUT			//Resultado del tamaño del vector mat size
);
	
wire [3:0] 	wire_Matrix_SIZE;


wire wire_P1_EN;
wire wire_P2_EN;
wire wire_P3_EN;
wire wire_P4_EN;

//Mux vector select for processor
wire [3:0] wire_RAM_P1;
wire [3:0] wire_RAM_P2;
wire [3:0] wire_RAM_P3;
wire [3:0] wire_RAM_P4;

wire [7:0]wire_vector_P1;
wire [7:0]wire_vector_P2;
wire [7:0]wire_vector_P3;
wire [7:0]wire_vector_P4;

wire [3:0]wire_ADDR_P1;
wire [3:0]wire_ADDR_P2;
wire [3:0]wire_ADDR_P3;
wire [3:0]wire_ADDR_P4;

wire [19:0] wire_P1_OUT;
wire [19:0] wire_P2_OUT;
wire [19:0] wire_P3_OUT;
wire [19:0] wire_P4_OUT;

wire [19:0]wire_LD1;
wire [19:0]wire_LD2;
wire [19:0]wire_LD3;
wire [19:0]wire_LD4;


wire [159:0] wire_Last_Data_out;

// PROCESOR CONTROLLER
P_cntrl P_cntrl_MOD		
(
	.clk(clk),
	.rst(rst),
	.Enable(ENABLE),	//Enable del procesador (compartido con todos)
	.MAT_SIZE(wire_Matrix_SIZE),			
	.P1_EN(wire_P1_EN),	//Enable del procesador (compartido con todos)
	.P2_EN(wire_P2_EN),	//Enable del procesador (compartido con todos)
	.P3_EN(wire_P3_EN),	//Enable del procesador (compartido con todos)
	.P4_EN(wire_P4_EN)	//Enable del procesador (compartido con todos)
);

//PIPO TO SAVE THE MAT SIZE
PIPO_MAT_SIZE PIPO_MAT_SIZE_MOD( //saves the value of the matrix
	//inputs
	.clk(clk),
	.rst(rst),
	.SIZE_M_EN(SIZE_M_EN),
	.REC_DATA(REC_DATA),
	
	//outputs
	.MAT_SIZE(wire_Matrix_SIZE)
);

//PROCESSOR BLOCK how to enable?
//Dependiendo del tamaño de la matriz
//tiene que ver que ram leer y la dirección,
//y su salida se tiene que asignar a un BIG PIPO
//en la posiccion adecuada. es decir en el ADDR
P_block P_block_MOD1		
(
	.clk(clk),
	.rst(rst),
	.Enable(wire_P1_EN),	//Enable del procesador (compartido con todos)
	.MAT_SIZE(wire_Matrix_SIZE),			
	.P_NUM(3'b000),		//Num del procesador
	//outputs
	.Last_data(wire_LD1),
	.Vector_IN(wire_vector_P1),
	.DATA_RAM(DATA_M2P[7:0]),
	.ADDR(wire_ADDR_P1),
	.RAM(wire_RAM_P1),
	.OUTPUT(wire_P1_OUT)
	//DONE signal
);

P_block P_block_MOD2		
(
	.clk(clk),
	.rst(rst),
	.Enable(wire_P2_EN),	//Enable del procesador (compartido con todos)
	.MAT_SIZE(wire_Matrix_SIZE),			
	.P_NUM(3'b001),		//Num del procesador
	//outputs
	.Last_data(wire_LD2),
	.Vector_IN(wire_vector_P2),
	.DATA_RAM(DATA_M2P[15:8]),
	.ADDR(wire_ADDR_P2),
	.RAM(wire_RAM_P2),
	.OUTPUT(wire_P2_OUT)
	//DONE signal
);
//
P_block P_block_MOD3		
(
	.clk(clk),
	.rst(rst),
	.Enable(wire_P3_EN),	//Enable del procesador (compartido con todos)
	.MAT_SIZE(wire_Matrix_SIZE),			
	.P_NUM(3'b010),		//Num del procesador
	//outputs
	.Last_data(wire_LD3),
	.Vector_IN(wire_vector_P3),
	.DATA_RAM(DATA_M2P[23:16]),
	.ADDR(wire_ADDR_P3),
	.RAM(wire_RAM_P3),
	.OUTPUT(wire_P3_OUT)
	//DONE signal
);
//
P_block P_block_MOD4	
(
	.clk(clk),
	.rst(rst),
	.Enable(wire_P4_EN),	//Enable del procesador (compartido con todos)
	.MAT_SIZE(wire_Matrix_SIZE),			
	.P_NUM(3'b011),		//Num del procesador
	//outputs
	.Last_data(wire_LD4),
	.Vector_IN(wire_vector_P4),
	.DATA_RAM(DATA_M2P[31:24]),
	.ADDR(wire_ADDR_P4),
	.RAM(wire_RAM_P4),
	.OUTPUT(wire_P4_OUT)
	//DONE signal
);

//Vector Selector for EACH Procesor

comb_v2p  comb_v2p_MOD
(
.clk(clk),
	.rst(rst),
	.in(DATA_VEC),
	.sel_1(wire_RAM_P1),
	.sel_2(wire_RAM_P2),
	.sel_3(wire_RAM_P3),
	.sel_4(wire_RAM_P4),
	
	.in_LD({wire_P1_OUT,wire_P2_OUT,wire_P3_OUT,wire_P4_OUT,20'b0}),

	
	.in_Addr1(wire_ADDR_P1),
	.in_Addr2(wire_ADDR_P2),
	.in_Addr3(wire_ADDR_P3),
	.in_Addr4(wire_ADDR_P4),
	
	.out_P1(wire_vector_P1),
	.out_P2(wire_vector_P2),
	.out_P3(wire_vector_P3),
	.out_P4(wire_vector_P4),
	
	.out_LD1(wire_LD1),
	.out_LD2(wire_LD2),
	.out_LD3(wire_LD3),
	.out_LD4(wire_LD4),
	.RES(wire_Last_Data_out)
	
);
//Last Data block?
Last_Data Last_Data_MOD(
	.clk(clk),
	.rst(rst),
	.IN_P1(wire_P1_OUT),
	.IN_P2(wire_P2_OUT),
	.IN_P3(wire_P3_OUT),
	.IN_P4(wire_P4_OUT),
	
	.P1_EN(wire_P1_EN),
	.P2_EN(wire_P2_EN),
	.P3_EN(wire_P3_EN),
	.P4_EN(wire_P4_EN),
	
	.P1_ADDR(wire_ADDR_P1),
	.P2_ADDR(wire_ADDR_P2),
	.P3_ADDR(wire_ADDR_P3),
	.P4_ADDR(wire_ADDR_P4),
	.OUT_LD(wire_Last_Data_out),
	.temp()
);



//outputs
assign RAM_SEL_P = {wire_RAM_P1,wire_RAM_P2,wire_RAM_P3,wire_RAM_P4};		//Select ram to read 16 bits 4 4 4 4
assign RAM_ADDR_P = {wire_ADDR_P1,wire_ADDR_P2,wire_ADDR_P3,wire_ADDR_P4};		//addres of ram to read 16 bits 4 4 4 4


assign OP_DONE = 1'b0; 			//Tells when the operation is done
assign  DATA_OUT = wire_Last_Data_out;			//Resultado del tamaño del vector mat size

endmodule
