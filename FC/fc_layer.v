
module fc_layer #(parameter numNodesIn = 5,
                  parameter numNodesOut = 3)
                 (enable,
                  inputNodes,
                  outputNodes,
                  weights, 
                  biases,
                  finished,
                  clk);

    // The address from which to start reading weights from dataory and another to start writing output.
    // input [15:0] readAddress, writeAddress, weightsAddress, biasesAddress;
    
    // input wire[15:0] readAddress = 0;
    // wire [15: 0] writeAddress   = readAddress + numNodesIn + numNodesIn * numNodesOut + numNodesOut;
    // wire [15: 0] weightsAddress = readAddress + numNodesIn;
    // wire [15: 0] biasesAddress  = readAddress + numNodesIn + numNodesIn * numNodesOut;
    

    // 5 nodes
    // 5 * 3 weights
    // 3 biases
    // 3 o/p
    // 3 * 1 weights
    // 1 biases
    // 1 o/p
    
    // enable to start working
    input enable;
    input clk;
    // //                 input nodes   total num of weights       biases      output nodes for writing
    // reg [15: 0] data[0: numNodesIn + numNodesIn * numNodesOut + numNodesOut + numNodesOut];
    // // The whole block for this operation
    
    // reg [15: 0] readdata[0: numNodesIn - 1]; // input nodes' weights
    // // The block returned in every read operation (will be 120)
    
    // We read the input nodes once at the start
    input [15: 0] inputNodes[0: numNodesIn - 1];
    output reg [15: 0] outputNodes[0: numNodesOut - 1];
    input [15: 0] weights[0: numNodesIn * numNodesOut - 1];
    input [15: 0] biases[0: numNodesOut - 1];
    
    // Output signal when the layer finishes
    output reg finished;
    
    integer i, j, it;
    always @(posedge clk) begin
        // for (it = 0; it < numNodesIn; it = it + 1) begin
        //     inputNodes[it] = data[it];
        // end
        if (enable) begin
            
            for (it = 0; it < numNodesIn; it = it + 1) begin
                inputNodes[it] = data[it];
            end
            
            for (j = 0; j < numNodesOut; j = j+1) begin
                // Initialize current output node
                outputNodes[j] = 0;
                
                address = j * numNodesIn + numNodesIn;
                for (it = 0; it < numNodesIn; it = it + 1) begin
                    weights[it] = data_out[it];
                end
                // Read starting from weightsAddress (skip the first 5 nodes) +
                //                   numNodesIn * j (go to the start of the weights of the current output node)
                //  then read the numNodesIn(five) weights starting from that
                // for (it = 0; it < numNodesIn; it = it + 1) begin
                //     readdata[it] = data[weightsAddress + (numNodesIn * j) + it];
                // end
                
                for (i = 0; i < numNodesIn; i = i+1) begin
                    outputNodes[j] = outputNodes[j] + weights[i] * inputNodes[i];
                end
                
                // Write the outputnode after adding its bias
                //outputNodes[j] = outputNodes[j] + biases[j];
                finished = 1;
            end
            
        end
    end
endmodule