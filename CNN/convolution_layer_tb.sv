module convolution_layer_tb;
    	reg clk, reset, loadEnable, dmaEnable, rw, loadDone;
	reg [15:0] address;
	reg [15:0] inputData;
	reg [15:0] dmaOut [0:24];
	reg [15:0] blockSize;
	reg [15:0] initAddr;
        reg signed [15: 0] loadOut[0:1023]; 

	reg conv_enable, cl_done;
	
	reg [15:0] imgsNumber;
	reg [15:0] imgSize;
	reg [15:0] imgsAddress;
	reg [15:0] filtersNumber;
	reg [15:0] filterSize;
	reg [15:0] filterAddress;
	
    	localparam period = 100;

    	//convolution_layer conv(clk, enable, reset, )
	DMA dma(.clk(clk), .enable(dmaEnable), .RW(rw), .address(address), .inputDATA(inputData), .outputData(dmaOut));
        load_block loadB (.clk(clk), .enable(loadEnable), .size(blockSize), .address(initAddr), .dmaAddr(address), .dmaOut(dmaOut), .out(loadOut) ,.done(loadDone));


	convolution_layer cl(.clk(clk), .enable(conv_enable), .reset(reset), .loadDone(loadDone),
		.imgsNumber(imgsNumber), .imgSize(imgSize), .imgsAddress(imgsAddress), 
		.filtersNumber(filtersNumber), .filterSize(filterSize), .filterAddress(filterAddress), 
		.loadAddr(initAddr), .loadSize(blockSize), .loadOut(loadOut),
		.loadEnable(loadEnable), .done(cl_done));


	initial begin
		$display($time, " << Starting the Simulation >>");
		clk = 0;
		dmaEnable = 1;
		rw = 1;
		inputData = 0;
		reset = 1;

		conv_enable = 0;
		imgsNumber = 3;
		imgSize = 10;
		imgsAddress = 0;
		
		filtersNumber = 6;
		filterSize = 5;
		filterAddress = 300;
		#period;
		
		reset = 0;
		conv_enable = 1;

	end

	always #(period/2) clk=~clk;

endmodule
