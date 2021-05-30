vsim -gui work.main_testbench
mem load -i {/home/mohamedsamy/CMP_3rd/2nd/VLSI/project/code/DCNN_Accelerator (copy)/FC/test.mem} -format mti /main_testbench/fc/mem
add wave -position insertpoint  \
sim:/main_testbench/enable \
sim:/main_testbench/clk \
sim:/main_testbench/finished \
sim:/main_testbench/reset \
sim:/main_testbench/result
force -freeze sim:/main_testbench/clk 1 0, 0 {50 ps} -r 100
run 640 ns
