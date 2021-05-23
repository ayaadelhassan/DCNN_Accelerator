// compressed ram 
module memory(
    output [15:0] data_out,
    input [17:0] address,
    input [15:0] data_in, 
    input write_enable,
    input clk
);
    reg [15:0] memory [0:262143];  // address will be 18 bits  -  32*32*16*16 worst image case

    always @(posedge clk) begin
        if (write_enable) begin
            memory[address] <= data_in;
        end
    end

    assign data_out = memory[address];

endmodule
