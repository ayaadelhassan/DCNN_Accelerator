module pool_window(window,pooledOut);
	input signed [15:0] window [0:1][0:1];
	output pooledOut;
	reg signed [15:0] pooledOut = "0000000000000000"; 
	reg signed quarter [15:0] = "0000001000000000"; // quarter 0.25
	wire signed [15:0] temp [0:3];
	genvar i,j;
	generate 

	for (i=0; i<2; i++)
	begin
      		for (j=0; j<2; j++)
		begin
          		multiplication mp(window[i][j], quarter, temp[i * 2 + j]);
			add ad(pooledOut,temp[i*2+j],pooledOut);
		end
	end
	
	endgenerate

endmodule