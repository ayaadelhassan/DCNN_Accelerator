
module CNN_ALU (clk, enable, reset, initialAddr, 
address, dmaOut ,imgSize, filterSize, noOfFilters, 
prevImagesCount, dmaEnable, opDone, done, poolEnable, convEnable , convORpoolDone ,imgAddr ,loadImageEnable );

    localparam MEM_ADDR_SIZE = 20;
    localparam BLOCK_SIZE = 150;
    localparam DATA_SIZE = 16;
    localparam noOfLayerAddr = 1;
    localparam IMAGE_ADDR = 0;

    input clk,enable, reset,opDone ,convORpoolDone; 
    input  [MEM_ADDR_SIZE - 1 : 0] initialAddr;
    input [DATA_SIZE-1:0] dmaOut [0:BLOCK_SIZE-1]; 
    
    output address; // address for layer info 
    output loadImageEnable, dmaEnable;
    output convEnable,poolEnable;
    output imgSize; 
    output imgAddr; // for conv or pool layer to load from 
    output filterSize; 
    output noOfFilters; 
    output prevImagesCount; 
    output done; 

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
    reg [DATA_SIZE-1:0] result ; 
    reg [DATA_SIZE-1:0] interMediaResult;
    reg convORpoolDone; 
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
    reg opDone,done; 
    integer  counter;
    integer filterCounter; 
    integer layerCounter;

    always @(posedge clk) begin
        if(reset)begin
        //stage 1 load # of layers
        dmaEnable = 1;
        address = noOfLayerAddr; 
        readNoOfLayersSignal = 1;
        // initial signals 
        opDone = 0; 
        convDone = 0; 
        poolDone = 0; 
        counter = 0;
        imgSize = 32; 
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

    integer i; 
    always @(posedge clk) begin
        opDone = opDone ||  convORpoolDone; 
        
        if(enable && convORpoolDone) begin
            convORpoolDone = 0; 
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
                noOfLayers = dmaOut[0];
                layerCounter = 0; 
                dmaEnable = 0; 
                readNoOfLayersSignal = 0; // now load layer data if not loaded 
            end
            if(readLayerDataSignal)begin
               dmaEnable = 0; 
               layerType = dmaOut[0]; 
               filterSize = dmaOut[1]; 
               noOfFilters = dmaOut[2]; 
               doneReadLayerDataSignal = 1;  
            end

            if (layerCounter < noOfLayers)begin
                if(doneReadLayerDataSignal == 0) // if type not loaded the load it
                begin
                    address = address + 1; 
                    dmaEnable = 1;
                    //raed = 1;  
                    readLayerDataSignal = 1; 
                end  
                else begin 
                    convEnable = layerType;
                    poolEnable = ! layerType;
                    if(convEnable)
                        address = address + 3; 
                    else 
                        address = address + 1; 

                    // out to pool or conv prevImagesCount, address, noOfFilters, filter-size , image-size.
                end 
            end else begin
                done = 1;
                opDone = 0;  
            end
            
        end
          
    end
endmodule
