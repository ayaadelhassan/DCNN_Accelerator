// CNN ram 
module CNNmemory(
    output [399:0] data_out, //25 * 16  bit 
    input [15:0] address,
    input [15:0] data_in, 
    input write_enable,
    input clk
);
    reg [15:0] CNNmemory [0:65535];  //2^16  //memory size 6*5*5 (150)+ 96*5*5 (2400) + 1920*5*5 (48000) + 32*32 (1024) io outputs + 3 + 6 + 96 + 1920 + 4704 + 1167 + 1600 + 400  --->  FC inputs in FC ram ==   61470  

    always @(posedge clk) begin
        if (write_enable) begin
            CNNmemory[address] <= data_in;  
        end
		
    end
	
	genvar i;
 generate
    for (i=0; i<25; i=i+1) 
    begin:loop1
	assign data_out[(i+1)*16-1:i*16] = CNNmemory[address+i];
	end
  endgenerate

    

endmodule

