if [file exists work] {vdel -all}

vlib work

vlog -f files.f

onbreak {resume}

set NoQuitOnFinish 1

vsim -voptargs=+acc work.tb_piso
do wave_piso.do

run 1300ms