Delay *d* against `ua[0]`, typical corner, 3.3 V, 27 C (ns). *d* is from the capture edge at the flip-flops under test to the early-sample clock at the early observer.

| `ua[0]` | *d*, schematic | *d*, layout |
| --- | --- | --- |
| 1.0 V | 2.93 | 4.19 |
| 1.1 V | 2.32 | 3.36 |
| 1.2 V | 1.93 | 2.84 |
| 1.3 V | 1.68 | 2.49 |
| 1.4 V | 1.49 | 2.24 |
| 1.5 V | 1.35 | 2.06 |
| 1.8 V | 1.10 | 1.72 |
| 2.4 V | 0.89 | 1.44 |
| 3.0 V | 0.82 | 1.34 |
| 3.3 V | 0.80 | 1.31 |

When the chosen flip-flop's new value reaches the early observer, after the same capture edge (ns). An early sample taken before this reads the old value, so *d* has to be longer.

| Flip-flop | rising, schematic | falling, schematic | rising, layout | falling, layout |
| --- | --- | --- | --- | --- |
| DUT1: library `dffq_1` | 1.25 | 1.24 | 2.26 | 2.37 |
| DUT2: NAND, baseline | 0.97 | 1.16 | 1.69 | 1.94 |
| DUT3: NAND, keeper doubled | 0.97 | 1.15 | 1.82 | 2.13 |
| DUT4: NAND, forward gate doubled | 0.96 | 1.17 | 1.77 | 2.07 |

Regeneration time constant tau of the master latch (ps). The schematic carries its wiring estimates: 0.25 fF on each latch node and 0.05 fF between them.

| Flip-flop | typical 3.3 V 27 C, schematic | typical 3.3 V 27 C, layout | slow 3.0 V -40 C, schematic | slow 3.0 V -40 C, layout | slow 3.0 V 125 C, schematic | slow 3.0 V 125 C, layout | fast 3.6 V -40 C, schematic | fast 3.6 V -40 C, layout |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| DUT2: NAND, baseline | 88.8 | 136.1 | 114.7 | 175.9 | 170.8 | 258.3 | 53.4 | 82.4 |
| DUT3: NAND, keeper doubled | 80.6 | 113.8 | 104.0 | 147.3 | 155.2 | 216.3 | 48.3 | 68.9 |
| DUT4: NAND, forward gate doubled | 102.0 | 163.1 | 131.4 | 210.2 | 195.8 | 309.0 | 61.3 | 98.8 |

Wiring capacitance Magic extracted on the latch nodes `mq` and `mqb`: DUT2 2.58 and 2.45 fF; DUT3 2.45 and 2.41 fF; DUT4 2.70 and 2.50 fF.

Controller timing over eight count pulses, `ui_in[6]` toggling before every capture, `ua[0]` = 1.3 V.

| Measured | typical 3.3 V 27 C, schematic | typical 3.3 V 27 C, layout | slow 3.0 V -40 C, schematic | slow 3.0 V -40 C, layout | slow 3.0 V 125 C, schematic | slow 3.0 V 125 C, layout | fast 3.6 V -40 C, schematic | fast 3.6 V -40 C, layout |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `run` edge, 10 % to 90 % (ns) | 3.32 | 9.50 | 3.82 | 11.52 | 5.86 | 17.28 | 2.14 | 5.85 |
| `allow_count` rises after `b` falls (ns) | 0.85 | 1.53 | 1.15 | 2.12 | 1.68 | 3.01 | 0.49 | 0.89 |
| lowest `tick_n` before the first count (V) | 3.23 | 3.26 | 2.94 | 2.96 | 2.93 | 2.96 | 3.53 | 3.55 |
| `b` rising to `tick_n` falling (ns) | 0.17 | 0.76 | 0.22 | 1.05 | 0.32 | 1.47 | 0.10 | 0.45 |
| count pulse width (ns) | 99.8 | 99.7 | 99.7 | 99.6 | 99.5 | 99.3 | 99.9 | 99.9 |
| `tick_n` to `n[0]` (ns) | 0.87 | 1.65 | 1.17 | 2.27 | 1.73 | 3.25 | 0.50 | 0.95 |
| `n[0]` to `n[1]`, through the inverter (ns) | 0.94 | 1.66 | 1.27 | 2.28 | 1.86 | 3.24 | 0.55 | 0.96 |
| counter stage, output rising, the slower of `n[2]` and `n[3]` (ns) | 0.87 | 1.77 | 1.17 | 2.41 | 1.72 | 3.44 | 0.51 | 1.03 |
| counter stage, output falling (ns) | 0.58 | 1.20 | 0.78 | 1.63 | 1.13 | 2.30 | 0.35 | 0.71 |
| last count settled after `b` rises: the steps above and 15 more stages (ns) | 15.1 | 30.6 | 20.2 | 41.8 | 29.7 | 59.6 | 8.8 | 17.8 |
| *d* at this `ua[0]` (ns) | 1.68 | 2.49 | 2.54 | 3.80 | 3.00 | 4.48 | 1.02 | 1.51 |
| new value at the early observer, rising (ns) | 0.97 | 1.69 | 1.28 | 2.32 | 1.91 | 3.30 | 0.56 | 0.98 |
| new value at the early observer, falling (ns) | 1.16 | 1.94 | 1.61 | 2.74 | 2.34 | 3.85 | 0.67 | 1.12 |
| events counted after 8 count pulses | 0 | 0 | 0 | 0 | 0 | 4 | 0 | 0 |
| busy, done, fault (V) | 3.3, 0.0, 0.0 | 3.3, 0.0, 0.0 | 3.0, 0.0, 0.0 | 3.0, 0.0, 0.0 | 3.0, 0.0, 0.0 | 3.0, 0.0, 0.0 | 3.6, 0.0, 0.0 | 3.6, 0.0, 0.0 |

Event path, four count pulses, `ui_in[6]` toggling before every capture. With *d* shorter than the arrival the early reading is the old value and every counted trial is an event; with *d* well beyond it no trial is.

| Netlist | Corner | `ua[0]` | *d* (ns) | arrival, rising (ns) | arrival, falling (ns) | events | busy, done, fault (V) |
| --- | --- | --- | --- | --- | --- | --- | --- |
| schematic | slow 3.0 V 125 C | 1.1 V | 4.15 | 1.91 | 2.34 | 0 | 3.0, 0.0, 0.0 |
| schematic | typical 3.3 V 27 C | 3.3 V | 0.80 | 0.96 | 1.16 | 4 | 3.3, 0.0, 0.0 |
| layout | slow 3.0 V 125 C | 1.1 V | 6.04 | 3.30 | 3.85 | 0 | 3.0, 0.0, 0.0 |
| layout | typical 3.3 V 27 C | 3.3 V | 1.31 | 1.69 | 1.95 | 4 | 3.3, 0.0, 0.0 |

