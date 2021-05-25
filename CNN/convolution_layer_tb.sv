module convolution_layer_tb;
    	reg clk, reset, loadEnable, done, dmaEnable, rw, loadDone;
	reg [15:0] address;
	reg [15:0] inputData;
	reg [15:0] dmaOut [0:24];
	reg [15:0] blockSize;
	reg [15:0] initAddr;
        reg [15: 0] loadOut[0:1023]; 
    	localparam period = 100;

    	//convolution_layer conv(clk, enable, reset, )
	DMA dma(.clk(clk), .enable(dmaEnable), .RW(rw), .address(address), .inputDATA(inputData), .outputData(dmaOut));
        load_block loadB (.clk(clk), .enable(loadEnable), .size(blockSize), .address(initAddr), .dmaAddr(address), .dmaOut(dmaOut), .out(loadOut) ,.done(loadDone));


	initial begin
		$display($time, " << Starting the Simulation >>");
		clk = 0;
		dmaEnable = 1;
		rw = 1;
		inputData = 0;
		blockSize = 6;
		initAddr = 0;
		loadEnable = 0;
		
		#period
		
		loadEnable = 1;
	end

	always #(period/2) clk=~clk;

endmodule
