module  ship_RAM3   //bisimai 
(
    input Clk,
    input [18:0] read_address1, read_address2,
    // input [5:0] ship_state, ship2_state,
    // input logic [2:0] choose_ship1, choose_ship2,
    // output logic [3:0] ball_data1, ball_data2
    output [3:0] data1_11, data1_12, data1_13, data1_14, data1_15,
    output [3:0] data2_11, data2_12, data2_13, data2_14, data2_15
);
    // mem has width of 4 bits and a total of 6399 addresses for pixels

    logic [3:0] mem11 [0:6399];
    logic [3:0] mem12 [0:6399];
    logic [3:0] mem13 [0:6399];
    logic [3:0] mem14 [0:6399];
    logic [3:0] mem15 [0:6399];

    initial
    begin
        $readmemh("sources/yingrui.png.txt", mem11);
        $readmemh("sources/yingrui_move_left.png.txt", mem12);
        $readmemh("sources/yingrui_move.png.txt", mem13);
        $readmemh("sources/yingrui_attack.png.txt", mem14);
        $readmemh("sources/yingrui_dead.png.txt", mem15);
    end
    always_ff@ (posedge Clk)
    begin
        data1_11 <= mem11[read_address1];
        data1_12 <= mem12[read_address1];
        data1_13 <= mem13[read_address1];
        data1_14 <= mem14[read_address1];
        data1_15 <= mem15[read_address1];

    end
    always_ff@ (posedge Clk)
    begin
        data2_11 <= mem11[read_address2];
        data2_12 <= mem12[read_address2];
        data2_13 <= mem13[read_address2];
        data2_14 <= mem14[read_address2];
        data2_15 <= mem15[read_address2];
    end

endmodule
