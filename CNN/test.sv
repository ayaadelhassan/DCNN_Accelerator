module test ;
	localparam period = 100;
	reg clk, reset;
	// DMA variables
	reg dmaEnable,readWrite;
	reg [15:0] dmaAddress;
	reg [15:0] dmaInputData;
	reg signed [15:0] dmaOutputData [0:24];


	// load block variables
	reg loadEnable, loadDone;
	reg [15:0] blockSize;
	reg [15:0] loadAddr;
	reg [15:0] loadBlockAddress;
	reg signed [15:0] loadOut [0:1023];

	// CNN ALU variables
	reg CNNEnable, CNNreset , CNNDMaEnable, CnnOpDone, CnnLoadEnable, CnnWriteEnable, CNNDone;
	reg [15:0] CNNinitialAddress;
	reg [15:0] CNNOutAddr;
	reg [15:0] CNNImgSize;
	reg [15:0] CNNimgAddr;



	DMA dma(.clk(clk), .enable(dmaEnable), .RW(readWrite), .address(dmaAddress), .inputDATA(dmaInputData), .outputData(dmaOutputData));

	load_block loadB (.clk(clk), .enable(loadEnable), .size(blockSize), .address(loadAddr), .dmaAddr(loadBlockAddress), .dmaOut(dmaOutputData), .out(loadOut) ,.done(loadDone));

	CNN_ALU CnnALU(.clk(clk), .enable(CNNEnable), .reset(CNNreset), .initialAddr(CNNinitialAddress), 
		       .address(CNNOutAddr), .memFetchResult(dmaOutputData) , .imgSize(CNNImgSize), .fetchedImage(loadOut), 
	 		.dmaEnable(CNNDmaEnable), .opDone(CnnOpDone),.done(CNNDone) , .imgAddr(CNNimgAddr) , .loadImageEnable(loadEnable) , .loadImgAddrr(loadAddr), .loadEnable(CnnLoadEnable), .writeEnable(CnnwriteEnable));
	always @(posedge clk)begin 
		dmaEnable = CnnwriteEnable || CnnLoadEnable ; 
		dmaEnable = loadEnable || CNNDmaEnable;
		if (CNNDmaEnable)
			dmaAddress = CNNOutAddr ;
		else if (loadEnable)
			dmaAddress = loadBlockAddress;
		readWrite = CnnLoadEnable || loadEnable;
		blockSize = CNNImgSize;
	end

	initial begin
		$display($time, " << Starting the Simulation >>");
		clk = 0;
		reset = 1;
	
		#period
		reset = 0;
	end
	always #(period/2) clk=~clk;
endmodule