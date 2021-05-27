module main_testbench ();

    reg enable,clk,finished,reset;
    reg [3:0]result;

    fc_main #(.firstLayerNodes(3),.secondLayerNodes(2),.thirdLayerNodes(10))fc (.enable(enable),
                  .clk(clk),
                  .finished(finished),
                  .result(result),
                  .reset(reset));

initial
begin
    // first reset the component  
    clk = 1;
    enable = 0;
    reset = 1;
    #100 clk=~clk;
    reset = 0;
    enable = 1;
    #100 clk=~clk;
    while (~finished) begin
        #100 clk=~clk;
    end
    if (result == 4'b0000) begin
        $display("Right answer");
    end else begin
        $error("Wrong answer");
    end
end
endmodule