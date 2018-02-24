onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_testbench/A
add wave -noupdate /alu_testbench/B
add wave -noupdate /alu_testbench/cntrl
add wave -noupdate /alu_testbench/result
add wave -noupdate /alu_testbench/zero
add wave -noupdate /alu_testbench/overflow
add wave -noupdate /alu_testbench/carry_out
add wave -noupdate /alu_testbench/negative
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {18147 ps}
