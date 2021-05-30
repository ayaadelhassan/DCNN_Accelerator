module cnn_controller_tb;
	localparam period = 100;
	reg clk, reset;
	// DMA variables
	wire dmaEnable,readWrite;
	wire [15:0] dmaAddress;
	reg [15:0] dmaInputData;
	reg signed [15:0] dmaOutputData [0:24];


	// load block variables
	wire loadEnable, loadDone ;
	reg CNNEnable,CNNreset; 
	reg [15:0] loadAddr;
	wire [15:0] loadBlockAddress;
	reg signed [15:0] loadOut [0:1023];

	// CNN ALU variables
	wire CNNDmaEnable, CnnDmaDone, CnnLoadEnable, CnnWriteEnable, CNNDone;
	wire [15:0] CNNinitialAddress;
	wire [15:0] CNNDmaAddress;
	wire [15:0] CNNImgSize;
	wire [15:0] CNNOutImgSize;
	wire [15:0] CNNimgAddr;
	



	CNNmemory dma(.data_out(dmaOutputData), .address(dmaAddress), .data_in(dmaInputData), .write_enable(readWrite), .clk(clk));

	load_block loadB (.clk(clk), .enable(loadEnable),.reset(reset), .size(CNNOutImgSize), .address(loadAddr), .dmaAddr(loadBlockAddress), .dmaOut(dmaOutputData), .out(loadOut) ,.done(loadDone));
	
	cnn_controller cnn2(.clk(clk), .enable(CNNEnable), .reset(CNNreset), .orgLayerAddress(CNNinitialAddress), .orgImgAddress(CNNimgAddr), // initial input address
	.memFetchResult(dmaOutputData) ,.orgImgSize(CNNImgSize), .imgSize(CNNOutImgSize) ,.fetchedImage(loadOut), 
	.loadBlockAddress(loadBlockAddress),.dmaInput(dmaInputData),.dmaEnable(CNNDmaEnable), .dmaDone(CnnDmaDone), .dmaAddress(CNNDmaAddress),
	.done(CNNDone) ,.loadImageEnable(loadEnable),.loadImageDone(loadDone) , .loadImgAddress(loadAddr), .loadEnable(CnnLoadEnable), .writeEnable(CnnWriteEnable));
	
	assign dmaEnable = loadEnable || CNNDmaEnable;
	assign readWrite = CnnWriteEnable;
   	assign dmaAddress = loadEnable? loadBlockAddress : CNNDmaAddress;
	assign CNNinitialAddress = 0; 
	assign CNNimgAddr = 100;
	assign CNNImgSize =6; 
	assign CnnDmaDone = 1;
	
	initial begin
		$display($time, " << Starting the Simulation >>");
		clk = 1;
		reset = 1;
		CNNreset = 1; 
		CNNEnable = 0;
		#period
		reset = 0;
		CNNEnable = 1;
         
		CNNreset = 0; 

	end
	always #(period/2) clk=~clk;
endmodule