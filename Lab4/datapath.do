onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath_testbench/reset
add wave -noupdate /datapath_testbench/clk
add wave -noupdate /datapath_testbench/instruction
add wave -noupdate -expand -group {Control Signals} /datapath_testbench/Reg2Loc
add wave -noupdate -expand -group {Control Signals} /datapath_testbench/RegWrite
add wave -noupdate -expand -group {Control Signals} /datapath_testbench/MemWrite
add wave -noupdate -expand -group {Control Signals} /datapath_testbench/MemToReg
add wave -noupdate -expand -group {Control Signals} /datapath_testbench/BrTaken
add wave -noupdate -expand -group {Control Signals} /datapath_testbench/UncondBr
add wave -noupdate -expand -group {Control Signals} /datapath_testbench/read_enable
add wave -noupdate /datapath_testbench/ALUSrc
add wave -noupdate /datapath_testbench/ALUOp
add wave -noupdate /datapath_testbench/xfer_size
add wave -noupdate /datapath_testbench/overflow
add wave -noupdate /datapath_testbench/negative
add wave -noupdate /datapath_testbench/zero
add wave -noupdate /datapath_testbench/carry_out
add wave -noupdate -label Aa /datapath_testbench/dut/RegisterFile/ReadRegister1
add wave -noupdate -label Ab /datapath_testbench/dut/RegToLocMux/out
add wave -noupdate -label Aw /datapath_testbench/dut/RegisterFile/WriteRegister
add wave -noupdate -label Da /datapath_testbench/dut/RegisterFile/ReadData1
add wave -noupdate -label Db /datapath_testbench/dut/RegisterFile/ReadData2
add wave -noupdate -label Imm12Extended /datapath_testbench/dut/Imm12/out
add wave -noupdate -label Registers /datapath_testbench/dut/RegisterFile/regOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {960052 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 397
configure wave -valuecolwidth 398
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
WaveRestoreZoom {417957 ps} {1714844 ps}
