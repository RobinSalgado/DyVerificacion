onerror {resume}

quietly WaveActivateNextPane {} 0

add wave -noupdate /tb_sipo/uut/clk

add wave -noupdate /tb_sipo/uut/rst

add wave -noupdate /tb_sipo/uut/enb

add wave -noupdate /tb_sipo/uut/inp

add wave -noupdate /tb_sipo/uut/out

add wave -noupdate -expand /tb_sipo/out
TreeUpdate [SetDefaultTree]

WaveRestoreCursors {{Cursor 1} {0 ps} 0}

quietly wave cursor active 0

configure wave -namecolwidth 259

configure wave -valuecolwidth 40

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

WaveRestoreZoom {0 ps} {92197 ps}
