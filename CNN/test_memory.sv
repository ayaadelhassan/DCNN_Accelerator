module test_memory();
	reg signed [15:0] mem [0:65535];

	initial begin
		$readmemb("1.mem", mem);
	end


endmodule

