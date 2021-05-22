module LoadImage (clk, enable, imgSize, address, initialAddr, image ,done, out );
    localparam MEM_ADDR_SIZE = 32;
    localparam BLOCK_SIZE = 150;
    localparam DATA_SIZE = 16;
    localparam IMG_SIZE_WIDTH = 6;
    input clk, enable; 
    input [IMG_SIZE_WIDTH-1:0] imgSize;
    output reg done; 
    output reg [MEM_ADDR_SIZE - 1 : 0] address;
    input  [MEM_ADDR_SIZE - 1 : 0] initialAddr;
    input [DATA_SIZE-1:0] image [0:BLOCK_SIZE-1];
    reg [DATA_SIZE-1:0] iterations;
    reg [2:0] counter;

    output reg [DATA_SIZE -1: 0] out[0:1023]; 

    initial begin
        counter = 0;  
        iterations = (imgSize * imgSize / BLOCK_SIZE) + 1;
        address = initialAddr; 
    end
    integer  i;
    always @(posedge clk) begin
        if(counter < iterations && done == 0) begin
            for(i = (counter * BLOCK_SIZE); i < (counter * BLOCK_SIZE) + BLOCK_SIZE; i = i +1 )begin
                out[i] = image[i - counter * BLOCK_SIZE];
            end
	    counter =  counter + 1; 
            address = address + BLOCK_SIZE; 
        end else begin
            done = 1;
        end
    end
endmodule