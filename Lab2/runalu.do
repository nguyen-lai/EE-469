# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./alu.sv"
vlog "./alu1bit.sv"
vlog "./mux_8to1.sv"
vlog "./mux_4to1.sv"
vlog "./mux_2to1.sv"
vlog "./norGate_64input.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work alu_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do alu.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
