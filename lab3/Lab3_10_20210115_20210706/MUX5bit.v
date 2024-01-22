module MUX5bit(
    input [5:0] A,
    input [5:0] B,
    input select,
    output reg [31:0] OUT
    );
       
    always @(*) begin
        if (select == 1'd0 )
            OUT = A;
        else
            OUT = B;
    end
endmodule