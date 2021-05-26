module convolve_image_clked(clk, reset ,enable, imgSize, image, filterSize, filter, convolved, done);
	
	localparam n = 32;

	input signed [15:0] image [0:n*n-1];
	input signed [15:0] filter [0:24];
	input [15:0] imgSize;
	input [15:0] filterSize;
    	input clk , reset, enable;
	output signed [15:0] convolved;
   	output done; 
    	reg done; 
	reg signed [15:0] window [0:24];
    	
	convolve_window cw(window, filterSize, filter, convolved);
    
	integer i,j,k,f;
    	always @(posedge clk) 
	begin
		if(done) begin
			done = 0;
			i = 0;
			j = 0;
		end
        	
		if (reset) begin
        	    	i  <= 0; 
        	    	j <= 0 ;
			done <= 0;
			for(k=0;k<25;k=k+1) begin
        	    		window[k] <= 0;
			end
        	end else if(enable) begin
			f = 0;
			
			for(integer x=i;x<i+filterSize;x++) begin
				for(integer y=0;y<filterSize;y++) begin
					window[f] = image[j+(imgSize*x)+y];
					f = f + 1;
				end
			end
        		            
            		j = j + 1; 
			
			if(j >= imgSize - ((filterSize>>1) << 1)) begin
				i = i + 1;
				j = 0;
			end

			if(i >= imgSize - ((filterSize>>1) << 1)) begin
				done = 1;	
			end
		end 
    	end
	

endmodule
