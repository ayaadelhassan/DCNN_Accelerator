module fortesting(x,y);
input [15:0] x;
output [15:0] y;

assign y = (x>>1)<<1;

endmodule
