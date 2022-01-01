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
    // logic [3:0] mem0 [0:307199];
    logic [3:0] mem0 [0:1600];
    logic [3:0] mem1 [0:1600];
    logic [3:0] mem2 [0:1600];
    logic [3:0] mem3 [0:1600];
    logic [3:0] mem4 [0:1600];
    logic [3:0] mem5 [0:1600];

    initial
    begin
        $readmemh("sources/bisimai.txt", mem0);
        // $readmemh("sources/bisimai_get_hit.txt", mem1);
        $readmemh("sources/bisimai_move_left.txt", mem2);
        $readmemh("sources/bisimai_move.txt", mem3);
        $readmemh("sources/bisimai_attack.txt", mem4);
        $readmemh("sources/bisimai_dead.txt", mem5);
    end

    always_ff @ (posedge Clk) begin
        // case(ship_state) // test mode from sw
        //     6'd000001:   ball_data<= mem0[read_address];
        //     // 6'b000010:   ball_data<= mem1[read_address];
        //     6'b000100:   ball_data<= mem2[read_address];
        //     6'b001000:   ball_data<= mem3[read_address];
        //     6'b010000:   ball_data<= mem4[read_address];
        //     6'b100000:   ball_data<= mem5[read_address];
        //     default:     ball_data<= mem5[read_address];
        // endcase
        case(ship_state)
            6'd0:   ball_data<= mem0[read_address];
            // 6'd1:   ball_data<= mem1[read_address];
            6'd2:   ball_data<= mem2[read_address];
            6'd3:   ball_data<= mem3[read_address];
            6'd4:   ball_data<= mem4[read_address];
            6'd5:   ball_data<= mem5[read_address];
            default:     ball_data<= mem0[read_address];
        endcase
    end
endmodule

module  Ship2 ( input        Clk,                // 50 MHz clock
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
    ship_RAM ship2_RAM(.*);
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

module  ship2_RAM
(
    input Clk,
    input [18:0] read_address,
    input [5:0] ship_state,
    output logic [3:0] ball_data
);
    // mem has width of 4 bits and a total of 1600 addresses for pixels
    // logic [3:0] mem0 [0:307199];
    logic [3:0] mem0 [0:1600];
    logic [3:0] mem1 [0:1600];
    logic [3:0] mem2 [0:1600];
    logic [3:0] mem3 [0:1600];
    logic [3:0] mem4 [0:1600];
    logic [3:0] mem5 [0:1600];

    initial
    begin
        $readmemh("sources/bisimai.txt", mem0);
        // $readmemh("sources/bisimai_get_hit.txt", mem1);
        $readmemh("sources/bisimai_move.txt", mem2);
        $readmemh("sources/bisimai_move_left.txt", mem3);
        $readmemh("sources/bisimai_attack.txt", mem4);
        $readmemh("sources/bisimai_dead.txt", mem5);
    end

    always_ff @ (posedge Clk) begin
        // case(ship_state) // test mode from sw
        //     6'd000001:   ball_data<= mem0[read_address];
        //     // 6'b000010:   ball_data<= mem1[read_address];
        //     6'b000100:   ball_data<= mem2[read_address];
        //     6'b001000:   ball_data<= mem3[read_address];
        //     6'b010000:   ball_data<= mem4[read_address];
        //     6'b100000:   ball_data<= mem5[read_address];
        //     default:     ball_data<= mem5[read_address];
        // endcase
        case(ship_state)
            6'd0:   ball_data<= mem0[read_address];
            // 6'd1:   ball_data<= mem1[read_address];
            6'd2:   ball_data<= mem2[read_address];
            6'd3:   ball_data<= mem3[read_address];
            6'd4:   ball_data<= mem4[read_address];
            6'd5:   ball_data<= mem5[read_address];
            default:     ball_data<= mem0[read_address];
        endcase
    end
endmodule
