module ALU #(parameter data_width = 16) (
	input [data_width - 1 : 0] A, 
	input [data_width - 1 : 0] B, 
	input [3 : 0] FuncCode,
       	output reg [data_width - 1: 0] C,
       	output reg OverflowFlag);
// Do not use delay in your implementation.

// You can declare any variables as needed.
/*
	YOUR VARIABLE DECLARATION...
*/
//와이어를 사용하는 모듈 만들고, 그거 뒤에서always begin으로 reg에 넣어주면 되는 듯.
wire [15:0] wire_c;
wire over;

initial begin
	C = 0;
	OverflowFlag = 0;
end   	



alu alu(
    .A(A),
    .B(B),
    .FuncCode(FuncCode),
    .C(wire_c),
    .OverflowFlag(over)
    );

// TODO: You should implement the functionality of ALU!
// (HINT: Use 'always @(...) begin ... end')
/*
	YOUR ALU FUNCTIONALITY IMPLEMENTATION...
*/

always begin @(wire_c, over)

 C = wire_c;
 OverflowFlag = over;


end


endmodule

