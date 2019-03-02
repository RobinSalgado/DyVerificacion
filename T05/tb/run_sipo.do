if [file exists work] {vdel -all}

vlib work

vlog -f files.f
onbreak {resume}

set NoQuitOnFinish 1

vsim -voptargs=+acc work.tb_sipo

do wave_sipo.do
run 1300ms
