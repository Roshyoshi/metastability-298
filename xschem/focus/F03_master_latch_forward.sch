v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 0 360 0 0 {name=fw_N8 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 0 260 0 0 {name=fw_N4 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 110 260 0 0 {name=fw_N3 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 110 360 0 0 {name=fw_N7 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 220 360 0 0 {name=fw_N6 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 220 260 0 0 {name=fw_N2 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 330 260 0 0 {name=fw_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 330 360 0 0 {name=fw_N5 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 0 60 0 0 {name=fw_P8 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 110 60 0 0 {name=fw_P4 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 220 60 0 0 {name=fw_P3 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 330 60 0 0 {name=fw_P7 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 440 60 0 0 {name=fw_P6 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 550 60 0 0 {name=fw_P2 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 660 60 0 0 {name=fw_P1 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 770 60 0 0 {name=fw_P5 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 950 360 0 0 {name=kp_N2 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 950 260 0 0 {name=kp_N1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 950 60 0 0 {name=kp_P2 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 1060 60 0 0 {name=kp_P1 model=pfet_05v0 W=1.13u L=0.5u spiceprefix=X}
N -160 0 1280 0 {lab=VDD}
C {devices/lab_pin.sym} -160 0 0 0 {name=l1 lab=VDD}
N -160 420 1280 420 {lab=VSS}
C {devices/lab_pin.sym} -160 420 0 0 {name=l2 lab=VSS}
N 20 390 20 420 {lab=VSS}
N 130 390 130 420 {lab=VSS}
N 240 390 240 420 {lab=VSS}
N 350 390 350 420 {lab=VSS}
N 20 30 20 0 {lab=VDD}
N 130 30 130 0 {lab=VDD}
N 240 30 240 0 {lab=VDD}
N 350 30 350 0 {lab=VDD}
N 460 30 460 0 {lab=VDD}
N 570 30 570 0 {lab=VDD}
N 680 30 680 0 {lab=VDD}
N 790 30 790 0 {lab=VDD}
N 970 390 970 420 {lab=VSS}
N 970 30 970 0 {lab=VDD}
N 1080 30 1080 0 {lab=VDD}
N 20 230 20 90 {lab=mq}
N 20 230 130 230 {lab=mq}
N 130 230 240 230 {lab=mq}
N 20 90 130 90 {lab=mq}
N 240 230 350 230 {lab=mq}
N 130 90 240 90 {lab=mq}
N 240 90 350 90 {lab=mq}
N 350 90 460 90 {lab=mq}
N 460 90 570 90 {lab=mq}
N 570 90 680 90 {lab=mq}
N 680 90 790 90 {lab=mq}
N 790 90 930 90 {lab=mq}
N 930 90 930 100 {lab=mq}
N 930 100 1040 100 {lab=mq}
N 930 100 930 260 {lab=mq}
N 1040 100 1040 60 {lab=mq}
N 1040 100 1040 140 {lab=mq}
N 1040 140 1240 140 {lab=mq}
N -20 260 -20 300 {lab=mqb}
N -20 300 90 300 {lab=mqb}
N 90 300 200 300 {lab=mqb}
N 90 300 90 260 {lab=mqb}
N 90 260 90 110 {lab=mqb}
N 200 300 310 300 {lab=mqb}
N 200 300 200 260 {lab=mqb}
N 90 110 200 110 {lab=mqb}
N 90 110 90 60 {lab=mqb}
N 310 300 310 260 {lab=mqb}
N 200 110 530 110 {lab=mqb}
N 200 110 200 60 {lab=mqb}
N 530 110 640 110 {lab=mqb}
N 530 110 530 60 {lab=mqb}
N 640 110 640 230 {lab=mqb}
N 640 110 640 60 {lab=mqb}
N 640 230 970 230 {lab=mqb}
N 970 230 970 180 {lab=mqb}
N 970 180 970 120 {lab=mqb}
N 970 180 1240 180 {lab=mqb}
N 970 120 970 90 {lab=mqb}
N 970 120 1080 120 {lab=mqb}
N 1080 120 1080 90 {lab=mqb}
N -20 360 -20 320 {lab=g1}
N -20 320 -40 320 {lab=g1}
N -20 320 90 320 {lab=g1}
N 90 320 90 360 {lab=g1}
N 90 320 200 320 {lab=g1}
N 200 320 200 360 {lab=g1}
N 200 320 290 320 {lab=g1}
N -40 320 -40 140 {lab=g1}
N -40 140 -40 60 {lab=g1}
N -40 140 -120 140 {lab=g1}
N -40 60 -20 60 {lab=g1}
N 290 320 310 320 {lab=g1}
N 290 320 290 130 {lab=g1}
N 310 320 310 360 {lab=g1}
N 290 130 290 60 {lab=g1}
N 290 130 420 130 {lab=g1}
N 290 60 310 60 {lab=g1}
N 420 130 750 130 {lab=g1}
N 420 130 420 60 {lab=g1}
N 750 130 750 60 {lab=g1}
N 930 360 910 360 {lab=g2}
N 910 360 910 180 {lab=g2}
N 910 180 -120 180 {lab=g2}
N 910 180 910 60 {lab=g2}
N 910 60 930 60 {lab=g2}
N 20 330 20 290 {lab=u_mfw.net_0_0}
N 130 290 130 330 {lab=u_mfw.net_0_1}
N 240 330 240 290 {lab=u_mfw.net_0_2}
N 350 290 350 330 {lab=u_mfw.net_0_3}
N 970 330 970 290 {lab=u_mkp.net_0}
C {devices/ipin.sym} -120 140 0 0 {name=p_g1 lab=g1}
C {devices/ipin.sym} -120 180 0 0 {name=p_g2 lab=g2}
C {devices/opin.sym} 1240 140 0 0 {name=p_mq lab=mq}
C {devices/opin.sym} 1240 180 0 0 {name=p_mqb lab=mqb}
L 7 -40 -40 850 -40 {}
L 7 -40 -40 -40 -28 {}
L 7 850 -40 850 -28 {}
T {CHANGED: forward u_mfw now nand2_4 (4 copies)} -40 -61.8932 0 0 0.3 0.3 {layer=7}
L 3 910 -40 1140 -40 {}
L 3 910 -40 910 -28 {}
L 3 1140 -40 1140 -28 {}
T {keeper u_mkp (nand2_1, unchanged): g_k} 910 -61.8932 0 0 0.3 0.3 {layer=3}
T {F03  master latch of DUT4: forward strengthened (nand2_2 -> nand2_4)} -180 -198.707 0 0 0.45 0.45 {}
T {With g1 = g2 = 1 (clock high, door closed) each NAND is an inverter: forward u_mfw drives mq from mqb, keeper u_mkp drives mqb from mq.} -180 -155.867 0 0 0.24 0.24 {}
T {CHANGE from DUT2: the forward u_mfw has four copies of each transistor in parallel (twice the baseline). Simulated tau: 88.9 ps -> 102.3 ps (the added capacitance outweighs the added drive).} -180 -136.543 0 0 0.24 0.24 {}
T {Names: fw = forward u_mfw, kp = keeper u_mkp; P/N = PMOS/NMOS. Two (or four) transistors side by side = copies in parallel.} -180 -117.218 0 0 0.24 0.24 {}
N -120 470 -20 470 {lab=mq}
C {devices/lab_wire.sym} -20 470 0 0 {name=l3 lab=mq}
T {mq: master node driven by the forward gate} 10 460.843 0 0 0.24 0.24 {}
N -120 510 -20 510 {lab=mqb}
C {devices/lab_wire.sym} -20 510 0 0 {name=l4 lab=mqb}
T {mqb: master node driven by the keeper gate} 10 500.843 0 0 0.24 0.24 {}
T {Rails: VDD at the top, VSS at the bottom; every PMOS body is on VDD and every NMOS body on VSS (drawn inside the symbol). A dot marks a connection; wires that cross without a dot are not connected.} -120 544 0 0 0.2 0.2 {}
