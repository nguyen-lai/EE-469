onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_testbench/dut/theIFStage/clk
add wave -noupdate /cpu_testbench/dut/theIFStage/reset
add wave -noupdate /cpu_testbench/dut/theIFStage/currentPC
add wave -noupdate /cpu_testbench/dut/theIFStage/nextPC
add wave -noupdate /cpu_testbench/dut/theIFStage/instruction
add wave -noupdate -radix unsigned /cpu_testbench/dut/theIFIDpipe/IF_PC
add wave -noupdate -radix unsigned /cpu_testbench/dut/theIFStage/nextPC
add wave -noupdate /cpu_testbench/dut/theIFIDpipe/ID_PC
add wave -noupdate /cpu_testbench/dut/theIFIDpipe/IF_instruction
add wave -noupdate /cpu_testbench/dut/theIFIDpipe/ID_instruction
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {843202 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 296
configure wave -valuecolwidth 232
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
WaveRestoreZoom {0 ps} {3944979 ps}
