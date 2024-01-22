module is_Ecall_and_ten (
    input [31:0] A,  // input
    input Is_Ecall,
    output reg is_halted
  );
  always @(*) begin
      if((Is_Ecall==1)&&(A==32'd10)) begin
          is_halted<=1;
      end
      else begin
          is_halted<=0;
      end
  end
  
endmodule