module convolution_layer(clk, enable, reset, loadDone,
		imgsNumber, imgSize, imgsAddress, 
		filtersNumber, filterSize, biasAddress, 
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
	input reg [ADDR_SZ-1:0] biasAddress;
	reg [ADDR_SZ-1:0] filterAddress;
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
	reg [ADDR_SZ-1:0] convWriteAddr; 
	reg signed [DATA_SZ -1: 0] convWriteOut;
	reg convWriteEnable, convLoadPrevDataEnable;

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
	
	reg biasesEnable, biasesDone, isBiasesDone, biasesWriteEnable, biasesLoadEnable;
	reg [ADDR_SZ-1:0] outImgAddress;
	reg [DATA_SZ-1:0] outImageSize;
	reg [ADDR_SZ-1:0] loadBiasAddr;
	reg [DATA_SZ-1:0] writeBias;
	reg [ADDR_SZ-1:0] biasesWriteAddr;
	
	assign filterPerImage = filtersNumber/imgsNumber;
	
	assign filterAddress = biasAddress + filterPerImage;
	
	assign outImageSize = imgSize - ((filterSize >> 1) << 1);
	
	assign outImgAddress = imgsAddress + imgSize * imgSize * imgsNumber;
	
	assign writeAddr = (isBiasesDone)? convWriteAddr : (biasesWriteEnable)? biasesWriteAddr:loadBiasAddr;
	
	assign writeOut = (isBiasesDone)? convWriteOut : writeBias;

	assign writeEnable = convWriteEnable || biasesWriteEnable;

	assign loadPrevDataEnable = convLoadPrevDataEnable || biasesLoadEnable;

	biases_repeater br(.clk(clk), .enable(biasesEnable), .reset(reset), .biasAddress(biasAddress), 
		.numberOfBiases(filterPerImage), .outImgAddress(outImgAddress), .outImgSize(outImageSize), 
		.loadAddr(loadBiasAddr), .loadedBiases(loadPrevDataOut), .loadEnable(biasesLoadEnable), 
		.writeBias(writeBias), .writeAddr(biasesWriteAddr), .writeEnable(biasesWriteEnable), 
		.done(biasesDone));

	convolve_image_clked ci(.clk(clk), .reset(reset), .enable(convEnable), 
				.imgSize(imgSize), .image(image), .filterSize(filterSize),
		 		.filter(filter), .convolved(convoloved), .done(convDone));
	
	
	add ad(.in1(convoloved),.in2(prevData),.out(convWriteOut));

	always @(posedge clk)   // Loops on the images and filter then do the convolution
	begin
		if(biasesDone) begin
			isBiasesDone = biasesDone;
			biasesEnable = 0;	
		end

		if(isBiasesDone == 0 && enable) begin
			biasesEnable = 1;
		end
		
		if(done) begin
			done = 0;
			imgCounter = 0;
			filterCounter = 0;
			loadingOp = 0;
			loadType = 0;
			isImageLoaded = 0;
			isFilterLoaded = 0;
			isBiasesDone = 0;
			convEnable = 0;
			loadEnable = 0;
			biasesEnable = 0;
			convWriteEnable = 0;
			convLoadPrevDataEnable = 0;
		end
		
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
		
		if(convWriteEnable) begin
			convWriteEnable = 0;
			if(isImageLoaded) begin
				convWriteAddr = convWriteAddr + 1;
			end else begin
				convWriteAddr = imgsAddress + imgSize * imgSize * imgsNumber;
			end
		end

		if(convEnable)begin
			convWriteEnable = 1 ;
			convEnable = 0; 
		end	
		
		if((loadDone || convLoadPrevDataEnable) && loadingOp) begin
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
				convLoadPrevDataEnable = 0;
			end

			loadingOp = 0;
			loadEnable = 0;
		end
		
		if(reset) begin
			done = 0;
			imgCounter = 0;
			filterCounter = 0;
			loadingOp = 0;
			loadEnable = 0;
			loadType = 0;
			isImageLoaded = 0;
			isFilterLoaded = 0;
			convEnable = 0;
			convWriteEnable = 0;
			isBiasesDone = 0;
			biasesEnable = 0;
			convLoadPrevDataEnable = 0;
		end
		else if (enable && isBiasesDone && loadingOp == 0 && done == 0) begin
			if(imgCounter == 0 && filterCounter == 0) begin
				currentImgAddress = imgsAddress;
				isImageLoaded = 0;
				currentfilterAddress = filterAddress;
				isFilterLoaded = 0;
				convWriteAddr = imgsAddress + imgSize * imgSize * imgsNumber;
			end
			
			if(isImageLoaded == 0) begin
				loadingOp = 1;
				loadEnable = 1;
				loadSize = imgSize;
				loadAddr = currentImgAddress;
				loadType = 0;
			end else if(isFilterLoaded == 0 && convWriteEnable == 0) begin
				loadingOp = 1;
				loadEnable = 1;
				loadSize = filterSize;
				loadAddr = currentfilterAddress;
				loadType = 1;
			end else if(convWriteEnable == 0) begin
				convEnable = 1;
				loadingOp = 1;
				convLoadPrevDataEnable = 1;
				loadType = 2;
			end
			
		end
	end
endmodule
