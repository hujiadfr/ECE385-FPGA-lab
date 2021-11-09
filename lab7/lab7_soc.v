module lab7_soc (   input           clk_clk,
                    input           reset_reset_n,
                    output [7:0]    led_wire_export,
                    output [12:0]   sdram_wire_addr,    //  sdram_wire.addr
                    output [1:0]    sdram_wire_ba,      //  .ba
                    output          sdram_wire_cas_n,   //  .cas_n
                    output          sdram_wire_cke,     //  .cke
                    output          sdram_wire_cs_n,    //  .cs_n
                    output [31:0]   sdram_wire_dq,      //  .dq
                    output [3:0]    sdram_wire_dqm,     //  .dqm
                    output          sdram_wire_ras_n,   //  .ras_n
                    output          sdram_wire_we_n,    //  .we_n
                    output          sdram_clk_clk		//  clock out to SDRAM from other PLL port
                );
endmodule  //module_name
