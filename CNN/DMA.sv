module DMA (clk, enable, RW, address, inputDATA, outputData); 
localparam ADDR_WIDTH = 16;
localparam  DATA_WIDTH = 16;
localparam  BLOCK_SIZE = 25;// output array size 
input clk, RW, enable; 
input [ADDR_WIDTH-1:0] address;
input [DATA_WIDTH-1:0] inputDATA; 
output outputData;

reg signed [DATA_WIDTH-1:0] outputData [0:BLOCK_SIZE-1];

reg signed [DATA_WIDTH -1 : 0]ram [0:(BLOCK_SIZE * 100)];


// RAM ram(clk, enable,address,RW,ramIn,ramOut);
integer i,counter, j;

initial begin
    for (i = 0; i < BLOCK_SIZE*100; i = i + 1 ) begin
        ram[i] = i; 
    end

	/*ram[0] = 16'b0000100000000000;
	ram[1] = 16'b0001000000000000;*/
    ram[0] = 16'b0000000000000101;
    ram[1] = 16'b0000000000000001;
    ram[4] = 16'b0000000000001000;
    ram[5] = 16'b0010000000000000;

    ram[2] = 16'b0000000000000011;
    ram[3] = 16'b0000000000000010;
    ram[6] = 16'b0001010000000000;
    ram[7] = 16'b0011100000000000;


    ram[8] = 16'b1111000000000000;
    ram[9] = 16'b1111000000000000;
    ram[12] = 16'b1110100000000000;
    ram[13] = 16'b1101100000000000;


    ram[10] = 16'b0000100000000000;
    ram[11] = 16'b0000010000000000;
    ram[14] = 16'b0001010000000000;
    ram[15] = 16'b0110000000000000;
    ram[21] = 16'b0000000000000000;
    ram[22] = 16'b0000000000000000;
    ram[23] = 16'b0000000000000010;
    ram[24] = 16'b0000000000000001;


    ram[46] = 16'b1111000000000000;
    ram[47] = 16'b1111000000000000;
    ram[48] = 16'b1110100000000000;
    ram[49] = 16'b1101100000000000;
    

end
 
always @(posedge clk) begin

    if (enable == 1) begin
        if (RW) begin //read 1
            for(counter = 0; counter<= address; counter= counter + 1)begin
                 if(counter == address)begin
                     for(j = 0; j< BLOCK_SIZE; j++)
                        outputData[j] = ram[j+counter];
                 end
            end
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