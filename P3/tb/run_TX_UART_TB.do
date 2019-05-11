if [file exists work] {vdel -all}

vlib work

vlog -f files_TX_UART.f

onbreak {resume}

set NoQuitOnFinish 1

vsim -voptargs=+acc work.UART_TX_TB
do wave_TX.do

run 500 ps