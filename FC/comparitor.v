module Comparitor(
    Arr,result
);
    input [15:0]Arr[0:9];
    output reg [3:0]result;

    reg [15:0]max;
    reg [3:0]i;

always @* begin
    assign max  = Arr[0];
    assign result = 4'b0000;
    
    for (i = 1;i<9 ;i = i + 1 ) begin
        assign max = (Arr[i] > max)? Arr[i] : max;
        assign result = (Arr[i] > max)? i : result;
    end
end
    
endmodule