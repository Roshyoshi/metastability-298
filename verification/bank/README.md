# Checks and simulations of the revised layout with the bank (25 Nov 2026)

These files are the logs behind the section "Bank of faster flip-flops" of `README_analog.md` and of
`docs/info.md`. They describe the GDS whose SHA-1 is in `layout/gds.sha1`. Tools: Magic 8.3.573, Netgen 1.5.314,
KLayout 0.28.16, ngspice with the models of the PDK `gf180mcuD`. No chip has been measured. Paths inside the
scripts and benches are those of the machine on which they ran.

## layout/

| File | Contents |
| --- | --- |
| `drc_magic_8.3.573.txt` | Magic DRC: count 0 |
| `checks_magic_netgen_antenna.txt` | summary of Magic DRC, Netgen LVS (as is, and with `MCT` as `nfet_06v0` on both sides) and the Magic antenna check |
| `lvs_report.txt`, `lvs_report_mct_as_nfet_06v0.txt` | Netgen reports: "Circuits match uniquely" |
| `antenna_magic.log` | Magic antenna check: 0 |
| `checks_klayout_precheck.txt` | KLayout main deck (621 rules, 0 violations), the conservative run of the well rules (6 x NW.2b_MV inside `dffq_1`, see `README_analog.md`), and the number of offline precheck steps passed |
| `tt_precheck_offline.md` | the offline Tiny Tapeout precheck step by step: 10 of 12 pass; the two steps that run the PDK decks need a newer KLayout and were not run |
| `sch_check.txt`, `check_focus.txt` | schematics against the master netlist: SAME CIRCUIT; presentation sheets: ALL SAME |
| `xor_region.txt` | KLayout XOR of this GDS against that of commit 06823df, above and below y = 199 um |
| `reproduce_06823df_gds_records.txt`, `reproduce_06823df_xor.txt` | before the bank was added: the generators reproduce the GDS of 06823df (records equal except 23 time stamps; XOR 0) |

## sim/

| File | Contents |
| --- | --- |
| `tau.txt`, `tau.json` | latch time constants by the growth method at four conditions: DUT2, DUT3, DUT4 (`xu_dut*`), N3 (`xbank_n3`), N1 (`meta_n3ffb_0`), N2 (`meta_j3a_0`) |
| `delay_line.txt` | *d* against `ua[0]` on the revised layout (`post_bank`) and, repeated with the same tool, on 06823df (`post_old`) |
| `floors.txt` | floors of DUT1 to DUT4 in continuous operation, typical corner, 3.3 V, 25 C |
| `wire_capacitance_06823df_vs_revised.json` | extracted wiring capacitance per net, before and after |

## tile/

Whole-tile transient runs of the extracted netlist (`layout/make_tb_chip.py`, 1.6 us, four counted trials). For
each run: the bench, its `RESULT` lines, and the edge times of the bank path taken from the saved waveforms with
`tools/bank_edges.py`.

| Run | Setting | Events in 4 counted trials |
| --- | --- | --- |
| `post_core` | bank off, data of DUT2 toggled once per trial, `ua[0]` = 1.8 V | 2 |
| `post_b1_early`, `post_b2_early`, `post_b3_early` | N1, N2, N3; bank data toggled once per trial; `ui_in[5]` 0.2 ns after the clock edge | 4, 4, 4 |
| `post_b2_early_ss`, `post_b2_early_ff` | N2 at ss 3.0 V 125 C and ff 3.6 V −40 C | 4, 4 |
| `post_b2_late` | N2, `ui_in[5]` 6 ns after the clock edge | 0 |

## tools/

The scripts that produced `sim/` and the summaries: `tau_bank.py` (uses the growth-method code of the second
check), `capcmp_bank.py`, `cutout_bank.py`, `pexmap_bank.py`, `bank_edges.py`, `kxor_region.py`, `checks_a.sh`,
`checks_b.sh`. They are a record of what was run; they read helper modules that are not in this repository.
