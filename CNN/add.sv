module add(in1,in2,out);
	input signed [15:0] in1,in2;
	output signed [15:0] out;
	wire signed [16:0] addOut;	

	assign addOut = in1 + in2;
	fixed_point_modification #(.n(17), .m(6)) addFP(addOut, out);
endmodule
