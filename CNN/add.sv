module add(in1,in2,out);
	input signed [15:0] in1,in2;
	output signed [15:0] out;	
	assign out = in1 + in2;
	
endmodule
