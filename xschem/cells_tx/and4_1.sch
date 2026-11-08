v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {and4_1: Z = A1 AND A2 AND A3 AND A4   (10 transistors, gf180mcu_fd_sc_mcu7t5v0 and4_1; nfet_05v0 / pfet_05v0, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 470 0 0 {name=M_i_2 L=0.6u W=0.42u nf=1 m=1 ad=2.1e-13 as=2.1e-13 pd=1.84e-06 ps=1.84e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 620 0 0 {name=M_i_3 L=0.6u W=0.42u nf=1 m=1 ad=2.1e-13 as=2.1e-13 pd=1.84e-06 ps=1.84e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 770 0 0 {name=M_i_4 L=0.6u W=0.42u nf=1 m=1 ad=2.1e-13 as=2.1e-13 pd=1.84e-06 ps=1.84e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 920 0 0 {name=M_i_5 L=0.6u W=0.42u nf=1 m=1 ad=2.1e-13 as=2.1e-13 pd=1.84e-06 ps=1.84e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1100 920 0 0 {name=M_i_0 L=0.6u W=0.815u nf=1 m=1 ad=4.075e-13 as=4.075e-13 pd=2.63e-06 ps=2.63e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=M_i_6 L=0.5u W=0.6u nf=1 m=1 ad=3e-13 as=3e-13 pd=2.2e-06 ps=2.2e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 340 60 0 0 {name=M_i_7 L=0.5u W=0.6u nf=1 m=1 ad=3e-13 as=3e-13 pd=2.2e-06 ps=2.2e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 540 60 0 0 {name=M_i_8 L=0.5u W=0.6u nf=1 m=1 ad=3e-13 as=3e-13 pd=2.2e-06 ps=2.2e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 740 60 0 0 {name=M_i_9 L=0.5u W=0.6u nf=1 m=1 ad=3e-13 as=3e-13 pd=2.2e-06 ps=2.2e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1100 60 0 0 {name=M_i_1 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
N 160 470 190 470 {lab=0}
C {devices/gnd.sym} 190 470 0 0 {name=s1 lab=0}
N 160 620 190 620 {lab=0}
C {devices/gnd.sym} 190 620 0 0 {name=s2 lab=0}
N 160 770 190 770 {lab=0}
C {devices/gnd.sym} 190 770 0 0 {name=s3 lab=0}
N 160 950 160 970 {lab=0}
C {devices/gnd.sym} 160 970 0 0 {name=s4 lab=0}
N 160 920 190 920 {lab=0}
C {devices/gnd.sym} 190 920 0 0 {name=s5 lab=0}
N 1120 950 1120 970 {lab=0}
C {devices/gnd.sym} 1120 970 0 0 {name=s6 lab=0}
N 1120 920 1150 920 {lab=0}
C {devices/gnd.sym} 1150 920 0 0 {name=s7 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s8 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s9 lab=VDD}
N 360 30 360 10 {lab=VDD}
C {devices/vdd.sym} 360 10 0 0 {name=s10 lab=VDD}
N 360 60 390 60 {lab=VDD}
C {devices/vdd.sym} 390 60 0 0 {name=s11 lab=VDD}
N 560 30 560 10 {lab=VDD}
C {devices/vdd.sym} 560 10 0 0 {name=s12 lab=VDD}
N 560 60 590 60 {lab=VDD}
C {devices/vdd.sym} 590 60 0 0 {name=s13 lab=VDD}
N 760 30 760 10 {lab=VDD}
C {devices/vdd.sym} 760 10 0 0 {name=s14 lab=VDD}
N 760 60 790 60 {lab=VDD}
C {devices/vdd.sym} 790 60 0 0 {name=s15 lab=VDD}
N 1120 30 1120 10 {lab=VDD}
C {devices/vdd.sym} 1120 10 0 0 {name=s16 lab=VDD}
N 1120 60 1150 60 {lab=VDD}
C {devices/vdd.sym} 1150 60 0 0 {name=s17 lab=VDD}
N 160 440 160 100 {lab=Z_neg}
N 160 100 160 90 {lab=Z_neg}
N 160 100 360 100 {lab=Z_neg}
N 360 100 560 100 {lab=Z_neg}
N 360 100 360 90 {lab=Z_neg}
N 560 100 760 100 {lab=Z_neg}
N 560 100 560 90 {lab=Z_neg}
N 760 100 760 90 {lab=Z_neg}
N 760 90 800 90 {lab=Z_neg}
N 800 90 800 60 {lab=Z_neg}
N 800 60 1070 60 {lab=Z_neg}
N 1070 60 1070 920 {lab=Z_neg}
N 1070 60 1080 60 {lab=Z_neg}
N 1070 920 1080 920 {lab=Z_neg}
N 120 920 -60 920 {lab=A4}
N -60 920 -60 660 {lab=A4}
N -60 660 -60 610 {lab=A4}
N -60 660 600 660 {lab=A4}
N 600 660 600 60 {lab=A4}
N 600 60 720 60 {lab=A4}
N 120 770 110 770 {lab=A3}
N 110 770 110 570 {lab=A3}
N 110 570 400 570 {lab=A3}
N 110 570 -60 570 {lab=A3}
N 400 570 400 60 {lab=A3}
N 400 60 520 60 {lab=A3}
N 120 620 90 620 {lab=A2}
N 90 620 90 530 {lab=A2}
N 90 530 -60 530 {lab=A2}
N 90 530 200 530 {lab=A2}
N 200 530 200 60 {lab=A2}
N 200 60 320 60 {lab=A2}
N 1120 890 1120 550 {lab=Z}
N 1120 550 1500 550 {lab=Z}
N 1120 550 1120 90 {lab=Z}
N 120 470 110 470 {lab=A1}
N 110 470 110 60 {lab=A1}
N 110 470 -60 470 {lab=A1}
N -60 470 -60 490 {lab=A1}
N 110 60 120 60 {lab=A1}
N 160 500 160 590 {lab=net_0}
N 160 650 160 740 {lab=net_1}
N 160 800 160 890 {lab=net_2}
C {devices/ipin.sym} -60 490 0 0 {name=p18 lab=A1}
C {devices/ipin.sym} -60 530 0 0 {name=p19 lab=A2}
C {devices/ipin.sym} -60 570 0 0 {name=p20 lab=A3}
C {devices/ipin.sym} -60 610 0 0 {name=p21 lab=A4}
C {devices/opin.sym} 1500 550 0 0 {name=p22 lab=Z}
