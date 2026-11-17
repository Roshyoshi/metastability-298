v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 360 660 0 0 {name=MN5 model=nfet_05v0 W=0.365u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 360 560 0 0 {name=MN9 model=nfet_05v0 W=0.365u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 470 560 0 0 {name=MN10 model=nfet_05v0 W=0.365u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 470 660 0 0 {name=MN6 model=nfet_05v0 W=0.365u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 870 660 0 0 {name=MNout model=nfet_05v0 W=0.38u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 470 460 0 0 {name=MN12 model=nfet_05v0 W=0.365u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 690 460 0 0 {name=MN11 model=nfet_05v0 W=0.365u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 0 660 0 0 {name=MN2 model=nfet_05v0 W=0.365u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 580 660 0 0 {name=MN4 model=nfet_05v0 W=0.365u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 580 560 0 0 {name=MN8 model=nfet_05v0 W=0.365u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 690 560 0 0 {name=MN7 model=nfet_05v0 W=0.365u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 690 660 0 0 {name=MN3 model=nfet_05v0 W=0.365u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 180 660 0 0 {name=MN1 model=nfet_05v0 W=0.365u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 360 60 0 0 {name=MP2 model=pfet_05v0 W=0.565u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 360 160 0 0 {name=MP9 model=pfet_05v0 W=0.565u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 470 160 0 0 {name=MP10 model=pfet_05v0 W=0.565u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 470 60 0 0 {name=MP6 model=pfet_05v0 W=0.565u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 870 60 0 0 {name=MPout model=pfet_05v0 W=0.78u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 470 260 0 0 {name=MP12 model=pfet_05v0 W=0.565u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 690 260 0 0 {name=MP11 model=pfet_05v0 W=0.565u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 0 60 0 0 {name=MP5 model=pfet_05v0 W=0.565u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 580 60 0 0 {name=MP4 model=pfet_05v0 W=0.565u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 580 160 0 0 {name=MP8 model=pfet_05v0 W=0.565u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 690 160 0 0 {name=MP7 model=pfet_05v0 W=0.565u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 690 60 0 0 {name=MP3 model=pfet_05v0 W=0.565u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 180 60 0 0 {name=MP1 model=pfet_05v0 W=0.565u L=0.5u spiceprefix=X}
N -160 0 1090 0 {lab=VDD}
C {devices/lab_pin.sym} -160 0 0 0 {name=l1 lab=VDD}
N -160 720 1090 720 {lab=VSS}
C {devices/lab_pin.sym} -160 720 0 0 {name=l2 lab=VSS}
N 380 690 380 720 {lab=VSS}
N 490 690 490 720 {lab=VSS}
N 890 690 890 720 {lab=VSS}
N 20 690 20 720 {lab=VSS}
N 600 690 600 720 {lab=VSS}
N 710 690 710 720 {lab=VSS}
N 200 690 200 720 {lab=VSS}
N 380 30 380 0 {lab=VDD}
N 490 30 490 0 {lab=VDD}
N 890 30 890 0 {lab=VDD}
N 20 30 20 0 {lab=VDD}
N 600 30 600 0 {lab=VDD}
N 710 30 710 0 {lab=VDD}
N 200 30 200 0 {lab=VDD}
N 450 560 450 600 {lab=ui_in_3}
N 450 600 560 600 {lab=ui_in_3}
N 450 600 330 600 {lab=ui_in_3}
N 560 600 560 560 {lab=ui_in_3}
N 330 600 160 600 {lab=ui_in_3}
N 330 600 330 420 {lab=ui_in_3}
N 160 600 160 660 {lab=ui_in_3}
N 330 420 -120 420 {lab=ui_in_3}
N 330 420 330 200 {lab=ui_in_3}
N 330 200 670 200 {lab=ui_in_3}
N 330 200 330 160 {lab=ui_in_3}
N 330 160 340 160 {lab=ui_in_3}
N 330 160 160 160 {lab=ui_in_3}
N 670 200 670 160 {lab=ui_in_3}
N 160 160 160 60 {lab=ui_in_3}
N 340 560 200 560 {lab=sel1_n}
N 200 560 200 620 {lab=sel1_n}
N 200 620 430 620 {lab=sel1_n}
N 200 620 200 630 {lab=sel1_n}
N 430 620 430 160 {lab=sel1_n}
N 430 620 540 620 {lab=sel1_n}
N 540 620 670 620 {lab=sel1_n}
N 670 620 670 560 {lab=sel1_n}
N 430 160 430 120 {lab=sel1_n}
N 430 160 450 160 {lab=sel1_n}
N 430 120 560 120 {lab=sel1_n}
N 430 120 200 120 {lab=sel1_n}
N 200 120 200 90 {lab=sel1_n}
N 560 120 560 160 {lab=sel1_n}
N 850 660 850 430 {lab=int03}
N 850 430 710 430 {lab=int03}
N 850 430 850 60 {lab=int03}
N 710 430 490 430 {lab=int03}
N 710 430 710 290 {lab=int03}
N 490 430 490 290 {lab=int03}
N 380 530 490 530 {lab=int02}
N 380 530 380 230 {lab=int02}
N 490 530 490 490 {lab=int02}
N 380 230 380 190 {lab=int02}
N 380 230 490 230 {lab=int02}
N 490 230 490 190 {lab=int02}
N 710 490 710 530 {lab=int04}
N 710 530 660 530 {lab=int04}
N 660 530 600 530 {lab=int04}
N 660 530 660 230 {lab=int04}
N 660 230 710 230 {lab=int04}
N 660 230 600 230 {lab=int04}
N 710 230 710 190 {lab=int04}
N 600 230 600 190 {lab=int04}
N 450 460 -20 460 {lab=uio_in_6}
N 450 460 450 410 {lab=uio_in_6}
N 450 410 540 410 {lab=uio_in_6}
N 540 410 540 260 {lab=uio_in_6}
N 540 260 670 260 {lab=uio_in_6}
N -20 460 -120 460 {lab=uio_in_6}
N -20 460 -20 60 {lab=uio_in_6}
N -20 460 -20 660 {lab=uio_in_6}
N 670 460 640 460 {lab=sel2_n}
N 640 460 640 390 {lab=sel2_n}
N 640 390 450 390 {lab=sel2_n}
N 450 390 280 390 {lab=sel2_n}
N 280 390 20 390 {lab=sel2_n}
N 450 390 450 260 {lab=sel2_n}
N 20 390 20 630 {lab=sel2_n}
N 20 390 20 90 {lab=sel2_n}
N 380 630 380 590 {lab=int01}
N 380 590 310 590 {lab=int01}
N 310 590 310 130 {lab=int01}
N 310 130 380 130 {lab=int01}
N 380 130 380 90 {lab=int01}
N 490 590 490 630 {lab=int07}
N 490 590 540 590 {lab=int07}
N 540 590 540 550 {lab=int07}
N 540 550 560 550 {lab=int07}
N 560 550 560 240 {lab=int07}
N 560 240 540 240 {lab=int07}
N 540 240 540 130 {lab=int07}
N 540 130 490 130 {lab=int07}
N 490 130 490 90 {lab=int07}
N 600 630 600 600 {lab=int06}
N 600 600 600 590 {lab=int06}
N 600 600 760 600 {lab=int06}
N 760 600 760 120 {lab=int06}
N 760 120 600 120 {lab=int06}
N 600 120 600 130 {lab=int06}
N 600 120 600 90 {lab=int06}
N 710 590 710 620 {lab=int05}
N 710 620 780 620 {lab=int05}
N 710 620 710 630 {lab=int05}
N 780 620 780 130 {lab=int05}
N 780 130 710 130 {lab=int05}
N 710 130 710 90 {lab=int05}
N 670 660 640 660 {lab=q_0}
N 640 660 640 510 {lab=q_0}
N 640 510 620 510 {lab=q_0}
N 620 510 620 370 {lab=q_0}
N 620 370 640 370 {lab=q_0}
N 640 370 640 100 {lab=q_0}
N 640 100 -120 100 {lab=q_0}
N 640 100 640 60 {lab=q_0}
N 640 60 670 60 {lab=q_0}
N -120 100 -120 260 {lab=q_0}
N 560 660 550 660 {lab=q_1}
N 550 660 550 530 {lab=q_1}
N 550 530 580 530 {lab=q_1}
N 580 530 580 300 {lab=q_1}
N 580 300 -120 300 {lab=q_1}
N 580 300 580 220 {lab=q_1}
N 580 220 550 220 {lab=q_1}
N 550 220 550 60 {lab=q_1}
N 550 60 560 60 {lab=q_1}
N 450 660 420 660 {lab=q_3}
N 420 660 420 520 {lab=q_3}
N 420 520 410 520 {lab=q_3}
N 410 520 410 370 {lab=q_3}
N 410 370 -120 370 {lab=q_3}
N 410 370 410 190 {lab=q_3}
N 410 190 420 190 {lab=q_3}
N 420 190 420 60 {lab=q_3}
N 420 60 450 60 {lab=q_3}
N -120 370 -120 380 {lab=q_3}
N 340 660 290 660 {lab=q_2}
N 290 660 290 340 {lab=q_2}
N 290 340 -120 340 {lab=q_2}
N 290 340 290 60 {lab=q_2}
N 290 60 340 60 {lab=q_2}
N 890 630 1050 630 {lab=selected_q}
N 1050 630 1050 360 {lab=selected_q}
N 1050 360 890 360 {lab=selected_q}
N 890 360 890 90 {lab=selected_q}
C {devices/ipin.sym} -120 260 0 0 {name=p_q_0 lab=q_0}
C {devices/ipin.sym} -120 300 0 0 {name=p_q_1 lab=q_1}
C {devices/ipin.sym} -120 340 0 0 {name=p_q_2 lab=q_2}
C {devices/ipin.sym} -120 380 0 0 {name=p_q_3 lab=q_3}
C {devices/ipin.sym} -120 420 0 0 {name=p_ui_in_3 lab=ui_in_3}
C {devices/ipin.sym} -120 460 0 0 {name=p_uio_in_6 lab=uio_in_6}
C {devices/opin.sym} 1050 360 0 0 {name=p_selected_q lab=selected_q}
C {devices/lab_wire.sym} 540 620 0 0 {name=l3 lab=sel1_n}
C {devices/lab_wire.sym} 280 390 0 0 {name=l4 lab=sel2_n}
L 3 -40 -40 260 -40 {}
L 3 -40 -40 -40 -28 {}
L 3 260 -40 260 -28 {}
T {select inverters} -40 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 320 -40 770 -40 {}
L 3 320 -40 320 -28 {}
L 3 770 -40 770 -28 {}
T {S0 level: clocked inverters; S1 level: transmission gates} 320 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 830 -90 950 -90 {}
L 3 830 -90 830 -78 {}
L 3 950 -90 950 -78 {}
T {output inverter} 830 -111.893 0 0 0.3 0.3 {layer=3}
T {F10  selector mux4_1: passes one of the four flip-flop outputs q[0..3] to selected_q} -180 -229.382 0 0 0.45 0.45 {}
T {ui_in[3] (S0) picks one input of each pair with clocked inverters; uio_in[6] (S1) picks the pair with two transmission gates} -180 -186.543 0 0 0.24 0.24 {}
T {(the floating transistors in the middle); the output inverter drives selected_q.} -180 -167.218 0 0 0.24 0.24 {}
N -120 770 -20 770 {lab=ui_in_3}
C {devices/lab_wire.sym} -20 770 0 0 {name=l5 lab=ui_in_3}
N 0 770 100 770 {lab=sel1_n}
C {devices/lab_wire.sym} 100 770 0 0 {name=l6 lab=sel1_n}
T {S0 and its inverse} 130 760.843 0 0 0.24 0.24 {}
N -120 810 -20 810 {lab=uio_in_6}
C {devices/lab_wire.sym} -20 810 0 0 {name=l7 lab=uio_in_6}
N 0 810 100 810 {lab=sel2_n}
C {devices/lab_wire.sym} 100 810 0 0 {name=l8 lab=sel2_n}
T {S1 and its inverse} 130 800.843 0 0 0.24 0.24 {}
T {Rails: VDD at the top, VSS at the bottom; every PMOS body is on VDD and every NMOS body on VSS (drawn inside the symbol). A dot marks a connection; wires that cross without a dot are not connected.} -120 844 0 0 0.2 0.2 {}
