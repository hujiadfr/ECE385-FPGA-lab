module  torpedo ( input         Clk,                // 50 MHz clock
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
    parameter [9:0] RESHAPE_LENGTH = 10'd40;
    parameter [9:0] HALF_LENGTH = 10'd20;
    parameter [9:0] HALF_HEIGHT = 10'd10;
//--------------------------------------------------------------------  
    assign read_address = (DrawX-Ball_X_Pos) + HALF_LENGTH + (DrawY-Ball_Y_Pos+HALF_HEIGHT-1)*RESHAPE_LENGTH;

    int DistX, DistY;
    assign DistX = DrawX - Ball_X_Pos;
    assign DistY = DrawY - Ball_Y_Pos;

    always_comb begin
        if ( (DrawX - Ball_X_Pos <= HALF_LENGTH || Ball_X_Pos-DrawX <= HALF_LENGTH) && (DrawY - Ball_Y_Pos <= HALF_HEIGHT || Ball_Y_Pos-DrawY <= HALF_HEIGHT)) 
            is_ball = 1'b1;
        else
            is_ball = 1'b0;
        if(torpedo_stop == 10'd1 || game_start == 10'd0)
            is_ball = 1'b0;
    end
endmodule

module  torpedo_RAM   //bisimai 
(
    input Clk,
    input [18:0] read_address0, read_address1, read_address2, read_address3,
    output [3:0] data0, data1, data2, data3
);
    // mem has width of 4 bits and a total of 6399 addresses for pixels
    logic [3:0] mem0 [0:799];
    logic [3:0] mem1 [0:799];
    logic [3:0] mem2 [0:799];
    logic [3:0] mem3 [0:799];

    initial
    begin
        $readmemh("sources/yulei.txt", mem0);
        $readmemh("sources/yulei.txt", mem1);
        $readmemh("sources/yulei.txt", mem2);
        $readmemh("sources/yulei.txt", mem3);
    end
    always_ff@ (posedge Clk)
    begin
        data0 <= mem0[read_address0];
        data1 <= mem1[read_address1];
        data2 <= mem2[read_address2];
        data3 <= mem3[read_address3];
    end
endmodule

module  torpedo_left_RAM   //bisimai 
(
    input Clk,
    input [18:0] read_address0, read_address1, read_address2, read_address3,
    output [3:0] data0, data1, data2, data3
);
    // mem has width of 4 bits and a total of 6399 addresses for pixels
    logic [3:0] mem0 [0:799];
    logic [3:0] mem1 [0:799];
    logic [3:0] mem2 [0:799];
    logic [3:0] mem3 [0:799];

    initial
    begin
        $readmemh("sources/yulei_left.txt", mem0);
        $readmemh("sources/yulei_left.txt", mem1);
        $readmemh("sources/yulei_left.txt", mem2);
        $readmemh("sources/yulei_left.txt", mem3);
    end
    always_ff@ (posedge Clk)
    begin
        data0 <= mem0[read_address0];
        data1 <= mem1[read_address1];
        data2 <= mem2[read_address2];
        data3 <= mem3[read_address3];
    end
endmodule