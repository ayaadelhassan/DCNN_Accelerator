module pool_window(windowSize, window, pooledOut);
	localparam n = 5;
	input signed [15:0] window [0:n*n-1];
	input [15:0] windowSize;
	output pooledOut;
	reg signed [15:0] pooledOut; 

	integer i;
	always @* begin 
		pooledOut = 0;
		for (i=0; i < windowSize*windowSize; i++)
		begin
      			pooledOut = pooledOut + (window[i] >>> windowSize);
		end
	end

endmodule