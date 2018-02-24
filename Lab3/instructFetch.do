onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /instructFetch_testbench/reset
add wave -noupdate /instructFetch_testbench/clk
add wave -noupdate /instructFetch_testbench/instruction
add wave -noupdate /instructFetch_testbench/BrTaken
add wave -noupdate /instructFetch_testbench/UncondBr
add wave -noupdate /instructFetch_testbench/dut/currentPC
add wave -noupdate /instructFetch_testbench/dut/nextPC
add wave -noupdate /instructFetch_testbench/dut/condAddrExtended
add wave -noupdate /instructFetch_testbench/dut/brAddrExtended
add wave -noupdate /instructFetch_testbench/dut/UncondMuxOut
add wave -noupdate /instructFetch_testbench/dut/shifterOut
add wave -noupdate /instructFetch_testbench/dut/PCplusBranch
add wave -noupdate /instructFetch_testbench/dut/BrTakenOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4155993 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 246
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
WaveRestoreZoom {0 ps} {68543765 ps}
