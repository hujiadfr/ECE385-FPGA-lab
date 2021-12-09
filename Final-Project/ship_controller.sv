module ship_controller (
    input Clk,      // 50 MHz clock
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
    parameter [9:0] Ship_Velocity_Forward = 10'd40;       // Maximun velocity forward
    parameter [9:0] Ship_Velocity_Backward = 10'd20;      // Maximun velocity backward
    parameter [9:0] Ship_Velocity_Angle = 10'd15;         // Angular velocity in degrees

    logic [9:0] step_x_out, step_y_out;
    logic [3:0] direction_out;
    logic [9:0] ship_velocity, ship_angle;
    logic [27:0] count;
    initial begin
        ship_velocity = 4'd0;
        ship_angle = 4'd0;
        count = 1'b0;
    end

    always_ff @ (posedge Clk)
    begin
        if(count >= 28'd12500000) // 50*10^6 / 4 = 1/4 of a second wait time before
        begin
            count <= count;
            step_x <= step_x_out;
            step_y <= step_y_out;
            direction <= direction_out;
        end
        else
        begin
            count <= count + 1;
        end
    end

    logic [9:0] ship_velocity_in;
    logic [9:0] ship_angle_in;
    always_comb begin

    end
endmodule