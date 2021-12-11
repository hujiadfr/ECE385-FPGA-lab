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
               input [9:0]   Ball_X_Step, Ball_YBall_Y_Step,      // step size
               input [3:0]   Direction,          // {up, down, left, right}
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
    parameter [9:0] Ball_Size = 10'd4;        // Ball size
//------------------------------------------------------------------------------
    logic [9:0] Ball_X_Step, Ball_Y_Step;
    // logic [9:0] Ball_X_Step = step_x*speed;      // Step size on the X axis
    // logic [9:0] Ball_Y_Step = step_y*speed;      // Step size on the Y axis
//------------------------------------------------------------------------------

    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
    
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
            Ball_Y_Motion <= Ball_Y_Step;
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
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        Ball_X_Pos_in = Ball_X_Pos;
        Ball_Y_Pos_in = Ball_Y_Pos;
        Ball_X_Motion_in = Ball_X_Motion;
        Ball_Y_Motion_in = Ball_Y_Motion;
        
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
			//--------------------------------------------------------
            if (Direction[3] && Direction[2]) begin 
            end
            else if (Direction [3]) begin // up
                Ball_Y_Motion_in = Ball_Y_Step;
            end
            else begin  // if (Direction [2]) // down
                Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1');
            end

            if (Direction[1] && Direction[0]) begin 
            end
            else if (Direction [0]) begin // right
                Ball_X_Motion_in = Ball_X_Step;
            end
            else begin  // if (Direction [1]) // left
                Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1');
            end
            /* case(direction)
					// quadrant 1, positive x, negative y
					4b'0001: begin
								Ball_X_Motion_in = Ball_X_Step;
								Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1');
							end
							
					// quadrant 2, negative x, negative y
					4b'0010: begin
								Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1');
								Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1');
							end
					
					// quadrant 3, negative x, positive y
					4b'0100: begin
								Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1');
								Ball_Y_Motion_in = Ball_Y_Step;
							end
					
					// quadrant 4, positive x, positive y
					4b'1000: begin
								Ball_X_Motion_in = ball_X_Step;
								Ball_Y_Motion_in = Ball_Y_Step;
							end
							
					// default does nothing
					default:
						begin
						end
				endcase */
			//--------------------------------------------------------

            // Be careful when using comparators with "logic" datatype because compiler treats both sides of the operator as UNSIGNED numbers.
            // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
            // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.

//------------------------------------------------------------------------------------------------------------------------
            // TODO: stop the ball when hit the boundary for ship design.
            // clear the velocity, can move backward instead of sticked there.
            if( Ball_Y_Pos + Ball_Size >= Ball_Y_Max )  // Ball is at the bottom edge, STOP!
                Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
            else if ( Ball_Y_Pos <= Ball_Y_Min + Ball_Size )  // Ball is at the top edge, STOP!
                Ball_Y_Motion_in = Ball_Y_Step;
            // TODO: Add other boundary detections and handle keypress here.
				if( Ball_X_Pos + Ball_Size >= Ball_X_Max)
					 Ball_X_Motion_in = (~(Ball_Y_Step) + 1'b1);
				else if (Ball_X_Pos <= Ball_X_Min + Ball_Size)
					 Ball_X_Motion_in = Ball_Y_Step;
//------------------------------------------------------------------------------------------------------------------------	

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
