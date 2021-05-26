
module PoolLayer (clk,enable, reset, imagesCount, imgSize, address, done , loadImgEnable, loadImgAddrr, image ,opDone,RW);
    localparam DATA_SIZE = 16;
    localparam ADDR_WIDTH = 20;
    localparam  n = 32;
    input clk, enable, reset, opDone; 
    input imagesCount,  address; // address of first image in intermidiat layer
    input image; 
    input imgSize; 
    output done, loadImgEnable,loadImgAddrr,RW;  
    reg RW; 
    reg signed [DATA_SIZE-1:0] image [n*n-1:0];
    reg [DATA_SIZE-1:0]imagesCount, imgSize, address, loadImgAddrr; 
    reg signed [DATA_SIZE-1:0] pooledOut;
    reg [DATA_SIZE-1:0] saveImgAddr; 
    reg poolDone ,opDone,donePooling,poolEnable,done, loadImgEnable; 
    reg doneReadImage,loadImageEnable,readImageSignal;
    
    pool_image_clked poolImg (.clk(clk), .reset(reset), .enable(poolEnable), .imgSize(imgSize), .image(image), .windowSize(16'd2), .pooledOut(pooledOut), .done(poolDone));
    integer counter; 
    always @(posedge clk) begin
        if(reset)begin
             poolEnable = 0; 
	     counter = 0;
            //  SSSSpoolDone = 1; 
             done = 0 ;  
        end
        if(enable)begin
            if(opDone || poolDone)begin 
                opDone = 0; 
                poolDone = 0;
                if(readImageSignal == 1) begin
                    doneReadImage = 1; 
                    loadImageEnable = 0; 
                end
              
                if(poolDone)begin 
                    donePooling = 1; // signal indeicates that operation done before; 
                end
                if(counter < imagesCount)begin
                    if(counter == 0)begin
                        saveImgAddr = address + imagesCount * imgSize * imgSize;  //initial save address; 
                    end
                    if(doneReadImage == 0) begin
                        loadImageEnable = 1; 
                        RW = 1; //read
                        loadImgAddrr = address;
                        readImageSignal = 1;
                    end else if(donePooling  == 0)begin
                        poolEnable = 1; 
                    end else  if(poolEnable)begin // pool done  
                        loadImgAddrr = loadImgAddrr + imgSize * imgSize; 
                        doneReadImage =0; 
                        counter = counter + 1; 
                        saveImgAddr = saveImgAddr + imgSize * imgSize / 2; 
                        poolEnable = 0;  
                    end
                end else begin
                    done =1; 
		    counter = 0;
                end
            end
            
        end
    end
endmodule