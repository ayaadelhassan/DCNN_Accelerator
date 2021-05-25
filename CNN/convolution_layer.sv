module convolution_layer(clk, enable, reset, loadDone,
		imgsNumber, imgSize, imgsAddress, 
		filtersNumber, filterSize, filterAddress, 
		loadAddr, loadSize, loadOut,
		loadEnable, done);

	localparam DATA_SZ = 16;
	localparam ADDR_SZ = 16;

	// Convolution Parameters
	input reg clk, enable, reset;
	input reg [DATA_SZ-1:0] imgsNumber;
	input reg [DATA_SZ-1:0] imgSize;
	input reg [ADDR_SZ-1:0] imgsAddress;

	input reg [DATA_SZ-1:0] filtersNumber;
	input reg [DATA_SZ-1:0] filterSize;
	input reg [ADDR_SZ-1:0] filterAddress;
	output reg done;

	// Load Block parameters
	output reg loadEnable;
	output [ADDR_SZ-1:0] loadAddr;  
	output [DATA_SZ-1:0] loadSize;
	input [DATA_SZ -1: 0] loadOut[0:1023];
	input loadDone;
	
	reg loadingOp;
	reg [DATA_SZ-1:0] imgCounter;
	reg [ADDR_SZ-1:0] currentImgAddress;
	
	always @(clk)   // Loops on the images and filter then do the convolution
	begin
		if(reset) begin
			imgCounter = 0;	
			loadingOp = 0;
		end
		else if (enable) begin
			if(imgCounter == 0) begin
				currentImgAddress = imgsAddress;
			end
			// 1- Read the image
			if(imgCounter < imgsNumber) begin
				if(loadingOp == 0) begin
					loadingOp = 1;
					loadEnable = 1;
					loadSize = imgSize;
					loadAddr = currentImgAddress;
				end
				else begin
				if(loadDone == 1) begin
					
					imgCounter = imgCounter + 1;
					currentImgAddress = currentImgAddress + imgSize*imgSize; // Is that right?!
				end
				end
			end
			// 2- Read the filter
		end
	end
endmodule
