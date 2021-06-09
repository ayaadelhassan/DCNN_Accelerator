vsim -gui work.comp_testbench
add wave -position insertpoint sim:/comp_testbench/*
force -freeze sim:/comp_testbench/clk 1 0, 0 {50 ps} -r 100
run
run
run
run
run
run
run
run
run
run
run
run