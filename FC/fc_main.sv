module fc_main(enable,
               clk,
               finished,
               reset);
    
    input enable;
    input clk;
    output finished;
    input reset;
    reg enable1, enable2, finished1, finished2;
    
    reg [1919:0] data_out; //120 * 16  bit
    reg [13:0] address;
    reg [15:0] data_in;
    reg write_enable;
    reg read_enable;
    reg finishedMem;
    FCmemory mem(
    .data_out(data_out),
    .address(address),
    .data_in(data_in),
    .write_enable(write_enable),
    .read_enable(read_enable),
    .clk(clk),
    .finished(finishedMem)
    );
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
    reg reset1;
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
    
    // fc_layer#(.numNodesIn(84),.numNodesOut(10))
    // fc2(.enable(enable2),
    // .inputNodes(outputNodes1R),
    // .outputNodes(outputNodes2R),
    // .weights(weights2R),
    // .biases(biases2R),
    // .finished(finished2),
    // .clk(clk)
    // );
    
    // assign inputNodes1 = inputNodes1R;
    // assign outputNodes1 = outputNodes1R;
    // assign weights1 = weights1R;
    // assign biases1 = biases1R;

    // assign outputNodes2 = outputNodes2R;
    // assign weights2 = weights2R;
    // assign biases2 = biases2R;
    reg [15:0] i, j, it , k;
    always @(posedge clk) begin
        if (reset==1)begin
            i<=0;
            j<=0;
            it<=0;
            k<=0;
            layer <= 0;
            reset1 <= 1;
        end
        else if (enable) begin
            if (layer == 0)begin
            reset1 <=0;
            enable1      <= 1;
            write_enable <= 0;
            read_enable <= 1;
            address     <= 0;
            if(finishedMem==1)begin
            if(j<120) begin
            inputNodes1R[j] <= data_out[(j*16)+:16];
            j<=j+1;    
            end
            else begin
            address<= i * 120 + 120;
            finishedMem=0;
            end               
            end

            if(i<84)begin
            
            if(finishedMem==1)begin
            if(it<120)begin
                weights1R[(i*120)+it] <= data_out[(it*16)+:16];
                it<=it+1;
            end
            else begin
                it <=0;
                i<=i+1;
                finishedMem<=0;
            end
            end
            end
            else begin
            address <= 120 + 84 * 120;  
            end
            if(finishedMem==1)begin
             if (k<84)begin
             biases1R[k] <= data_out[(k*16)+:16]; 
             k<=k+1;
            end
            else begin
                finishedMem=0;
                end
            end

            if(finished1==1)begin
            enable1 <=0;
            read_enable <=0;
            enable2 <= 1;
            write_enable <=1;
            layer <=1;                
            end
            end
        else if (layer == 1)begin
            
        end 
            // for(i = 0; i < 10; i = i + 1) begin
                                
            //                     // old address: 120(input nodes) + 84 * 120 (weights);
            //                     // beginning of new weights: old Address + 84(biases) + 84(o/p nodes)
            //     address          = i * 84 + 84      +    120 + 84 * 120 + 84 * 2;
            //     weights2[i] = data_out;
            // end

            // address = 120 + 84 * 120 + 84 * 2 + 10 * 84 + 84;
            // biases2 = data_out[0: 9];

            // enable2 = finished1? 1: 0;
            
            
            // finished <= finished2;
        end
    end
endmodule
