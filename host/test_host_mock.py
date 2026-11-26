#!/usr/bin/env python3
"""Runs metachar_host.py under CPython against a software model of the demo board and the tile.

The model follows src/gf180/compact_control.v at the level the host sees: start is a level, busy
rises about 300 ns later, done rises 13.107 ms after that, K is held until start is lowered, and
byte_sel picks the byte on uo_out. Events are drawn from a probability per trial that the test
sets. It checks the host's handshake, byte order, fault handling and accounting. It says nothing
about the chip itself.
"""
import sys, types, time as _t, random

# ---- minimal stand-ins for the MicroPython modules --------------------------------------------
clock = {"t": 0.0}                                   # simulated seconds


def _advance(dt):
    clock["t"] += dt
    CHIP.update()


fake_time = types.ModuleType("time")
fake_time.sleep_ms = lambda ms: _advance(ms * 1e-3)
fake_time.sleep_us = lambda us: _advance(us * 1e-6)
fake_time.ticks_ms = lambda: int(clock["t"] * 1e3)
fake_time.ticks_us = lambda: int(clock["t"] * 1e6)
fake_time.ticks_diff = lambda a, b: a - b

machine = types.ModuleType("machine")
class Pin:
    IN, OUT = 0, 1
    def __init__(self, n): self.n, self.v, self.mode = n, 0, Pin.IN
    def init(self, mode, pull=-1): self.mode = mode
    def value(self, v=None):
        if v is None: return self.v
        self.v = v
machine.Pin = Pin
machine.freq = lambda: 120_000_000

rp2 = types.ModuleType("rp2")
class PIO: OUT_LOW = 0
rp2.PIO = PIO
rp2.asm_pio = lambda **kw: (lambda f: f)
class StateMachine:
    def __init__(self, i, prog, freq, in_base, set_base):
        assert freq <= machine.freq()
        self.active_flag = 0
        CHIP.toggling = False
    def active(self, x):
        self.active_flag = x
        CHIP.toggling = bool(x)
rp2.StateMachine = StateMachine


class Port:
    def __init__(self, name, n=8, on_write=None):
        self.name, self.bits, self.on_write = name, [0] * n, on_write
    def __getitem__(self, i):
        CHIP.update(); return self.bits[i]
    def __setitem__(self, i, v):
        self.bits[i] = 1 if v else 0
        _advance(10e-6)                              # a MicroPython pin write takes some microseconds
        if self.on_write: self.on_write()
    @property
    def value(self):
        CHIP.update(); return sum(b << i for i, b in enumerate(self.bits))
    @value.setter
    def value(self, v):
        self.bits = [(v >> i) & 1 for i in range(len(self.bits))]
        if self.on_write: self.on_write()


class Chip:
    """The tile as the host sees it."""
    def __init__(self):
        self.p_event = 0.0
        self.p_fault_block = 0.0
        self.toggling = False
        self.static = False
        self.reset_state()
    def reset_state(self):
        self.run = False; self.t_run = None; self.k = 0; self.fault = 0; self.done = False
    def update(self):
        tt = BOARD
        if tt is None or not tt.enabled or not tt.clock: return
        start = tt.ui_in.bits[4]
        now = clock["t"]
        if start and not self.run:
            self.run = True; self.t_run = now + 300e-9
            self.k = 0; self.fault = 0; self.done = False
            self.decided = False
        if not start and self.run:
            self.reset_state()
        if self.run and not self.done and now >= self.t_run + 65_535 * 200e-9 + 100e-9:
            # the whole block happened: draw its result
            if self.toggling:
                p = 1.0 if self.short_d else 0.0
            elif self.static:
                p = 0.0
            else:
                p = self.p_event
            self.k = sum(1 for _ in range(65_535) if random.random() < p) if 0 < p < 1 else int(65_535 * p)
            self.nblock = getattr(self, 'nblock', 0) + 1
            self.fault = 1 if (self.p_fault_block and self.nblock % 3 == 0) else 0   # every third block
            self.done = True
        busy = self.run and now >= self.t_run and not self.done
        tt.uio_out.bits[1] = 1 if busy else 0
        tt.uio_out.bits[2] = 1 if self.done else 0
        tt.uio_out.bits[3] = self.fault if self.done else 0
        byte = (self.k >> 8) & 0xFF if tt.ui_in.bits[0] else self.k & 0xFF
        tt.uo_out.bits = [(byte >> i) & 1 for i in range(8)]


class Pins:
    def __init__(self):
        for name in ["ui_in%d" % i for i in range(8)] + ["uio%d" % i for i in range(8)]:
            setattr(self, name, types.SimpleNamespace(raw_pin=Pin(0), mode=Pin.IN))


class Board:
    def __init__(self):
        self.enabled = False; self.clock = 0
        self.ui_in = Port("ui_in", on_write=lambda: CHIP.update())
        self.uio_in = Port("uio_in"); self.uio_out = Port("uio_out"); self.uo_out = Port("uo_out")
        self.uio_oe_pico = Port("uio_oe_pico")
        self.pins = Pins(); self.mode = None
        proj = types.SimpleNamespace(enable=self._enable)
        self.shuttle = types.SimpleNamespace(tt_um_metastability_characterizer=proj)
    def _enable(self): self.enabled = True
    def clock_project_PWM(self, hz): self.clock = hz
    def reset_project(self, r):
        if r: CHIP.reset_state()


BOARD = None
CHIP = Chip()
CHIP.short_d = True

ttboard = types.ModuleType("ttboard"); demo = types.ModuleType("ttboard.demoboard"); mode = types.ModuleType("ttboard.mode")
class DemoBoard:
    @staticmethod
    def get():
        global BOARD
        if BOARD is None: BOARD = Board()
        return BOARD
demo.DemoBoard = DemoBoard
mode.RPMode = types.SimpleNamespace(ASIC_RP_CONTROL=1)

real_time = sys.modules["time"]
sys.modules.update({"machine": machine, "rp2": rp2, "ttboard": ttboard, "ttboard.demoboard": demo,
                    "ttboard.mode": mode, "time": fake_time})
import metachar_host as mh
sys.modules["time"] = real_time


class FakeDAC:
    def set(self, v):
        CHIP.short_d = v > 2.0
        return v


def main():
    random.seed(3)
    c = mh.Characterizer(dac=FakeDAC())
    assert BOARD.clock == 20_000_000 and BOARD.uio_oe_pico.value == 0x40

    # Bring-up: static data -> 0; toggle, short delay -> 65,535; toggle, long delay -> 0
    out = c.bringup(dut=2, v_short=2.5, v_long=1.0)
    assert out["static"] == (0, 0), out
    assert out["toggle_short_d"] == (65_535, 0), out
    assert out["toggle_long_d"] == (0, 0), out
    assert 13.1 <= out["block_ms"] <= 14.5, out

    # Byte order: K = 0x1234 must read back as 0x1234
    CHIP.p_event = 0.0
    CHIP.update()
    c.select(3)
    BOARD.ui_in[4] = 1
    _advance(20e-3)
    CHIP.k = 0x1234
    CHIP.update()
    assert c.read_k() == 0x1234
    BOARD.ui_in[4] = 0
    _advance(1e-3)

    # Selection pins
    for dut, code in mh.DUT_CODE.items():
        c.select(dut)
        assert (BOARD.uio_in.bits[6] << 1 | BOARD.ui_in.bits[3]) == code

    # Accounting with events and faulted blocks
    CHIP.p_event = 2e-3
    CHIP.p_fault_block = 0.25
    r = c.count(2, n_blocks=8)
    assert r["blocks"] == 8 and r["trials"] == 8 * 65_535 and r["faults"] >= 1, r
    assert abs(r["events"] / r["trials"] - 2e-3) < 4 * (2e-3 / r["trials"]) ** 0.5, r
    CHIP.p_fault_block = 0.0
    r = c.count(4, min_events=1000)
    assert r["events"] >= 1000 and r["faults"] == 0, r

    # A block started while done is still high must be refused
    BOARD.ui_in[4] = 1
    _advance(20e-3)
    try:
        c.block()
        raise AssertionError("block() started while done was high")
    except RuntimeError:
        pass
    BOARD.ui_in[4] = 0
    _advance(1e-3)
    print("mock test passed:", out)


if __name__ == "__main__":
    main()
