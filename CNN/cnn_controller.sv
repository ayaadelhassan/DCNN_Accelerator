module cnn_controller (clk, enable, reset, orgLayerAddress, orgImgAddress,
 memFetchResult ,orgImgSize, imgSize ,fetchedImage, loadBlockAddress, dmaInput,
 dmaEnable, dmaDone, dmaAddress, done ,loadImageEnable,loadImageDone , loadImgAddress, loadEnable, writeEnable);

input clk,enable, reset,dmaDone,loadImageDone,orgLayerAddress ,
orgImgAddress,orgImgSize,memFetchResult,fetchedImage,loadBlockAddress; 
output dmaEnable, loadImageEnable, loadEnable, writeEnable;// read & write signal to dma
output dmaAddress, imgSize , loadImgAddress, done,dmaInput; 

localparam n = 32;
localparam BLOCK_SIZE = 25;
localparam DATA_SIZE = 16;

reg clk, enable, reset,dmaDone,loadImageDone,dmaEnable,loadEnable,writeEnable, done; 
wire loadImageEnable; 
reg [DATA_SIZE-1:0] orgLayerAddress; 
reg [DATA_SIZE-1:0] orgImgSize; 
reg [DATA_SIZE-1:0] imgSize; 
wire [DATA_SIZE-1:0] dmaAddress;  
wire [DATA_SIZE-1:0] loadImgAddress;  
reg [DATA_SIZE-1:0] orgImgAddress;  
wire [DATA_SIZE-1:0] loadBlockAddress;  
reg signed [DATA_SIZE-1:0] memFetchResult [0:BLOCK_SIZE-1]; 
wire signed [DATA_SIZE-1:0] dmaInput; 
reg signed [DATA_SIZE-1:0] fetchedImage [0:n*n-1]; 

// input buffers  
reg [DATA_SIZE-1:0] layerAddressBuffer; 
reg [DATA_SIZE-1:0] imgAddressBuffer; 
reg [DATA_SIZE-1:0] imgSizeBuffer; 

//number of prev images buffer input to pool and conv 
reg [DATA_SIZE-1:0] imgsCountBuffer; 


// # of layers 
reg doneReadNoOFLayers; 
reg readNoOfLayers; 
reg signed [DATA_SIZE-1:0] noOfLayers;
reg signed [DATA_SIZE-1:0] layerCounter; 


// layer data 
reg doneReadLayerData; 
reg readLayerData; 
reg signed [DATA_SIZE-1:0] layerType; 
reg signed [DATA_SIZE-1:0] filterSize; 
reg signed [DATA_SIZE-1:0] noOfFilters; 

// conv and pool
reg convEnable, poolEnable, convDone, poolDone,convOrpoolRun; 
reg poolLoadEnable, poolWriteEnable; 
reg [DATA_SIZE-1:0] poolWriteAddress; 
reg [DATA_SIZE-1:0] poolReadAddress; 
reg  [DATA_SIZE-1:0] poolLoadImgAddress;
reg  [DATA_SIZE-1:0] poolLoadSize;
reg  [DATA_SIZE-1:0] poolWriteOut;

reg convLoadEnable, convWriteEnable,convLoadPrevDataEnable; 
reg  [DATA_SIZE-1:0] convWriteAddress; 
reg  [DATA_SIZE-1:0] convLoadSize;
reg  [DATA_SIZE-1:0] convLoadImgAddress; 
reg  [DATA_SIZE-1:0] convLoadPrevDataOut; 
reg  [DATA_SIZE-1:0] convWriteOut; 




pool_layer poolModule (.clk(clk), .enable(poolEnable), .reset(reset), .loadDone(loadImageDone),
		.imgsNumber(imgsCountBuffer), .imgSize(imgSizeBuffer), .imgsAddress(imgAddressBuffer), .windowSize(filterSize), 
		.loadAddr(poolLoadImgAddress), .loadSize(poolLoadSize), .loadOut(fetchedImage), .loadEnable(poolLoadEnable),
 		.writeAddr(poolWriteAddress), .writeOut(poolWriteOut), .writeEnable(poolWriteEnable),
		.done(poolDone));

convolution_layer convModule(.clk(clk), .enable(convEnable), .reset(reset), .loadDone(loadImageDone),
		.imgsNumber(imgsCountBuffer), .imgSize(imgSizeBuffer), .imgsAddress(imgAddressBuffer), 
		.filtersNumber(noOfFilters), .filterSize(filterSize), .biasAddress(layerAddressBuffer), 
		.loadAddr(convLoadImgAddress), .loadSize(convLoadSize), .loadOut(fetchedImage),
		.writeAddr(convWriteAddress), .writeOut(convWriteOut), .writeEnable(convWriteEnable),
		.loadPrevDataOut(memFetchResult), .loadPrevDataEnable(convLoadPrevDataEnable),
		.loadEnable(convLoadEnable), .done(convDone));

/**always @(convWriteEnable)begin
	dmaInput = convWriteOut;
end*/
assign dmaInput = poolEnable? poolWriteOut : convWriteOut;
assign dmaAddress = ( poolEnable == 0 && convEnable == 0 )?
layerAddressBuffer : ( poolEnable? ((poolWriteEnable) ? poolWriteAddress : loadBlockAddress):
((convWriteEnable || convLoadPrevDataEnable) ? convWriteAddress : loadBlockAddress) );
assign loadImgAddress = ( poolEnable ) ? poolLoadImgAddress : convLoadImgAddress;
assign loadImageEnable = (poolEnable == 0 && convEnable == 0)? 0 : (poolEnable?poolLoadEnable: convLoadEnable);
always @(layerAddressBuffer,convLoadPrevDataEnable,convWriteAddress, poolWriteAddress, poolLoadEnable, poolWriteEnable,convLoadEnable,convWriteEnable) begin

      if(poolEnable)begin
            //loadImgAddress = poolLoadImgAddress; 
            imgSize = poolLoadSize; 
            //dmaAddress = (poolWriteEnable) ? poolWriteAddress : loadBlockAddress; 
            dmaEnable = poolWriteEnable; 
            //dmaInput = poolWriteOut; 
            //loadImageEnable = poolLoadEnable;
        end else if(convEnable) begin
            //dmaAddress = (convWriteEnable || convLoadPrevDataEnable) ? convWriteAddress : loadBlockAddress; 
            //loadImgAddress = convLoadImgAddress;
            dmaEnable = convWriteEnable; 
            //loadImageEnable = convLoadEnable;
            imgSize = convLoadSize; 
        end
        //  else
        //     dmaAddress = layerAddressBuffer;
end

always @(negedge clk) begin
	if(enable && dmaDone)begin	
	    if(readNoOfLayers && doneReadNoOFLayers)begin
		    noOfLayers = memFetchResult[0]; 
     		readNoOfLayers = 0;
		   
	    end
	    if(readLayerData && doneReadLayerData)begin
		    layerType = memFetchResult[0]; 
		    filterSize = memFetchResult[1]; 
		    noOfFilters = memFetchResult[2]; 
     		readLayerData = 0;
           
	    end
	end
end

always @(posedge clk) begin
    if(reset)begin
        doneReadNoOFLayers = 0; 
        readNoOfLayers = 0; 
        noOfLayers = 0;  
        doneReadLayerData = 0;
        readLayerData = 0;
        layerType = 0; 
        filterSize= 0;
        noOfFilters= 0;
        layerCounter = 0; 
        poolEnable = 0; 
        convEnable = 0; 
        imgsCountBuffer = 1;
    end
    if(enable)begin  
        if(dmaDone  || convDone || poolDone )begin
            convOrpoolRun = 0;
            if((convEnable && convDone) || ( poolEnable && poolDone) )begin
                if(convEnable)begin
                    // increase address by # of filters * size of filter 
                    layerAddressBuffer = layerAddressBuffer+ (filterSize * filterSize * noOfFilters) - 1;
                    // clac new image size after last conv
                    imgSizeBuffer = imgSizeBuffer - ((filterSize/2) * 2); 
                    //calc # of feature maps from prev layer conv layer
                    imgsCountBuffer = noOfFilters / imgsCountBuffer; 
                    convEnable = 0;  
                end else begin
                    // image size after last bool
                    imgSizeBuffer = imgSizeBuffer / 2; 
                    layerAddressBuffer= layerAddressBuffer + 2;
                    poolEnable = 0; 
                end
                // incraese image address by prev no of feature map to start fetch new maps 
                imgAddressBuffer = imgAddressBuffer + imgsCountBuffer * imgSizeBuffer * imgSizeBuffer; 
                
                doneReadLayerData = 0;
                layerCounter = layerCounter + 1; 
            end
            
            if(readNoOfLayers)begin  
                doneReadNoOFLayers = 1; 
		         loadEnable = 0; 
		         dmaEnable = 0;
            end
            if(readLayerData)begin  
                doneReadLayerData = 1; 
                convOrpoolRun = 1;
		        loadEnable = 0; 
		        dmaEnable = 0;
            end
            if(doneReadNoOFLayers==0)begin // read # of layers 
                dmaEnable = 1;
	            readNoOfLayers = 1;
		        loadEnable =1;
		       // loadImageEnable =0;
                //initial buffers
	            layerAddressBuffer = orgLayerAddress; 
                imgAddressBuffer = orgImgAddress;
                imgSizeBuffer = orgImgSize; 
                //dmaAddress = layerAddressBuffer;
            end else if(convEnable == 0 && poolEnable == 0 && layerCounter < noOfLayers)begin
                if(doneReadLayerData == 0)begin // read layer data 
                    dmaEnable = 1;
                    layerAddressBuffer= layerAddressBuffer+ 1; 
                    readLayerData = 1; 
                    loadEnable = 1; 
                    //loadImageEnable = 0; 
                   //dmaAddress = layerAddressBuffer;
                end else if(convOrpoolRun == 0)  begin
                    convEnable = layerType[0];
                    if(convEnable)
                        layerAddressBuffer = layerAddressBuffer + 3; 
                    poolEnable = !layerType[0]; 

                end 
            end
        end
    end
end

endmodule 