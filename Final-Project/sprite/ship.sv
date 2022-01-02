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


module  Ship ( input        Clk,                // 50 MHz clock
                            Reset,              // Active-high reset signal
                            frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
               input logic [9:0] Ball_X_Pos,
	           input logic [9:0] Ball_Y_Pos,
               input logic [5:0] ship_state,
               input logic [2:0] choose_ship,
               input [3:0] data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15,

               output logic  is_ball,            // Whether current pixel belongs to ball or background
               output [3:0]  ball_data,
               output logic [18:0] read_address
              );

//--------------------------------------------------------------------
    parameter [9:0] Ball_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 10'd240;  // Center position on the Y axis
	parameter [9:0] RESHAPE_LENGTH = 10'd80;
    parameter [9:0] HALF_LENGTH = 10'd40;
//--------------------------------------------------------------------  

    // logic [18:0] read_address;
    assign read_address = (DrawX-Ball_X_Pos) + RESHAPE_LENGTH/2 + (DrawY-Ball_Y_Pos+RESHAPE_LENGTH/2)*RESHAPE_LENGTH;

    // ship_RAM ship_RAM(.*);

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

        case(choose_ship)
            3'b000: begin
                case(ship_state)
                6'd0:   ball_data = data1;
                6'd2:   ball_data = data2;
                6'd3:   ball_data = data3;
                6'd4:   ball_data = data4;
                6'd5:   ball_data = data5;
                default:     ball_data = data1;
            endcase
            end

            3'b001: begin
                case(ship_state)
                6'd0:   ball_data = data6;
                6'd2:   ball_data = data7;
                6'd3:   ball_data = data8;
                6'd4:   ball_data = data9;
                6'd5:   ball_data = data10;
                default:     ball_data = data6;
            endcase
            end

            3'b010: begin
                case(ship_state)
                6'd0:   ball_data = data11;
                6'd2:   ball_data = data12;
                6'd3:   ball_data = data13;
                6'd4:   ball_data = data14;
                6'd5:   ball_data = data15;
                default:     ball_data =data11;
            endcase
            end
            default: ball_data = data1;
        endcase
    end
endmodule

// ship_state:
// bismai_get_hit
// bismai_attack
// bismai_dead
// bismai_move_left
// bismai_move      // move right
// bismai           // standing
