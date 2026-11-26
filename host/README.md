# Measuring the chip

Programs for the measurement described in `docs/info.md`. None has been run on hardware: no chip exists yet.

| File | Runs on | What it does |
|---|---|---|
| `metachar_host.py` | the demo board's RP2040 or RP2350, MicroPython with the Tiny Tapeout SDK (`ttboard`) | Selects the project, clocks it at 20 MHz, runs blocks and reads K, runs the bring-up checks, the toggle scan and the survey, and writes a CSV file |
| `fit_tau.py` | a computer, Python 3 with numpy | Fits ln(K) against *d* by Poisson maximum likelihood and prints τ, its error, the local slopes and the ratios of τ; `--selftest` checks the fit on synthetic counts |
| `test_host_mock.py` | a computer, Python 3 | Runs `metachar_host.py` against a software model of the board and the tile, to check its handshake, byte order, fault handling and accounting |

    python3 fit_tau.py --selftest            # synthetic counts, labelled as such; no measurement
    python3 test_host_mock.py                # host program against a model; no hardware

## The bench

- **Data.** A square wave on `ui[6]` from a source with its own time base: a function generator or a crystal
  oscillator. Choose a frequency of a few megahertz that is not a multiple or simple fraction of 5 MHz, the trial
  rate. The RP2 cannot make this signal: everything it produces is derived from the clock that also makes the
  20 MHz, so its edges would fall at a few fixed positions relative to capture. Check the independence on the chip:
  K divided by the data frequency must not change when the frequency is moved by a few percent.
- **Control voltage.** `ua[0]`, between 1.0 and 1.4 V in the useful range. Between 1.3 and 1.0 V the delay changes by
  4 to 9 ps per mV (simulated, Magic 8.3.573 extraction: `verification/independent/README.md`, Section 6) and τ is
  110 to 170 ps, so the voltage has to hold to about 1 mV over a run. A 16-bit DAC on a quiet reference with an RC
  filter at the pin (class `DAC` is an example for an AD5693R used at gain 1, which cannot exceed 2.5 V), and a
  voltmeter of five digits on the pin. Never above 3.3 V. Demo board Rev 3.2 has a 10 MΩ pull-down on each analog
  line; the design files of rev 3.3 show instead a protection diode (SP3022, leakage at most 100 nA at 5.3 V by its
  data sheet) and no pull-down. Behind a 10 kΩ filter resistor the first gives a gain error of 0.1 % and the second
  an offset of at most 1 mV; the voltmeter on the pin reads the voltage that the tile receives in either case. Which
  revision comes with this shuttle is not known: measure the resistance from the header pin to ground.
- **Oscilloscope** on `uio[4]` (capture monitor) and `uio[5]` (early-sample monitor), to measure the delay *M*
  between them with averaging. It gives τ in picoseconds; ratios of τ do not need it. In simulation *M* is shorter
  than *d* by an amount that grows with `ua[0]` (see `verification/independent/README.md`); a slope fitted against
  *M* is therefore about 1.5 % longer than against *d*. Add the simulated difference to *M*, or carry it as a
  systematic error.

## Procedure

1. Power, clock, reset: `c = Characterizer(dac)`.
2. Bring-up, without the oscillator: `c.bringup()`. Constant data must give K = 0; data toggled once per trial must
   give K = 65,535 at 2.5 V and K = 0 at 1.0 V. One block takes about 13.1 ms.
3. Toggle scan, without the oscillator: `c.toggle_scan(dut, volts)` for each flip-flop, with the control voltage
   stepped down from about 2 V. The fraction of events falls from 1 to about 1/2 where the rising (or falling)
   outputs start to be caught, and to 0 where both are: those are the two floors. Measure *M* at each.
4. Survey, with the oscillator: `rows = c.survey([2, 3, 4, 1], volts)` over control voltages below the lower
   threshold found in step 3 (delays above the floor), then `save_csv(rows)`. In the straight part a block holds
   about one event or fewer, so `survey()` sums blocks at each setting until 200 events are counted or 300,000
   blocks (about 66 min) have run. Taking every flip-flop at one setting before moving to the next makes a drift of
   the delay common to all of them. Record *M* and the voltmeter reading at each setting in `calibration.csv`
   (columns `V,d_ps`).
5. Fit: `python3 fit_tau.py survey.csv calibration.csv --dmin <ps> --dmax <ps>`, over the straight part only:
   the local slopes printed for neighbouring settings must agree within their errors. The deviance per degree of
   freedom near 1 shows that the points scatter as counting predicts; well above 1, the range reaches into the
   shoulder above the floor or the delay drifted.
6. Checks: repeat one flip-flop with the data frequency changed by a few percent (the slope and K per unit
   frequency must not change), and repeat the first setting at the end (its count must agree within counting
   error).
