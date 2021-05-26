
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
                stage = 2;
            end
            
            else if (stage == 2) begin
            outputNodes[outputsI] <= 0;
            inputsI               <= 0;
            curWeightsI           <= 0;
            stage = 3;
        end
        
        else if (stage == 3) begin
        outputNodes[outputsI] = outputNodes[outputsI] + inputNodes[inputsI] * weights[weightsI];
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
    end
    
    else if (stage == 4) begin
    outputNodes[outputsI] = outputNodes[outputsI] + biases[outputsI];
    outputsI              = outputsI + 1;
    if (outputsI < numNodesOut) begin
        stage = 2;
    end
    else
        stage = 5;
    end
    
    else begin
    finished = 1;
    end
    
    end
    end
endmodule
