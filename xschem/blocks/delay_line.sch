v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {delay_line: Current-starved delay line: MP, MN, MC, timing capacitor MCT (NMOS gate capacitor, about 2 fF), three restoring inverters   (flow box: Adjustable delay)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 240 60 0 0 {name=MP L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {devices/lab_pin.sym} 260 30 0 1 {name=l1 lab=VDD}
C {devices/lab_pin.sym} 220 60 0 0 {name=l2 lab=launch}
C {devices/lab_pin.sym} 260 90 0 1 {name=l3 lab=slow}
C {devices/lab_pin.sym} 260 60 0 1 {name=l4 lab=VDD}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 240 190 0 0 {name=MN L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {devices/lab_pin.sym} 260 160 0 1 {name=l5 lab=slow}
C {devices/lab_pin.sym} 220 190 0 0 {name=l6 lab=launch}
C {devices/lab_pin.sym} 260 220 0 1 {name=l7 lab=foot}
C {devices/lab_pin.sym} 260 190 0 1 {name=l8 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 240 320 0 0 {name=MC L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {devices/lab_pin.sym} 260 290 0 1 {name=l9 lab=foot}
C {devices/lab_pin.sym} 220 320 0 0 {name=l10 lab=control}
C {devices/lab_pin.sym} 260 350 0 1 {name=l11 lab=0}
C {devices/lab_pin.sym} 260 320 0 1 {name=l12 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 420 250 0 0 {name=MCT L=1u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {devices/lab_pin.sym} 440 220 0 1 {name=l13 lab=0}
C {devices/lab_pin.sym} 400 250 0 0 {name=l14 lab=slow}
C {devices/lab_pin.sym} 440 280 0 1 {name=l15 lab=0}
C {devices/lab_pin.sym} 440 250 0 1 {name=l16 lab=0}
C {@@ROOT@@/cells_tx/inv_1.sym} 580 150 0 0 {name=xXR0}
C {devices/lab_pin.sym} 530 150 0 0 {name=l17 lab=slow}
C {devices/lab_pin.sym} 630 150 0 1 {name=l18 lab=r0}
C {@@ROOT@@/cells_tx/inv_2.sym} 740 150 0 0 {name=xXR1}
C {devices/lab_pin.sym} 690 150 0 0 {name=l19 lab=r0}
C {devices/lab_pin.sym} 790 150 0 1 {name=l20 lab=r1}
C {@@ROOT@@/cells_tx/inv_2.sym} 900 150 0 0 {name=xXR2}
C {devices/lab_pin.sym} 850 150 0 0 {name=l21 lab=r1}
C {devices/lab_pin.sym} 950 150 0 1 {name=l22 lab=sample_clk}
C {devices/ipin.sym} 60 0 0 0 {name=p23 lab=launch}
C {devices/ipin.sym} 60 40 0 0 {name=p24 lab=control}
C {devices/opin.sym} 1160 0 0 0 {name=p25 lab=sample_clk}
