// This module is only used for test, and will not be contained in the 
// top level after every part of the project has been done.
module shipFSM(input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
					 input logic [5:0]SW,
					 output	[5:0] ship_state
                );
	 logic [5:0]state_in;
	 logic frame_clk_delayed, frame_clk_rising_edge;
	 logic [5:0]count, count_in;
	 
	always_ff @ (posedge Clk)
    begin
		ship_state <= state_in;
		count <= count_in;
	 end
		  
	 always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    

	always_comb begin
		state_in = ship_state;
		count_in = count;
		if (frame_clk_rising_edge) begin
		//------------SWitch test------------//
        	state_in = SW[5:0]; // for debug
		
		//------------Count test------------//
		// 	count_in = count +1;
		// 	if (count == 4'd10) begin
		// 		count_in = 0;
		// 		state_in = ship_state+ 1;
		// 	end
		// end
		// if (ship_state > 5'd31)begin
		// 	state_in = 0;
		// end
		
	end
endmodule
