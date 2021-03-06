/* 
    12.9
        If we update the position of ships and shells at least one pixel every time frame_clk @ rasing edge, 
        many problem will occure. So, we may wish to assign velocity in float. However, System Verliog don't
        have float type variable directly.

        To do this, we can store the velocity in interger, but divide by 10 or so in calculation.

        Maybe there are some better way to do this
    12.11
        To simplify the problem, we just move the ship and shell in 8 directions around,
        i.e. for Ship_Velocity == 1, S the current position, * the possible next time position
            * *  *
            * S* *
            * *  *
*/
module ship_controller (
            input           Clk,                        // 50 MHz clock
            input           Reset,
            input  [4:0]    Command,                    // {up, down, left, right}
            output [9:0]    Ship_X_Step, Ship_Y_Step,   // output step of movenment
            output [7:0]    Ship_Angle,                 // oneshot code for angle, {7/8pi, 3/4pi, 5/8pi, pi, 3/8pi, 1/2pi, 1/4pi, 0}
            output          forward                     // 1 if ship is moving forward, 0 if ship is moving backward.
);
    parameter [9:0] Ship_Max_Velocity_Forward = 10'd02;   // Maximun velocity forward
    parameter [9:0] Ship_Max_Velocity_Backward = 10'd02;  // Maximun velocity backward
    parameter [7:0] Ship_Angle_Default = 8'b00000001;     // Default initial ship angle, TODO for different ship

    logic [9:0] Ship_Velocity;  // Store the current velocity of the ship
    logic [27:0] Count;         // Not always change ship position and movenment information, use this to count the clock number

    initial begin
        Ship_Velocity = 10'd0;
        Ship_Angle = Ship_Angle_Default;
        Ship_X_Step = 10'd0;
        Ship_Y_Step = 10'd0;
        forward = 1'b1;
        Count = 28'h0;
    end

    // Movenment Mechanism
    // 速度不为0，加速减速不改变Angle，只改变Step
        // left, Ship_Angle << 1， right, Ship_Angle >> 1.
    // 速度为0，down改变Angle << 4，up/left/right不改变Angle.
    // 注意overflow
    logic [9:0] Ship_X_Step_in, Ship_Y_Step_in;
    logic [7:0] Ship_Angle_in;  // {7/8pi, 3/4pi, 5/8pi, pi, 3/8pi, 1/2pi, 1/4pi, 0}
    logic [9:0] Ship_Velocity_in;
    logic       forward_in;

    always_comb // Calculate next time velocity and angle, also the Ship_X_Step_in and Ship_Y_Step_in.
    begin
        // Calculate next time velocity and angle
        // defult cases
        Ship_Velocity_in = Ship_Velocity;
        Ship_Angle_in = Ship_Angle;
        forward_in = forward;
        Ship_X_Step_in = Ship_Velocity_in;
        Ship_Y_Step_in = Ship_Velocity_in;

        if((Ship_Angle[2] == 1'b1)||(Ship_Angle[6] == 1'b1))
        begin
            Ship_X_Step_in = 10'd0;
        end
        else if((Ship_Angle[0] == 1'b1)||(Ship_Angle[4] == 1'b1))
        begin
            Ship_Y_Step_in = 10'd0;
        end
        
        if (Ship_Velocity == 10'd0) // 速度为0，down改变Angle << 4，up/left/right不改变Angle.
        begin
            Ship_X_Step_in = 10'd0;
            Ship_Y_Step_in = 10'd0;
            if (Command[3:2] == 2'b10)  // up
            begin
                Ship_Velocity_in = 1'd1;
                forward_in = 1'b1;
            end
            else if (Command[3:2] == 2'b01)   // down, add angle 180 degree, moving backward
            begin
                Ship_Velocity_in = 10'd1;
                forward_in = 1'b0;
                case(Ship_Angle)
                    8'b00010000: Ship_Angle_in = 8'b00000001;
                    8'b00100000: Ship_Angle_in = 8'b00000010;
                    8'b01000000: Ship_Angle_in = 8'b00000100;
                    8'b10000000: Ship_Angle_in = 8'b00001000;
                    default: Ship_Angle_in = Ship_Angle << 4;     // default Ship_Angle_in
                endcase
            end
        end

        else if (Ship_Velocity != 10'd0) // 速度不为0
        begin
            // Calculate next time Ship_X_Step_in and Ship_Y_Step_in
            // 运动是向周围的8个点运动
            // Ship_X_Step_in = 10'd1;
            // Ship_Y_Step_in = 10'd1;
            
            // 先执行转弯，再执行加减速
            if (forward == 1'b1)    // ship is moving forward
                // left, Ship_Angle << 1; right, Ship_Angle >> 1. 注意overflow.
                // change angle
                if (Command[1:0] == 2'b10)  // left, << 1
                begin
                    case(Ship_Angle)
                        8'b10000000: Ship_Angle_in = 8'b00000001;
                        default: Ship_Angle_in = Ship_Angle << 1;     // default Ship_Angle_in
                    endcase
                end
                else if (Command[1:0] == 2'b01) // right, >> 1
                begin
                    case(Ship_Angle)
                        8'b00000001: Ship_Angle_in = 8'b10000000;
                        default: Ship_Angle_in = Ship_Angle >> 1;     // default Ship_Angle_in
                    endcase
                end

                // change velocity
                if (Command[3:2] == 2'b10) // up
                begin
                    Ship_Velocity_in = Ship_Velocity + 1'd1;
                    if (Ship_Velocity == Ship_Max_Velocity_Forward)   // Reach Maximun Velocity
                    begin
                        Ship_Velocity_in = Ship_Velocity;
                        case(Ship_Angle)
                        8'b00010000: Ship_Angle_in = 8'b00000001;
                        8'b00100000: Ship_Angle_in = 8'b00000010;
                        8'b01000000: Ship_Angle_in = 8'b00000100;
                        8'b10000000: Ship_Angle_in = 8'b00001000;
                        default: Ship_Angle_in = Ship_Angle << 4;     // default Ship_Angle_in
                endcase
                    end
                end
                else if (Command[3:2] == 2'b01) // down
                begin
                    Ship_Velocity_in = Ship_Velocity + (~(10'd1)+1'd1);
                end
            end

            else if (forward == 1'b0)   // ship is moving backward
            begin
                // left, Ship_Angle >> 1; right, Ship_Angle << 1. 注意overflow.
                // change angle
                if (Command[1:0] == 2'b10)  // left, >> 1
                begin
                    case(Ship_Angle)
                        8'b00000001: Ship_Angle_in = 8'b10000000;
                        default: Ship_Angle_in = Ship_Angle >> 1;     // default Ship_Angle_in
                    endcase
                end
                else if (Command[1:0] == 2'b01) // right, << 1
                begin
                    case(Ship_Angle)
                        8'b10000000: Ship_Angle_in = 8'b00000001;
                        default: Ship_Angle_in = Ship_Angle << 1;     // default Ship_Angle_in
                    endcase
                end

                // change velocity
                if (Command[3:2] == 2'b10) // up
                begin
                    Ship_Velocity_in = Ship_Velocity + (~(10'd1)+1'd1);
                    if (Ship_Velocity == 10'd1) begin
                        forward_in = 1'b1;
                    end
                end
                else if (Command[3:2] == 2'b01) // down
                begin
                    Ship_Velocity_in = Ship_Velocity + 1'd1;
                    if (Ship_Velocity == Ship_Max_Velocity_Backward)   // Reach Maximun Velocity
                    begin
                        Ship_Velocity_in = Ship_Velocity;
                    end
                end
            end
//        end
	end
    
    always_ff @ (posedge Clk)   // update velocity abd angle in 4Hz
    begin
        if (Reset == 1'b1)
        begin
            Ship_Velocity = 10'd0;
            Ship_Angle = Ship_Angle_Default;
            forward = 1'b1;
            Count = 28'h0;
        end
        else if(Count >= 28'hbebc20) // 50*10^6 / 4 = 1/4 of a second wait time before
        // else if(Count >= 28'h17D7840) // 50*10^6 / 2 = 1/2 of a second wait time before
        // else if(Count >= 28'h840)
        // else
		  begin
            Count <= 28'h0;
            Ship_Velocity <= Ship_Velocity_in;
            Ship_Angle <= Ship_Angle_in;
            Ship_X_Step <= Ship_X_Step_in;
            Ship_Y_Step <= Ship_Y_Step_in;
            forward <= forward_in;
        end
        else
            Count <= Count + 1;
    end
endmodule