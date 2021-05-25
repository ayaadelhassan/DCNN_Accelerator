module load_block (clk, enable, size, address, dmaOut, dmaAddr, out, done);
    localparam MEM_ADDR_SIZE = 16;
    localparam BLOCK_SIZE = 25;
    localparam DATA_SIZE = 16;
    localparam IMG_SIZE_WIDTH = 16;
    input clk, enable; 
    input [IMG_SIZE_WIDTH-1:0] size;
    output reg done; 
    output reg [MEM_ADDR_SIZE - 1 : 0] dmaAddr;
    input  [MEM_ADDR_SIZE - 1 : 0] address;
    input [DATA_SIZE-1:0] dmaOut [0:BLOCK_SIZE-1];
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
        operand = BLOCK_SIZE;
	for(integer j = 0; j<1024; j++) out[j] = 0;
    end
    
    assign iterations = (size * size / 10'd25) + 1;
    
    integer  i;
    always @(negedge clk)begin
	 if(counter == 0)begin
           dmaAddr = address;
        end
    end 

    always @(posedge clk) begin
        if(counter < iterations && done == 0) begin
            for(i = 0 ; i < BLOCK_SIZE ; i = i +1 )begin
               	k = counter*operand;
                k = k + i;  
                out[k] = dmaOut[i];
            end
	counter =  counter + 1; 
        dmaAddr = dmaAddr + 10'd25;
        end else begin
           done = 1;
        end
    end
endmodule