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
    logic [7:0] keycode_0, keycode_1, keycode_2, keycode_3, keycode_4, keycode_5, keycode_6, keycode_7;
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
        .keycode_1_export(keycode_1),  
        .keycode_2_export(keycode_2),
        .keycode_3_export(keycode_3),
        .keycode_4_export(keycode_4),  
        .keycode_5_export(keycode_5),

        .otg_hpi_address_export(hpi_addr),
        .otg_hpi_data_in_port(hpi_data_in),
        .otg_hpi_data_out_port(hpi_data_out),
        .otg_hpi_cs_export(hpi_cs),
        .otg_hpi_r_export(hpi_r),
        .otg_hpi_w_export(hpi_w),
        .otg_hpi_reset_export(hpi_reset)
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
    
    // wire [3:0] 	command_p1, command_p2; //{up, down, left, right}
    // keycode u_keycode(
    //     //ports
    //     .Clk       		( Clk       		),
    //     .keycode_0 		( keycode_0 		),
    //     .keycode_1 		( keycode_1 		),
    //     .keycode_2 		( keycode_2 		),
    //     .keycode_3 		( keycode_3 		),
    //     .keycode_4 		( keycode_4 		),
    //     .keycode_5 		( keycode_5 		),

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
    wire is_choose_state_data;
    wire [3:0] choose_state_data;
    choose_state #(
        .RESHAPE_LENGTH     ( 10'd80   		),
        .HALF_LENGTH        ( 10'd40        ))
    u_choose_state(
        .Clk       		        ( Clk       		),
        .DrawX     		        ( DrawX     		),
        .DrawY     		        ( DrawY     		),
        .choose_ship1           ( choose_ship1      ),
        .choose_ship2           ( choose_ship2      ),
        .ship1_choose_ready     ( ship1_choose_ready),
        .ship2_choose_ready     ( ship2_choose_ready),
        .is_choose_state_data   ( is_choose_state_data),
        .choose_state_data      ( choose_state_data   )
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
	
    wire is_ball1;
	wire is_ball2;
    wire [3:0] ball_data1;
	wire [3:0] ball_data2;
    Ship #(
        .RESHAPE_LENGTH     ( 10'd40   		))
    Ship_1(
        //ports
        .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( ship_x  	        ),
        .Ball_Y_Pos    	( ship_y   	        ),
        .ship_state     ( ship_state        ),
        .is_ball   		( is_ball1   		),
        .ball_data      ( ball_data1        )
    );
	 
	Ship2 #(
        .RESHAPE_LENGTH     ( 10'd40   		))
    Ship_2(
        //ports
        .Clk       		( Clk       		),
        .Reset     		( Reset_h     		),
        .frame_clk 		( VGA_VS     		),
        .DrawX     		( DrawX     		),
        .DrawY     		( DrawY     		),
        .Ball_X_Pos    	( ship2_x  	        ),
        .Ball_Y_Pos    	( ship2_y   	    ),
        .ship_state     ( ship2_state       ),
        .is_ball   		( is_ball2   		),
        .ball_data      ( ball_data2        )
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
        .is_choose_state_data   		( is_choose_state_data),
		.background_data(background_data),
        .ball_data1     ( ball_data1    ),
        .ball_data2     ( ball_data2    ),
        .choose_state_data   		( choose_state_data),
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
