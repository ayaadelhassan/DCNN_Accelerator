module fixed_point_modification2 (result, modifiedOut);
	
	input signed [31:0] result;
	reg signed [9:0] integerPart;
	output reg signed [15:0] modifiedOut;  // Always 16 bits
	
	always @ (*)
	begin
		integerPart = result[31:22];   // [31:22] for multiplication, [16:11] for addition 
		if (integerPart > 15) begin
			$display("GREATER");
			modifiedOut[15:11] = 15;
			modifiedOut[10:0] = {11{1'b1}};
		end else if(integerPart < -16) begin
			$display("LESS");
			modifiedOut[15:11] = -16;
			modifiedOut[10:0] = {11{1'b0}};
		end else begin
			$display("INRANGE");
			modifiedOut[15:11] = integerPart[4:0];
			modifiedOut[10:0] = result[21:11]; //[21:11] for multiplication, [10:0] for addition
		end
	end
	
endmodule
