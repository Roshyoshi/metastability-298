v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {joins: Joins: ui_in[7] = 0 gives the controller selected_q / early_q, ui_in[7] = 1 those of the bank   (flow box: Joins)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/mux2_1.sym} 300 0 0 0 {name=xjoin_q}
C {devices/lab_pin.sym} 250 -20 0 0 {name=l1 lab=selected_q}
C {devices/lab_pin.sym} 250 0 0 0 {name=l2 lab=bank_selected_q}
C {devices/lab_pin.sym} 250 20 0 0 {name=l3 lab=ui_in_7}
C {devices/lab_pin.sym} 350 -20 0 1 {name=l4 lab=ctrl_q}
C {@@ROOT@@/cells_tx/mux2_1.sym} 300 130 0 0 {name=xjoin_e}
C {devices/lab_pin.sym} 250 110 0 0 {name=l5 lab=early_q}
C {devices/lab_pin.sym} 250 130 0 0 {name=l6 lab=bank_early_q}
C {devices/lab_pin.sym} 250 150 0 0 {name=l7 lab=ui_in_7}
C {devices/lab_pin.sym} 350 110 0 1 {name=l8 lab=ctrl_early}
C {devices/ipin.sym} 60 0 0 0 {name=p9 lab=bank_early_q}
C {devices/ipin.sym} 60 40 0 0 {name=p10 lab=bank_selected_q}
C {devices/ipin.sym} 60 80 0 0 {name=p11 lab=early_q}
C {devices/ipin.sym} 60 120 0 0 {name=p12 lab=selected_q}
C {devices/ipin.sym} 60 160 0 0 {name=p13 lab=ui_in_7}
C {devices/opin.sym} 560 0 0 0 {name=p14 lab=ctrl_early}
C {devices/opin.sym} 560 40 0 0 {name=p15 lab=ctrl_q}
