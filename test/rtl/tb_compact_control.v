`timescale 1ns / 1ps
`default_nettype none

module tb_compact_control;
    parameter integer WIDTH = 16;
    localparam integer TRIALS = (1 << WIDTH) - 1;
    localparam integer HALF = 1 << (WIDTH - 1);

    reg  clk20 = 1'b0;
    reg  rst_n = 1'b0;
    reg  ena   = 1'b1;
    reg  start = 1'b0;
    reg  q_selected = 1'b0;
    reg  early_e    = 1'b0;
    reg  byte_sel   = 1'b0;
    wire capture;
    wire busy;
    wire done;
    wire fault;
    wire [7:0] result_byte;
    wire [WIDTH-1:0] result_k;
    string vcd_path;

    compact_control #(.WIDTH(WIDTH)) dut (
        .clk20      (clk20),
        .rst_n      (rst_n),
        .ena        (ena),
        .start      (start),
        .q_selected (q_selected),
        .early_e    (early_e),
        .byte_sel   (byte_sel),
        .capture    (capture),
        .busy       (busy),
        .done       (done),
        .fault      (fault),
        .result_byte(result_byte),
        .result_k   (result_k)
    );

    always #25 clk20 = ~clk20;

    initial $timeformat(-9, 1, " ns", 0);

    wire [1:0] ab = {dut.a, dut.b};

    function [1:0] next_ab(input [1:0] now);
        next_ab = {now[0], ~now[1]};
    endfunction

    realtime capture_rose_at = -1.0;
    realtime shortest_capture_high = 1.0e9;
    realtime a_n_rose_at = -1.0;
    realtime b_fell_at = -1.0;
    realtime b_rose_at = -1.0;
    realtime rst_fell_at = -1.0;
    realtime run_rose_at = -1.0;
    realtime run_fell_at = -1.0;
    realtime tick_fell_at = -1.0;
    realtime early_changed_at = -1.0;

    integer run_rises = 0;
    integer run_falls = 0;
    integer ticks = 0;
    integer ticks_at_run_rise = 0;
    integer captures = 0;
    integer captures_at_run_rise = 0;

    integer event_sum = 0;
    reg     fault_ref = 1'b0;
    reg [WIDTH-1:0] k_before_last_trial;
    integer final_k;
    reg     final_fault;

    integer k_checks = 0;
    integer first_counts_checked = 0;
    integer blocks_run = 0;
    integer aborts_run = 0;
    integer readings_checked = 0;
    integer seen_l1_l2 [0:3];
    integer seen_event [0:1];

    initial begin
        seen_l1_l2[0] = 0; seen_l1_l2[1] = 0; seen_l1_l2[2] = 0; seen_l1_l2[3] = 0;
        seen_event[0] = 0; seen_event[1] = 0;
    end

    task wait_clk20_edge;
        begin
            @(posedge clk20);
            #5;
        end
    endtask

    task release_reset;
        begin
            @(negedge clk20);
            rst_n = 1'b1;
        end
    endtask

    task wait_trials(input integer trials);
        begin
            repeat (trials) @(posedge capture);
        end
    endtask

    task wait_run_and_check_delay(input value, input [8*8-1:0] what);
        realtime asked_at;
        realtime took;
        begin
            asked_at = $realtime;
            while (dut.run !== value) begin
                #1;
                if ($realtime - asked_at > 500.0)
                    $fatal(1, "%0s: run never became %b (asked at %0t)", what, value, asked_at);
            end
            took = (value ? run_rose_at : run_fell_at) - asked_at;
            if (took < 200.0 || took > 402.0)
                $fatal(1, "%0s: run became %b after %0t, expected 200 to 402 ns", what, value, took);
        end
    endtask

    task check_cleared(input [8*8-1:0] what);
        begin
            #3;
            if ((|dut.n) !== 1'b0 || (|result_k) !== 1'b0 || fault !== 1'b0 || done !== 1'b0 || busy !== 1'b0)
                $fatal(1, "%0s: expected n, k, fault, done, busy all 0, got n=%b k=%b fault=%b done=%b busy=%b at %0t",
                       what, dut.n, result_k, fault, done, busy, $realtime);
        end
    endtask

    task read_bytes(input first, output [15:0] value);
        reg [7:0] low;
        reg [7:0] high;
        begin
            byte_sel = first;
            #5;
            if (first) high = result_byte; else low = result_byte;
            byte_sel = ~first;
            #5;
            if (first) low = result_byte; else high = result_byte;
            value = {high, low};
        end
    endtask

    localparam integer EVENTS_RANDOM     = 0;
    localparam integer EVENTS_NONE       = 1;
    localparam integer EVENTS_ALL        = 2;
    localparam integer EVENTS_ALTERNATE  = 3;
    localparam integer EVENTS_LAST_CARRY = 4;
    localparam integer BAD_RANDOM = -2;
    localparam integer BAD_NEVER  = -1;

    integer event_pattern = EVENTS_RANDOM;
    integer bad_at        = BAD_RANDOM;

    integer trial_index;
    reg     trial_event;
    reg     trial_bad;
    reg     trial_value;
    integer t_late, t_super, t_early;

    always @(posedge capture) begin : drive_trial
        trial_index = ticks - ticks_at_run_rise;
        case (event_pattern)
            EVENTS_NONE:       trial_event = 1'b0;
            EVENTS_ALL:        trial_event = 1'b1;
            EVENTS_ALTERNATE:  trial_event = ~trial_index[0];
            EVENTS_LAST_CARRY: trial_event = (trial_index < HALF - 1) || (trial_index == TRIALS - 1);
            default:           trial_event = $urandom_range(0, 1);
        endcase
        if (bad_at == BAD_RANDOM) trial_bad = ($urandom_range(0, 7) == 0);
        else                      trial_bad = (bad_at >= 0) && (trial_index == bad_at);
        trial_value = $urandom_range(0, 1);
        t_late  = $urandom_range(0, 40);
        t_super = $urandom_range(52, 98);
        t_early = $urandom_range(1, 45);
        fork
            begin
                #(0.5 + t_late)     q_selected = trial_bad ? ~trial_value : trial_value;
                #(t_super - t_late) q_selected = trial_value;
            end
            #(0.5 + t_early) early_e = trial_value ^ trial_event;
        join
    end

    always @(capture) begin
        if (capture === 1'b1) begin
            capture_rose_at = $realtime;
        end else if (capture === 1'b0 && capture_rose_at >= 0.0) begin
            if ($realtime - capture_rose_at < shortest_capture_high)
                shortest_capture_high = $realtime - capture_rose_at;
        end
    end

    always @(posedge capture) captures = captures + 1;
    always @(posedge dut.a_n) a_n_rose_at = $realtime;
    always @(negedge dut.b) b_fell_at = $realtime;
    always @(posedge dut.b) b_rose_at = $realtime;
    always @(negedge rst_n) rst_fell_at = $realtime;
    always @(early_e) early_changed_at = $realtime;

    always @(dut.run) begin
        if (dut.run === 1'b1) run_rises = run_rises + 1;
        if (dut.run === 1'b0) run_falls = run_falls + 1;
    end

    always @(posedge dut.run) begin
        run_rose_at = $realtime;
        ticks_at_run_rise = ticks;
        captures_at_run_rise = captures;
    end

    always @(negedge dut.run) begin
        run_fell_at = $realtime;
        event_sum = 0;
        fault_ref = 1'b0;
    end

    always @(posedge capture)
        if (dut.run === 1'b1 && ticks - ticks_at_run_rise == TRIALS - 1) k_before_last_trial = result_k;

    always @(negedge dut.tick_n) begin
        ticks = ticks + 1;
        tick_fell_at = $realtime;
        if (dut.run === 1'b1) begin
            event_sum = event_sum + trial_event;
            if (trial_bad) fault_ref = 1'b1;
        end
        check_count_pulse_starts_on_b_rising();
        check_count_limit();
        check_first_count_is_a_whole_trial();
    end

    // ========================================================================
    // TEST (always running): run only moves on the a_n rising edge
    //
    // WHAT IT TESTS
    //   run is the flip-flop that says "a block is in progress". It is meant
    //   to be clocked by a_n, so it may only change just after a_n rises,
    //   100 ns into a trial. A change at any other moment means run_ff has
    //   the wrong clock wire or the wrong edge. Reset is the one exception:
    //   rst_n low forces run to 0 immediately.
    //
    // HOW
    //   Another block stores the time of every a_n rising edge in
    //   a_n_rose_at. This block wakes on every change of dut.run. If rst_n
    //   is high, the change must come exactly 1 ns after the last a_n rising
    //   edge; 1 ns is the flip-flop delay in the cell models. It runs for the
    //   whole simulation, so every start, stop and abort made by every other
    //   test is covered.
    // ========================================================================
    always @(dut.run)
        if (rst_n === 1'b1 && $realtime - a_n_rose_at != 1.0)
            $fatal(1, "run changed to %b at %0t, not on an a_n rising edge", dut.run, $realtime);

    // ========================================================================
    // TEST (always running): l1 only moves when b falls, l2 only when a_n rises
    //
    // WHAT IT TESTS
    //   l1 is the late reading and must be taken when b falls, 50 ns into
    //   the trial. l2 is the super-late reading and must be taken when a_n
    //   rises, at 100 ns. This catches l1_ff or l2_ff connected to the wrong
    //   clock wire, or acting on the wrong edge of the right wire.
    //
    // HOW
    //   Other blocks store the time of every b falling edge in b_fell_at and
    //   every a_n rising edge in a_n_rose_at. The two blocks below wake on
    //   every change of dut.l1 and dut.l2. Each change must come exactly 1 ns
    //   (the flip-flop delay in the cell models) after its own edge. No
    //   exception is needed for reset: reset makes b fall, and l1 is right to
    //   sample then.
    // ========================================================================
    always @(dut.l1)
        if ($realtime - b_fell_at != 1.0)
            $fatal(1, "l1 changed to %b at %0t, not on a b falling edge", dut.l1, $realtime);
    always @(dut.l2)
        if ($realtime - a_n_rose_at != 1.0)
            $fatal(1, "l2 changed to %b at %0t, not on an a_n rising edge", dut.l2, $realtime);

    // ========================================================================
    // TEST (always running): l1, l2, event_bit and bad_bit hold the right
    // values in every trial
    //
    // WHAT IT TESTS
    //   By 140 ns into each trial, 10 ns before the count edge:
    //     l1        = what q_selected was at 50 ns
    //     l2        = what q_selected was at 100 ns
    //     bad_bit   = l1 ^ l2
    //     event_bit = early_e ^ l2
    //   This catches a flip-flop reading the wrong wire (for example l2
    //   reading l1 instead of q_selected) and an XOR gate comparing the
    //   wrong pair.
    //
    // HOW
    //   It wakes on every rising edge of capture and uses its own delays, not
    //   dut.b or dut.a_n, to decide when the samples should be taken. In the
    //   cell models b falls 50 ns after capture rises and a_n rises 101 ns
    //   after. So it copies q_selected into expect_l1 after 50 ns and into
    //   expect_l2 after 51 ns more. drive_trial only moves q_selected on half
    //   nanoseconds, so the copy is never taken at the instant it changes.
    //   At 140 ns it compares dut.l1, dut.l2, dut.bad_bit and dut.event_bit
    //   with what it worked out. Two cases are skipped: a trial during which
    //   rst_n was low (reset moves the edges), and the event_bit comparison
    //   when early_e changed in the last 3 ns (the XOR model needs 1 ns).
    //   It also counts how often each l1,l2 combination and each event_bit
    //   value was seen, for the next test.
    // ========================================================================
    realtime trial_began;
    reg      expect_l1;
    reg      expect_l2;
    reg      early_now;

    always @(posedge capture) begin : check_readings
        trial_began = $realtime;
        #50  expect_l1 = q_selected;
        #51  expect_l2 = q_selected;
        #39;
        if (rst_n !== 1'b1 || rst_fell_at >= trial_began) disable check_readings;
        if (dut.l1 !== expect_l1)
            $fatal(1, "l1: expected %b (q_selected at 50 ns), got %b at %0t", expect_l1, dut.l1, $realtime);
        if (dut.l2 !== expect_l2)
            $fatal(1, "l2: expected %b (q_selected at 100 ns), got %b at %0t", expect_l2, dut.l2, $realtime);
        early_now = early_e;
        if ($realtime - early_changed_at > 3.0) begin
            if (dut.event_bit !== (early_now ^ expect_l2))
                $fatal(1, "event_bit: expected %b, got %b at %0t", early_now ^ expect_l2, dut.event_bit, $realtime);
            seen_event[early_now ^ expect_l2] = seen_event[early_now ^ expect_l2] + 1;
        end
        if (dut.bad_bit !== (expect_l1 ^ expect_l2))
            $fatal(1, "bad_bit: expected %b, got %b at %0t", expect_l1 ^ expect_l2, dut.bad_bit, $realtime);
        seen_l1_l2[{expect_l1, expect_l2}] = seen_l1_l2[{expect_l1, expect_l2}] + 1;
        readings_checked = readings_checked + 1;
    end

    // ========================================================================
    // TEST: the readings test above saw every case
    //
    // WHAT IT TESTS
    //   That the previous test was given something to find. If q_selected
    //   never changed between 50 and 100 ns, l1 would always equal l2 and a
    //   swapped wire could pass unnoticed. So all four l1,l2 combinations
    //   and both values of event_bit must have occurred.
    //
    // HOW
    //   Called once at the end of the run. It reads the counters the
    //   previous test filled in, fails if any of them is zero, and prints
    //   the totals.
    // ========================================================================
    task check_readings_were_exercised;
        begin
            if (seen_l1_l2[0] == 0 || seen_l1_l2[1] == 0 || seen_l1_l2[2] == 0 || seen_l1_l2[3] == 0)
                $fatal(1, "readings: not every l1,l2 combination occurred (%0d %0d %0d %0d)",
                       seen_l1_l2[0], seen_l1_l2[1], seen_l1_l2[2], seen_l1_l2[3]);
            if (seen_event[0] == 0 || seen_event[1] == 0)
                $fatal(1, "readings: event_bit was not seen both ways");
            $display("Later readings: l1, l2, event_bit, bad_bit right in %0d trials (l1,l2 = 00/01/10/11 seen %0d/%0d/%0d/%0d times) passed",
                     readings_checked, seen_l1_l2[0], seen_l1_l2[1], seen_l1_l2[2], seen_l1_l2[3]);
        end
    endtask

    // ========================================================================
    // TEST (on every count): a count pulse begins when b rises
    //
    // WHAT IT TESTS
    //   tick_n = ~(b & allow_count). It must go low because b rose, 150 ns
    //   into the trial, and for no other reason. This catches the NAND gate
    //   connected to the wrong signal, and allow_count changing while b is
    //   already high, which would start a pulse late.
    //
    // HOW
    //   Another block stores the time of every b rising edge in b_rose_at.
    //   This task is called on every falling edge of dut.tick_n. That edge
    //   must come exactly 1 ns after b rose; 1 ns is the NAND gate delay in
    //   the cell models.
    // ========================================================================
    task check_count_pulse_starts_on_b_rising;
        begin
            if ($realtime - b_rose_at != 1.0)
                $fatal(1, "count pulse began at %0t, not on a b rising edge", $realtime);
        end
    endtask

    // ========================================================================
    // TEST (on every count): a block never has more than TRIALS counts
    //
    // WHAT IT TESTS
    //   Counting must stop after 2^WIDTH - 1 trials. This is what the one
    //   odd wire in the trial counter is for: if n[1] were clocked like the
    //   other bits there would be 2^WIDTH counts. It also catches the stop
    //   logic (finished_inv, want_and, allow_ff) not closing the gate.
    //
    // HOW
    //   ticks is the testbench's own count of falling edges on dut.tick_n.
    //   It never reads n. ticks_at_run_rise is the value ticks had when run
    //   last rose. This task is called on every count; while run is high,
    //   ticks - ticks_at_run_rise must not exceed TRIALS. It fails at the
    //   moment of the extra count, not later.
    // ========================================================================
    task check_count_limit;
        begin
            if (dut.run === 1'b1 && ticks > ticks_at_run_rise + TRIALS)
                $fatal(1, "count %0d in one block at %0t, limit is %0d", ticks - ticks_at_run_rise, $realtime, TRIALS);
        end
    endtask

    // ========================================================================
    // TEST (on the first count of every block): the first counted trial is
    // a whole one
    //
    // WHAT IT TESTS
    //   run rises 100 ns into a trial. That trial began before run was high,
    //   so it must not be counted. The first count must belong to the next
    //   trial: one whose capture, late reading and super-late reading all
    //   happened after run rose.
    //
    // HOW
    //   Other blocks store when run rose, when capture rose, when b fell and
    //   when a_n rose, and count capture edges. This task is called on every
    //   count and acts on the first one after run rose. It requires exactly
    //   one capture rising edge since run rose, and the stored times in this
    //   order: run rose, then capture rose, then b fell, then a_n rose, then
    //   this count.
    // ========================================================================
    task check_first_count_is_a_whole_trial;
        begin
            if (dut.run === 1'b1 && ticks == ticks_at_run_rise + 1) begin
                if (captures != captures_at_run_rise + 1 || !(capture_rose_at > run_rose_at &&
                        b_fell_at > capture_rose_at && a_n_rose_at > b_fell_at))
                    $fatal(1, "first count at %0t does not belong to a whole trial after run rose at %0t",
                           $realtime, run_rose_at);
                first_counts_checked = first_counts_checked + 1;
            end
        end
    endtask

    // ========================================================================
    // TEST (always running): every count pulse is 100 ns wide
    //
    // WHAT IT TESTS
    //   tick_n stays low from b rising to b falling, which is 100 ns. That
    //   must hold for the last pulse of a block too. When the last count
    //   makes n[WIDTH] go high, nothing may close the gate until b falls by
    //   itself. A shorter last pulse would mean the stop logic acts in the
    //   middle of a pulse. Only reset is allowed to cut a pulse short.
    //
    // HOW
    //   Another block stores the time of every falling edge of dut.tick_n in
    //   tick_fell_at. This block wakes on every rising edge of dut.tick_n
    //   and requires exactly 100 ns between the two. It skips a pulse during
    //   which rst_n fell, and the first rise at power-up when no pulse has
    //   begun yet.
    // ========================================================================
    always @(posedge dut.tick_n)
        if (tick_fell_at >= 0.0 && rst_fell_at < tick_fell_at && $realtime - tick_fell_at != 100.0)
            $fatal(1, "count pulse ending at %0t was %0t wide, expected 100 ns", $realtime, $realtime - tick_fell_at);

    // ========================================================================
    // TEST (always running): k and fault are right after every count
    //
    // WHAT IT TESTS
    //   After each counted trial:
    //     k     = the number of events so far in this block
    //     fault = 1 if any trial so far in this block was bad, else 0
    //   Checking after every count, and not only at the end, shows the exact
    //   trial at which the event counter or the fault flip-flop goes wrong.
    //
    // HOW
    //   drive_trial decides for each trial whether it is an event
    //   (trial_event) and whether it is bad (trial_bad), then moves
    //   q_selected and early_e to make that happen. On every count while run
    //   is high, the block that counts ticks adds trial_event to event_sum
    //   and sets fault_ref if trial_bad; both are cleared when run falls.
    //   This block waits 40 ns after each count, so a carry has time to pass
    //   through every bit of k at 1 ns per flip-flop, and then compares
    //   result_k with event_sum and fault with fault_ref. It skips the
    //   comparison if run is low or rst_n is low by then.
    // ========================================================================
    always @(negedge dut.tick_n) begin : check_k_after_count
        #40;
        if (rst_n === 1'b1 && dut.run === 1'b1) begin
            if (result_k !== event_sum[WIDTH-1:0])
                $fatal(1, "k: expected %0d, got %0d at %0t", event_sum, result_k, $realtime);
            if (fault !== fault_ref)
                $fatal(1, "fault: expected %b, got %b at %0t", fault_ref, fault, $realtime);
            k_checks = k_checks + 1;
        end
    end

    // ========================================================================
    // TEST (always running): done rises at the right moment with the result
    // ready
    //
    // WHAT IT TESTS
    //   When done goes high, four things must be true:
    //     - it rose because b fell (done_ff is clocked by b falling)
    //     - exactly TRIALS counts have happened since run rose
    //     - the last count began exactly 100 ns earlier
    //     - k and fault already hold their final values
    //   The last point matters because the host reads the result as soon as
    //   it sees done.
    //
    // HOW
    //   It wakes on every rising edge of done and compares against values
    //   the other blocks keep: b_fell_at (must be 1 ns ago, the flip-flop
    //   delay), ticks - ticks_at_run_rise (must equal TRIALS), tick_fell_at
    //   (must be 100 ns ago), and event_sum and fault_ref (must equal
    //   result_k and fault).
    // ========================================================================
    always @(posedge done) begin
        if (result_k !== event_sum[WIDTH-1:0] || fault !== fault_ref)
            $fatal(1, "at done: expected k=%0d fault=%b, got k=%0d fault=%b", event_sum, fault_ref, result_k, fault);
        if ($realtime - b_fell_at != 1.0)
            $fatal(1, "done rose at %0t, not on a b falling edge", $realtime);
        if (ticks - ticks_at_run_rise != TRIALS)
            $fatal(1, "done rose after %0d counts, expected %0d", ticks - ticks_at_run_rise, TRIALS);
        if ($realtime - tick_fell_at != 100.0)
            $fatal(1, "done rose %0t after the last count began, expected 100 ns", $realtime - tick_fell_at);
    end

    // ========================================================================
    // TEST (always running): nothing moves while run is low
    //
    // WHAT IT TESTS
    //   run is wired to the reset pin of every bit of n and k, and of fault
    //   and done. While run is low they must all stay at 0. After an abort
    //   one more count pulse can still arrive, because allow_count is
    //   updated up to one trial later; that pulse must change nothing.
    //
    // HOW
    //   It wakes on every change of dut.n, result_k, fault or done. If run is
    //   0 and has been for more than 2 ns (time for the reset pins to act in
    //   the cell models), all four must be 0.
    // ========================================================================
    always @(dut.n or result_k or fault or done)
        if (dut.run === 1'b0 && $realtime - run_fell_at > 2.0 &&
                ((|dut.n) !== 1'b0 || (|result_k) !== 1'b0 || fault !== 1'b0 || done !== 1'b0))
            $fatal(1, "something moved while run is low: n=%b k=%b fault=%b done=%b at %0t",
                   dut.n, result_k, fault, done, $realtime);

    // ========================================================================
    // TEST (always running): busy = run & ~done
    //
    // WHAT IT TESTS
    //   busy is one inverter and one AND gate: high while a block is running
    //   and not yet finished. This catches done used without the inverter,
    //   or the AND gate reading the wrong signals.
    //
    // HOW
    //   20 ns after every clk20 rising edge, when all outputs have settled,
    //   it compares busy with dut.run & ~done. It skips the comparison while
    //   rst_n is low.
    // ========================================================================
    always @(posedge clk20) begin
        #20;
        if (rst_n === 1'b1 && busy !== (dut.run & ~done))
            $fatal(1, "busy: expected %b, got %b at %0t", dut.run & ~done, busy, $realtime);
    end

    // ========================================================================
    // TEST: reset clears a and b
    //
    // WHAT IT TESTS
    //   Holding rst_n low across two clk20 rising edges leaves a = 0 and
    //   b = 0. b has a reset pin and clears at once. a has no reset pin; it
    //   clears by loading b's 0 on a clk20 edge. Two edges is what the host
    //   procedure asks for.
    //
    // HOW
    //   Drive rst_n low, wait for two clk20 rising edges plus 5 ns for the
    //   cell-model delays, then read {dut.a, dut.b} and require 00.
    // ========================================================================
    task reset_and_check_cleared;
        begin
            rst_n = 1'b0;
            repeat (2) wait_clk20_edge();
            if (ab !== 2'b00)
                $fatal(1, "reset: after two clk20 edges expected a,b = 00, got %b at %0t", ab, $realtime);
        end
    endtask

    // ========================================================================
    // TEST: a and b step 00 -> 01 -> 11 -> 10 on every clk20 edge
    //
    // WHAT IT TESTS
    //   On every rising edge of clk20 the pair must do
    //       a <= b;
    //       b <= ~a;
    //   and a_n must be the opposite of a. This catches a missing inversion,
    //   the two flip-flops swapped, or either one on the wrong clock edge.
    //
    // HOW
    //   For `edges` clk20 edges in a row: remember {a, b}, wait for the edge
    //   plus 5 ns, and compare the new {a, b} with next_ab(), which is the
    //   two lines above written as a function. It also compares dut.a_n with
    //   ~dut.a each time.
    // ========================================================================
    task check_step_order(input integer edges);
        reg [1:0] was;
        begin
            repeat (edges) begin
                was = ab;
                wait_clk20_edge();
                if (ab !== next_ab(was))
                    $fatal(1, "step order: from %b expected %b, got %b at %0t", was, next_ab(was), ab, $realtime);
                if (dut.a_n !== ~dut.a)
                    $fatal(1, "a_n: expected %b, got %b at %0t", ~dut.a, dut.a_n, $realtime);
            end
        end
    endtask

    // ========================================================================
    // TEST: capture is high for 100 ns and repeats every 200 ns
    //
    // WHAT IT TESTS
    //   capture is a. With clk20 at 20 MHz it must be high for two clock
    //   periods and low for two, so one trial is 200 ns.
    //
    // HOW
    //   Record $realtime at a rising edge of capture, at the next falling
    //   edge and at the next rising edge. The differences must be exactly
    //   100 ns and 200 ns.
    // ========================================================================
    task check_capture_timing;
        realtime rose, fell;
        begin
            @(posedge capture);
            rose = $realtime;
            @(negedge capture);
            fell = $realtime;
            if (fell - rose != 100.0)
                $fatal(1, "capture high time: expected 100 ns, got %0t", fell - rose);
            @(posedge capture);
            if ($realtime - rose != 200.0)
                $fatal(1, "trial length: expected 200 ns, got %0t", $realtime - rose);
        end
    endtask

    // ========================================================================
    // TEST: reset arriving in any of the four steps
    //
    // WHAT IT TESTS
    //   When rst_n goes low in the middle of a clock period, with {a, b}
    //   holding `state`:
    //     - b goes to 0 at once
    //     - a does not move until the next clk20 edge, then goes to 0
    //     - both stay 0 while reset is held
    //     - after release the pair goes 00 -> 01 -> 11, so capture first
    //       rises on the second clk20 edge
    //   The same restart from all four steps shows reset leaves no memory of
    //   where the pair was.
    //
    // HOW
    //   Step clk20 edges until {a, b} equals `state`. 10 ns later pull rst_n
    //   low. 3 ns after that read dut.b (must be 0) and dut.a (must still be
    //   its old value, state[1]). After one more clk20 edge, and again after
    //   another, require 00. Release reset on a falling clk20 edge, then
    //   require 01 after the first rising edge and 11 after the second.
    //   Called once for each of 00, 01, 11 and 10.
    // ========================================================================
    task reset_while_in(input [1:0] state);
        begin
            wait_clk20_edge();
            while (ab !== state) wait_clk20_edge();
            #10 rst_n = 1'b0;
            #3;
            if (dut.b !== 1'b0)
                $fatal(1, "reset in %b: b must clear at once, got %b at %0t", state, dut.b, $realtime);
            if (dut.a !== state[1])
                $fatal(1, "reset in %b: a must wait for a clk20 edge, expected %b, got %b at %0t",
                       state, state[1], dut.a, $realtime);
            wait_clk20_edge();
            if (ab !== 2'b00)
                $fatal(1, "reset in %b: expected 00 after one clk20 edge, got %b at %0t", state, ab, $realtime);
            wait_clk20_edge();
            if (ab !== 2'b00)
                $fatal(1, "reset in %b: expected 00 to hold, got %b at %0t", state, ab, $realtime);

            release_reset();
            wait_clk20_edge();
            if (ab !== 2'b01)
                $fatal(1, "restart from %b: expected 01 on the first edge, got %b at %0t", state, ab, $realtime);
            wait_clk20_edge();
            if (ab !== 2'b11)
                $fatal(1, "restart from %b: expected 11 on the second edge, got %b at %0t", state, ab, $realtime);
        end
    endtask

    // ========================================================================
    // TEST: reset never makes a capture pulse shorter than 50 ns
    //
    // WHAT IT TESTS
    //   Because a has no reset pin, capture can only fall on a clk20 edge.
    //   The worst case is reset arriving just after capture rose: b clears,
    //   and a follows on the next clk20 edge, one clock period after it
    //   rose. So the shortest capture pulse reset can cause is 50 ns, never
    //   a sliver.
    //
    // HOW
    //   Another block measures every capture high pulse in the run and keeps
    //   the shortest in shortest_capture_high. This task is called after the
    //   four reset_while_in tests, one of which resets in step 11 just after
    //   capture rose. The shortest pulse seen must be exactly 50 ns.
    // ========================================================================
    task check_shortest_capture_pulse;
        begin
            if (shortest_capture_high != 50.0)
                $fatal(1, "shortest capture pulse: expected 50 ns (reset just after it rose), got %0t",
                       shortest_capture_high);
        end
    endtask

    // ========================================================================
    // TEST: run stays low while start is low
    //
    // WHAT IT TESTS
    //   With no request from the host, no block starts by itself.
    //
    // HOW
    //   Leave start at 0 for 5 trials, then read dut.run and require 0.
    // ========================================================================
    task check_run_stays_low_without_start;
        begin
            wait_trials(5);
            if (dut.run !== 1'b0)
                $fatal(1, "idle: run must stay low while start is low, got %b", dut.run);
        end
    endtask

    // ========================================================================
    // TEST: run follows start 200 to 402 ns later, wherever start changes
    //
    // WHAT IT TESTS
    //   start goes through two flip-flops in a row, both clocked by a_n
    //   rising: start_meta reads start, and run reads start_meta. So run
    //   must change one to two trials after start does. Sooner than 200 ns
    //   would mean run reads start directly, skipping start_meta. Later than
    //   402 ns would mean an extra stage or a missed edge.
    //
    // HOW
    //   Wait for capture to rise, wait `offset` ns more, and raise start.
    //   wait_run_and_check_delay then waits until dut.run is 1 and takes the
    //   moment it rose from run_rose_at, which another block records. The time
    //   since start was raised must be between 200 and 402 ns (the extra 2 ns
    //   is cell-model delay). The same is done for lowering start.
    //   Called for every offset from 0 to 199 ns, so start is changed at
    //   every 1 ns position in the trial, including right at the sampling
    //   edge.
    // ========================================================================
    task start_and_stop_at(input integer offset);
        begin
            @(posedge capture);
            #offset start = 1'b1;
            wait_run_and_check_delay(1'b1, "start");
            @(posedge capture);
            #offset start = 1'b0;
            wait_run_and_check_delay(1'b0, "stop");
        end
    endtask

    // ========================================================================
    // TEST: a start pulse or gap shorter than a trial can be missed
    //
    // WHAT IT TESTS
    //   start is only looked at once per trial, when a_n rises. A 100 ns
    //   pulse that fits between two of those edges is never seen, and
    //   neither is a 100 ns gap in start while a block is running. This is
    //   intended behaviour, not a fault: it is why the host must hold start
    //   as a level. The test pins the behaviour down so a change to it is
    //   noticed.
    //
    // HOW
    //   Wait for a_n to rise, wait 10 ns, raise start for 100 ns, then wait
    //   3 trials. run_rises, which counts every time run goes high, must not
    //   have changed. Then start a block normally, wait for a_n to rise,
    //   wait 10 ns, lower start for 100 ns, and wait 3 trials. run_falls
    //   must not have changed. Finally lower start for good.
    // ========================================================================
    task check_short_pulses_can_be_missed;
        integer rises_was;
        integer falls_was;
        begin
            rises_was = run_rises;
            @(posedge dut.a_n);
            #10  start = 1'b1;
            #100 start = 1'b0;
            wait_trials(3);
            if (run_rises != rises_was)
                $fatal(1, "a 100 ns start pulse between sampling edges must be missed");

            start = 1'b1;
            wait_run_and_check_delay(1'b1, "start");
            falls_was = run_falls;
            @(posedge dut.a_n);
            #10  start = 1'b0;
            #100 start = 1'b1;
            wait_trials(3);
            if (run_falls != falls_was)
                $fatal(1, "a 100 ns gap in start between sampling edges must be missed");
            start = 1'b0;
            wait_run_and_check_delay(1'b0, "stop");
        end
    endtask

    // ========================================================================
    // TEST: a start pulse longer than a trial is always seen
    //
    // WHAT IT TESTS
    //   A 250 ns pulse is longer than the 200 ns between sampling edges, so
    //   it must be seen wherever it begins, and seen as one request, not
    //   two.
    //
    // HOW
    //   Raise start `offset` ns after capture rises and lower it 250 ns
    //   later. Wait 4 trials. run_rises must have gone up by exactly one,
    //   and dut.run must be 0 again. Called with offsets 0, 25, ... 175.
    // ========================================================================
    task check_long_pulse_is_seen(input integer offset);
        integer rises_was;
        begin
            rises_was = run_rises;
            @(posedge capture);
            #offset start = 1'b1;
            #250    start = 1'b0;
            wait_trials(4);
            if (run_rises != rises_was + 1)
                $fatal(1, "250 ns start pulse at offset %0d: expected run to rise once, rose %0d times",
                       offset, run_rises - rises_was);
            if (dut.run !== 1'b0)
                $fatal(1, "250 ns start pulse at offset %0d: run must be low again, got %b", offset, dut.run);
        end
    endtask

    // ========================================================================
    // TEST: ena low makes start ignored
    //
    // WHAT IT TESTS
    //   The first flip-flop reads ena & start, not start alone. With ena low
    //   a high start does nothing, and dropping ena while a block is running
    //   stops it the same way dropping start does.
    //
    // HOW
    //   Set ena = 0 and start = 1 and wait 3 trials: run_rises must not
    //   change. Set ena = 1: run must rise within 200 to 402 ns. Set ena = 0
    //   again: run must fall within 200 to 402 ns. Then put ena back to 1
    //   and start back to 0.
    // ========================================================================
    task check_ena_gates_start;
        integer rises_was;
        begin
            rises_was = run_rises;
            ena   = 1'b0;
            start = 1'b1;
            wait_trials(3);
            if (run_rises != rises_was)
                $fatal(1, "ena low: start must be ignored");
            ena = 1'b1;
            wait_run_and_check_delay(1'b1, "ena high");
            ena = 1'b0;
            wait_run_and_check_delay(1'b0, "ena low");
            ena   = 1'b1;
            start = 1'b0;
            wait_trials(3);
        end
    endtask

    // ========================================================================
    // TEST: reset clears run and start_meta at once
    //
    // WHAT IT TESTS
    //   Both start flip-flops have rst_n on their reset pin, so rst_n low
    //   must force them to 0 without waiting for a clock. If start is still
    //   high when reset is released, run comes back by itself through the
    //   normal two-flip-flop path.
    //
    // HOW
    //   Raise start and wait for run. 7 ns later pull rst_n low; 3 ns after
    //   that dut.run and dut.start_meta must both be 0. Hold reset for two
    //   clk20 edges and release it. With start still high, run must be 1
    //   again within 200 to 402 ns of the release. Then lower start.
    // ========================================================================
    task check_reset_clears_run;
        begin
            start = 1'b1;
            wait_run_and_check_delay(1'b1, "start");
            #7 rst_n = 1'b0;
            #3;
            if (dut.run !== 1'b0 || dut.start_meta !== 1'b0)
                $fatal(1, "reset: run and start_meta must clear at once, got run=%b start_meta=%b at %0t",
                       dut.run, dut.start_meta, $realtime);
            repeat (2) wait_clk20_edge();
            release_reset();
            wait_run_and_check_delay(1'b1, "restart");
            start = 1'b0;
            wait_run_and_check_delay(1'b0, "stop");
        end
    endtask

    // ========================================================================
    // TEST: one whole block, as the host sees it
    //
    // WHAT IT TESTS
    //   The complete life of a block:
    //     - once run is high, busy = 1 and done = 0
    //     - done rises after exactly TRIALS counts, and busy drops
    //     - with start still high for 20 more trials there are no more
    //       counts, and done, k and fault do not move, even though events
    //       keep arriving
    //     - reading the low byte then the high byte, and the high byte then
    //       the low byte, both give k
    //     - k equals the testbench's own total of events
    //     - lowering start clears n, k, fault, done and busy
    //     - no count pulse appears after that
    //
    // HOW
    //   Raise start `offset` ns after capture rises and wait for run. Wait
    //   on capture edges until done is 1, failing if that takes more than
    //   TRIALS + 4 trials. The number of counts is ticks minus the value
    //   ticks had when run rose. Save result_k and fault, wait 20 trials and
    //   compare them again. Read both bytes through byte_sel in each order
    //   with read_bytes and compare with the saved k, then compare the saved
    //   k with event_sum. Lower start, wait for run to fall, call
    //   check_cleared, wait 2 trials and check the count has not grown.
    //   Called from many start offsets, and once per pattern by run_pattern.
    // ========================================================================
    task run_whole_block(input integer offset);
        integer ticks_was;
        integer waited;
        reg [15:0] read_low_first;
        reg [15:0] read_high_first;
        begin
            @(posedge capture);
            #offset start = 1'b1;
            wait_run_and_check_delay(1'b1, "start");
            ticks_was = ticks_at_run_rise;
            #3;
            if (busy !== 1'b1 || done !== 1'b0)
                $fatal(1, "block start: expected busy=1 done=0, got busy=%b done=%b at %0t", busy, done, $realtime);
            waited = 0;
            while (done !== 1'b1) begin
                @(posedge capture);
                waited = waited + 1;
                if (waited > TRIALS + 4)
                    $fatal(1, "block: done never rose, %0d counts seen", ticks - ticks_was);
            end
            if (ticks - ticks_was != TRIALS)
                $fatal(1, "block: expected %0d counts, got %0d", TRIALS, ticks - ticks_was);
            if (busy !== 1'b0)
                $fatal(1, "block end: busy must be 0 once done is 1");
            final_k = result_k;
            final_fault = fault;

            wait_trials(20);
            if (ticks - ticks_was != TRIALS)
                $fatal(1, "after done: expected no more counts, got %0d extra", ticks - ticks_was - TRIALS);
            if (done !== 1'b1 || busy !== 1'b0)
                $fatal(1, "after done: expected done=1 busy=0 to hold, got done=%b busy=%b", done, busy);
            if (result_k !== final_k[WIDTH-1:0] || fault !== final_fault)
                $fatal(1, "after done: expected k=%0d fault=%b to hold, got k=%0d fault=%b",
                       final_k, final_fault, result_k, fault);

            read_bytes(1'b0, read_low_first);
            read_bytes(1'b1, read_high_first);
            if (read_low_first !== final_k[15:0] || read_high_first !== final_k[15:0])
                $fatal(1, "byte read: expected %0d, got %0d (low byte first) and %0d (high byte first)",
                       final_k, read_low_first, read_high_first);
            if (final_k != event_sum)
                $fatal(1, "block: expected k=%0d from the testbench's own total, got %0d", event_sum, final_k);

            start = 1'b0;
            wait_run_and_check_delay(1'b0, "stop");
            check_cleared("stop");
            wait_trials(2);
            if (ticks - ticks_was != TRIALS)
                $fatal(1, "after stop: a count pulse appeared with nothing running");
            blocks_run = blocks_run + 1;
        end
    endtask

    // ========================================================================
    // TEST: lowering start in the middle of a block
    //
    // WHAT IT TESTS
    //   If the host gives up part-way, run falls and n, k, fault, done and
    //   busy all go to 0 and stay there. allow_count is reset by rst_n, not
    //   by run, so it can stay high for up to one trial after run falls. At
    //   most one more count pulse may therefore appear, and it must change
    //   nothing.
    //
    // HOW
    //   Raise start, wait for run, and wait until `after_counts` counts have
    //   happened. At the next capture plus `offset` ns lower start. Wait for
    //   run to fall and call check_cleared. Wait 3 trials: ticks may have
    //   grown by at most 1 since run fell, and check_cleared must still
    //   pass. Called with offsets 25, 75, 125 and 175 ns, one in each quarter
    //   of the trial, after 1 count and in mid-block, and at the two short
    //   block lengths also on the very last trial.
    // ========================================================================
    task abort_block(input integer after_counts, input integer offset);
        integer ticks_was;
        integer ticks_at_stop;
        begin
            start = 1'b1;
            wait_run_and_check_delay(1'b1, "start");
            ticks_was = ticks_at_run_rise;
            while (ticks - ticks_was < after_counts) @(posedge capture);
            @(posedge capture);
            #offset start = 1'b0;
            wait_run_and_check_delay(1'b0, "abort");
            ticks_at_stop = ticks;
            check_cleared("abort");
            wait_trials(3);
            if (ticks - ticks_at_stop > 1)
                $fatal(1, "abort: %0d count pulses after run fell, at most 1 allowed", ticks - ticks_at_stop);
            check_cleared("abort");
            aborts_run = aborts_run + 1;
        end
    endtask

    // ========================================================================
    // TEST: reset in the middle of a block
    //
    // WHAT IT TESTS
    //   rst_n low while a block is running must clear run and allow_count at
    //   once, and through run everything else: n, k, fault, done and busy.
    //   After reset is released with start low, nothing may come back.
    //
    // HOW
    //   Raise start, wait for run, and let 5 trials go by. `offset` ns after
    //   a capture edge pull rst_n low and lower start. 3 ns later dut.run
    //   and dut.allow_count must be 0 and check_cleared must pass. Hold reset
    //   for two clk20 edges, release it, wait 5 trials (the 1 us the host
    //   procedure asks for) and call check_cleared again. Called with offsets
    //   10, 60, 110 and 160 ns, one in each quarter of the trial; the last
    //   lands inside a count pulse.
    // ========================================================================
    task reset_during_block(input integer offset);
        begin
            start = 1'b1;
            wait_run_and_check_delay(1'b1, "start");
            wait_trials(5);
            #offset rst_n = 1'b0;
            start = 1'b0;
            #3;
            if (dut.run !== 1'b0 || dut.allow_count !== 1'b0)
                $fatal(1, "reset in block: expected run=0 allow_count=0, got run=%b allow_count=%b at %0t",
                       dut.run, dut.allow_count, $realtime);
            check_cleared("reset in block");
            repeat (2) wait_clk20_edge();
            release_reset();
            wait_trials(5);
            check_cleared("after reset");
        end
    endtask

    // ========================================================================
    // TEST: a whole block with a chosen pattern of events and bad trials
    //
    // WHAT IT TESTS
    //   That k and fault end with known values for known input:
    //     no events            -> k = 0
    //     every trial an event -> k = TRIALS, every bit of k high
    //     every other trial    -> k = 2^(WIDTH-1)
    //     random events        -> k = the testbench's own total
    //     no bad trial         -> fault = 0
    //     one bad trial, placed first, in the middle, or last
    //                          -> fault = 1, and the block still runs to the
    //                             full count
    //
    // HOW
    //   Set event_pattern and bad_at. drive_trial reads them at every capture
    //   to decide whether that trial is an event and whether it is bad, and
    //   moves q_selected and early_e to match. Run run_whole_block(0), which
    //   also applies all of its own checks. Then compare the k it saved with
    //   `want_k` (skipped when want_k is negative) and the fault it saved
    //   with `want_fault`. Put the pattern back to random afterwards.
    // ========================================================================
    task run_pattern(input integer events, input integer bad, input integer want_k, input want_fault);
        begin
            event_pattern = events;
            bad_at = bad;
            run_whole_block(0);
            if (want_k >= 0 && final_k != want_k)
                $fatal(1, "pattern %0d: expected k=%0d, got %0d", events, want_k, final_k);
            if (final_fault !== want_fault)
                $fatal(1, "pattern %0d, bad trial %0d: expected fault=%b, got %b", events, bad, want_fault, final_fault);
            event_pattern = EVENTS_RANDOM;
            bad_at = BAD_RANDOM;
        end
    endtask

    // ========================================================================
    // TEST: the longest carry in k, on the very last trial
    //
    // WHAT IT TESTS
    //   The slowest thing k can do is go from 0111...1 to 1000...0: every
    //   bit changes, one after another, each clocked by the bit below. The
    //   worst moment for that is the last trial of a block, because done
    //   follows 100 ns later and the host then reads k. The carry must have
    //   finished by then.
    //
    // HOW
    //   The EVENTS_LAST_CARRY pattern makes the first 2^(WIDTH-1) - 1 trials
    //   events, then no events, then the last trial an event. Another block
    //   copies result_k into k_before_last_trial at the capture edge of the
    //   last trial. After the block, k_before_last_trial must be
    //   2^(WIDTH-1) - 1 and the final k must be 2^(WIDTH-1). The always
    //   running test on done has already required k to be final at the
    //   moment done rose.
    // ========================================================================
    task check_last_carry;
        begin
            run_pattern(EVENTS_LAST_CARRY, BAD_NEVER, HALF, 1'b0);
            if (k_before_last_trial !== HALF - 1)
                $fatal(1, "last carry: expected k=%0d before the last trial, got %0d", HALF - 1, k_before_last_trial);
        end
    endtask

    localparam integer OFFSET_STEP  = (WIDTH <= 4) ? 1 : (WIDTH <= 8) ? 3 : 50;
    localparam integer ABORT_MIDDLE = (TRIALS > 2000) ? 1000 : TRIALS / 2;

    integer offset;

    initial begin
        if ($value$plusargs("vcd=%s", vcd_path)) begin
            $dumpfile(vcd_path);
            $dumpvars(0, tb_compact_control);
        end

        reset_and_check_cleared();
        release_reset();
        check_step_order(40);
        check_capture_timing();
        $display("Trial clock: 00 -> 01 -> 11 -> 10 order, 100 ns high, 200 ns trial passed");

        reset_while_in(2'b00);
        reset_while_in(2'b01);
        reset_while_in(2'b11);
        reset_while_in(2'b10);
        check_step_order(8);
        check_shortest_capture_pulse();
        $display("Reset in each of the four steps: cleared, restarted, shortest capture pulse 50 ns passed");

        check_run_stays_low_without_start();
        for (offset = 0; offset < 200; offset = offset + 1)
            start_and_stop_at(offset);
        $display("Start and stop at every 1 ns offset in the trial: run follows after 200 to 402 ns passed");

        check_short_pulses_can_be_missed();
        for (offset = 0; offset < 200; offset = offset + 25)
            check_long_pulse_is_seen(offset);
        check_ena_gates_start();
        check_reset_clears_run();
        $display("Short pulses missed, 250 ns pulses seen, ena gates start, reset clears run passed");

        for (offset = 0; offset < 200; offset = offset + OFFSET_STEP)
            run_whole_block(offset);
        $display("Whole block from %0d start offsets: exactly %0d counts, done 100 ns after the last, nothing after passed",
                 blocks_run, TRIALS);

        for (offset = 25; offset < 200; offset = offset + 50) begin
            abort_block(1, offset);
            abort_block(ABORT_MIDDLE, offset);
            if (WIDTH <= 8) begin
                abort_block(TRIALS - 1, offset);
                run_whole_block(offset);
            end
        end
        for (offset = 10; offset < 200; offset = offset + 50)
            reset_during_block(offset);
        run_whole_block(0);
        $display("%0d aborts and 4 resets inside a block: everything cleared, next block whole (%0d first counts checked) passed",
                 aborts_run, first_counts_checked);

        run_pattern(EVENTS_NONE,      BAD_NEVER, 0,      1'b0);
        run_pattern(EVENTS_ALL,       BAD_NEVER, TRIALS, 1'b0);
        run_pattern(EVENTS_ALTERNATE, BAD_NEVER, HALF,   1'b0);
        run_pattern(EVENTS_RANDOM,    BAD_NEVER, -1,     1'b0);
        check_last_carry();
        $display("Event patterns: none -> k=0, all -> k=%0d, alternate -> k=%0d, random, and %0d -> %0d on the last trial passed",
                 TRIALS, HALF, HALF - 1, HALF);

        run_pattern(EVENTS_RANDOM, 0,          -1, 1'b1);
        run_pattern(EVENTS_RANDOM, TRIALS / 2, -1, 1'b1);
        run_pattern(EVENTS_RANDOM, TRIALS - 1, -1, 1'b1);
        $display("One bad trial first, in the middle, or last: fault stays set, the block still counts %0d passed", TRIALS);
        $display("k and fault matched the testbench's own totals after each of %0d counts, and both byte orders read back k", k_checks);

        check_readings_were_exercised();

        $finish;
    end

    initial begin
        #(2000000.0 + 400.0 * 200.0 * TRIALS);
        $fatal(1, "Timed out");
    end
endmodule

`default_nettype wire
