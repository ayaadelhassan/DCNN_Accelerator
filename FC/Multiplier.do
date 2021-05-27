vsim work.Multiplier
add wave -position insertpoint  \
sim:/Multiplier/clk \
sim:/Multiplier/enable \
sim:/Multiplier/M \
sim:/Multiplier/R \
sim:/Multiplier/i \
sim:/Multiplier/continue \
sim:/Multiplier/finish \
sim:/Multiplier/reset \
sim:/Multiplier/P \
sim:/Multiplier/fixedMulResult \
sim:/Multiplier/fixedEnable \
sim:/Multiplier/result \
sim:/Multiplier/mulResult
force -freeze sim:/Multiplier/enable 1 0
force -freeze sim:/Multiplier/reset 1 0
force -freeze sim:/Multiplier/R 0100010001000010 0
force -freeze sim:/Multiplier/M 0011001100110011 0
force -freeze sim:/Multiplier/clk 1 0, 0 {50 ps} -r 100
run
force -freeze sim:/Multiplier/reset 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run