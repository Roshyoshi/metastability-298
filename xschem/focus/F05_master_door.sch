v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {@@ROOT@@/sym/nmos3.sym} 0 360 0 0 {name=ck_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 0 60 0 0 {name=ck_P1 model=pfet_05v0 W=1.22u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 180 360 0 0 {name=g1_N2 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 180 260 0 0 {name=g1_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 180 60 0 0 {name=g1_P2 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 290 60 0 0 {name=g1_P1 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 470 360 0 0 {name=g2_N2 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 470 260 0 0 {name=g2_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 470 60 0 0 {name=g2_P2 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 580 60 0 0 {name=g2_P1 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
N -160 0 800 0 {lab=VDD}
C {devices/lab_pin.sym} -160 0 0 0 {name=l1 lab=VDD}
N -160 420 800 420 {lab=VSS}
C {devices/lab_pin.sym} -160 420 0 0 {name=l2 lab=VSS}
N 20 390 20 420 {lab=VSS}
N 20 30 20 0 {lab=VDD}
N 200 390 200 420 {lab=VSS}
N 200 30 200 0 {lab=VDD}
N 310 30 310 0 {lab=VDD}
N 490 390 490 420 {lab=VSS}
N 490 30 490 0 {lab=VDD}
N 600 30 600 0 {lab=VDD}
N 200 230 450 230 {lab=g1}
N 200 230 200 90 {lab=g1}
N 200 90 310 90 {lab=g1}
N 450 230 450 260 {lab=g1}
N 450 230 450 220 {lab=g1}
N 450 220 560 220 {lab=g1}
N 560 220 560 140 {lab=g1}
N 560 140 560 60 {lab=g1}
N 560 140 760 140 {lab=g1}
N 20 330 160 330 {lab=clkn}
N 20 330 20 90 {lab=clkn}
N 160 330 160 360 {lab=clkn}
N 160 330 160 320 {lab=clkn}
N 20 90 160 90 {lab=clkn}
N 160 90 160 60 {lab=clkn}
N 160 320 420 320 {lab=clkn}
N 420 320 430 320 {lab=clkn}
N 430 320 450 320 {lab=clkn}
N 430 320 430 60 {lab=clkn}
N 450 320 450 360 {lab=clkn}
N 430 60 450 60 {lab=clkn}
N 490 230 490 180 {lab=g2}
N 490 180 760 180 {lab=g2}
N 490 180 490 90 {lab=g2}
N 490 90 600 90 {lab=g2}
N 160 260 160 210 {lab=d}
N 160 210 270 210 {lab=d}
N 160 210 160 140 {lab=d}
N 270 210 270 60 {lab=d}
N 160 140 -120 140 {lab=d}
N -20 360 -120 360 {lab=clk}
N -120 360 -120 180 {lab=clk}
N -120 180 -20 180 {lab=clk}
N -20 180 -20 60 {lab=clk}
N 200 330 200 290 {lab=u_mg1.net_0}
N 490 330 490 290 {lab=u_mg2.net_0}
C {devices/ipin.sym} -120 140 0 0 {name=p_d lab=d}
C {devices/ipin.sym} -120 180 0 0 {name=p_clk lab=clk}
C {devices/opin.sym} 760 140 0 0 {name=p_g1 lab=g1}
C {devices/opin.sym} 760 180 0 0 {name=p_g2 lab=g2}
C {devices/lab_wire.sym} 420 320 0 0 {name=l3 lab=clkn}
L 3 -40 -40 80 -40 {}
L 3 -40 -40 -40 -28 {}
L 3 80 -40 80 -28 {}
T {clock inverter u_cki} -40 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 140 -90 370 -90 {}
L 3 140 -90 140 -78 {}
L 3 370 -90 370 -78 {}
T {door gate u_mg1: g1 = NAND(d, clkn)} 140 -111.893 0 0 0.3 0.3 {layer=3}
L 3 430 -40 660 -40 {}
L 3 430 -40 430 -28 {}
L 3 660 -40 660 -28 {}
T {door gate u_mg2: g2 = NAND(g1, clkn)} 430 -61.8932 0 0 0.3 0.3 {layer=3}
T {F05  clock inverter and master door of the NAND flip-flops (same in DUT2, DUT3, DUT4)} -180 -229.382 0 0 0.45 0.45 {}
T {clk low -> clkn high: the door is open, g1 = NOT d and g2 = d, so the master latch follows d.} -180 -186.543 0 0 0.24 0.24 {}
T {clk high -> clkn low: g1 = g2 = 1, the door closes and the master latch (F01-F04) is left to resolve on its own.} -180 -167.218 0 0 0.24 0.24 {}
N -120 470 -20 470 {lab=clk}
C {devices/lab_wire.sym} -20 470 0 0 {name=l4 lab=clk}
T {clk: clock} 10 460.843 0 0 0.24 0.24 {}
N -120 510 -20 510 {lab=clkn}
C {devices/lab_wire.sym} -20 510 0 0 {name=l5 lab=clkn}
T {clkn: inverted clock} 10 500.843 0 0 0.24 0.24 {}
T {Rails: VDD at the top, VSS at the bottom; every PMOS body is on VDD and every NMOS body on VSS (drawn inside the symbol). A dot marks a connection; wires that cross without a dot are not connected.} -120 544 0 0 0.2 0.2 {}
