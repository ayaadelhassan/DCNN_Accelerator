module fc_mains(enable,
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
    
    reg [15:0] mem[0:127];
    
    reg [1919:0] data_out; //5 * 16  bit
    
    wire [15: 0] readAddress1    = 0;
    wire [15: 0] weightsAddress1 = readAddress1 + 5;
    wire [15: 0] biasesAddress1  = weightsAddress1 + 5 * 3;
    wire [15: 0] writeAddress1   = biasesAddress1 + 3;
    
    // wire [15: 0] readAddress1    = 0;
    // wire [15: 0] weightsAddress1 = readAddress1 + 5;
    // wire [15: 0] biasesAddress1  = weightsAddress1 + 5 * 3;
    
    wire [15: 0] readAddress2    = 5 + 5 * 3 + 3 + 3;
    wire [15: 0] weightsAddress2 = readAddress2 + 3;
    wire [15: 0] biasesAddress2  = weightsAddress2 + 3 * 10;
    wire [15: 0] writeAddress2   = biasesAddress2 + 10;
    
    // FCmemory mem(
    // .data_out(data_out),
    // .address(address),
    // .data_in(data_in),
    // .write_enable(write_enable),
    // .read_enable(read_enable),
    // .clk(clk),
    // .finished(finishedMem)
    // );
    reg [2: 0]layer;
    reg [15: 0] inputNodes1R[0: 4];
    reg [15: 0] outputNodes1R[0: 2];
    reg [15: 0] weights1R[0: 14]; // 5 * 3 - 1
    reg [15: 0] biases1R[0: 2];
    
    // wire [15: 0] outputNodes1[0: 83];
    // wire [15: 0] biases1[0: 83]; //??????
    
    reg [15: 0] outputNodes2R[0: 9];
    reg [15: 0] weights2R[0: 29]; // 3 * 10 - 1
    reg [15: 0] biases2R[0: 9];
    
    // wire [15: 0] outputNodes2[0: 83];
    // wire [15: 0] weights2[0: 839]; // 3 * 1 - 1
    // wire [15: 0] biases2[0: 9];
    reg reset1, reset2, reset3;
    fc_layer#(.numNodesIn(5),.numNodesOut(3))
    fc1(.enable(enable1),
    .reset(reset1),
    .inputNodes(inputNodes1R),
    .outputNodes(outputNodes1R),
    .weights(weights1R),
    .biases(biases1R),
    .finished(finished1),
    .clk(clk)
    );
    
    fc_layer#(.numNodesIn(3),.numNodesOut(10))
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
    
    // assign inputNodes1  = inputNodes1R;
    // assign outputNodes1 = outputNodes1R;
    // assign weights1     = weights1R;
    // assign biases1      = biases1R;
    
    // assign outputNodes2 = outputNodes2R;
    // assign weights2     = weights2R;
    // assign biases2      = biases2R;
    reg [15:0] i, j, it , k, f1, f2, f3;
    always @(posedge clk) begin
        if (reset == 1)begin
            i       <= 0;
            j       <= 0;
            it      <= 0;
            k       <= 0;
            //dav   <= 0;
            layer   <= 0;
            reset1  <= 1;
            reset2  <= 1;
            f1      <= 0;
            f2      <= 0;
            f3      <= 0;
            enable3 <= 0;
            reset3  <= 1;
        end
        else if (enable) begin
            if (layer == 0)begin
                reset1  <= 0;
                enable1 <= 0;
                
                if (j<5) begin
                    inputNodes1R[j] = mem[j];
                    j <= j+1;
                end
                else begin
                    f1 <= 1;
                end
                
                if (i<3)begin
                    if (it<5)begin
                        weights1R[(i*5)+it] <= mem[weightsAddress1 + it + 5 * i];
                        it                  <= it+1;
                    end
                    else begin
                        it <= 0;
                        i  <= i+1;
                    end
                end
                else begin
                    f2 <= 1;
                end
                
                if (k<3)begin
                    biases1R[k] <= mem[biasesAddress1 + k];
                    k           <= k+1;
                end
                else begin
                    f3 <= 1;
                end
                
                if (f1 == 1 && f2 == 1 && f3 == 1) begin
                    enable1 <= 1;
                end
                
                if (finished1 == 1)begin
                    enable1 <= 0;
                    enable2 <= 1;
                    layer   <= 1;
                    f2      <= 0;
                    f3      <= 0;
                    i       <= 0;
                    j       <= 0;
                    it      <= 0;
                    k       <= 0;
                    // if (dav<3)begin
                    //     mem[writeAddress1 + dav] <= outputNodes1R[writeAddress1 + dav];
                    //     dav                      <= dav+1;
                    // end
                end
            end
            
            else if (layer == 1)begin
            reset2  <= 0;
            enable2 <= 0;
            
            if (i<10)begin
                if (it<3)begin
                    weights2R[(i*3)+it] <= mem[weightsAddress2 + it + (i*3)];
                    it                  <= it+1;
                end
                else begin
                    it <= 0;
                    i  <= i+1;
                end
            end
            else begin
                f2 <= 1;
            end
            
            if (k<10)begin
                biases2R[k] <= mem[biasesAddress2 + k];
                k           <= k+1;
            end
            else begin
                f3 <= 1;
            end
            
            if (f2 == 1 && f3 == 1) begin
                enable2 <= 1;
            end
            
            if (finished2 == 1)begin
                enable1 <= 0;
                enable2 <= 0;
                layer   <= 2;
            end
        end
            else if (layer == 2)begin
            enable3 <= 1;
            reset3  <= 0;
            end
            
            
            end
            end
            endmodule
