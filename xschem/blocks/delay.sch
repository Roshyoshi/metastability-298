v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {delay: Adjustable delay: isolation buffer + current-starved delay line   (flow box: Adjustable delay)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {/home/oshan/metastability-298/xschem/cells_tx/inv_1.sym} 240 0 0 0 {name=xiso0}
C {devices/lab_pin.sym} 190 0 0 0 {name=l1 lab=capture_local}
C {devices/lab_pin.sym} 290 0 0 1 {name=l2 lab=capture_iso_b}
C {/home/oshan/metastability-298/xschem/cells_tx/inv_2.sym} 440 0 0 0 {name=xiso1}
C {devices/lab_pin.sym} 390 0 0 0 {name=l3 lab=capture_iso_b}
C {devices/lab_pin.sym} 490 0 0 1 {name=l4 lab=capture_iso}
C {/home/oshan/metastability-298/xschem/cells_tx/antenna.sym} 700 160 0 0 {name=xant_ctrl}
C {devices/lab_pin.sym} 650 160 0 0 {name=l5 lab=ua_0}
C {/home/oshan/metastability-298/xschem/blocks/delay_line.sym} 700 0 0 0 {name=xdelay}
C {devices/lab_pin.sym} 620 -10 0 0 {name=l6 lab=capture_iso}
C {devices/lab_pin.sym} 620 10 0 0 {name=l7 lab=ua_0}
C {devices/lab_pin.sym} 780 -10 0 1 {name=l8 lab=early_clk}
C {devices/ipin.sym} 60 0 0 0 {name=p9 lab=capture_local}
C {devices/ipin.sym} 60 40 0 0 {name=p10 lab=ua_0}
C {devices/opin.sym} 960 0 0 0 {name=p11 lab=early_clk}
