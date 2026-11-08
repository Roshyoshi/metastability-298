v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {early_observer: Early observer (sample at delay d)   (flow box: Early observer)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/dffq_1.sym} 300 0 0 0 {name=xearly_observer}
C {devices/lab_pin.sym} 250 -10 0 0 {name=l1 lab=selected_q}
C {devices/lab_pin.sym} 250 10 0 0 {name=l2 lab=early_clk}
C {devices/lab_pin.sym} 350 -10 0 1 {name=l3 lab=early_q}
C {devices/ipin.sym} 60 0 0 0 {name=p4 lab=early_clk}
C {devices/ipin.sym} 60 40 0 0 {name=p5 lab=selected_q}
C {devices/opin.sym} 560 0 0 0 {name=p6 lab=early_q}
