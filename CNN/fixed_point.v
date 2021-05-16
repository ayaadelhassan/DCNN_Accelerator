module fixed_point_modification(multOut, modifiedOut);
	input signed [31:0] multOut;
	output modifiedOut;
	reg signed [9:0] integerPart;
	reg signed [15:0] modifiedOut; 
	
	always @ (*)
	begin
		integerPart = multOut[31:22];
		if (integerPart > 15) begin
			modifiedOut[15:11] = 15;
			modifiedOut[10:0] = {11{1'b1}};
		end else if(integerPart < -16) begin
			modifiedOut[15:11] = -16;
			modifiedOut[10:0] = {11{1'b0}};
		end else begin
			modifiedOut[15:11] = integerPart[4:0];
			modifiedOut[10:0] = multOut[21:11];
		end
	end
	
endmodule
