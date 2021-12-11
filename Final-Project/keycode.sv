/*******************************

@Parameters keycode_1 ... : 8-bit char, each is a key from keyboard

@parameter command: {up, down, left, right, shoot} <- {W, S, A, D, space}

Description: 
    This module receive keycode from keyboard, 
    interperate them into commands for different players.

*******************************/

module keycode (
    input  Clk,                // 50 MHz clock
    input  [7:0] keycode_0, keycode_1, keycode_2, keycode_3, keycode_4, keycode_5, keycode_6, keycode_7,
    output [3:0] command_p1    // {up, down, left, right} <- {W, S, A, D}
    output [3:0] command_p2    // {up, down, left, right} <- {up, down, left, right}

);
    //TODO: add shoot as command[5]
    logic p1_right, p1_left, p1_up, p1_down;    
    logic p2_right, p2_left, p2_up, p2_down;    
    logic [3:0] command_p1， command_p2;

    // commands for player1
    assign p1_right = ((keycode_0 == 8'h07 || keycode_1 == 8'h07) || (keycode_2 == 8'h07 || keycode_3 == 8'h07)) || ((keycode_4 == 8'h07 || keycode_5 == 8'h07) || (keycode_6 == 8'h07 || keycode_7 == 8'h07));
    assign p1_left  = ((keycode_0 == 8'h04 || keycode_1 == 8'h04) || (keycode_2 == 8'h04 || keycode_3 == 8'h04)) || ((keycode_4 == 8'h04 || keycode_5 == 8'h04) || (keycode_6 == 8'h04 || keycode_7 == 8'h04));
    assign p1_up    = ((keycode_0 == 8'h1a || keycode_1 == 8'h1a) || (keycode_2 == 8'h1a || keycode_4= = 8'h1a)) || ((keycode_4 == 8'h1a || keycode_5 == 8'h1a) || (keycode_6 == 8'h1a || keycode_7 == 8'h1a));
    assign p1_down  = ((keycode_0 == 8'h16 || keycode_1 == 8'h16) || (keycode_2 == 8'h16 || keycode_3 == 8'h16)) || ((keycode_4 == 8'h16 || keycode_5 == 8'h16) || (keycode_6 == 8'h16 || keycode_7 == 8'h16));
    
    // commands for player2
    assign p2_right = ((keycode_0 == 8'h79 || keycode_1 == 8'h79) || (keycode_2 == 8'h79 || keycode_3 == 8'h79)) || ((keycode_4 == 8'h79 || keycode_5 == 8'h79) || (keycode_6 == 8'h79 || keycode_7 == 8'h79));
    assign p2_left  = ((keycode_0 == 8'h80 || keycode_1 == 8'h80) || (keycode_2 == 8'h80 || keycode_3 == 8'h80)) || ((keycode_4 == 8'h80 || keycode_5 == 8'h80) || (keycode_6 == 8'h80 || keycode_7 == 8'h80));
    assign p2_up    = ((keycode_0 == 8'h81 || keycode_1 == 8'h81) || (keycode_2 == 8'h81 || keycode_4= = 8'h81)) || ((keycode_4 == 8'h81 || keycode_5 == 8'h81) || (keycode_6 == 8'h81 || keycode_7 == 8'h81));
    assign p2_down  = ((keycode_0 == 8'h82 || keycode_1 == 8'h82) || (keycode_2 == 8'h82 || keycode_3 == 8'h82)) || ((keycode_4 == 8'h82 || keycode_5 == 8'h82) || (keycode_6 == 8'h82 || keycode_7 == 8'h82));
    
    command_p1 <= {p1_up, p1_down, p1_left, p1_right};
    command_p2 <= {p2_up, p2_down, p2_left, p2_right};

endmodule