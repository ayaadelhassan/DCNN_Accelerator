vsim work.fc_main
mem load -i {/home/mohamedsamy/CMP_3rd/2nd/VLSI/project/code/DCNN_Accelerator (copy)/FC/test.mem} /fc_main/mem
add wave -position insertpoint  \
sim:/fc_main/firstLayerNodes \
sim:/fc_main/secondLayerNodes \
sim:/fc_main/thirdLayerNodes \
sim:/fc_main/enable \
sim:/fc_main/clk \
sim:/fc_main/finished \
sim:/fc_main/result \
sim:/fc_main/reset \
sim:/fc_main/enable1 \
sim:/fc_main/enable2 \
sim:/fc_main/enable3 \
sim:/fc_main/finished1 \
sim:/fc_main/finished2 \
sim:/fc_main/mem \
sim:/fc_main/data_out \
sim:/fc_main/address \
sim:/fc_main/data_in \
sim:/fc_main/write_enable \
sim:/fc_main/read_enable \
sim:/fc_main/finishedMem \
sim:/fc_main/readAddress1 \
sim:/fc_main/weightsAddress1 \
sim:/fc_main/biasesAddress1 \
sim:/fc_main/writeAddress1 \
sim:/fc_main/readAddress2 \
sim:/fc_main/weightsAddress2 \
sim:/fc_main/biasesAddress2 \
sim:/fc_main/layer \
sim:/fc_main/inputNodes1R \
sim:/fc_main/outputNodes1R \
sim:/fc_main/weights1R \
sim:/fc_main/biases1R \
sim:/fc_main/outputNodes2R \
sim:/fc_main/weights2R \
sim:/fc_main/biases2R \
sim:/fc_main/reset1 \
sim:/fc_main/reset2 \
sim:/fc_main/reset3 \
sim:/fc_main/i \
sim:/fc_main/j \
sim:/fc_main/it \
sim:/fc_main/k \
sim:/fc_main/f1 \
sim:/fc_main/f2 \
sim:/fc_main/f3
add log sim:/fc_main/fc1/mul/*
add log sim:/fc_main/fc1/adder/*
force -freeze sim:/fc_main/enable 1 0
force -freeze sim:/fc_main/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/fc_main/reset 1 0
run
force -freeze sim:/fc_main/reset 0 0
run 640 ns
