module fc_main(enable,
               clk,
               finished);
    
    input enable;
    input clk;
    output finished;
    
    reg enable1, enable2, finished1, finished2;
    
    reg [1919:0] data_out; //120 * 16  bit
    reg [13:0] address;
    reg [15:0] data_in;
    reg write_enable;
    reg read_enable;
    
    FCmemory mem(
    .data_out(data_out),
    .address(address),
    .data_in(data_in),
    .write_enable(write_enable),
    .read_enable(read_enable),
    .clk(clk));
    
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
    
    fc_layer#(.numNodesIn(120),.numNodesOut(84))
    fc1(.enable(enable1),
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

    integer i, j, it;
    always @(posedge clk) begin
        if (enable) begin
            
            enable1      = 0;
            //finished1    = 0;
            //finished2    = 0;
            write_enable = 0;
            read_enable = 1;
            address     = 0;
            for(j=0;j<120;j++) begin
            inputNodes1R[j] = data_out[(j*16)+:16];
            end
            
            for(i = 0; i < 84; i = i + 1) begin
                address          = i * 120 + 120;
                for (it = 0; it < 120; it = it + 1) begin
                    weights1R[(i*120)+it] = data_out[(it*16)+:16];
                end
            end
            address = 120 + 84 * 120;

            for(j=0;j<84;j++) begin
             biases1R[j] = data_out[(j*16)+:16];
            end
           
            read_enable=0;
            enable1 = 1;
            write_enable=1;
            
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