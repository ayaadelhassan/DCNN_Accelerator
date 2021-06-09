vsim -gui work.Comparitor
add wave -position insertpoint sim:/Comparitor/*
force -freeze sim:/Comparitor/reset 1 0
run
force -freeze sim:/Comparitor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Comparitor/enable 1 0
force -freeze sim:/Comparitor/reset 0 0
force -freeze {sim:/Comparitor/Arr[0]} 000000000000001 0
force -freeze {sim:/Comparitor/Arr[1]} 000000000000011 0
force -freeze {sim:/Comparitor/Arr[2]} 000000000000111 0
force -freeze {sim:/Comparitor/Arr[3]} 000000000001001 0
force -freeze {sim:/Comparitor/Arr[4]} 000000000100001 0
force -freeze {sim:/Comparitor/Arr[5]} 000000000001111 0
force -freeze {sim:/Comparitor/Arr[6]} 000000000011111 0
force -freeze {sim:/Comparitor/Arr[9]} 000000000000000 0
force -freeze {sim:/Comparitor/Arr[8]} 000001000000001 0
force -freeze {sim:/Comparitor/Arr[7]} 001100000000001 0
run
run
run
run
run
run
run
run
force -freeze sim:/Comparitor/enable 0 0
run
force -freeze sim:/Comparitor/enable 1 0
force -freeze sim:/Comparitor/reset 1 0
run
force -freeze sim:/Comparitor/reset 0 0
run
run
run
run
run
run
run
run