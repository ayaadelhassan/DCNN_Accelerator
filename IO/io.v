module io(loadCNN, loadFC, loadImg, finishCNN, finishFC, done, CNNData);
input  loadCNN, loadFC, loadImg;
output reg finishCNN,finishFC,done;
output reg [50707:0] CNNData;
integer data_file;
integer scan_file;
integer i=0;
integer j=0;
reg [15:0] data [1:0][4:0];

`define NULL 0
always @(loadFC)  begin


finishFC = 1;
end

always @(loadCNN)  begin
CNNData[0] = 5;
//layer1
CNNData[1] = 0;
CNNData[2] = 5;
CNNData[3] = 6;
data_file=$fopen("fixed_point_biases1.txt","r");
if(data_file==`NULL) begin
$display("DATA FILE WAS NULL");
$finish;
end
while(!$feof(data_file)) begin
i = 4;
scan_file=$fscanf(data_file,"%b ",CNNData[i]);
i=i+1;
end

finishCNN = 1;
end

always @(loadImg)  begin
done = 1;
end

endmodule
