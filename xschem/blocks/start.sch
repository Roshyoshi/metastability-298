v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {start: Start: request = ena AND start, then start_meta and run, both clocked by a_n rising   (flow box: Sequencer)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/and2_1.sym} 300 0 0 0 {name=xrequest_and}
C {devices/lab_pin.sym} 250 -10 0 0 {name=l1 lab=ena}
C {devices/lab_pin.sym} 250 10 0 0 {name=l2 lab=ui_in_4}
C {devices/lab_pin.sym} 350 -10 0 1 {name=l3 lab=request}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 820 20 0 0 {name=xrun_ff}
C {devices/lab_pin.sym} 770 0 0 0 {name=l4 lab=start_meta}
C {devices/lab_pin.sym} 770 20 0 0 {name=l5 lab=rst_n}
C {devices/lab_pin.sym} 770 40 0 0 {name=l6 lab=a_n}
C {devices/lab_pin.sym} 870 0 0 1 {name=l7 lab=run}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 560 20 0 0 {name=xstart_meta_ff}
C {devices/lab_pin.sym} 510 0 0 0 {name=l8 lab=request}
C {devices/lab_pin.sym} 510 20 0 0 {name=l9 lab=rst_n}
C {devices/lab_pin.sym} 510 40 0 0 {name=l10 lab=a_n}
C {devices/lab_pin.sym} 610 0 0 1 {name=l11 lab=start_meta}
C {devices/ipin.sym} 60 0 0 0 {name=p12 lab=a_n}
C {devices/ipin.sym} 60 40 0 0 {name=p13 lab=ena}
C {devices/ipin.sym} 60 80 0 0 {name=p14 lab=rst_n}
C {devices/ipin.sym} 60 120 0 0 {name=p15 lab=ui_in_4}
C {devices/opin.sym} 1080 0 0 0 {name=p16 lab=run}
