module full_adder (input x,y,z, output s,c);
    assign s=x^y^z;
    assign c=(x&y)|(y&z)|(x&z);
endmodule


module nine_bit_adder
(
    input [8:0] A, B, // A connect to the RegA, B connect to the RegS
    input fn,
	input control_add,
	input x1,
    output [7:0] S, //This is output S[8] for X, and S[7:0] for RegA
	 output x2
);
   logic c0,c1,c2, c3, c4, c5, c6, c7; //internal carries in the 4-bit adder
   logic [8:0] BB;
	logic X_temp;
    //logic A8, BB8; //internal sign extension bits
	 // when fn=1, complement B
	// always_comb begin
	// 	case(fn)
	// 	1'b0:	BB = B;
	// 	1'b1:	BB = ~B;
	// 	endcase
	// 	A8 = A[7]; 
	//     BB8 = BB[7]; // Sign extension bits
	// end
	assign BB = B ^ {9{fn}};
	// copied from sign-bits
  full_adder FA0(.x(A[0]), .y(BB[0]), .z(fn), .s(S[0]), .c(c0));
  full_adder FA1(.x(A[1]), .y(BB[1]), .z(c0), .s(S[1]), .c(c1));
  full_adder FA2(.x(A[2]), .y(BB[2]), .z(c1), .s(S[2]), .c(c2));
  full_adder FA3(.x(A[3]), .y(BB[3]), .z(c2), .s(S[3]), .c(c3));
  full_adder FA4(.x(A[4]), .y(BB[4]), .z(c3), .s(S[4]), .c(c4));
  full_adder FA5(.x(A[5]), .y(BB[5]), .z(c4), .s(S[5]), .c(c5));
  full_adder FA6(.x(A[6]), .y(BB[6]), .z(c5), .s(S[6]), .c(c6));
  full_adder FA7(.x(A[7]), .y(BB[7]), .z(c6), .s(S[7]), .c(c7));
  full_adder FA8(.x(A[8]),   .y(BB[8]),   .z(c7), .s(X_temp), .c());
  assign x2 = X_temp&(1'b1&control_add)|(x1&(1'b1&(~control_add)));
  //assign x2 = X_temp;
endmodule
