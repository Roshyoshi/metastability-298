# Tiny Tapeout precheck, offline, on the GDS of 26 Nov 2026

tt-support-tools 21568ef, `precheck/precheck.py --tech gf180mcuD`, with the GDS, the LEF and the Verilog placed as the GitHub action places them.

| Check | Result |
|-----------|--------|
| KLayout pin label overlapping drawing | ✅ |
| KLayout zero area | ✅ |
| KLayout Checks | ✅ |
| Pin check | ✅ |
| Boundary check | ✅ |
| Power pin check | ✅ |
| Layer check | ✅ |
| Cell name check | ✅ |
| KLayout GF180MCU DRC | ✅ |
| Antenna check | ✅ |
| Analog pin check | ✅ |
| Verilog syntax check | ❌ Fail: [Errno 2] No such file or directory: 'yowasp-yosys' |

Of these, nine steps are checks of this GDS: pin labels, zero area, KLayout checks, pins, boundary, power pins, layers, cell names, analog pins.
The steps "KLayout GF180MCU DRC" and "Antenna check" call the unified rule deck of a newer PDK with a switch that the deck installed here does not know;
the log shows FEOL and BEOL disabled and a run time of 0.4 s, so their pass means nothing here. The Verilog check needs yowasp-yosys, which is not installed;
the Verilog file is that of e449093. The `gds` workflow on GitHub runs all twelve steps on the pushed commit.
