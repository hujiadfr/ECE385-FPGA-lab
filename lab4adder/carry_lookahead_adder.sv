module full_add(input x,y,c,
	 output s);
    assign s = x ^ y ^ c;
endmodule

module four_bit_CLA
(
    input   logic[3:0]     a,
    input   logic[3:0]     b,
    input   logic          c,
    output  logic          Pg,
    output  logic          Gg,
    output  logic[3:0]     S
);
    logic c1, c2, c3;
    logic[3:0] P;
    logic[3:0] G;
    assign G = a & b;
    assign P = a ^ b;

    assign c1 = c & P[0] | G[0];
    assign c2 = c & P[0] & P[1] | G[0] & P[1] | G[1];
    assign c3 = c & P[0] & P[1] & P[2] | G[0] & P[1] & P[2] | G[1] & P[2] | G[2];

    full_add FA0 (.x (a[0]), .y (b[0]), .c (c), .s (S[0]));
    full_add FA1 (.x (a[1]), .y (b[1]), .c (c1), .s (S[1]));
    full_add FA2 (.x (a[2]), .y (b[2]), .c (c2), .s (S[2]));
    full_add FA3 (.x (a[3]), .y (b[3]), .c (c3), .s (S[3]));
    assign Pg = P[0] & P[1] & P[2] & P[3];
    assign Gg = G[3] | G[2]&P[3] | G[1]&P[3]&P[2] | G[0]&P[3]&P[2]&P[1];
endmodule


module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);
    logic c0,c4,c8,c12;
    logic   pg0, pg4, pg8, pg12;
    logic   gg0, gg4, gg8, gg12;
	assign c0 = 1'b0;
    four_bit_CLA FA0 (.a (A[3:0]), .b (B[3:0]), .c (c0), .Pg (pg0), .Gg (gg0), .S (Sum[3:0]));
    assign c4 = gg0 | c0&pg0;
    four_bit_CLA FA1 (.a (A[7:4]), .b (B[7:4]), .c (c4), .Pg (pg4), .Gg (gg4), .S (Sum[7:4]));
    assign c8 = gg4 | gg0&pg4 | c0&pg0&pg4;
    four_bit_CLA FA2 (.a (A[11:8]), .b (B[11:8]), .c (c8), .Pg (pg8), .Gg (gg8), .S (Sum[11:8]));
    assign c12 = gg8 | gg4&pg8 | gg0&pg8&pg4 |  c0&pg8&pg4&pg0;
    four_bit_CLA FA3 (.a (A[15:12]), .b (B[15:12]), .c (c12), .Pg (pg12), .Gg (gg12), .S (Sum[15:12]));

     
endmodule
