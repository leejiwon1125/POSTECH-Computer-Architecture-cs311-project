module MUX3(
    input [3:0] A,
    input [3:0] B,
    input [3:0] C,
    input [3:0] D,
    input [3:0] E,
    input [3:0] F,
    input [2:0] select,
    output reg [3:0] OUT
    );
       
    always @(*) begin
        if (select == 3'd0 )
            OUT = A;
        else if(select == 3'd1)
            OUT = B;
        else if(select == 3'd2)
            OUT = C;
        else if(select == 3'd3)
            OUT = D;
        else if(select == 3'd4)
            OUT = E;
        else if(select == 3'd5)
            OUT = F;
        else 
           OUT = 4'bXXXX;
    end
endmodule