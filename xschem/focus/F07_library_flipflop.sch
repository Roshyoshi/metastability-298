v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 0 460 0 0 {name=tn3 model=nfet_05v0 W=0.405u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 180 460 0 0 {name=tn4 model=nfet_05v0 W=0.405u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 360 460 0 0 {name=tn5 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 360 360 0 0 {name=tn8 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 470 360 0 0 {name=tn6 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 470 460 0 0 {name=tn7 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 650 460 0 0 {name=tn0 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 650 360 0 0 {name=tn9 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 760 360 0 0 {name=tn11 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 760 460 0 0 {name=tn12 model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 940 460 0 0 {name=tn10 model=nfet_05v0 W=0.4u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 1120 460 0 0 {name=tn1 model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 0 60 0 0 {name=tp3 model=pfet_05v0 W=0.865u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 180 60 0 0 {name=tp4 model=pfet_05v0 W=0.865u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 360 60 0 0 {name=tp12 model=pfet_05v0 W=0.36u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 360 160 0 0 {name=tp11 model=pfet_05v0 W=0.36u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 470 160 0 0 {name=tp6 model=pfet_05v0 W=0.36u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 470 60 0 0 {name=tp5 model=pfet_05v0 W=0.36u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 650 60 0 0 {name=tp0 model=pfet_05v0 W=0.36u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 650 160 0 0 {name=tp7 model=pfet_05v0 W=0.36u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 760 160 0 0 {name=tp9 model=pfet_05v0 W=0.36u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 760 60 0 0 {name=tp10 model=pfet_05v0 W=0.36u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 940 60 0 0 {name=tp8 model=pfet_05v0 W=0.8u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 1120 60 0 0 {name=tp1 model=pfet_05v0 W=1.22u L=0.5u spiceprefix=X}
N -160 0 1340 0 {lab=VDD}
C {devices/lab_pin.sym} -160 0 0 0 {name=l1 lab=VDD}
N -160 520 1340 520 {lab=VSS}
C {devices/lab_pin.sym} -160 520 0 0 {name=l2 lab=VSS}
N 20 490 20 520 {lab=VSS}
N 200 490 200 520 {lab=VSS}
N 380 490 380 520 {lab=VSS}
N 490 490 490 520 {lab=VSS}
N 670 490 670 520 {lab=VSS}
N 780 490 780 520 {lab=VSS}
N 960 490 960 520 {lab=VSS}
N 1140 490 1140 520 {lab=VSS}
N 20 30 20 0 {lab=VDD}
N 200 30 200 0 {lab=VDD}
N 380 30 380 0 {lab=VDD}
N 490 30 490 0 {lab=VDD}
N 670 30 670 0 {lab=VDD}
N 780 30 780 0 {lab=VDD}
N 960 30 960 0 {lab=VDD}
N 1140 30 1140 0 {lab=VDD}
N 20 430 160 430 {lab=ncki}
N 20 430 20 90 {lab=ncki}
N 160 430 160 460 {lab=ncki}
N 160 430 160 420 {lab=ncki}
N 20 90 160 90 {lab=ncki}
N 160 420 340 420 {lab=ncki}
N 340 420 340 460 {lab=ncki}
N 340 420 730 420 {lab=ncki}
N 730 420 740 420 {lab=ncki}
N 160 90 160 100 {lab=ncki}
N 160 90 160 60 {lab=ncki}
N 160 100 450 100 {lab=ncki}
N 450 100 450 120 {lab=ncki}
N 450 120 450 160 {lab=ncki}
N 450 120 630 120 {lab=ncki}
N 740 420 740 360 {lab=ncki}
N 630 120 630 160 {lab=ncki}
N 200 430 200 400 {lab=cki}
N 200 400 450 400 {lab=cki}
N 200 400 200 120 {lab=cki}
N 450 400 630 400 {lab=cki}
N 450 400 450 360 {lab=cki}
N 200 120 340 120 {lab=cki}
N 200 120 200 90 {lab=cki}
N 630 400 630 360 {lab=cki}
N 630 360 630 320 {lab=cki}
N 340 120 340 60 {lab=cki}
N 630 320 730 320 {lab=cki}
N 730 320 740 320 {lab=cki}
N 740 320 740 160 {lab=cki}
N 740 460 740 430 {lab=net3}
N 740 430 750 430 {lab=net3}
N 750 430 750 420 {lab=net3}
N 750 420 830 420 {lab=net3}
N 830 420 830 120 {lab=net3}
N 830 420 960 420 {lab=net3}
N 960 420 960 430 {lab=net3}
N 960 430 1100 430 {lab=net3}
N 1100 430 1100 460 {lab=net3}
N 830 120 740 120 {lab=net3}
N 830 120 830 90 {lab=net3}
N 740 120 740 60 {lab=net3}
N 830 90 960 90 {lab=net3}
N 960 90 1100 90 {lab=net3}
N 1100 90 1100 60 {lab=net3}
N 380 330 380 190 {lab=net4}
N 380 330 490 330 {lab=net4}
N 490 330 530 330 {lab=net4}
N 380 190 490 190 {lab=net4}
N 490 190 530 190 {lab=net4}
N 530 330 530 460 {lab=net4}
N 530 460 620 460 {lab=net4}
N 620 460 630 460 {lab=net4}
N 530 190 530 60 {lab=net4}
N 530 60 630 60 {lab=net4}
N 670 330 780 330 {lab=net2}
N 670 330 670 190 {lab=net2}
N 780 330 780 190 {lab=net2}
N 780 330 920 330 {lab=net2}
N 920 330 920 460 {lab=net2}
N 920 330 920 60 {lab=net2}
N 450 460 430 460 {lab=net0}
N 430 460 430 310 {lab=net0}
N 430 310 600 310 {lab=net0}
N 600 310 610 310 {lab=net0}
N 430 310 430 60 {lab=net0}
N 610 310 610 390 {lab=net0}
N 610 310 610 130 {lab=net0}
N 610 390 670 390 {lab=net0}
N 670 390 670 430 {lab=net0}
N 430 60 450 60 {lab=net0}
N 610 130 670 130 {lab=net0}
N 670 130 670 90 {lab=net0}
N 340 360 340 240 {lab=D}
N 340 240 340 160 {lab=D}
N 340 240 -120 240 {lab=D}
N 1140 430 1300 430 {lab=Q}
N 1140 430 1140 90 {lab=Q}
N 1300 430 1300 260 {lab=Q}
N -20 460 -120 460 {lab=CLK}
N -120 460 -120 280 {lab=CLK}
N -120 280 -20 280 {lab=CLK}
N -20 280 -20 60 {lab=CLK}
N 380 430 380 390 {lab=net5}
N 490 390 490 430 {lab=net6}
N 780 390 780 430 {lab=net1}
N 380 90 380 130 {lab=net7}
N 490 130 490 90 {lab=net8}
N 780 130 780 90 {lab=net1x}
C {devices/ipin.sym} -120 240 0 0 {name=p_D lab=D}
C {devices/ipin.sym} -120 280 0 0 {name=p_CLK lab=CLK}
C {devices/opin.sym} 1300 260 0 0 {name=p_Q lab=Q}
C {devices/lab_wire.sym} 730 320 0 0 {name=l3 lab=cki}
C {devices/lab_wire.sym} 730 420 0 0 {name=l4 lab=ncki}
C {devices/lab_wire.sym} 620 460 0 0 {name=l5 lab=net4}
C {devices/lab_wire.sym} 600 310 0 0 {name=l6 lab=net0}
L 3 -40 -40 260 -40 {}
L 3 -40 -40 -40 -28 {}
L 3 260 -40 260 -28 {}
T {clock inverters} -40 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 320 -40 550 -40 {}
L 3 320 -40 320 -28 {}
L 3 550 -40 550 -28 {}
T {master: clocked input + clocked feedback} 320 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 610 -90 840 -90 {}
L 3 610 -90 610 -78 {}
L 3 840 -90 840 -78 {}
T {master inverter, pass gate, slave feedback} 610 -111.893 0 0 0.3 0.3 {layer=3}
L 3 900 -40 1020 -40 {}
L 3 900 -40 900 -28 {}
L 3 1020 -40 1020 -28 {}
T {slave inverter} 900 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 1080 -40 1200 -40 {}
L 3 1080 -40 1080 -28 {}
L 3 1200 -40 1200 -28 {}
T {output} 1080 -61.8932 0 0 0.3 0.3 {layer=3}
T {F07  library flip-flop dffq_1 (DUT1, and the early observer): the paper's "regular library FF"} -180 -229.382 0 0 0.45 0.45 {}
T {Master: a clocked inverter takes D into net4; inverter net4 -> net0 and a clocked inverter back into net4 close the loop} -180 -186.543 0 0 0.24 0.24 {}
T {(this loop is what goes metastable). On the clock edge the pass gate tn9/tp7 hands net0 to the slave (net2 -> net3); Q = NOT net3.} -180 -167.218 0 0 0.24 0.24 {}
N -120 570 -20 570 {lab=CLK}
C {devices/lab_wire.sym} -20 570 0 0 {name=l7 lab=CLK}
N 0 570 100 570 {lab=cki}
C {devices/lab_wire.sym} 100 570 0 0 {name=l8 lab=cki}
T {clock} 130 560.843 0 0 0.24 0.24 {}
N -120 610 -20 610 {lab=ncki}
C {devices/lab_wire.sym} -20 610 0 0 {name=l9 lab=ncki}
T {inverted clock} 10 600.843 0 0 0.24 0.24 {}
N -120 650 -20 650 {lab=net4}
C {devices/lab_wire.sym} -20 650 0 0 {name=l10 lab=net4}
T {master loop node} 10 640.843 0 0 0.24 0.24 {}
N -120 690 -20 690 {lab=net0}
C {devices/lab_wire.sym} -20 690 0 0 {name=l11 lab=net0}
T {master loop node (complement)} 10 680.843 0 0 0.24 0.24 {}
T {Rails: VDD at the top, VSS at the bottom; every PMOS body is on VDD and every NMOS body on VSS (drawn inside the symbol). A dot marks a connection; wires that cross without a dot are not connected.} -120 724 0 0 0.2 0.2 {}
