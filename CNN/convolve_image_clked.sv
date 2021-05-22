module convolve_image_clked(image, filter, convolved, clk, reset ,enable, done);
	
	parameter n = 10;

	input signed [15:0] image [0:n*n-1];
	input signed [15:0] filter [0:24];
    	input clk , reset, enable; 
	output signed [15:0] convolved;
   	output done; 
    	reg done; 
	reg signed [15:0] window [0:24];
    	
	convolve_window cw(window, filter, convolved);
    
	integer i,j,k,f;
    	always @(posedge clk, reset) 
	begin
        	if (reset) begin
        	    	i  <= 0; 
        	    	j <= 0 ;
			done <= 0;
			for(k=0;k<25;k=k+1) begin
        	    		window[k] <= 0;
			end
        	end if(enable) begin
			f = 0;
			
			for(integer x=i;x<i+5;x++) begin
				for(integer y=0;y<5;y++) begin
					window[f] = image[j+(n*x)+y];
					f = f + 1;
				end
			end
        		            
            		j = j + 1; 
			
			if(j >= n - 4) begin
				i = i + 1;
				j = 0;
			end

			if(i >= n - 4) begin
				done = 1;	
			end
		end 
    	end
	

endmodule
