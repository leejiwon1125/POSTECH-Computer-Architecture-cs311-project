`include "vending_machine_def.sv"


module change_state(clk,reset_n,current_total_nxt,current_total);

	input clk;
	input reset_n;
	input [`kTotalBits-1:0] current_total_nxt;
	output reg[`kTotalBits-1:0] current_total;
	
	// Sequential circuit to reset or update the states
	always @(posedge clk ) begin
		if (!reset_n) begin
			current_total<=0;
		end
		else begin
			current_total<=current_total_nxt;
		end
	end
endmodule 