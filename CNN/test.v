module test (A, B, Z);
	input signed [15:0] A, B;
	output signed [15:0] Z;
	wire signed [31:0] multOut;
	
	multiplication mp(A, B, multOut);
	fixed_point_modification fp(multOut, Z);
	
endmodule