v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {bank_early_observer: Bank: early observer, clocked from the pin ui_in[5]   (flow box: Bank)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/inv_1.sym} 240 0 0 0 {name=xbank_obs0}
C {devices/lab_pin.sym} 190 0 0 0 {name=l1 lab=ui_in_5}
C {devices/lab_pin.sym} 290 0 0 1 {name=l2 lab=bank_obs_b}
C {@@ROOT@@/cells_tx/inv_2.sym} 440 0 0 0 {name=xbank_obs1}
C {devices/lab_pin.sym} 390 0 0 0 {name=l3 lab=bank_obs_b}
C {devices/lab_pin.sym} 490 0 0 1 {name=l4 lab=bank_obs_clk}
C {@@ROOT@@/cells_tx/dffq_1.sym} 700 20 0 0 {name=xbank_observer}
C {devices/lab_pin.sym} 650 10 0 0 {name=l5 lab=bank_selected_q}
C {devices/lab_pin.sym} 650 30 0 0 {name=l6 lab=bank_obs_clk}
C {devices/lab_pin.sym} 750 10 0 1 {name=l7 lab=bank_early_q}
C {devices/ipin.sym} 60 0 0 0 {name=p8 lab=bank_selected_q}
C {devices/ipin.sym} 60 40 0 0 {name=p9 lab=ui_in_5}
C {devices/opin.sym} 960 0 0 0 {name=p10 lab=bank_early_q}
