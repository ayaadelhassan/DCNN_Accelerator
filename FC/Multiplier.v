module Multiplier #(parameter N = 5) (M,R,mulResult);
    input [N-1:0] M,R;
    output [(2*N)-1:0] mulResult;
    reg [(2*N):0] A,S,P;
    integer i;
    always @(*) begin
        A = {M,{N+1{1'b0}}};
        S = {-M,{N+1{1'b0}}};
        P = {{N{1'b0}},R,1'b0};
        for (i=0;i<N;i=i+1)
            begin
            //$display(P[1:0]);
            case (P[1:0])
                2'b01: P= P+A;
                2'b10: P=P+S;
                2'b00: P=P;
                2'b11: P=P;
            endcase
            //$display(P);
            P= {P[2*N],P[2*N:1]};
            //$display(P);
            end     
    end
    assign mulResult = P[2*N:1];
endmodule