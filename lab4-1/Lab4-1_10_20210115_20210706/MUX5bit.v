module MUX5bit(
    input [4:0] A,
    input [4:0] B,
    input select,
    output reg [4:0] OUT
    );
       
    always @(*) begin
        if (select == 1'd0 )
            OUT = A;
        else
            OUT = B;
    end
endmodule