//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  12-08-2017                               --
//    Spring 2018 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  Ship ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
               input logic [9:0] Ball_X_Pos,
	           input logic [9:0] Ball_Y_Pos,
               input logic [5:0] ship_state,
               output logic  is_ball,            // Whether current pixel belongs to ball or background
               output [3:0]  ball_data
              );

//--------------------------------------------------------------------
    parameter [9:0] Ball_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 10'd240;  // Center position on the Y axis
	parameter [9:0] RESHAPE_LENGTH = 10'd40;
    parameter [9:0] HALF_LENGTH = 10'd20;
//--------------------------------------------------------------------  

    logic [18:0] read_address;
    assign read_address = (DrawX-Ball_X_Pos) + HALF_LENGTH + (DrawY-Ball_Y_Pos+HALF_LENGTH)*RESHAPE_LENGTH;
    ship_RAM ship_RAM(.*);
    int DistX, DistY, Size;
    assign DistX = DrawX - Ball_X_Pos;
    assign DistY = DrawY - Ball_Y_Pos;
    assign Size = HALF_LENGTH;
    always_comb begin
        if ( 
                (DrawX - Ball_X_Pos <= Size || Ball_X_Pos-DrawX <= Size) && 
                (DrawY - Ball_Y_Pos <= Size || Ball_Y_Pos-DrawY <= Size)
            ) 
            is_ball = 1'b1;
        else
            is_ball = 1'b0;
    end
endmodule

// ship_state:
// bismai_get_hit
// bismai_attack
// bismai_dead
// bismai_move_left
// bismai_move      // move right
// bismai           // standing

module  ship_RAM
(
    input Clk,
    input [18:0] read_address,
    input [5:0] ship_state,
    output logic [3:0] ball_data
);
    // mem has width of 4 bits and a total of 1600 addresses for pixels
    //logic [3:0] mem [0:307199];
    logic [3:0] mem [4:0][0:1600];
    initial
    begin
        // $readmemh("sources/bisimai_get_hit.txt", mem[0]);
        $readmemh("sources/bisimai_attack.txt", mem[1]);
        $readmemh("sources/bisimai_dead.txt", mem[2]);
        $readmemh("sources/bisimai_move_left.txt", mem[3]);
        $readmemh("sources/bisimai_move.txt", mem[4]);
        $readmemh("sources/bisimai.txt", mem[5]);
    end

    always_ff @ (posedge Clk) begin
        ball_data<= mem[ship_state][read_address];
    end
endmodule
