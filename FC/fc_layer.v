module fc_layer #(parameter numNodesIn = 5,
                  parameter numNodesOut = 3)
                 (enable,
                  readAddress,
                  finished);
    
    // Bias for this layer and its enable to start working
    input enable;
    
    // The address from which to start reading weights from memory and another to start writing output.
    // input [15:0] readAddress, writeAddress, weightsAddress, biasesAddress;
    
    input wire[15:0] readAddress;
    wire [15: 0] writeAddress   = readAddress + numNodesIn + numNodesIn * numNodesOut + numNodesOut;
    wire [15: 0] weightsAddress = readAddress + numNodesIn;
    wire [15: 0] biasesAddress  = readAddress + numNodesIn + numNodesIn * numNodesOut;
    
    // 5 nodes
    // 5 * 3 weights
    // 3 biases
    // 3 o/p
    // 3 * 1 weights
    // 1 biases
    // 1 o/p
    
    //                 input nodes   total num of weights       biases      output nodes for writing
    reg [15: 0] mem[0: numNodesIn + numNodesIn * numNodesOut + numNodesOut + numNodesOut];
    // The whole block for this operation
    
    reg [15: 0] outputNodes[0: numNodesOut - 1];
    
    reg [15: 0] readMem[0: numNodesIn - 1]; // input nodes' weights
    // The block returned in every read operation (will be 120)
    
    // We read the input nodes once at the start
    reg [15: 0] inputNodes[0: numNodesIn - 1];
    
    // Output signal when the layer finishes
    output reg finished;
    
    integer i, j, it;
    always @(enable) begin
        for (it = 0; it < numNodesIn; it = it + 1) begin
            inputNodes[it] = mem[it];
        end
        if (enable) begin
            for (j = 0; j < numNodesOut; j = j+1) begin
                // Initialize current output node
                outputNodes[j] = 0;
                
                // Read starting from weightsAddress (skip the first 5 nodes) +
                //                   numNodesIn * j (go to the start of the weights of the current output node)
                //  then read the numNodesIn(five) weights starting from that
                for (it = 0; it < numNodesIn; it = it + 1) begin
                    readMem[it] = mem[weightsAddress + (numNodesIn * j) + it];
                end
                
                for (i = 0; i < numNodesIn; i = i+1) begin
                    outputNodes[j] = outputNodes[j] + readMem[i] * inputNodes[i];
                end
                
                // Write the outputnode after adding its bias
                mem[writeAddress + j] = outputNodes[j] + mem[biasesAddress + j];
            end
            finished <= 1;
        end
    end
endmodule
