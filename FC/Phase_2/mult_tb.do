vsim work.multiplication_test
add wave  \
sim:/multiplication_test/testa_16 \
sim:/multiplication_test/testb_16 \
sim:/multiplication_test/testProd_16 \
sim:/multiplication_test/mulOpProd_16 \
sim:/multiplication_test/mulProdMod_16 \
sim:/multiplication_test/testClk \
sim:/multiplication_test/enable \
sim:/multiplication_test/reset \
sim:/multiplication_test/finished \
sim:/multiplication_test/clk_period
add wave  \
sim:/multiplication_test/uut_14/result \
sim:/multiplication_test/uut_14/modifiedOut
add wave sim:/multiplication_test/uut_16/mulResult
add wave sim:/multiplication_test/uut_16/fixedMulResult
add wave sim:/multiplication_test/uut_16/M
add wave sim:/multiplication_test/uut_16/R
add wave sim:/multiplication_test/uut_16/i
add wave sim:/multiplication_test/uut_16/P
add wave sim:/multiplication_test/uut_16/S
add wave sim:/multiplication_test/uut_16/A
add wave sim:/multiplication_test/uut_16/enable
add wave sim:/multiplication_test/uut_16/finish
add wave sim:/multiplication_test/uut_16/reset
run 50 ns