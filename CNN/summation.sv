module summation(array, filterSize, sum);
	parameter n = 25;	//array size

	input signed [15:0] array [0:n-1];
	input [15:0] filterSize;
	wire signed [15:0] addOutTemp [0:n-2];
	output signed [15:0] sum;

	add ad(array[0], array[1], addOutTemp[0]);
	
	genvar k;
	generate 

	for (k=0;k<n-2;k=k+1)
	begin
		add ad(array[k+2], addOutTemp[k], addOutTemp[k+1]);
	end
	
	endgenerate

	assign sum = addOutTemp[filterSize*filterSize-2];

endmodule
