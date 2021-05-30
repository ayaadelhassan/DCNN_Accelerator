module main_testbench ();

    reg enable,clk,finished,reset;
    reg [3:0]result;

    fc_main #(.firstLayerNodes(3),.secondLayerNodes(2),.thirdLayerNodes(10))fc (.enable(enable),
                  .clk(clk),
                  .finished(finished),
                  .result(result),
                  .reset(reset));

initial begin
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