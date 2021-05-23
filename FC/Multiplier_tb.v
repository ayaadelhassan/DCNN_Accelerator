module Multiplier_tb;
localparam period = 100;
reg signed [4:0] input1_tb,input2_tb; 
wire signed [9:0] result_tb; 
integer i;
integer j;
Multiplier #(.N(5)) MUT (.M(input1_tb),.R(input2_tb),.mulResult(result_tb));
initial
begin
for (i=0;i<16;i=i+1)begin
input1_tb=i;
	for(j=0;j<16;j=j+1)begin
 	 	  input2_tb=j;
		  #period
 		  if (result_tb!=input1_tb*input2_tb) begin
			$error ("ERROR: multiplication result doesn't mtach expected value");
			$display(input1_tb, input2_tb, result_tb);
		  end

#period;
end
end
end 
endmodule
