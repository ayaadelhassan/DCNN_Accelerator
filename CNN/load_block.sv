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
    reg signed [DATA_SIZE -1: 0] out[0:1023]; 

    initial begin
        counter = 0;  
	done = 0; 
        k = 0; 
        operand = 25;
    end

    assign iterations = (((size * size) +  10'd25 - 1)/ 10'd25);
    
    integer  i;

    always @(posedge clk) begin
	if(done) begin
		done = 0;
		counter = 0;
		k = 0;
	end
	
	if(enable) begin
        	if(counter == 0)begin
           		dmaAddr = address;
        	end
		
		if(counter < iterations && done == 0) begin
        		for(i = 0 ; i < 25 ; i = i +1 )begin
        		       	k = counter*operand;
        		        k = k + i;  
        		        out[k] = dmaOut[i];
       			end
			counter =  counter + 1; 
        		dmaAddr = dmaAddr + 10'd25;
        	end

		if(counter == iterations) begin
			done = 1;
		end
	end
    end
endmodule