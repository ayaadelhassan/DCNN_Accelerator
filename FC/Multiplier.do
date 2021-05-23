vsim work.Multiplier
add wave -position insertpoint  \
sim:/Multiplier/A \
sim:/Multiplier/M \
sim:/Multiplier/N \
sim:/Multiplier/P \
sim:/Multiplier/R \
sim:/Multiplier/S \
sim:/Multiplier/i \
sim:/Multiplier/mulResult
force -freeze sim:/Multiplier/R 1000 0
force -freeze sim:/Multiplier/M 1111 0
run
