v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {data_input: Data input buffers (ring oscillator moved off chip)   (flow box: Data input)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/inv_2.sym} 240 0 0 0 {name=xdata0}
C {devices/lab_pin.sym} 190 0 0 0 {name=l1 lab=ui_in_6}
C {devices/lab_pin.sym} 290 0 0 1 {name=l2 lab=data_b}
C {@@ROOT@@/cells_tx/inv_2.sym} 440 0 0 0 {name=xdata1}
C {devices/lab_pin.sym} 390 0 0 0 {name=l3 lab=data_b}
C {devices/lab_pin.sym} 490 0 0 1 {name=l4 lab=data_local}
C {devices/ipin.sym} 60 0 0 0 {name=p5 lab=ui_in_6}
C {devices/opin.sym} 700 0 0 0 {name=p6 lab=data_local}
