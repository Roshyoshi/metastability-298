`timescale 1ns / 1ps
`default_nettype none

// Runs measurement blocks and counts their events.
//
// A block is 2^WIDTH - 1 trials. In each trial the flip-flop under test captures once and its
// output is read three times: `early_e` (sampled outside this module), `l1` at 50 ns and `l2` at
// 100 ns. `k` counts the trials where `early_e != l2`. `fault` records whether any trial had
// `l1 != l2`.
//
// Only `a` and `b` are clocked by `clk20`. Every other flip-flop is clocked by an edge of `a`,
// `b`, `tick_n`, or the counter bit below it, so there is no stage decoder and no adder.
//
// ## Trial
//
// `{a, b}` steps 00 -> 01 -> 11 -> 10 on `clk20`, one bit per edge. Four edges are one 200 ns
// trial, and each edge clocks one thing:
//
// ```text
//   0 ns   a rises     capture: the flip-flops under test sample
//  50 ns   b falls     l1 <= q_selected          allow_count and done update
// 100 ns   a_n rises   l2 <= q_selected          start_meta and run update
// 150 ns   b rises     tick_n falls if allow_count is 1:
//                        n counts
//                        k[0]  <= k[0] ^ (early_e ^ l2)
//                        fault <= fault | (l1 ^ l2)
// ```
//
// ## Block
//
// `start` is a level, not a pulse. It passes through `start_meta` into `run`, both on the 100 ns
// edge, so `run` follows `start` by 200 to 400 ns and `start_meta` has a full trial to settle.
// `run` is the reset of `n`, `k`, `fault` and `done`. Low holds them at zero, so lowering `start`
// is what clears a result.
//
// `allow_count <= run & ~n[WIDTH]` on the 50 ns edge, and `tick_n = ~(b & allow_count)`.
// `allow_count` therefore only changes while `b` is low, which has two consequences. The trial
// in which `run` rises is not counted, so the first counted trial is a whole one. And the last
// count pulse is not cut short when `n[WIDTH]` rises in the middle of it.
//
// `fault` does not stop the block. `done` always means that 2^WIDTH - 1 trials ran.
//
// ## Counters
//
// Each bit is a falling-edge flip-flop with its own inverted output on D, clocked by the bit
// below. `k` is a plain binary chain whose bit 0 loads `k[0] ^ event_bit`. `n` has one changed
// wire: `n[1]` is clocked by `n_n[0]`, so it toggles when `n[0]` rises. `n[i]` then first goes
// high on count 2^i - 1, and `n[WIDTH]` on count 2^WIDTH - 1, which is also the largest value
// `k` can hold. `n` is not a binary count. Only `n[WIDTH]` is read.
//
// After the last count `k` receives no more edges, so it is the result register.
// `done <= n[WIDTH]` on the next 50 ns edge, 100 ns after that count began. `result_byte` is
// `k[7:0]` or `k[15:8]`, selected by `byte_sel`.
//
// ## Reset
//
// `rst_n` clears `b`, `start_meta`, `run` and `allow_count`, and `run` clears the rest. `a` has
// no reset and follows `b` on the next `clk20` edge, so reset can shorten a `capture` pulse to
// one `clk20` period but no further. `l1` and `l2` have no reset and are overwritten before the
// first counted trial. `allow_count` is not cleared by `run`, so one count pulse can follow an
// abort. It reaches flip-flops that are held in reset.
//
// ## Timing the logic tests cannot establish
//
// - On the last count `n[WIDTH]` settles through WIDTH + 1 flip-flops in the 100 ns before
//   `done` and `allow_count` sample it.
// - The fall of `b` reaches `tick_nand` before the new `allow_count` does.
// - `run` drives 35 reset pins and releases every one of them cleanly.
// - Counter switching, which starts at 150 ns, is over before the next capture at 200 ns.
//
// `WIDTH` 16 is the width that is built: 93 cells, 42 of them flip-flops, 1,388 transistors.
// Widths 2 to 15 are for simulation, with the missing high bits of `k` reading as 0.

module compact_control #(
    parameter integer WIDTH = 16
) (
    input  wire clk20,
    input  wire rst_n,
    input  wire ena,
    input  wire start,
    input  wire q_selected,
    input  wire early_e,
    input  wire byte_sel,
    output wire capture,
    output wire busy,
    output wire done,
    output wire fault,
    output wire [7:0] result_byte,
    output wire [WIDTH-1:0] result_k
);
    generate
        if (WIDTH < 2 || WIDTH > 16) begin : g_invalid_width
            compact_control_requires_width_from_2_to_16 invalid_width ();
        end
    endgenerate

    wire a;
    wire b;
    wire a_n;

    // @(posedge clk20) a <= b;
    gf180mcu_fd_sc_mcu7t5v0__dffq_1 a_ff (
        .D   (b),
        .CLK (clk20),
        .Q   (a)
    );

    // assign a_n = ~a;
    gf180mcu_fd_sc_mcu7t5v0__inv_1 a_inv (
        .I  (a),
        .ZN (a_n)
    );

    // @(posedge clk20, negedge rst_n) b <= rst_n ? ~a : 0;
    gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 b_ff (
        .D   (a_n),
        .RN  (rst_n),
        .CLK (clk20),
        .Q   (b)
    );

    assign capture = a;

    wire request;
    wire start_meta;
    wire run;

    // assign request = ena & start;
    gf180mcu_fd_sc_mcu7t5v0__and2_1 request_and (
        .A1 (ena),
        .A2 (start),
        .Z  (request)
    );

    // @(posedge a_n, negedge rst_n)
    //     start_meta <= rst_n ? request : 0;  // a_n rises at 100 ns
    gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 start_meta_ff (
        .D   (request),
        .RN  (rst_n),
        .CLK (a_n),
        .Q   (start_meta)
    );

    // @(posedge a_n, negedge rst_n)
    //     run <= rst_n ? start_meta : 0;  // a_n rises at 100 ns
    gf180mcu_fd_sc_mcu7t5v0__dffrnq_1 run_ff (
        .D   (start_meta),
        .RN  (rst_n),
        .CLK (a_n),
        .Q   (run)
    );

    wire l1;
    wire l2;
    wire event_bit;
    wire bad_bit;

    // @(negedge b) l1 <= q_selected;  // b falls at 50 ns
    gf180mcu_fd_sc_mcu7t5v0__dffnq_1 l1_ff (
        .D    (q_selected),
        .CLKN (b),
        .Q    (l1)
    );

    // @(posedge a_n) l2 <= q_selected;  // a_n rises at 100 ns
    gf180mcu_fd_sc_mcu7t5v0__dffq_1 l2_ff (
        .D   (q_selected),
        .CLK (a_n),
        .Q   (l2)
    );

    // assign event_bit = early_e ^ l2;
    gf180mcu_fd_sc_mcu7t5v0__xor2_1 event_xor (
        .A1 (early_e),
        .A2 (l2),
        .Z  (event_bit)
    );

    // assign bad_bit = l1 ^ l2;
    gf180mcu_fd_sc_mcu7t5v0__xor2_1 bad_xor (
        .A1 (l1),
        .A2 (l2),
        .Z  (bad_bit)
    );

    wire [WIDTH:0] n;
    wire [WIDTH:0] n_n;
    wire finished;
    wire finished_n;
    wire want_count;
    wire allow_count;
    wire tick_n;

    assign finished = n[WIDTH];

    // assign finished_n = ~finished;
    gf180mcu_fd_sc_mcu7t5v0__inv_1 finished_inv (
        .I  (finished),
        .ZN (finished_n)
    );

    // assign want_count = run & finished_n;
    gf180mcu_fd_sc_mcu7t5v0__and2_1 want_and (
        .A1 (run),
        .A2 (finished_n),
        .Z  (want_count)
    );

    // @(negedge b, negedge rst_n)
    //     allow_count <= rst_n ? want_count : 0;  // b falls at 50 ns
    gf180mcu_fd_sc_mcu7t5v0__dffnrnq_1 allow_ff (
        .D    (want_count),
        .RN   (rst_n),
        .CLKN (b),
        .Q    (allow_count)
    );

    // assign tick_n = ~(b & allow_count);  // falls at 150 ns if counting
    gf180mcu_fd_sc_mcu7t5v0__nand2_1 tick_nand (
        .A1 (b),
        .A2 (allow_count),
        .ZN (tick_n)
    );

    // n_clkn[0] = tick_n, n_clkn[1] = n_n[0], n_clkn[i] = n[i-1] for i >= 2
    wire [WIDTH:0] n_clkn = {n[WIDTH-1:1], n_n[0], tick_n};

    genvar i;
    generate
        for (i = 0; i <= WIDTH; i = i + 1) begin : g_n
            // @(negedge n_clkn[i], negedge run) n[i] <= run ? n_n[i] : 0;
            gf180mcu_fd_sc_mcu7t5v0__dffnrnq_1 bit_ff (
                .D    (n_n[i]),
                .RN   (run),
                .CLKN (n_clkn[i]),
                .Q    (n[i])
            );
            // assign n_n[i] = ~n[i];
            gf180mcu_fd_sc_mcu7t5v0__inv_1 bit_inv (
                .I  (n[i]),
                .ZN (n_n[i])
            );
        end
    endgenerate

    wire [WIDTH-1:0] k;
    wire [WIDTH-1:1] k_n;
    wire k0_d;

    // assign k0_d = k[0] ^ event_bit;
    gf180mcu_fd_sc_mcu7t5v0__xor2_1 k0_xor (
        .A1 (k[0]),
        .A2 (event_bit),
        .Z  (k0_d)
    );

    // @(negedge tick_n, negedge run) k[0] <= run ? k0_d : 0;
    gf180mcu_fd_sc_mcu7t5v0__dffnrnq_1 k0_ff (
        .D    (k0_d),
        .RN   (run),
        .CLKN (tick_n),
        .Q    (k[0])
    );

    generate
        for (i = 1; i < WIDTH; i = i + 1) begin : g_k
            // @(negedge k[i-1], negedge run) k[i] <= run ? k_n[i] : 0;
            gf180mcu_fd_sc_mcu7t5v0__dffnrnq_1 bit_ff (
                .D    (k_n[i]),
                .RN   (run),
                .CLKN (k[i-1]),
                .Q    (k[i])
            );
            // assign k_n[i] = ~k[i];
            gf180mcu_fd_sc_mcu7t5v0__inv_1 bit_inv (
                .I  (k[i]),
                .ZN (k_n[i])
            );
        end
    endgenerate

    assign result_k = k;

    wire fault_d;
    wire done_n;

    // assign fault_d = fault | bad_bit;
    gf180mcu_fd_sc_mcu7t5v0__or2_1 fault_or (
        .A1 (fault),
        .A2 (bad_bit),
        .Z  (fault_d)
    );

    // @(negedge tick_n, negedge run) fault <= run ? fault_d : 0;
    gf180mcu_fd_sc_mcu7t5v0__dffnrnq_1 fault_ff (
        .D    (fault_d),
        .RN   (run),
        .CLKN (tick_n),
        .Q    (fault)
    );

    // @(negedge b, negedge run) done <= run ? finished : 0;
    gf180mcu_fd_sc_mcu7t5v0__dffnrnq_1 done_ff (
        .D    (finished),
        .RN   (run),
        .CLKN (b),
        .Q    (done)
    );

    // assign done_n = ~done;
    gf180mcu_fd_sc_mcu7t5v0__inv_1 done_inv (
        .I  (done),
        .ZN (done_n)
    );

    // assign busy = run & done_n;
    gf180mcu_fd_sc_mcu7t5v0__and2_1 busy_and (
        .A1 (run),
        .A2 (done_n),
        .Z  (busy)
    );

    wire [15:0] k16;

    generate
        for (i = 0; i < 16; i = i + 1) begin : g_k16
            if (i < WIDTH) begin : g_bit
                assign k16[i] = k[i];
            end else begin : g_zero
                assign k16[i] = 1'b0;
            end
        end
        for (i = 0; i < 8; i = i + 1) begin : g_byte
            // assign result_byte[i] = byte_sel ? k16[i+8] : k16[i];
            gf180mcu_fd_sc_mcu7t5v0__mux2_1 bit_mux (
                .I0 (k16[i]),
                .I1 (k16[i+8]),
                .S  (byte_sel),
                .Z  (result_byte[i])
            );
        end
    endgenerate
endmodule

`default_nettype wire
