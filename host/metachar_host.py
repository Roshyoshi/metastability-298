# Host program for tt_um_metastability_characterizer (controller: compact_control) on the Tiny
# Tapeout demo board. MicroPython, for the board's RP2040 or RP2350 running tt-micropython-firmware
# (SDK v3: ttboard.demoboard.DemoBoard).
#
# NOT TESTED ON HARDWARE: no chip exists yet. Written against the SDK as of commit 15ba5ce
# (12 Nov 2026) and the tile's pinout in info.yaml. Check every pin against the shuttle's datasheet
# before use.
#
# Pins of the tile (info.yaml):
#   clk            20 MHz from the RP2 (clock_project_PWM)
#   rst_n          reset, active low
#   ui_in[0]       byte_sel: 0 puts K[7:0] on uo_out, 1 puts K[15:8]
#   ui_in[3]       dut_select[0]        uio_in[6]  dut_select[1]  (the RP2 drives uio[6])
#   ui_in[4]       start: a level. Raise it and hold it for one block; lower it to clear K, done and
#                  fault. busy rises 200 to 400 ns after start.
#   ui_in[6]       data_in: an asynchronous square wave from an external oscillator, or the
#                  once-per-trial toggle produced by this program (PIO) for the toggle test
#   uo_out[7:0]    one byte of the event count K
#   uio_out[1]     busy    uio_out[2] done    uio_out[3] fault
#   uio_out[4]     capture monitor    uio_out[5] early-sample monitor  (to the oscilloscope)
#   ua[0]          delay_control: analog voltage, 1.0 to 1.4 V in the useful range (see class DAC)
#
# A block is 65,535 trials of 200 ns, 13.107 ms. Selection {uio[6], ui[3]}: 00 DUT1 (library
# flip-flop dffq_1), 01 DUT2 (NAND, baseline), 10 DUT3 (keeper doubled), 11 DUT4 (forward gate
# doubled).
#
# Data file written by save_csv (one row per control voltage and flip-flop):
#   V        control voltage set on ua[0] (V); record the voltmeter reading separately
#   dut      1 to 4
#   events   sum of K over the accepted blocks
#   trials   65,535 x accepted blocks
#   blocks   accepted blocks
#   faults   blocks discarded because fault was set
#   source   "async" (external oscillator) or "toggle" (PIO toggle test)

import time
import machine
import rp2
from ttboard.demoboard import DemoBoard
from ttboard.mode import RPMode

PROJECT = "tt_um_metastability_characterizer"
CLOCK_HZ = 20_000_000
TRIALS_PER_BLOCK = 65_535
BLOCK_MS = 13.107                      # 65,535 x 200 ns
DUT_CODE = {1: 0b00, 2: 0b01, 3: 0b10, 4: 0b11}
V_CONTROL_MAX = 2.5                    # never drive ua[0] above this from the program


class DAC:
    """Control voltage on ua[0]. Example driver for an AD5693R (16-bit, I2C, internal 2.5 V
    reference), powered from 3.3 V and used at gain x1, so that its output cannot exceed 2.5 V.
    One step is 38 uV. Put an RC low-pass at the pin (for example 1 kOhm and 10 uF) and wait at
    least 10 time constants after each change. Measure ua[0] at the board with a voltmeter of five
    digits or more and record that reading, not the set value: near 1.2 V the delay changes by
    about 4 ps per millivolt, and tau is 110 to 170 ps.
    Give it the I2C bus of two free RP2 pins (see the demo board's schematic) or replace it with
    whatever sets the voltage on the bench."""
    ADDR = 0x4C                        # A0 low

    def __init__(self, i2c, vref=2.5):
        self.i2c, self.span = i2c, vref
        self.i2c.writeto(self.ADDR, bytes([0x40, 0x00, 0x00]))   # control: gain x1, internal reference on

    def set(self, volts):
        if not 0.0 <= volts <= V_CONTROL_MAX:
            raise ValueError("control voltage outside 0 to %.1f V" % V_CONTROL_MAX)
        code = max(0, min(65535, int(round(volts / self.span * 65536))))
        self.i2c.writeto(self.ADDR, bytes([0x30, code >> 8, code & 0xFF]))  # write and update DAC
        return code * self.span / 65536


@rp2.asm_pio(set_init=rp2.PIO.OUT_LOW)
def _toggle_after_capture():
    # Toggle test: data that change once per trial, far from the capture edge. The capture monitor
    # (uio_out[4]) is high from 0 to 100 ns of each 200 ns trial; ui_in[6] changes at each of its
    # falling edges, about 100 ns before the next capture.
    wrap_target()
    wait(1, pin, 0)
    wait(0, pin, 0)
    set(pins, 1)
    wait(1, pin, 0)
    wait(0, pin, 0)
    set(pins, 0)
    wrap()


class Characterizer:
    def __init__(self, dac=None):
        tt = DemoBoard.get()
        tt.mode = RPMode.ASIC_RP_CONTROL
        getattr(tt.shuttle, PROJECT).enable()
        tt.uio_oe_pico.value = 1 << 6       # the RP2 drives uio[6] only; uio[1] to uio[5] are tile outputs
        tt.ui_in.value = 0                  # start low, byte_sel low, DUT1
        tt.uio_in[6] = 0
        self.tt, self.dac, self.sm = tt, dac, None
        self.source = "async"
        self.external_data()
        tt.clock_project_PWM(CLOCK_HZ)       # may change the RP2's system clock (see toggle_data)
        self.reset()

    # ---- basic operations ---------------------------------------------------------------------
    def reset(self):
        self.tt.ui_in[4] = 0
        self.tt.reset_project(True)
        time.sleep_ms(2)
        self.tt.reset_project(False)
        time.sleep_ms(2)

    def select(self, dut):
        code = DUT_CODE[dut]
        self.tt.ui_in[3] = code & 1
        self.tt.uio_in[6] = (code >> 1) & 1

    def set_control(self, volts, settle_ms=200):
        if self.dac is None:
            raise RuntimeError("no DAC configured: set ua[0] by hand and record the voltmeter reading")
        v = self.dac.set(volts)
        time.sleep_ms(settle_ms)
        return v

    def read_k(self):
        tt = self.tt
        tt.ui_in[0] = 0
        lo = int(tt.uo_out.value)
        tt.ui_in[0] = 1
        hi = int(tt.uo_out.value)
        tt.ui_in[0] = 0
        return (hi << 8) | lo

    def block(self, timeout_ms=40):
        """One block of 65,535 trials. Returns (K, fault). K is read after done, when the counter
        receives no more clock edges."""
        tt = self.tt
        if tt.uio_out[2] or tt.uio_out[1]:
            raise RuntimeError("done or busy high before start: lower start and wait")
        tt.ui_in[4] = 1                              # start, held high for the whole block
        t0 = time.ticks_ms()
        time.sleep_ms(1)
        if not tt.uio_out[1]:
            tt.ui_in[4] = 0
            raise RuntimeError("busy did not rise: check the clock, reset, ena and project selection")
        time.sleep_ms(13)
        while not tt.uio_out[2]:                     # done
            if time.ticks_diff(time.ticks_ms(), t0) > timeout_ms:
                tt.ui_in[4] = 0
                raise RuntimeError("done did not rise within %d ms" % timeout_ms)
        fault = 1 if tt.uio_out[3] else 0
        k = self.read_k()
        tt.ui_in[4] = 0                              # clears K, done and fault within 400 ns
        t1 = time.ticks_us()
        while tt.uio_out[2]:
            if time.ticks_diff(time.ticks_us(), t1) > 2000:
                raise RuntimeError("done did not fall after start was lowered")
        return k, fault

    def count(self, dut, n_blocks=None, min_events=None, max_blocks=10_000_000):
        """Run blocks on one flip-flop; stop after n_blocks accepted blocks, or once min_events have
        been counted. Blocks that end with fault set are discarded and counted separately."""
        self.select(dut)
        events = blocks = faults = 0
        while blocks + faults < max_blocks:
            k, fault = self.block()
            if fault:
                faults += 1
                continue
            events += k
            blocks += 1
            if n_blocks is not None and blocks >= n_blocks:
                break
            if min_events is not None and events >= min_events:
                break
        return {"dut": dut, "events": events, "trials": blocks * TRIALS_PER_BLOCK,
                "blocks": blocks, "faults": faults, "source": self.source}

    # ---- data sources -------------------------------------------------------------------------
    def external_data(self):
        """Release ui_in[6] so that the external asynchronous oscillator drives it. The RP2 cannot
        produce this signal itself: everything it generates is locked to the clock that also makes
        the 20 MHz, so its edges would fall at a few fixed positions relative to capture."""
        if self.sm is not None:
            self.sm.active(0)
            self.sm = None
        self.tt.pins.ui_in6.mode = machine.Pin.IN
        self.source = "async"

    def hold_data(self, level=0):
        """Drive ui_in[6] with a constant level (disconnect the external oscillator first)."""
        self.external_data()
        self.tt.pins.ui_in6.mode = machine.Pin.OUT
        self.tt.pins.ui_in6.raw_pin.value(level)
        self.source = "static"

    def toggle_data(self):
        """Drive ui_in[6] with data that change once per trial (disconnect the external oscillator
        first). The state machine runs at the RP2's system clock, which clock_project_PWM may
        have changed."""
        self.external_data()
        mon = self.tt.pins.uio4.raw_pin
        out = self.tt.pins.ui_in6.raw_pin
        self.sm = rp2.StateMachine(0, _toggle_after_capture, freq=machine.freq(),
                                   in_base=mon, set_base=out)
        self.sm.active(1)
        self.source = "toggle"

    # ---- bring-up and measurement procedures --------------------------------------------------
    def bringup(self, dut=2, v_short=2.5, v_long=1.0):
        """Checks that need no oscillator. Expected: constant data gives K = 0; toggled data with
        a short delay (high control voltage) gives K = 65,535, every trial an event; toggled data
        with a long delay gives K = 0. Times one block."""
        out = {}
        self.select(dut)
        self.hold_data(0)
        t0 = time.ticks_us()
        out["static"] = self.block()
        out["block_ms"] = time.ticks_diff(time.ticks_us(), t0) / 1000
        self.toggle_data()
        if self.dac is not None:
            self.set_control(v_short)
            out["toggle_short_d"] = self.block()
            self.set_control(v_long)
            out["toggle_long_d"] = self.block()
        else:
            out["toggle"] = self.block()
        self.external_data()
        print("bring-up:", out)
        return out

    def toggle_scan(self, dut, volts, blocks_per_step=2):
        """Toggle test: K / 65,535 falls from 1 through about 1/2 to 0 as the delay passes the
        floors of the two directions of the data, where the flip-flop's new value stops reaching
        the early observer in time. Fit only control voltages well below both floors (longer
        delay). Measure the delay at each step on the oscilloscope."""
        self.toggle_data()
        out = []
        for v in volts:
            self.set_control(v)
            r = self.count(dut, n_blocks=blocks_per_step)
            frac = r["events"] / max(1, r["trials"])
            out.append((v, frac))
            print("toggle scan dut%d V=%.4f fraction %.4f" % (dut, v, frac))
        self.external_data()
        return out

    def survey(self, duts, volts, min_events=200, max_blocks=300_000):
        """Counts at each control voltage for each flip-flop in turn, with the external
        asynchronous oscillator on ui_in[6]. Interleaving the flip-flops at each setting makes
        their ratios insensitive to drift of the delay."""
        self.external_data()
        rows = []
        for v in volts:
            if self.dac is not None:
                self.set_control(v)
            for dut in duts:
                r = self.count(dut, min_events=min_events, max_blocks=max_blocks)
                r["V"] = v
                rows.append(r)
                print("V=%.5f dut%d events=%d trials=%d faults=%d" % (v, dut, r["events"], r["trials"], r["faults"]))
        return rows


def save_csv(rows, path="survey.csv"):
    with open(path, "w") as f:
        f.write("V,dut,events,trials,blocks,faults,source\n")
        for r in rows:
            f.write("%.6f,%d,%d,%d,%d,%d,%s\n" % (r["V"], r["dut"], r["events"], r["trials"],
                                                  r["blocks"], r["faults"], r["source"]))
