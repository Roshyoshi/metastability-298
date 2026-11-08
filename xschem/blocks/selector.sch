v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {selector: Selector (one of four flip-flop outputs)   (flow box: Selector)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/mux4_1.sym} 300 0 0 0 {name=xselect_dut}
C {devices/lab_pin.sym} 250 -50 0 0 {name=l1 lab=q_0}
C {devices/lab_pin.sym} 250 -30 0 0 {name=l2 lab=q_1}
C {devices/lab_pin.sym} 250 -10 0 0 {name=l3 lab=q_2}
C {devices/lab_pin.sym} 250 10 0 0 {name=l4 lab=q_3}
C {devices/lab_pin.sym} 250 30 0 0 {name=l5 lab=cfg_0}
C {devices/lab_pin.sym} 250 50 0 0 {name=l6 lab=cfg_1}
C {devices/lab_pin.sym} 350 -50 0 1 {name=l7 lab=selected_q}
C {devices/ipin.sym} 60 0 0 0 {name=p8 lab=cfg_0}
C {devices/ipin.sym} 60 40 0 0 {name=p9 lab=cfg_1}
C {devices/ipin.sym} 60 80 0 0 {name=p10 lab=q_0}
C {devices/ipin.sym} 60 120 0 0 {name=p11 lab=q_1}
C {devices/ipin.sym} 60 160 0 0 {name=p12 lab=q_2}
C {devices/ipin.sym} 60 200 0 0 {name=p13 lab=q_3}
C {devices/opin.sym} 560 0 0 0 {name=p14 lab=selected_q}
