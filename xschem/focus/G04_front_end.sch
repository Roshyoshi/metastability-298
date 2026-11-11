v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {@@ROOT@@/sym/g_G04_data0.sym} 100 60 0 0 {name=data0 schematic=@@ROOT@@/cells_tx/inv_2.sch}
C {@@ROOT@@/sym/g_G04_cap0.sym} 100 280 0 0 {name=cap0 schematic=@@ROOT@@/cells_tx/inv_2.sch}
C {@@ROOT@@/sym/g_G04_data1.sym} 470 60 0 0 {name=data1 schematic=@@ROOT@@/cells_tx/inv_2.sch}
C {@@ROOT@@/sym/g_G04_cap1.sym} 470 280 0 0 {name=cap1 schematic=@@ROOT@@/cells_tx/inv_2.sch}
C {@@ROOT@@/sym/g_G04_u_dut1.sym} 840 60 0 0 {name=u_dut1 schematic=@@ROOT@@/cells_tx/dffq_1.sch}
C {@@ROOT@@/sym/g_G04_u_dut2.sym} 840 320 0 0 {name=u_dut2 schematic=@@ROOT@@/blocks/meta_dut_baseline.sch}
C {@@ROOT@@/sym/g_G04_u_dut3.sym} 840 580 0 0 {name=u_dut3 schematic=@@ROOT@@/blocks/meta_dut_keeper.sch}
C {@@ROOT@@/sym/g_G04_u_dut4.sym} 840 840 0 0 {name=u_dut4 schematic=@@ROOT@@/blocks/meta_dut_forward.sch}
C {@@ROOT@@/sym/g_G04_select_dut.sym} 1210 60 0 0 {name=select_dut schematic=@@ROOT@@/cells_tx/mux4_1.sch}
C {@@ROOT@@/sym/g_G04_iso0.sym} 1580 60 0 0 {name=iso0 schematic=@@ROOT@@/cells_tx/inv_1.sch}
C {@@ROOT@@/sym/g_G04_iso1.sym} 1580 280 0 0 {name=iso1 schematic=@@ROOT@@/cells_tx/inv_2.sch}
C {@@ROOT@@/sym/g_G04_delay.sym} 1950 60 0 0 {name=delay schematic=@@ROOT@@/blocks/delay_line.sch}
C {@@ROOT@@/sym/g_G04_early_observer.sym} 2330 60 0 0 {name=early_observer schematic=@@ROOT@@/cells_tx/dffq_1.sch}
C {@@ROOT@@/sym/g_G04_monitor_capture_a.sym} 2330 320 0 0 {name=monitor_capture_a schematic=@@ROOT@@/cells_tx/inv_1.sch}
C {@@ROOT@@/sym/g_G04_monitor_early_a.sym} 2330 540 0 0 {name=monitor_early_a schematic=@@ROOT@@/cells_tx/inv_1.sch}
C {@@ROOT@@/sym/g_G04_monitor_capture_b.sym} 2720 60 0 0 {name=monitor_capture_b schematic=@@ROOT@@/cells_tx/inv_2.sch}
C {@@ROOT@@/sym/g_G04_monitor_early_b.sym} 2720 280 0 0 {name=monitor_early_b schematic=@@ROOT@@/cells_tx/inv_2.sch}
N 570 290 570 370 {lab=capture_local}
N 570 370 730 370 {lab=capture_local}
N 730 370 730 110 {lab=capture_local}
N 730 370 740 370 {lab=capture_local}
N 730 370 730 630 {lab=capture_local}
N 730 110 740 110 {lab=capture_local}
N 730 110 730 -20 {lab=capture_local}
N 730 630 740 630 {lab=capture_local}
N 730 630 730 890 {lab=capture_local}
N 730 890 740 890 {lab=capture_local}
N 730 -20 1470 -20 {lab=capture_local}
N 1470 -20 1480 -20 {lab=capture_local}
N 1480 -20 1480 70 {lab=capture_local}
N 1480 70 1480 170 {lab=capture_local}
N 1480 170 2220 170 {lab=capture_local}
N 2220 170 2220 330 {lab=capture_local}
N 570 70 710 70 {lab=data_local}
N 710 70 710 330 {lab=data_local}
N 710 70 740 70 {lab=data_local}
N 710 330 710 590 {lab=data_local}
N 710 330 740 330 {lab=data_local}
N 710 590 740 590 {lab=data_local}
N 710 590 710 850 {lab=data_local}
N 710 850 740 850 {lab=data_local}
N 1310 170 1310 190 {lab=selected_q}
N 1310 190 2060 190 {lab=selected_q}
N 2060 190 2060 70 {lab=selected_q}
N 2060 190 2060 450 {lab=selected_q}
N 2060 70 2230 70 {lab=selected_q}
N 2060 450 3010 450 {lab=selected_q}
N 2050 90 2190 90 {lab=early_clk}
N 2190 90 2200 90 {lab=early_clk}
N 2200 90 2230 90 {lab=early_clk}
N 2200 90 2200 550 {lab=early_clk}
N 2230 90 2230 110 {lab=early_clk}
N 2200 550 2220 550 {lab=early_clk}
N 1850 110 1850 430 {lab=ua_0}
N 1850 430 690 430 {lab=ua_0}
N 690 430 690 620 {lab=ua_0}
N 690 620 -260 620 {lab=ua_0}
N 1110 230 670 230 {lab=ui_in_3}
N 670 230 670 520 {lab=ui_in_3}
N 670 520 -260 520 {lab=ui_in_3}
N 1110 270 1110 450 {lab=uio_in_6}
N 1110 450 650 450 {lab=uio_in_6}
N 650 450 650 570 {lab=uio_in_6}
N 650 570 -260 570 {lab=uio_in_6}
N 2430 90 2450 90 {lab=early_q}
N 2450 90 2450 500 {lab=early_q}
N 2450 500 3010 500 {lab=early_q}
N 0 70 -260 70 {lab=ui_in_6}
N -260 70 -260 420 {lab=ui_in_6}
N 0 290 0 470 {lab=capture}
N 0 470 -260 470 {lab=capture}
N 1680 70 1680 130 {lab=capture_iso_b}
N 1680 130 1460 130 {lab=capture_iso_b}
N 1460 130 1460 290 {lab=capture_iso_b}
N 1460 290 1480 290 {lab=capture_iso_b}
N 2830 70 2840 70 {lab=uio_out_4}
N 2840 70 2840 550 {lab=uio_out_4}
N 2840 550 3010 550 {lab=uio_out_4}
N 2830 290 2860 290 {lab=uio_out_5}
N 2860 290 2860 600 {lab=uio_out_5}
N 2860 600 3010 600 {lab=uio_out_5}
N 200 70 370 70 {lab=data_b}
N 200 290 370 290 {lab=capture_b}
N 940 90 940 70 {lab=q_0}
N 940 70 1110 70 {lab=q_0}
N 940 350 940 110 {lab=q_1}
N 940 110 1110 110 {lab=q_1}
N 940 610 960 610 {lab=q_2}
N 960 610 960 150 {lab=q_2}
N 960 150 1110 150 {lab=q_2}
N 940 870 980 870 {lab=q_3}
N 980 870 980 190 {lab=q_3}
N 980 190 1110 190 {lab=q_3}
N 1680 290 1700 290 {lab=capture_iso}
N 1700 290 1700 70 {lab=capture_iso}
N 1700 70 1850 70 {lab=capture_iso}
N 2440 330 2470 330 {lab=capmon_n}
N 2470 330 2470 70 {lab=capmon_n}
N 2470 70 2610 70 {lab=capmon_n}
N 2440 550 2610 550 {lab=earlymon_n}
N 2610 550 2610 290 {lab=earlymon_n}
C {devices/ipin.sym} -260 420 0 0 {name=p_ui_in_6 lab=ui_in_6}
C {devices/ipin.sym} -260 470 0 0 {name=p_capture lab=capture}
C {devices/ipin.sym} -260 520 0 0 {name=p_ui_in_3 lab=ui_in_3}
C {devices/ipin.sym} -260 570 0 0 {name=p_uio_in_6 lab=uio_in_6}
C {devices/ipin.sym} -260 620 0 0 {name=p_ua_0 lab=ua_0}
C {devices/opin.sym} 3010 450 0 0 {name=p_selected_q lab=selected_q}
C {devices/opin.sym} 3010 500 0 0 {name=p_early_q lab=early_q}
C {devices/opin.sym} 3010 550 0 0 {name=p_uio_out_4 lab=uio_out_4}
C {devices/opin.sym} 3010 600 0 0 {name=p_uio_out_5 lab=uio_out_5}
C {devices/lab_wire.sym} 1470 -20 0 0 {name=l1 lab=capture_local}
C {devices/lab_wire.sym} 2190 90 0 0 {name=l2 lab=early_clk}
L 3 20 -70 180 -70 {}
L 3 20 -70 20 -58 {}
L 3 180 -70 180 -58 {}
T {input buffers} 20 -91.8932 0 0 0.3 0.3 {layer=3}
L 3 760 -70 920 -70 {}
L 3 760 -70 760 -58 {}
L 3 920 -70 920 -58 {}
T {flip-flops under test: DUT1-DUT4} 760 -91.8932 0 0 0.3 0.3 {layer=3}
L 3 1130 -70 1290 -70 {}
L 3 1130 -70 1130 -58 {}
L 3 1290 -70 1290 -58 {}
T {selector} 1130 -91.8932 0 0 0.3 0.3 {layer=3}
L 3 1500 -70 1660 -70 {}
L 3 1500 -70 1500 -58 {}
L 3 1660 -70 1660 -58 {}
T {isolation} 1500 -91.8932 0 0 0.3 0.3 {layer=3}
L 3 1870 -70 2030 -70 {}
L 3 1870 -70 1870 -58 {}
L 3 2030 -70 2030 -58 {}
T {delay line (F08, F09)} 1870 -91.8932 0 0 0.3 0.3 {layer=3}
L 3 2240 -70 2420 -70 {}
L 3 2240 -70 2240 -58 {}
L 3 2420 -70 2420 -58 {}
T {early observer, monitors} 2240 -91.8932 0 0 0.3 0.3 {layer=3}
T {G04  front end (gate level): data in, capture edge, four flip-flops, selector, delay line, early sample} -340 -228.707 0 0 0.45 0.45 {}
T {capture (from the controller) clocks all four flip-flops at once; pins ui_in[3] and uio_in[6] pick which one the selector passes on (selected_q).} -340 -185.867 0 0 0.24 0.24 {}
T {The same edge, delayed by d (set by ua[0]) in the delay line, becomes early_clk: the early observer samples selected_q then.} -340 -166.543 0 0 0.24 0.24 {}
T {The controller (not drawn) samples selected_q again 50 ns and 100 ns later and compares. Monitors copy both clocks to pins.} -340 -147.218 0 0 0.24 0.24 {}
N -260 1020 -160 1020 {lab=capture}
C {devices/lab_wire.sym} -160 1020 0 0 {name=l3 lab=capture}
N -140 1020 -7.7888 1020 {lab=capture_local}
C {devices/lab_wire.sym} -7.7888 1020 0 0 {name=l4 lab=capture_local}
T {capture edge} 22.2112 1010.84 0 0 0.24 0.24 {}
N -260 1060 -159.238 1060 {lab=early_clk}
C {devices/lab_wire.sym} -159.238 1060 0 0 {name=l5 lab=early_clk}
T {early_clk: capture delayed by d} -129.238 1050.84 0 0 0.24 0.24 {}
N -260 1100 -160 1100 {lab=ua_0}
C {devices/lab_wire.sym} -160 1100 0 0 {name=l6 lab=ua_0}
T {ua[0]: delay control} -130 1090.84 0 0 0.24 0.24 {}
N -260 1140 -151.376 1140 {lab=selected_q}
C {devices/lab_wire.sym} -151.376 1140 0 0 {name=l7 lab=selected_q}
T {selected_q: output of the chosen flip-flop} -121.376 1130.84 0 0 0.24 0.24 {}
T {Each box is one cell (name, then cell type). Click a box and press e to see its transistors; Ctrl+e comes back. A dot marks a connection; wires that cross without a dot are not connected.} -260 1174 0 0 0.2 0.2 {}
