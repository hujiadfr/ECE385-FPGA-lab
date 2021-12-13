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
//-------------------------------------------------------------------------
               input [9:0]   Step_X, Step_Y,     // step size
               input [7:0]   Angle,              // {7/8pi, 3/4pi, 5/8pi, pi, 3/8pi, 1/2pi, 1/4pi, 0}
//-------------------------------------------------------------------------
               output logic  is_ball             // Whether current pixel belongs to ball or background
              );

//--------------------------------------------------------------------
    // TODO change this when more than one ship is instanced
    parameter [9:0] Ball_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 10'd240;  // Center position on the Y axis
//--------------------------------------------------------------------  
    parameter [9:0] Ball_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_Size  = 10'd4;       // Ball size

    logic [9:0] Ball_X_Pos, Ball_Y_Pos,
                Ball_X_Motion, Ball_Y_Motion;

    logic [9:0] Ball_X_Pos_in, Ball_Y_Pos_in, 
                Ball_X_Motion_in, Ball_Y_Motion_in;
    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk)
    begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            Ball_X_Pos <= Ball_X_Center;
            Ball_Y_Pos <= Ball_Y_Center;
            Ball_X_Motion <= 10'd0;
            Ball_Y_Motion <= Step_Y;
        end
        else
        begin
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    always_comb
    begin
        // By default, keep motion and position unchanged
        Ball_X_Pos_in = Ball_X_Pos;
        Ball_Y_Pos_in = Ball_Y_Pos;
        Ball_X_Motion_in = Step_X;
        Ball_Y_Motion_in = Step_Y;

        // Update position only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
            // Be careful when using comparators with "logic" datatype because compiler 
            // treats both sides of the operator as UNSIGNED numbers.
            // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
            // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, 
            // but rather a large positive number.
            if ((Angle[3]||Angle[4]||Angle[5]) == 1'b1) begin
                Ball_X_Motion_in = (~(Step_Y) + 1'b1);
            end
            if ((Angle[6]||Angle[7]||Angle[8]) == 1'b1) begin
                Ball_Y_Motion_in = (~(Step_Y) + 1'b1);
            end
            // Update the position
            // TODO: stop the ball when hit the boundary for ship design.
            // clear the velocity, can move backward instead of sticked there.

            // Boundar for y
            if( Ball_Y_Pos + Ball_Size >= Ball_Y_Max )          // Ball is at the bottom edge, STOP!
                if ((Angle[2]||Angle[3]||Angle[4]) == 1'b0)
                begin
                    Ball_Y_Motion_in = 10'd0;                   // stop moving through the wall
                end
            else if ( Ball_Y_Pos <= Ball_Y_Min + Ball_Size )    // Ball is at the top edge, STOP!
                if ((Angle[6]||Angle[7]||Angle[8]) == 1'b0)
                begin
                    Ball_Y_Motion_in = 10'd0;                   // stop moving through the wall
                end                
            // Boundary for x
            if( Ball_X_Pos + Ball_Size >= Ball_X_Max)           // Ball is at the right edge, STOP!
                if ((Angle[4]||Angle[5]||Angle[6]) == 1'b0)
                begin
                    Ball_X_Motion_in = 10'd0;                   // stop moving through the wall
                end     
            else if (Ball_X_Pos <= Ball_X_Min + Ball_Size)      // Ball is at the left edge, STOP!
                if ((Angle[1]||Angle[2]||Angle[8]) == 1'b0)
                begin
                    Ball_X_Motion_in = 10'd0;                   // stop moving through the wall
                end

            // Update the ball's position with its motion
            Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion_in;
            Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion_in;
        end
    end
    
    // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Step;
    assign DistX = DrawX - Ball_X_Pos;
    assign DistY = DrawY - Ball_Y_Pos;
    assign Step = DistX + DistY;
    always_comb
    begin
        case(Angle)
            8'b00000001:
            begin
                if ((Step <= 10'd2) && (DrawX >= Ball_X_Pos)) 
                begin
                    is_ball = 1'b1;
                end
            end
            8'b00000010:
            begin
                if ((Step <= 10'd4) && (DistY <= DistX)) 
                begin
                    is_ball = 1'b1;
                end
            end
            8'b00000100:
            begin
                if ((Step <= 10'd2) && (DrawY <= Ball_Y_Pos)) 
                begin
                    is_ball = 1'b1;
                end
            end
            8'b00001000:
            begin
                if ((Step <= 10'd4) && ((DistX + DistY) <= 0)) 
                begin
                    is_ball = 1'b1;
                end
            end
            8'b00010000:
            begin
                if ((Step <= 10'd2) && (DrawX <= Ball_X_Pos)) 
                begin
                    is_ball = 1'b1;
                end
            end
            8'b00100000:
            begin
                if ((Step <= 10'd4) && (DistX >= DistY)) 
                begin
                    is_ball = 1'b1;
                end
            end
            8'b01000000:
            begin
                if ((Step <= 10'd2) && (DrawY >= Ball_Y_Pos)) 
                begin
                    is_ball = 1'b1;
                end
            end
            8'b10000000:
            begin
                if ((Step <= 10'd4) && ((DistX + DistY) >= 0)) 
                begin
                    is_ball = 1'b1;
                end
            end
            default: is_ball = 1'b0;
        endcase
    end
    
endmodule
