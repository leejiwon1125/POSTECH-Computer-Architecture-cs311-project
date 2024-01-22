`define HIT 2'b00
`define M2C 2'b01
`define C2M 2'b10
module Cache #(parameter LINE_SIZE = 16,
               parameter NUM_SETS = 8,
               parameter NUM_WAYS = 2) (
    input reset,
    input clk,

    input is_input_valid,
    input [31:0] addr,
    input mem_read,
    input mem_write,
    input [31:0] din,

    output is_ready, //data mem ¿Ã ∞·¡§«ÿ¡‹.
    output is_output_valid, // is_hit mem_read∞° ∞·¡§«ÿ¡‹.
    output reg [31:0] dout,
    output reg is_hit);
  // Wire declarations
  wire is_data_mem_ready;
  wire dm_is_output_valid;
  wire [8*LINE_SIZE-1:0]dm_dout;
  
  wire [24:0]tag_from_addr; 
  wire [2:0]idx_from_addr;
  wire [1:0]bo_from_addr;
  
  // Reg declarations
  // You might need registers to keep the status.
  reg recent [0:NUM_SETS-1];
  
  reg valid_0 [0:NUM_SETS-1];
  reg dirty_0 [0:NUM_SETS-1];
  reg [24:0] tag_0 [0:NUM_SETS-1];
  reg [8*LINE_SIZE-1:0] data_bank_0 [0:NUM_SETS-1];
  
  reg valid_1 [0:NUM_SETS-1];
  reg dirty_1 [0:NUM_SETS-1];
  reg [24:0] tag_1 [0:NUM_SETS-1];
  reg [8*LINE_SIZE-1:0] data_bank_1 [0:NUM_SETS-1];
  
  reg [1:0] state;
  reg [1:0] next_state;

  reg write_0;
  reg write_1;

  reg hit_0;
  reg hit_1;

  reg m2c_0;
  reg m2c_1;

  reg c2m_0;
  reg c2m_1;

  reg [8*LINE_SIZE-1:0] data_bank;
  reg [24:0] tag;

  reg [31:0] dm_addr;
  reg dm_is_input_valid;
  reg dm_mem_read;
  reg dm_mem_write;
  reg [8*LINE_SIZE-1:0] dm_din;

  integer i;
  
  assign tag_from_addr = addr[31:7];
  assign idx_from_addr = addr[6:4];
  assign bo_from_addr = addr[3:2];
  
  always @(posedge clk) begin
    if(hit_0) begin
      recent[idx_from_addr] <= 0;
      if(write_0) begin
        data_bank_0[idx_from_addr] <= data_bank;
        dirty_0[idx_from_addr] <= 1;
      end
    end
    else if(hit_1) begin
      recent[idx_from_addr] <= 1;
      if(write_1) begin
        data_bank_1[idx_from_addr] <= data_bank;
        dirty_1[idx_from_addr] <= 1;
      end
    end
    else if(m2c_0) begin
      valid_0[idx_from_addr]<=1;
      dirty_0[idx_from_addr]<=0;
      tag_0[idx_from_addr]<=tag;
      data_bank_0[idx_from_addr]<=data_bank;
    end
    else if(m2c_1) begin
      valid_1[idx_from_addr]<=1;
      dirty_1[idx_from_addr]<=0;
      tag_1[idx_from_addr]<=tag;
      data_bank_1[idx_from_addr]<=data_bank;
    end
    else if(c2m_0)
    begin
      dirty_0[idx_from_addr]<=0;
    end
    else if(c2m_1) 
    begin
      dirty_1[idx_from_addr]<=0;
    end
  end

  
  always @(*) begin
    hit_0=0;
    hit_1=0;
    m2c_0=0;
    m2c_1=0;
    c2m_0=0;
    c2m_1=0;
    write_0=0;
    write_1=0;
    dm_is_input_valid=0;
    if(is_input_valid)
    begin
      case(state)
        `HIT: 
        begin
          if( (tag_from_addr == tag_0[idx_from_addr]) && valid_0[idx_from_addr] ) //hit in 0 
          begin
            is_hit = 1;
            hit_0=1;
            next_state=`HIT;
            //load
            case (bo_from_addr)
            0: dout = data_bank_0 [idx_from_addr] [31:0];
            1: dout = data_bank_0 [idx_from_addr] [63:32];
            2: dout = data_bank_0 [idx_from_addr] [95:64];
            3: dout = data_bank_0 [idx_from_addr] [127:96];
            endcase
            //store
            if(mem_write)
            begin
                write_0=1;
                data_bank = data_bank_0[idx_from_addr];
                case (bo_from_addr)
                0: data_bank[31:0] = din;
                1: data_bank[63:32]  = din;
                2: data_bank[95:64]  = din;
                3: data_bank[127:96] = din;
                endcase
            end
          end //hit in 0  end 
          else if( (tag_from_addr == tag_1[idx_from_addr]) && valid_1[idx_from_addr] ) //hit in 1
          begin
            is_hit = 1;
            hit_1=1;
            next_state=`HIT;
            //load
            case (bo_from_addr)
            0: dout = data_bank_1 [idx_from_addr] [31:0];
            1: dout = data_bank_1 [idx_from_addr] [63:32];
            2: dout = data_bank_1 [idx_from_addr] [95:64];
            3: dout = data_bank_1 [idx_from_addr] [127:96];
            endcase
            //store
            if(mem_write)
            begin
                write_1=1;
                data_bank = data_bank_1[idx_from_addr];
                case (bo_from_addr)
                0: data_bank[31:0] = din;
                1: data_bank[63:32]  = din;
                2: data_bank[95:64]  = din;
                3: data_bank[127:96] = din;
                endcase
            end
          end //hit in 1 end
          else begin//miss
            is_hit=0;
            if(recent[idx_from_addr])//change cache_0
            begin
              if(dirty_0[idx_from_addr]==0)//go M2C
              begin
                next_state=`M2C;
                dm_addr={addr[31:4],4'b0000};
                dm_is_input_valid=1;
                dm_mem_read=1;
                dm_mem_write=0;
                dm_din=0;
              end
              else//go C2M
              begin
                next_state=`C2M;
                dm_addr={tag_0[idx_from_addr],idx_from_addr,4'b0000};
                dm_is_input_valid=1;
                dm_mem_read=0;
                dm_mem_write=1;
                dm_din=data_bank_0[idx_from_addr];
              end
            end
            else//change cache_1
            begin
              if(dirty_1[idx_from_addr]==0)//go M2C
              begin
                next_state=`M2C;
                dm_addr={addr[31:4],4'b0000};
                dm_is_input_valid=1;
                dm_mem_read=1;
                dm_mem_write=0;
                dm_din=0;
              end
              else//go C2M
              begin
                next_state=`C2M;
                dm_addr={tag_1[idx_from_addr],idx_from_addr,4'b0000};
                dm_is_input_valid=1;
                dm_mem_read=0;
                dm_mem_write=1;
                dm_din=data_bank_1[idx_from_addr];
              end
            end
          end//miss end
        end//HIT end
        `M2C:
          begin
            if(dm_is_output_valid)//after 50 cycles
            begin
              is_hit=0;
              next_state=`HIT;
              if(recent[idx_from_addr])
              begin
                m2c_0=1;
              end//change cache_0
              else
              begin
                m2c_1=1;//change cache_1
              end
              tag=tag_from_addr;
              data_bank=dm_dout;
            end
            else//during 50 cycles
            begin
              is_hit=0;
              next_state=`M2C;
            end
          end
        `C2M:
          begin
            if(is_data_mem_ready)
            begin
              is_hit=0;
              next_state=`HIT;
              if(recent[idx_from_addr])
              begin
                c2m_0=1;
              end
              else
              begin
                c2m_1=1;
              end
            end
            else
            begin
              is_hit=0;
              next_state=`C2M;
            end
          end
      endcase
    end
  end

  always @(posedge clk) begin
    if(reset) begin
      for(i = 0; i < NUM_SETS; i = i + 1) begin
        valid_0[i] = 0;
        valid_1[i] = 0;
        dirty_0[i] = 0;
        dirty_1[i] = 0;
        recent[i]=0;
      end
    end
  end

  always @(posedge clk) begin
    if(reset) next_state <= `HIT;
    else state <= next_state;
  end

  assign is_ready = is_data_mem_ready;
  assign is_output_valid = is_hit;
  
  
  // Instantiate data memory
  DataMemory #(.BLOCK_SIZE(LINE_SIZE)) data_mem(
    .reset(reset),
    .clk(clk),

    .is_input_valid(dm_is_input_valid),
    .addr(dm_addr),        // NOTE: address must be shifted by CLOG2(LINE_SIZE)
    .mem_read(dm_mem_read),
    .mem_write(dm_mem_write),
    .din(dm_din),

    // is output from the data memory valid?
    .is_output_valid(dm_is_output_valid),
    .dout(dm_dout),
    // is data memory ready to accept request?
    .mem_ready(is_data_mem_ready)
  );
endmodule