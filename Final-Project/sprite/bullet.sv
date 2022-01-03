module  bullet ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
               input logic [9:0] Ball_X_Pos,
	           input logic [9:0] Ball_Y_Pos,
               input logic [9:0] game_start,
               input logic [9:0] torpedo_stop,
               output logic  is_ball,            // Whether current pixel belongs to ball or background
               output logic [18:0] read_address
              );

    //--------------------------------------------------------------------
    parameter [9:0] Ball_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 10'd240;  // Center position on the Y axis
	parameter [9:0] Size_y = 10'd5;
    parameter [9:0] Size_x = 10'd10;
    parameter [9:0] RESHAPE_LENGTH = 10'd20;
//--------------------------------------------------------------------  

    int DistX, DistY;
    assign DistX = DrawX - Ball_X_Pos;
    assign DistY = DrawY - Ball_Y_Pos;
    assign read_address = (DrawX-Ball_X_Pos) + Size_x + (DrawY-Ball_Y_Pos+Size_y)*RESHAPE_LENGTH;

    always_comb begin
        if ( (DrawX - Ball_X_Pos <= Size_x || Ball_X_Pos-DrawX <= Size_x) && (DrawY - Ball_Y_Pos <= Size_y || Ball_Y_Pos-DrawY <= Size_y)) 
            is_ball = 1'b1;
        else
            is_ball = 1'b0;
        if(game_start == 10'd0)
            is_ball = 1'b0;
    end
endmodule

module  bullet_RAM   
(
    input Clk,
    input [18:0] bullet_address1_0, bullet_address1_1, bullet_address1_2, bullet_address1_3, bullet_address1_4,
                 bullet_address1_5, bullet_address1_6, bullet_address1_7, bullet_address1_8, bullet_address1_9,
                 
    output [3:0] bullet_data1_0, bullet_data1_1, bullet_data1_2, bullet_data1_3, bullet_data1_4, bullet_data1_5, bullet_data1_6, bullet_data1_7, bullet_data1_8, bullet_data1_9
);
    // mem has width of 4 bits and a total of 6399 addresses for pixels
    logic [3:0] mem0 [0:199];
    logic [3:0] mem1 [0:199];
    logic [3:0] mem2 [0:199];
    logic [3:0] mem3 [0:199];
logic [3:0] mem4 [0:199];
    initial
    begin
        $readmemh("sources/paodan.png.txt", mem0);
        $readmemh("sources/paodan.png.txt", mem1);
        $readmemh("sources/paodan.png.txt", mem2);
        $readmemh("sources/paodan.png.txt", mem3);
        $readmemh("sources/paodan.png.txt", mem4);

    end
    always_ff@ (posedge Clk)
    begin
        bullet_data1_0 <= mem0[bullet_address1_0];
        bullet_data1_1 <= mem1[bullet_address1_1];
        bullet_data1_2 <= mem2[bullet_address1_2];
        bullet_data1_3 <= mem3[bullet_address1_3];
        bullet_data1_4 <= mem4[bullet_address1_4];
    end

    always_ff@ (posedge Clk)
    begin
        bullet_data1_5 <= mem0[bullet_address1_5];
        bullet_data1_6 <= mem1[bullet_address1_6];
        bullet_data1_7 <= mem2[bullet_address1_7];
        bullet_data1_8 <= mem3[bullet_address1_8];
        bullet_data1_9 <= mem4[bullet_address1_9];
    end
endmodule

module  bullet_left_RAM   
(
    input Clk,
    input [18:0] bullet_address2_0, bullet_address2_1, bullet_address2_2, bullet_address2_3, bullet_address2_4,
                 bullet_address2_5, bullet_address2_6, bullet_address2_7, bullet_address2_8, bullet_address2_9,
                 
    output [3:0] bullet_data2_0, bullet_data2_1, bullet_data2_2, bullet_data2_3, bullet_data2_4, bullet_data2_5, bullet_data2_6, bullet_data2_7, bullet_data2_8, bullet_data2_9
);
    // mem has width of 4 bits and a total of 6399 addresses for pixels
    logic [3:0] mem0 [0:199];
    logic [3:0] mem1 [0:199];
    logic [3:0] mem2 [0:199];
    logic [3:0] mem3 [0:199];
logic [3:0] mem4 [0:199];

    initial
    begin
        $readmemh("sources/paodan_left.png.txt", mem0);
        $readmemh("sources/paodan_left.png.txt", mem1);
        $readmemh("sources/paodan_left.png.txt", mem2);
        $readmemh("sources/paodan_left.png.txt", mem3);
        $readmemh("sources/paodan_left.png.txt", mem4);

    end
    always_ff@ (posedge Clk)
    begin
        bullet_data2_0 <= mem0[bullet_address2_0];
        bullet_data2_1 <= mem1[bullet_address2_1];
        bullet_data2_2 <= mem2[bullet_address2_2];
        bullet_data2_3 <= mem3[bullet_address2_3];
        bullet_data2_4 <= mem4[bullet_address2_4];
    end

    always_ff@ (posedge Clk)
    begin
        bullet_data2_5 <= mem0[bullet_address2_5];
        bullet_data2_6 <= mem1[bullet_address2_6];
        bullet_data2_7 <= mem2[bullet_address2_7];
        bullet_data2_8 <= mem3[bullet_address2_8];
        bullet_data2_9 <= mem4[bullet_address2_9];
    end
endmodule