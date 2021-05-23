module convolve_image_clked_tb;
    	reg signed [15:0] image [0:1023];
	reg signed [15:0] filter [0:24];
	reg [15:0] imageSize;
	reg [15:0] filterSize;
    	reg signed [15:0] convolved;

    	reg clk, reset, enable, done;
    	localparam period = 100;

    	convolve_image_clked pl(clk, reset, enable, imageSize, image, filterSize, filter, convolved, done);

	initial begin
		$display($time, " << Starting the Simulation >>");
	    	
		for (integer i=0; i<100; i++)
		begin
	       		image[i] = 16'b0000010000000000;
		end
	
		for (integer i=0; i<25; i++)
		begin
	       		filter[i] = 16'b0000100000000000;
		end
		
		image[3] = 16'b1010000000000000;

		reset = 1'b1;
		enable = 1'b1;
		clk = 0;
		#50 reset = 1'b0;

	end

	always #(period/2) clk=~clk;

	initial begin
		imageSize = 6;
		filterSize = 3;
		#period;
	end

endmodule
