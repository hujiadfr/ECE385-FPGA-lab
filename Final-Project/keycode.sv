/*******************************

@Parameters keycode_1 ... : 8-bit char, each is a key from keyboard

@parameter command: {up, down, left, right, shoot} <- {W, S, A, D, space}

*******************************/

module keycode (
    input Clk,                // 50 MHz clock
    input [7:0] keycode_1, keycode_2, keycode_3, keycode_4, keycode_5,
    output [4:0] command    // {up, down, left, right, shoot} <- {W, S, A, D, space}
);
    logic up, down, left, right, shoot;

    assign right = keycode_1 == 8'h07 || keycode_2 == 8'h07 || keycode_3 == 8'h07 || keycode_4 == 8'h07 || keycode_5 == 8'h07;
    assign left  = keycode_1 == 8'h04 || keycode_2 == 8'h04 || keycode_3 == 8'h04 || keycode_4 == 8'h04 || keycode_5 == 8'h04;
    assign up    = keycode_1 == 8'h1a || keycode_2 == 8'h1a || keycode_4= = 8'h1a || keycode_4 == 8'h1a || keycode_5 == 8'h1a;
    assign down  = keycode_1 == 8'h16 || keycode_2 == 8'h16 || keycode_3 == 8'h16 || keycode_4 == 8'h16 || keycode_5 == 8'h16;
    assign shoot = keycode_1 == 8'h44 || keycode_2 == 8'h44 || keycode_3 == 8'h44 || keycode_4 == 8'h44 || keycode_5 == 8'h44;

    logic[27:0] count;
    
    always_ff @ (posedge Clk)
    begin
        if(count >= 28'h17D7840) // 50*10^6 / 2 = 1/2 of a second wait time before
        begin
            count <= count;
            command <= {up, down, left, right, shoot};
        end
        else
        begin
            count <= count + 1;
        end
    end		  
endmodule