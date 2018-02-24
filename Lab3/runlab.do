# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./cpu.sv"
vlog "./datapath.sv"
vlog "./controlSignals.sv"
vlog "./mux_5x2to1.sv"
vlog "./regfile.sv"
vlog "./zeroExtend.sv"
vlog "./signExtend.sv"
vlog "./mux_4to1.sv"
vlog "./alu.sv"
vlog "./datamem.sv"
vlog "./instructmem.sv"
vlog "./mux_64x2to1.sv"
vlog "./decoder_5to32.sv"
vlog "./mux_64x32to1.sv"
vlog "./decoder_3to8.sv"
vlog "./decoder_2to4.sv"
vlog "./register.sv"
vlog "./flagRegister.sv"
vlog "./mux_32to1.sv"
vlog "./mux_16to1.sv"
vlog "./mux_8to1.sv"
vlog "./mux_4to1.sv"
vlog "./mux_2to1.sv"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work cpu_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End