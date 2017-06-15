# Set the working dir, where all compiled Verilog goes.

vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)


vlog -timescale 1ns/1ns regalu.v

# Load simulation using mux as the top level simulation module.
vsim regalu

# Log all signals and add some signals to waveform window.
log {/*}

# add wave {/*}would add all items in top level simulation module.
add wave {/*}

force {SW[3:0]} 2#0000
force {SW[9]} 0
force {SW[7:5]} 2#000
force {KEY[0]} 0

run 10ns

# First test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[3:0]} 2#0110
force {SW[9]} 1
force {SW[7:5]} 2#000
force {KEY[0]} 0

# Run simulation for a few ns.
run 10ns

force {KEY[0]} 1
run 10ns

# Set input values using the force command, signal names need to be in {} brackets.
force {SW[3:0]} 2#0001
force {SW[9]} 1
force {KEY[0]} 0

# Run simulation for a few ns.
run 10ns

force {KEY[0]} 1
run 10ns

# Set input values using the force command, signal names need to be in {} brackets.
force {SW[3:0]} 2#1001
force {SW[9]} 1
force {KEY[0]} 0

# Run simulation for a few ns.
run 10ns

force {KEY[0]} 1
run 10ns

# Set input values using the force command, signal names need to be in {} brackets.
force {SW[3:0]} 2#0001
force {SW[9]} 0
force {KEY[0]} 0

# Run simulation for a few ns.
run 10ns

force {KEY[0]} 1
run 10ns
