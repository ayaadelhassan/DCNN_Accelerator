module pool_image_clked_tb;
    reg signed [15:0] image [0:15];
    reg signed [15:0] pooledOut;

    reg clk, reset, enable, done;
    localparam period = 100;

    pool_image_clked #(.n(4)) pl(image, pooledOut, clk, reset, enable, done);

initial begin
  $display($time, " << Starting the Simulation >>");
    reset = 1'b1;
	enable = 1'b1;
    clk = 0;
    #50 reset = 1'b0;
end

always #period clk=~clk;

    initial begin
	image = { 16'b0100010000000000, 16'b0000010100000000, 16'b0100100000000000, 16'b0010110000000000, 
			16'b1100010000000000, 16'b0000010000000000, 16'b1111110011000000, 16'b1111000000000000,
			16'b0101000000000000, 16'b0101100000000000, 16'b1011000000000000, 16'b1010100010000000, 
			16'b0000000000000000, 16'b0110100000000011, 16'b1011000000000000, 16'b1001110000000000
		};
    end

endmodule