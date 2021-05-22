module convolve_image_clked_tb;
    	reg signed [15:0] image [0:99];
	reg signed [15:0] filter [0:24];
    	reg signed [15:0] convolved;

    	reg clk, reset, enable, done;
    	localparam period = 100;

    	convolve_image_clked #(.n(10)) pl(image, filter, convolved, clk, reset, enable, done);

	initial begin
		$display($time, " << Starting the Simulation >>");
	    	reset = 1'b1;
		enable = 1'b1;
		clk = 0;
		#50 reset = 1'b0;
	end

	always #period clk=~clk;

	initial begin
		for (integer i=0; i<100; i++)
		begin
	       		image[i] = 16'b0000010000000000;
		end
	
		for (integer i=0; i<25; i++)
		begin
	       		filter[i] = 16'b0000100000000000;
		end
		
		image[3] = 16'b1010000000000000;
        	
		#period;
	end

endmodule
