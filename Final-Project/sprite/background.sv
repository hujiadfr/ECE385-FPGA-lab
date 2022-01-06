module background (
	input Clk, 
	// input logic background_exist,
	input logic [9:0] DrawX, DrawY,
	output logic [3:0] background_data
	// output logic is_background
);
	// screen size
	parameter [9:0] SCREEN_WIDTH =  10'd480;
   	parameter [9:0] SCREEN_LENGTH = 10'd640;
	parameter [9:0] RESHAPE_LENGTH = 10'd320;
	//--------------------load memory-----------------//
	logic [18:0] read_address;
	// assign read_address = DrawX + DrawY*RESHAPE_LENGTH;
	assign read_address = DrawX/2 + DrawY/2*RESHAPE_LENGTH;	// in low quality
	background_RAM background_RAM(.*);
endmodule

module  background_RAM
(
	input Clk,
	input [18:0] read_address,
	output logic [3:0] background_data
);
	// mem has width of 4 bits and a total of 307200=480*640 addresses
	// logic [3:0] mem [0:307199];
	logic [3:0] mem [0:71924];	// in low quality
	initial
	begin
		// $readmemh("sources/background.txt", mem);
		$readmemh("sources/background_low.txt", mem);	// in low quality
	end

	always_ff @ (posedge Clk) begin
		background_data<= mem[read_address];
	end
endmodule