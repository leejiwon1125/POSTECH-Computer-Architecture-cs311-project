`timescale 1ns / 1ps
module ControlUnit_PLA(
    input wire [3:0] state,  // input
   
    output reg PCWriteCond,        
    output reg PCWrite,       
    output reg IorD,        
    output reg MemRead,
    output reg MemWrite,
    output reg MemtoReg,
    output reg IRWrite,     
    output reg PCSource,     
    output reg [1:0] ALUOp, 
    output reg [1:0] ALUSrcB,    
    output reg ALUSrcA,    
    output reg RegWrite,
    output reg [3:0] AddrCtl,
  
    output reg IsEcall,
    output reg [4:0] IsIf
    

    );
    
    
     always @(*) begin
        
            if(state==4'd0)begin
                PCWriteCond=1'b0;
                PCWrite=1'b1;
                IorD=1'b0;
                MemRead=1'b1;
                MemWrite=1'b0;
                MemtoReg=1'b0;
                IRWrite=1'b1;
                PCSource=1'b0;
                ALUOp=2'b00;
                ALUSrcB=2'b01;
                ALUSrcA=1'b0;
                RegWrite=1'b0;
                AddrCtl=3'b011;
                IsEcall=1'b0;
                IsIf=5'b10001;
            end

            else if(state==4'd1)begin
                PCWriteCond=1'b0;
                PCWrite=1'b0;
                IorD=1'b0;
                MemRead=1'b0;
                MemWrite=1'b0;
                MemtoReg=1'b0;
                IRWrite=1'b0;
                PCSource=1'b0;
                ALUOp=2'b11;
                ALUSrcB=2'b10;
                ALUSrcA=1'b0;
                RegWrite=1'b0;
                AddrCtl=3'b001;
                IsEcall=1'b0;
                IsIf=5'b00000;
            end

            else if(state==4'd2)begin
                PCWriteCond=1'b0;
                PCWrite=1'b0;
                IorD=1'b0;
                MemRead=1'b0;
                MemWrite=1'b0;
                MemtoReg=1'b0;
                IRWrite=1'b0;
                PCSource=1'b0;
                ALUOp=2'b00;
                ALUSrcB=2'b10;
                ALUSrcA=1'b1;
                RegWrite=1'b0;
                AddrCtl=3'b010;
                IsEcall=1'b0;
                IsIf=5'b00000;
            end

            else if(state==4'd3)begin
                PCWriteCond=1'b0;
                PCWrite=1'b0;
                IorD=1'b1;
                MemRead=1'b1;
                MemWrite=1'b0;
                MemtoReg=1'b0;
                IRWrite=1'b0;
                PCSource=1'b0;
                ALUOp=2'b00;
                ALUSrcB=2'b00;
                ALUSrcA=1'b0;
                RegWrite=1'b0;
                AddrCtl=3'b011;
                IsEcall=1'b0;
                IsIf=5'b00000;
            end

            else if(state==4'd4)begin
                PCWriteCond=1'b0;
                PCWrite=1'b0;
                IorD=1'b0;
                MemRead=1'b0;
                MemWrite=1'b0;
                MemtoReg=1'b1;
                IRWrite=1'b0;
                PCSource=1'b0;
                ALUOp=2'b00;
                ALUSrcB=2'b00;
                ALUSrcA=1'b0;
                RegWrite=1'b1;
                AddrCtl=3'b000;
                IsEcall=1'b0;
                IsIf=5'b00000;
            end

            else if(state==4'd5)begin
                PCWriteCond=1'b0;
                PCWrite=1'b0;
                IorD=1'b1;
                MemRead=1'b0;
                MemWrite=1'b1;
                MemtoReg=1'b0;
                IRWrite=1'b0;
                PCSource=1'b0;
                ALUOp=2'b00;
                ALUSrcB=2'b00;
                ALUSrcA=1'b0;
                RegWrite=1'b0;
                AddrCtl=3'b000;
                IsEcall=1'b0;
                IsIf=5'b00000;
            end

            else if(state==4'd6)begin
                PCWriteCond=1'b0;
                PCWrite=1'b0;
                IorD=1'b0;
                MemRead=1'b0;
                MemWrite=1'b0;
                MemtoReg=1'b0;
                IRWrite=1'b0;
                PCSource=1'b0;
                ALUOp=2'b10;
                ALUSrcB=2'b00;
                ALUSrcA=1'b1;
                RegWrite=1'b0;
                AddrCtl=3'b011;
                IsEcall=1'b0;
                IsIf=5'b00000;
            end

            else if(state==4'd7)begin
                PCWriteCond=1'b0;
                PCWrite=1'b0;
                IorD=1'b0;
                MemRead=1'b0;
                MemWrite=1'b0;
                MemtoReg=1'b0;
                IRWrite=1'b0;
                PCSource=1'b0;
                ALUOp=2'b00;
                ALUSrcB=2'b00;
                ALUSrcA=1'b0;
                RegWrite=1'b1;
                AddrCtl=3'b000;
                IsEcall=1'b0;
                IsIf=5'b00000;
            end

            else if(state==4'd8)begin
                PCWriteCond=1'b1;
                PCWrite=1'b0;
                IorD=1'b0;
                MemRead=1'b0;
                MemWrite=1'b0;
                MemtoReg=1'b0;
                IRWrite=1'b0;
                PCSource=1'b1;
                ALUOp=2'b01;//here
                ALUSrcB=2'b00;
                ALUSrcA=1'b1;
                RegWrite=1'b0;
                AddrCtl=3'b000;
                IsEcall=1'b0;
                IsIf=5'b00000;
            end

            else if(state==4'd9)begin
                PCWriteCond=1'b0;
                PCWrite=1'b0;
                IorD=1'b0;
                MemRead=1'b0;
                MemWrite=1'b0;
                MemtoReg=1'b0;
                IRWrite=1'b0;
                PCSource=1'b0;
                ALUOp=2'b10;
                ALUSrcB=2'b10;
                ALUSrcA=1'b1;
                RegWrite=1'b0;
                AddrCtl=3'b101;
                IsEcall=1'b0;
                IsIf=5'b00000;
            end

            else if(state==4'd10)begin
                PCWriteCond=1'b0;
                PCWrite=1'b0;
                IorD=1'b0;
                MemRead=1'b0;
                MemWrite=1'b0;
                MemtoReg=1'b0;
                IRWrite=1'b0;
                PCSource=1'b0;
                ALUOp=2'b00;
                ALUSrcB=2'b10;
                ALUSrcA=1'b1;
                RegWrite=1'b0;
                AddrCtl=3'b011;
                IsEcall=1'b0;
                IsIf=5'b00000;
            end

            else if(state==4'd11)begin
                PCWriteCond=1'b0;
                PCWrite=1'b1;
                IorD=1'b0;
                MemRead=1'b0;
                MemWrite=1'b0;
                MemtoReg=1'b0;
                IRWrite=1'b0;
                PCSource=1'b1;
                ALUOp=2'b00;
                ALUSrcB=2'b11;
                ALUSrcA=1'b0;
                RegWrite=1'b0;
                AddrCtl=3'b101;
                IsEcall=1'b0;
                IsIf=5'b00000;
            end

            else if(state==4'd13)begin
                PCWriteCond=1'b0;
                PCWrite=1'b0;
                IorD=1'b0;
                MemRead=1'b0;
                MemWrite=1'b0;
                MemtoReg=1'b0;
                IRWrite=1'b0;
                PCSource=1'b0;
                ALUOp=2'b00;
                ALUSrcB=2'b00;
                ALUSrcA=1'b0;
                RegWrite=1'b0;
                AddrCtl=3'b000;
                IsEcall=1'b1;
                IsIf=5'b00000;
            end
      
    end
endmodule
