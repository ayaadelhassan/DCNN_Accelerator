vsim work.fc_main
mem load -i {/home/mohamedsamy/CMP_3rd/2nd/VLSI/project/code/DCNN_Accelerator (copy)/FC/FC_mem.mem} /fc_main/mem/FCmemory
force -freeze sim:/fc_main/enable 1 0
force -freeze sim:/fc_main/reset 1 0
force -freeze sim:/fc_main/clk 1 0, 0 {50 ps} -r 100
add wave -position insertpoint  \
sim:/fc_main/enable \
sim:/fc_main/clk \
sim:/fc_main/finished
add wave -position insertpoint  \
sim:/fc_main/reset
add wave -position insertpoint  \
sim:/fc_main/write_enable \
sim:/fc_main/read_enable \
sim:/fc_main/layer
add wave -position insertpoint  \
sim:/fc_main/outputNodes1R
