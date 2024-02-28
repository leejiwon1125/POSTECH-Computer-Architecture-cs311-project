`include "vending_machine_def.sv"

	

module check_time_and_coin(i_input_coin,i_select_item,clk,reset_n,wait_time,o_available_item,real_selected_item);
	input clk;
	input reset_n;
	input [`kNumCoins-1:0] i_input_coin;
	input [`kNumItems-1:0]	i_select_item;
	input [`kNumItems-1:0] o_available_item;
	output [`kNumItems-1:0] real_selected_item;
	output reg [31:0] wait_time;
	
	assign real_selected_item=i_select_item & o_available_item;
	// initiate values
	initial begin
		// TODO: initiate values
		wait_time<=100;
	end


	// update coin return time
	always @(i_input_coin, i_select_item) begin
		// TODO: update coin return time
		if(i_input_coin!=0) wait_time<=100;
		if(real_selected_item!=0) wait_time<=100;
	end

	always @(posedge clk ) begin
		if (!reset_n) begin
		// TODO: reset all states.
		wait_time<=100;
		end
		else begin
		// TODO: update all states.
		  #1 if(wait_time>0) wait_time<=wait_time-1;
		end
	end
endmodule 