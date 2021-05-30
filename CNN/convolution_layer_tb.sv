module convolution_layer_tb;
    	reg clk, reset, loadEnable, dmaEnable, rw, loadDone, writeEnable, loadPrevDataEnable;
	reg [15:0] address;
	reg [15:0] inputData;
	reg signed [15:0] dmaOut [0:24];
	reg [15:0] blockSize;
	reg [15:0] loadAddr;
        reg signed [15: 0] loadOut[0:1023]; 
	reg [15:0] loadBlockAddress;

	reg conv_enable, cl_done;
	
	reg [15:0] imgsNumber;
	reg [15:0] imgSize;
	reg [15:0] imgsAddress;
	reg [15:0] filtersNumber;
	reg [15:0] filterSize;
	reg [15:0] filterAddress;
	reg [15:0] writeAddr;
	
    	localparam period = 100;

    	//convolution_layer conv(clk, enable, reset, )
	CNNmemory dma(.clk(clk), .write_enable(rw), .address(address), .data_in(inputData), .data_out(dmaOut));
        load_block loadB (.clk(clk), .enable(loadEnable), .reset(reset), .size(blockSize), .address(loadAddr), .dmaAddr(loadBlockAddress), .dmaOut(dmaOut), .out(loadOut) ,.done(loadDone));

	convolution_layer cl(.clk(clk), .enable(conv_enable), .reset(reset), .loadDone(loadDone),
		.imgsNumber(imgsNumber), .imgSize(imgSize), .imgsAddress(imgsAddress), 
		.filtersNumber(filtersNumber), .filterSize(filterSize), .biasAddress(filterAddress), 
		.loadAddr(loadAddr), .loadSize(blockSize), .loadOut(loadOut),
		.writeAddr(writeAddr), .writeOut(inputData), .writeEnable(writeEnable),
		.loadPrevDataOut(dmaOut), .loadPrevDataEnable(loadPrevDataEnable),
		.loadEnable(loadEnable), .done(cl_done));


	assign address = (writeEnable || loadPrevDataEnable) ? writeAddr : loadBlockAddress;
	assign dmaEnable = writeEnable || loadEnable || loadPrevDataEnable; 
	assign rw = writeEnable;
	
	initial begin
		$display($time, "<< Starting the Simulation >>");
		clk = 0;
		reset = 1;

		conv_enable = 0;
		imgsNumber = 3;
		imgSize = 8;
		imgsAddress = 200;
		
		filtersNumber = 6;
		filterSize = 5;
		filterAddress = 0;
		#period;
		
		reset = 0;
		conv_enable = 1;

	end

	always #(period/2) clk=~clk;

endmodule
