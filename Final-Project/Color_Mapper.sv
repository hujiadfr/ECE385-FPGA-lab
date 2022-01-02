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
	logic [23:0] color;
    parameter [9:0] reshap_len = 10'd320;
    logic is_ball;
//    logic [23:0] background_palette [0:2];
    logic [23:0] background_palette [0:15];
    logic [23:0] bisimai_palette [0:15];
    logic [23:0] linbo_palette [0:15];
    logic [23:0] yingrui_palette [0:15];

    logic [23:0] ship1_color;
    logic [23:0] ship2_color;
    logic [23:0] background_color;
    logic [23:0] choose_state_color1;
    logic [23:0] choose_state_color2;

    assign background_palette = '{24'h3FB9E9,24'h0AA5E8,24'h04A3E8,24'h3FB9E9,24'h0AA5E8,24'h04A3E8,24'h3FB9E9,24'h0AA5E8,24'h04A3E8,24'h3FB9E9,24'h0AA5E8,24'h04A3E8,24'h3FB9E9,24'h0AA5E8,24'h04A3E8,24'h3FB9E9};

    assign bisimai_palette = '{24'h808080,24'hf3f1f3,24'h201c18,24'hfffbef,24'h3b3b3b,24'h54657b,24'haa3e49,24'h767778,24'hbe3647,24'hfff78f,24'h505050,24'h535c74,24'hdfc5ae,24'h9ea7af,24'h000000,24'hffffff};
    assign linbo_palette =  '{24'hf9f1e9,24'hc25f4f,24'h686554,24'hd7c1b2,24'h455273,24'hffd1c0,24'hf19a3e,24'h362e3e,24'h8594a5,24'hf4f0e8,24'h505050,24'h535c74,24'h808080,24'h9ea7af,24'h000000,24'hffffff};
    assign yingrui_palette = '{24'h695871,24'h808080,24'hefe7e7,24'h694a82,24'h4d5ea2,24'ha5a3a2,24'hfed9d2,24'h9e7d64,24'h474757,24'h6f4d90,24'h544058,24'h322a4c,24'heee7e7,24'h9ea7af,24'h000000,24'hffffff};

    assign background_color = background_palette[background_data];

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
            if(ship1_color == 24'h808080)
					color = background_color;
            else
                color = ship1_color;
        end
        else if (is_ball2 == 1'b1)
        begin
            if(ship2_color == 24'h808080)
                color = background_color;
            else
                color = ship2_color;
         end
        else if(is_tor1_0 == 1'b1 || is_tor1_1 == 1'b1 || is_tor1_2 == 1'b1 || is_tor1_3 == 1'b1 || is_tor2_0 == 1'b1 || is_tor2_1 == 1'b1 || is_tor2_2 == 1'b1 || is_tor2_3 == 1'b1 )
                color = 24'hFFFBEB;
        else
        begin
            color = background_color;
        end        
    end 
endmodule
