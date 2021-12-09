//TODO: use class to simplify the code
    // class class_ship;
    //     logic isShip;               // indicates weather the pixel belongs to background or ship
    //     logic [9:0] ship_x_pos,     // position of ship
    //                 ship_y_pos;
    //     logic Ship_Killed;          // ship killed by shell
        
    //     function new();             // constructor
            
    //     endfunction //new()
    // endclass //ship

    // class class_ball;
    //     logic isBall1;              // indicates weather the pixel belongs to background or ball
    //     logic [9:0] ball_x_pos,     // position of ball
    //                 ball_y_pos;
    //     logic ready, done;          //
    //     logic Ball_Killed;          // ball disappear when it kills/hit the ship

    //     function new();
            
    //     endfunction //new()
    // endclass //ball

//
module top_level (
    input               CLOCK_50,
    input       [3:0]   KEY,        //bit 0 is set up as Reset
    // VGA Interface
    output logic [7:0]  VGA_R,        //VGA Red
                        VGA_G,        //VGA Green
                        VGA_B,        //VGA Blue
    output logic        VGA_CLK,      //VGA Clock
                        VGA_SYNC_N,   //VGA Sync signal
                        VGA_BLANK_N,  //VGA Blank signal
                        VGA_VS,       //VGA virtical sync signal
                        VGA_HS,       //VGA horizontal sync signal
    // CY7C67200 Interface
    inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
    output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
    output logic        OTG_CS_N,     //CY7C67200 Chip Select
                        OTG_RD_N,     //CY7C67200 Write
                        OTG_WR_N,     //CY7C67200 Read
                        OTG_RST_N,    //CY7C67200 Reset
    input               OTG_INT,      //CY7C67200 Interrupt
    // SDRAM Interface for Nios II Software
    output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
    inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
    output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
    output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
    output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                        DRAM_CAS_N,   //SDRAM Column Address Strobe
                        DRAM_CKE,     //SDRAM Clock Enable
                        DRAM_WE_N,    //SDRAM Write Enable
                        DRAM_CS_N,    //SDRAM Chip Select
                        DRAM_CLK,     //SDRAM Clock

    // SRAM 
    output logic SRAM_CE_N, SRAM_UB_N, SRAM_LB_N, SRAM_OE_N, SRAM_WE_N,
    output logic [19:0] SRAM_ADDR,
    inout wire [15:0] SRAM_DQ,

    //LED for debugging
    output logic [3:0]  LEDG    // for now, show the value of Ball_Killed
);
    //------------------- Reset_h, Clk --------------------------------//
        logic Reset_h, Clk;
        assign Clk = CLOCK_50;
        always_ff @ (posedge Clk) begin
            Reset_h <= ~(KEY[0]);        // The push buttons are active low
        end

    //------------------- Read the key from keyboard ----------------------//
        // Interface between NIOS II and EZ-OTG chip
            logic [1:0] hpi_addr;
            logic [15:0] hpi_data_in, hpi_data_out;
            logic hpi_r, hpi_w, hpi_cs, hpi_reset;

            hpi_io_intf hpi_io_inst(
                    .Clk(Clk),
                    .Reset(Reset_h),
                    // signals connected to NIOS II
                    .from_sw_address(hpi_addr),
                    .from_sw_data_in(hpi_data_in),
                    .from_sw_data_out(hpi_data_out),
                    .from_sw_r(hpi_r),
                    .from_sw_w(hpi_w),
                    .from_sw_cs(hpi_cs),
                    .from_sw_reset(hpi_reset),
                    // signals connected to EZ-OTG chip
                    .OTG_DATA(OTG_DATA),
                    .OTG_ADDR(OTG_ADDR),
                    .OTG_RD_N(OTG_RD_N),
                    .OTG_WR_N(OTG_WR_N),
                    .OTG_CS_N(OTG_CS_N),
                    .OTG_RST_N(OTG_RST_N)
                    );

        // soc NIOS II system completed in platform designer
        /* You need to make sure that the port names here match the ports in Qsys-generated codes.
        Since we only use Nios II to read keyboard, only modify thekeycode_export number*/
    
        logic [7:0] keycode_0;   // Keyboard input, contain 2 key, each of 8-bit in Hex values
        logic [7:0] keycode_1;
        logic [7:0] keycode_2;
        //TODO module name to be modified for soc NIOS II system completed in platform designer
        final_soc nios_system(
                .clk_clk(Clk),
                .reset_reset_n(1'b1),    // Never reset NIOS
                .sdram_wire_addr(DRAM_ADDR),
                .sdram_wire_ba(DRAM_BA),
                .sdram_wire_cas_n(DRAM_CAS_N),
                .sdram_wire_cke(DRAM_CKE),
                .sdram_wire_cs_n(DRAM_CS_N),
                .sdram_wire_dq(DRAM_DQ),
                .sdram_wire_dqm(DRAM_DQM),
                .sdram_wire_ras_n(DRAM_RAS_N),
                .sdram_wire_we_n(DRAM_WE_N),
                .sdram_clk_clk(DRAM_CLK),

                //----- Modify this in platform designer ------//
                .keycode1_export(keycode_0),
                .keycode2_export(keycode_1),
                .keycode3_export(keycode_2),
                //-------------------END------------------------//

                .otg_hpi_address_export(hpi_addr),
                .otg_hpi_data_in_port(hpi_data_in),
                .otg_hpi_data_out_port(hpi_data_out),
                .otg_hpi_cs_export(hpi_cs),
                .otg_hpi_r_export(hpi_r),
                .otg_hpi_w_export(hpi_w),
                .otg_hpi_reset_export(hpi_reset)
            );
    //------------------- END Read the key from keyboard ------------------//

    //----------------------------- VGA -----------------------------------//
        // Use PLL to generate the 25MHZ VGA_CLK.
        // You will have to generate it on your own in simulation.
        logic [9:0] DRAWX, DRAWY;       // Current pixel coordinates
        vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
        VGA_controller vga_controller_instance(.Clk(Clk), .Reset(Reset_h),.*, .VGA_CLK(VGA_CLK), .DrawX(DRAWX), .DrawY(DRAWY));
    //--------------------------- END VGA ---------------------------------//

    //------------------- Instances and Controllers -----------------------//
        /*     
        In the code below, we need to:
            1. instance the ships, shells,
            2. interactions between ships, shells,
            3. appear and disappear of ships and shells. 
            4. draw them in DRAWX, DRAWY to show in screen.
        
        TODO: In the future, we may 
            1. add blocks for landfrom, which forbid ships and shell.
            2. use class to define some logic for ship and ball.
        */

    // define some logic below to do the interactions between ships and shell, appear and disappear of ships and shell.
    
    //---- Version 0.1, 1 ship, 4 shell ----//
    // logic parameters for ship, unfold to see details
        logic isShip1;              // indicates weather the pixel belongs to background or ship
        logic [9:0] ship_x_pos1,    // position of ship
                    ship_y_pos1;
        logic Ship_Killed1;         // is ship killed by shell?

    //TODO: logic [3:0] direction
    /*
        logic [1:0] direction: store the information of movenment
            direction[0]:   angle in radius. positive: left, negative: right
            direction[1]:   velocity
    */
    logic [3:0] direction;      // output of ball_controller

    // logic parameters for balls, unfold to see details
        // ball 1
        logic isBall1;              // indicates weather the pixel belongs to background or ball
        logic [9:0] ball_x_pos1,     // position of ball
                    ball_y_pos1;
        logic ready1, done1;        //
        logic Ball_Killed1;         // ball disappear when it kills/hit the ship

        // ball 2
        logic isBall2;
        logic [9:0] ball_x_pos2,
                    ball_y_pos2;
        logic ready2, done2;
        logic Ball_Killed2;

        // ball 3
        logic isBall3;
        logic [9:0] ball_x_pos3,
                    ball_y_pos3;
        logic ready3, done3;
        logic Ball_Killed3;

        // ball 2
        logic isBall4;
        logic [9:0] ball_x_pos4,
                    ball_y_pos4;
        logic ready4, done4;
        logic Ball_Killed4;
    //TODO: what select do?
    logic [3:0] ball_select;            // output from ballController
    assign ready1 = ball_select[0];
    assign ready2 = ball_select[1];
    assign ready3 = ball_select[2];
    assign ready4 = ball_select[3];
    
    // logic passed to Color_Mapper to draw ships, shells and all staffs,
    // also used for hit detections
    logic isShip;   // indicates weather the pixel belongs to background or ship
    logic isBall;   // indicates weather the pixel belongs to background or ball
    assign isShip = isShip1;    // for more than one ship, do || for all "isShip#" parameters. logical-or(||) //binary operator
    assign isBall = isBall1 || isBall2 || isBall3 || isBall4; // for more than one ball, do || for all "isBall#" parameters.

    // Hit Detection for each single ship
    assign Ship_Killed1 = isShip1 && isBall;

    ballController u_ballController(
        // input
        .Clk       		( Clk       		),
        .done1     		( done1     		),
        .done2     		( done2     		),
        .done3     		( done3     		),
        .done4     		( done4     		),
        .keycode_0 		( keycode_0 		),
        .keycode_1 		( keycode_1 		),
        .keycode_2 		( keycode_2 		),
        .keycode_3 		( keycode_3 		),
        // output
        .select    		( ball_select    	),
        .direction 		( direction 		)
    );
    
    // for debug
    assign LEDG[0] = Ball_Killed1;
    assign LEDG[1] = Ball_Killed2;
    assign LEDG[2] = Ball_Killed3;
    assign LEDG[4] = Ball_Killed4;
    // assign LEDG[3] = 1'b1;

    // ball produced by astro 1
    ball ball1(.Clk(Clk), 
                .Reset(Reset_h), 
                .frame_clk(VGA_VS), 
                .DrawX(DRAWX), 
                .DrawY(DRAWY), 
                .is_ball(isBall1), 
                .keycode(keycode), 
                .direction(direction),
                .astro_X_Pos(astro_x_pos), 
                .astro_Y_Pos(astro_y_pos), 
                .ball_X_Pos(ball1_x_pos), 
                .ball_Y_Pos(ball1_y_pos), 
                .ready_use(ready1), 
                .done_use(done1),
                .restart(restart), 
                .kill(kill1), 
                .gunboost_use(bulletboost_use));

    ball ball2(.Clk(Clk), .Reset(Reset_h), .frame_clk(VGA_VS), .DrawX(DRAWX), .DrawY(DRAWY), .is_ball(isBall2), .keycode(keycode), .direction(direction),
               .astro_X_Pos(astro_x_pos), .astro_Y_Pos(astro_y_pos), .ball_X_Pos(ball2_x_pos), .ball_Y_Pos(ball2_y_pos), .ready_use(ready2), .done_use(done2),
               .restart(restart), .kill(kill2), .gunboost_use(bulletboost_use));

    ball ball3(.Clk(Clk), .Reset(Reset_h), .frame_clk(VGA_VS), .DrawX(DRAWX), .DrawY(DRAWY), .is_ball(isBall3), .keycode(keycode), .direction(direction),
               .astro_X_Pos(astro_x_pos), .astro_Y_Pos(astro_y_pos), .ball_X_Pos(ball3_x_pos), .ball_Y_Pos(ball3_y_pos), .ready_use(ready3), .done_use(done3),
               .restart(restart), .kill(kill3), .gunboost_use(bulletboost_use));

    ball ball4(.Clk(Clk), .Reset(Reset_h), .frame_clk(VGA_VS), .DrawX(DRAWX), .DrawY(DRAWY), .is_ball(isBall4), .keycode(keycode), .direction(direction),
               .astro_X_Pos(astro_x_pos), .astro_Y_Pos(astro_y_pos), .ball_X_Pos(ball4_x_pos), .ball_Y_Pos(ball4_y_pos), .ready_use(ready4), .done_use(done4),
               .restart(restart), .kill(kill4), .gunboost_use(bulletboost_use));


    color_mapper_lab8 u_color_mapper_lab8(
        //ports
        .is_ball 		( is_ball 		),
        .DrawX   		( DrawX   		),
        .DrawY   		( DrawY   		),
        .VGA_R   		( VGA_R   		),
        .VGA_G   		( VGA_G   		),
        .VGA_B   		( VGA_B   		)
    );

    // color_mapper color_instance(
    //             .*, 
    //             .DrawX(DRAWX), 
    //             .DrawY(DRAWY), 
    //             .is_astro(isAstro), 
    //             .bg_data(bg_data), 
    //             .astro_data(astro_data),
    //             .astro2_data(astro2_data), 
    //             .is_astro2(isAstro2),
    //             .monster1_data(monster1_data), .monster2_data(monster2_data), .monster3_data(monster3_data), .monster4_data(monster4_data),
    //             .monster5_data(monster5_data), .monster6_data(monster6_data), .monster7_data(monster7_data), .monster8_data(monster8_data),
    //             .isBall(isBall), .isBall5(isBall5), .isBall6(isBall6),
    //             .is_monster1(isMonster1), .is_monster2(isMonster2), .is_monster3(isMonster3), .is_monster4(isMonster4),
    //             .is_monster5(isMonster5), .is_monster6(isMonster6), .is_monster7(isMonster7), .is_monster8(isMonster8),
    //             .in_game(in_game), .p2(p2),
    //             .is_speedboost(is_speedboost), 
    //             .speed_data(speed_data), 
    //             .dead_state(dead_state), 
    //             .dead_data(dead_data),
    //             .is_bulletboost(is_bulletboost), 
    //             .bullet_data(bullet_data), 
    //             .is_end(is_end)
    //             );

endmodule