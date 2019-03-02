if [file exists work] {vdel -all}

vlib work

vlog -f files.f

onbreak {resume}

set NoQuitOnFinish 1

vsim -voptargs=+acc work.Universal_Register_TB
do wave_Universal_Register.do

run 1000ms