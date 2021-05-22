module convolve_image(image, filter, convolved_image);
	
	parameter n = 32;

	input signed [15:0] image [0:n*n-1];
	input signed [15:0] filter [0:24];
	output signed [15:0] convolved_image [0:((n-4)*(n-4))-1];
	wire signed [15:0] window [0:((n-4)*(n-4))-1][0:24];


	genvar i,j;
	generate 

	for (i = 0; i < n-4; i++)
	begin
		for(j = 0; j < n-4; j++)
		begin
			assign window[j+(n-4)*i][0:4] = image[j+(n*i):j+(n*i)+4];
			assign window[j+(n-4)*i][5:9] = image[j+(n*(i+1)):j+(n*(i+1))+4];
			assign window[j+(n-4)*i][10:14] = image[j+(n*(i+2)):j+(n*(i+2))+4];
			assign window[j+(n-4)*i][15:19] = image[j+(n*(i+3)):j+(n*(i+3))+4];
			assign window[j+(n-4)*i][20:24] = image[j+(n*(i+4)):j+(n*(i+4))+4];

          	convolve_window cw(window[j+(n-4)*i], filter, convolved_image[j+(n-4)*i]);


		end
	end
	
	endgenerate


endmodule
