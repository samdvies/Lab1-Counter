#!/bin/bash

# Clean up previous build files
rm -rf obj_dir
rm -f counter.vcd

# Attach USB script
~/Documents/iac/lab0-devtools/tools/attach_usb.sh

# Compile SystemVerilog files with Verilator, including tracing and testbench
verilator -Wall --cc --trace top.sv counter.sv bin2bcd.sv --exe top_tb.cpp

# Build the model using make
make -j -C obj_dir/ -f Vtop.mk Vtop

# Run the generated model
obj_dir/Vtop
