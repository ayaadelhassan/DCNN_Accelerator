module pool_window(window,pooledOut);
	parameter n = 4;
	input signed [15:0] window [0:n-1];
	output pooledOut;
	reg signed [15:0] pooledOut; 

	integer i;
	always @* begin 
		pooledOut = 0;
		for (i=0; i<n; i++)
		begin
      			pooledOut = pooledOut + (window[i] >>> 2);
		end
	end

endmodule