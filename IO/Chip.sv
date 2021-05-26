module Chip(load,clk);
input  load;
input  clk;
////////////////LOAD IO DATA////////////////
wire [15:0] CNNData [50703:0];
wire [15:0] FCData  [11217:0];
wire [0:16383] IMGDAat;
reg loadCNN, loadFC, loadImg;
wire finishCNN,finishFC,finishImg,done;
//////////////CNN RAM DATA////////////////////
wire [399:0] data_out; //25 * 16  bit 
reg[15:0] address = 0;
reg [15:0] data_in; 
reg write_enable;
reg currentStateCnn = 1;
reg [15:0] cnnIndex =0;
//////////////FC RAM DATA////////////////////
wire [1919:0] datafc_out; //120 * 16  bit 
reg [13:0] addressfc;
reg [15:0] datafc_in; 
reg writefc_enable;
reg read_enable = 0;
reg currentStateFC = 1;
reg [13:0] fcIndex =0;
//////////////////////////////////////////////
reg doneLoadingCNN=0;
reg currentStateIMG = 1;
reg [9:0] imgIndex =0;
//////////////////////////////////////////////
io ioChip(loadCNN, loadFC, loadImg,finishCNN,finishFC,finishImg,CNNData,FCData,IMGDAat,clk,done);
CNNmemory cnnmemory(data_out,address,data_in,write_enable,clk);
FCmemory fcmemory(datafc_out,addressfc,datafc_in,writefc_enable,read_enable,clk);
///////////////////////////////////////////////
always @(load)  begin
    loadCNN=1;
    loadFC=1;
    loadImg=1;
end
always @(done , posedge clk , currentStateCnn)  begin
if(currentStateCnn && done  )begin
        write_enable=1;
        address= cnnIndex;
        data_in = CNNData[cnnIndex];
        cnnIndex=cnnIndex+1;
        end
end 
    always @(done , posedge clk,cnnIndex) begin
        if(cnnIndex<50704) 
        currentStateCnn = 1'b1;
        
        else begin
        currentStateCnn = 1'b0;
        doneLoadingCNN=1;
        write_enable=0;
        end
    end


always @(done , posedge clk , currentStateFC)  begin
if(currentStateFC && done  )begin
        writefc_enable=1;
        addressfc= fcIndex;
        data_in = FCData[fcIndex];
        fcIndex=fcIndex+1;
        end
end 
    always @(done , posedge clk,fcIndex) begin
        if(fcIndex<11218)
        currentStateFC = 1'b1;
        else
        currentStateFC = 1'b0;
    end



always @(doneLoadingCNN , posedge clk , currentStateIMG)  begin
if(currentStateIMG && doneLoadingCNN)begin
        write_enable=1;
        address= cnnIndex;
        data_in = IMGDAat[imgIndex*16 +:15];
        cnnIndex=cnnIndex+1;
        imgIndex=imgIndex+1;
        end
end 
    always @(doneLoadingCNN , posedge clk,imgIndex) begin
        if(imgIndex<1024)
        currentStateIMG = 1'b1;
        else
        currentStateIMG = 1'b0;
    end
endmodule



