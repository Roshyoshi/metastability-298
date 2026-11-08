v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {@@ROOT@@/sym/nmos3.sym} 0 360 0 0 {name=fw_N4 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 0 260 0 0 {name=fw_N2 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 110 260 0 0 {name=fw_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 110 360 0 0 {name=fw_N3 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 0 60 0 0 {name=fw_P4 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 110 60 0 0 {name=fw_P2 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 220 60 0 0 {name=fw_P1 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 330 60 0 0 {name=fw_P3 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 510 360 0 0 {name=kp_N2 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 510 260 0 0 {name=kp_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 510 60 0 0 {name=kp_P2 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 620 60 0 0 {name=kp_P1 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
N -160 0 840 0 {lab=VDD}
C {devices/lab_pin.sym} -160 0 0 0 {name=l1 lab=VDD}
N -160 420 840 420 {lab=VSS}
C {devices/lab_pin.sym} -160 420 0 0 {name=l2 lab=VSS}
N 20 390 20 420 {lab=VSS}
N 130 390 130 420 {lab=VSS}
N 20 30 20 0 {lab=VDD}
N 130 30 130 0 {lab=VDD}
N 240 30 240 0 {lab=VDD}
N 350 30 350 0 {lab=VDD}
N 530 390 530 420 {lab=VSS}
N 530 30 530 0 {lab=VDD}
N 640 30 640 0 {lab=VDD}
N 20 230 20 90 {lab=mq}
N 20 230 130 230 {lab=mq}
N 20 90 130 90 {lab=mq}
N 130 90 240 90 {lab=mq}
N 240 90 350 90 {lab=mq}
N 350 90 490 90 {lab=mq}
N 490 90 490 100 {lab=mq}
N 490 100 490 260 {lab=mq}
N 490 100 600 100 {lab=mq}
N 600 100 600 60 {lab=mq}
N 600 100 600 140 {lab=mq}
N 600 140 800 140 {lab=mq}
N -20 260 -20 300 {lab=mqb}
N -20 300 90 300 {lab=mqb}
N 90 300 90 260 {lab=mqb}
N 90 260 90 110 {lab=mqb}
N 90 110 200 110 {lab=mqb}
N 90 110 90 60 {lab=mqb}
N 200 110 200 60 {lab=mqb}
N 200 110 200 230 {lab=mqb}
N 200 230 530 230 {lab=mqb}
N 530 230 530 180 {lab=mqb}
N 530 180 800 180 {lab=mqb}
N 530 180 530 120 {lab=mqb}
N 530 120 640 120 {lab=mqb}
N 530 120 530 90 {lab=mqb}
N 640 120 640 90 {lab=mqb}
N -20 360 -20 320 {lab=g1}
N -20 320 -40 320 {lab=g1}
N -20 320 90 320 {lab=g1}
N 90 320 90 360 {lab=g1}
N 90 320 310 320 {lab=g1}
N -40 320 -40 140 {lab=g1}
N -40 140 -40 60 {lab=g1}
N -40 140 -120 140 {lab=g1}
N -40 60 -20 60 {lab=g1}
N 310 320 310 60 {lab=g1}
N 490 360 470 360 {lab=g2}
N 470 360 470 180 {lab=g2}
N 470 180 -120 180 {lab=g2}
N 470 180 470 60 {lab=g2}
N 470 60 490 60 {lab=g2}
N 20 330 20 290 {lab=u_mfw.net_0_0}
N 130 290 130 330 {lab=u_mfw.net_0_1}
N 530 330 530 290 {lab=u_mkp.net_0}
C {devices/ipin.sym} -120 140 0 0 {name=p_g1 lab=g1}
C {devices/ipin.sym} -120 180 0 0 {name=p_g2 lab=g2}
C {devices/opin.sym} 800 140 0 0 {name=p_mq lab=mq}
C {devices/opin.sym} 800 180 0 0 {name=p_mqb lab=mqb}
L 3 -40 -40 410 -40 {}
L 3 -40 -40 -40 -28 {}
L 3 410 -40 410 -28 {}
T {forward u_mfw (nand2_2): g_f} -40 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 470 -40 700 -40 {}
L 3 470 -40 470 -28 {}
L 3 700 -40 700 -28 {}
T {keeper u_mkp (nand2_1): g_k} 470 -61.8932 0 0 0.3 0.3 {layer=3}
T {F01  master latch of DUT2 (baseline): forward nand2_2, keeper nand2_1} -180 -198.707 0 0 0.45 0.45 {}
T {With g1 = g2 = 1 (clock high, door closed) each NAND is an inverter: forward u_mfw drives mq from mqb, keeper u_mkp drives mqb from mq.} -180 -155.867 0 0 0.24 0.24 {}
T {1/tau = sqrt(g_f g_k / (C_mq C_mqb)): tau falls when the added drive outweighs the capacitance it adds.} -180 -136.543 0 0 0.24 0.24 {}
T {Names: fw = forward u_mfw, kp = keeper u_mkp; P/N = PMOS/NMOS. Two (or four) transistors side by side = copies in parallel.} -180 -117.218 0 0 0.24 0.24 {}
N -120 470 -20 470 {lab=mq}
C {devices/lab_wire.sym} -20 470 0 0 {name=l3 lab=mq}
T {mq: master node driven by the forward gate} 10 460.843 0 0 0.24 0.24 {}
N -120 510 -20 510 {lab=mqb}
C {devices/lab_wire.sym} -20 510 0 0 {name=l4 lab=mqb}
T {mqb: master node driven by the keeper gate} 10 500.843 0 0 0.24 0.24 {}
T {Rails: VDD at the top, VSS at the bottom; every PMOS body is on VDD and every NMOS body on VSS (drawn inside the symbol). A dot marks a connection; wires that cross without a dot are not connected.} -120 544 0 0 0.2 0.2 {}
