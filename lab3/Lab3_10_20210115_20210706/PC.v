`timescale 1ns / 1ps


module PC(
    input reset,       // input (Use reset to initialize PC. Initial value must be 0)
    input clk,         // input
    input [31:0] next_pc,     // input
    output reg [31:0] current_pc,   // output
    input PC_Write
  );
  

  
always @(posedge clk) begin
 
    if(reset==1'd1)  current_pc <= 0;
 
    else 
    begin
       if( PC_Write == 1'b1)
       begin
        current_pc <= next_pc;
       end
    end
 end
  
  endmodule