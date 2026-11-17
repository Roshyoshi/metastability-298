v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {pin_drivers: Constant outputs: ena buffers for uio_oe[5:1], tie-low cells for the unused outputs   (flow box: Hold results + readout)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {/home/oshan/metastability-298/xschem/cells_tx/buf_1.sym} 200 20 0 0 {name=xoe_buf1}
C {devices/lab_pin.sym} 150 20 0 0 {name=l1 lab=ena}
C {devices/lab_pin.sym} 250 20 0 1 {name=l2 lab=uio_oe_1}
C {/home/oshan/metastability-298/xschem/cells_tx/buf_1.sym} 200 130 0 0 {name=xoe_buf2}
C {devices/lab_pin.sym} 150 130 0 0 {name=l3 lab=ena}
C {devices/lab_pin.sym} 250 130 0 1 {name=l4 lab=uio_oe_2}
C {/home/oshan/metastability-298/xschem/cells_tx/buf_1.sym} 200 240 0 0 {name=xoe_buf3}
C {devices/lab_pin.sym} 150 240 0 0 {name=l5 lab=ena}
C {devices/lab_pin.sym} 250 240 0 1 {name=l6 lab=uio_oe_3}
C {/home/oshan/metastability-298/xschem/cells_tx/buf_1.sym} 200 350 0 0 {name=xoe_buf4}
C {devices/lab_pin.sym} 150 350 0 0 {name=l7 lab=ena}
C {devices/lab_pin.sym} 250 350 0 1 {name=l8 lab=uio_oe_4}
C {/home/oshan/metastability-298/xschem/cells_tx/buf_1.sym} 200 460 0 0 {name=xoe_buf5}
C {devices/lab_pin.sym} 150 460 0 0 {name=l9 lab=ena}
C {devices/lab_pin.sym} 250 460 0 1 {name=l10 lab=uio_oe_5}
C {/home/oshan/metastability-298/xschem/cells_tx/tiel.sym} 200 570 0 0 {name=xtielo_uio_oe0}
C {devices/lab_pin.sym} 250 570 0 1 {name=l11 lab=uio_oe_0}
C {/home/oshan/metastability-298/xschem/cells_tx/tiel.sym} 200 680 0 0 {name=xtielo_uio_oe6}
C {devices/lab_pin.sym} 250 680 0 1 {name=l12 lab=uio_oe_6}
C {/home/oshan/metastability-298/xschem/cells_tx/tiel.sym} 200 790 0 0 {name=xtielo_uio_oe7}
C {devices/lab_pin.sym} 250 790 0 1 {name=l13 lab=uio_oe_7}
C {/home/oshan/metastability-298/xschem/cells_tx/tiel.sym} 200 900 0 0 {name=xtielo_uio_out0}
C {devices/lab_pin.sym} 250 900 0 1 {name=l14 lab=uio_out_0}
C {/home/oshan/metastability-298/xschem/cells_tx/tiel.sym} 200 1010 0 0 {name=xtielo_uio_out6}
C {devices/lab_pin.sym} 250 1010 0 1 {name=l15 lab=uio_out_6}
C {/home/oshan/metastability-298/xschem/cells_tx/tiel.sym} 200 1120 0 0 {name=xtielo_uio_out7}
C {devices/lab_pin.sym} 250 1120 0 1 {name=l16 lab=uio_out_7}
C {devices/ipin.sym} 60 0 0 0 {name=p17 lab=ena}
C {devices/opin.sym} 460 0 0 0 {name=p18 lab=uio_oe_0}
C {devices/opin.sym} 460 40 0 0 {name=p19 lab=uio_oe_1}
C {devices/opin.sym} 460 80 0 0 {name=p20 lab=uio_oe_2}
C {devices/opin.sym} 460 120 0 0 {name=p21 lab=uio_oe_3}
C {devices/opin.sym} 460 160 0 0 {name=p22 lab=uio_oe_4}
C {devices/opin.sym} 460 200 0 0 {name=p23 lab=uio_oe_5}
C {devices/opin.sym} 460 240 0 0 {name=p24 lab=uio_oe_6}
C {devices/opin.sym} 460 280 0 0 {name=p25 lab=uio_oe_7}
C {devices/opin.sym} 460 320 0 0 {name=p26 lab=uio_out_0}
C {devices/opin.sym} 460 360 0 0 {name=p27 lab=uio_out_6}
C {devices/opin.sym} 460 400 0 0 {name=p28 lab=uio_out_7}
