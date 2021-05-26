module LoadImage (clk, enable,dmaEnable, imgSize, address, initialAddr, image ,done, out );
    localparam MEM_ADDR_SIZE = 20;
    localparam BLOCK_SIZE = 150;
    localparam DATA_SIZE = 16;
    localparam IMG_SIZE_WIDTH = 6;
    input clk, enable; 
    input [IMG_SIZE_WIDTH-1:0] imgSize;
    output reg done; 
    output reg dmaEnable; 
    output reg [MEM_ADDR_SIZE - 1 : 0] address;
    input  [MEM_ADDR_SIZE - 1 : 0] initialAddr;
    input [DATA_SIZE-1:0] image [0:BLOCK_SIZE-1];
    wire [DATA_SIZE-1:0] iterations;
    integer counter;
    integer k; 
    integer operand; 
    output out;
    reg [DATA_SIZE -1: 0] out[0:1023]; 
    initial begin
        counter = 0;  
	    done = 0; 
        k = 0; 
        operand = 25; 
    end
    
    assign iterations = (imgSize * imgSize / 10'd25) + 1;
    
    integer  i;
    always @(posedge clk)begin
	 if(counter == 0)begin
           address = initialAddr;
           dmaEnable = 1; 
        end
    end 

    always @(negedge clk) begin
        if(enable)begin
            dmaEnable = 0; 
            if(counter < iterations && done == 0) begin
                for(i = 0 ; i < 25 ; i = i +1 )begin
                    k = counter *operand;
                    k = k + i;  
                    out[k] = image[i];
                end
            counter =  counter + 1; 
            address = address + 10'd25;
            end else begin
            done = 1;
            end
        end
    end
endmodule