module Multiplier #(parameter N = 5) (M,R,mulResult,clk,finish,enable);
    input clk;
    input enable;
    input [N-1:0] M,R;
    reg [17:0] i;
    reg continue;
    output reg finish;
    reg [(2*N):0] A;
    reg [(2*N):0] S;
    reg [(2*N):0] P;
    
    output reg [(2*N)-1:0] mulResult;
    initial begin
	i=0;
    P={{N{1'b0}},R,1'b0};

    end
always @(posedge clk,continue) begin
    if(enable) begin
        if(continue) begin
        A={M,{N+1{1'b0}}};
        S={-M,{N+1{1'b0}}};
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
        else begin
	
        mulResult = P[2*N:1];
 	    P={{N{1'b0}},R,1'b0};
        end
    end
    end
         

    always @(posedge clk,continue,i) begin
        if(i<N) begin
        continue=1'b1;
	    finish = 0;
        end
        else begin
	    
i=0;
	  finish = 1;
        continue=1'b0; 
        end        
    end
endmodule