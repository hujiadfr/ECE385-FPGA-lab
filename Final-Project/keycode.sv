/*******************************

@Parameters keycode_1 ... : 8-bit char, each is a key from keyboard

@parameter command: {up, down, left, right, shoot} <- {W, S, A, D, space}

*******************************/

module keycode (
    input Clk,                // 50 MHz clock
    input [7:0] keycode_0, keycode_1, keycode_2, keycode_3, keycode_4, keycode_5, keycode_6, keycode_7,
    output [3:0] command_p1    // {up, down, left, right} <- {W, S, A, D}
    output [3:0] command_p2    // {up, down, left, right} <- {up, down, left, right}

);
    // logic up, down, left, right, shoot;
    logic p1_right, p1_left, p1_up, p1_down;
    logic p2_right, p2_left, p2_up, p2_down;

    assign p1_right = ((keycode_0 == 8'h07 || keycode_1 == 8'h07) || (keycode_2 == 8'h07 || keycode_3 == 8'h07)) || ((keycode_4 == 8'h07 || keycode_5 == 8'h07) || (keycode_6 == 8'h07 || keycode_7 == 8'h07));
    assign p1_left  = ((keycode_0 == 8'h04 || keycode_1 == 8'h04) || (keycode_2 == 8'h04 || keycode_3 == 8'h04)) || ((keycode_4 == 8'h04 || keycode_5 == 8'h04) || (keycode_6 == 8'h04 || keycode_7 == 8'h04));
    assign p1_up    = ((keycode_0 == 8'h1a || keycode_1 == 8'h1a) || (keycode_2 == 8'h1a || keycode_4= = 8'h1a)) || ((keycode_4 == 8'h1a || keycode_5 == 8'h1a) || (keycode_6 == 8'h1a || keycode_7 == 8'h1a));
    assign p1_down  = ((keycode_0 == 8'h16 || keycode_1 == 8'h16) || (keycode_2 == 8'h16 || keycode_3 == 8'h16)) || ((keycode_4 == 8'h16 || keycode_5 == 8'h16) || (keycode_6 == 8'h16 || keycode_7 == 8'h16));
    
    assign p2_right = ((keycode_0 == 8'h79 || keycode_1 == 8'h79) || (keycode_2 == 8'h79 || keycode_3 == 8'h79)) || ((keycode_4 == 8'h79 || keycode_5 == 8'h79) || (keycode_6 == 8'h79 || keycode_7 == 8'h79));
    assign p2_left  = ((keycode_0 == 8'h80 || keycode_1 == 8'h80) || (keycode_2 == 8'h80 || keycode_3 == 8'h80)) || ((keycode_4 == 8'h80 || keycode_5 == 8'h80) || (keycode_6 == 8'h80 || keycode_7 == 8'h80));
    assign p2_up    = ((keycode_0 == 8'h81 || keycode_1 == 8'h81) || (keycode_2 == 8'h81 || keycode_4= = 8'h81)) || ((keycode_4 == 8'h81 || keycode_5 == 8'h81) || (keycode_6 == 8'h81 || keycode_7 == 8'h81));
    assign p2_down  = ((keycode_0 == 8'h82 || keycode_1 == 8'h82) || (keycode_2 == 8'h82 || keycode_3 == 8'h82)) || ((keycode_4 == 8'h82 || keycode_5 == 8'h82) || (keycode_6 == 8'h82 || keycode_7 == 8'h82));
    

    logic[27:0] count;
    
    always_ff @ (posedge Clk)
    begin
        if(count >= 28'h17D7840) // 50*10^6 / 2 = 1/2 of a second wait time before
        begin
            count <= 28'h0;
            command_p1 <= {p1_up, p1_down, p1_left, p1_right};
            command_p2 <= {p2_up, p2_down, p2_left, p2_right};
        end
        else
        begin
            count <= count + 1;
        end
    end
endmodule