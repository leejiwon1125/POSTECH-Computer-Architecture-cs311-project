module MUX2(
    input [31:0] A,
    input [31:0] B,
    input [31:0] C,
    input [31:0] D,
    input [1:0] select,
    output reg [31:0] OUT
    );
       
    always @(*) begin
        if (select == 2'd0 )
            OUT = A;
        else if(select == 2'd1)
            OUT = B;
        else if(select == 2'd2)
            OUT = C;
        else if(select == 2'd3)
            OUT = D;
    end
endmodule