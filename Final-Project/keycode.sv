/*******************************

@Parameters keycode_1 ... : 8-bit char, each is a key from keyboard

@parameter command: {up, down, left, right, shoot} <- {W, S, A, D, space}

Description: 
    This module receive keycode from keyboard, 
    interperate them into commands for different players.

*******************************/

module keycode (
    input  Clk,                // 50 MHz clock
    input  [7:0] keycode_0, keycode_1, keycode_2, keycode_3, keycode_4, keycode_5,
    output [3:0] command_p1,   // {up, down, left, right} <- {W, S, A, D}
    output [3:0] command_p2    // {up, down, left, right} <- {up, down, left, right}

);
    //TODO: add shoot as command[5]
    logic p1_right, p1_left, p1_up, p1_down;    
    logic p2_right, p2_left, p2_up, p2_down;    

    // commands for player1
    assign p1_right = ((keycode_0 == 8'd07 || keycode_1 == 8'd07) || (keycode_2 == 8'd07 || keycode_3 == 8'd07)) || ((keycode_4 == 8'd07 || keycode_5 == 8'd07));
    assign p1_left  = ((keycode_0 == 8'd04 || keycode_1 == 8'd04) || (keycode_2 == 8'd04 || keycode_3 == 8'd04)) || ((keycode_4 == 8'd04 || keycode_5 == 8'd04));
    assign p1_up    = ((keycode_0 == 8'd26 || keycode_1 == 8'd26) || (keycode_2 == 8'd26 || keycode_4 == 8'd26)) || ((keycode_4 == 8'd26 || keycode_5 == 8'd26));
    assign p1_down  = ((keycode_0 == 8'd22 || keycode_1 == 8'd22) || (keycode_2 == 8'd22 || keycode_3 == 8'd22)) || ((keycode_4 == 8'd22 || keycode_5 == 8'd22));
    
    // commands for player2
    assign p2_right = ((keycode_0 == 8'd79 || keycode_1 == 8'd79) || (keycode_2 == 8'd79 || keycode_3 == 8'd79)) || ((keycode_4 == 8'd79 || keycode_5 == 8'd79));
    assign p2_left  = ((keycode_0 == 8'd80 || keycode_1 == 8'd80) || (keycode_2 == 8'd80 || keycode_3 == 8'd80)) || ((keycode_4 == 8'd80 || keycode_5 == 8'd80));
    assign p2_down    = ((keycode_0 == 8'd81 || keycode_1 == 8'd81) || (keycode_2 == 8'd81 || keycode_4 == 8'd81)) || ((keycode_4 == 8'd81 || keycode_5 == 8'd81));
    assign p2_up  = ((keycode_0 == 8'd82 || keycode_1 == 8'd82) || (keycode_2 == 8'd82 || keycode_3 == 8'd82)) || ((keycode_4 == 8'd82 || keycode_5 == 8'd82));
    
    always_comb
    begin
        command_p1 = {p1_up, p1_down, p1_left, p1_right};
        command_p2 = {p2_up, p2_down, p2_left, p2_right};
    end
 
endmodule