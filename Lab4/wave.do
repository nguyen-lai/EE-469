onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label Clock /cpu_testbench/clk
add wave -noupdate -label Reset /cpu_testbench/reset
add wave -noupdate -label Instruction /cpu_testbench/dut/theDataPath/instruction
add wave -noupdate -label Registers /cpu_testbench/dut/theDataPath/RegisterFile/regOut
add wave -noupdate -label Memory /cpu_testbench/dut/theDataPath/theDataMem/mem
add wave -noupdate -label {Program Counter} /cpu_testbench/dut/FetchInstruction/storePC/out
add wave -noupdate -group Flags -label Negative {/cpu_testbench/dut/theDataPath/flags/q[3]}
add wave -noupdate -group Flags -label Zero {/cpu_testbench/dut/theDataPath/flags/q[2]}
add wave -noupdate -group Flags -label Overflow {/cpu_testbench/dut/theDataPath/flags/q[1]}
add wave -noupdate -group Flags -label CarryOut {/cpu_testbench/dut/theDataPath/flags/q[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {45263771 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 439
configure wave -valuecolwidth 416
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
WaveRestoreZoom {44070503 ps} {51627869 ps}
