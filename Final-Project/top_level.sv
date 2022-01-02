//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module top_level( 
            input 		 [18:0] SW,	          // only for test
            input               CLOCK_50,
            input        [3:0]  KEY,          //bit 0 is set up as Reset
            output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7, // output to HEX displayer
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
                                DRAM_CLK      //SDRAM Clock


                    );
    
    logic Reset_h, Clk;
    logic[9:0] DrawX, DrawY;
    
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end
    
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;
    logic [9:0] bullet_1_x_0;
    logic [9:0] bullet_1_x_1;
    logic [9:0] bullet_1_x_2;
    logic [9:0] bullet_1_x_3;
    logic [9:0] bullet_1_x_4;
    logic [9:0] bullet_1_x_5;
    logic [9:0] bullet_1_x_6;
    logic [9:0] bullet_1_x_7;
    logic [9:0] bullet_1_x_8;
    logic [9:0] bullet_1_x_9;
    logic [9:0] bullet_1_y_0;
    logic [9:0] bullet_1_y_1;
    logic [9:0] bullet_1_y_2;
    logic [9:0] bullet_1_y_3;
    logic [9:0] bullet_1_y_4;
    logic [9:0] bullet_1_y_5;
    logic [9:0] bullet_1_y_6;
    logic [9:0] bullet_1_y_7;
    logic [9:0] bullet_1_y_8;
    logic [9:0] bullet_1_y_9;
    logic [9:0] bullet_2_x_0;
    logic [9:0] bullet_2_x_1;
    logic [9:0] bullet_2_x_2;
    logic [9:0] bullet_2_x_3;
    logic [9:0] bullet_2_x_4;
    logic [9:0] bullet_2_x_5;
    logic [9:0] bullet_2_x_6;
    logic [9:0] bullet_2_x_7;
    logic [9:0] bullet_2_x_8;
    logic [9:0] bullet_2_x_9;
    logic [9:0] bullet_2_y_0;
    logic [9:0] bullet_2_y_1;
    logic [9:0] bullet_2_y_2;
    logic [9:0] bullet_2_y_3;
    logic [9:0] bullet_2_y_4;
    logic [9:0] bullet_2_y_5;
    logic [9:0] bullet_2_y_6;
    logic [9:0] bullet_2_y_7;
    logic [9:0] bullet_2_y_8;
    logic [9:0] bullet_2_y_9;
    logic [9:0] bullet_1_stop;
    logic [9:0] bullet_2_stop;
    // Interface between NIOS II and EZ-OTG chip
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
    logic [7:0] keycode_0;
    logic [2047:0] game_file;
     // You need to make sure that the port names here match the ports in Qsys-generated codes.
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
        
        .game_readdata(game_file),

        .keycode_0_export(keycode_0),                              

        .otg_hpi_address_export(hpi_addr),
        .otg_hpi_data_in_port(hpi_data_in),
        .otg_hpi_data_out_port(hpi_data_out),
        .otg_hpi_cs_export(hpi_cs),
        .otg_hpi_r_export(hpi_r),
        .otg_hpi_w_export(hpi_w),
        .otg_hpi_reset_export(hpi_reset),

        .bullet_1_x_0_export(bullet_1_x_0),
        .bullet_1_x_1_export(bullet_1_x_1),
        .bullet_1_x_2_export(bullet_1_x_2),
        .bullet_1_x_3_export(bullet_1_x_3),
        .bullet_1_x_4_export(bullet_1_x_4),
        .bullet_1_x_5_export(bullet_1_x_5),
        .bullet_1_x_6_export(bullet_1_x_6),
        .bullet_1_x_7_export(bullet_1_x_7),
        .bullet_1_x_8_export(bullet_1_x_8),
        .bullet_1_x_9_export(bullet_1_x_9),
        .bullet_1_y_0_export(bullet_1_y_0),
        .bullet_1_y_1_export(bullet_1_y_1),
        .bullet_1_y_2_export(bullet_1_y_2),
        .bullet_1_y_3_export(bullet_1_y_3),
        .bullet_1_y_4_export(bullet_1_y_4),
        .bullet_1_y_5_export(bullet_1_y_5),
        .bullet_1_y_6_export(bullet_1_y_6),
        .bullet_1_y_7_export(bullet_1_y_7),
        .bullet_1_y_8_export(bullet_1_y_8),
        .bullet_1_y_9_export(bullet_1_y_9),
        .bullet_2_x_0_export(bullet_2_x_0),
        .bullet_2_x_1_export(bullet_2_x_1),
        .bullet_2_x_2_export(bullet_2_x_2),
        .bullet_2_x_3_export(bullet_2_x_3),
        .bullet_2_x_4_export(bullet_2_x_4),
        .bullet_2_x_5_export(bullet_2_x_5),
        .bullet_2_x_6_export(bullet_2_x_6),
        .bullet_2_x_7_export(bullet_2_x_7),
        .bullet_2_x_8_export(bullet_2_x_8),
        .bullet_2_x_9_export(bullet_2_x_9),
        .bullet_2_y_0_export(bullet_2_y_0),
        .bullet_2_y_1_export(bullet_2_y_1),
        .bullet_2_y_2_export(bullet_2_y_2),
        .bullet_2_y_3_export(bullet_2_y_3),
        .bullet_2_y_4_export(bullet_2_y_4),
        .bullet_2_y_5_export(bullet_2_y_5),
        .bullet_2_y_6_export(bullet_2_y_6),
        .bullet_2_y_7_export(bullet_2_y_7),
        .bullet_2_y_8_export(bullet_2_y_8),
        .bullet_2_y_9_export(bullet_2_y_9)
    );
    
    // Use PLL to generate the 25MHZ VGA_CLK.
    // You will have to generate it on your own in simulation.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
    
    VGA_controller vga_controller_instance(
        .Clk(Clk),
        .Reset(Reset_h),
        .VGA_HS,
        .VGA_VS,
        .VGA_CLK,
        .VGA_BLANK_N,
        .VGA_SYNC_N,
        .DrawX,
        .DrawY
    );
    

    //     .command_p1   	( command_p1   		),
    //     .command_p2     ( command_p2        )
    // );

    // wire [9:0] 	Ship_X_Step;
    // wire       	Ship_Y_Step;
    // wire [7:0] 	Ship_Angle;
    // wire        forward;
    // ship_controller #(
    //     .Ship_Max_Velocity_Forward 		( 10'd01 		),
    //     .Ship_Angle_Default        		( 8'b00010000   ))
    // u_ship_controller(
    //     //ports
    //     .Clk         		( Clk         		),
    //     .Reset       		( Reset_h       	),
    //     .Command     		( command_p1     	),
    //     .Ship_X_Step 		( Ship_X_Step 		),
    //     .Ship_Y_Step 		( Ship_Y_Step 		),
    //     .Ship_Angle  		( Ship_Angle  		),
    //     .forward            ( forward           )
    // );
//----------------------------------------------------------------
    // choose ship state control
    wire [2:0] choose_ship1, choose_ship2;
	wire ship1_choose_ready, ship2_choose_ready;
    assign choose_ship1 = game_file[1922:1920];
    assign choose_ship2 = game_file[1954:1952];
    assign ship1_choose_ready = game_file[1984];
    assign ship2_choose_ready = game_file[2016];
    wire is_choose_state_data1, is_choose_state_data2;
    wire [3:0] choose_state_data1, choose_state_data2;
    choose_state u_choose_state(
        .Clk       		        ( Clk       		),
        .DrawX     		        ( DrawX     		),
        .DrawY     		        ( DrawY     		),
        .choose_ship1           ( choose_ship1      ),
        .choose_ship2           ( choose_ship2      ),
        .ship1_choose_ready     ( ship1_choose_ready),
        .ship2_choose_ready     ( ship2_choose_ready),
        .is_choose_state_data1  ( is_choose_state_data1),
        .is_choose_state_data2  ( is_choose_state_data2),
        .choose_state_data1     ( choose_state_data1   ),
        .choose_state_data2     ( choose_state_data2   )
    );
//----------------------------------------------------------------

	logic [9:0]ship_x,ship_y,ship2_x,ship2_y;
    assign ship_x = game_file[41:32];
	assign ship_y = game_file[73:64];
	
	assign ship2_x = game_file[265:256];
	assign ship2_y = game_file[297:288];

    logic [5:0] ship_state, ship2_state;
    assign ship_state = game_file[101:96];
    assign ship2_state = game_file[325:320];

// for test
    // assign ship2_state = ship_state;
    // shipFSM u_shipFSM(
    //     //ports
    //     .Clk        		( Clk        		),
    //     .Reset      		( Reset      		),
    //     .frame_clk  		( VGA_VS      		),
    //     .SW         		( SW         		),
    //     .ship_state 		( ship_state 		)
    // );
//
	
    logic [3:0] data1_1, data1_2, data1_3, data1_4, data1_5, data1_6, data1_7, data1_8, data1_9, data1_10, data1_11, data1_12, data1_13, data1_14, data1_15;
    logic [3:0] data2_1, data2_2, data2_3, data2_4, data2_5, data2_6, data2_7, data2_8, data2_9, data2_10, data2_11, data2_12, data2_13, data2_14, data2_15;

    wire is_ball1;
	wire is_ball2;
    wire [3:0] ball_data1;
	wire [3:0] ball_data2;
    wire [18:0] read_address1, read_address2; 
        logic [9:0] game_start;
    assign game_start = game_file[1417:1408];
    Ship Ship_1(
        //ports
        .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( ship_x  	        ),
        .Ball_Y_Pos    	( ship_y   	        ),
        .ship_state     ( ship_state        ),
        .choose_ship    ( choose_ship1      ),
        .is_ball   		( is_ball1   		),
        .read_address   ( read_address1     ),
        .ball_data      ( ball_data1        ),
        .game_start (game_start),
        .data1          ( data1_1           ),
        .data2          ( data1_2           ),
        .data3          ( data1_3           ),
        .data4          ( data1_4           ),
        .data5          ( data1_5           ),
        .data6          ( data1_6           ),
        .data7          ( data1_7           ),
        .data8          ( data1_8           ),
        .data9          ( data1_9           ),
        .data10         ( data1_10          ),
        .data11         ( data1_11          ),
        .data12         ( data1_12          ),
        .data13         ( data1_13          ),
        .data14         ( data1_14          ),
        .data15         ( data1_15          ),
    );
	
	Ship Ship_2(
        //ports
        .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( ship2_x  	        ),
        .Ball_Y_Pos    	( ship2_y   	    ),
        .ship_state     ( ship2_state       ),
        .choose_ship    ( choose_ship2      ),
        .is_ball   		( is_ball2   		),
        .read_address   ( read_address2     ),
        .ball_data      ( ball_data2        ),
         .game_start (game_start),
        .data1          ( data2_1           ),
        .data2          ( data2_2           ),
        .data3          ( data2_3           ),
        .data4          ( data2_4           ),
        .data5          ( data2_5           ),
        .data6          ( data2_6           ),
        .data7          ( data2_7           ),
        .data8          ( data2_8           ),
        .data9          ( data2_9           ),
        .data10         ( data2_10          ),
        .data11         ( data2_11          ),
        .data12         ( data2_12          ),
        .data13         ( data2_13          ),
        .data14         ( data2_14          ),
        .data15         ( data2_15          ),
    );

    ship_RAM u_ship_RAM(.*);
    ship_RAM2 u_ship_RAM2(.*);
    ship_RAM3 u_ship_RAM3(.*);

    logic [9:0] torpedo1_0_x, torpedo1_1_x, torpedo1_2_x, torpedo1_3_x, torpedo2_0_x, torpedo2_1_x, torpedo2_2_x, torpedo2_3_x;
    logic [9:0] torpedo1_0_y, torpedo1_1_y, torpedo1_2_y, torpedo1_3_y, torpedo2_0_y, torpedo2_1_y, torpedo2_2_y, torpedo2_3_y;
    logic [9:0] torpedo1_stop, torpedo2_stop;


    assign torpedo1_stop = game_file[1193:1184];
    assign torpedo2_stop = game_file[1225:1216];

    assign torpedo1_0_x = game_file[393:384];
    assign torpedo1_1_x = game_file[425:416];
    assign torpedo1_2_x = game_file[457:448];
    assign torpedo1_3_x = game_file[489:480];

    assign torpedo1_0_y = game_file[521:512];
    assign torpedo1_1_y = game_file[553:544];
    assign torpedo1_2_y = game_file[585:576];
    assign torpedo1_3_y = game_file[617:608];

    assign torpedo2_0_x = game_file[841:832];
    assign torpedo2_1_x = game_file[873:864];
    assign torpedo2_2_x = game_file[905:896];
    assign torpedo2_3_x = game_file[937:928];

    assign torpedo2_0_y = game_file[969:960];
    assign torpedo2_1_y = game_file[1001:992];
    assign torpedo2_2_y = game_file[1033:1024];
    assign torpedo2_3_y = game_file[1065:1056];
    
    assign bullet_1_stop = game_file[1449:1440];
    assign bullet_2_stop = game_file[1481:1472];


wire is_tor1_0;
    wire is_tor1_1;
    wire is_tor1_2;
    wire is_tor1_3;
    wire is_tor2_0;
    wire is_tor2_1;
    wire is_tor2_2;
    wire is_tor2_3;
    wire [3:0] torpedo1_0;
    wire [3:0] torpedo1_1;
    wire [3:0] torpedo1_2;
    wire [3:0] torpedo1_3;

    wire [3:0] torpedo2_0;
    wire [3:0] torpedo2_1;
    wire [3:0] torpedo2_2;
    wire [3:0] torpedo2_3;

    wire is_bullet_1_0;
    wire is_bullet_1_1;
    wire is_bullet_1_2;
    wire is_bullet_1_3;
    wire is_bullet_1_4;
    wire is_bullet_1_5;
    wire is_bullet_1_6;
    wire is_bullet_1_7;
    wire is_bullet_1_8;
    wire is_bullet_1_9;
    wire is_bullet_2_0;
    wire is_bullet_2_1;
    wire is_bullet_2_2;
    wire is_bullet_2_3;
    wire is_bullet_2_4;
    wire is_bullet_2_5;
    wire is_bullet_2_6;
    wire is_bullet_2_7;
    wire is_bullet_2_8;
    wire is_bullet_2_9;


torpedo 
torpedo0(
        .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( torpedo1_0_x  	      ),
        .Ball_Y_Pos    	( torpedo1_0_y  	   ),
        .game_start   (game_start),
        .torpedo_stop (torpedo1_stop),
        .is_ball   		( is_tor1_0   		),
        .ball_data      ( torpedo1_0        )
);
torpedo 
torpedo1(
        .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( torpedo1_1_x    ),
        .Ball_Y_Pos    	( torpedo1_1_y 	   ),
        .game_start   (game_start),
        .torpedo_stop (torpedo1_stop),
        .is_ball   		( is_tor1_1   		),
        .ball_data      ( torpedo1_1        )
);
torpedo
torpedo2(
        .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( torpedo1_2_x    ),
        .Ball_Y_Pos    	( torpedo1_2_y	   ),
        .game_start   (game_start),
        .torpedo_stop (torpedo1_stop),
        .is_ball   		( is_tor1_2   		),
        .ball_data      ( torpedo1_2        )
);
torpedo 
torpedo3(
        .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( torpedo1_3_x      ),
        .Ball_Y_Pos    	( torpedo1_3_y	   ),
        .game_start   (game_start),
        .torpedo_stop (torpedo1_stop),
        .is_ball   		( is_tor1_3   		),
        .ball_data      ( torpedo1_3        )
);
torpedo 
torpedo4(
        .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( torpedo2_0_x	      ),
        .Ball_Y_Pos    	( torpedo2_0_y	   ),
        .game_start   (game_start),
        .torpedo_stop (torpedo2_stop),
        .is_ball   		( is_tor2_0  		),
        .ball_data      ( torpedo2_0        )
);
torpedo 
torpedo5(
        .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( torpedo2_1_x	      ),
        .Ball_Y_Pos    	( torpedo2_1_y	   ),
        .game_start   (game_start),
        .torpedo_stop (torpedo2_stop),
        .is_ball   		( is_tor2_1  		),
        .ball_data      ( torpedo2_1        )
);
torpedo 
torpedo6(
        .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( torpedo2_2_x    ),
        .Ball_Y_Pos    	( torpedo2_2_y	   ),
        .game_start   (game_start),
        .torpedo_stop (torpedo2_stop),
        .is_ball   		( is_tor2_2   		),
        .ball_data      ( torpedo2_2        )
);
torpedo 
torpedo7(
        .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( torpedo2_3_x     ),
        .Ball_Y_Pos    	( torpedo2_3_y	   ),
        .game_start   (game_start),
        .torpedo_stop (torpedo2_stop),
        .is_ball   		( is_tor2_3  		),
        .ball_data      ( torpedo2_3        )
);

bullet
bullet1_0(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_1_x_0    ),
        .Ball_Y_Pos    	( bullet_1_y_0	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_1_stop),
        .is_ball   		( is_bullet_1_0  		),
);
bullet
bullet1_1(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_1_x_1    ),
        .Ball_Y_Pos    	( bullet_1_y_1	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_1_stop),
        .is_ball   		( is_bullet_1_1  		),
);
bullet
bullet1_2(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_1_x_2    ),
        .Ball_Y_Pos    	( bullet_1_y_2	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_1_stop),
        .is_ball   		( is_bullet_1_2  		),
);
bullet
bullet1_3(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_1_x_3    ),
        .Ball_Y_Pos    	( bullet_1_y_3	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_1_stop),
        .is_ball   		( is_bullet_1_3 		),
);
bullet
bullet1_4(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_1_x_4    ),
        .Ball_Y_Pos    	( bullet_1_y_4	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_1_stop),
        .is_ball   		( is_bullet_1_4 		),
);
bullet
bullet1_5(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_1_x_5    ),
        .Ball_Y_Pos    	( bullet_1_y_5	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_1_stop),
        .is_ball   		( is_bullet_1_5  		),
);
bullet
bullet1_6(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_1_x_6    ),
        .Ball_Y_Pos    	( bullet_1_y_6	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_1_stop),
        .is_ball   		( is_bullet_1_6 		),
);

bullet
bullet1_7(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_1_x_7    ),
        .Ball_Y_Pos    	( bullet_1_y_7	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_1_stop),
        .is_ball   		( is_bullet_1_7 		),
);
bullet
bullet1_8(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_1_x_8   ),
        .Ball_Y_Pos    	( bullet_1_y_8	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_1_stop),
        .is_ball   		( is_bullet_1_8 		),
);
bullet
bullet1_9(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_1_x_9    ),
        .Ball_Y_Pos    	( bullet_1_y_9	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_1_stop),
        .is_ball   		( is_bullet_1_9  		),
);

bullet
bullet2_0(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_2_x_0    ),
        .Ball_Y_Pos    	( bullet_2_y_0	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_2_stop),
        .is_ball   		( is_bullet_2_0  		),
);
bullet
bullet2_1(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_2_x_1    ),
        .Ball_Y_Pos    	( bullet_2_y_1	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_2_stop),
        .is_ball   		( is_bullet_2_1 		),
);
bullet
bullet2_2(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_2_x_2    ),
        .Ball_Y_Pos    	( bullet_2_y_2	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_2_stop),
        .is_ball   		( is_bullet_2_2  		),
);
bullet
bullet2_3(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_2_x_3    ),
        .Ball_Y_Pos    	( bullet_2_y_3	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_2_stop),
        .is_ball   		( is_bullet_2_3  		),
);
bullet
bullet2_4(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_2_x_4    ),
        .Ball_Y_Pos    	( bullet_2_y_4	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_2_stop),
        .is_ball   		( is_bullet_2_4  		),
);
bullet
bullet2_5(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_2_x_5    ),
        .Ball_Y_Pos    	( bullet_2_y_5	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_2_stop),
        .is_ball   		( is_bullet_2_5 		),
);
bullet
bullet2_6(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_2_x_6    ),
        .Ball_Y_Pos    	( bullet_2_y_6	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_2_stop),
        .is_ball   		( is_bullet_2_6  		),
);

bullet
bullet2_7(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_2_x_7    ),
        .Ball_Y_Pos    	( bullet_2_y_7	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_2_stop),
        .is_ball   		( is_bullet_2_7  		),
);
bullet
bullet2_8(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_2_x_8   ),
        .Ball_Y_Pos    	( bullet_2_y_8	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_2_stop),
        .is_ball   		( is_bullet_2_8  		),
);
bullet
bullet2_9(
         .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( bullet_2_x_9    ),
        .Ball_Y_Pos    	( bullet_2_y_9	   ),
        .game_start    (game_start),
        .torpedo_stop (bullet_2_stop),
        .is_ball   		( is_bullet_2_9 		),
);

    logic [3:0]background_data;
    background background(.Clk,
                        .DrawX,
                        .DrawY,
                        .background_data, ); 	

    color_mapper u_color_mapper(
        //ports
        .Clk            ( Clk           ),
        .is_ball1 		( is_ball1 		),
        .is_ball2 		( is_ball2 		),
        .is_tor1_0  (is_tor1_0),
        .is_tor1_1  (is_tor1_1),
        .is_tor1_2  (is_tor1_2),
        .is_tor1_3  (is_tor1_3),
        .is_tor2_0  (is_tor2_0),
        .is_tor2_1  (is_tor2_1),
        .is_tor2_2  (is_tor2_2),
        .is_tor2_3  (is_tor2_3),

        .is_bullet_1_0 ,
        .is_bullet_1_1 ,
        .is_bullet_1_2 ,
        .is_bullet_1_3 ,
        .is_bullet_1_4 ,
        .is_bullet_1_5 ,
        .is_bullet_1_6 ,
        .is_bullet_1_7 ,
        .is_bullet_1_8 ,
        .is_bullet_1_9 ,
        .is_bullet_2_0 ,
        .is_bullet_2_1 ,
        .is_bullet_2_2 ,
        .is_bullet_2_3 ,
        .is_bullet_2_4 ,
        .is_bullet_2_5 ,
        .is_bullet_2_6 ,
        .is_bullet_2_7 ,
        .is_bullet_2_8 ,
        .is_bullet_2_9 ,

        .choose_ship1, 
        .choose_ship2,
        .is_choose_state_data1  ( is_choose_state_data1),
        .is_choose_state_data2  ( is_choose_state_data2),
		.background_data(background_data),
        .ball_data1     ( ball_data1    ),
        .ball_data2     ( ball_data2    ),
        .choose_state_data1  ( choose_state_data1),
        .choose_state_data2  ( choose_state_data2),
        .DrawX   		( DrawX   		),
        .DrawY   		( DrawY   		),
        .VGA_R   		( VGA_R   		),
        .VGA_G   		( VGA_G   		),
        .VGA_B   		( VGA_B   		)
    );


    // Display keycode on hex display
//    HexDriver hex_inst_0 (DrawX[3:0], HEX0);
//    HexDriver hex_inst_1 (DrawX[7:4], HEX1);
		HexDriver hex_inst_0 (ship_x[3:0],HEX0);
		HexDriver hex_inst_1 (ship_x[7:4],HEX1);

endmodule
