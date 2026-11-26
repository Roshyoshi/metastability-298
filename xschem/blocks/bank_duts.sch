v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {bank_duts: Bank: flip-flops under test N1 (3.3 V NAND), N2 (3.3 V jamb latch j3a), N3 (copy of DUT3)   (flow box: Bank)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/blocks/meta_dut_n3ffb.sym} 300 0 0 0 {name=xbank_n1}
C {devices/lab_pin.sym} 250 -10 0 0 {name=l1 lab=bank_data}
C {devices/lab_pin.sym} 250 10 0 0 {name=l2 lab=bank_cap}
C {devices/lab_pin.sym} 350 -10 0 1 {name=l3 lab=bank_q_0}
C {@@ROOT@@/blocks/meta_dut_j3a.sym} 300 130 0 0 {name=xbank_n2}
C {devices/lab_pin.sym} 250 120 0 0 {name=l4 lab=bank_data}
C {devices/lab_pin.sym} 250 140 0 0 {name=l5 lab=bank_cap}
C {devices/lab_pin.sym} 350 120 0 1 {name=l6 lab=bank_q_1}
C {@@ROOT@@/blocks/meta_dut_keeper.sym} 300 260 0 0 {name=xbank_n3}
C {devices/lab_pin.sym} 250 250 0 0 {name=l7 lab=bank_data}
C {devices/lab_pin.sym} 250 270 0 0 {name=l8 lab=bank_cap}
C {devices/lab_pin.sym} 350 250 0 1 {name=l9 lab=bank_q_2}
C {devices/ipin.sym} 60 0 0 0 {name=p10 lab=bank_cap}
C {devices/ipin.sym} 60 40 0 0 {name=p11 lab=bank_data}
C {devices/opin.sym} 560 0 0 0 {name=p12 lab=bank_q_0}
C {devices/opin.sym} 560 40 0 0 {name=p13 lab=bank_q_1}
C {devices/opin.sym} 560 80 0 0 {name=p14 lab=bank_q_2}
