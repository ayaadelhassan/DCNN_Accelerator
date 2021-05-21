module convolve_window(window, filter, value);
	input signed [15:0] window [0:4][0:4];
	input signed [15:0] filter [0:4][0:4]; 
	output signed [15:0] value;
	
	wire signed [15:0] temp [0:24];

	genvar i,j;
	generate 

	for (i=0; i<5; i++)
	begin
      		for (j=0; j<5; j++)
		begin
          		multiplication mp(window[i][j], filter[i][j], temp[i * 5 + j]);
		end
	end
	
	endgenerate


	summation #(.n(25)) sm(temp, value);

endmodule
