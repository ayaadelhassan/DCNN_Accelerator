module pool_image_clked (clk, reset, enable, imgSize, image, windowSize, pooledOut, done);

	localparam n = 32;
	
	input signed [15:0] image [0:n*n-1];
	input [15:0] imgSize;
	input [15:0] windowSize;
	input clk, reset, enable;
	output signed [15:0] pooledOut ;
	reg signed [15:0] window [0:24];
	output done ;
	reg done;

//     initial
// 	begin
//		image = { 16'b0000010000000000, 16'b0000010000000000, 16'b0000100000000000, 16'b0000110000000000, 
//			16'b0000010000000000, 16'b0000010000000000, 16'b1111110000000000, 16'b1111000000000000,
//			16'b0101000000000000, 16'b0101100000000000, 16'b1011000000000000, 16'b1010100000000000, 
//			16'b0110000000000000, 16'b0110100000000000, 16'b1010000000000000, 16'b1001100000000000
//		};

// 		image = { 16'b0100010000000000, 16'b0000010100000000, 16'b0100100000000000, 16'b0010110000000000, 
// 			16'b1100010000000000, 16'b0000010000000000, 16'b1111110011000000, 16'b1111000000000000,
// 			16'b0101000000000000, 16'b0101100000000000, 16'b1011000000000000, 16'b1010100010000000, 
// 			16'b0000000000000000, 16'b0110100000000011, 16'b1011000000000000, 16'b1001110000000000
// 		};

// 	end


    pool_window pw(windowSize, window, pooledOut);
    integer i,j,x,y,f,k;
    always @(posedge clk) begin
        if (reset) begin
            	i <= 0 ;
            	j <= 0 ;
            	done <= 0;
		for(k=0;k<25;k=k+1) begin
        	    	window[k] <= 0;
		end

        end
        if (enable) begin
            	f = 0;
            	for(x=i;x<i+windowSize;x++) begin
			for(y=0;y<windowSize;y++) begin
				window[f] = image[j+(imgSize*x)+y];
            	        	f = f + 1;
			end
		end

            	j = j + windowSize;

		if(j >= imgSize) begin
			i = i + windowSize;
			j = 0;
		end
		
		if(i >= imgSize) begin
			done = 1;	
		end
            
        end
        
    end 



endmodule