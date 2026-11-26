v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {bank_trial_clock: Bank: copy of the trial clock (a and b of the controller, clocked by clk, reset by rst_n)   (flow box: Bank)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/dffq_1.sym} 300 0 0 0 {name=xbank_a_ff}
C {devices/lab_pin.sym} 250 -10 0 0 {name=l1 lab=bank_b}
C {devices/lab_pin.sym} 250 10 0 0 {name=l2 lab=clk}
C {devices/lab_pin.sym} 350 -10 0 1 {name=l3 lab=bank_a}
C {@@ROOT@@/cells_tx/inv_1.sym} 560 0 0 0 {name=xbank_a_inv}
C {devices/lab_pin.sym} 510 0 0 0 {name=l4 lab=bank_a}
C {devices/lab_pin.sym} 610 0 0 1 {name=l5 lab=bank_a_n}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 820 20 0 0 {name=xbank_b_ff}
C {devices/lab_pin.sym} 770 0 0 0 {name=l6 lab=bank_a_n}
C {devices/lab_pin.sym} 770 20 0 0 {name=l7 lab=rst_n}
C {devices/lab_pin.sym} 770 40 0 0 {name=l8 lab=clk}
C {devices/lab_pin.sym} 870 0 0 1 {name=l9 lab=bank_b}
C {devices/ipin.sym} 60 0 0 0 {name=p10 lab=clk}
C {devices/ipin.sym} 60 40 0 0 {name=p11 lab=rst_n}
C {devices/opin.sym} 1080 0 0 0 {name=p12 lab=bank_a}
