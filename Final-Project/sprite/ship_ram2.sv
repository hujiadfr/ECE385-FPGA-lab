module  ship_RAM2   //bisimai 
(
    input Clk,
    input [18:0] read_address1, read_address2,
    // input [5:0] ship_state, ship2_state,
    // input logic [2:0] choose_ship1, choose_ship2,
    // output logic [3:0] ball_data1, ball_data2
    output [3:0] data1_6, data1_7, data1_8, data1_9, data1_10,
    output [3:0] data2_6, data2_7, data2_8, data2_9, data2_10
);
    // mem has width of 4 bits and a total of 6399 addresses for pixels

    logic [3:0] mem6 [0:6399];
    logic [3:0] mem7 [0:6399];
    logic [3:0] mem8 [0:6399];
    logic [3:0] mem9 [0:6399];
    logic [3:0] mem10 [0:6399];

    initial
    begin

        $readmemh("sources/linbo.png.txt", mem6);
        $readmemh("sources/linbo_move_left.png.txt", mem7);
        $readmemh("sources/linbo_move.png.txt", mem8);
        $readmemh("sources/linbo_attack.png.txt", mem9);
        $readmemh("sources/linbo_dead.png.txt", mem10);

    end

    always_ff@ (posedge Clk)
    begin
        data1_6 <= mem6[read_address1];
        data1_7 <= mem7[read_address1];
        data1_8 <= mem8[read_address1];
        data1_9 <= mem9[read_address1];
        data1_10 <= mem10[read_address1];
    end
    always_ff@ (posedge Clk)
    begin
       data2_6 <= mem6[read_address2];
       data2_7 <= mem7[read_address2];
       data2_8 <= mem8[read_address2];
       data2_9 <= mem9[read_address2];
       data2_10 <= mem10[read_address2];
    end
endmodule
