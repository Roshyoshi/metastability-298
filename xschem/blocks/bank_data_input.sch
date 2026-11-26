v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {bank_data_input: Bank: data input buffers (uio_in[0])   (flow box: Bank)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/inv_2.sym} 240 0 0 0 {name=xbank_data0}
C {devices/lab_pin.sym} 190 0 0 0 {name=l1 lab=uio_in_0}
C {devices/lab_pin.sym} 290 0 0 1 {name=l2 lab=bank_data_b}
C {@@ROOT@@/cells_tx/inv_2.sym} 440 0 0 0 {name=xbank_data1}
C {devices/lab_pin.sym} 390 0 0 0 {name=l3 lab=bank_data_b}
C {devices/lab_pin.sym} 490 0 0 1 {name=l4 lab=bank_data}
C {devices/ipin.sym} 60 0 0 0 {name=p5 lab=uio_in_0}
C {devices/opin.sym} 700 0 0 0 {name=p6 lab=bank_data}
