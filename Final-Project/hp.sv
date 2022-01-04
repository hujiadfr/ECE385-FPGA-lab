module hp (
    input logic [9:0] DrawX, DrawY,
    input logic [9:0] ship1_hp, ship2_hp,
    output logic is_hp
);
    parameter [9:0] height = 10'd10;
    parameter [9:0] Ball_X_Pos1 = 10'd100;
    parameter [9:0] Ball_Y_Pos1 = 10'd460;
    parameter [9:0] Ball_X_Pos2 = 10'd420;
    parameter [9:0] Ball_Y_Pos2 = 10'd460;

//    assign DistX1 = DrawX1 - Ball_X_Pos1;
//    assign DistY1 = DrawY1 - Ball_Y_Pos1;
//    assign DistX2 = DrawX2 - Ball_X_Pos1;
//    assign DistY2 = DrawY2 - Ball_Y_Pos1;

    always_comb begin
        is_hp = 1'b0;
        if(
            ((DrawX - Ball_X_Pos1) <= ship1_hp) && 
            ((DrawY - Ball_Y_Pos1) <= height)
        ) begin
            is_hp = 1'b1;
        end

        if(
            ((DrawX - Ball_X_Pos2) <= ship2_hp) && 
            ((DrawY - Ball_Y_Pos2) <= height)
        ) begin
            is_hp = 1'b1;
        end
    end
endmodule