vsim work.fc_mains
mem load -i {C:/Users/Omar Salama/Desktop/My_Files/Uni/3rd Year/Second Semester/VLSI/project/DCNN_Accelerator/FC/FC_mem.mem} -update_properties /fc_mains/mem
force -freeze sim:/fc_mains/enable 1 0
force -freeze sim:/fc_mains/reset 1 0
force -freeze sim:/fc_mains/clk 1 0, 0 {50 ps} -r 100
add wave -position insertpoint  \
sim:/fc_mains/enable \
sim:/fc_mains/clk \
sim:/fc_mains/finished
add wave -position insertpoint  \
sim:/fc_mains/reset
add wave -position insertpoint  \
sim:/fc_mains/write_enable \
sim:/fc_mains/read_enable \
sim:/fc_mains/layer
add wave -position insertpoint  \
sim:/fc_mains/outputNodes1R

run
force -freeze sim:/fc_mains/reset 0 0

run