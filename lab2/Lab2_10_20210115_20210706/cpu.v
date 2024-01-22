// Submit this file with other files you created.
// Do not touch port declarations of the module 'CPU'.

// Guidelines
// 1. It is highly recommened to `define opcodes and something useful.
// 2. You can modify the module.
// (e.g., port declarations, remove modules, define new modules, ...)
// 3. You might need to describe combinational logics to drive them into the module (e.g., mux, and, or, ...)
// 4. `include files if required
`include "ALUop.v"

module CPU(input reset,       // positive reset signal
           input clk,         // clock signal
           output is_halted); // Whehther to finish simulation
  /***** Wire declarations *****/
  wire [31:0] current_pc, next_pc, pc4, instr, rs1, rs2, imm, aluresult, m1, m2, m3, m4, m5, a1;
  wire JALR, JAL, Branch, MemRead, MemtoReg,MemWrite, ALUSrc, RegWrite, PCtoReg, Ecall;
  wire bcond, trash1, trash2, b1,b2, is_ten;
  wire [3:0] aluop;
  /***** Register declarations *****/

  // ---------- Update program counter ----------
  // PC must be updated on the rising edge (positive edge) of the clock.
  PC pc(
    .reset(reset),       // input (Use reset to initialize PC. Initial value must be 0)
    .clk(clk),         // input
    .next_pc(next_pc),     // input
    .current_pc(current_pc)   // output
  );
  
  // ---------- Instruction Memory ----------
  InstMemory imem(
    .reset(reset),   // input
    .clk(clk),     // input
    .addr(current_pc),    // input
    .dout(instr)     // output
  );

  // ---------- Register File ----------
  RegisterFile reg_file (
    .reset (reset),        // input
    .clk (clk),          // input
    .rs1 (instr[19:15]),          // input
    .rs2 (instr[24:20]),          // input
    .rd (instr[11:7]),           // input
    .rd_din (m1),       // input
    .write_enable (RegWrite),    // input
    .rs1_dout (rs1),     // output
    .rs2_dout (rs2),      // output
    .is_ten (is_ten)
  );

  assign is_halted = is_ten & Ecall;//둘다 reg임. is_halted는 값을 계속 가지고 있을 것임.

  // ---------- Control Unit ----------
  ControlUnit ctrl_unit (
    .part_of_inst(instr[6:0]),  // input
    .is_jal(JAL),        // output
    .is_jalr(JALR),       // output
    .branch(Branch),        // output
    .mem_read(MemRead),      // output
    .mem_to_reg(MemtoReg),    // output
    .mem_write(MemWrite),     // output
    .alu_src(ALUSrc),       // output
    .reg_write(RegWrite),     // output
    .pc_to_reg(PCtoReg),     // output
    .is_ecall(Ecall)       // output (ecall inst)
  );

  // ---------- Immediate Generator ----------
  ImmediateGenerator imm_gen(
    .part_of_inst(instr),  // input
    .imm_gen_out(imm)    // output
  );

  // ---------- ALU Control Unit ----------
  ALUControlUnit alu_ctrl_unit (
    .part_of_inst(instr),  // input
    .alu_op(aluop)         // output
  );

  // ---------- ALU ----------
  ALU alu (
    .ALUop(aluop),      // input
    .A(rs1),    // input  
    .B(m2),    // input
    .bcond(bcond),  // output
    .ALUresult(aluresult)
  );

  // ---------- Data Memory ----------
  DataMemory dmem(
    .reset (reset),      // input
    .clk (clk),        // input
    .addr (aluresult),       // input
    .din (rs2),        // input
    .mem_read (MemRead),   // input
    .mem_write (MemWrite),  // input
    .dout (m5)        // output
  );
  
  ALU adder_pc_4(
    .ALUop(`ADD),      // input
    .A(current_pc),    // input  
    .B(32'd4),    // input
    .bcond(trash1),  // output
    .ALUresult(pc4)
  );
  
  ALU adder_pc_imm(
    .ALUop(`ADD),      // input
    .A(current_pc),    // input  
    .B(imm),    // input
    .bcond(trash2),  // output
    .ALUresult(a1)
  );
  
  MUX mux_to_rf(
    .A(m4),
    .B(pc4),
    .select(PCtoReg),
    .OUT(m1)
  );
  
  MUX mux_to_alu(
    .A(rs2),
    .B(imm),
    .select(ALUSrc),
    .OUT(m2)
  );
  
  assign b1 = bcond & Branch;
  assign b2 = b1 | JAL;
  
  MUX mux_from_pc(
    .A(pc4),
    .B(a1),
    .select(b2),
    .OUT(m3)
  );
  
  MUX mux_to_pc(
    .A(m3),
    .B(aluresult),
    .select(JALR),
    .OUT(next_pc)
  );
  
  MUX mux_from_dm(
    .A(aluresult),
    .B(m5),
    .select(MemtoReg),
    .OUT(m4)
  );
  
  
  
endmodule
