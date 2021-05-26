module test (clk);
    input clk; 
    parameter  DATA_WIDTH = 16;
    parameter ADDR_WIDTH = 20;
    localparam DATA_SIZE = 16;
    parameter  BLOCK_SIZE = 150;// output array size 
    localparam noOfLayerAddr = 1;
    reg dmaRW; 
    reg dmaEnable;
    reg [ADDR_WIDTH-1:0] loadImgOutAddr; 
    reg [DATA_WIDTH-1:0] dmaInput;
    reg [DATA_WIDTH-1:0] dmaOut [0:BLOCK_SIZE-1];
    reg done; 
    wire [DATA_SIZE -1: 0] out[0:1023];
    reg [DATA_WIDTH-1:0] dmaInputAddr; 
    reg [DATA_WIDTH-1:0] cnnOutAddr; 
    wire [DATA_WIDTH-1:0] imgSize;
    wire loadImgOutDmaEnable,opDone; 
    wire cnnLoadImgEnable,cnnOutDmaEnable; 
    wire [DATA_SIZE - 1:0] cnnLoadImgAddrr; 
    reg cnnDone; 
    
    assign opDone = ((cnnOutDmaEnable && done) || (cnnLoadImgEnable && done));
    assign dmaEnable = cnnOutDmaEnable || loadImgOutDmaEnable ; 
    DMA dma(.clk(clk),.enable(dmaEnable),.RW(1'b1),.address(dmaInputAddr), .inputDATA(dmaInput),.outputData(dmaOut));
    
    LoadImage limg (.clk(clk),.enable(cnnLoadImgEnable), .dmaEnable(loadImgOutDmaEnable), .imgSize(imgSize), .address(address), .initialAddr(cnnLoadImgAddrr), .image(dmaOut) ,.done(done), .out(out) );
    
    CNN_ALU (.clk(clk), .enable(1'b1), .reset(reset), .initialAddr(16'd0), 
    .address(cnnOutAddr), .memFetchResult(dmaOut) ,.imgSize(imgSize), .fetchedImage(out) ,          // original image address in ram 
    .dmaEnable(cnnOutDmaEnable), .opDone(opDone), .done(cnnDone),.imgAddr(16'd12) ,.loadImageEnable(cnnLoadImgEnable), .loadImgAddrr(cnnLoadImgAddrr) );
  
endmodule