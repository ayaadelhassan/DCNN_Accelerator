vsim work.Chip
# vsim work.Chip 
# Start time: 03:14:32 on May 27,2021
# Loading sv_std.std
# Loading work.Chip
# Loading work.io
# Loading work.decompression
# Loading work.CNNmemory
# Loading work.FCmemory
add wave -position insertpoint  \
sim:/Chip/clk
add wave -position insertpoint  \
sim:/Chip/load
add wave -position insertpoint  \
sim:/Chip/CNNData \
sim:/Chip/FCData \
sim:/Chip/IMGDAat
# (vsim-4077) Logging very large object: /Chip/CNNData 
add wave -position insertpoint  \
sim:/Chip/address \
sim:/Chip/addressfc \
sim:/Chip/data_in \
sim:/Chip/datafc_in
add wave -position insertpoint  \
sim:/Chip/doneLoadingCNN \
sim:/Chip/doneLoadingFC \
sim:/Chip/doneLoadingIMG
add wave -position insertpoint  \
sim:/Chip/write_enable \
sim:/Chip/writefc_enable
force -freeze sim:/Chip/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Chip/load 1 0
run -all