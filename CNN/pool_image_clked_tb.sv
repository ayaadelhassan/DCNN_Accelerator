module pool_image_clked_tb;
    reg signed [15:0] image [0:1023];
    reg signed [15:0] pooledOut;
	reg [15:0] imgSize;
	reg [15:0] windowSize;
    reg clk, reset, enable, done;
    localparam period = 100;

    pool_image_clked pl(clk, reset, enable, imgSize, image, windowSize, pooledOut, done);

initial begin
  $display($time, " << Starting the Simulation >>");

	for (integer i=0; i<1024; i++)
	begin
	       	image[i] = 16'b0000010000000000;
	end
	image[3] = 16'b1010000000000000;

    reset = 1'b1;
	enable = 1'b1;
    clk = 0;
    #100 reset = 1'b0;
end

always #(period/2) clk=~clk;

    initial begin
	imgSize = 10;
	windowSize = 5;
    end

endmodule