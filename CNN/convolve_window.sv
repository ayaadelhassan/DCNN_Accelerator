module convolve_window(window, filter, value);
	input signed [15:0] window [0:24];
	input signed [15:0] filter [0:24]; 
	output signed [15:0] value;
	
	wire signed [15:0] temp [0:24];

	genvar i,j;
	generate 

	for (i=0; i<25; i++)
	begin
          	multiplication mp(window[i], filter[i], temp[i]);
	end
	
	endgenerate


	summation #(.n(25)) sm(temp, value);

endmodule
