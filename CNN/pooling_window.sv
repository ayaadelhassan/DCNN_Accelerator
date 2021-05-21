module pool_window(window,pooledOut);
	input signed [15:0] window [0:3];
	output pooledOut;
	reg signed [15:0] pooledOut; 

	integer i;
	always @* begin 
		pooledOut = 0;
		for (i=0; i<4; i++)
		begin
      			pooledOut = pooledOut + (window[i] >>> 2);
		end
	end

endmodule