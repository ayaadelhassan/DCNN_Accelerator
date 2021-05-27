`timescale 1ns / 1ps

module testbench;
wire doneLoadingCNN,doneLoadingFC,doneLoadingIMG;
reg load =1;
bit clk = 0;
integer i;
Chip IOChip (load,clk, doneLoadingCNN,doneLoadingFC,doneLoadingIMG );
initial begin
   for(i=0;i<599000;i=i+1)
      #0.05 clk = ~clk;
end
      
endmodule
//////////Notes
//Done signals indicate that the data has been stored in memory 
//Check the memory list for CNNRam and FCRam details