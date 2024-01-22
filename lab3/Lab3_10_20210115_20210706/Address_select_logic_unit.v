`timescale 1ns / 1ps

module Address_select_logic_unit(
    input clk,
    input reset,
    input [6:0] instr,
    input [2:0] AddrCtl,
    output reg [3:0] state
    );
    
     wire[3:0] R1,R2,A2M,out;
    
    MUX3 muxMC(
      .A(4'd0),
      .B(R1),
      .C(R2),
      .D(A2M),
      .E(4'd11),
      .F(4'd7),
      .select(AddrCtl),
      .OUT(out)
    );
    
    bit4adder adder(
      .A(state),    // input  
      .B(4'd1),    // input
      .ALUresult(A2M)
    );
    
    ROM1 r1(
      .part_of_inst(instr),
      .state(R1)
    );
    
    ROM2 r2(
      .part_of_inst(instr),
      .state(R2)
    );

   

    always @(posedge clk) begin
        if(reset == 1'd1)
        begin         
            state <=4'd0;
        end
        else if(reset == 1'd0)
        begin
            state<=out;
        end
    end
    
    
endmodule

