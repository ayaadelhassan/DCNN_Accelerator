`timescale 1ns / 1ps

module tb;
integer j,i,k;
wire imagebuffer [0:16383];
reg  [0:15] word [0:1023];
decompression de (imagebuffer);
initial begin
   k=0;
   #10
  for(j=0;j<16384;j=j+16)
   begin
    for(i=0;i<16;i=i+1)
    begin
    word[k][i]=imagebuffer[j+i];
    end
     $display(word[k]);
     k=k+1;
   end
   #10
    $stop;
end
      
endmodule
