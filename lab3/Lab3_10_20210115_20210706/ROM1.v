module ROM1 (
    input [6:0] part_of_inst,  // input
    output reg [3:0] state
  );
  
  always @(*) begin
      case (part_of_inst) 
          //R type  
          7'b0110011: state = 4'b0110;
          //I type (imm)
          7'b0010011: state = 4'b1001;
          //SB type
          7'b1100011: state = 4'b1000;
          //L type (Load)
          7'b0000011: state = 4'b0010;
          //S type
          7'b0100011: state = 4'b0010;
          //UJ type
          7'b1101111: state = 4'b1011;
          //JALR
          7'b1100111: state = 4'b1010;
          //ECALL
          7'b1110011: state = 4'b1101;
          default : state = 4'bXXXX;
          
      endcase
  end
  
endmodule