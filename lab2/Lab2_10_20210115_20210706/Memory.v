`timescale 1ns / 1ps

module InstMemory #(parameter MEM_DEPTH = 1024) (input reset,
                                                 input clk,
                                                 input [31:0] addr,   // address of the instruction memory
                                                 output [31:0] dout); // instruction at addr
  integer i;
  // Instruction memory
  reg [31:0] mem[0:MEM_DEPTH - 1];//32bit짜리가 1024개 있다.
  // Do not touch imem_addr
  wire [31:0] imem_addr;
  assign imem_addr = {2'b00, addr >> 2};

  // TODO
  // Asynchronously read instruction from the memory 
  // (use imem_addr to access memory)
  assign dout = mem[imem_addr]; 

  // Initialize instruction memory (do not touch except path)
  always @(posedge clk) begin
    if (reset) begin
      for (i = 0; i < MEM_DEPTH; i = i + 1)
          mem[i] = 32'b0;
      // Provide path of the file including instructions with binary format
      $readmemh("C:/non-controlflow_mem.txt", mem);
    end
  end

endmodule

module DataMemory #(parameter MEM_DEPTH = 16384) (input reset,
                                                  input clk,
                                                  input [31:0] addr,    // address of the data memory
                                                  input [31:0] din,     // data to be written
                                                  input mem_read,       // is read signal driven?
                                                  input mem_write,      // is write signal driven?
                                                  output [31:0] dout);  // output of the data memory at addr
  integer i;
  // Data memory
  reg [31:0] mem[0: MEM_DEPTH - 1];
  // Do not touch dmem_addr
  wire [31:0] dmem_addr;
  assign dmem_addr = {2'b00, addr >> 2};

  // TODO
  // Asynchrnously read data from the memory
  // Synchronously write data to the memory
  // (use dmem_addr to access memory)

    assign dout = mem_read ? mem[dmem_addr]:32'b0 ;
    
    always @(posedge clk) begin
    if(mem_write)
        begin
            mem[dmem_addr] <= din;
        end
    end

  // Initialize data memory (do not touch)
  always @(posedge clk) begin
    if (reset) begin
      for (i = 0; i < MEM_DEPTH; i = i + 1)
        mem[i] = 32'b0;
    end
  end
endmodule
