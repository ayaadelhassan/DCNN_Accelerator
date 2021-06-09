module comp_testbench (clk);
    input clk;
    reg enable,finished,reset;
    reg [3:0]result;
    reg [15:0]Arr[0:9];

    Comparitor compare (.Arr(Arr),.clk(clk),.done(finished),.result(result),.enable(enable),.reset(reset));

initial begin
    Arr[0] = 16'b0000100000000000;
    Arr[1] = 16'b0000000000000000;
    Arr[2] = 16'b0000000000000001;
    Arr[3] = 16'b0000000000000010;
    Arr[4] = 16'b0000000000000100;
    Arr[5] = 16'b0000000000001000;
    Arr[6] = 16'b0000000000010000;
    Arr[7] = 16'b0000000000100000;
    Arr[8] = 16'b0000000001000000;
    Arr[9] = 16'b0000000010000000;
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