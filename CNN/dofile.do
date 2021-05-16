vsim -gui work.test
# vsim -gui work.test 
# Start time: 17:51:11 on May 16,2021
# Loading work.test
# Loading work.multiplication
# Loading work.fixed_point_modification
add wave -position end  sim:/test/A
add wave -position end  sim:/test/B
add wave -position end  sim:/test/Z
add wave -position end  sim:/test/multOut
force -freeze sim:/test/A 0001110000000000 0
force -freeze sim:/test/B 0001000000000000 0
run
force -freeze sim:/test/A 0111110000000000 0
force -freeze sim:/test/B 0001100000000000 0
run
force -freeze sim:/test/A 1010010000000000 0
force -freeze sim:/test/B 0001110000000000 0
run
force -freeze sim:/test/A 0010110000000000 0
force -freeze sim:/test/B 1110010000000000 0
run
force -freeze sim:/test/A 0010110000000000 0
force -freeze sim:/test/B 1110010000000000 0
run
force -freeze sim:/test/A 0010110000000000 0
force -freeze sim:/test/B 0010110000000000 0
run