
module pool_layer(clk, enable, reset, loadDone,
		imgsNumber, imgSize, imgsAddress, windowSize, 
		loadAddr, loadSize, loadOut, loadEnable,
 		writeAddr, writeOut, writeEnable,
		done);

	localparam DATA_SZ = 16;
	localparam ADDR_SZ = 16;

	// Pooling Parameters
	input reg clk, enable, reset;
	input reg [DATA_SZ-1:0] imgsNumber;
	input reg [DATA_SZ-1:0] imgSize;
	input reg [DATA_SZ-1:0] windowSize;
	input reg [ADDR_SZ-1:0] imgsAddress;

	output reg done;

	// Write Block parameters
	output reg writeEnable;
	output reg [ADDR_SZ-1:0] writeAddr;  
	output reg signed [DATA_SZ -1: 0] writeOut;


	// Load Block parameters
	output reg loadEnable;
	output reg [ADDR_SZ-1:0] loadAddr;  
	output reg [DATA_SZ-1:0] loadSize;
	input signed [DATA_SZ -1: 0] loadOut[0:1023];
	input loadDone;
	
	
	reg signed [DATA_SZ -1: 0] image[0:1023];

	reg loadingOp, isImageLoaded;
	reg [DATA_SZ-1:0] imgCounter;
	reg [ADDR_SZ-1:0] currentImgAddress;

	reg poolEnable, poolDone;

	pool_image_clked pi(.clk(clk), .reset(reset), .enable(poolEnable), 
				.imgSize(imgSize), .image(image), .windowSize(windowSize),
		 		.pooledOut(writeOut), .done(poolDone));
	always @(posedge clk)   // Loops on the images and filter then do the convolution
	begin
		if(poolDone && poolEnable) begin
			writeEnable = 0;
			poolEnable = 0;
			isImageLoaded = 0;
			if(imgCounter == imgsNumber) begin
				done = 1;
			end
		end
		
		if (poolEnable)begin
			writeEnable = 1 ;
			writeAddr = writeAddr + 1; 
		end		
		if(loadDone && loadingOp) begin
			imgCounter = imgCounter + 1;
			currentImgAddress = currentImgAddress + imgSize*imgSize;
			isImageLoaded = 1;
			image = loadOut;
			loadingOp = 0;
			loadEnable = 0;
		end
		
		if(reset) begin
			writeEnable = 0;
			done = 0;
			imgCounter = 0;
			loadingOp = 0;
			isImageLoaded = 0;
			poolEnable = 0;
		end
		else if (enable && loadingOp == 0 && done == 0) begin
			if(imgCounter == 0) begin
				currentImgAddress = imgsAddress;
				isImageLoaded = 0;
				writeAddr = imgsAddress + imgSize * imgSize * imgsNumber - 1;  
			end
			
			if(isImageLoaded == 0) begin
				loadingOp = 1;
				loadEnable = 1;
				loadSize = imgSize;
				loadAddr = currentImgAddress;
			end else begin
				poolEnable = 1;	
			end	
		end
	end
endmodule