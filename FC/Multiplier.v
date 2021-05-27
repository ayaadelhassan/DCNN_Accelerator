module Multiplier #(parameter N = 16) (M,R,mulResult,clk,finish,enable,reset);
    input clk;
    input enable;
    input [N-1:0] M,R;
    input reset;
    reg [17:0] i;
    output reg finish;
    reg [(2*N):0] A;
    reg [(2*N):0] S;
    reg [(2*N):0] P;
    output reg [(2*N)-1:0] mulResult;
    reg signed [15:0] fixedMulResult;
    reg fixedEnable;
    fixed_point_modification #(.n(32),.m(10)) fp(.enable(fixedEnable),.result(mulResult),.modifiedOut(fixedMulResult));
always @(posedge clk) begin
    if(enable) begin
        if (reset) begin
            A={M,{N+1{1'b0}}};
            S={-M,{N+1{1'b0}}};
            P={{N{1'b0}},R,1'b0};
            i=0;
            finish=0;
            fixedEnable=0;
        end
        else if (i<N) begin
            case (P[1:0])
                2'b01: P= P+A;
                2'b10: P=P+S;
                2'b00: P=P;
                2'b11: P=P;
            endcase
            P= {P[2*N],P[2*N:1]};
            i=i+1;
            mulResult = 0;
        end
        else if(i>=N) begin
           mulResult = P[2*N:1];
           fixedEnable=1;
           finish = 1;
        end
    end
end
   
endmodule