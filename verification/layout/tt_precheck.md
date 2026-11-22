Tiny Tapeout precheck, 17 Nov 2026: tt-support-tools 8f7b506 (precheck/precheck.py --tech gf180mcuD) with
KLayout 0.30.12 and open_pdks e8daeda7, the PDK build that tt-gds-action tag ttgf26c installs. Run on
gds/tt_um_metastability_characterizer.gds and lef/tt_um_metastability_characterizer.lef with src/project.v,
arranged as the action arranges them: info.yaml beside tt_submission/<top>.gds, .lef and .v.

| Check | Result |
|-----------|--------|
| KLayout pin label overlapping drawing | pass |
| KLayout zero area | pass |
| KLayout Checks | pass |
| Pin check | pass |
| Boundary check | pass |
| Power pin check | pass |
| Layer check | pass |
| Cell name check | pass |
| KLayout GF180MCU DRC | pass |
| Antenna check | pass |
| Analog pin check | pass |
| Verilog syntax check | pass |

