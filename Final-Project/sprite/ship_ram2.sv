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

    logic [3:0] mem1_6 [0:6399];
    logic [3:0] mem1_7 [0:6399];
    logic [3:0] mem1_8 [0:6399];
    logic [3:0] mem1_9 [0:6399];
    logic [3:0] mem1_10 [0:6399];

    logic [3:0] mem2_6 [0:6399];
    logic [3:0] mem2_7 [0:6399];
    logic [3:0] mem2_8 [0:6399];
    logic [3:0] mem2_9 [0:6399];
    logic [3:0] mem2_10 [0:6399];

    initial
    begin

        $readmemh("sources/linbo.png.txt",              mem1_6);
        $readmemh("sources/linbo_move_left.png.txt",    mem1_7);
        $readmemh("sources/linbo_move.png.txt",         mem1_8);
        $readmemh("sources/linbo_attack.png.txt",       mem1_9);
        $readmemh("sources/linbo_dead.png.txt",         mem1_10);

        $readmemh("sources/linbo2.png.txt",             mem2_6);
        $readmemh("sources/linbo2_move.png.txt",        mem2_8);
        $readmemh("sources/linbo2_move_left.png.txt",   mem2_7);
        $readmemh("sources/linbo2_attack.png.txt",      mem2_9);
        $readmemh("sources/linbo2_dead.png.txt",        mem2_10);

    end

    always_ff@ (posedge Clk)
    begin
        data1_6 <= mem1_6[read_address1];
        data1_7 <= mem1_7[read_address1];
        data1_8 <= mem1_8[read_address1];
        data1_9 <= mem1_9[read_address1];
        data1_10 <= mem1_10[read_address1];

        data2_6 <= mem2_6[read_address2];
        data2_7 <= mem2_7[read_address2];
        data2_8 <= mem2_8[read_address2];
        data2_9 <= mem2_9[read_address2];
        data2_10 <= mem2_10[read_address2];
    end
endmodule
