# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./regfile.sv"
vlog "./register.sv"
vlog "./D_FF.sv"
vlog "./decoder_2to4.sv"
vlog "./decoder_3to8.sv"
vlog "./decoder_5to32.sv"
vlog "./mux_64x32to1.sv"
vlog "./mux_2to1.sv"
vlog "./mux_4to1.sv"
vlog "./mux_8to1.sv"
vlog "./mux_16to1.sv"
vlog "./mux_32to1.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work regstim

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do regfilewave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
