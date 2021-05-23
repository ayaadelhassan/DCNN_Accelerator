module test (clk);
    input clk; 
    parameter  DATA_WIDTH = 16;
    parameter ADDR_WIDTH = 20;
    localparam DATA_SIZE = 16;
    parameter  BLOCK_SIZE = 150;// output array size 
    reg dmaRW; 
    reg dmaEnable;
    reg [ADDR_WIDTH-1:0] address; 
    reg [DATA_WIDTH-1:0] dmaInput;
    reg [DATA_WIDTH-1:0] dmaOut [0:BLOCK_SIZE-1];
    reg done; 
    reg [DATA_SIZE -1: 0] out[0:1023];

    DMA dma(.clk(clk),.enable(1'b1),.RW(1'b1),.address(address), .inputDATA(dmaInput),.outputData(dmaOut));
    LoadImage limg (.clk(clk), .enable(1'b1), .imgSize(6'd32), .address(address), .initialAddr(20'b0), .image(dmaOut) ,.done(done), .out(out) );
    
endmodule