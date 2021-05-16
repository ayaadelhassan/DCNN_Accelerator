vsim -gui work.multiplication
# vsim -gui work.test 
# Start time: 17:51:11 on May 16,2021
# Loading work.test
# Loading work.multiplication
# Loading work.fixed_point_modification
add wave -position end  sim:/multiplication/A
add wave -position end  sim:/multiplication/B
add wave -position end  sim:/multiplication/Z
add wave -position end  sim:/multiplication/multOut
force -freeze sim:/multiplication/A 0001110000000000 0
force -freeze sim:/multiplication/B 0001000000000000 0
run
force -freeze sim:/multiplication/A 0111110000000000 0
force -freeze sim:/multiplication/B 0001100000000000 0
run
force -freeze sim:/multiplication/A 1010010000000000 0
force -freeze sim:/multiplication/B 0001110000000000 0
run
force -freeze sim:/multiplication/A 0010110000000000 0
force -freeze sim:/multiplication/B 1110010000000000 0
run
force -freeze sim:/multiplication/A 0010110000000000 0
force -freeze sim:/multiplication/B 1110010000000000 0
run
force -freeze sim:/multiplication/A 0010110000000000 0
force -freeze sim:/multiplication/B 0010110000000000 0
run