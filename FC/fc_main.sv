module fc_mains(enable,
               clk,
               finished,
               reset);
    
    input enable;
    input clk;
    output finished;
    input reset;
    reg enable1, enable2, finished1, finished2;
    
    reg [15:0] mem[0:16383];
    
    reg [1919:0] data_out; //120 * 16  bit
    reg [13:0] address;
    reg [15:0] data_in;
    reg write_enable;
    reg read_enable;
    reg finishedMem;
    
    wire [15: 0] readAddress1    = 0;
    wire [15: 0] weightsAddress1 = readAddress1 + 120;
    wire [15: 0] biasesAddress1  = weightsAddress1 + 120 * 84;
    wire [15: 0] writeAddress1  = biasesAddress1 + 84;
    
    // wire [15: 0] readAddress1    = 0;
    // wire [15: 0] weightsAddress1 = readAddress1 + 5;
    // wire [15: 0] biasesAddress1  = weightsAddress1 + 5 * 3;
    
    wire [15: 0] readAddress2    = 120 + 120 * 84 + 84 + 84;
    wire [15: 0] weightsAddress2 = readAddress2 + 84;
    wire [15: 0] biasesAddress2  = readAddress2 + 84 + 84 * 10;
    
    // FCmemory mem(
    // .data_out(data_out),
    // .address(address),
    // .data_in(data_in),
    // .write_enable(write_enable),
    // .read_enable(read_enable),
    // .clk(clk),
    // .finished(finishedMem)
    // );
    reg layer;
    reg [15: 0] inputNodes1R[0: 119];
    reg [15: 0] outputNodes1R[0: 83];
    reg [15: 0] weights1R[0: 10079]; // 120 * 84 - 1
    reg [15: 0] biases1R[0: 83];
    
    // wire [15: 0] outputNodes1[0: 83];
    // wire [15: 0] biases1[0: 83]; //??????
    
    reg [15: 0] outputNodes2R[0: 9];
    reg [15: 0] weights2R[0: 839]; // 84 * 10 - 1
    reg [15: 0] biases2R[0: 9];
    
    // wire [15: 0] outputNodes2[0: 83];
    // wire [15: 0] weights2[0: 839]; // 84 * 10 - 1
    // wire [15: 0] biases2[0: 9];
    reg reset1, reset2;
    fc_layer#(.numNodesIn(120),.numNodesOut(84))
    fc1(.enable(enable1),
    .reset(reset1),
    .inputNodes(inputNodes1R),
    .outputNodes(outputNodes1R),
    .weights(weights1R),
    .biases(biases1R),
    .finished(finished1),
    .clk(clk)
    );
    
    fc_layer#(.numNodesIn(84),.numNodesOut(10))
    fc2(.enable(enable2),
    .inputNodes(outputNodes1R),
    .outputNodes(outputNodes2R),
    .weights(weights2R),
    .biases(biases2R),
    .finished(finished2),
    .clk(clk)
    );
    
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
            i      <= 0;
            j      <= 0;
            it     <= 0;
            k      <= 0;
            //dav    <= 0;
            layer  <= 0;
            reset1 <= 1;
            f1 <= 0;
            f2 <= 0;
            f3 <= 0;
        end
        else if (enable) begin
            if (layer == 0)begin
                reset1       <= 0;
                enable1      <= 0;
                write_enable <= 0;
                read_enable  <= 1;
                address      <= 0;
                
                if (j<120) begin
                    inputNodes1R[j] = mem[j];
                    j <= j+1;
                end
                else begin
                    f1 <= 1;
                end
                
                if (i<84)begin
                    if (it<120)begin
                        weights1R[(i*120)+it] <= mem[weightsAddress1 + (i*120) + it];
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
                
                if (k<84)begin
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
                    f1 <= 1;
                    f2 <= 0;
                    f3 <= 0;
                    i  <= 0;
                    j  <= 0;
                    it <= 0;
                    k  <= 0;
                    // if (dav<84)begin
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
                
                if (i<84)begin
                    if (it<120)begin
                        weights2R[(i*120)+it] <= mem[weightsAddress2 + (i*120) + it];
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
                
                if (k<84)begin
                    biases2R[k] <= mem[biasesAddress2 + k];
                    k <= k+1;
                end
                else begin
                    f3 <= 1;
                end
                
                if (f1 == 1 && f2 == 1 && f3 == 1) begin
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
               
                end
                end
                endmodule
