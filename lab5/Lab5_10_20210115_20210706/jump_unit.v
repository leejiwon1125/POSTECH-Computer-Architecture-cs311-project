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
     // taken �Ǿ��� �� PC
  always @(*) begin
    if(ID_EX_is_jal||ID_EX_is_jalr||(ID_EX_branch&&bcond)) begin //���� �ٴ� ��� -> JAL, JALR, BXX�� taken
      is_jump <= 1;
      if(ID_EX_is_jalr) begin
        taken_pc <= (ALU1+ID_EX_imm)&32'hFFFFFFFE; //FORWARDING�Ȱŷ�.  ID_EX_imm
      end
      else begin
        taken_pc <= ID_EX_current_pc+ID_EX_imm;
      end
    end
    else begin //���� �ȶٴ� ��� -> ������ 
      is_jump <= 0;
      taken_pc <= 0;
    end
  end
    
endmodule
