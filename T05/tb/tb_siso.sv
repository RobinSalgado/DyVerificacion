//`timescale 1ns / 1ps

timeunit 1ns; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ns;// It specifies the resolution in the simulation.

module tb_siso;

logic           clk;
logic           rst;
logic           enb;
logic           inp;
logic           out;

logic [3:0]      rgstr_r;

siso uut(
.clk    (clk    ),
.rst    (rst    ),
.enb    (enb    ),
.inp    (inp    ),
.out    (out    )
);

initial begin
rst     = 0;
            clk     = 0;
            enb     = 0;
            inp     = 0;
            rst     = 1;
    #10.2   rst     = 0;
    #4.2    rst     = 1;
    #5      enb     = 1;
    #5      inp     = 1;
    #5      inp     = 0;
    #5      inp     = 1;
    #3      inp     = 0;
    #6      inp     = 1;
    #6      inp     = 0;
    #6      inp     = 1;
    #6      inp     = 0;
    #100

    $stop;
end

always begin
    #1 clk <= ~clk;
end

endmodule
