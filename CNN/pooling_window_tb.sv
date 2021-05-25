module pooling_window_tb;
	reg signed [15:0] window [0:24];
	reg signed [15:0] value;
	reg [15:0] windowSize;

    	localparam period = 100;
	
	pool_window pw(windowSize, window, value);
	
	initial
	begin

       	window = { 16'b0000010000000000, 16'b0000010000000000, 16'b0000010000000000, 16'b0000010000000000, 16'b0000000000000000, 
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000,
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000,
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000,
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000
	};
	
	windowSize = 2;

	$display("RESULT: 0000010000000000 ==> 0.5");
        #period;

       	window = { 16'b0000100000000000, 16'b0000110000000000, 16'b1111110000000000, 16'b1111000000000000, 16'b0000000000000000, 
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000,
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000,
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000,
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000
	};
	
	windowSize = 3;

	$display("RESULT: 0000000000000000 ==> 0");

        #period;

       	window = { 16'b0011010000000000, 16'b0001010000000000, 16'b1000010000000000, 16'b0000011100000000, 16'b0000000000000000, 
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000,
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000,
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000,
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000
	};
	
	windowSize = 5;

	$display("RESULT: -1.40625");

        #period;

       	window = { 16'b0010010000000000, 16'b0000010000110000, 16'b0001010000000000, 16'b0000010000000000, 16'b0000000000000000, 
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000,
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000,
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000,
		16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000
	};
	
	windowSize = 5;

	$display("RESULT: 2.005859375");

        #period;


	end

endmodule
