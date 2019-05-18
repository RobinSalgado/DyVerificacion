//Coder:          Abisai Ramirez Perez
//Date:           03/31/2019
//Name:           dp_dc_ ram_if.sv
//Description:    This is the interface of a dual-port dual-clock random access memory. 

`ifndef DP_DC_RAM_IF_SV
    `define DP_DC_RAM_IF_SV

interface dp_dc_ram_if ();
import dp_dc_ram_pkg::*;

// Write enable signal
logic       we_a        ;   // Write enable
data_t      data_a      ;   // data to be stored
data_t      rd_data_a   ;   // read data from memory
addr_t      addr_a      ;   // Read write address

logic       we_b        ;   // Write enable
data_t      data_b      ;   // data to be stored
data_t      rd_data_b   ;   // read data from memory
addr_t      addr_b      ;   // Read write address

// Memory modport
modport mem (
input   we_a,
input   data_a,
input   addr_a,
output  rd_data_a,
input   we_b,
input   data_b,
input   addr_b,
output  rd_data_b
);

//Client modport
modport cln (
output  we_a,
output  data_a,
output  addr_a,
input   rd_data_a,
output  we_b,
output  data_b,
output  addr_b,
input   rd_data_b
);

endinterface
`endif
