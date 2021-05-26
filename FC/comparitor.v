module Comparitor(
    Arr,clk,done,result,enable,reset
);
    input [15:0]Arr[0:9];
    input clk;
    input enable;
    input reset;
    output reg done;
    output reg [3:0]result;

    reg [15:0]max;
    reg [3:0]i;
    reg [3:0] maxIndex;

always @(posedge clk) begin
    if(reset == 1) begin
            assign max  = Arr[0];
            assign i  = 4'b0001;
            assign maxIndex = 4'b0000;
            assign done = 0;
        end
    if(enable == 1) begin
        if(done == 0) begin
            // Check if the max is arr[i]
            assign max = (Arr[i] > max)? Arr[i] : max;
            assign maxIndex = (Arr[i] > max)? i : maxIndex;
            // prepare to next loop
            assign i = i + 1;
            // Set the result
            if (i>=9) begin
                assign result = maxIndex;
                assign done = 1;
            end
        end 
    end
end
endmodule