// Coder:           DSc Abisai Ramirez Perez
// Date:            31 April 2019
// Name:            dp_dc_ram_pkg.sv
// Description:     This is the package of single-port RAM
`ifndef DP_DC_RAM__PKG_SV
    `define DP_DC_RAM_PKG_SV
package dp_dc_ram_pkg ;

    localparam  W_DATA      = 5;
    localparam  W_ADDR      = 12;
    localparam  W_DEPTH     = 2**W_ADDR;

    typedef logic [W_DATA-1:0]        data_t;
    typedef logic [W_ADDR-1:0]        addr_t;

endpackage
`endif
