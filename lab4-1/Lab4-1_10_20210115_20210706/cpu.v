// Submit this file with other files you created.
// Do not touch port declarations of the module 'CPU'.

// Guidelines
// 1. It is highly recommened to `define opcodes and something useful.
// 2. You can modify modules (except InstMemory, DataMemory, and RegisterFile)
// (e.g., port declarations, remove modules, define new modules, ...)
// 3. You might need to describe combinational logics to drive them into the module (e.g., mux, and, or, ...)
// 4. `include files if required

module CPU(input reset,       // positive reset signal
           input clk,         // clock signal
           output is_halted); // Whehther to finish simulation
  /***** Wire declarations *****/
  wire [31:0] current_pc, next_pc, instr, rs1, rs2, imm, register17, ALU1, true_rs2, ALU2, true_write_data, WB_output, aluresult, mem_dout, trash_mux2;
  wire [4:0] rs1_input;
  wire [3:0] alu_op;
  wire [1:0] Ecall_select, ALU1_select, ALU2_select, rs2_from_forwarding, ALUSrc;
  wire MemRead, MemtoReg,MemWrite, RegWrite, is_stall, is_Ecall, ID_halted, trash0, trash1;

  /***** Register declarations *****/
  // You need to modify the width of registers
  // In addition, 
  // 1. You might need other pipeline registers that are not described below
  // 2. You might not need registers described below
  /***** IF/ID pipeline registers *****/
  reg [31:0] IF_ID_inst;           // will be used in ID stage
  /***** ID/EX pipeline registers *****/
  // From the control unit
  reg [1:0] ID_EX_alu_src;        // will be used in EX stage
  reg ID_EX_mem_write;      // will be used in MEM stage
  reg ID_EX_mem_read;       // will be used in MEM stage
  reg ID_EX_mem_to_reg;     // will be used in WB stage
  reg ID_EX_reg_write;      // will be used in WB stage
  // From others
  reg [31:0] ID_EX_rs1_data;
  reg [31:0] ID_EX_rs2_data;
  reg [31:0] ID_EX_imm;
  reg [31:0] ID_EX_inst;
  reg ID_EX_is_halted;

  /***** EX/MEM pipeline registers *****/
  // From the control unit
  reg EX_MEM_mem_write;     // will be used in MEM stage
  reg EX_MEM_mem_read;      // will be used in MEM stage
  reg EX_MEM_mem_to_reg;    // will be used in WB stage
  reg EX_MEM_reg_write;     // will be used in WB stage
  // From others
  reg [31:0] EX_MEM_alu_out;
  reg [31:0] EX_MEM_rs2_data;
  reg [31:0] EX_MEM_inst;
  reg EX_MEM_is_halted;

  /***** MEM/WB pipeline registers *****/
  // From the control unit
  reg MEM_WB_mem_to_reg;    // will be used in WB stage
  reg MEM_WB_reg_write;     // will be used in WB stage
  // From others
  reg [31:0] MEM_WB_inst;
  reg [31:0] MEM_WB_alu_out;
  reg [31:0] MEM_WB_read_data;
  reg MEM_WB_is_halted;
  // ---------- Update program counter ----------
  // PC must be updated on the rising edge (positive edge) of the clock.
  PC pc(
    .reset(reset),       // input (Use reset to initialize PC. Initial value must be 0)
    .clk(clk),         // input
    .next_pc(next_pc),     // input
    .current_pc(current_pc),   // output
    .is_stall(is_stall)
  );
  
  // ---------- Instruction Memory ----------
  InstMemory imem(
    .reset(reset),   // input
    .clk(clk),     // input
    .addr(current_pc),    // input
    .dout(instr)     // output
  );

  // Update IF/ID pipeline registers here
  always @(posedge clk) begin
    if (reset) begin
      IF_ID_inst<=0;
    end
    else begin
      if(!is_stall) IF_ID_inst<=instr;
    end
  end

  // ---------- Register File ----------
  RegisterFile reg_file (
    .reset (reset),        // input
    .clk (clk),          // input
    .rs1 (rs1_input),          // input
    .rs2 (IF_ID_inst[24:20]),          // input
    .rd (MEM_WB_inst[11:7]),           // input
    .rd_din (WB_output),       // input
    .write_enable (MEM_WB_reg_write),    // input
    .rs1_dout (rs1),     // output
    .rs2_dout (rs2)      // output
  );


  // ---------- Control Unit ----------
  ControlUnit ctrl_unit (
    .part_of_inst(IF_ID_inst),  // input
    .mem_read(MemRead),      // output
    .mem_to_reg(MemtoReg),    // output
    .mem_write(MemWrite),     // output
    .alu_src(ALUSrc),       // output
    .reg_write(RegWrite),  // output
    .is_ecall(is_Ecall)       // output (ecall inst)
  );

  // ---------- Immediate Generator ----------
  ImmediateGenerator imm_gen(
    .part_of_inst(IF_ID_inst),  // input
    .imm_gen_out(imm)    // output
  );

  // Update ID/EX pipeline registers here
  always @(posedge clk) begin
    if (reset) begin
      ID_EX_alu_src<=0;
      ID_EX_mem_write<=0;
      ID_EX_mem_read<=0;
      ID_EX_mem_to_reg<=0;
      ID_EX_reg_write<=0;
      ID_EX_imm<=0;
      ID_EX_inst<=0;
      ID_EX_is_halted<=0;
      ID_EX_rs1_data<=0;
      ID_EX_rs2_data<=0;
    end
    else begin
      ID_EX_alu_src<=ALUSrc;
      if(!is_stall) ID_EX_mem_write<=MemWrite;
      else ID_EX_mem_write<=0;
      ID_EX_mem_read<=MemRead;
      ID_EX_mem_to_reg<=MemtoReg;
      if(!is_stall) ID_EX_reg_write<=RegWrite;
      else ID_EX_reg_write<=0;
      ID_EX_imm<=imm;
      ID_EX_inst<=IF_ID_inst;
      ID_EX_is_halted<=ID_halted;
      ID_EX_rs1_data<=rs1;
      ID_EX_rs2_data<=rs2;
    end
  end

  // ---------- ALU Control Unit ----------
  ALUControlUnit alu_ctrl_unit (
    .part_of_inst(ID_EX_inst),  // input
    .alu_op(alu_op)         // output
  );

  // ---------- ALU ----------
  ALU alu (
    .ALUop(alu_op),      // input
    .A(ALU1),    // input  
    .B(ALU2),    // input
    .ALUresult(aluresult),  // output
    .bcond(trash0)     // output
  );

  // Update EX/MEM pipeline registers here
  always @(posedge clk) begin
    if (reset) begin
      EX_MEM_mem_write<=0;
      EX_MEM_mem_read<=0;
      EX_MEM_mem_to_reg<=0;
      EX_MEM_reg_write<=0;
      EX_MEM_alu_out<=0;
      EX_MEM_rs2_data<=0;
      EX_MEM_inst<=0;
      EX_MEM_is_halted<=0;
    end
    else begin
      EX_MEM_mem_write<=ID_EX_mem_write;
      EX_MEM_mem_read<=ID_EX_mem_read;
      EX_MEM_mem_to_reg<=ID_EX_mem_to_reg;
      EX_MEM_reg_write<=ID_EX_reg_write;
      EX_MEM_alu_out<=aluresult;
      EX_MEM_rs2_data<=true_write_data;
      EX_MEM_inst<=ID_EX_inst;
      EX_MEM_is_halted<=ID_EX_is_halted;
    end
  end

  // ---------- Data Memory ----------
  DataMemory dmem(
    .reset (reset),      // input
    .clk (clk),        // input
    .addr (EX_MEM_alu_out),       // input
    .din (EX_MEM_rs2_data),        // input
    .mem_read (EX_MEM_mem_read),   // input
    .mem_write (EX_MEM_mem_write),  // input
    .dout (mem_dout)        // output
  );

  // Update MEM/WB pipeline registers here
  always @(posedge clk) begin
    if (reset) begin
      MEM_WB_mem_to_reg<=0;
      MEM_WB_reg_write<=0;
      MEM_WB_inst<=0;
      MEM_WB_alu_out<=0;
      MEM_WB_is_halted<=0;
      MEM_WB_read_data<=0;
    end
    else begin
      MEM_WB_mem_to_reg<=EX_MEM_mem_to_reg;
      MEM_WB_reg_write<=EX_MEM_reg_write;
      MEM_WB_inst<=EX_MEM_inst;
      MEM_WB_alu_out<=EX_MEM_alu_out;
      MEM_WB_is_halted<=EX_MEM_is_halted;
      MEM_WB_read_data<=mem_dout;
    end
  end

  ALU adder_pc_4(
    .ALUop(4'b0100),      // input
    .A(current_pc),    // input  
    .B(32'd4),    // input
    .bcond(trash1),  // output
    .ALUresult(next_pc)
  );

  MUX5bit IsIF_to_register(
    .A(IF_ID_inst[19:15]),
    .B(5'd17),
    .select(is_Ecall),
    .OUT(rs1_input)
  );

  MUX2 is_ten_mux(
    .A(rs1),
    .B(trash_mux2),
    .C(EX_MEM_alu_out),
    .D(WB_output),
    .select(Ecall_select),
    .OUT(register17)
  );

  MUX2 ALU_src_1(
    .A(ID_EX_rs1_data),
    .B(trash_mux2),
    .C(EX_MEM_alu_out),
    .D(WB_output),
    .select(ALU1_select),
    .OUT(ALU1)
  );

  MUX2 ALU_src_2(
    .A(ID_EX_rs2_data),
    .B(ID_EX_imm),
    .C(EX_MEM_alu_out),
    .D(WB_output),
    .select(ALU2_select),
    .OUT(true_rs2)
  );
  
  MUX2 true_write(
    .A(true_rs2),
    .B(ID_EX_rs2_data),
    .C(true_rs2),
    .D(true_rs2),
    .select(ALU2_select),
    .OUT(true_write_data)
  );

  MUX memory_from_dm(
    .A(MEM_WB_alu_out),
    .B(MEM_WB_read_data),
    .select(MEM_WB_mem_to_reg),
    .OUT(WB_output)
  );
  
  MUX store_imm_select(
    .A(true_rs2),
    .B(ID_EX_imm),
    .select(ID_EX_mem_write),
    .OUT(ALU2)
  );

  rs2_select_unit rs2_select(
    .A(rs2_from_forwarding),
    .B(ID_EX_alu_src),
    .OUT(ALU2_select)
  );

  is_Ecall_and_ten IEAT(
    .Is_Ecall(is_Ecall),
    .A(register17),
    .is_halted(ID_halted)
  );

  data_hazard_detect_unit DHDU(
    .reset(reset),
    .clk(clk),
    .part_of_inst(IF_ID_inst),
    .ID_EX_inst(ID_EX_inst),
    .ID_EX_mem_read(ID_EX_mem_read),
    .is_Ecall(is_Ecall),
    .ID_EX_reg_write(ID_EX_reg_write),
    .is_stall(is_stall)
  );
  
  forwarding_unit FW(
    .ex_mem_inst(EX_MEM_inst),
    .mem_wb_inst(MEM_WB_inst),
    .id_ex_inst(ID_EX_inst),
    .ex_mem_reg_write(EX_MEM_reg_write),
    .mem_wb_reg_write(MEM_WB_reg_write),
    .is_ecall(is_Ecall),
    .forwarding_rs1(ALU1_select),
    .forwarding_rs2(rs2_from_forwarding),
    .ecall_select(Ecall_select)
  );

  assign is_halted=MEM_WB_is_halted;
  
endmodule
