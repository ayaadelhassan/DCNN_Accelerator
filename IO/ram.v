
module memory(
    output [15:0] data_out,
    input [7:0] address,
    input [15:0] data_in, 
    input write_enable,
    input clk
);
    reg [15:0] memory [0:2048];

    always @(posedge clk) begin
        if (write_enable) begin
            memory[address] <= data_in;
        end
    end

    assign data_out = memory[address];

endmodule
//150 filters   -- 1024 img ---- 