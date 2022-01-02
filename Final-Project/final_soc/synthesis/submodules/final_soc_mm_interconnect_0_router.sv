// (C) 2001-2018 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/18.0std/ip/merlin/altera_merlin_router/altera_merlin_router.sv.terp#1 $
// $Revision: #1 $
// $Date: 2018/01/31 $
// $Author: psgswbuild $

// -------------------------------------------------------
// Merlin Router
//
// Asserts the appropriate one-hot encoded channel based on 
// either (a) the address or (b) the dest id. The DECODER_TYPE
// parameter controls this behaviour. 0 means address decoder,
// 1 means dest id decoder.
//
// In the case of (a), it also sets the destination id.
// -------------------------------------------------------

`timescale 1 ns / 1 ns

module final_soc_mm_interconnect_0_router_default_decode
  #(
     parameter DEFAULT_CHANNEL = 11,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 0 
   )
  (output [97 - 92 : 0] default_destination_id,
   output [53-1 : 0] default_wr_channel,
   output [53-1 : 0] default_rd_channel,
   output [53-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[97 - 92 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 53'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 53'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 53'b1 << DEFAULT_RD_CHANNEL;
    end
  endgenerate

endmodule


module final_soc_mm_interconnect_0_router
(
    // -------------------
    // Clock & Reset
    // -------------------
    input clk,
    input reset,

    // -------------------
    // Command Sink (Input)
    // -------------------
    input                       sink_valid,
    input  [111-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [111-1    : 0] src_data,
    output reg [53-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 64;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 97;
    localparam PKT_DEST_ID_L = 92;
    localparam PKT_PROTECTION_H = 101;
    localparam PKT_PROTECTION_L = 99;
    localparam ST_DATA_W = 111;
    localparam ST_CHANNEL_W = 53;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 67;
    localparam PKT_TRANS_READ  = 68;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h10000000 - 64'h8000000); 
    localparam PAD1 = log2ceil(64'h10001000 - 64'h10000800); 
    localparam PAD2 = log2ceil(64'h10001100 - 64'h10001000); 
    localparam PAD3 = log2ceil(64'h10001120 - 64'h10001110); 
    localparam PAD4 = log2ceil(64'h10001130 - 64'h10001120); 
    localparam PAD5 = log2ceil(64'h10001140 - 64'h10001130); 
    localparam PAD6 = log2ceil(64'h10001150 - 64'h10001140); 
    localparam PAD7 = log2ceil(64'h10001160 - 64'h10001150); 
    localparam PAD8 = log2ceil(64'h10001170 - 64'h10001160); 
    localparam PAD9 = log2ceil(64'h10001180 - 64'h10001170); 
    localparam PAD10 = log2ceil(64'h10001190 - 64'h10001180); 
    localparam PAD11 = log2ceil(64'h100011a0 - 64'h10001190); 
    localparam PAD12 = log2ceil(64'h100011b0 - 64'h100011a0); 
    localparam PAD13 = log2ceil(64'h100011c0 - 64'h100011b0); 
    localparam PAD14 = log2ceil(64'h100011d0 - 64'h100011c0); 
    localparam PAD15 = log2ceil(64'h100011e0 - 64'h100011d0); 
    localparam PAD16 = log2ceil(64'h100011f0 - 64'h100011e0); 
    localparam PAD17 = log2ceil(64'h10001200 - 64'h100011f0); 
    localparam PAD18 = log2ceil(64'h10001210 - 64'h10001200); 
    localparam PAD19 = log2ceil(64'h10001220 - 64'h10001210); 
    localparam PAD20 = log2ceil(64'h10001230 - 64'h10001220); 
    localparam PAD21 = log2ceil(64'h10001240 - 64'h10001230); 
    localparam PAD22 = log2ceil(64'h10001250 - 64'h10001240); 
    localparam PAD23 = log2ceil(64'h10001260 - 64'h10001250); 
    localparam PAD24 = log2ceil(64'h10001270 - 64'h10001260); 
    localparam PAD25 = log2ceil(64'h10001280 - 64'h10001270); 
    localparam PAD26 = log2ceil(64'h10001290 - 64'h10001280); 
    localparam PAD27 = log2ceil(64'h100012a0 - 64'h10001290); 
    localparam PAD28 = log2ceil(64'h100012b0 - 64'h100012a0); 
    localparam PAD29 = log2ceil(64'h100012c0 - 64'h100012b0); 
    localparam PAD30 = log2ceil(64'h100012d0 - 64'h100012c0); 
    localparam PAD31 = log2ceil(64'h100012e0 - 64'h100012d0); 
    localparam PAD32 = log2ceil(64'h100012f0 - 64'h100012e0); 
    localparam PAD33 = log2ceil(64'h10001300 - 64'h100012f0); 
    localparam PAD34 = log2ceil(64'h10001310 - 64'h10001300); 
    localparam PAD35 = log2ceil(64'h10001320 - 64'h10001310); 
    localparam PAD36 = log2ceil(64'h10001330 - 64'h10001320); 
    localparam PAD37 = log2ceil(64'h10001340 - 64'h10001330); 
    localparam PAD38 = log2ceil(64'h10001350 - 64'h10001340); 
    localparam PAD39 = log2ceil(64'h10001360 - 64'h10001350); 
    localparam PAD40 = log2ceil(64'h10001370 - 64'h10001360); 
    localparam PAD41 = log2ceil(64'h10001380 - 64'h10001370); 
    localparam PAD42 = log2ceil(64'h10001390 - 64'h10001380); 
    localparam PAD43 = log2ceil(64'h100013a0 - 64'h10001390); 
    localparam PAD44 = log2ceil(64'h100013b0 - 64'h100013a0); 
    localparam PAD45 = log2ceil(64'h100013c0 - 64'h100013b0); 
    localparam PAD46 = log2ceil(64'h100013d0 - 64'h100013c0); 
    localparam PAD47 = log2ceil(64'h100013e0 - 64'h100013d0); 
    localparam PAD48 = log2ceil(64'h100013f0 - 64'h100013e0); 
    localparam PAD49 = log2ceil(64'h10001400 - 64'h100013f0); 
    localparam PAD50 = log2ceil(64'h10001410 - 64'h10001408); 
    localparam PAD51 = log2ceil(64'h10001418 - 64'h10001410); 
    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
    localparam ADDR_RANGE = 64'h10001418;
    localparam RANGE_ADDR_WIDTH = log2ceil(ADDR_RANGE);
    localparam OPTIMIZED_ADDR_H = (RANGE_ADDR_WIDTH > PKT_ADDR_W) ||
                                  (RANGE_ADDR_WIDTH == 0) ?
                                        PKT_ADDR_H :
                                        PKT_ADDR_L + RANGE_ADDR_WIDTH - 1;

    localparam RG = RANGE_ADDR_WIDTH-1;
    localparam REAL_ADDRESS_RANGE = OPTIMIZED_ADDR_H - PKT_ADDR_L;

      reg [PKT_ADDR_W-1 : 0] address;
      always @* begin
        address = {PKT_ADDR_W{1'b0}};
        address [REAL_ADDRESS_RANGE:0] = sink_data[OPTIMIZED_ADDR_H : PKT_ADDR_L];
      end   

    // -------------------------------------------------------
    // Pass almost everything through, untouched
    // -------------------------------------------------------
    assign sink_ready        = src_ready;
    assign src_valid         = sink_valid;
    assign src_startofpacket = sink_startofpacket;
    assign src_endofpacket   = sink_endofpacket;
    wire [PKT_DEST_ID_W-1:0] default_destid;
    wire [53-1 : 0] default_src_channel;




    // -------------------------------------------------------
    // Write and read transaction signals
    // -------------------------------------------------------
    wire read_transaction;
    assign read_transaction  = sink_data[PKT_TRANS_READ];


    final_soc_mm_interconnect_0_router_default_decode the_default_decode(
      .default_destination_id (default_destid),
      .default_wr_channel   (),
      .default_rd_channel   (),
      .default_src_channel  (default_src_channel)
    );

    always @* begin
        src_data    = sink_data;
        src_channel = default_src_channel;
        src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = default_destid;

        // --------------------------------------------------
        // Address Decoder
        // Sets the channel and destination ID based on the address
        // --------------------------------------------------

    // ( 0x8000000 .. 0x10000000 )
    if ( {address[RG:PAD0],{PAD0{1'b0}}} == 29'h8000000   ) begin
            src_channel = 53'b0000000000000000000000000000000000000000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
    end

    // ( 0x10000800 .. 0x10001000 )
    if ( {address[RG:PAD1],{PAD1{1'b0}}} == 29'h10000800   ) begin
            src_channel = 53'b0000000000000000000000000000000000000000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 44;
    end

    // ( 0x10001000 .. 0x10001100 )
    if ( {address[RG:PAD2],{PAD2{1'b0}}} == 29'h10001000   ) begin
            src_channel = 53'b0000000000000000000000000000000000000000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 41;
    end

    // ( 0x10001110 .. 0x10001120 )
    if ( {address[RG:PAD3],{PAD3{1'b0}}} == 29'h10001110   ) begin
            src_channel = 53'b1000000000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 33;
    end

    // ( 0x10001120 .. 0x10001130 )
    if ( {address[RG:PAD4],{PAD4{1'b0}}} == 29'h10001120   ) begin
            src_channel = 53'b0100000000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 35;
    end

    // ( 0x10001130 .. 0x10001140 )
    if ( {address[RG:PAD5],{PAD5{1'b0}}} == 29'h10001130   ) begin
            src_channel = 53'b0010000000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 34;
    end

    // ( 0x10001140 .. 0x10001150 )
    if ( {address[RG:PAD6],{PAD6{1'b0}}} == 29'h10001140   ) begin
            src_channel = 53'b0001000000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 40;
    end

    // ( 0x10001150 .. 0x10001160 )
    if ( {address[RG:PAD7],{PAD7{1'b0}}} == 29'h10001150   ) begin
            src_channel = 53'b0000100000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 39;
    end

    // ( 0x10001160 .. 0x10001170 )
    if ( {address[RG:PAD8],{PAD8{1'b0}}} == 29'h10001160   ) begin
            src_channel = 53'b0000010000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 38;
    end

    // ( 0x10001170 .. 0x10001180 )
    if ( {address[RG:PAD9],{PAD9{1'b0}}} == 29'h10001170   ) begin
            src_channel = 53'b0000001000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 37;
    end

    // ( 0x10001180 .. 0x10001190 )
    if ( {address[RG:PAD10],{PAD10{1'b0}}} == 29'h10001180   ) begin
            src_channel = 53'b0000000100000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 36;
    end

    // ( 0x10001190 .. 0x100011a0 )
    if ( {address[RG:PAD11],{PAD11{1'b0}}} == 29'h10001190   ) begin
            src_channel = 53'b0000000010000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 32;
    end

    // ( 0x100011a0 .. 0x100011b0 )
    if ( {address[RG:PAD12],{PAD12{1'b0}}} == 29'h100011a0   ) begin
            src_channel = 53'b0000000001000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 31;
    end

    // ( 0x100011b0 .. 0x100011c0 )
    if ( {address[RG:PAD13],{PAD13{1'b0}}} == 29'h100011b0   ) begin
            src_channel = 53'b0000000000100000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 30;
    end

    // ( 0x100011c0 .. 0x100011d0 )
    if ( {address[RG:PAD14],{PAD14{1'b0}}} == 29'h100011c0   ) begin
            src_channel = 53'b0000000000010000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 29;
    end

    // ( 0x100011d0 .. 0x100011e0 )
    if ( {address[RG:PAD15],{PAD15{1'b0}}} == 29'h100011d0   ) begin
            src_channel = 53'b0000000000001000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 28;
    end

    // ( 0x100011e0 .. 0x100011f0 )
    if ( {address[RG:PAD16],{PAD16{1'b0}}} == 29'h100011e0   ) begin
            src_channel = 53'b0000000000000100000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 27;
    end

    // ( 0x100011f0 .. 0x10001200 )
    if ( {address[RG:PAD17],{PAD17{1'b0}}} == 29'h100011f0   ) begin
            src_channel = 53'b0000000000000010000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 26;
    end

    // ( 0x10001200 .. 0x10001210 )
    if ( {address[RG:PAD18],{PAD18{1'b0}}} == 29'h10001200   ) begin
            src_channel = 53'b0000000000000001000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 25;
    end

    // ( 0x10001210 .. 0x10001220 )
    if ( {address[RG:PAD19],{PAD19{1'b0}}} == 29'h10001210   ) begin
            src_channel = 53'b0000000000000000100000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 24;
    end

    // ( 0x10001220 .. 0x10001230 )
    if ( {address[RG:PAD20],{PAD20{1'b0}}} == 29'h10001220   ) begin
            src_channel = 53'b0000000000000000010000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 23;
    end

    // ( 0x10001230 .. 0x10001240 )
    if ( {address[RG:PAD21],{PAD21{1'b0}}} == 29'h10001230   ) begin
            src_channel = 53'b0000000000000000001000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 22;
    end

    // ( 0x10001240 .. 0x10001250 )
    if ( {address[RG:PAD22],{PAD22{1'b0}}} == 29'h10001240   ) begin
            src_channel = 53'b0000000000000000000100000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 21;
    end

    // ( 0x10001250 .. 0x10001260 )
    if ( {address[RG:PAD23],{PAD23{1'b0}}} == 29'h10001250   ) begin
            src_channel = 53'b0000000000000000000010000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 20;
    end

    // ( 0x10001260 .. 0x10001270 )
    if ( {address[RG:PAD24],{PAD24{1'b0}}} == 29'h10001260   ) begin
            src_channel = 53'b0000000000000000000001000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 19;
    end

    // ( 0x10001270 .. 0x10001280 )
    if ( {address[RG:PAD25],{PAD25{1'b0}}} == 29'h10001270   ) begin
            src_channel = 53'b0000000000000000000000100000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 18;
    end

    // ( 0x10001280 .. 0x10001290 )
    if ( {address[RG:PAD26],{PAD26{1'b0}}} == 29'h10001280   ) begin
            src_channel = 53'b0000000000000000000000010000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 17;
    end

    // ( 0x10001290 .. 0x100012a0 )
    if ( {address[RG:PAD27],{PAD27{1'b0}}} == 29'h10001290   ) begin
            src_channel = 53'b0000000000000000000000001000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 16;
    end

    // ( 0x100012a0 .. 0x100012b0 )
    if ( {address[RG:PAD28],{PAD28{1'b0}}} == 29'h100012a0   ) begin
            src_channel = 53'b0000000000000000000000000100000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 15;
    end

    // ( 0x100012b0 .. 0x100012c0 )
    if ( {address[RG:PAD29],{PAD29{1'b0}}} == 29'h100012b0   ) begin
            src_channel = 53'b0000000000000000000000000010000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
    end

    // ( 0x100012c0 .. 0x100012d0 )
    if ( {address[RG:PAD30],{PAD30{1'b0}}} == 29'h100012c0   ) begin
            src_channel = 53'b0000000000000000000000000001000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 13;
    end

    // ( 0x100012d0 .. 0x100012e0 )
    if ( {address[RG:PAD31],{PAD31{1'b0}}} == 29'h100012d0   ) begin
            src_channel = 53'b0000000000000000000000000000100000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
    end

    // ( 0x100012e0 .. 0x100012f0 )
    if ( {address[RG:PAD32],{PAD32{1'b0}}} == 29'h100012e0   ) begin
            src_channel = 53'b0000000000000000000000000000010000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
    end

    // ( 0x100012f0 .. 0x10001300 )
    if ( {address[RG:PAD33],{PAD33{1'b0}}} == 29'h100012f0   ) begin
            src_channel = 53'b0000000000000000000000000000001000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
    end

    // ( 0x10001300 .. 0x10001310 )
    if ( {address[RG:PAD34],{PAD34{1'b0}}} == 29'h10001300   ) begin
            src_channel = 53'b0000000000000000000000000000000100000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
    end

    // ( 0x10001310 .. 0x10001320 )
    if ( {address[RG:PAD35],{PAD35{1'b0}}} == 29'h10001310   ) begin
            src_channel = 53'b0000000000000000000000000000000010000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
    end

    // ( 0x10001320 .. 0x10001330 )
    if ( {address[RG:PAD36],{PAD36{1'b0}}} == 29'h10001320   ) begin
            src_channel = 53'b0000000000000000000000000000000001000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
    end

    // ( 0x10001330 .. 0x10001340 )
    if ( {address[RG:PAD37],{PAD37{1'b0}}} == 29'h10001330   ) begin
            src_channel = 53'b0000000000000000000000000000000000100000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
    end

    // ( 0x10001340 .. 0x10001350 )
    if ( {address[RG:PAD38],{PAD38{1'b0}}} == 29'h10001340   ) begin
            src_channel = 53'b0000000000000000000000000000000000010000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
    end

    // ( 0x10001350 .. 0x10001360 )
    if ( {address[RG:PAD39],{PAD39{1'b0}}} == 29'h10001350   ) begin
            src_channel = 53'b0000000000000000000000000000000000001000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
    end

    // ( 0x10001360 .. 0x10001370 )
    if ( {address[RG:PAD40],{PAD40{1'b0}}} == 29'h10001360   ) begin
            src_channel = 53'b0000000000000000000000000000000000000100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
    end

    // ( 0x10001370 .. 0x10001380 )
    if ( {address[RG:PAD41],{PAD41{1'b0}}} == 29'h10001370   ) begin
            src_channel = 53'b0000000000000000000000000000000000000010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
    end

    // ( 0x10001380 .. 0x10001390 )
    if ( {address[RG:PAD42],{PAD42{1'b0}}} == 29'h10001380   ) begin
            src_channel = 53'b0000000000000000000000000000000000000001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
    end

    // ( 0x10001390 .. 0x100013a0 )
    if ( {address[RG:PAD43],{PAD43{1'b0}}} == 29'h10001390   ) begin
            src_channel = 53'b0000000000000000000000000000000000000000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 43;
    end

    // ( 0x100013a0 .. 0x100013b0 )
    if ( {address[RG:PAD44],{PAD44{1'b0}}} == 29'h100013a0   ) begin
            src_channel = 53'b0000000000000000000000000000000000000000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 49;
    end

    // ( 0x100013b0 .. 0x100013c0 )
    if ( {address[RG:PAD45],{PAD45{1'b0}}} == 29'h100013b0   ) begin
            src_channel = 53'b0000000000000000000000000000000000000000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 46;
    end

    // ( 0x100013c0 .. 0x100013d0 )
    if ( {address[RG:PAD46],{PAD46{1'b0}}} == 29'h100013c0   ) begin
            src_channel = 53'b0000000000000000000000000000000000000000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 45;
    end

    // ( 0x100013d0 .. 0x100013e0 )
    if ( {address[RG:PAD47],{PAD47{1'b0}}} == 29'h100013d0   ) begin
            src_channel = 53'b0000000000000000000000000000000000000000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 47;
    end

    // ( 0x100013e0 .. 0x100013f0 )
    if ( {address[RG:PAD48],{PAD48{1'b0}}} == 29'h100013e0   ) begin
            src_channel = 53'b0000000000000000000000000000000000000000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 48;
    end

    // ( 0x100013f0 .. 0x10001400 )
    if ( {address[RG:PAD49],{PAD49{1'b0}}} == 29'h100013f0   ) begin
            src_channel = 53'b0000000000000000000000000000000000000000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 50;
    end

    // ( 0x10001408 .. 0x10001410 )
    if ( {address[RG:PAD50],{PAD50{1'b0}}} == 29'h10001408  && read_transaction  ) begin
            src_channel = 53'b0000000000000000000000000000000000000000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 52;
    end

    // ( 0x10001410 .. 0x10001418 )
    if ( {address[RG:PAD51],{PAD51{1'b0}}} == 29'h10001410   ) begin
            src_channel = 53'b0000000000000000000000000000000000000000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 42;
    end

end


    // --------------------------------------------------
    // Ceil(log2()) function
    // --------------------------------------------------
    function integer log2ceil;
        input reg[65:0] val;
        reg [65:0] i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction

endmodule


