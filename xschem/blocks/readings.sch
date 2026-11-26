v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {readings: Later readings: l1 on b falling (50 ns), l2 on a_n rising (100 ns); event_bit = early XOR l2, bad_bit = l1 XOR l2   (flow box: Late observers + compare)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/xor2_1.sym} 620 0 0 0 {name=xbad_xor}
C {devices/lab_pin.sym} 570 -10 0 0 {name=l1 lab=l1}
C {devices/lab_pin.sym} 570 10 0 0 {name=l2 lab=l2}
C {devices/lab_pin.sym} 670 -10 0 1 {name=l3 lab=bad_bit}
C {@@ROOT@@/cells_tx/xor2_1.sym} 620 150 0 0 {name=xevent_xor}
C {devices/lab_pin.sym} 570 140 0 0 {name=l4 lab=ctrl_early}
C {devices/lab_pin.sym} 570 160 0 0 {name=l5 lab=l2}
C {devices/lab_pin.sym} 670 140 0 1 {name=l6 lab=event_bit}
C {@@ROOT@@/cells_tx/dffnq_1.sym} 300 0 0 0 {name=xl1_ff}
C {devices/lab_pin.sym} 250 -10 0 0 {name=l7 lab=ctrl_q}
C {devices/lab_pin.sym} 250 10 0 0 {name=l8 lab=b}
C {devices/lab_pin.sym} 350 -10 0 1 {name=l9 lab=l1}
C {@@ROOT@@/cells_tx/dffq_1.sym} 300 150 0 0 {name=xl2_ff}
C {devices/lab_pin.sym} 250 140 0 0 {name=l10 lab=ctrl_q}
C {devices/lab_pin.sym} 250 160 0 0 {name=l11 lab=a_n}
C {devices/lab_pin.sym} 350 140 0 1 {name=l12 lab=l2}
C {devices/ipin.sym} 60 0 0 0 {name=p13 lab=a_n}
C {devices/ipin.sym} 60 40 0 0 {name=p14 lab=b}
C {devices/ipin.sym} 60 80 0 0 {name=p15 lab=ctrl_early}
C {devices/ipin.sym} 60 120 0 0 {name=p16 lab=ctrl_q}
C {devices/opin.sym} 880 0 0 0 {name=p17 lab=bad_bit}
C {devices/opin.sym} 880 40 0 0 {name=p18 lab=event_bit}
