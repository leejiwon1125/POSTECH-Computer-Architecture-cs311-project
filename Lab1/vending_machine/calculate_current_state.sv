`include "vending_machine_def.sv"


module calculate_current_state(i_input_coin,real_selected_item,item_price,coin_value,current_total,ret_sig,
o_return_coin,current_total_nxt,o_available_item,o_output_item);


	
	input [`kNumCoins-1:0] i_input_coin;
	input  [`kNumItems-1:0] real_selected_item;		
	input [31:0] item_price [`kNumItems-1:0];
	input [31:0] coin_value [`kNumCoins-1:0];	
	input [`kTotalBits-1:0] current_total;
	input ret_sig;
	output reg [`kNumCoins-1:0] o_return_coin;
	output reg [`kNumItems-1:0] o_available_item;
	output reg [`kNumItems-1:0] o_output_item;
	output reg  [`kTotalBits-1:0] current_total_nxt;
	integer i;
	
	
	//initial begin
	//   o_return_coin<=0;
	//end

    //calculate_available_item
    always @(*) begin
        if(current_total >= item_price[3])
            o_available_item <= 4'b1111;
        else if(current_total >= item_price[2])
            o_available_item <= 4'b0111;
        else if(current_total >= item_price[1])
            o_available_item <= 4'b0011;
        else if(current_total >= item_price[0])
            o_available_item <= 4'b0001;
        else o_available_item <= 4'b0000;
    end
	// Combinational logic for the next states
	always @(*) begin//real_selected_item
		case(real_selected_item)
		    4'b1000: begin
		      current_total_nxt<=current_total-item_price[3];
		      o_output_item<=real_selected_item;
		      end
		    4'b0100: begin
		      current_total_nxt<=current_total-item_price[2];
		      o_output_item<=real_selected_item;
		      end
		    4'b0010: begin
		      current_total_nxt<=current_total-item_price[1];
		      o_output_item<=real_selected_item;
		      end
		    4'b0001: begin
		      current_total_nxt<=current_total-item_price[0];
		      o_output_item<=real_selected_item;
		      end
		    default: begin
		      current_total_nxt<=current_total;
		      o_output_item<=real_selected_item;
		      end
		endcase
	end

	always @(*) begin
		case(i_input_coin)
		    3'b100: current_total_nxt<=current_total+coin_value[2];
		    3'b010: current_total_nxt<=current_total+coin_value[1];
		    3'b001: current_total_nxt<=current_total+coin_value[0];
		    default: current_total_nxt<=current_total;
		endcase
	end
	
	// Combinational logic for the outputs
	always @(*) begin
		if(ret_sig) begin
		  if(current_total>=coin_value[2])begin
		      o_return_coin<=3'b100;
		      current_total_nxt<=current_total-coin_value[2];
		  end
		  else if(current_total>=coin_value[1])begin
		      o_return_coin<=3'b010;
		      current_total_nxt<=current_total-coin_value[1];
		  end
		  else if(current_total>=coin_value[0])begin
		      o_return_coin<=3'b001;
		      current_total_nxt<=current_total-coin_value[0];
		  end
		  else
		      o_return_coin<=0;
		end
		else 
		  o_return_coin<=0;
        
	end
 
	


endmodule 