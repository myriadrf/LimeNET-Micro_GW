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

module lms_ctr_mm_interconnect_0_router_default_decode
  #(
     parameter DEFAULT_CHANNEL = 6,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 11 
   )
  (output [89 - 86 : 0] default_destination_id,
   output [16-1 : 0] default_wr_channel,
   output [16-1 : 0] default_rd_channel,
   output [16-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[89 - 86 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 16'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 16'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 16'b1 << DEFAULT_RD_CHANNEL;
    end
  endgenerate

endmodule


module lms_ctr_mm_interconnect_0_router
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
    input  [103-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [103-1    : 0] src_data,
    output reg [16-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 57;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 89;
    localparam PKT_DEST_ID_L = 86;
    localparam PKT_PROTECTION_H = 93;
    localparam PKT_PROTECTION_L = 91;
    localparam ST_DATA_W = 103;
    localparam ST_CHANNEL_W = 16;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 60;
    localparam PKT_TRANS_READ  = 61;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h200000 - 64'h100000); 
    localparam PAD1 = log2ceil(64'h201000 - 64'h200000); 
    localparam PAD2 = log2ceil(64'h202000 - 64'h201800); 
    localparam PAD3 = log2ceil(64'h202100 - 64'h202000); 
    localparam PAD4 = log2ceil(64'h202120 - 64'h202100); 
    localparam PAD5 = log2ceil(64'h202140 - 64'h202120); 
    localparam PAD6 = log2ceil(64'h202160 - 64'h202140); 
    localparam PAD7 = log2ceil(64'h202180 - 64'h202160); 
    localparam PAD8 = log2ceil(64'h2021a0 - 64'h202180); 
    localparam PAD9 = log2ceil(64'h2021c0 - 64'h2021a0); 
    localparam PAD10 = log2ceil(64'h2021d0 - 64'h2021c0); 
    localparam PAD11 = log2ceil(64'h2021e0 - 64'h2021d0); 
    localparam PAD12 = log2ceil(64'h2021f0 - 64'h2021e0); 
    localparam PAD13 = log2ceil(64'h202200 - 64'h2021f0); 
    localparam PAD14 = log2ceil(64'h202208 - 64'h202200); 
    localparam PAD15 = log2ceil(64'h202210 - 64'h202208); 
    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
    localparam ADDR_RANGE = 64'h202210;
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
    wire [16-1 : 0] default_src_channel;




    // -------------------------------------------------------
    // Write and read transaction signals
    // -------------------------------------------------------
    wire read_transaction;
    assign read_transaction  = sink_data[PKT_TRANS_READ];


    lms_ctr_mm_interconnect_0_router_default_decode the_default_decode(
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

    // ( 0x100000 .. 0x200000 )
    if ( {address[RG:PAD0],{PAD0{1'b0}}} == 22'h100000   ) begin
            src_channel = 16'b0000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
    end

    // ( 0x200000 .. 0x201000 )
    if ( {address[RG:PAD1],{PAD1{1'b0}}} == 22'h200000   ) begin
            src_channel = 16'b0000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
    end

    // ( 0x201800 .. 0x202000 )
    if ( {address[RG:PAD2],{PAD2{1'b0}}} == 22'h201800   ) begin
            src_channel = 16'b0000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
    end

    // ( 0x202000 .. 0x202100 )
    if ( {address[RG:PAD3],{PAD3{1'b0}}} == 22'h202000   ) begin
            src_channel = 16'b0000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
    end

    // ( 0x202100 .. 0x202120 )
    if ( {address[RG:PAD4],{PAD4{1'b0}}} == 22'h202100   ) begin
            src_channel = 16'b1000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
    end

    // ( 0x202120 .. 0x202140 )
    if ( {address[RG:PAD5],{PAD5{1'b0}}} == 22'h202120   ) begin
            src_channel = 16'b0100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
    end

    // ( 0x202140 .. 0x202160 )
    if ( {address[RG:PAD6],{PAD6{1'b0}}} == 22'h202140   ) begin
            src_channel = 16'b0010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
    end

    // ( 0x202160 .. 0x202180 )
    if ( {address[RG:PAD7],{PAD7{1'b0}}} == 22'h202160   ) begin
            src_channel = 16'b0000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
    end

    // ( 0x202180 .. 0x2021a0 )
    if ( {address[RG:PAD8],{PAD8{1'b0}}} == 22'h202180   ) begin
            src_channel = 16'b0000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
    end

    // ( 0x2021a0 .. 0x2021c0 )
    if ( {address[RG:PAD9],{PAD9{1'b0}}} == 22'h2021a0   ) begin
            src_channel = 16'b0000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
    end

    // ( 0x2021c0 .. 0x2021d0 )
    if ( {address[RG:PAD10],{PAD10{1'b0}}} == 22'h2021c0  && read_transaction  ) begin
            src_channel = 16'b0001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 15;
    end

    // ( 0x2021d0 .. 0x2021e0 )
    if ( {address[RG:PAD11],{PAD11{1'b0}}} == 22'h2021d0   ) begin
            src_channel = 16'b0000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
    end

    // ( 0x2021e0 .. 0x2021f0 )
    if ( {address[RG:PAD12],{PAD12{1'b0}}} == 22'h2021e0  && read_transaction  ) begin
            src_channel = 16'b0000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 13;
    end

    // ( 0x2021f0 .. 0x202200 )
    if ( {address[RG:PAD13],{PAD13{1'b0}}} == 22'h2021f0   ) begin
            src_channel = 16'b0000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
    end

    // ( 0x202200 .. 0x202208 )
    if ( {address[RG:PAD14],{PAD14{1'b0}}} == 22'h202200   ) begin
            src_channel = 16'b0000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
    end

    // ( 0x202208 .. 0x202210 )
    if ( {address[RG:PAD15],{PAD15{1'b0}}} == 22'h202208  && read_transaction  ) begin
            src_channel = 16'b0000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
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


