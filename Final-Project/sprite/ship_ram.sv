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
    logic [3:0] mem1 [0:6399];
    logic [3:0] mem2 [0:6399];
    logic [3:0] mem3 [0:6399];
    logic [3:0] mem4 [0:6399];
    logic [3:0] mem5 [0:6399];

    initial
    begin
        $readmemh("sources/bisimai.png.txt", mem1);
        $readmemh("sources/bisimai_move_left.png.txt", mem2);
        $readmemh("sources/bisimai_move.png.txt", mem3);
        $readmemh("sources/bisimai_attack.png.txt", mem4);
        $readmemh("sources/bisimai_dead.png.txt", mem5);
    end
    always_ff@ (posedge Clk)
    begin
        data1_1 <= mem1[read_address1];
        data1_2 <= mem2[read_address1];
        data1_3 <= mem3[read_address1];
        data1_4 <= mem4[read_address1];
        data1_5 <= mem5[read_address1];
    end
    always_ff@ (posedge Clk)
    begin
        data2_1 <= mem1[read_address2];
        data2_2 <= mem2[read_address2];
        data2_3 <= mem3[read_address2];
        data2_4 <= mem4[read_address2];
        data2_5 <= mem5[read_address2];
    end

endmodule
