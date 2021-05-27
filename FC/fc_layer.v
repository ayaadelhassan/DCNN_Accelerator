
module fc_layer #(parameter numNodesIn = 5,
                  parameter numNodesOut = 3)
                 (enable,
                  reset,
                  inputNodes,
                  outputNodes,
                  weights,
                  biases,
                  finished,
                  clk);
    
    // enable to start working
    input enable, reset;
    input clk;
    
    // We read the input nodes once at the start
    input [15: 0] inputNodes[0: numNodesIn - 1];
    output reg [15: 0] outputNodes[0: numNodesOut - 1];
    input [15: 0] weights[0: numNodesIn * numNodesOut - 1];
    input [15: 0] biases[0: numNodesOut - 1];
    
    reg [15: 0] mulInput1, mulInput2;
    wire[15: 0] mulOutput;
    reg mulFinished, mulEnable, mulReset;
    reg [15: 0] addInput1, addInput2;
    wire[15: 0] addOutput;
    
    reg startedMultiplier;
    Multiplier #(parameter N = 16) mul(.M(mulInput1), .R(mulInput2), .mulResult(mulOutput), .clk(clk), .finish(mulFinished), .enable(mulEnable), .reset(mulReset));

    add adder(.in1(addInput1), .in2(addInput2), .out(addOutput));
    
    reg [1: 0] state;
    // Output signal when the layer finishes
    output reg finished;
    
    reg [10: 0] inputsI;
    reg [10: 0] weightsI;
    reg [10: 0] curWeightsI;
    reg [10: 0] outputsI;
    reg [10: 0] stage;
    
    always @(posedge clk) begin
        
        if (reset == 1) begin
            stage = 1;
        end
        if (enable) begin
            
            if (stage == 1) begin
                weightsI <= 0;
                inputsI  <= 0;
                outputsI <= 0;
                startedMultiplier <= 0;
                stage = 2;
                state = 0;
            end
            
            else if (stage == 2) begin
                outputNodes[outputsI] <= 0;
                inputsI               <= 0;
                curWeightsI           <= 0;
                stage = 3;
            end
        
            else if (stage == 3) begin
                if (state == 0) begin
                    if (startedMultiplier == 0) begin
                        mulEnable = 1;
                        mulReset = 1;
                        mulInput1 = inputNodes[inputsI];
                        mulInput2 = weights[weightsI];
                        startedMultiplier = 1;
                    end
                    if (mulFinished == 1) begin
                        state = 1 ;
                        mulEnable = 0;
                        startedMultiplier = 0;
                    end
                end
                else if (state == 1) begin
                    addInput1 = mulOutput;
                    addInput2 = outputNodes[outputsI];
                    state = 2;
                end
                else begin
                    outputNodes[outputsI] = addOutput;
                    curWeightsI           = curWeightsI + 1;
                    if (curWeightsI < numNodesIn) begin
                        weightsI = weightsI + 1;
                        inputsI  = inputsI + 1;
                    end
                    else begin
                        curWeightsI = curWeightsI - 1;
                        weightsI    = weightsI + 1;
                        stage       = 4;
                    end
                    state = 0;
                end
            end
    
            else if (stage == 4) begin
                if (state == 0) begin
                    addInput1 = biases[outputsI];
                    addInput2 = outputNodes[outputsI];
                    state = 1;
                end
                else begin
                    outputNodes[outputsI] = addOutput;
                    outputsI = outputsI + 1;
                    if (outputsI < numNodesOut) begin
                        stage = 2;
                    end
                    else
                        stage = 5;
                    state = 0;
                end
            end
    
            else 
                finished = 1;


        end
    end
endmodule
