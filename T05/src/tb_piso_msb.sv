`timescale 1ns / 1ps
module tb_piso_msb;

logic           clk;
logic           rst;
logic           enb;
logic           l_s;
logic [3:0]     inp;
logic           out;


piso_msb uut(
.clk    (clk    ),
.rst    (rst    ),
.enb    (enb    ),
.l_s    (l_s    ),
.inp    (inp    ),
.out    (out    )
);

initial begin
            rst     = 0;
            clk     = 0;
            enb     = 0;
            l_s     = 0;
            inp     = 0;
            rst     = 1;
    #10.2   rst     = 0;
    #4.2    rst     = 1;
    #5      enb     = 1;
    #5      l_s     = 1;
            inp     = $urandom%16;
    #2      l_s     = 0;
    #8      l_s     = 1;
            inp     = $urandom%16;
    #2      l_s     = 0;
    #8      l_s     = 1;
            inp     = $urandom%16;
    #2      l_s     = 0;
    #8      l_s     = 1;
            inp     = $urandom%16;
    #2      l_s     = 0;
    #8      l_s     = 1;
            inp     = $urandom%16;
    #2      l_s     = 0;
    #8      l_s     = 1;
            inp     = $urandom%16;
    #2      l_s     = 0;
    #8      l_s     = 1;
            inp     = $urandom%16;
    #2      l_s     = 0;
    #8      l_s     = 1;
            inp     = $urandom%16;
    #2      l_s     = 0;
    #8      l_s     = 1;
            inp     = $urandom%16;
    #2      l_s     = 0;
    #5      inp     = $urandom%16;
    #3      inp     = $urandom%16;
    #6      inp     = $urandom%16;
    #100
    $stop;
end
endmodule