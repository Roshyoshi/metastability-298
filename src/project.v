`timescale 1ns / 1ps
`default_nettype none

module tt_um_metastability (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // Bidirectional pin inputs
    output wire [7:0] uio_out,  // Bidirectional pin output data
    output wire [7:0] uio_oe,   // Per-pin direction: 0 = input, 1 = output
    input  wire       ena,     // Asserted when the project is selected
    input  wire       clk,     // External system clock
    input  wire       rst_n    // Active-low reset
);

    // Interface scaffold. Replace tie-offs as the circuit is integrated.
    assign uo_out  = 8'b0;
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    wire _unused = &{ui_in, uio_in, ena, clk, rst_n, 1'b0};

endmodule

`default_nettype wire
