module convolve_image_clked(image, filter, convolved_image, clk, reset ,enable, done);
	
	parameter n = 32;

	input signed [15:0] image [0:n*n-1];
	input signed [15:0] filter [0:24];
    input clk , reset, enable; 
	output signed [15:0] convolved_image;
    output done; 
    reg done; 
	reg signed [15:0] window [0:24];

    convolve_window cw(window, filter, convolved_image);
    
	integer i = 0,j = 0;
    always @(posedge clk, reset) begin
        if (reset == 1)begin
            i  = 0; 
            j = 0 ; 
            window = {25{16'b0}}; 
        end
        if(enable == 1)
        begin
            if (i == and j == )begin
                done = 1; 
            end
            window[0:4] = image[j+(n*i):j+(n*i)+4];
            window[5:9] = image[j+(n*(i+1)):j+(n*(i+1))+4];
            window[10:14] = image[j+(n*(i+2)):j+(n*(i+2))+4];
            window[15:19] = image[j+(n*(i+3)):j+(n*(i+3))+4];
            window[20:24] = image[j+(n*(i+4)):j+(n*(i+4))+4];
            j = j + 1; 
            i = i + 1; 
    end
	

endmodule
