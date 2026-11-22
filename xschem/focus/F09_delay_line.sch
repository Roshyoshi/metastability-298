v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {@@ROOT@@/sym/nmos3.sym} 0 360 0 0 {name=i0_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 0 60 0 0 {name=i0_P1 model=pfet_05v0 W=1.22u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 180 360 0 0 {name=i1_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 290 360 0 0 {name=i1_N2 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 180 60 0 0 {name=i1_P1 model=pfet_05v0 W=1.22u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 290 60 0 0 {name=i1_P2 model=pfet_05v0 W=1.22u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 830 360 0 0 {name=r0_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 830 60 0 0 {name=r0_P1 model=pfet_05v0 W=1.22u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 1010 360 0 0 {name=r1_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 1120 360 0 0 {name=r1_N2 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 1010 60 0 0 {name=r1_P1 model=pfet_05v0 W=1.22u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 1120 60 0 0 {name=r1_P2 model=pfet_05v0 W=1.22u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 1300 360 0 0 {name=r2_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 1410 360 0 0 {name=r2_N2 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 1300 60 0 0 {name=r2_P1 model=pfet_05v0 W=1.22u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 1410 60 0 0 {name=r2_P2 model=pfet_05v0 W=1.22u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 470 60 0 0 {name=MP model=pfet_05v0 W=1.22u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 470 260 0 0 {name=MN model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 470 360 0 0 {name=MC model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 650 360 0 0 {name=MCT model=nfet_05v0 W=0.82u L=1u spiceprefix=X}
N -160 0 1630 0 {lab=VDD}
C {devices/lab_pin.sym} -160 0 0 0 {name=l1 lab=VDD}
N -160 420 1630 420 {lab=VSS}
C {devices/lab_pin.sym} -160 420 0 0 {name=l2 lab=VSS}
N 20 390 20 420 {lab=VSS}
N 20 30 20 0 {lab=VDD}
N 200 390 200 420 {lab=VSS}
N 310 390 310 420 {lab=VSS}
N 200 30 200 0 {lab=VDD}
N 310 30 310 0 {lab=VDD}
N 850 390 850 420 {lab=VSS}
N 850 30 850 0 {lab=VDD}
N 1030 390 1030 420 {lab=VSS}
N 1140 390 1140 420 {lab=VSS}
N 1030 30 1030 0 {lab=VDD}
N 1140 30 1140 0 {lab=VDD}
N 1320 390 1320 420 {lab=VSS}
N 1430 390 1430 420 {lab=VSS}
N 1320 30 1320 0 {lab=VDD}
N 1430 30 1430 0 {lab=VDD}
N 490 30 490 0 {lab=VDD}
N 490 390 490 420 {lab=VSS}
N 670 390 670 420 {lab=VSS}
N 1030 330 1140 330 {lab=r1}
N 1030 330 1030 90 {lab=r1}
N 1140 330 1280 330 {lab=r1}
N 1030 90 1140 90 {lab=r1}
N 1280 330 1280 320 {lab=r1}
N 1280 330 1280 360 {lab=r1}
N 1140 90 1280 90 {lab=r1}
N 1280 320 1390 320 {lab=r1}
N 1390 320 1390 60 {lab=r1}
N 1390 320 1390 360 {lab=r1}
N 1280 90 1280 60 {lab=r1}
N 20 330 160 330 {lab=capture_iso_b}
N 20 330 20 90 {lab=capture_iso_b}
N 160 330 160 360 {lab=capture_iso_b}
N 160 330 160 320 {lab=capture_iso_b}
N 20 90 160 90 {lab=capture_iso_b}
N 160 320 270 320 {lab=capture_iso_b}
N 270 320 270 360 {lab=capture_iso_b}
N 270 320 270 60 {lab=capture_iso_b}
N 160 90 160 60 {lab=capture_iso_b}
N 200 330 200 90 {lab=launch}
N 200 330 310 330 {lab=launch}
N 310 330 310 260 {lab=launch}
N 200 90 310 90 {lab=launch}
N 310 260 450 260 {lab=launch}
N 450 260 450 60 {lab=launch}
N 850 330 850 90 {lab=r0}
N 850 330 990 330 {lab=r0}
N 990 330 990 310 {lab=r0}
N 990 330 990 360 {lab=r0}
N 850 90 990 90 {lab=r0}
N 990 310 1100 310 {lab=r0}
N 1100 310 1100 60 {lab=r0}
N 1100 310 1100 360 {lab=r0}
N 990 90 990 60 {lab=r0}
N 810 360 810 320 {lab=slow}
N 810 320 800 320 {lab=slow}
N 800 320 630 320 {lab=slow}
N 810 320 810 60 {lab=slow}
N 630 320 630 230 {lab=slow}
N 630 320 630 360 {lab=slow}
N 630 230 490 230 {lab=slow}
N 490 230 490 90 {lab=slow}
N 1320 330 1430 330 {lab=early_clk}
N 1320 330 1320 90 {lab=early_clk}
N 1320 90 1430 90 {lab=early_clk}
N 1430 90 1430 160 {lab=early_clk}
N 1430 160 1590 160 {lab=early_clk}
N -20 360 -20 140 {lab=capture_local}
N -20 140 -120 140 {lab=capture_local}
N -20 140 -20 60 {lab=capture_local}
N 450 360 430 360 {lab=ua_0}
N 430 360 430 180 {lab=ua_0}
N 430 180 -120 180 {lab=ua_0}
N 710 420 710 330 {lab=VSS}
N 710 330 670 330 {lab=VSS}
N 490 290 490 330 {lab=foot}
C {devices/ipin.sym} -120 140 0 0 {name=p_capture_local lab=capture_local}
C {devices/ipin.sym} -120 180 0 0 {name=p_ua_0 lab=ua_0}
C {devices/opin.sym} 1590 160 0 0 {name=p_early_clk lab=early_clk}
C {devices/lab_wire.sym} 800 320 0 0 {name=l3 lab=slow}
L 3 -40 -40 370 -40 {}
L 3 -40 -40 -40 -28 {}
L 3 370 -40 370 -28 {}
T {isolation buffer iso0, iso1} -40 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 430 -40 550 -40 {}
L 3 430 -40 430 -28 {}
L 3 550 -40 550 -28 {}
T {current-starved stage} 430 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 610 -90 730 -90 {}
L 3 610 -90 610 -78 {}
L 3 730 -90 730 -78 {}
T {MCT} 610 -111.893 0 0 0.3 0.3 {layer=3}
L 3 790 -40 1490 -40 {}
L 3 790 -40 790 -28 {}
L 3 1490 -40 1490 -28 {}
T {restoring inverters XR0, XR1, XR2} 790 -61.8932 0 0 0.3 0.3 {layer=3}
T {F09  the whole delay line: capture_local -> early_clk} -180 -229.382 0 0 0.45 0.45 {}
T {iso0, iso1 buffer the capture edge into launch. MP/MN/MC/MCT: the current-starved stage of F08 (ua[0] sets how fast slow falls).} -180 -186.543 0 0 0.24 0.24 {}
T {XR0-XR2 square the slow ramp back into a sharp edge: early_clk, which clocks the early observer a time d after capture.} -180 -167.218 0 0 0.24 0.24 {}
N -120 470 12.2112 470 {lab=capture_local}
C {devices/lab_wire.sym} 12.2112 470 0 0 {name=l4 lab=capture_local}
T {capture edge in} 42.2112 460.843 0 0 0.24 0.24 {}
N -120 510 -20 510 {lab=ua_0}
C {devices/lab_wire.sym} -20 510 0 0 {name=l5 lab=ua_0}
T {ua[0]: control voltage} 10 500.843 0 0 0.24 0.24 {}
N -120 550 -20 550 {lab=slow}
C {devices/lab_wire.sym} -20 550 0 0 {name=l6 lab=slow}
T {slow ramp} 10 540.843 0 0 0.24 0.24 {}
N -120 590 -19.2384 590 {lab=early_clk}
C {devices/lab_wire.sym} -19.2384 590 0 0 {name=l7 lab=early_clk}
T {early_clk out} 10.7616 580.843 0 0 0.24 0.24 {}
T {Rails: VDD at the top, VSS at the bottom; every PMOS body is on VDD and every NMOS body on VSS (drawn inside the symbol). A dot marks a connection; wires that cross without a dot are not connected.} -120 624 0 0 0.2 0.2 {}
