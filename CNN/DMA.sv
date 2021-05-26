module DMA (clk, enable, RW, address, inputDATA, outputData); 
localparam ADDR_WIDTH = 16;
localparam  DATA_WIDTH = 16;
localparam  BLOCK_SIZE = 25;// output array size 
input clk, RW, enable; 
input [ADDR_WIDTH-1:0] address;
input [DATA_WIDTH-1:0] inputDATA; 
output outputData;

reg [DATA_WIDTH-1:0] outputData [0:BLOCK_SIZE-1];

reg [DATA_WIDTH -1 : 0]ram [0:(BLOCK_SIZE * 100)];


// RAM ram(clk, enable,address,RW,ramIn,ramOut);
integer i;
initial begin
    for (i = 0; i < BLOCK_SIZE*100; i = i + 1 ) begin
        ram[i] = 16'b0000010000000000; 
    end
end

always @(posedge clk) begin

    if (enable ==1) begin
        if (RW) begin //read 1
            outputData = ram[0:BLOCK_SIZE-1]; 
	  
        end
        else begin //write 0
            ram[address] = inputDATA; 
        end
    end

end

    




// parameter parallel_PE = 150;
// parameter columns = 10;
// parameter tot_weight_size =  320;
// input clk; 
// input [ADDR_WIDTH-1:0] address; 
// input read_on_MM,enable; 
// out reg [(DATA_WIDTH* parallel_PE):0] dataMainMemo; 

// reg signed [DATA_WIDTH-1:0] mem [0:tot_weight_size-1]; 
// integer  k;
// always @(negedge clk) begin
//     for (k = 0; k < parallel_PE; k= k+1) begin
//         if (enable) begin
//             dataMainMemo[k*DATA_WIDTH+:DATA_WIDTH] <= read_on_MM?mem[columns*k+address]: 16'b0; 
//         end
//         else begin
//             dataMainMemo[k*DATA_WIDTH+:DATA_WIDTH] <= 8192'bz;
//         end
//     end
// end
// initial begin
//     $readmemh(file,mem); 
// end
endmodule