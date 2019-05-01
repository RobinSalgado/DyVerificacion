if [file exists work] {vdel -all}

vlib work

vlog -f files.f

onbreak {resume}

set NoQuitOnFinish 1

vsim -voptargs=+acc work.topmod_TB
do wave.do

run 500 ps