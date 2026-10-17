`timescale 1ns / 1ps
`default_nettype none

// STAGES includes the enable NAND: 31 stages = one NAND + 30 inverters.
// Hold en low until the loop settles before starting. Disabling parks
// clk_out high after propagation; start/stop edges are not glitch-free.
(* keep_hierarchy = 1 *)
module ring_osc #(
    parameter integer STAGES = 31
) (
    input  wire en,
    output wire clk_out
);
    (* keep = 1, dont_touch = 1 *) wire [STAGES-1:0] ring;

    generate
        if (STAGES < 3 || STAGES % 2 == 0) begin : g_invalid_stages
            // An invalid topology must fail elaboration/hierarchy checking.
            ring_osc_requires_odd_stages_at_least_3 invalid_stage_count ();
        end
    endgenerate

    // With en high, the NAND supplies the loop's remaining inversion.
    // Feedback uses A1; preserve this pin assignment during implementation.
    (* keep = 1, dont_touch = 1 *)
    gf180mcu_fd_sc_mcu7t5v0__nand2_1 enable_gate (
        .A1 (ring[STAGES-1]),
        .A2 (en),
        .ZN (ring[0])
    );

    genvar stage;
    generate
        for (stage = 1; stage < STAGES; stage = stage + 1) begin : g_stage
            (* keep = 1, dont_touch = 1 *)
            gf180mcu_fd_sc_mcu7t5v0__inv_1 inverter (
                .I  (ring[stage-1]),
                .ZN (ring[stage])
            );
        end
    endgenerate

    // The buffer isolates downstream loads; its output is outside feedback.
    (* keep = 1, dont_touch = 1 *)
    gf180mcu_fd_sc_mcu7t5v0__buf_1 output_buffer (
        .I (ring[STAGES-1]),
        .Z (clk_out)
    );
endmodule

`default_nettype wire
