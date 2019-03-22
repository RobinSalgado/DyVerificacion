if [file exists work] {vdel -all}

vlib work

vlog -f files.f

onbreak {resume}

set NoQuitOnFinish 1

vsim -voptargs=+acc work.TOP_MOD_TB
do wave_P1.do

run 1300ms