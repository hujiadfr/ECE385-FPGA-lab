// Testbench for report.

module testbench();
	
	timeunit 10ns;
	timeprecision 1ns;

	// Set variables and instance.
	logic CLK,RESET,AES_START,AES_DONE;
	logic [127:0] AES_KEY,AES_MSG_ENC,AES_MSG_DEC;
	logic [127:0]  current_STATE;
	AES AES_test(.*);
	
	// Clock Generation and Initialization.
	always begin : CLOCK_GENERATION 
		#1 CLK = ~CLK;
	end 

		always begin 
		#1 current_STATE = AES_test.AES_STATE;
	end 
	initial begin: CLOCK_INITIALIZATION 
		CLK = 0;
	end
	
	initial begin: TEST_VECTORS
	// Starting Settings
	AES_START = 1'b0;
	RESET = 1'b1;
	
	// Info of Key and En_message.
	AES_KEY = 128'h000102030405060708090a0b0c0d0e0f;
	AES_MSG_ENC = 128'hdaec3055df058e1c39e814ea76f6747e;

	// Prepare to start by stop resetting.
	#2 RESET = 1'b0;
	
	// Start the simulation.
	#2 AES_START = 1'b1;
	end
	 
endmodule
