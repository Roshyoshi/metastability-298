// Black box of the analog tile. The circuit is netlist/chip.cdl and the
// layout is layout/tt_um_metastability_characterizer.gds; Tiny Tapeout only
// reads this file for the port list.
`default_nettype none

module tt_um_metastability_characterizer (
    input  wire       VGND,
    input  wire       VDPWR,    // 3.3 V core supply
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: input path
    output wire [7:0] uio_out,  // IOs: output path
    output wire [7:0] uio_oe,   // IOs: enable path (1 = output)
    inout  wire [7:0] ua,       // Analog pins; only ua[0] is used
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

endmodule

`default_nettype wire
