/*Register Map:

not decided
*/
module avalon_game_interface (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,						// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable
	input  logic [5:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Exported Conduit
	output logic [2047:0] EXPORT_DATA		// Exported Conduit Signal to LEDs
);

	// create 64 32bit registers
	logic [63:0][31:0] Reg_unit;
	
	assign EXPORT_DATA = Reg_unit;
	always_ff @ (posedge CLK)
	begin
		if (RESET)				// if reset is active, clear all registers
			begin
				Reg_unit[0]  <= 32'h0;	
				Reg_unit[1]  <= 32'h0; 
				Reg_unit[2]  <= 32'h0; 
				Reg_unit[3]  <= 32'h0; 
				Reg_unit[4]  <= 32'h0;	
				Reg_unit[5]  <= 32'h0;	
				Reg_unit[6]  <= 32'h0;	
				Reg_unit[7]  <= 32'h0; 
				Reg_unit[8]  <= 32'h0; 
				Reg_unit[9]  <= 32'h0; 
				Reg_unit[10] <= 32'h0; 
				Reg_unit[11] <= 32'h0; 
				Reg_unit[12] <= 32'h0; 
				Reg_unit[13] <= 32'h0;	
				Reg_unit[14] <= 32'h0;	
				Reg_unit[15] <= 32'h0;	
				Reg_unit[16] <= 32'h0;	
				Reg_unit[17] <= 32'h0;	
				Reg_unit[18] <= 32'h0;
				Reg_unit[19] <= 32'h0; 
				Reg_unit[20] <= 32'h0; 
				Reg_unit[21] <= 32'h0; 
				Reg_unit[22] <= 32'h0;	
				Reg_unit[23] <= 32'h0;
				Reg_unit[24] <= 32'h0;	
				Reg_unit[25] <= 32'h0;	
				Reg_unit[26] <= 32'h0;	
				Reg_unit[27] <= 32'h0;	
				Reg_unit[28] <= 32'h0;	
				Reg_unit[29] <= 32'h0;	
				Reg_unit[30] <= 32'h0;	
				Reg_unit[31] <= 32'h0;	
				Reg_unit[32] <= 32'h0;	
				Reg_unit[33] <= 32'h0;	
				Reg_unit[34] <= 32'h0;
				Reg_unit[35] <= 32'h0;	
				Reg_unit[36] <= 32'h0;	
				Reg_unit[37] <= 32'h0;	
				Reg_unit[38] <= 32'h0;	
				Reg_unit[39] <= 32'h0;	
				Reg_unit[40] <= 32'h0;
				Reg_unit[41] <= 32'h0;	
				Reg_unit[42] <= 32'h0;
				Reg_unit[43] <= 32'h0;	 
				Reg_unit[44] <= 32'h0;	
				Reg_unit[45] <= 32'h0;
				Reg_unit[46] <= 32'h0;
				Reg_unit[47] <= 32'h0;
				Reg_unit[48] <= 32'h0;
				Reg_unit[49] <= 32'h0;
				Reg_unit[50] <= 32'h0;
				Reg_unit[51] <= 32'h0;
				Reg_unit[52] <= 32'h0;
				Reg_unit[53] <= 32'h0;
				Reg_unit[54] <= 32'h0;
				Reg_unit[55] <= 32'h0;
				Reg_unit[56] <= 32'h0;
				Reg_unit[57] <= 32'h0;
				Reg_unit[58] <= 32'h0;
				Reg_unit[59] <= 32'h0;
				Reg_unit[60] <= 32'h0;
				Reg_unit[61] <= 32'h0;
				Reg_unit[62] <= 32'h0;
				Reg_unit[63] <= 32'h0;
			end
		else if (AVL_WRITE && AVL_CS)
		begin
		/*write yourcode*/
		end
	end
	
	always_comb
	begin
		AVL_READDATA = 32'b0;
		// Read
		if (AVL_READ)
			AVL_READDATA = Reg_unit[AVL_ADDR];
	end
endmodule
	