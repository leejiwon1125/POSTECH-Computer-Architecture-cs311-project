module bit4adder( 
    input [3:0] A,
    input [3:0] B,   
    output reg [3:0] ALUresult
);

always @(*) begin
    ALUresult = A+B;
  end


endmodule