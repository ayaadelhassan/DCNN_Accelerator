
module cnn_controller (clk, enable, reset, orgLayerAddress, orgImgAddress,
 memFetchResult ,orgImgSize, imgSize ,fetchedImage, 
 dmaEnable, dmaDone, dmaAddress, done ,loadImageEnable,loadImageDone , loadImgAddress, loadEnable, writeEnable);

input clk,enable, reset,dmaDone,loadImageDone,orgLayerAddress,orgImgAddress,orgImgSize,memFetchResult,fetchedImage; 
output dmaEnable, loadImageEnable, loadEnable, writeEnable;// read & write signal to dma
output dmaAddress, imgSize, loadImgAddress, done; 

localparam n = 32;
localparam BLOCK_SIZE = 25;
localparam DATA_SIZE = 16;

reg clk, enable, reset,dmaDone,loadImageDone,dmaEnable,loadImageEnable,loadEnable,writeEnable, done; 
reg [DATA_SIZE-1:0] orgLayerAddress; 
reg [DATA_SIZE-1:0] orgImgSize; 
reg [DATA_SIZE-1:0] imgSize; 
reg [DATA_SIZE-1:0] dmaAddress;  
reg [DATA_SIZE-1:0] loadImgAddress;  
reg [DATA_SIZE-1:0] orgImgAddress;  
reg signed [DATA_SIZE-1:0] memFetchResult [0:BLOCK_SIZE-1]; 
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

        imgsCountBuffer = 1;
    end
    if(enable)begin
        if(dmaDone || convDone || poolDone )begin
            convOrpoolRun = 0;
            if((convEnable && convDone) || ( poolEnable && poolDone) )begin
                if(convEnable)begin
                    // increase address by # of filters * size of filter 
                    layerAddressBuffer= layerAddressBuffer+ (filterSize * filterSize * noOfFilters) + 2;
                    // clac new image size after last conv
                    imgSizeBuffer = imgSizeBuffer - ((filterSize/2) * 2); 
                    //calc # of feature maps from prev layer conv layer
                    imgsCountBuffer = noOfFilters / imgsCountBuffer; 
                    convEnable = 0;  
                end else begin
                    // image size after last bool
                    imgSizeBuffer = imgSizeBuffer / 2; 
                    poolEnable = 0; 
                end
                // incraese image address by prev no of feature map to start fetch new maps 
                imgAddressBuffer = imgAddressBuffer+ imgsCountBuffer * imgSizeBuffer * imgSizeBuffer; 
                
                doneReadLayerData = 0;
                layerCounter = layerCounter + 1; 
            end
            
            if(readNoOfLayers)begin  
                doneReadNoOFLayers = 1; 
            end
            if(readLayerData)begin  
                doneReadLayerData = 1; 
                convOrpoolRun = 1;
            end
            if(doneReadNoOFLayers==0)begin // read # of layers 
                dmaEnable = 1;
	            readNoOfLayers = 1;
		        loadEnable =1;
		        loadImageEnable =0;
                //initial buffers
	            layerAddressBuffer = orgLayerAddress; 
                imgAddressBuffer = orgImgAddress;
                imgSizeBuffer = orgImgSize; 

            end else if(layerCounter < noOfLayers)begin
                if(doneReadLayerData == 0)begin // read layer data 
                    dmaEnable = 1;
                    layerAddressBuffer= layerAddressBuffer+ 1; 
                    readLayerData = 1; 
                    loadEnable = 1; 
                    loadImageEnable = 0; 
                end else if(convOrpoolRun == 0)  begin
                    convEnable = layerType[0]; 
                    poolEnable = !layerType[0]; 

                end
            end
           

        end
        dmaAddress = layerAddressBuffer;
    end
end

endmodule 