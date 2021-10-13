module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);
    logic c4, c8, c12;
    four_ripple_adder FA0(.A (A[3:0]), .B (B[3:0]), .CI (1'b0), .Sum (Sum[3:0]), .CO (c4) );
    carry_select_adder_4bit CSA2 (.A (A[7:4]), .B (B[7:4]), .CI (c4), .Sum (Sum[7:4]), .CO (c8) );
    carry_select_adder_4bit CSA3 (.A (A[11:8]), .B (B[11:8]), .CI (c8), .Sum (Sum[11:8]), .CO (c12) );
    carry_select_adder_4bit CSA4 (.A (A[15:12]), .B (B[15:12]), .CI (c12), .Sum (Sum[15:12]), .CO (CO) );
endmodule

module four_ripple_adder
(       
    input   logic[3:0]     A,
    input   logic[3:0]     B,
    input   logic          CI,
    output  logic[3:0]     Sum,
    output  logic          CO
);
    wire c1,c2,c3;
    full_adder FA0 (.x (A[0]), .y (B[0]), .z (CI) , .s (Sum[0]), .c (c1));
    full_adder FA1 (.x (A[1]), .y (B[1]), .z (c1), .s (Sum[1]), .c (c2));
    full_adder FA2 (.x (A[2]), .y (B[2]), .z (c2), .s (Sum[2]), .c (c3));
    full_adder FA3 (.x (A[3]), .y (B[3]), .z (c3), .s (Sum[3]), .c (CO));

endmodule

module carry_select_adder_4bit (
    input   logic[3:0]     A,
    input   logic[3:0]     B,
    input   logic          CI,
    output  logic[3:0]     Sum,
    output  logic          CO
);
    wire temp0, temp1;
    wire[3:0] temp_Sum0, temp_Sum1;

    four_ripple_adder FA0(.A (A[3:0]), .B (B[3:0]) , .CI (1'b0), .Sum (temp_Sum0[3:0]), .CO (temp0) );
    four_ripple_adder FA1(.A (A[3:0]), .B (B[3:0]) , .CI (1'b1), .Sum (temp_Sum1[3:0]), .CO (temp1) );
    
    assign CO = (CI & temp1) | temp0;
    always_comb begin: MUX
        case(CI)
            1'b0:   Sum[3:0] <= temp_Sum0;
            1'b1:   Sum[3:0] <= temp_Sum1;
        endcase
    end
endmodule