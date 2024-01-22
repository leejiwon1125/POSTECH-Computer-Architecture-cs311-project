module rs2_select_unit(
    input [1:0] A,
    input [1:0] B,
    output reg [1:0] OUT
    );
       
    always @(*) begin
        if (A == 2'd0 )
            OUT = B;
        else
            OUT = A;
    end
endmodule