module filterbuffer ( clk,  enable, RW , inFilter, outFilter, empty);

parameter BUFF_SIZE = 150;
reg [15:0] filters [0:BUFF_SIZE-1];
reg [2:0] counter; 

//dummy data 
integer  k ;
initial begin
    counter = 5; 
    for (k =0 ; k < 150; k = k + 1 ) begin
        filter[k] = k; 
    end
end

always @(posedge clk) begin
    if (enable)begin
        if(RW == 1 and counter < 5) begin //read
            outFilter = filters[(counter * 25 ) +: (counter * 25 + 25)];
            counter = counter + 1; 
        end
        else begin
            filters = inFilter; 
            counter = 0; 
        end
        if(counter == 5)begin
            empty = 1; 
        end
    end
    
end
endmodule

