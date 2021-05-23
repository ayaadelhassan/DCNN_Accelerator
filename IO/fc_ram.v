
module FCmemory(
    output [1919:0] data_out, //120 * 16  bit 
    input [13:0] address,
    input [15:0] data_in, 
    input write_enable,
    input clk
);
    reg [15:0] FCmemory [0:16383];  //2^14   // 120 + 120*84 + 84 + 84 + 84* 10 + 10 +10   //11228
	always @(posedge clk) begin
        if (write_enable) begin
            FCmemory[address] <= data_in;  
        end
		
    end
	
	genvar i;
 generate
    for (i=0; i<120; i=i+1) 
    begin:loop1
	assign data_out[(i+1)*16-1:i*16] = FCmemory[address+i];
	end
  endgenerate

    

endmodule