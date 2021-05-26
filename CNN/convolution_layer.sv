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
	output reg [ADDR_SZ-1:0] loadAddr;  
	output reg [DATA_SZ-1:0] loadSize;
	input signed [DATA_SZ -1: 0] loadOut[0:1023];
	input loadDone;
	
	
	reg signed [DATA_SZ -1: 0] image[0:1023];
	reg signed [DATA_SZ -1: 0] filter[0:24];

	reg loadingOp, imageOrFilter, isImageLoaded, isFilterLoaded;
	reg [DATA_SZ-1:0] imgCounter;
	reg [ADDR_SZ-1:0] currentImgAddress;
	
	reg [DATA_SZ-1:0] filterCounter;
	reg [ADDR_SZ-1:0] currentfilterAddress;
	
	reg [DATA_SZ-1:0] filterPerImage;
	
	reg [DATA_SZ-1:0] convolved;

	reg convEnable, convDone;

	assign filterPerImage = filtersNumber/imgsNumber;

	convolve_image_clked ci(.clk(clk), .reset(reset), .enable(convEnable), 
				.imgSize(imgSize), .image(image), .filterSize(filterSize),
		 		.filter(filter), .convolved(convolved), .done(convDone));

	always @(posedge clk)   // Loops on the images and filter then do the convolution
	begin
		
		if(convDone && convEnable) begin
			convEnable = 0;
			isFilterLoaded = 0;
			if(filterCounter == filterPerImage) begin
				filterCounter = 0;
				isImageLoaded = 0;
				if(imgCounter == imgsNumber) begin
					done = 1;
				end
			end
		end
		
		if(loadDone && loadingOp) begin
			if(imageOrFilter) begin
				imgCounter = imgCounter + 1;
				currentImgAddress = currentImgAddress + imgSize*imgSize;
				imageOrFilter = 0;
				isImageLoaded = 1;
				image = loadOut;
			end else begin
				filterCounter = filterCounter + 1;
				currentfilterAddress = currentfilterAddress + filterSize*filterSize;
				isFilterLoaded = 1;
				filter = loadOut[0:24];
				
			end

			loadingOp = 0;
			loadEnable = 0;
		end
		
		if(reset) begin
			done = 0;
			imgCounter = 0;
			filterCounter = 0;
			loadingOp = 0;
			imageOrFilter = 0;
			isImageLoaded = 0;
			isFilterLoaded = 0;
			convEnable = 0;
		end
		else if (enable && loadingOp == 0 && done == 0) begin
			if(imgCounter == 0 && filterCounter == 0) begin
				currentImgAddress = imgsAddress;
				isImageLoaded = 0;
				currentfilterAddress = filterAddress;
				isFilterLoaded = 0;
			end
			
			
			
			if(isImageLoaded == 0) begin
				loadingOp = 1;
				loadEnable = 1;
				loadSize = imgSize;
				loadAddr = currentImgAddress;
				imageOrFilter = 1;
			end else if(isFilterLoaded == 0) begin
				loadingOp = 1;
				loadEnable = 1;
				loadSize = filterSize;
				loadAddr = currentfilterAddress;
				imageOrFilter = 0;
			end else begin
				convEnable = 1;	
			end
			
		end
	end
endmodule
