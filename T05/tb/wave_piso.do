onerror {resume}

quietly WaveActivateNextPane {} 0

add wave -noupdate /tb_piso/uut/clk

add wave -noupdate /tb_piso/uut/rst

add wave -noupdate /tb_piso/uut/enb

add wave -noupdate /tb_piso/uut/l_s

add wave -noupdate -expand /tb_piso/uut/inp

add wave -noupdate /tb_piso/uut/out

add wave -noupdate /tb_piso/uut/left_right
add wave -noupdate -expand /tb_piso/uut/rgstr_r

TreeUpdate [SetDefaultTree]

WaveRestoreCursors {{Cursor 1} {91000 ps} 0}

quietly wave cursor active 1

configure wave -namecolwidth 150
configure wave -valuecolwidth 100

configure wave -justifyvalue left

configure wave -signalnamewidth 0

configure wave -snapdistance 10

configure wave -datasetprefix 0

configure wave -rowmargin 4

configure wave -childrowmargin 2

configure wave -gridoffset 0

configure wave -gridperiod 1

configure wave -griddelta 40

configure wave -timeline 0

configure wave -timelineunits ps

update

WaveRestoreZoom {0 ps} {210 ns}
