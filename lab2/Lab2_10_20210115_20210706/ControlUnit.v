`include "opcodes.v"

module ControlUnit (
    input [6:0] part_of_inst,  // input
    output reg is_jal,        // output
    output reg is_jalr,       // output
    output reg branch,        // output
    output reg mem_read,      // output
    output reg mem_to_reg,    // output
    output reg mem_write,     // output
    output reg alu_src,       // output
    output reg reg_write,     // output
    output reg pc_to_reg,     // output
    output reg is_ecall       // output (ecall inst)
  );
  
  always @(*) begin
      case (part_of_inst) 
          //R type  
          `ARITHMETIC: {is_jal, is_jalr, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, pc_to_reg, is_ecall} = {1'b0,1'b0,1'b0,1'b0,1'b0, 1'b0,1'b0,1'b1,1'b0,1'b0};
          //I type (imm)
          `ARITHMETIC_IMM: {is_jal, is_jalr, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, pc_to_reg, is_ecall} = {1'b0,1'b0,1'b0,1'b0,1'b0, 1'b0,1'b1,1'b1,1'b0,1'b0};
          //SB type
          `BRANCH: {is_jal, is_jalr, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, pc_to_reg, is_ecall} = {1'b0,1'b0,1'b1,1'b0,1'b0, 1'b0,1'b0,1'b0,1'b0,1'b0};
          //L type (Load)
          `LOAD: {is_jal, is_jalr, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, pc_to_reg, is_ecall} = {1'b0,1'b0,1'b0,1'b1,1'b1, 1'b0,1'b1,1'b1,1'b0,1'b0};
          //S type
          `STORE: {is_jal, is_jalr, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, pc_to_reg, is_ecall} = {1'b0,1'b0,1'b0,1'b0,1'b0, 1'b1,1'b1,1'b0,1'b0,1'b0};
          //UJ type
          `JAL: {is_jal, is_jalr, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, pc_to_reg, is_ecall} = {1'b1,1'b0,1'b0,1'b0,1'b0, 1'b0,1'b0,1'b1,1'b1,1'b0};
          //JALR
          `JALR: {is_jal, is_jalr, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, pc_to_reg, is_ecall} = {1'b0,1'b1,1'b0,1'b0,1'b0, 1'b0,1'b1,1'b1,1'b1,1'b0};
          //ECALL
          `ECALL: {is_jal, is_jalr, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, pc_to_reg, is_ecall} = {1'b0,1'b0,1'b0,1'b0,1'b0, 1'b0,1'b0,1'b0,1'b0,1'b1};
          
          default : {is_jal, is_jalr, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, pc_to_reg, is_ecall} = {1'bX,1'bX,1'bX,1'bX,1'bX,1'bX,1'bX,1'bX,1'bX,1'bX};
      endcase
  end
  
endmodule
