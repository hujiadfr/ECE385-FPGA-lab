module  bullet ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
               input logic [9:0] Ball_X_Pos,
	           input logic [9:0] Ball_Y_Pos,
               input logic [9:0] torpedo_stop,
               output logic  is_ball,            // Whether current pixel belongs to ball or background
               output [3:0]  ball_data
              );

    //--------------------------------------------------------------------
    parameter [9:0] Ball_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 10'd240;  // Center position on the Y axis
	 parameter [9:0] Size = 10'd5;
//--------------------------------------------------------------------  

    int DistX, DistY;
    assign DistX = DrawX - Ball_X_Pos;
    assign DistY = DrawY - Ball_Y_Pos;

    always_comb begin
        if ( (DrawX - Ball_X_Pos <= Size || Ball_X_Pos-DrawX <= Size) && (DrawY - Ball_Y_Pos <= Size || Ball_Y_Pos-DrawY <= Size)) 
            is_ball = 1'b1;
        else
            is_ball = 1'b0;
        if(torpedo_stop == 10'd1)
            is_ball = 1'b0;
    end
endmodule