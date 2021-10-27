// 这是MUX
//2 to 1
module Mux2 
(
    input logic Select,
    input logic [15:0] A,
    input logic [15:0] B,
    output logic [15:0] Out
);
	always_comb
	// use select to choose inputs
	begin
		if (Select)
			Out = B;
		else
			Out = A;	
	end
endmodule

//4 to 1 MUX
module Mux4
(
    input logic Select,
    input logic [15:0] A,
    input logic [15:0] B,
    input logic [15:0] C,
    input logic [15:0] D,
    output logic [15:0] Out
);
    always_comb 
    begin
        case(Select)
            2'b00: Out = A;
            2'b01: Out = B;
            2'b10: Out = C;
            2'b11: Out = D;
        endcase
    end
endmodule

//prepare for bus
module Mux_Bus
(
    input logic Select,
    input logic [15:0] A,
    input logic [15:0] B,
    input logic [15:0] C,
    input logic [15:0] D,
    output logic [15:0] Out
);
always_comb 
    begin
        case(Select)
            4'b0001: Out = A;
				4'b0010: Out = B;
				4'b0100: Out = C;
				4'b1000: Out = D;
			default: Out = 16'h0000;
        endcase
    end
endmodule
