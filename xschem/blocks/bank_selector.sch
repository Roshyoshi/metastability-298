v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {bank_selector: Bank: selector (ui_in[2:1]: 00 N1, 01 N2, 10 N3, 11 constant 0) and its tie cell   (flow box: Bank)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/mux4_1.sym} 500 60 0 0 {name=xbank_select}
C {devices/lab_pin.sym} 450 10 0 0 {name=l1 lab=bank_q_0}
C {devices/lab_pin.sym} 450 30 0 0 {name=l2 lab=bank_q_1}
C {devices/lab_pin.sym} 450 50 0 0 {name=l3 lab=bank_q_2}
C {devices/lab_pin.sym} 450 70 0 0 {name=l4 lab=bank_zero}
C {devices/lab_pin.sym} 450 90 0 0 {name=l5 lab=ui_in_1}
C {devices/lab_pin.sym} 450 110 0 0 {name=l6 lab=ui_in_2}
C {devices/lab_pin.sym} 550 10 0 1 {name=l7 lab=bank_selected_q}
C {@@ROOT@@/cells_tx/tiel.sym} 240 0 0 0 {name=xbank_tie}
C {devices/lab_pin.sym} 290 0 0 1 {name=l8 lab=bank_zero}
C {devices/ipin.sym} 60 0 0 0 {name=p9 lab=bank_q_0}
C {devices/ipin.sym} 60 40 0 0 {name=p10 lab=bank_q_1}
C {devices/ipin.sym} 60 80 0 0 {name=p11 lab=bank_q_2}
C {devices/ipin.sym} 60 120 0 0 {name=p12 lab=ui_in_1}
C {devices/ipin.sym} 60 160 0 0 {name=p13 lab=ui_in_2}
C {devices/opin.sym} 760 0 0 0 {name=p14 lab=bank_selected_q}
