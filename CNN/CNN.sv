

module CNN (clk, enable,reset);

    // load image  clk, enable, RW, address, inputDATA, outputData
    parameter ADDR_WIDTH = 20;
    parameter  BLOCK_SIZE = 150;// output array size 
    reg dmaRW; 
    reg dmaEnable
    reg [ADDR_WIDTH-1:0] address; 
    reg [DATA_WIDTH-1:0] dmaInput;
    reg [DATA_WIDTH-1:0] dmaOut [0:BLOCK_SIZE-1];
    reg [BLOCK_SIZE -1:0] filterInput; 
    reg filterBufferRW; 
    reg filterbufferEnable; 
    reg filterEmpty; 
    reg [24:0] filterOut; 

    reg [DATA_WIDTH-1:0] image [1023:0];
    // -----------------------------------------------
    
    loadImage img(------, done); 
    loadFIltgers(   enable(done), done , reset));
    DMA dma(.clk(clk),.enable(dmaEnable),.RW(dmaRW),.address(address), .inputDATA(dmaInput),.outputData(dmaOut));
    filterbuffer  filtrebuff ( .clk(clk),  .enable(filterbufferEnable), .RW(filterBufferRW) , .inFilter(filterInput), .outFilter(filterOut), .empty(filterEmpty));
    
    always @(posedge clk, reset) begin
        if (reset)begin
            RW = 0; 
            address = 0; 
        end
        if(enable) begin
            // load Img
            if (counter = 1){
                address = address + 150; 
            }else ifcounter = 1 {

            }


            


        end
    end
    
endmodule