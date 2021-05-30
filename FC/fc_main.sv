module fc_main #(parameter firstLayerNodes = 3,
                  parameter secondLayerNodes = 2, 
                  parameter thirdLayerNodes = 10)
                 (enable,
                  clk,
                  finished,
                  result,
                  reset);
    
    input enable;
    input clk;
    output finished;
    output [3:0]result;
    input reset;
    reg enable1, enable2, enable3, finished1, finished2;
    
    reg [15:0] mem[0:16383];
    
    reg [1919:0] data_out; //120 * 16  bit
    reg [13:0] address;
    reg [15:0] data_in;
    reg write_enable;
    reg read_enable;
    reg finishedMem;
    
    wire [15: 0] readAddress1    = 0;
    wire [15: 0] weightsAddress1 = readAddress1 + firstLayerNodes;
    wire [15: 0] biasesAddress1  = weightsAddress1 + firstLayerNodes * secondLayerNodes;
    wire [15: 0] writeAddress1  = biasesAddress1 + secondLayerNodes;
    
    wire [15: 0] readAddress2    = writeAddress1;
    wire [15: 0] weightsAddress2 = readAddress2 + secondLayerNodes;
    wire [15: 0] biasesAddress2  = readAddress2 + secondLayerNodes + secondLayerNodes * thirdLayerNodes;
    
    // FCmemory mem(
    // .data_out(data_out),
    // .address(address),
    // .data_in(data_in),
    // .write_enable(write_enable),
    // .read_enable(read_enable),
    // .clk(clk),
    // .finished(finishedMem)
    // );

    reg [1: 0]layer;
    reg [15: 0] inputNodes1R[0: firstLayerNodes - 1];
    reg [15: 0] outputNodes1R[0: secondLayerNodes - 1];
    reg [15: 0] weights1R[0: firstLayerNodes * secondLayerNodes - 1];
    reg [15: 0] biases1R[0: secondLayerNodes - 1];

    reg [15: 0] outputNodes2R[0: thirdLayerNodes - 1];
    reg [15: 0] weights2R[0: secondLayerNodes * thirdLayerNodes - 1]; // secondLayerNodes * thirdLayerNodes - 1
    reg [15: 0] biases2R[0: thirdLayerNodes - 1];

    reg reset1, reset2, reset3;

    fc_layer#(.numNodesIn(firstLayerNodes),.numNodesOut(secondLayerNodes))
    fc1(.enable(enable1),
    .reset(reset1),
    .inputNodes(inputNodes1R),
    .outputNodes(outputNodes1R),
    .weights(weights1R),
    .biases(biases1R),
    .finished(finished1),
    .clk(clk)
    );
    
    fc_layer#(.numNodesIn(secondLayerNodes),.numNodesOut(thirdLayerNodes))
    fc2(.enable(enable2),
    .reset(reset2),
    .inputNodes(outputNodes1R),
    .outputNodes(outputNodes2R),
    .weights(weights2R),
    .biases(biases2R),
    .finished(finished2),
    .clk(clk)
    );

    Comparitor comper(.Arr(outputNodes2R),.clk(clk),.done(finished),.result(result),.enable(enable3),.reset(reset3));

    
    reg [15:0] i, j, it , k, f1, f2, f3;
    always @(posedge clk) begin
        if (reset == 1)begin
            i      <= 0;
            j      <= 0;
            it     <= 0;
            k      <= 0;
            //dav    <= 0;
            layer  <= 0;
            reset1 <= 1;
            reset2 <= 1;
            reset3 <= 1;
            f1 <= 0;
            f2 <= 0;
            f3 <= 0;
            enable3 <= 0;
        end
        else if (enable) begin
            if (layer == 0)begin
                reset1       <= 0;
                enable1      <= 0;
                write_enable <= 0;
                read_enable  <= 1;
                address      <= 0;
                
                if (j<firstLayerNodes) begin
                    inputNodes1R[j] = mem[j];
                    j <= j+1;
                end
                else begin
                    f1 <= 1;
                end
                
                if (i<secondLayerNodes)begin
                    if (it<firstLayerNodes)begin
                        weights1R[(i*firstLayerNodes)+it] <= mem[weightsAddress1 + (i*firstLayerNodes) + it];
                        it <= it+1;
                    end
                    else begin
                        it          <= 0;
                        i           <= i+1;
                    end
                end
                else begin
                    f2 <= 1;
                end
                
                if (k<secondLayerNodes)begin
                    biases1R[k] <= mem[biasesAddress1 + k];
                    k <= k+1;
                end
                else begin
                    f3 <= 1;
                end
                
                if (f1 == 1 && f2 == 1 && f3 == 1) begin
                    enable1 <= 1;
                end
                
                if (finished1 == 1)begin
                    enable1      <= 0;
                    read_enable  <= 0;
                    enable2      <= 1;
                    write_enable <= 1;
                    layer        <= 1;
                    f2 <= 0;
                    f3 <= 0;
                    i  <= 0;
                    j  <= 0;
                    it <= 0;
                    k  <= 0;
                    // if (dav<secondLayerNodes)begin
                    //     mem[writeAddress1 + dav] <= outputNodes1R[writeAddress1 + dav];
                    //     dav <= dav+1;
                    // end
                end
            end

            else if (layer == 1)begin
                reset2       <= 0;
                enable2      <= 0;
                write_enable <= 0;
                read_enable  <= 1;
                address      <= 0;
                
                if (i<thirdLayerNodes)begin
                    if (it<secondLayerNodes)begin
                        weights2R[(i*secondLayerNodes)+it] <= mem[weightsAddress2 + (i*secondLayerNodes) + it];
                        it <= it+1;
                    end
                    else begin
                        it          <= 0;
                        i           <= i+1;
                    end
                end
                else begin
                    f2 <= 1;
                end
                
                if (k<thirdLayerNodes)begin
                    biases2R[k] <= mem[biasesAddress2 + k];
                    k <= k+1;
                end
                else begin
                    f3 <= 1;
                end
                
                if (f2 == 1 && f3 == 1) begin
                    enable2 <= 1;
                end
                
                if (finished2 == 1)begin
                    enable1      <= 0;
                    read_enable  <= 0;
                    enable2      <= 0;
                    write_enable <= 1;
                    layer        <= 2;
                end
            end
            else if (layer == 2)begin
                enable3 <= 1;
                reset3  <= 0;
            end
        end
    end
endmodule
