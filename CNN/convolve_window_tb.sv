module convolve_window_tb;
	reg signed [15:0] window [0:4][0:4];
	reg signed [15:0] filter [0:4][0:4];
	reg signed [15:0] value;

    	localparam period = 100;
	
	convolve_window cv(window, filter, value);
	
	initial
	begin
		for (integer i=0; i<5; i++)
		begin
      			for (integer j=0; j<5; j++)
			begin
				window[i][j] = 16'b0000010000000000;
          			filter[i][j] = 16'b0000100000000000;
			end
		end

        	#period;

	end

endmodule
