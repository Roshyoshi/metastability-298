`timescale 1ns / 1ps
`default_nettype none

module tb;
    reg  [7:0] ui_in = 8'b0;
    wire [7:0] uo_out;
    reg  [7:0] uio_in = 8'b0;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    reg        ena = 1'b1;
    reg        clk = 1'b0;
    reg        rst_n = 1'b0;
    string     vcd_path;

    tt_um_metastability dut (
        .ui_in   (ui_in),
        .uo_out  (uo_out),
        .uio_in  (uio_in),
        .uio_out (uio_out),
        .uio_oe  (uio_oe),
        .ena     (ena),
        .clk     (clk),
        .rst_n   (rst_n)
    );

    always #25 clk = ~clk;

    initial begin
        if ($value$plusargs("vcd=%s", vcd_path)) begin
            $dumpfile(vcd_path);
            $dumpvars(0, tb);
        end

        // Release reset away from the active clock edge.
        repeat (4) @(negedge clk);
        rst_n = 1'b1;
        repeat (16) @(negedge clk);
        $display("Interface harness completed; instrument behavior is pending.");
        $finish;
    end
endmodule

`default_nettype wire
