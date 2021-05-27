module biases_repeater_tb;
    	reg clk, reset, loadEnable, dmaEnable, rw, writeEnable, done, enable;
	reg [15:0] address;
	reg signed [15:0] inputData;
	reg signed [15:0] dmaOut [0:24];
	reg [15:0] biasAddress;
	reg [15:0] numberOfBiases;
	reg [15:0] outImgAddress;
	reg [15:0] outImgSize;
	reg [15:0] loadAddr;
	reg [15:0] writeBias;
	reg [15:0] writeAddr;

	
    	localparam period = 100;

	CNNmemory dma(.clk(clk), .write_enable(rw), .address(address), .data_in(writeBias), .data_out(dmaOut));
	
	biases_repeater br(.clk(clk), .enable(enable), .reset(reset), .biasAddress(biasAddress), .numberOfBiases(numberOfBiases), 
		.outImgAddress(outImgAddress), .outImgSize(outImgSize), 
		.loadAddr(loadAddr), .loadedBiases(dmaOut), .loadEnable(loadEnable), .writeBias(writeBias), .writeAddr(writeAddr), .writeEnable(writeEnable), 
		.done(done));
        
	always@(loadEnable, writeEnable, writeAddr, loadAddr)begin
		dmaEnable = loadEnable || writeEnable; 
		address = (writeEnable == 1) ? writeAddr : loadAddr;
		rw = loadEnable;
	end

	initial begin
		$display($time, "<< Starting the Simulation >>");
		clk = 0;
		dmaEnable = 1;
		rw = 1;
		reset = 1;
		enable = 1;
		biasAddress = 0;
		numberOfBiases = 50;
		outImgAddress = 150;
		outImgSize = 2;
		
		#period;
		reset = 0;

	end

	always #(period/2) clk=~clk;

endmodule