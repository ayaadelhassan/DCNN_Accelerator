module multiplication (A, B, Z);
	input signed [15:0] A, B;
	output signed [15:0] Z;
	wire signed [31:0] multOut;
	
	assign multOut = A * B;
	fixed_point_modification #(.n(32), .m(10)) fp(multOut, Z);
	
endmodule
