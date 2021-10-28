//module reg_16 (
//        input logic Clk, Reset, Load,
//        input logic [15:0] Din,
//        output logic [15:0] Dout
//    );
//    
//	 logic [15:0] register;
//	 always_comb
//	 begin 
//		  register = 	Dout;
//		  if (~Reset) // Asynchronous Reset
//            register = 0;
//        else if (Load)
//            register = Din;
//	 end
//	 
//	 
//	 
//	 
//	 always_ff @ (posedge Clk) 
//	 begin
//        Dout<=register;
//    end
//endmodule


module reg_16 (
        input logic Clk, Reset, Load,
        input logic [15:0] Din,
//        output logic Shift_Out,
        output logic [15:0] Dout
    );
    always_ff @ (posedge Clk) begin
        if (~Reset) // Asynchronous Reset
            Dout <= 16'h0;
        else if (Load)
            Dout <= Din[15:0];
    end
endmodule
