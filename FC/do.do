vsim -gui work.main_testbench
mem load -i {D:/Projects/On GitHub acc/DCNN_Accelerator/FC/test.mem} -format mti /main_testbench/fc/mem
add wave -position insertpoint  \
sim:/main_testbench/enable \
sim:/main_testbench/clk \
sim:/main_testbench/finished \
sim:/main_testbench/reset \
sim:/main_testbench/result