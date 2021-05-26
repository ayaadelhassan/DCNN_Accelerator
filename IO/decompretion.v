module decompression(decompress,imagebuffer);
reg [15:0] inputtext[1630:0];
integer count,bit,j,p,k;
input decompress;
output reg [0:16383] imagebuffer ;
always @(decompress) begin
$readmemb("commdata.txt",inputtext);
k=0;
for(j=0;j<1631;j=j+1)
   begin
     count=inputtext[j][14:0];
     bit=inputtext[j][15];
    ///put bit*count
   for(p=0;p<count;p=p+1)
     begin
      imagebuffer[k]=bit;
      k=k+1;
      end
   end
end
      
endmodule
