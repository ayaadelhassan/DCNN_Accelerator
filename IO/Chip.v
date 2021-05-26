module Chip(load,clk);
input  load;
input  clk;
////////////////LOAD IO DATA////////////////
wire [15:0] CNNData [50703:0];
wire [15:0] FCData  [11217:0];
wire [0:16383] IMGDAat;
reg loadCNN, loadFC, loadImg;
wire finishCNN,finishFC,done;
//////////////CNN RAM DATA////////////////////
wire [399:0] data_out; //25 * 16  bit 
reg[15:0] address;
reg [15:0] data_in; 
reg write_enable;
//////////////FC RAM DATA////////////////////
wire [1919:0] datafc_out; //120 * 16  bit 
reg [13:0] addressfc;
reg [15:0] datafc_in; 
reg writefc_enable;
//////////////////////////////////////////////
io ioChip(loadCNN, loadFC, loadImg,finishCNN,finishFC,done,CNNData,FCData,IMGDAat,clk);
CNNmemory cnnmemory(data_out,address,data_in,write_enable,clk);
FCmemory fcmemory(datafc_out,addressfc,datafc_in,writefc_enable,clk);
///////////////////////////////////////////////
always @(load)  begin
    loadCNN=1;
    loadFC=1;
    loadImg=1;
end


endmodule

