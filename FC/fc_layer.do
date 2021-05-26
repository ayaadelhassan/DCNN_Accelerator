
vsim -gui work.fc_layer
force -freeze sim:/fc_layer/enable 1 0
force -freeze sim:/fc_layer/reset 1 0
force -freeze sim:/fc_layer/clk 1 0, 0 {50 ps} -r 100
force -freeze {sim:/fc_layer/inputNodes[0]} 0000000000000001 0
force -freeze {sim:/fc_layer/inputNodes[1]} 0000000000000010 0
force -freeze {sim:/fc_layer/inputNodes[2]} 0000000000000011 0
force -freeze {sim:/fc_layer/inputNodes[3]} 0000000000000100 0
force -freeze {sim:/fc_layer/inputNodes[4]} 0000000000000101 0
force -freeze {sim:/fc_layer/weights[0]} 0000000000000001 0
force -freeze {sim:/fc_layer/weights[1]} 0000000000000010 0
force -freeze {sim:/fc_layer/weights[2]} 0000000000000011 0
force -freeze {sim:/fc_layer/weights[3]} 0000000000000100 0
force -freeze {sim:/fc_layer/weights[4]} 0000000000000101 0
force -freeze {sim:/fc_layer/weights[5]} 0000000000000000 0
force -freeze {sim:/fc_layer/weights[6]} 0000000000000000 0
force -freeze {sim:/fc_layer/weights[7]} 0000000000000000 0
force -freeze {sim:/fc_layer/weights[8]} 0000000000000000 0
force -freeze {sim:/fc_layer/weights[9]} 0000000000000000 0
force -freeze {sim:/fc_layer/weights[10]} 0000000000000001 0
force -freeze {sim:/fc_layer/weights[11]} 0000000000000001 0
force -freeze {sim:/fc_layer/weights[12]} 0000000000000001 0
force -freeze {sim:/fc_layer/weights[13]} 0000000000000001 0
force -freeze {sim:/fc_layer/weights[14]} 0000000000000001 0
force -freeze {sim:/fc_layer/biases[0]} 1 0
force -freeze {sim:/fc_layer/biases[1]} 1 0
force -freeze {sim:/fc_layer/biases[2]} 1 0
run
force -freeze sim:/fc_layer/reset 0 0
