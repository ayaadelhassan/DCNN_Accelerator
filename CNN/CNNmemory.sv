
// CNN ram 
module CNNmemory(
    output [15:0] data_out[0:24], //25 * 16  bit 
    input [15:0] address,
    input [15:0] data_in, 
    input write_enable,
    input clk
);
    reg [15:0] CNNmemory [0:2499];  //2^16  //memory size 655 (150)+ 9655 (2400) + 192055 (48000) + 32*32 (1024) io outputs + 3 + 6 + 96 + 1920 + 4704 + 1167 + 1600 + 400  --->  FC inputs in FC ram ==   61470

    initial begin
        $readmemb("1.mem", CNNmemory);
    end

    always @(posedge clk) begin
        if (write_enable) begin
            CNNmemory[address] <= data_in;
        end

    end

    genvar i;
 generate
    for (i=0; i<25; i=i+1) 
    begin:loop1
    assign data_out[i][15:0] = CNNmemory[address+i];
    end
  endgenerate
endmodule 