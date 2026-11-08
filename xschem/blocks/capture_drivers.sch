v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {capture_drivers: Capture-edge drivers   (flow box: Capture edge)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/inv_2.sym} 240 0 0 0 {name=xcap0}
C {devices/lab_pin.sym} 190 0 0 0 {name=l1 lab=capture}
C {devices/lab_pin.sym} 290 0 0 1 {name=l2 lab=capture_b}
C {@@ROOT@@/cells_tx/inv_2.sym} 440 0 0 0 {name=xcap1}
C {devices/lab_pin.sym} 390 0 0 0 {name=l3 lab=capture_b}
C {devices/lab_pin.sym} 490 0 0 1 {name=l4 lab=capture_local}
C {devices/ipin.sym} 60 0 0 0 {name=p5 lab=capture}
C {devices/opin.sym} 700 0 0 0 {name=p6 lab=capture_local}
