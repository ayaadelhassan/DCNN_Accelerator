module fixed_point_modification (result, modifiedOut);
	parameter n = 32, // 32 for multiplication, 17 for addition
		m = 10;   // '10' for multiplication, '6' for addition

	input signed [n-1:0] result;
	output modifiedOut;
	reg signed [m-1:0] integerPart;
	reg signed [15:0] modifiedOut;  // Always 16 bits
	
	always @ (*)
	begin
		integerPart = result[n-1:n-m];   // [31:22] for multiplication, [16:11] for addition 
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
			modifiedOut[10:0] = result[n-m-1:n-m-11]; //[21:11] for multiplication, [10:0] for addition
		end
	end
	
endmodule
