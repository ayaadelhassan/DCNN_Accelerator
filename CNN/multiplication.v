module multiplication (A, B, Z);
	input signed [15:0] A, B;
	output signed [31:0] Z;
	
	assign Z = A * B;
	
endmodule
