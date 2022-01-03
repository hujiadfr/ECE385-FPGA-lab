module  ship_RAM   //bisimai 
(
    input Clk,
    input [18:0] read_address1, read_address2,
    // input [5:0] ship_state, ship2_state,
    // input logic [2:0] choose_ship1, choose_ship2,
    // output logic [3:0] ball_data1, ball_data2
    output [3:0] data1_1, data1_2, data1_3, data1_4, data1_5,
    output [3:0] data2_1, data2_2, data2_3, data2_4, data2_5
);
    // mem has width of 4 bits and a total of 6399 addresses for pixels
    logic [3:0] mem1_1 [0:6399];
    logic [3:0] mem1_2 [0:6399];
    logic [3:0] mem1_3 [0:6399];
    logic [3:0] mem1_4 [0:6399];
    logic [3:0] mem1_5 [0:6399];

    logic [3:0] mem2_1 [0:6399];
    logic [3:0] mem2_2 [0:6399];
    logic [3:0] mem2_3 [0:6399];
    logic [3:0] mem2_4 [0:6399];
    logic [3:0] mem2_5 [0:6399];

    initial
    begin
        $readmemh("sources/bisimai.png.txt",            mem1_1);
        $readmemh("sources/bisimai_move_left.png.txt",  mem1_2);
        $readmemh("sources/bisimai_move.png.txt",       mem1_3);
        $readmemh("sources/bisimai_attack.png.txt",     mem1_4);
        $readmemh("sources/bisimai_dead.png.txt",       mem1_5);

        $readmemh("sources/bisimai2.png.txt",           mem2_1);
        $readmemh("sources/bisimai2_move.png.txt",      mem2_3);
        $readmemh("sources/bisimai2_move_left.png.txt", mem2_2);
        $readmemh("sources/bisimai2_attack.png.txt",    mem2_4);
        $readmemh("sources/bisimai2_dead.png.txt",      mem2_5);
    end
    always_ff@ (posedge Clk)
    begin
        data1_1 <= mem1_1[read_address1];
        data1_2 <= mem1_2[read_address1];
        data1_3 <= mem1_3[read_address1];
        data1_4 <= mem1_4[read_address1];
        data1_5 <= mem1_5[read_address1];

        data2_1 <= mem2_1[read_address2];
        data2_2 <= mem2_2[read_address2];
        data2_3 <= mem2_3[read_address2];
        data2_4 <= mem2_4[read_address2];
        data2_5 <= mem2_5[read_address2];
    end

endmodule
