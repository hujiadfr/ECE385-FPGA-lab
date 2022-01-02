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
	logic [23:0] color;
    parameter [9:0] reshap_len = 10'd320;
    logic is_ball;
//    logic [23:0] background_palette [0:2];
    logic [23:0] background_palette [0:15];
    logic [23:0] ship_palette [0:15];
    logic [23:0] ship1_color;
    logic [23:0] ship2_color;
    logic [23:0] background_color;
    logic [23:0] choose_state_color1;
    logic [23:0] choose_state_color2;

    assign background_palette = '{24'h3FB9E9,24'h0AA5E8,24'h04A3E8,24'h3FB9E9,
                            24'h0AA5E8,24'h04A3E8,24'h3FB9E9,
    24'h0AA5E8,24'h04A3E8,24'h3FB9E9,24'h0AA5E8,24'h04A3E8,
    24'h3FB9E9,24'h0AA5E8,24'h04A3E8,
    24'h3FB9E9};
    assign ship_palette = '{24'hFFF3DC,24'hCCC1D3,24'hAE3F4C,24'h9D834D,24'h020101,
    24'h00FF00,24'hF0CCAF,24'hFFFBEB,24'h766C96,24'hE3998A,24'h59667F,
    24'h535C74,24'hAB9B9E,24'hDFE5EB,24'h000000,24'hFFFFFF};
    assign background_color = background_palette[background_data];
    assign ship1_color = ship_palette[ball_data1];
    assign ship2_color = ship_palette[ball_data2];

    assign choose_state_color1 = ship_palette[choose_state_data1];
    assign choose_state_color2 = ship_palette[choose_state_data2];

    // Output colors to VGA
    
    // assign is_ball = is_ball1 || is_ball2;
    assign VGA_R = color[23:16];
    assign VGA_G = color[15:8];
    assign VGA_B = color[7:0];
    // Assign color based on is_ball signal
    always_comb
    begin
        if (is_choose_state_data1 == 1'b1) begin
            // if(choose_state_color1 == 24'h00FF00)
			// 		color = background_color;
            // else
                color = choose_state_color1;
        end
        else if (is_choose_state_data2 == 1'b1) begin
            // if(choose_state_color2 == 24'h00FF00)
			// 		color = background_color;
            // else
                color = choose_state_color2;
        end
        else if (is_ball1 == 1'b1) 
        begin
            if(ship1_color == 24'h00FF00)
					color = background_color;
            else
                color = ship1_color;
        end
        else if (is_ball2 == 1'b1)
        begin
            if(ship2_color == 24'h00FF00)
                color = background_color;
            else
                color = ship2_color;
         end
        else if(is_tor1_0 == 1'b1 || is_tor1_1 == 1'b1 || is_tor1_2 == 1'b1 || is_tor1_3 == 1'b1 || is_tor2_0 == 1'b1 || is_tor2_1 == 1'b1 || is_tor2_2 == 1'b1 || is_tor2_3 == 1'b1 )
                color = 24'hFFFBEB;
        else if (is_bullet_1_0 == 1'b1 || is_bullet_1_1 == 1'b1 || is_bullet_1_2 == 1'b1 || is_bullet_1_3 == 1'b1 || is_bullet_1_4 == 1'b1 || is_bullet_1_5 == 1'b1 || is_bullet_1_6 == 1'b1 || is_bullet_1_7 == 1'b1 ||is_bullet_1_8 == 1'b1 || is_bullet_1_9 == 1'b1)
                 color = 24'hFFFBEB;
        else if (is_bullet_2_0 == 1'b1 || is_bullet_2_1 == 1'b1 || is_bullet_2_2 == 1'b1 || is_bullet_2_3 == 1'b1 || is_bullet_2_4 == 1'b1 || is_bullet_2_5 == 1'b1 || is_bullet_2_6 == 1'b1 || is_bullet_2_7 == 1'b1 ||is_bullet_2_8 == 1'b1 || is_bullet_2_9 == 1'b1)
                 color = 24'hFFFBEB;
        else
        begin
            color = background_color;
        end        
    end 
endmodule
