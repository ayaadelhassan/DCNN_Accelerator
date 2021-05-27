module test ;
	localparam period = 100;
	reg clk, reset;
	// DMA variables
	wire dmaEnable,readWrite;
	wire [15:0] dmaAddress;
	reg [15:0] dmaInputData;
	reg signed [15:0] dmaOutputData [0:24];


	// load block variables
	reg loadEnable, loadDone;

	reg [15:0] loadAddr;
	wire [15:0] loadBlockAddress;
	reg signed [15:0] loadOut [0:1023];

	// CNN ALU variables
	reg CNNEnable, CNNreset , CNNDmaEnable, CnnDmaDone, CnnLoadEnable, CnnWriteEnable, CNNDone;
	reg [15:0] CNNinitialAddress;
	reg [15:0] CNNDmaAddress;
	reg [15:0] CNNImgSize;
	reg [15:0] CNNOutImgSize;
	reg [15:0] CNNimgAddr;
	



	DMA dma(.clk(clk), .enable(dmaEnable), .RW(readWrite), .address(dmaAddress), .inputDATA(dmaInputData), .outputData(dmaOutputData));

	load_block loadB (.clk(clk), .enable(loadEnable),.reset(reset), .size(CNNOutImgSize), .address(loadAddr), .dmaAddr(loadBlockAddress), .dmaOut(dmaOutputData), .out(loadOut) ,.done(loadDone));
	
	cnn_controller cnn2(.clk(clk), .enable(CNNEnable), .reset(CNNreset), .orgLayerAddress(CNNinitialAddress), .orgImgAddress(CNNimgAddr), // initial input address
	.memFetchResult(dmaOutputData) ,.orgImgSize(CNNImgSize), .imgSize(CNNOutImgSize) ,.fetchedImage(loadOut), 
	.loadBlockAddress(loadBlockAddress),.dmaInput(dmaInputData),.dmaEnable(CNNDmaEnable), .dmaDone(CnnDmaDone), .dmaAddress(CNNDmaAddress),
	.done(CNNDone) ,.loadImageEnable(loadEnable),.loadImageDone(loadDone) , .loadImgAddress(loadAddr), .loadEnable(CnnLoadEnable), .writeEnable(CnnWriteEnable));
	
	assign dmaEnable = loadEnable || CNNDmaEnable;
	assign readWrite = CnnLoadEnable || loadEnable;
   	assign dmaAddress = loadEnable? loadBlockAddress :CNNDmaAddress;

	always @(posedge clk)begin 
		if(reset)begin 
			CNNinitialAddress = 0; 
            		CNNimgAddr = 100; 
			CNNImgSize =6;
                end 
	
	end

	initial begin
		$display($time, " << Starting the Simulation >>");
		clk = 1;
		reset = 1;
		CNNreset = 1; 
		CNNEnable = 0;
		
		#period
		reset = 0;
		CNNEnable = 1;
        CnnDmaDone = 1; 
		CNNreset = 0; 

	end
	always #(period/2) clk=~clk;
endmodule