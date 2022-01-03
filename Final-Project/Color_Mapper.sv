//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( 
                    input logic  Clk,                             //   or background (computed in ball.sv)
                    input logic  is_ball1,          // Whether current pixel belongs to ball
					input logic is_ball2,
                    input logic is_tor1_0,
                    input logic is_tor1_1,
                    input logic is_tor1_2,
                    input logic is_tor1_3,
                    input logic is_tor2_0,
                    input logic is_tor2_1,
                    input logic is_tor2_2,
                    input logic is_tor2_3,
                    
                    input logic is_bullet_1_0,
                    input logic is_bullet_1_1,
                    input logic is_bullet_1_2,
                    input logic is_bullet_1_3,
                    input logic is_bullet_1_4,
                    input logic is_bullet_1_5,
                    input logic is_bullet_1_6,
                    input logic is_bullet_1_7,
                    input logic is_bullet_1_8,
                    input logic is_bullet_1_9,
                    input logic is_bullet_2_0,
                    input logic is_bullet_2_1,
                    input logic is_bullet_2_2,
                    input logic is_bullet_2_3,
                    input logic is_bullet_2_4,
                    input logic is_bullet_2_5,
                    input logic is_bullet_2_6,
                    input logic is_bullet_2_7,
                    input logic is_bullet_2_8,
                    input logic is_bullet_2_9,

                    input  logic [3:0] torpedo1_0,
                    input  logic [3:0] torpedo1_1,
                    input  logic [3:0] torpedo1_2,
                    input  logic [3:0] torpedo1_3,
                    input  logic [3:0] torpedo2_0,
                    input  logic [3:0] torpedo2_1,
                    input  logic [3:0] torpedo2_2,
                    input  logic [3:0] torpedo2_3,

                    input logic [3:0] bullet_data1_0,
                    input logic [3:0] bullet_data1_1,
                    input logic [3:0] bullet_data1_2,
                    input logic [3:0] bullet_data1_3,
                    input logic [3:0] bullet_data1_4,
                    input logic [3:0] bullet_data1_5,
                    input logic [3:0] bullet_data1_6,
                    input logic [3:0] bullet_data1_7,
                    input logic [3:0] bullet_data1_8,
                    input logic [3:0] bullet_data1_9,
                    input logic [3:0] bullet_data2_0,
                    input logic [3:0] bullet_data2_1,
                    input logic [3:0] bullet_data2_2,
                    input logic [3:0] bullet_data2_3,
                    input logic [3:0] bullet_data2_4,
                    input logic [3:0] bullet_data2_5,
                    input logic [3:0] bullet_data2_6,
                    input logic [3:0] bullet_data2_7,
                    input logic [3:0] bullet_data2_8,
                    input logic [3:0] bullet_data2_9,

                    input logic [2:0] choose_ship1, choose_ship2,
                    input logic is_choose_state_data1,
                    input logic is_choose_state_data2,
                    input logic [3:0] background_data,
                    input logic [3:0] ball_data1,
                    input logic [3:0] ball_data2,
                    input logic [3:0] choose_state_data1,
                    input logic [3:0] choose_state_data2,
                    input logic [9:0] DrawX, DrawY,      // Current pixel coordinates
                    output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    logic [7:0] bg_data, code;
	logic [23:0] color, ship_color, weapon_color;
    logic is_weapon, is_ship, is_background;
    parameter [9:0] reshap_len = 10'd320;
    logic is_ball;
//    logic [23:0] background_palette [0:2];
    logic [23:0] background_palette [0:15];
    logic [23:0] bisimai_palette [0:15];
    logic [23:0] linbo_palette [0:15];
    logic [23:0] yingrui_palette [0:15];

    logic [23:0] weapen_palette [0:15];

    logic [23:0] ship1_color;
    logic [23:0] ship2_color;
    logic [23:0] background_color;
    logic [23:0] choose_state_color1;
    logic [23:0] choose_state_color2;

    
    logic [23:0] torpedo1_0_color;
    logic [23:0] torpedo1_1_color;
    logic [23:0] torpedo1_2_color;
    logic [23:0] torpedo1_3_color;
    logic [23:0] torpedo2_0_color;
    logic [23:0] torpedo2_1_color;
    logic [23:0] torpedo2_2_color;
    logic [23:0] torpedo2_3_color;
    assign background_palette = '{24'h0f4792,24'h3577cd,24'h4fc3fc,24'h4586d9,24'h033477,24'h4176bb,24'h4faafb,24'h043578,24'h4b93ed,24'hfff78f,24'h505050,24'h535c74,24'hdfc5ae,24'h9ea7af,24'h000000,24'hffffff};
    // assign background_palette = '{24'h3FB9E9,24'h0AA5E8,24'h04A3E8,24'h3FB9E9,24'h0AA5E8,24'h04A3E8,24'h3FB9E9,24'h0AA5E8,24'h04A3E8,24'h3FB9E9,24'h0AA5E8,24'h04A3E8,24'h3FB9E9,24'h0AA5E8,24'h04A3E8,24'h3FB9E9};
    assign bisimai_palette = '{24'h808080,24'hf3f1f3,24'h201c18,24'hfffbef,24'h3b3b3b,24'h54657b,24'haa3e49,24'h767778,24'hbe3647,24'hfff78f,24'h505050,24'h535c74,24'hdfc5ae,24'h9ea7af,24'h000000,24'hffffff};
    assign linbo_palette =  '{24'hf9f1e9,24'hc25f4f,24'h686554,24'hd7c1b2,24'h455273,24'hffd1c0,24'hf19a3e,24'h362e3e,24'h8594a5,24'hf4f0e8,24'h505050,24'h535c74,24'h808080,24'h9ea7af,24'h000000,24'hffffff};
    assign yingrui_palette = '{24'h695871,24'h808080,24'hefe7e7,24'h694a82,24'h4d5ea2,24'ha5a3a2,24'hfed9d2,24'h9e7d64,24'h474757,24'h6f4d90,24'h544058,24'h322a4c,24'heee7e7,24'h9ea7af,24'h000000,24'hffffff};
    assign weapen_palette = '{24'h808080,24'hffffff,24'h3c3c3e,24'h686a70,24'he27a55,24'hffd778,24'hba160d,24'hffffe1,24'hca2d27,24'he9a16c,24'h505050,24'h535c74,24'hdfc5ae,24'h9ea7af,24'h000000,24'hfb2901};

    assign background_color = background_palette[background_data];

    assign    torpedo1_0_color = weapen_palette[torpedo1_0];
    assign    torpedo1_1_color = weapen_palette[torpedo1_1];
    assign    torpedo1_2_color = weapen_palette[torpedo1_2];
    assign    torpedo1_3_color = weapen_palette[torpedo1_3];
    assign    torpedo2_0_color = weapen_palette[torpedo2_0];
    assign    torpedo2_1_color = weapen_palette[torpedo2_1];
    assign    torpedo2_2_color = weapen_palette[torpedo2_2];
    assign    torpedo2_3_color = weapen_palette[torpedo2_3];

    logic [23:0] bullet1_0_color;
    logic [23:0] bullet1_1_color;
    logic [23:0] bullet1_2_color;
    logic [23:0] bullet1_3_color;
    logic [23:0] bullet1_4_color;
    logic [23:0] bullet1_5_color;
    logic [23:0] bullet1_6_color;
    logic [23:0] bullet1_7_color;
    logic [23:0] bullet1_8_color;
    logic [23:0] bullet1_9_color;
    logic [23:0] bullet2_0_color;
    logic [23:0] bullet2_1_color;
    logic [23:0] bullet2_2_color;
    logic [23:0] bullet2_3_color;
    logic [23:0] bullet2_4_color;
    logic [23:0] bullet2_5_color;
    logic [23:0] bullet2_6_color;
    logic [23:0] bullet2_7_color;
    logic [23:0] bullet2_8_color;
    logic [23:0] bullet2_9_color;

    assign    bullet1_0_color = weapen_palette[bullet_data1_0];
    assign    bullet1_1_color = weapen_palette[bullet_data1_1];
    assign    bullet1_2_color = weapen_palette[bullet_data1_2];
    assign    bullet1_3_color = weapen_palette[bullet_data1_3];
    assign    bullet1_4_color = weapen_palette[bullet_data1_4];
    assign    bullet1_5_color = weapen_palette[bullet_data1_5];
    assign    bullet1_6_color = weapen_palette[bullet_data1_6];
    assign    bullet1_7_color = weapen_palette[bullet_data1_7];
    assign    bullet1_8_color = weapen_palette[bullet_data1_8];
    assign    bullet1_9_color = weapen_palette[bullet_data1_9];
    assign    bullet2_0_color = weapen_palette[bullet_data2_0];
    assign    bullet2_1_color = weapen_palette[bullet_data2_1];
    assign    bullet2_2_color = weapen_palette[bullet_data2_2];
    assign    bullet2_3_color = weapen_palette[bullet_data2_3];
    assign    bullet2_4_color = weapen_palette[bullet_data2_4];
    assign    bullet2_5_color = weapen_palette[bullet_data2_5];
    assign    bullet2_6_color = weapen_palette[bullet_data2_6];
    assign    bullet2_7_color = weapen_palette[bullet_data2_7];
    assign    bullet2_8_color = weapen_palette[bullet_data2_8];
    assign    bullet2_9_color = weapen_palette[bullet_data2_9];
    // Output colors to VGA
    
    // assign is_ball = is_ball1 || is_ball2;
    assign VGA_R = color[23:16];
    assign VGA_G = color[15:8];
    assign VGA_B = color[7:0];
    // Assign color based on is_ball signal
    always_comb
    begin
        case(choose_ship1)
            6'd0: begin   
                choose_state_color1 = bisimai_palette[choose_state_data1];
                ship1_color = bisimai_palette[ball_data1];
            end
            6'd1:  begin
                choose_state_color1 = linbo_palette[choose_state_data1];
                ship1_color = linbo_palette[ball_data1];
            end 
            6'd2:   begin
                choose_state_color1 = yingrui_palette[choose_state_data1];
                ship1_color = yingrui_palette[ball_data1];
            end 
            default:   begin   
                choose_state_color1 = bisimai_palette[choose_state_data1];
                ship1_color = bisimai_palette[ball_data1];
            end
        endcase

        case(choose_ship2)
            6'd0: begin   
                choose_state_color2 = bisimai_palette[choose_state_data2];
                ship2_color = bisimai_palette[ball_data2];
            end
            6'd1:  begin
                choose_state_color2 = linbo_palette[choose_state_data2];
                ship2_color = linbo_palette[ball_data2];
            end 
            6'd2:   begin
                choose_state_color2 = yingrui_palette[choose_state_data2];
                ship2_color = yingrui_palette[ball_data2];
            end 
            default:   begin   
                choose_state_color2 = bisimai_palette[choose_state_data2];
                ship2_color = bisimai_palette[ball_data2];
            end
        endcase
        

        // color = weapen_palette[torpedo1_0];
        is_weapon = 1'b0; 
        is_ship = 1'b0; 
        is_background = 1'b1;
        ship_color = background_color;
        weapon_color = background_color;
		color = background_color;

        if (is_choose_state_data1 || is_choose_state_data2) begin
        is_weapon = 1'b0; 
        is_ship = 1'b1; 
        is_background = 1'b0;
            if (is_choose_state_data1 == 1'b1) begin
                if(choose_state_color1 == 24'h808080)
                        ship_color = background_color;
                else
                    ship_color = choose_state_color1;
            end
            else if (is_choose_state_data2 == 1'b1) begin
                if(choose_state_color2 == 24'h808080)
                        ship_color = background_color;
                else
                    ship_color = choose_state_color2;
            end
        end
        // else if (is_ball1 == 1'b1) 
        else if (is_ball1 || is_ball2) begin
        is_weapon = 1'b0; 
        is_ship = 1'b1; 
        is_background = 1'b0;
            if (is_ball1 == 1'b1) 
            begin
                if(ship1_color == 24'h808080) begin
                    if (is_ball2 == 1'b1 && ship2_color != 24'h808080)
                        ship_color = ship2_color;
                    else 
                        ship_color = background_color;
                end
                else
                    ship_color = ship1_color;
            end
            else if (is_ball2 == 1'b1)
            begin
                if(ship2_color == 24'h808080)
                    ship_color = background_color;
                else
                    ship_color = ship2_color;
            end
        end


        if(is_tor1_0 == 1'b1 || is_tor1_1 == 1'b1 || is_tor1_2 == 1'b1 || is_tor1_3 == 1'b1) begin
            is_weapon = 1'b1; 
            is_ship = 1'b0; 
            is_background = 1'b0;
            if (is_tor1_0) begin
                if (torpedo1_0_color == 24'hFFFFFF) begin
                    weapon_color = background_color;
                end
                else
                    weapon_color = torpedo1_0_color;
            end
            else if (is_tor1_1) begin
                if (torpedo1_1_color == 24'hFFFFFF) begin
                    weapon_color = background_color;
                end
                else
                    weapon_color = torpedo1_1_color;
            end
            else if (is_tor1_2) begin
                if (torpedo1_2_color == 24'hFFFFFF) begin
                    weapon_color = background_color;
                end
                else
                    weapon_color = torpedo1_2_color;
            end
            else if (is_tor1_3) begin
                if (torpedo1_3_color == 24'hFFFFFF) begin
                    weapon_color = background_color;
                end
                else
                    weapon_color = torpedo1_3_color;
            end
        end
        else if(is_tor2_0 == 1'b1 || is_tor2_1 == 1'b1 || is_tor2_2 == 1'b1 || is_tor2_3 == 1'b1) begin
            is_weapon = 1'b1; 
            is_ship = 1'b0; 
            is_background = 1'b0;
            if (is_tor2_0) begin
                if (torpedo2_0_color == 24'hFFFFFF) begin
                    weapon_color = background_color;
                end
                else
                    weapon_color = torpedo2_0_color;
            end
            else if (is_tor2_1) begin
                if (torpedo2_1_color == 24'hFFFFFF) begin
                    weapon_color = background_color;
                end
                else
                    weapon_color = torpedo2_1_color;
            end
            else if (is_tor2_2) begin
                if (torpedo2_2_color == 24'hFFFFFF) begin
                    weapon_color = background_color;
                end
                else
                    weapon_color = torpedo2_2_color;
            end
            else if (is_tor2_3) begin
                if (torpedo2_3_color == 24'hFFFFFF) begin
                    weapon_color = background_color;
                end
                else
                    weapon_color = torpedo2_3_color;
            end
        end
        else if (is_bullet_2_0 == 1'b1 || is_bullet_2_1 == 1'b1 || is_bullet_2_2 == 1'b1 || is_bullet_2_3 == 1'b1 || is_bullet_2_4 == 1'b1 || 
                 is_bullet_2_5 == 1'b1 || is_bullet_2_6 == 1'b1 || is_bullet_2_7 == 1'b1 || is_bullet_2_8 == 1'b1 || is_bullet_2_9 == 1'b1)
            begin
        is_weapon = 1'b1; 
        is_ship = 1'b0; 
        is_background = 1'b0;
                if (is_bullet_2_0) begin
                    if (bullet2_0_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet2_0_color;
                end
                else if (is_bullet_2_1) begin
                    if (bullet2_1_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet2_1_color;
                end
                else if (is_bullet_2_2) begin
                    if (bullet2_2_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet2_2_color;
                end
                else if (is_bullet_2_3) begin
                    if (bullet2_3_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet2_3_color;
                end
                else if (is_bullet_2_4) begin
                    if (bullet2_3_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet2_4_color;
                end

                if (is_bullet_2_5) begin
                    if (bullet2_5_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet2_5_color;
                end
                else if (is_bullet_2_6) begin
                    if (bullet2_6_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet2_6_color;
                end
                else if (is_bullet_2_7) begin
                    if (bullet2_7_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet2_7_color;
                end
                else if (is_bullet_2_8) begin
                    if (bullet2_8_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet2_8_color;
                end
                else if (is_bullet_2_9) begin
                    if (bullet2_9_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet2_9_color;
                end
             end
        
        else if (is_bullet_1_0 == 1'b1 || is_bullet_1_1 == 1'b1 || is_bullet_1_2 == 1'b1 || is_bullet_1_3 == 1'b1 || is_bullet_1_4 == 1'b1 || 
                 is_bullet_1_5 == 1'b1 || is_bullet_1_6 == 1'b1 || is_bullet_1_7 == 1'b1 || is_bullet_1_8 == 1'b1 || is_bullet_1_9 == 1'b1)
            begin
        is_weapon = 1'b1; 
        is_ship = 1'b0; 
        is_background = 1'b0;
                if (is_bullet_1_0) begin
                    if (bullet1_0_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet1_0_color;
                end
                else if (is_bullet_1_1) begin
                    if (bullet1_1_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet1_1_color;
                end
                else if (is_bullet_1_2) begin
                    if (bullet1_2_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet1_2_color;
                end
                else if (is_bullet_1_3) begin
                    if (bullet1_3_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet1_3_color;
                end
                else if (is_bullet_1_4) begin
                    if (bullet1_3_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet1_4_color;
                end

                if (is_bullet_1_5) begin
                    if (bullet1_5_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet1_5_color;
                end
                else if (is_bullet_1_6) begin
                    if (bullet1_6_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet1_6_color;
                end
                else if (is_bullet_1_7) begin
                    if (bullet1_7_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet1_7_color;
                end
                else if (is_bullet_1_8) begin
                    if (bullet1_8_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet1_8_color;
                end
                else if (is_bullet_1_9) begin
                    if (bullet1_9_color == 24'hFFFFFF) begin
                        weapon_color = background_color;
                    end
                    else
                        weapon_color = bullet1_9_color;
                end
             end
        else begin
            color = background_color;
        end      

        if (is_ship == 1'b1) begin
            color = ship_color;
        end  
        else if (is_weapon == 1'b1) begin
            color = weapon_color;
        end
        else begin
            color = background_color;
        end
    end 
endmodule
