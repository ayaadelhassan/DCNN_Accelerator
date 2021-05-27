
module FCmemory(
    output reg [1919:0] data_out, //120 * 16  bit 
    input [13:0] address,
    input [15:0] data_in, 
    input write_enable,
    input read_enable,
    input clk
);
reg [6:0] i =0;
reg currentState=1;
// integer i;
    reg [15:0] FCmemory [0:16383];  //2^14   // 120 + 120*84 + 84 + 84 + 84* 10 + 10 +10   //11228
	always @(posedge clk,currentState) begin
        if (write_enable) begin
            FCmemory[address] <= data_in;  
        end
        if(read_enable && currentState )begin
        data_out[(i*16)+:16] = FCmemory[address+i];
        i=i+1;
        end
    end


    always @(posedge clk,i) begin
        if(i<120)
        currentState = 1'b1;
        else
        currentState = 1'b0;
    end
	
// 	genvar i;
//  generate
//     for (i=0; i<120; i=i+1) 
//     begin:loop1
// 	assign data_out[(i+1)*16-1:i*16] = FCmemory[address+i];
// 	end
//   endgenerate

    

endmodule