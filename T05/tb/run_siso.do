if [file exists work] {vdel -all}

vlib work

vlog -f files.f

onbreak {resume}

set NoQuitOnFinish 1

vsim -voptargs=+acc work.tb_siso
do wave_siso.do

run 500ms
