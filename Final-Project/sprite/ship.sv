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
               output logic  is_ball,            // Whether current pixel belongs to ball or background
               output [3:0]  ball_data
              );

//--------------------------------------------------------------------
    parameter [9:0] Ball_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 10'd240;  // Center position on the Y axis
	parameter [9:0] RESHAPE_LENGTH = 10'd40;
//--------------------------------------------------------------------  

    logic [18:0] read_address;
    assign read_address = (DrawX-Ball_X_Pos) + RESHAPE_LENGTH/2 + (DrawY-Ball_Y_Pos+RESHAPE_LENGTH/2)*RESHAPE_LENGTH;
    ship_RAM ship_RAM(.*);
    int DistX, DistY, Size;
    assign DistX = DrawX - Ball_X_Pos;
    assign DistY = DrawY - Ball_Y_Pos;
    assign Size = RESHAPE_LENGTH;
    always_comb begin
        if ( (DrawX - Ball_X_Pos <= Size || Ball_X_Pos-DrawX <= Size) && (DrawY - Ball_Y_Pos <= Size || Ball_Y_Pos-DrawY <= Size)) 
            is_ball = 1'b1;
        else
            is_ball = 1'b0;
    end
endmodule


module  ship_RAM
(
    input Clk,
    input [18:0] read_address,
    output logic [3:0] ball_data
);
    // mem has width of 4 bits and a total of 307200 addresses
    //logic [3:0] mem [0:307199];
    logic [3:0] mem [0:1600];
    initial
    begin
        $readmemh("sources/bisimai.txt", mem);
    end

    always_ff @ (posedge Clk) begin
        ball_data<= mem[read_address];
    end
endmodule
