module pooling_window_tb;
	reg signed [15:0] window [0:3];
	reg signed [15:0] value;

    	localparam period = 100;
	
	pool_window #(.n(4)) pw(window, value);
	
	initial
	begin


        window = { 
			16'b0000010000000000, 16'b0000010000000000, 
			16'b0000010000000000, 16'b0000010000000000
		};
	$display("RESULT: 0000010000000000 ==> 0.5");
        #period;

        window = { 
			16'b0000100000000000, 16'b0000110000000000, 
			16'b1111110000000000, 16'b1111000000000000
		};
	$display("RESULT: 0000000000000000 ==> 0");

        #period;
        
        window = { 
			16'b0011010000000000, 16'b0001010000000000, 
			16'b1000010000000000, 16'b0000011100000000
		};
	$display("RESULT: -1.40625");

        #period;

        window = { 
			16'b0010010000000000, 16'b0000010000110000, 
			16'b0001010000000000, 16'b0000010000000000
		};
	$display("RESULT: 2.005859375");

        #period;

	window = { 
			16'b0101000000000000, 16'b0101100000000000, 
			16'b0110000000000000, 16'b0110100000000000
		};
	$display("RESULT: 11.5");

        #period;
	
	window = { 
			16'b1011000000000000, 16'b1010100000000000, 
			16'b1010000000000000, 16'b1001100000000000
		};
	$display("RESULT: -11.5");

        #period;



	end

endmodule
