module is_Ecall_and_ten (
    input clk,
    input reset,
    input [31:0] A,  // input
    input IsEcall,
    output reg is_halted
  );
  reg [31:0] tempA;
  always @(*) begin
      if((IsEcall==1)&&(tempA==32'd10)) begin
          is_halted<=1;
      end
      else begin
          is_halted<=0;
      end
  end
  always @(posedge clk) begin
      tempA<=A;
  end
  
endmodule