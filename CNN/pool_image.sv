module pool_image(image, pooled_image);
	
	parameter n = 28;

	input signed [15:0] image [0:n*n-1];
	output signed [15:0] pooled_image [0:(n*n/4)-1];
	wire signed [15:0] window [0:(n*n/4)-1][0:3];


	genvar i,j;
	generate 

	for (i = 0; i < n ; i += 2)
	begin
		for(j = 0; j < n; j += 2)
		begin
			assign window[j/2+n*i/4][0:1] = image[j+(n*i):j+(n*i)+1];
			assign window[j/2+n*i/4][2:3] = image[j+(n*(i+1)):j+(n*(i+1))+1];

          		pool_window pw(window[j/2+n*i/4], pooled_image[j/2+n*i/4]);
		end
	end
	
	endgenerate


endmodule
