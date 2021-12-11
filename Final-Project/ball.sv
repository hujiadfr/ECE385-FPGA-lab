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


module  ball ( input         Clk,                // 50 MHz clock
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
    // TODO change this when two ship
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
    always_ff @ (posedge Clk) begin
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
        BALL_Y_Motion_in = Step_Y;

        // Update position only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
            // Be careful when using comparators with "logic" datatype because compiler 
            // treats both sides of the operator as UNSIGNED numbers.
            // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
            // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, 
            // but rather a large positive number.
            if ((Angle[4]||Angle[5]||Angle[6]) == 1'b1) begin
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
                Ball_Y_Motion_in = (~(Step_Y) + 1'b1);          // 2's complement.  
            else if ( Ball_Y_Pos <= Ball_Y_Min + Ball_Size )    // Ball is at the top edge, STOP!
                Ball_Y_Motion_in = Step_Y;
                
            // Boundary for x
            if( Ball_X_Pos + Ball_Size >= Ball_X_Max)
                Ball_X_Motion_in = (~(Step_Y) + 1'b1);
            else if (Ball_X_Pos <= Ball_X_Min + Ball_Size)
                Ball_X_Motion_in = Step_Y;

            // Update the ball's position with its motion
            Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
            Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
        end
    end
    
    // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
    assign DistX = DrawX - Ball_X_Pos;
    assign DistY = DrawY - Ball_Y_Pos;
    assign Size = Ball_Size;
    always_comb begin
        if ( ( DistX*DistX + DistY*DistY) <= (Size*Size) ) 
            is_ball = 1'b1;
        else
            is_ball = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
    
endmodule
