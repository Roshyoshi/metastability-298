v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {duts: Four flip-flops under test   (flow box: Flip-flops under test)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {/home/oshan/metastability-298/xschem/cells_tx/dffq_1.sym} 300 0 0 0 {name=xu_dut1}
C {devices/lab_pin.sym} 250 -10 0 0 {name=l1 lab=data_local}
C {devices/lab_pin.sym} 250 10 0 0 {name=l2 lab=capture_local}
C {devices/lab_pin.sym} 350 -10 0 1 {name=l3 lab=q_0}
C {/home/oshan/metastability-298/xschem/blocks/meta_dut_baseline.sym} 300 130 0 0 {name=xu_dut2}
C {devices/lab_pin.sym} 250 120 0 0 {name=l4 lab=data_local}
C {devices/lab_pin.sym} 250 140 0 0 {name=l5 lab=capture_local}
C {devices/lab_pin.sym} 350 120 0 1 {name=l6 lab=q_1}
C {/home/oshan/metastability-298/xschem/blocks/meta_dut_keeper.sym} 300 260 0 0 {name=xu_dut3}
C {devices/lab_pin.sym} 250 250 0 0 {name=l7 lab=data_local}
C {devices/lab_pin.sym} 250 270 0 0 {name=l8 lab=capture_local}
C {devices/lab_pin.sym} 350 250 0 1 {name=l9 lab=q_2}
C {/home/oshan/metastability-298/xschem/blocks/meta_dut_forward.sym} 300 390 0 0 {name=xu_dut4}
C {devices/lab_pin.sym} 250 380 0 0 {name=l10 lab=data_local}
C {devices/lab_pin.sym} 250 400 0 0 {name=l11 lab=capture_local}
C {devices/lab_pin.sym} 350 380 0 1 {name=l12 lab=q_3}
C {devices/ipin.sym} 60 0 0 0 {name=p13 lab=capture_local}
C {devices/ipin.sym} 60 40 0 0 {name=p14 lab=data_local}
C {devices/opin.sym} 560 0 0 0 {name=p15 lab=q_0}
C {devices/opin.sym} 560 40 0 0 {name=p16 lab=q_1}
C {devices/opin.sym} 560 80 0 0 {name=p17 lab=q_2}
C {devices/opin.sym} 560 120 0 0 {name=p18 lab=q_3}
