`include "opcodes.v"

module ControlUnit (
    input [31:0] part_of_inst,  // input
    output reg mem_read,      // output
    output reg mem_to_reg,    // output
    output reg mem_write,     // output
    output reg [1:0] alu_src,       // output
    output reg reg_write,     // output
    output reg is_ecall       // output (ecall inst)
  );
  
  always @(*) begin

    if(part_of_inst[6:0]==`ARITHMETIC) begin
        mem_read=1'b0;
        mem_to_reg=1'b0;
        mem_write=1'b0;
        alu_src=2'b00;
        reg_write=1'b1;
        is_ecall=1'b0;
    end

    else if(part_of_inst[6:0]==`ARITHMETIC_IMM) begin
        mem_read=1'b0;
        mem_to_reg=1'b0;
        mem_write=1'b0;
        alu_src=2'b01;
        reg_write=1'b1;
        is_ecall=1'b0;
    end

    else if(part_of_inst[6:0]==`LOAD) begin
        mem_read=1'b1;
        mem_to_reg=1'b1;
        mem_write=1'b0;
        alu_src=2'b01;
        reg_write=1'b1;
        is_ecall=1'b0;
    end

    else if(part_of_inst[6:0]==`STORE) begin
        mem_read=1'b0;
        mem_to_reg=1'b0;
        mem_write=1'b1;
        alu_src=2'b01;
        reg_write=1'b0;
        is_ecall=1'b0;
    end

    else if(part_of_inst[6:0]==`ECALL) begin
        mem_read=1'b0;
        mem_to_reg=1'b0;
        mem_write=1'b0;
        alu_src=2'b00;
        reg_write=1'b0;
        is_ecall=1'b1;
    end

  end
  
endmodule