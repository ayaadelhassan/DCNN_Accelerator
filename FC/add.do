vsim work.add
add wave -position insertpoint sim:/add/*
add wave -position insertpoint sim:/add/addFP/*
force -freeze sim:/add/in1 1111100000000000 0
force -freeze sim:/add/in2 1111100000000000 0
run
force -freeze sim:/add/in1 0111100000000000 0
force -freeze sim:/add/in2 0101100000000000 0
run
