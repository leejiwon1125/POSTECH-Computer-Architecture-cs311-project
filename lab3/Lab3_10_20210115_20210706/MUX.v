module MUX(
    input [31:0] A,
    input [31:0] B,
    input select,
    output reg [31:0] OUT
    );
       
    always @(*) begin
        if (select == 0 )
            OUT = A;
        else
            OUT = B;
    end
endmodule
