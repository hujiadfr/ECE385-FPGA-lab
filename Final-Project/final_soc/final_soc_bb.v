
module final_soc (
	clk_clk,
	game_readdata,
	keycode_0_export,
	otg_hpi_address_export,
	otg_hpi_cs_export,
	otg_hpi_data_in_port,
	otg_hpi_data_out_port,
	otg_hpi_r_export,
	otg_hpi_reset_export,
	otg_hpi_w_export,
	reset_reset_n,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	bullet_1_x_0_export,
	bullet_1_x_1_export,
	bullet_1_x_2_export,
	bullet_1_x_3_export,
	bullet_1_x_4_export,
	bullet_1_x_5_export,
	bullet_1_x_6_export,
	bullet_1_x_7_export,
	bullet_1_x_8_export,
	bullet_1_x_9_export,
	bullet_1_y_0_export,
	bullet_1_y_1_export,
	bullet_1_y_2_export,
	bullet_1_y_3_export,
	bullet_1_y_4_export,
	bullet_1_y_5_export,
	bullet_1_y_6_export,
	bullet_1_y_7_export,
	bullet_1_y_8_export,
	bullet_1_y_9_export,
	bullet_2_x_0_export,
	bullet_2_x_1_export,
	bullet_2_x_2_export,
	bullet_2_x_3_export,
	bullet_2_x_4_export,
	bullet_2_x_5_export,
	bullet_2_x_6_export,
	bullet_2_x_7_export,
	bullet_2_x_8_export,
	bullet_2_x_9_export,
	bullet_2_y_0_export,
	bullet_2_y_1_export,
	bullet_2_y_2_export,
	bullet_2_y_3_export,
	bullet_2_y_4_export,
	bullet_2_y_5_export,
	bullet_2_y_6_export,
	bullet_2_y_7_export,
	bullet_2_y_8_export,
	bullet_2_y_9_export);	

	input		clk_clk;
	output	[2047:0]	game_readdata;
	output	[7:0]	keycode_0_export;
	output	[1:0]	otg_hpi_address_export;
	output		otg_hpi_cs_export;
	input	[15:0]	otg_hpi_data_in_port;
	output	[15:0]	otg_hpi_data_out_port;
	output		otg_hpi_r_export;
	output		otg_hpi_reset_export;
	output		otg_hpi_w_export;
	input		reset_reset_n;
	output		sdram_clk_clk;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	output	[9:0]	bullet_1_x_0_export;
	output	[9:0]	bullet_1_x_1_export;
	output	[9:0]	bullet_1_x_2_export;
	output	[9:0]	bullet_1_x_3_export;
	output	[9:0]	bullet_1_x_4_export;
	output	[9:0]	bullet_1_x_5_export;
	output	[9:0]	bullet_1_x_6_export;
	output	[9:0]	bullet_1_x_7_export;
	output	[9:0]	bullet_1_x_8_export;
	output	[9:0]	bullet_1_x_9_export;
	output	[9:0]	bullet_1_y_0_export;
	output	[9:0]	bullet_1_y_1_export;
	output	[9:0]	bullet_1_y_2_export;
	output	[9:0]	bullet_1_y_3_export;
	output	[9:0]	bullet_1_y_4_export;
	output	[9:0]	bullet_1_y_5_export;
	output	[9:0]	bullet_1_y_6_export;
	output	[9:0]	bullet_1_y_7_export;
	output	[9:0]	bullet_1_y_8_export;
	output	[9:0]	bullet_1_y_9_export;
	output	[9:0]	bullet_2_x_0_export;
	output	[9:0]	bullet_2_x_1_export;
	output	[9:0]	bullet_2_x_2_export;
	output	[9:0]	bullet_2_x_3_export;
	output	[9:0]	bullet_2_x_4_export;
	output	[9:0]	bullet_2_x_5_export;
	output	[9:0]	bullet_2_x_6_export;
	output	[9:0]	bullet_2_x_7_export;
	output	[9:0]	bullet_2_x_8_export;
	output	[9:0]	bullet_2_x_9_export;
	output	[9:0]	bullet_2_y_0_export;
	output	[9:0]	bullet_2_y_1_export;
	output	[9:0]	bullet_2_y_2_export;
	output	[9:0]	bullet_2_y_3_export;
	output	[9:0]	bullet_2_y_4_export;
	output	[9:0]	bullet_2_y_5_export;
	output	[9:0]	bullet_2_y_6_export;
	output	[9:0]	bullet_2_y_7_export;
	output	[9:0]	bullet_2_y_8_export;
	output	[9:0]	bullet_2_y_9_export;
endmodule
