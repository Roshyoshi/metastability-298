v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {monitors: Clock monitor buffers to uio_out[4], uio_out[5]   (flow box: Hold results + readout)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {/home/oshan/metastability-298/xschem/cells_tx/inv_1.sym} 240 0 0 0 {name=xmonitor_capture_a}
C {devices/lab_pin.sym} 190 0 0 0 {name=l1 lab=capture_local}
C {devices/lab_pin.sym} 290 0 0 1 {name=l2 lab=capmon_n}
C {/home/oshan/metastability-298/xschem/cells_tx/inv_2.sym} 440 0 0 0 {name=xmonitor_capture_b}
C {devices/lab_pin.sym} 390 0 0 0 {name=l3 lab=capmon_n}
C {devices/lab_pin.sym} 490 0 0 1 {name=l4 lab=uio_out_4}
C {/home/oshan/metastability-298/xschem/cells_tx/inv_1.sym} 240 130 0 0 {name=xmonitor_early_a}
C {devices/lab_pin.sym} 190 130 0 0 {name=l5 lab=early_clk}
C {devices/lab_pin.sym} 290 130 0 1 {name=l6 lab=earlymon_n}
C {/home/oshan/metastability-298/xschem/cells_tx/inv_2.sym} 440 130 0 0 {name=xmonitor_early_b}
C {devices/lab_pin.sym} 390 130 0 0 {name=l7 lab=earlymon_n}
C {devices/lab_pin.sym} 490 130 0 1 {name=l8 lab=uio_out_5}
C {devices/ipin.sym} 60 0 0 0 {name=p9 lab=capture_local}
C {devices/ipin.sym} 60 40 0 0 {name=p10 lab=early_clk}
C {devices/opin.sym} 700 0 0 0 {name=p11 lab=uio_out_4}
C {devices/opin.sym} 700 40 0 0 {name=p12 lab=uio_out_5}
