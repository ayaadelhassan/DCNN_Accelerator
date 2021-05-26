module io(loadCNN, loadFC, loadImg, finishCNN, finishFC, done, CNNData,FCData,IMGDAat,clk);
input  loadCNN, loadFC, loadImg,clk;
output reg finishCNN,finishFC,done;
output reg [15:0] CNNData [50703:0];
output reg [15:0] FCData  [11217:0];
output reg [0:16383] IMGDAat;
integer data_file;
integer weights_file;
integer bias_file;
integer scan_file;
integer i=0;
integer j=0;
integer k=0;
integer m;
reg [15:0] layer1weights [119:0][83:0];
reg [15:0] layer1biases [83:0];
reg [15:0] layer2weights [83:0][9:0];
reg [15:0] layer2biases [9:0];
//////////////////////////
reg decompress;
wire [0:16383] imagebuffer;
decompression de (decompress,imagebuffer);
`define NULL 0
always @(loadFC)  begin
//---------------------------layer 1-----------------------
weights_file=$fopen("fixed_point_weightsFC1","r");
bias_file=$fopen("fixed_point_biasesFC1.txt","r");
i=0;
j=0;
if(weights_file==`NULL) begin
$display("DATA FILE WAS NULL");
$finish;
end
while(!$feof(weights_file)) begin
if(j==84) begin
j=0;
i=i+1;
end
scan_file=$fscanf(weights_file,"%b",layer1weights[i][j]);
j=j+1;
end
//--------------------------------------------
if(bias_file==`NULL) begin
$display("DATA FILE WAS NULL");
$finish;
end
i = 0;
while(!$feof(bias_file)) begin 
scan_file=$fscanf(bias_file,"%b ",layer1biases[i]);
i=i+1;
end
//----------------------------layer 2-----------------------------
weights_file=$fopen("fixed_point_weightsFC2","r");
bias_file=$fopen("fixed_point_biasesFC2.txt","r");
i=0;
j=0;
if(weights_file==`NULL) begin
$display("DATA FILE WAS NULL");
$finish;
end
while(!$feof(weights_file)) begin
if(j==10) begin
j=0;
i=i+1;
end
scan_file=$fscanf(weights_file,"%b",layer2weights[i][j]);
j=j+1;
end
//--------------------------------------------
if(bias_file==`NULL) begin
$display("DATA FILE WAS NULL");
$finish;
end
i = 0;
while(!$feof(bias_file)) begin 
scan_file=$fscanf(bias_file,"%b ",layer2biases[i]);
i=i+1;
end
//-----------------------------------------------
///////////// start filling the output ------------------------
k=120;
i=0;
j=0;
while(i<84)begin
if(j==120) begin
FCData[k]=layer1biases[i];
j=0;
i=i+1;
k=k+1;
end
FCData[k]=layer1weights[j][i];
j=j+1;
k=k+1;
end
//-------------------------------------
k=10368;
i=0;
j=0;
while(i<10)begin
if(j==84) begin
FCData[k]=layer2biases[i];
j=0;
i=i+1;
k=k+1;
end
FCData[k]=layer2weights[j][i];
j=j+1;
k=k+1;
end


finishFC = 1;
end

always @(loadCNN)  begin
CNNData[0] = 5;
//-----------------------layer1------------------------
CNNData[1] = 0;
CNNData[2] = 5;
CNNData[3] = 6;
data_file=$fopen("fixed_point_biases1.txt","r");
if(data_file==`NULL) begin
$display("DATA FILE WAS NULL");
$finish;
end
i = 4;
while(!$feof(data_file)) begin 
scan_file=$fscanf(data_file,"%b ",CNNData[i]);
i=i+1;
end
//---------------------filter 1-----------------
data_file=$fopen("fixed_point_filter1.txt","r");
if(data_file==`NULL) begin
$display("DATA FILE WAS NULL");
$finish;
end
i = 10;
while(!$feof(data_file)) begin 
scan_file=$fscanf(data_file,"%b ",CNNData[i]);
i=i+1;
end
//-------------------layer 2-------------------------
CNNData[160]=1;
//-------------------layer 3-------------------------
CNNData[161] = 0;
CNNData[162] = 5;
CNNData[163] = 96;
data_file=$fopen("fixed_point_biases2.txt","r");
if(data_file==`NULL) begin
$display("DATA FILE WAS NULL");
$finish;
end
i = 164;
while(!$feof(data_file)) begin 
scan_file=$fscanf(data_file,"%b ",CNNData[i]);
i=i+1;
end
//---------------------filter 2-----------------
data_file=$fopen("fixed_point_filter2.txt","r");
if(data_file==`NULL) begin
$display("DATA FILE WAS NULL");
$finish;
end
i = 180 ;
while(!$feof(data_file)) begin 
scan_file=$fscanf(data_file,"%b ",CNNData[i]);
i=i+1;
end
//---------------------layer 4-------------------
CNNData[2580]=1;
//---------------------layer 5-------------------
CNNData[2581] = 0;
CNNData[2582] = 5;
CNNData[2583] = 1920;
data_file=$fopen("fixed_point_biases3.txt","r");
if(data_file==`NULL) begin
$display("DATA FILE WAS NULL");
$finish;
end
i = 2584;
while(!$feof(data_file)) begin 
scan_file=$fscanf(data_file,"%b ",CNNData[i]);
i=i+1;
end
//---------------------filter 3-----------------
data_file=$fopen("fixed_point_filter3.txt","r");
if(data_file==`NULL) begin
$display("DATA FILE WAS NULL");
$finish;
end
i = 2704 ;
while(!$feof(data_file)) begin 
scan_file=$fscanf(data_file,"%b ",CNNData[i]);
i=i+1;
end



finishCNN = 1;
end

always @(posedge clk && loadImg )  //need two clocks clk =50 falling
begin
decompress=1;
end

always @(negedge clk && loadImg)
begin
   for(m=0;m<16384;m=m+1)
    begin
    IMGDAat[m] = imagebuffer[m];
    end
   done = 1;
end

endmodule
