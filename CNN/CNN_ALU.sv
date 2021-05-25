
module CNN_ALU (clk, enable, reset, initialAddr, 
address, memFetchResult ,imgSize, fetchedImage, 
 dmaEnable, opDone, done ,imgAddr ,loadImageEnable , loadImgAddrr,dmaRWSignal );

    localparam MEM_ADDR_SIZE = 20;
    localparam BLOCK_SIZE = 150;
    localparam DATA_SIZE = 16;
    localparam n = 32;
    localparam IMAGE_ADDR = 0;

    input clk,enable, reset,opDone ; 
    input  [MEM_ADDR_SIZE - 1 : 0] initialAddr;
    input [DATA_SIZE-1:0] memFetchResult [0:BLOCK_SIZE-1]; 
    input [DATA_SIZE-1:0] fetchedImage [0:n*n-1];
    
    output address,dmaRWSignal;
    output loadImageEnable, dmaEnable;
    output loadImgAddrr; 
    output done; 
     //imgSize; 
    //input  [DATA_SIZE-1:0] orgImgSize; 
    input  imgAddr; // for conv or pool layer to load from  
    output imgSize; 

    reg [MEM_ADDR_SIZE - 1 : 0] loadImgAddrr; 
    reg [MEM_ADDR_SIZE - 1 : 0] address; 
    reg [MEM_ADDR_SIZE - 1 : 0] imgAddr; 
    reg dmaEnable,convEnable,poolEnable; 
    reg [DATA_SIZE-1:0] prevImagesCount, prevFiltersCount; 
    reg [DATA_SIZE-1:0] noOfLayers; 
    reg [DATA_SIZE-1:0] layerType; 

    reg [DATA_SIZE-1:0] imgSize;  
    reg [DATA_SIZE-1:0] filterSize;  
    reg [DATA_SIZE-1:0] noOfFilters;  
    reg [DATA_SIZE-1:0] filter [0:24];//max size of filter
    reg convDone, poolDone; 
    reg [DATA_SIZE-1:0] poolLoadAddr; 
    reg poolDmaRW; 

    reg [DATA_SIZE-1:0] result ; 
    reg [DATA_SIZE-1:0] interMediaResult;
    //signals 
    reg readNoOfLayersSignal;    
    reg readLayerDataSignal;    
    reg readFilterSignal; 
    reg readImageSignal;
    reg saveImageSignal; 
    reg doneReadNoOfLayersSignal;    
    reg doneReadLayerDataSignal;    
    reg doneReadFilterSignal; 
    reg doneReadImageSignal;
    reg donesaveImageSignal; 
    reg opDone,done,dmaRWSignal; 
    integer  counter;
    integer filterCounter; 
    integer layerCounter;

    always @(posedge clk) begin
        if(reset)begin
        //stage 1 load # of layers
        dmaEnable = 1;
        address = initialAddr; 
        readNoOfLayersSignal = 1;
        // initial signals 
        imgSize = 32;
        opDone = 0; 
        convDone = 0; 
        poolDone = 0; 
        counter = 0;
        filterCounter = 0;  
        prevImagesCount = 1;
        prevFiltersCount = 1; 
        readNoOfLayersSignal = 0;
        readLayerDataSignal = 0; 
        readFilterSignal = 0; 
        readImageSignal = 0; 
        saveImageSignal = 0; 
        doneReadNoOfLayersSignal = 0;    
        doneReadLayerDataSignal = 0;    
        doneReadFilterSignal = 0; 
        doneReadImageSignal = 0;
        donesaveImageSignal = 0; 
        end

    end
    //assign imgSize = orgImgSize; 
    PoolLayer (.clk(clk),.enable(poolEnable), .reset(reset), .imagesCount(prevImagesCount), .imgSize(imgSize),
     .address(imgAddr), .done(poolDone) , .loadImgEnable(loadImageEnable), .loadImgAddrr(loadImgAddrr), .image(fetchedImage) , .opDone(opDone),.RW(poolDmaRW));
    integer i; 
    always @(posedge clk) begin
        opDone = opDone ||  poolDone; 
        if(enable && (poolDone || convDone)) begin
            poolDone = 0; 
            convDone =0; 
            imgAddr = prevImagesCount * imgSize * imgSize; // address of first intermidiat result for next layer    
            if(layerType)begin //conv 
                 address = address + (noOfFilters * filterSize * filterSize); 
                 prevImagesCount = noOfFilters / prevImagesCount; 
                 imgSize  = imgSize - (2 * (filterSize / 2));   
            end 
            else begin
                 imgSize = imgSize / 2;
            end
            layerCounter = layerCounter + 1; 
            doneReadLayerDataSignal = 0;
        end

        if (enable && opDone)begin // there is an operation done 
            opDone = 0;
            poolEnable = 0; 
            convEnable = 0; 
            if(readNoOfLayersSignal)begin // got number of layers 
                noOfLayers = memFetchResult[0];
                layerCounter = 0; 
                dmaEnable = 0; 
                readNoOfLayersSignal = 0; // now load layer data if not loaded 
            end
            if(readLayerDataSignal)begin
               dmaEnable = 0; 
               layerType = memFetchResult[0]; 
               filterSize = memFetchResult[1]; 
               noOfFilters = memFetchResult[2]; 
               doneReadLayerDataSignal = 1;  
            end

            if (layerCounter < noOfLayers)begin
                if(doneReadLayerDataSignal == 0) // if type not loaded the load it
                begin
                    address = address + 1; 
                    dmaEnable = 1;
                    dmaRWSignal = 1; //read
                    //raed = 1;  
                    readLayerDataSignal = 1; 
                end  
                else begin 
                    convEnable = layerType;
                    poolEnable = ! layerType;
                    dmaRWSignal = poolDmaRW; 
                    if(convEnable) begin
                        address = address + 3; 
                    end
                    else begin 
                        address = address + 1; 
                    end 
                    

                    // out to pool or conv prevImagesCount, address, noOfFilters, filter-size , image-size.
                end 
            end else begin
                done = 1;
                opDone = 0;  
            end
            
        end
          
    end
endmodule
