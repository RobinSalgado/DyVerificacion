
// Coder:           Esteban González Moreno

// Date:            10 Mayo 2019

// Name:            cntr_DATA_tx_ovf.sv

// Description:     Counter used for counting the transmited bits in the data frame

`ifndef DP_DC_RAM_SV
    `define DP_DC_RAM_SV
	
	
module dp_dc_ram 
import dp_dc_ram_pkg::*;
(
// Core clock a
input   clk_a,
// Core clock b
input   clk_b,
// Memory interface
dp_dc_ram_if.mem mem_if
);

// Declare a RAM variable 
data_t  ram [W_DEPTH-1:0];

//Variable to hold the registered read adddres
data_t  addr_logic;

always_ff@(posedge clk_a) begin
if(mem_if.we_a)
    ram[mem_if.addr_a] <= mem_if.data_a;
else
    mem_if.rd_data_a <= ram [mem_if.addr_a];
end

always_ff@(posedge clk_b) begin
if(mem_if.we_b)
    ram[mem_if.addr_b] <= mem_if.data_b;
else
    mem_if.rd_data_b <= ram [mem_if.addr_b];
end

endmodule
`endif
