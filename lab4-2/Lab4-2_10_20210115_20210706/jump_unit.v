`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/16 01:22:09
// Design Name: 
// Module Name: jump_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module jump_unit(
    input wire clk,
    input wire reset,
    input wire ID_EX_is_jal,
    input wire ID_EX_is_jalr,
    input wire ID_EX_branch,
    input wire [31:0] ALU1,
    input wire [31:0] ID_EX_imm,
    input wire [31:0] ID_EX_current_pc,
    input wire bcond,
    output reg is_jump,
    output reg [31:0] taken_pc
    );
     // taken 되었을 때 PC
  always @(*) begin
    if(ID_EX_is_jal||ID_EX_is_jalr||(ID_EX_branch&&bcond)) begin //점프 뛰는 경우 -> JAL, JALR, BXX의 taken
      is_jump <= 1;
      if(ID_EX_is_jalr) begin
        taken_pc <= (ALU1+ID_EX_imm)&32'hFFFFFFFE; //FORWARDING된거로.  ID_EX_imm
      end
      else begin
        taken_pc <= ID_EX_current_pc+ID_EX_imm;
      end
    end
    else begin //점프 안뛰는 경우 -> 나머지 
      is_jump <= 0;
      taken_pc <= 0;
    end
  end
    
endmodule
