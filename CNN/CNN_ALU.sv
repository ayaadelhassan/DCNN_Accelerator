
module CNN_ALU (clk, enable, reset, initialAddr, address, dmaOut ,imgSize, loadImageEnable, dmaEnable,opDone,done );
    localparam MEM_ADDR_SIZE = 20;
    localparam BLOCK_SIZE = 150;
    localparam DATA_SIZE = 16;
    localparam  noOfLayerAddr = 1;

    input clk,enable, reset,opDone; 
    output reg [MEM_ADDR_SIZE - 1 : 0] address;
    input  [MEM_ADDR_SIZE - 1 : 0] initialAddr;
    input [DATA_SIZE-1:0] dmaOut [0:BLOCK_SIZE-1]; 
    output loadImageEnable, dmaEnable;
    reg convEnable,poolEnable;
    reg loadImageEnable, dmaEnable,convEnable,poolEnable; 
    output [5:0] imgSize; 
    output done; 
    reg prevImagesCount, prevFiltersCount; 
    reg [DATA_SIZE-1:0] noOfLayers; 
    reg [DATA_SIZE-1:0] layerType; 
    reg [DATA_SIZE-1:0] filterSize;  
    reg [DATA_SIZE-1:0] noOfFilters;  
    reg [DATA_SIZE-1:0] filter [0:24];//max size of filter
    reg convDone, poolDone; 
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

    
    integer  counter;
    integer filterCounter; 
    integer layerCounter;

    initial begin
        //stage 1 load # of layers
        convDone = 0; 
        poolDone = 0; 
        opDone = 0; 
        dmaEnable = 1;
        address = noOfLayerAddr; 
        readNoOfLayersSignal = 1; 
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


    intger i; 
    always @(posedge clk) begin
        opDone = opeDone || convDone || poolDone; 
        if (opDone)begin // there is an operation done 
            opDone = 0;

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
            if(readFilterSignal)begin
                dmaEnable =0; 
                for ( i= 0 ;i<filterSize ;i = i + 1 ) begin
                    filter[i] = dmaOut[i]; 
                end
                //apply conv here 
               convEnable = 1; 
               convDone = 0;
               filterCounter = filterCounter + 1; 
            end
            if (layerCounter < noOfLayers)begin
                if(doneReadLayerDataSignal == 0) // if type not loaded the load it
                begin
                    address = address + 1; 
                    dmaEnable = 1;
                    raed = 1;  
                    readLayerDataSignal = 1; 
                    convDone = 1;
                end   
                else if(layerType == 1 /* value is dmmmy */&&  filterCounter < noOfFilters && convDone == 1 ) begin // if data are loaded  
                    
                    filtersPerImage = noOfFilters / prevImagesCount; 
                    // keep data loaded
                    if(filterCounter == 0)begin
                        address = address + 2;
                    end else begin
                        address = address + (filterSize * filterSize); 
                    end
                    dmaEnable = 1; // might make it another dma change only enable and returned value 
                    readFilterSignal = 1; 
                end 
                else if(layerType == 0) begin 
                    poolEnable = 1; 
                    layerCounter = layerCounter + 1; 
                    doneReadLayerDataSignal =0;
                    
                end else if (filterCounter == noOfFilters)begin
                    readFilterSignal = 0; // filters sinished
                    layerCounter = layerCounter + 1; 
                    doneReadLayerDataSignal =0;
                    prevFiltersCount = noOfFilters; 
                end


            end else begin
                done = 1;
                opDone = 0;  
            end
            
        end
          
    end
endmodule
