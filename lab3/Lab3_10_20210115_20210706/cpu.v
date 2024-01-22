// Submit this file with other files you created.
// Do not touch port declarations of the module 'CPU'.

// Guidelines
// 1. It is highly recommened to `define opcodes and something useful.
// 2. You can modify the module.
// (e.g., port declarations, remove modules, define new modules, ...)
// 3. You might need to describe combinational logics to drive them into the module (e.g., mux, and, or, ...)
// 4. `include files if required

module CPU(input reset,       // positive reset signal
           input clk,         // clock signal
           output is_halted
                      ); // Whehther to finish simulation                      
  /***** Wire declarations *****/
  wire [31:0] current_pc, next_pc, instr, rs1, rs2, imm, aluresult, Addr, rd_din, ALU1, ALU2;
  wire PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, PCSource, ALUSrcA, RegWrite, PC_Write, bcond, IsEcall;
  wire [1:0] ALUOp, ALUSrcB;
  wire [3:0] alu_op;
  wire [4:0] IsIf,rs1_input;
  /***** Register declarations *****/
  reg [31:0] IR; // instruction register
  reg [31:0] MDR; // memory data register
  reg [31:0] A; // Read 1 data register
  reg [31:0] B; // Read 2 data register
  reg [31:0] ALUOut; // ALU output register
  // Do not modify and use registers declared above.

  // ---------- Update program counter ----------
  // PC must be updated on the rising edge (positive edge) of the clock.
  PC pc(
    .reset(reset),       // input (Use reset to initialize PC. Initial value must be 0)
    .clk(clk),         // input
    .next_pc(next_pc),     // input
    .current_pc(current_pc),   // output
    .PC_Write(PC_Write)
  );

  assign PC_Write=(PCWriteCond&bcond)|PCWrite;

  // ---------- Register File ----------
  RegisterFile reg_file(
    .reset(reset),        // input
    .clk(clk),          // input
    .rs1(rs1_input),          // input
    .rs2(IR[24:20]),          // input
    .rd(IR[11:7]),           // input
    .rd_din(rd_din),       // input
    .write_enable(RegWrite),    // input
    .rs1_dout(rs1),     // output
    .rs2_dout(rs2)      // output
  );

  // ---------- Memory ----------
  Memory memory(
    .reset(reset),        // input
    .clk(clk),          // input
    .addr(Addr),         // input
    .din(B),          // input
    .mem_read(MemRead),     // input
    .mem_write(MemWrite),    // input
    .dout(instr)          // output
  );

  // ---------- Control Unit ----------
  ControlUnit ctrl_unit(
    .clk(clk),
    .reset(reset),
    .instr(IR[6:0]),  // input
    .PCWriteCond(PCWriteCond),        // output
    .PCWrite(PCWrite),       // output
    .IorD(IorD),        // output
    .MemRead(MemRead),      // output
    .MemWrite(MemWrite),     // output
    .MemtoReg(MemtoReg),    // output
    .IRWrite(IRWrite),     // output
    .PCSource(PCSource),     // output
    .ALUOp(ALUOp),     // output
    .ALUSrcB(ALUSrcB),       // output
    .ALUSrcA(ALUSrcA),       // output
    .RegWrite(RegWrite),     // output
    .IsEcall(IsEcall),       // output (ecall inst)
    .IsIf(IsIf)
    
  );

  // ---------- Immediate Generator ----------
  ImmediateGenerator imm_gen(
    .part_of_inst(IR[31:0]),  // input
    .imm_gen_out(imm)    // output
  );

  // ---------- ALU Control Unit ----------
  ALUControlUnit alu_ctrl_unit(
    .part_of_inst(IR[31:0]),  // input
    .alu_op_signal(ALUOp),
    .alu_op(alu_op)         // output
  );
  // ---------- ALU ----------
  ALU alu(
    .ALUop(alu_op),      // input
    .A(ALU1),    // input  
    .B(ALU2),    // input
    .ALUresult(aluresult),  // output
    .bcond(bcond)     // output
  );

  MUX PC_to_Memory(
    .A(current_pc),
    .B(ALUOut),
    .select(IorD),
    .OUT(Addr)
  );

  MUX A_to_ALU(
    .A(current_pc),
    .B(A),
    .select(ALUSrcA),
    .OUT(ALU1)
  );

  MUX2 B_to_ALU(
    .A(B),
    .B(32'd4),
    .C(imm),
    .D(32'd0),
    .select(ALUSrcB),
    .OUT(ALU2)
  );

  MUX MDR_to_register(
    .A(ALUOut),
    .B(MDR),
    .select(MemtoReg),
    .OUT(rd_din)
  );

  MUX ALU_to_PC(
    .A(aluresult),
    .B(ALUOut),
    .select(PCSource),
    .OUT(next_pc)
  );

  MUX5bit IsIF_to_register(
    .A(IR[19:15]),
    .B(IsIf),
    .select(IsIf[4]),
    .OUT(rs1_input)
  );
  
  is_Ecall_and_ten IEAT(
    .clk(clk),
    .reset(reset),
    .IsEcall(IsEcall),
    .A(A),
    .is_halted(is_halted)
  );
  
always @(posedge clk)begin
  if(IRWrite) IR <= instr;
  if(IorD) MDR <= instr;
  A <= rs1;
  B <= rs2;
  ALUOut <= aluresult;
end


endmodule

