module biases_repeater(clk, enable, reset, biasAddress, numberOfBiases, 
		outImgAddress, outImgSize, 
		loadAddr, loadedBiases, loadEnable, writeBias, writeAddr, writeEnable, 
		done);
	localparam DATA_SZ = 16;
	localparam ADDR_SZ = 16;

	input reg clk, enable, reset;
	output reg done, loadEnable, writeEnable;
	
	input reg [ADDR_SZ-1:0] biasAddress;
	input reg [ADDR_SZ-1:0] outImgAddress;
	input reg [DATA_SZ-1:0] numberOfBiases;
	input reg [DATA_SZ-1:0] outImgSize;

	output reg [ADDR_SZ-1:0] loadAddr;
	output reg [ADDR_SZ-1:0] writeAddr;
	output reg [DATA_SZ-1:0] writeBias;
	input reg signed [DATA_SZ-1:0] loadedBiases[0:24];

	integer biasCounter, currentBiasIndex, i;
	reg isBiasesLoaded;
	reg [ADDR_SZ-1:0] currentBiasesAddr;
	reg signed [DATA_SZ-1:0] biases[0:24];

	always @(posedge clk) begin
		if(reset || done) begin
			biasCounter = 0;
			currentBiasIndex = 0;
			isBiasesLoaded = 0;
			writeEnable = 0;
			i = 0;
			loadEnable = 0;
			done = 0;
		end else if(enable) begin
			if(biasCounter == 0 && writeEnable == 0) begin
				currentBiasesAddr = biasAddress;
				writeAddr = outImgAddress-1;
			end
			if(loadEnable) begin
				isBiasesLoaded = 1;
				loadEnable = 0;
				biases = loadedBiases;
			end
			if(writeEnable) begin
				i = i + 1;
			end

			if(isBiasesLoaded == 0) begin
				// Load set of biases
				loadEnable = 1;
				loadAddr = currentBiasesAddr;
			end
			else begin
				writeAddr = writeAddr + 1;
				writeEnable = 1;
				
				if(i==outImgSize*outImgSize) begin
					i = 0;
					biasCounter = biasCounter + 1;
					if(biasCounter >= numberOfBiases) begin
						done = 1;
						writeEnable = 0;	
					end
					currentBiasIndex = currentBiasIndex + 1;
					if(currentBiasIndex > 24 && done == 0) begin
						currentBiasIndex = 0;
						isBiasesLoaded = 0;
						writeEnable = 0;
						writeAddr = writeAddr - 1;
						currentBiasesAddr = currentBiasesAddr + 16'd25;
					end
				end
				writeBias = biases[currentBiasIndex];
			end
		end
	end
	
endmodule
