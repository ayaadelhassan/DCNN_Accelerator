module convolution_layer(clk, enable, reset, loadDone,
		imgsNumber, imgSize, imgsAddress, 
		filtersNumber, filterSize, filterAddress, 
		loadAddr, loadSize, loadOut,
		writeAddr, writeOut, writeEnable,
		loadPrevDataOut, loadPrevDataEnable,
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
	
	output reg loadPrevDataEnable;
	input signed [DATA_SZ -1: 0] loadPrevDataOut[0:24];
	

	// Write Block parameters
	output reg writeEnable;
	output reg [ADDR_SZ-1:0] writeAddr;  
	output reg signed [DATA_SZ -1: 0] writeOut;
	reg signed [DATA_SZ -1: 0] convoloved;
	
	
	reg signed [DATA_SZ -1: 0] image[0:1023];
	reg signed [DATA_SZ -1: 0] filter[0:24];
	reg signed [DATA_SZ -1: 0] prevData;

	reg loadingOp, isImageLoaded, isFilterLoaded;
	reg [DATA_SZ-1:0] imgCounter;
	reg [ADDR_SZ-1:0] currentImgAddress;
	
	reg [DATA_SZ-1:0] filterCounter;
	reg [1:0] loadType;             // 0 ==> Image, 1 ==> Filter, 2 ==> Conv Data
	reg [ADDR_SZ-1:0] currentfilterAddress;
	
	reg [DATA_SZ-1:0] filterPerImage;

	reg convEnable, convDone;

	assign filterPerImage = filtersNumber/imgsNumber;

	convolve_image_clked ci(.clk(clk), .reset(reset), .enable(convEnable), 
				.imgSize(imgSize), .image(image), .filterSize(filterSize),
		 		.filter(filter), .convolved(convoloved), .done(convDone));
	
	
	add ad(.in1(convoloved),.in2(prevData),.out(writeOut));

	always @(posedge clk)   // Loops on the images and filter then do the convolution
	begin
		
		if(convDone) begin
			isFilterLoaded = 0;
			if(filterCounter == filterPerImage) begin
				filterCounter = 0;
				isImageLoaded = 0;
				
				if(imgCounter == imgsNumber) begin
					done = 1;
				end
			end
		end
		
		if(writeEnable) begin
			writeEnable = 0;
			if(isImageLoaded) begin
				writeAddr = writeAddr + 1;
			end else begin
				writeAddr = imgsAddress + imgSize * imgSize * imgsNumber;
			end
		end

		if(convEnable)begin
			writeEnable = 1 ;
			convEnable = 0; 
		end	
		
		if((loadDone || loadPrevDataEnable) && loadingOp) begin
			if(loadType == 0) begin
				imgCounter = imgCounter + 1;
				currentImgAddress = currentImgAddress + imgSize*imgSize;
				//loadType = 0;
				isImageLoaded = 1;
				image = loadOut;
			end else if(loadType == 1) begin
				filterCounter = filterCounter + 1;
				currentfilterAddress = currentfilterAddress + filterSize*filterSize;
				isFilterLoaded = 1;
				filter = loadOut[0:24];	
			end else begin
				prevData = loadPrevDataOut[0];
				loadPrevDataEnable = 0;
			end

			loadingOp = 0;
			loadEnable = 0;
		end
		
		if(reset) begin
			done = 0;
			imgCounter = 0;
			filterCounter = 0;
			loadingOp = 0;
			loadType = 0;
			isImageLoaded = 0;
			isFilterLoaded = 0;
			convEnable = 0;
			writeEnable = 0;
		end
		else if (enable && loadingOp == 0 && done == 0) begin
			if(imgCounter == 0 && filterCounter == 0) begin
				currentImgAddress = imgsAddress;
				isImageLoaded = 0;
				currentfilterAddress = filterAddress;
				isFilterLoaded = 0;
				writeAddr = imgsAddress + imgSize * imgSize * imgsNumber;
			end
			
			if(isImageLoaded == 0) begin
				loadingOp = 1;
				loadEnable = 1;
				loadSize = imgSize;
				loadAddr = currentImgAddress;
				loadType = 0;
			end else if(isFilterLoaded == 0 && writeEnable == 0) begin
				loadingOp = 1;
				loadEnable = 1;
				loadSize = filterSize;
				loadAddr = currentfilterAddress;
				loadType = 1;
			end else if(writeEnable == 0) begin
				convEnable = 1;
				loadingOp = 1;
				loadPrevDataEnable = 1;
				loadType = 2;
			end
			
		end
	end
endmodule
