module data_hazard_detect_unit (
    input reset,
    input clk,
    input [31:0] part_of_inst,
    input [31:0] ID_EX_inst,
    input ID_EX_mem_read,
    input is_Ecall,
    input ID_EX_reg_write,
    output reg is_stall
  );
  //use_rs1=(part_of_inst[6:0]!=7'b1101111)&&(part_of_inst[19:15]!=0)
  //use_rs2=(part_of_inst[6:0]==7'b1100011)&&(part_of_inst[6:0]==7'b0100011)&&(part_of_inst[6:0]==7'b0110011)&&(part_of_inst[24:20]!=0)
  
  always @(posedge clk) begin
    if(reset) is_stall <=0;
  end
  
  always @(*) begin                             //rs1?? JAL?????? ???. JAL?? ???? rs1?? ?????? ????.                //rs2?? R S B ???? ??.
      if(  
           (
           ( (part_of_inst[19:15]==ID_EX_inst[11:7]) && (part_of_inst[6:0]!=7'b1101111) )  
           ||( (part_of_inst[24:20]==ID_EX_inst[11:7]) && ( (part_of_inst[6:0]==7'b0110011) || (part_of_inst[6:0]==7'b0100011) || (part_of_inst[6:0]==7'b1100011)  ) ) 
           )
           && ID_EX_mem_read
         )//if
          is_stall <=1;
       else if(
               is_Ecall&&(ID_EX_inst[11:7]==5'd17)&&ID_EX_reg_write
               ) 
           is_stall<=1;
       else 
          is_stall <=0;
      //if((part_of_inst[19:15]==ID_EX_inst[11:7])&&(part_of_inst[6:0]!=7'b1101111)&&(part_of_inst[19:15]!=0)&&ID_EX_mem_read) is_stall<=1;
      //if((part_of_inst[24:20]==ID_EX_inst[11:7])&&(part_of_inst[6:0]==7'b1100011)&&(part_of_inst[6:0]==7'b0100011)&&(part_of_inst[6:0]==7'b0110011)&&(part_of_inst[24:20]!=0)&&ID_EX_mem_read) is_stall<=1;
      //if(is_Ecall&&(ID_EX_inst[11:7]==5'd17)&&ID_EX_reg_write) is_stall<=1;
  end
  
endmodule
