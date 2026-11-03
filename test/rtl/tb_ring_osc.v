`timescale 1ns / 1ps
`default_nettype none

module tb_ring_osc;
    parameter integer STAGES = 31;

    // Each simulation cell delays an edge by 1 ns. The output buffer adds
    // latency, but must not add to the feedback period.
    localparam time HALF_PERIOD = STAGES;
    localparam time SETTLE_TIME = STAGES + 2;

    reg en = 1'b0;
    wire clk_out;
    reg expect_quiet = 1'b0;
    string vcd_path;

    ring_osc #(.STAGES(STAGES)) dut (
        .en      (en),
        .clk_out (clk_out)
    );

    always @(clk_out) begin
        if (expect_quiet)
            $fatal(1, "Output changed after the disabled ring had settled");
    end

    task check_stopped;
        begin
            en = 1'b0;
            #SETTLE_TIME;
            if (clk_out !== 1'b1)
                $fatal(1, "Disabled ring must settle high, got %b", clk_out);
            expect_quiet = 1'b1;
            #(2 * HALF_PERIOD);
            expect_quiet = 1'b0;
        end
    endtask

    task check_running;
        realtime last_edge;
        begin
            en = 1'b1;
            @(negedge clk_out);
            repeat (4) begin
                last_edge = $realtime;
                @(posedge clk_out);
                if (clk_out !== 1'b1 ||
                    $realtime - last_edge != HALF_PERIOD)
                    $fatal(1, "Unexpected low pulse: %0t", $realtime-last_edge);
                last_edge = $realtime;
                @(negedge clk_out);
                if (clk_out !== 1'b0 ||
                    $realtime - last_edge != HALF_PERIOD)
                    $fatal(1, "Unexpected high pulse: %0t", $realtime-last_edge);
            end
        end
    endtask

    initial begin
        if ($value$plusargs("vcd=%s", vcd_path)) begin
            $dumpfile(vcd_path);
            $dumpvars(0, tb_ring_osc);
        end

        check_stopped();
        check_running();
        #0.5;
        check_stopped();
        check_running();
        @(posedge clk_out);
        #0.5;
        check_stopped();
        $display("Ring (%0d stages): start, stop, restart, period passed", STAGES);
        $finish;
    end

    initial begin
        #(100 * STAGES + 100);
        $fatal(1, "Timed out waiting for ring oscillator edges");
    end
endmodule

`default_nettype wire
