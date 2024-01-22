`include "opcodes.v"
`include "ALUop.v"

module ALUControlUnit(input [31:0] part_of_inst, input [1:0] alu_op_signal, output reg [3:0] alu_op
    );
    always @(*) begin
    
    if(alu_op_signal == 2'b00)
    begin
        alu_op=`ADD;
    end
    else if (alu_op_signal == 2'b01)
    begin
        if(part_of_inst[14:12]==`FUNCT3_BEQ)
                    alu_op=`BEQ;
        else if(part_of_inst[14:12]==`FUNCT3_BNE)
                    alu_op=`BNE;
        else if(part_of_inst[14:12]==`FUNCT3_BLT)
                    alu_op=`BLT;
        else if(part_of_inst[14:12]==`FUNCT3_BGE)begin
                    alu_op=`BGE;
                    end
    end
    else if (alu_op_signal == 2'b10)
    begin
        case (part_of_inst[6:0])
            `JALR: begin//JALR
                alu_op=`ADD;
                end
            `LOAD: begin
                alu_op=`ADD;
                end
            `STORE: begin
                alu_op=`ADD;
                end
            `ARITHMETIC_IMM: begin
                if(part_of_inst[14:12]==`FUNCT3_ADD)
                    alu_op=`ADD;
                else if(part_of_inst[14:12]==`FUNCT3_XOR)
                    alu_op=`XOR;
                else if(part_of_inst[14:12]==`FUNCT3_OR)
                    alu_op=`OR;
                else if(part_of_inst[14:12]==`FUNCT3_AND)
                    alu_op=`AND;
                else if(part_of_inst[14:12]==`FUNCT3_SLL)
                    alu_op=`SLL;
                else if(part_of_inst[14:12]==`FUNCT3_SRL)
                    alu_op=`SRL;
                end
            `ARITHMETIC: begin
                if(part_of_inst[14:12]==`FUNCT3_ADD && part_of_inst[30]==0)
                    alu_op=`ADD;
                else if(part_of_inst[14:12]==`FUNCT3_SUB && part_of_inst[30]==1)
                    alu_op=`SUB;
                else if(part_of_inst[14:12]==`FUNCT3_XOR)
                    alu_op=`XOR;
                else if(part_of_inst[14:12]==`FUNCT3_XOR)
                    alu_op=`XOR;
                else if(part_of_inst[14:12]==`FUNCT3_OR)
                    alu_op=`OR;
                else if(part_of_inst[14:12]==`FUNCT3_AND)
                    alu_op=`AND;
                else if(part_of_inst[14:12]==`FUNCT3_SLL)
                    alu_op=`SLL;
                else if(part_of_inst[14:12]==`FUNCT3_SRL)
                    alu_op=`SRL;
                end
            default: begin
                alu_op = `ALUNULL;
            end
      endcase 
    
    end
    else if (alu_op_signal == 2'b11)
    begin 
         
        alu_op=`PREVADD;
    
        
    end
    
      
  end
endmodule
