module forwarding_unit (
    input [31:0] ex_mem_inst,
    input [31:0] mem_wb_inst,
    input [31:0] id_ex_inst,
    input ex_mem_reg_write,
    input mem_wb_reg_write,
    input is_ecall,
    output reg [1:0] forwarding_rs1,
    output reg [1:0] forwarding_rs2,
    output reg [1:0] ecall_select
  );
  
  always @(*) begin
      if((id_ex_inst[19:15]!=0)&&(id_ex_inst[19:15]==ex_mem_inst[11:7])&&ex_mem_reg_write) forwarding_rs1<=2'd2;
      else if((id_ex_inst[19:15]!=0)&&(id_ex_inst[19:15]==mem_wb_inst[11:7])&&mem_wb_reg_write) forwarding_rs1<=2'd3;
      else forwarding_rs1<=2'd0;
  end

  always @(*) begin
      if((id_ex_inst[24:20]!=0)&&(id_ex_inst[24:20]==ex_mem_inst[11:7])&&ex_mem_reg_write) forwarding_rs2<=2'd2;
      else if((id_ex_inst[24:20]!=0)&&(id_ex_inst[24:20]==mem_wb_inst[11:7])&&mem_wb_reg_write) forwarding_rs2<=2'd3;
      else forwarding_rs2<=2'd0;
  end

  always @(*) begin
      if((5'd17==ex_mem_inst[11:7])&&is_ecall) ecall_select<=2'd2;
      else if((5'd17==mem_wb_inst[11:7])&&mem_wb_reg_write) ecall_select<=2'd3;
      else ecall_select<=2'd0;
  end
  
endmodule
