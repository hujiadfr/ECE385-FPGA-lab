module ship_controller (
    input Clk,      // 50 MHz clock
    input Reset
    input [4:0]     command,
    output [9:0]    step_x, step_y,
    output [9:0]    speed,
    output [3:0]    direction
);
    /* 
        If we update the position of ships and shells at least one pixel every time frame_clk @ rasing edge, 
        many problem will occure. So, we may wish to assign velocity in float. However, System Verliog don't
        have float type variable directly.

        To do this, we can store the velocity in interger, but divide by 10 or so in calculation.

        Maybe there are some better way to do this
    */
    parameter [9:0] Ship_Velocity_Forward = 10'd02;       // Maximun velocity forward
    // parameter [9:0] Ship_Velocity_Backward = 10'd01;      // Maximun velocity backward

    logic [9:0] step_x_out, step_y_out;
    logic [3:0] direction_out;
    logic [9:0] ship_velocity;
    logic [7:0] ship_angle;         // {7/8pi, 3/4pi, 5/8pi, pi, 3/8pi, 1/2pi, 1/4pi, 0}
    logic [27:0] count;


    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            ship_velocity = 'd0;
            ship_angle = 8'b00000000;      // TODO change this when 2 ship
            count = 1'b0;
        end
    end

    logic [9:0] ship_velocity_in;
    logic [9:0] ship_angle_in;
    always_comb begin

    end
endmodule