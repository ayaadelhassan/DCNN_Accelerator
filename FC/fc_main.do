vsim work.fc_main
mem load -i {C:/Users/Omar Salama/Desktop/My_Files/Uni/3rd Year/Second Semester/VLSI/project/DCNN_Accelerator/FC/bigMem.mem} -update_properties /fc_main/mem
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
sim:/fc_main/layer
add wave -position insertpoint  \
sim:/fc_main/outputNodes1R \
sim:/fc_main/outputNodes2R \
sim:/fc_main/result

run
force -freeze sim:/fc_main/reset 0 0

run 100 ns