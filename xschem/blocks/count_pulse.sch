v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {count_pulse: Count pulse: allow_count takes run AND NOT n_16 on b falling; tick_n = NOT (b AND allow_count)   (flow box: Sequencer)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {/home/oshan/metastability-298/xschem/cells_tx/dffnrnq_1.sym} 820 20 0 0 {name=xallow_ff}
C {devices/lab_pin.sym} 770 0 0 0 {name=l1 lab=want_count}
C {devices/lab_pin.sym} 770 20 0 0 {name=l2 lab=rst_n}
C {devices/lab_pin.sym} 770 40 0 0 {name=l3 lab=b}
C {devices/lab_pin.sym} 870 0 0 1 {name=l4 lab=allow_count}
C {/home/oshan/metastability-298/xschem/cells_tx/inv_1.sym} 300 0 0 0 {name=xfinished_inv}
C {devices/lab_pin.sym} 250 0 0 0 {name=l5 lab=n_16}
C {devices/lab_pin.sym} 350 0 0 1 {name=l6 lab=finished_n}
C {/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sym} 1080 0 0 0 {name=xtick_nand}
C {devices/lab_pin.sym} 1030 -10 0 0 {name=l7 lab=b}
C {devices/lab_pin.sym} 1030 10 0 0 {name=l8 lab=allow_count}
C {devices/lab_pin.sym} 1130 -10 0 1 {name=l9 lab=tick_n}
C {/home/oshan/metastability-298/xschem/cells_tx/and2_1.sym} 560 0 0 0 {name=xwant_and}
C {devices/lab_pin.sym} 510 -10 0 0 {name=l10 lab=run}
C {devices/lab_pin.sym} 510 10 0 0 {name=l11 lab=finished_n}
C {devices/lab_pin.sym} 610 -10 0 1 {name=l12 lab=want_count}
C {devices/ipin.sym} 60 0 0 0 {name=p13 lab=b}
C {devices/ipin.sym} 60 40 0 0 {name=p14 lab=n_16}
C {devices/ipin.sym} 60 80 0 0 {name=p15 lab=rst_n}
C {devices/ipin.sym} 60 120 0 0 {name=p16 lab=run}
C {devices/opin.sym} 1340 0 0 0 {name=p17 lab=tick_n}
