v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {@@ROOT@@/sym/nmos3.sym} 0 560 0 0 {name=tn10 model=nfet_05v0 W=0.405u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 180 560 0 0 {name=tn13 model=nfet_05v0 W=0.405u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 360 560 0 0 {name=tn11 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 360 460 0 0 {name=tn15 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 470 360 0 0 {name=tn14 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 470 460 0 0 {name=tn8 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 470 560 0 0 {name=tn9 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 1050 560 0 0 {name=tn18 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 1050 460 0 0 {name=tn0 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 1160 460 0 0 {name=tn1 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 1160 560 0 0 {name=tn12 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 760 560 0 0 {name=tn5 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 760 460 0 0 {name=tn4 model=nfet_05v0 W=0.4u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/nmos3.sym} 1340 560 0 0 {name=tn3 model=nfet_05v0 W=0.815u L=0.6u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 0 60 0 0 {name=tp8 model=pfet_05v0 W=0.865u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 180 60 0 0 {name=tp11 model=pfet_05v0 W=0.865u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 360 60 0 0 {name=tp9 model=pfet_05v0 W=0.78u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 360 160 0 0 {name=tp15 model=pfet_05v0 W=0.78u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 580 160 0 0 {name=tp7 model=pfet_05v0 W=0.78u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 470 60 0 0 {name=tp6 model=pfet_05v0 W=0.78u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 580 60 0 0 {name=tp12 model=pfet_05v0 W=0.78u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 1050 60 0 0 {name=tp18 model=pfet_05v0 W=0.505u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 1050 160 0 0 {name=tp2 model=pfet_05v0 W=0.505u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 1160 160 0 0 {name=tp3 model=pfet_05v0 W=0.505u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 1160 60 0 0 {name=tp10 model=pfet_05v0 W=0.505u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 760 60 0 0 {name=tp5 model=pfet_05v0 W=1u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 870 60 0 0 {name=tp4 model=pfet_05v0 W=1u L=0.5u spiceprefix=X}
C {@@ROOT@@/sym/pmos3.sym} 1340 60 0 0 {name=tp1 model=pfet_05v0 W=1.215u L=0.5u spiceprefix=X}
N -160 0 1560 0 {lab=VDD}
C {devices/lab_pin.sym} -160 0 0 0 {name=l1 lab=VDD}
N -160 620 1560 620 {lab=VSS}
C {devices/lab_pin.sym} -160 620 0 0 {name=l2 lab=VSS}
N 20 590 20 620 {lab=VSS}
N 200 590 200 620 {lab=VSS}
N 380 590 380 620 {lab=VSS}
N 490 590 490 620 {lab=VSS}
N 1070 590 1070 620 {lab=VSS}
N 1180 590 1180 620 {lab=VSS}
N 780 590 780 620 {lab=VSS}
N 1360 590 1360 620 {lab=VSS}
N 20 30 20 0 {lab=VDD}
N 200 30 200 0 {lab=VDD}
N 380 30 380 0 {lab=VDD}
N 490 30 490 0 {lab=VDD}
N 600 30 600 0 {lab=VDD}
N 1070 30 1070 0 {lab=VDD}
N 1180 30 1180 0 {lab=VDD}
N 780 30 780 0 {lab=VDD}
N 890 30 890 0 {lab=VDD}
N 1360 30 1360 0 {lab=VDD}
N 20 530 20 90 {lab=ncki}
N 20 530 160 530 {lab=ncki}
N 160 530 160 460 {lab=ncki}
N 160 530 160 560 {lab=ncki}
N 160 460 340 460 {lab=ncki}
N 20 90 160 90 {lab=ncki}
N 160 90 160 100 {lab=ncki}
N 160 90 160 60 {lab=ncki}
N 160 100 560 100 {lab=ncki}
N 560 100 560 160 {lab=ncki}
N 560 160 560 200 {lab=ncki}
N 560 200 990 200 {lab=ncki}
N 990 200 1030 200 {lab=ncki}
N 1030 200 1140 200 {lab=ncki}
N 1030 200 1030 160 {lab=ncki}
N 1140 200 1140 460 {lab=ncki}
N 1140 560 1140 520 {lab=net4}
N 1140 520 1320 520 {lab=net4}
N 1140 520 1120 520 {lab=net4}
N 1320 520 1320 560 {lab=net4}
N 1120 520 1020 520 {lab=net4}
N 1120 520 1120 100 {lab=net4}
N 1020 520 1020 430 {lab=net4}
N 1020 430 780 430 {lab=net4}
N 1120 100 1120 60 {lab=net4}
N 1120 100 1320 100 {lab=net4}
N 1120 100 890 100 {lab=net4}
N 1120 60 1140 60 {lab=net4}
N 1320 100 1320 60 {lab=net4}
N 890 100 890 90 {lab=net4}
N 890 90 780 90 {lab=net4}
N 200 530 200 360 {lab=cki}
N 200 360 450 360 {lab=cki}
N 200 360 200 160 {lab=cki}
N 450 360 450 400 {lab=cki}
N 200 160 200 90 {lab=cki}
N 200 160 340 160 {lab=cki}
N 450 400 1030 400 {lab=cki}
N 1030 400 1030 460 {lab=cki}
N 1030 400 1110 400 {lab=cki}
N 1110 400 1160 400 {lab=cki}
N 1160 400 1160 190 {lab=cki}
N 1160 190 1140 190 {lab=cki}
N 1140 190 1140 160 {lab=cki}
N 380 430 380 330 {lab=net1}
N 380 330 380 190 {lab=net1}
N 380 330 490 330 {lab=net1}
N 490 330 820 330 {lab=net1}
N 380 190 600 190 {lab=net1}
N 820 330 820 560 {lab=net1}
N 820 330 930 330 {lab=net1}
N 820 560 1020 560 {lab=net1}
N 1020 560 1030 560 {lab=net1}
N 930 330 930 60 {lab=net1}
N 930 60 1030 60 {lab=net1}
N 450 460 450 500 {lab=net2}
N 450 460 430 460 {lab=net2}
N 430 460 430 60 {lab=net2}
N 430 60 450 60 {lab=net2}
N 450 500 990 500 {lab=net2}
N 990 500 1000 500 {lab=net2}
N 1000 500 1070 500 {lab=net2}
N 1000 500 1000 130 {lab=net2}
N 1070 500 1070 490 {lab=net2}
N 1070 500 1070 530 {lab=net2}
N 1000 130 1070 130 {lab=net2}
N 1070 130 1070 90 {lab=net2}
N 1070 430 1070 380 {lab=net8}
N 1070 430 1180 430 {lab=net8}
N 1180 430 1180 190 {lab=net8}
N 1070 380 1070 190 {lab=net8}
N 1070 380 850 380 {lab=net8}
N 850 380 740 380 {lab=net8}
N 850 380 850 60 {lab=net8}
N 740 380 740 460 {lab=net8}
N 450 560 450 520 {lab=RN}
N 450 520 540 520 {lab=RN}
N 540 520 540 260 {lab=RN}
N 540 520 740 520 {lab=RN}
N 740 520 740 560 {lab=RN}
N 540 260 -120 260 {lab=RN}
N 540 260 540 120 {lab=RN}
N 540 120 540 60 {lab=RN}
N 540 120 740 120 {lab=RN}
N 540 60 560 60 {lab=RN}
N 740 120 740 60 {lab=RN}
N 380 530 380 490 {lab=net10}
N 380 490 330 490 {lab=net10}
N 330 490 330 130 {lab=net10}
N 330 130 380 130 {lab=net10}
N 380 130 380 90 {lab=net10}
N 1180 490 1220 490 {lab=net11}
N 1180 490 1180 530 {lab=net11}
N 1220 490 1220 130 {lab=net11}
N 1220 130 1180 130 {lab=net11}
N 1180 130 1180 90 {lab=net11}
N 340 560 310 560 {lab=D}
N 310 560 310 220 {lab=D}
N 310 220 -120 220 {lab=D}
N 310 220 310 60 {lab=D}
N 310 60 340 60 {lab=D}
N 1360 530 1520 530 {lab=Q}
N 1520 530 1520 260 {lab=Q}
N 1520 260 1360 260 {lab=Q}
N 1360 260 1360 90 {lab=Q}
N 600 130 600 90 {lab=net9}
N 600 90 490 90 {lab=net9}
N -20 560 -120 560 {lab=CLK}
N -120 560 -120 300 {lab=CLK}
N -120 300 -20 300 {lab=CLK}
N -20 300 -20 60 {lab=CLK}
N 490 390 490 430 {lab=net15}
N 490 490 490 530 {lab=net12}
N 780 530 780 490 {lab=net0}
C {devices/ipin.sym} -120 220 0 0 {name=p_D lab=D}
C {devices/ipin.sym} -120 260 0 0 {name=p_RN lab=RN}
C {devices/ipin.sym} -120 300 0 0 {name=p_CLK lab=CLK}
C {devices/opin.sym} 1520 260 0 0 {name=p_Q lab=Q}
C {devices/lab_wire.sym} 1110 400 0 0 {name=l3 lab=cki}
C {devices/lab_wire.sym} 990 200 0 0 {name=l4 lab=ncki}
C {devices/lab_wire.sym} 1020 560 0 0 {name=l5 lab=net1}
C {devices/lab_wire.sym} 990 500 0 0 {name=l6 lab=net2}
L 3 -40 -40 260 -40 {}
L 3 -40 -40 -40 -28 {}
L 3 260 -40 260 -28 {}
T {clock inverters} -40 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 320 -40 660 -40 {}
L 3 320 -40 320 -28 {}
L 3 660 -40 660 -28 {}
T {master: clocked input + NAND(net2, RN)} 320 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 720 -40 950 -40 {}
L 3 720 -40 720 -28 {}
L 3 950 -40 950 -28 {}
T {slave NAND(net8, RN)} 720 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 1010 -40 1240 -40 {}
L 3 1010 -40 1010 -28 {}
L 3 1240 -40 1240 -28 {}
T {master inverter, pass gate, slave feedback} 1010 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 1300 -90 1420 -90 {}
L 3 1300 -90 1300 -78 {}
L 3 1420 -90 1420 -78 {}
T {output} 1300 -111.893 0 0 0.3 0.3 {layer=3}
T {F11  dffrnq_1: controller flip-flop with reset (b, start_meta, run); the other 36 use dffnrnq_1} -180 -229.382 0 0 0.45 0.45 {}
T {Same plan as F07 with a NAND in each loop: RN = 0 forces both NANDs to output 1, so net4 = 1 and Q = 0 whatever the clock does.} -180 -186.543 0 0 0.24 0.24 {}
T {Master loop: net1 -> inverter -> net2 -> NAND(net2, RN) -> net1. Slave: NAND(net8, RN) -> net4 -> Q = NOT net4.} -180 -167.218 0 0 0.24 0.24 {}
N -120 670 -20 670 {lab=CLK}
C {devices/lab_wire.sym} -20 670 0 0 {name=l7 lab=CLK}
N 0 670 100 670 {lab=cki}
C {devices/lab_wire.sym} 100 670 0 0 {name=l8 lab=cki}
T {clock} 130 660.843 0 0 0.24 0.24 {}
N -120 710 -20 710 {lab=ncki}
C {devices/lab_wire.sym} -20 710 0 0 {name=l9 lab=ncki}
T {inverted clock} 10 700.843 0 0 0.24 0.24 {}
N -120 750 -20 750 {lab=RN}
C {devices/lab_wire.sym} -20 750 0 0 {name=l10 lab=RN}
T {reset (active low)} 10 740.843 0 0 0.24 0.24 {}
N -120 790 -20 790 {lab=net1}
C {devices/lab_wire.sym} -20 790 0 0 {name=l11 lab=net1}
T {master loop node} 10 780.843 0 0 0.24 0.24 {}
N -120 830 -20 830 {lab=net2}
C {devices/lab_wire.sym} -20 830 0 0 {name=l12 lab=net2}
T {master loop node (complement)} 10 820.843 0 0 0.24 0.24 {}
T {Rails: VDD at the top, VSS at the bottom; every PMOS body is on VDD and every NMOS body on VSS (drawn inside the symbol). A dot marks a connection; wires that cross without a dot are not connected.} -120 864 0 0 0.2 0.2 {}
