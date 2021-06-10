module Comparitor(
    Arr0,Arr1,Arr2,Arr3,Arr4,Arr5,Arr6,Arr7,Arr8,Arr9,clk,done,result,enable,reset
);
    input [15:0]Arr0;
    input [15:0]Arr1;
    input [15:0]Arr2;
    input [15:0]Arr3;
    input [15:0]Arr4;
    input [15:0]Arr5;
    input [15:0]Arr6;
    input [15:0]Arr7;
    input [15:0]Arr8;
    input [15:0]Arr9;
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
            max  <= Arr0;
            i  <= 4'b0001;
            maxIndex <= 4'b0000;
            done <= 0;
        end
    if(enable == 1) begin
        if(done == 0) begin
            // Check if the max is arr[i]
            if(i == 1)begin
                max <= ($signed(Arr1) > $signed(max))? Arr1 : max;
                maxIndex <= ($signed(Arr1) > $signed(max))? i : maxIndex;
            end
            else if (i == 2) begin
                max <= ($signed(Arr2) > $signed(max))? Arr2 : max;
                maxIndex <= ($signed(Arr2) > $signed(max))? i : maxIndex;
            end
            else if (i == 3) begin
                max <= ($signed(Arr3) > $signed(max))? Arr3 : max;
                maxIndex <= ($signed(Arr3) > $signed(max))? i : maxIndex;
            end
            else if (i == 4) begin
                max <= ($signed(Arr4) > $signed(max))? Arr4 : max;
                maxIndex <= ($signed(Arr4) > $signed(max))? i : maxIndex;
            end
            else if (i == 5) begin
                max <= ($signed(Arr5) > $signed(max))? Arr5 : max;
                maxIndex <= ($signed(Arr5) > $signed(max))? i : maxIndex;
            end
            else if (i == 6) begin
                max <= ($signed(Arr6) > $signed(max))? Arr6 : max;
                maxIndex <= ($signed(Arr6) > $signed(max))? i : maxIndex;
            end
            else if (i == 7) begin
                max <= ($signed(Arr7) > $signed(max))? Arr7 : max;
                maxIndex <= ($signed(Arr7) > $signed(max))? i : maxIndex;
            end
            else if (i == 8) begin
                max <= ($signed(Arr8) > $signed(max))? Arr8 : max;
                maxIndex <= ($signed(Arr8) > $signed(max))? i : maxIndex;
            end
            else if (i == 9) begin
                max <= ($signed(Arr9) > $signed(max))? Arr9 : max;
                maxIndex <= ($signed(Arr9) > $signed(max))? i : maxIndex;
            end
            
            // prepare to next loop
            i <= i + 1;
            // Set the result
            if (i>=9) begin
                result <= maxIndex;
                done <= 1;
            end
        end 
    end
end
endmodule