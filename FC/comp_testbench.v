module comp_testbench (clk);
    input clk;
    reg enable,finished,reset;
    reg [3:0]result;
    reg [15:0]Arr0;
    reg [15:0]Arr1;
    reg [15:0]Arr2;
    reg [15:0]Arr3;
    reg [15:0]Arr4;
    reg [15:0]Arr5;
    reg [15:0]Arr6;
    reg [15:0]Arr7;
    reg [15:0]Arr8;
    reg [15:0]Arr9;

    Comparitor compare (.Arr0(Arr0),.Arr1(Arr1),.Arr2(Arr2),.Arr3(Arr3),.Arr4(Arr4),.Arr5(Arr5),.Arr6(Arr6),.Arr7(Arr7),.Arr8(Arr8),.Arr9(Arr9),.clk(clk),.done(finished),.result(result),.enable(enable),.reset(reset));

initial begin
    Arr0 = 16'b0000100000000000;
    Arr1 = 16'b0000000000000000;
    Arr2 = 16'b0000000000000001;
    Arr3 = 16'b0000000000000010;
    Arr4 = 16'b0000000000000100;
    Arr5 = 16'b0000000000001000;
    Arr6 = 16'b0000000000010000;
    Arr7 = 16'b0000000000100000;
    Arr8 = 16'b0000000001000000;
    Arr9 = 16'b0000000010000000;
    enable = 0;
    reset = 1;
    #100 
    reset = 0;
    enable = 1;
end
always @(posedge clk) begin

if (finished) begin
      if (result == 4'b0000) begin
        $display("Right answer");
    end else begin
        $error("Wrong answer");
    end
end

end
endmodule