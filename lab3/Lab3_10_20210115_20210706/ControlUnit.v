module ControlUnit(
    input clk,
    input reset,
    input [6:0] instr,
    
    output  PCWriteCond,        
    output  PCWrite,       
    output  IorD,        
    output  MemRead,
    output  MemWrite,
    output  MemtoReg,
    output  IRWrite,     
    output  PCSource,     
    output  [1:0] ALUOp, 
    output  [1:0] ALUSrcB,    
    output  ALUSrcA,    
    output  RegWrite,
    output  IsEcall,
    output  [4:0] IsIf
    );
    
    wire [2:0] AddrCtl;
    wire [3:0] state;
    
    Address_select_logic_unit ASLU( 
     .clk(clk),
     .reset(reset),
     .instr(instr),
     .AddrCtl(AddrCtl),
     .state(state)
     );
    
    ControlUnit_PLA CU_PLA(
    .state(state),
    .PCWriteCond(PCWriteCond),        
    .PCWrite(PCWrite),       
    .IorD(IorD),        
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .IRWrite(IRWrite),     
    .PCSource(PCSource),     
    .ALUOp(ALUOp), 
    .ALUSrcB(ALUSrcB),    
    .ALUSrcA(ALUSrcA),    
    .RegWrite(RegWrite),
    .AddrCtl(AddrCtl),
  
    .IsEcall(IsEcall),
    .IsIf(IsIf)
    );
    
endmodule