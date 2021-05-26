module pool_layer_tb;
    reg clk, enable, reset, imagesCount, done, loadImageEnable, opDone, RW, loadDone, dmaEnable, poolEnable;

    reg [15:0] imagesCount;
    reg [15:0] imageSize;
    reg [15:0] address;
    reg [15:0] loadImgAddrr;
    reg [15:0] image;
    reg [15:0] imagesCOunt;
    reg [15:0] inputData;
    reg [15:0] initAddr;
    reg [15:0] loadOut;
    
    
    PoolLayer pl(.clk(clk), .enable(poolEnable), .reset(reset), .imagesCount(imagesCount), .imgSize(imgSize), .address(address), .done(done) ,
     .loadImgEnable(loadImageEnable), .loadImgAddrr(loadImgAddrr), .image(image) ,.opDone(opDone), .RW(RW));
     
    load_block loadB (.clk(clk), .enable(loadImageEnable), .size(imgSize), .address(initAddr), .dmaAddr(loadImgAddrr), .dmaOut(dmaOut), .out(loadOut) ,.done(loadDone));

    DMA dma(.clk(clk), .enable(dmaEnable), .RW(RW), .address(loadImgAddrr), .inputDATA(inputData), .outputData(image)); 

    assign opDone = loadDone;
    initial begin
		$display($time, " << Starting the Simulation >>");
		clk = 0;
		dmaEnable = 1;
		inputData = 0;
		reset = 1;

		poolEnable = 0;
		imgsNumber = 3;
		imgSize = 14;
		imgsAddress = 0;
		#period;
        
		reset = 0;
		poolEnable = 1;

	end

	always #(period/2) clk=~clk;

endmodule