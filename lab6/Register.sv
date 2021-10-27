module reg_16 
(
	input logic Clk,
	input logic Reset,
	input logic Load,
	input logic [15:0]Din,
	output logic [15:0]Dout);
	// register module which can modify the input size
	logic [15:0]register;
	
	always_ff @ (posedge Clk)
	begin
		Dout <= register;
	end
	
	always_comb 
	begin
		register = Dout;
		if (~Reset)
			register = 0;
		else if(Load)
			register = Din;
	end
endmodule
