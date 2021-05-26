vsim work.Multiplier
add wave -position insertpoint  \
sim:/Multiplier/clk \
sim:/Multiplier/enable \
sim:/Multiplier/M \
sim:/Multiplier/R \
sim:/Multiplier/i \
sim:/Multiplier/continue \
sim:/Multiplier/finish \
sim:/Multiplier/mulResult
force -freeze sim:/Multiplier/enable 1 0
force -freeze sim:/Multiplier/R 00010 0
force -freeze sim:/Multiplier/M 00011 0
force -freeze sim:/Multiplier/clk 1 0, 0 {50 ps} -r 100
run
run
run
run
run
run
