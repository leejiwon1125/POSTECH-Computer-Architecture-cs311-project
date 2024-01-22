
module ImmediateGenerator(input [31:0] part_of_inst, output reg [31:0] imm_gen_out
    );
    always @(*) begin
      case (part_of_inst[6:0])
            `JAL: begin
                if(part_of_inst[31]==0)
                    imm_gen_out={11'b00000000000,part_of_inst[31],part_of_inst[19:12],part_of_inst[20],part_of_inst[30:21],1'b0};
                else
                    imm_gen_out={11'b11111111111,part_of_inst[31],part_of_inst[19:12],part_of_inst[20],part_of_inst[30:21],1'b0};
                end
            `JALR: begin
                if(part_of_inst[31]==0)
                    imm_gen_out={20'b00000000000000000000,part_of_inst[31:20]};
                else
                    imm_gen_out={20'b11111111111111111111,part_of_inst[31:20]};
                end
            `BRANCH: begin
                if(part_of_inst[31]==0)
                    imm_gen_out={19'b0000000000000000000,part_of_inst[31],part_of_inst[7],part_of_inst[30:25],part_of_inst[11:8],1'b0};
                else
                    imm_gen_out={19'b1111111111111111111,part_of_inst[31],part_of_inst[7],part_of_inst[30:25],part_of_inst[11:8],1'b0};
                end
            `LOAD: begin
                if(part_of_inst[31]==0)
                    imm_gen_out={20'b00000000000000000000,part_of_inst[31:20]};
                else
                    imm_gen_out={20'b11111111111111111111,part_of_inst[31:20]};
                end
            `STORE: begin
                if(part_of_inst[31]==0)
                    imm_gen_out={20'b00000000000000000000,part_of_inst[31:25],part_of_inst[11:7]};
                else
                    imm_gen_out={20'b11111111111111111111,part_of_inst[31:25],part_of_inst[11:7]};
                end
            `ARITHMETIC_IMM: begin
                if(part_of_inst[31]==0)
                    imm_gen_out={20'b00000000000000000000,part_of_inst[31:20]};
                else
                    imm_gen_out={20'b11111111111111111111,part_of_inst[31:20]};
                end
            default: begin
                imm_gen_out=32'b0;
            end
      endcase
    end
endmodule

