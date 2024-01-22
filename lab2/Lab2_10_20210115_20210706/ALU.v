`include "ALUop.v"

module ALU(
    input [3:0] ALUop,  
    input [31:0] A,
    input [31:0] B, 
    output reg bcond,        
    output reg [31:0] ALUresult
);

always @(*) begin
    ALUresult =0;
    bcond =0;
    if     (ALUop == `BEQ)
        begin
        //$display("BEQ\n");
            if(A==B)   begin bcond = 1'b1; ALUresult = 32'b00000000000000000000000000000000; end
            else       begin bcond = 1'b0; ALUresult = 32'b00000000000000000000000000000000; end
        end
    else if(ALUop == `BNE)
        begin
        //$display("BNE\n");
            if(A!=B)   begin bcond = 1'b1; ALUresult = 32'b00000000000000000000000000000000; end
            else       begin bcond = 1'b0; ALUresult = 32'b00000000000000000000000000000000; end
        end
    else if(ALUop == `BLT)
        begin
        //$display("BLT\n");
            if(A<B)    begin bcond = 1'b1; ALUresult = 32'b00000000000000000000000000000000; end
            else       begin bcond = 1'b0; ALUresult = 32'b00000000000000000000000000000000; end
        end
    else if(ALUop == `BGE)
        begin
        //$display("BGE\n");
            if(A>=B)   begin bcond = 1'b1; ALUresult = 32'b00000000000000000000000000000000; end
            else       begin bcond = 1'b0; ALUresult = 32'b00000000000000000000000000000000; end
        end
        
        
    else if(ALUop == `ADD)
        begin
        //$display("ADD\n");
            ALUresult = A+B;
            bcond     = 1'b0;
        end
    else if(ALUop == `SUB)
        begin
        //$display("SUB\n");
            ALUresult = A-B;
            bcond     = 1'b0;
        end
    else if(ALUop == `SLL)
        begin
        //$display("SLL\n");
            ALUresult = A<<B;
            bcond     = 1'b0;
        end
    else if(ALUop == `XOR)
        begin
        //$display("XOR\n");
            ALUresult = A^B;
            bcond     = 1'b0;    
        end
    else if(ALUop == `SRL)
        begin
        //$display("SRL\n");
            ALUresult = A>>>B;
            bcond     = 1'b0;
        end
    else if(ALUop == `OR)
        begin
        //$display("OR\n");
            ALUresult = A|B;
            bcond     = 1'b0;
        end
    else if(ALUop == `AND)
        begin
        //$display("AND\n");
            ALUresult = A&B;
            bcond     = 1'b0;
        end
    else if(ALUop == `ALUNULL)
        begin
        //$display("ALUNULL\n");
            ALUresult = 32'b00000000000000000000000000000000;
            bcond     = 1'b0;
        end
    else
        begin
        //$display("default\n");
            ALUresult = 32'bXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
            bcond     = 1'bX;
        end
      
  end


endmodule