module ROM2 (
    input [6:0] part_of_inst,  // input
    output reg [3:0] state
  );
  
  always @(*) begin
      case (part_of_inst) 
          //R type  

          //I type (imm)

          //SB type

          //L type (Load)
          7'b0000011: state = 4'b0011;
          //S type
          7'b0100011: state = 4'b0101;
          //UJ type

          //JALR

          //ECALL
          
          default : state = 4'bXXXX;
      endcase
  end
  
endmodule