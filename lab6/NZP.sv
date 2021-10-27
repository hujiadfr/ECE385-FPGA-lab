module NZP
(
    input logic[15:0] Bus;
    output logic[2:0] NZP_val;
);

always_comb
begin
    if(Bus == 16'h0000)
        NZP_val = 3'b010;
    else if(Bus[15] == 1'b1)
        NZP_val = 3'b100;
    else
        NZP_val = 3'b001;
end
endmodule
