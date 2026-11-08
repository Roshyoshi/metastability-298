v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {@@ROOT@@/sym/nmos3.sym} 0 360 0 0 {name=s1_N2 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 0 260 0 0 {name=s1_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 0 60 0 0 {name=s1_P2 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 110 60 0 0 {name=s1_P1 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 290 360 0 0 {name=s2_N2 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 290 260 0 0 {name=s2_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 290 60 0 0 {name=s2_P2 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 400 60 0 0 {name=s2_P1 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 580 360 0 0 {name=sf_N2 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 580 260 0 0 {name=sf_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 580 60 0 0 {name=sf_P2 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 690 60 0 0 {name=sf_P1 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 870 360 0 0 {name=sk_N2 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 870 260 0 0 {name=sk_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 870 60 0 0 {name=sk_P2 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 980 60 0 0 {name=sk_P1 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
N -160 0 1200 0 {lab=VDD}
C {devices/lab_pin.sym} -160 0 0 0 {name=l1 lab=VDD}
N -160 420 1200 420 {lab=VSS}
C {devices/lab_pin.sym} -160 420 0 0 {name=l2 lab=VSS}
N 20 390 20 420 {lab=VSS}
N 20 30 20 0 {lab=VDD}
N 130 30 130 0 {lab=VDD}
N 310 390 310 420 {lab=VSS}
N 310 30 310 0 {lab=VDD}
N 420 30 420 0 {lab=VDD}
N 600 390 600 420 {lab=VSS}
N 600 30 600 0 {lab=VDD}
N 710 30 710 0 {lab=VDD}
N 890 390 890 420 {lab=VSS}
N 890 30 890 0 {lab=VDD}
N 1000 30 1000 0 {lab=VDD}
N 20 230 20 90 {lab=s1}
N 20 230 270 230 {lab=s1}
N 20 90 130 90 {lab=s1}
N 270 230 270 220 {lab=s1}
N 270 230 270 260 {lab=s1}
N 270 220 380 220 {lab=s1}
N 380 220 380 100 {lab=s1}
N 380 220 380 360 {lab=s1}
N 380 100 380 60 {lab=s1}
N 380 100 560 100 {lab=s1}
N 380 360 560 360 {lab=s1}
N 560 100 560 60 {lab=s1}
N 600 230 600 90 {lab=q}
N 600 230 850 230 {lab=q}
N 600 90 710 90 {lab=q}
N 850 230 850 260 {lab=q}
N 850 230 850 220 {lab=q}
N 850 220 960 220 {lab=q}
N 960 220 960 160 {lab=q}
N 960 160 960 60 {lab=q}
N 960 160 1160 160 {lab=q}
N 310 230 310 90 {lab=s2}
N 310 90 420 90 {lab=s2}
N 420 90 420 300 {lab=s2}
N 420 300 830 300 {lab=s2}
N 830 300 830 60 {lab=s2}
N 830 300 850 300 {lab=s2}
N 850 300 850 360 {lab=s2}
N 830 60 850 60 {lab=s2}
N 560 260 560 210 {lab=sqb}
N 560 210 670 210 {lab=sqb}
N 670 210 670 200 {lab=sqb}
N 670 200 890 200 {lab=sqb}
N 670 200 670 60 {lab=sqb}
N 890 200 890 90 {lab=sqb}
N 890 200 890 230 {lab=sqb}
N 890 90 1000 90 {lab=sqb}
N -20 360 -120 360 {lab=clk}
N -20 360 -20 320 {lab=clk}
N -120 360 -120 180 {lab=clk}
N -120 180 -20 180 {lab=clk}
N -20 320 250 320 {lab=clk}
N 250 320 250 60 {lab=clk}
N 250 320 270 320 {lab=clk}
N 270 320 270 360 {lab=clk}
N -20 180 -20 60 {lab=clk}
N 250 60 270 60 {lab=clk}
N -20 260 -40 260 {lab=mq}
N -40 260 -40 140 {lab=mq}
N -40 140 90 140 {lab=mq}
N -40 140 -120 140 {lab=mq}
N 90 140 90 60 {lab=mq}
N 20 330 20 290 {lab=u_sg1.net_0}
N 310 330 310 290 {lab=u_sg2.net_0}
N 600 330 600 290 {lab=u_sfw.net_0}
N 890 330 890 290 {lab=u_skp.net_0}
C {devices/ipin.sym} -120 140 0 0 {name=p_mq lab=mq}
C {devices/ipin.sym} -120 180 0 0 {name=p_clk lab=clk}
C {devices/opin.sym} 1160 160 0 0 {name=p_q lab=q}
L 3 -40 -40 190 -40 {}
L 3 -40 -40 -40 -28 {}
L 3 190 -40 190 -28 {}
T {slave door u_sg1} -40 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 250 -40 480 -40 {}
L 3 250 -40 250 -28 {}
L 3 480 -40 480 -28 {}
T {slave door u_sg2} 250 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 540 -40 770 -40 {}
L 3 540 -40 540 -28 {}
L 3 770 -40 770 -28 {}
T {slave latch u_sfw} 540 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 830 -40 1060 -40 {}
L 3 830 -40 830 -28 {}
L 3 1060 -40 1060 -28 {}
T {slave latch u_skp} 830 -61.8932 0 0 0.3 0.3 {layer=3}
T {F06  slave door and slave latch of the NAND flip-flops (same in DUT2, DUT3, DUT4)} -180 -179.382 0 0 0.45 0.45 {}
T {clk high: the slave door passes mq (s1 = NOT mq, s2 = mq) and the slave latch copies it to q.} -180 -136.543 0 0 0.24 0.24 {}
T {clk low: s1 = s2 = 1, the slave latch holds q while the master takes the next d.} -180 -117.218 0 0 0.24 0.24 {}
N -120 470 -20 470 {lab=clk}
C {devices/lab_wire.sym} -20 470 0 0 {name=l3 lab=clk}
T {clk: clock} 10 460.843 0 0 0.24 0.24 {}
N -120 510 -20 510 {lab=mq}
C {devices/lab_wire.sym} -20 510 0 0 {name=l4 lab=mq}
T {mq: from the master latch} 10 500.843 0 0 0.24 0.24 {}
T {Rails: VDD at the top, VSS at the bottom; every PMOS body is on VDD and every NMOS body on VSS (drawn inside the symbol). A dot marks a connection; wires that cross without a dot are not connected.} -120 544 0 0 0.2 0.2 {}
