`timescale 1ns / 1ps
`default_nettype none

// Simulation-only truth tables with arbitrary 1 ns delays. These exercise
// the structural loop; they do not model GF180 timing, loading, or startup.
// Never include these definitions alongside the real PDK cell models.
module gf180mcu_fd_sc_mcu7t5v0__nand2_1 (
    input  wire A1,
    input  wire A2,
    output wire ZN
);
    assign #1 ZN = ~(A1 & A2);
endmodule

module gf180mcu_fd_sc_mcu7t5v0__inv_1 (
    input  wire I,
    output wire ZN
);
    assign #1 ZN = ~I;
endmodule

module gf180mcu_fd_sc_mcu7t5v0__buf_1 (
    input  wire I,
    output wire Z
);
    assign #1 Z = I;
endmodule

`default_nettype wire
