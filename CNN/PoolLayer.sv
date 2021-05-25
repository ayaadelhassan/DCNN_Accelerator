
module PoolLayer (clk,enable, reset, imagesCount, imgSize, address, done , loadImgEnable, loadImgAddrr, image ,opDone);
    localparam DATA_SIZE = 16;
    localparam  n = 32;
    input clk, enable, reset, opDone; 
    input imagesCount, imgSize, address, loadImgAddrr;
    reg [DATA_SIZE-1:0]imagesCount, imgSize, address, loadImgAddrr; 
    input image; 
    reg [DATA_SIZE-1:0] image [n*n-1:0];
    output done, loadImgEnable; 

    reg [DATA_SIZE-1:0] pooledImg[n*n-1:0];
    reg [DATA_SIZE-1:0] saveImgAddr; 
    reg poolDone,saveImageEnable ,opDone,donePooling,poolEnable,done, loadImgEnable; 
    reg doneReadImage,loadImageEnable,readImageSignal;
    
    pool_image_clked poolImg (.clk(clk), .reset(reset), .enable(poolEnable), .imgSize(imgSize), .image(image), .windowSize(16'd2), .pooledOut(pooledImg), .done(poolDone));
    integer counter; 
    initial begin
         counter = 0; 
    end 
    
    always @(posedge clk) begin
        if(reset)begin
             poolEnable = 0; 
            //  poolDone = 1; 
             done = 0 ;  
        end
        if(enable)begin
            opDone = opDone || poolDone; 
            if(opDone)begin 
                opDone = 0; 
                poolDone = 0;
                if(readImageSignal == 1) begin
                    doneReadImage = 1; 
                    loadImageEnable = 0; 
                end
              
                if(saveImageEnable)begin
                    saveImageEnable = 0; 
                    loadImgAddrr = loadImgAddrr + imgSize * imgSize; 
                    doneReadImage =0; 
                    counter = counter + 1; 
                    saveImgAddr = saveImgAddr + imgSize * imgSize / 2; 
                     
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
                        loadImgAddrr = address;
                        readImageSignal = 1;
                    end else if(donePooling  == 0)begin
                        poolEnable = 1; 
                    end else  if(poolEnable)begin
                        saveImageEnable = 1;
                        // need save logic 
                        poolEnable = 0;  
                    end
                end else begin
                    done =1; 
                    opDone = 0; 

                end
            end
            
        end
    end
endmodule