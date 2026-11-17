v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {status: Status: fault takes fault OR bad_bit on each count; done takes n_16 on b falling; busy = run AND NOT done   (flow box: Status)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {/home/oshan/metastability-298/xschem/cells_tx/and2_1.sym} 820 170 0 0 {name=xbusy_and}
C {devices/lab_pin.sym} 770 160 0 0 {name=l1 lab=run}
C {devices/lab_pin.sym} 770 180 0 0 {name=l2 lab=done_n}
C {devices/lab_pin.sym} 870 160 0 1 {name=l3 lab=uio_out_1}
C {/home/oshan/metastability-298/xschem/cells_tx/dffnrnq_1.sym} 300 190 0 0 {name=xdone_ff}
C {devices/lab_pin.sym} 250 170 0 0 {name=l4 lab=n_16}
C {devices/lab_pin.sym} 250 190 0 0 {name=l5 lab=run}
C {devices/lab_pin.sym} 250 210 0 0 {name=l6 lab=b}
C {devices/lab_pin.sym} 350 170 0 1 {name=l7 lab=uio_out_2}
C {/home/oshan/metastability-298/xschem/cells_tx/inv_1.sym} 560 170 0 0 {name=xdone_inv}
C {devices/lab_pin.sym} 510 170 0 0 {name=l8 lab=uio_out_2}
C {devices/lab_pin.sym} 610 170 0 1 {name=l9 lab=done_n}
C {/home/oshan/metastability-298/xschem/cells_tx/dffnrnq_1.sym} 560 20 0 0 {name=xfault_ff}
C {devices/lab_pin.sym} 510 0 0 0 {name=l10 lab=fault_d}
C {devices/lab_pin.sym} 510 20 0 0 {name=l11 lab=run}
C {devices/lab_pin.sym} 510 40 0 0 {name=l12 lab=tick_n}
C {devices/lab_pin.sym} 610 0 0 1 {name=l13 lab=uio_out_3}
C {/home/oshan/metastability-298/xschem/cells_tx/or2_1.sym} 300 0 0 0 {name=xfault_or}
C {devices/lab_pin.sym} 250 -10 0 0 {name=l14 lab=uio_out_3}
C {devices/lab_pin.sym} 250 10 0 0 {name=l15 lab=bad_bit}
C {devices/lab_pin.sym} 350 -10 0 1 {name=l16 lab=fault_d}
C {devices/ipin.sym} 60 0 0 0 {name=p17 lab=b}
C {devices/ipin.sym} 60 40 0 0 {name=p18 lab=bad_bit}
C {devices/ipin.sym} 60 80 0 0 {name=p19 lab=n_16}
C {devices/ipin.sym} 60 120 0 0 {name=p20 lab=run}
C {devices/ipin.sym} 60 160 0 0 {name=p21 lab=tick_n}
C {devices/opin.sym} 1080 0 0 0 {name=p22 lab=uio_out_1}
C {devices/opin.sym} 1080 40 0 0 {name=p23 lab=uio_out_2}
C {devices/opin.sym} 1080 80 0 0 {name=p24 lab=uio_out_3}
