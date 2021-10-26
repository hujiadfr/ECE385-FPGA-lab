module SEXT
(
    input logic [15:0] IR,
    output logic [15:0] SEXT11,
	output logic [15:0] SEXT9,
	output logic [15:0] SEXT6,
	output logic [15:0] SEXT5
);
// use the highest prior bit to decide whether to 
// extend data by 1 or by 0
always_comb
begin
    if (IR[10])
        SEXT11 = {5'b11111,IR[10:0]};
    else
        SEXT11 = {5'b00000,IR[10:0]};
    if (IR[8])
        SEXT9 = {7'b1111111,IR[8:0]};
    else
        SEXT9 = {7'b0000000,IR[8:0]};
    if(IR[5])
        SEXT6 = {9'b111111111,IR[5:0]};
    else
        SEXT6 = {9'b000000000,IR[5:0]};
    if(IR[4])
        SEXT5 = {10'b1111111111,IR[4:0]};
    else
        SEXT5 = {10'b0000000000,IR[4:0]};
end    
endmodule