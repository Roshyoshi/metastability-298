v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {xnor2_1: ZN = NOT (A1 XOR A2)   (10 transistors, gf180mcu_fd_sc_mcu7t5v0 xnor2_1; nfet_05v0 / pfet_05v0, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 620 0 0 {name=M_i_6 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 770 0 0 {name=M_i_7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 700 770 0 0 {name=M_i_2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 700 620 0 0 {name=M_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 900 620 0 0 {name=M_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=M_i_8 L=0.5u W=0.56u nf=1 m=1 ad=2.8e-13 as=2.8e-13 pd=2.12e-06 ps=2.12e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 340 60 0 0 {name=M_i_9 L=0.5u W=0.56u nf=1 m=1 ad=2.8e-13 as=2.8e-13 pd=2.12e-06 ps=2.12e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 700 60 0 0 {name=M_i_5 L=0.5u W=1.095u nf=1 m=1 ad=5.475e-13 as=5.475e-13 pd=3.19e-06 ps=3.19e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 700 210 0 0 {name=M_i_3 L=0.5u W=1.095u nf=1 m=1 ad=5.475e-13 as=5.475e-13 pd=3.19e-06 ps=3.19e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 900 60 0 0 {name=M_i_4 L=0.5u W=1.095u nf=1 m=1 ad=5.475e-13 as=5.475e-13 pd=3.19e-06 ps=3.19e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
N 160 620 190 620 {lab=0}
C {devices/gnd.sym} 190 620 0 0 {name=s1 lab=0}
N 160 800 160 820 {lab=0}
C {devices/gnd.sym} 160 820 0 0 {name=s2 lab=0}
N 160 770 190 770 {lab=0}
C {devices/gnd.sym} 190 770 0 0 {name=s3 lab=0}
N 720 800 720 820 {lab=0}
C {devices/gnd.sym} 720 820 0 0 {name=s4 lab=0}
N 720 770 750 770 {lab=0}
C {devices/gnd.sym} 750 770 0 0 {name=s5 lab=0}
N 720 620 750 620 {lab=0}
C {devices/gnd.sym} 750 620 0 0 {name=s6 lab=0}
N 920 620 950 620 {lab=0}
C {devices/gnd.sym} 950 620 0 0 {name=s7 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s8 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s9 lab=VDD}
N 360 30 360 10 {lab=VDD}
C {devices/vdd.sym} 360 10 0 0 {name=s10 lab=VDD}
N 360 60 390 60 {lab=VDD}
C {devices/vdd.sym} 390 60 0 0 {name=s11 lab=VDD}
N 720 30 720 10 {lab=VDD}
C {devices/vdd.sym} 720 10 0 0 {name=s12 lab=VDD}
N 720 60 750 60 {lab=VDD}
C {devices/vdd.sym} 750 60 0 0 {name=s13 lab=VDD}
N 720 210 750 210 {lab=VDD}
C {devices/vdd.sym} 750 210 0 0 {name=s14 lab=VDD}
N 920 30 920 10 {lab=VDD}
C {devices/vdd.sym} 920 10 0 0 {name=s15 lab=VDD}
N 920 60 950 60 {lab=VDD}
C {devices/vdd.sym} 950 60 0 0 {name=s16 lab=VDD}
N 120 620 110 620 {lab=A2}
N 110 620 -60 620 {lab=A2}
N 110 620 110 580 {lab=A2}
N -60 620 -60 490 {lab=A2}
N 110 580 760 580 {lab=A2}
N 110 580 110 60 {lab=A2}
N 110 60 120 60 {lab=A2}
N 760 580 760 620 {lab=A2}
N 760 620 870 620 {lab=A2}
N 870 620 880 620 {lab=A2}
N 870 620 870 60 {lab=A2}
N 870 60 880 60 {lab=A2}
N 120 770 90 770 {lab=A1}
N 90 770 90 660 {lab=A1}
N 90 660 200 660 {lab=A1}
N 90 660 90 450 {lab=A1}
N 90 450 -60 450 {lab=A1}
N 200 660 200 620 {lab=A1}
N 200 620 310 620 {lab=A1}
N 310 620 680 620 {lab=A1}
N 310 620 310 210 {lab=A1}
N 310 210 680 210 {lab=A1}
N 310 210 310 60 {lab=A1}
N 310 60 320 60 {lab=A1}
N 720 590 720 560 {lab=ZN}
N 720 560 760 560 {lab=ZN}
N 760 560 920 560 {lab=ZN}
N 760 560 760 180 {lab=ZN}
N 920 560 920 470 {lab=ZN}
N 920 560 920 590 {lab=ZN}
N 760 180 720 180 {lab=ZN}
N 720 180 720 90 {lab=ZN}
N 920 470 1300 470 {lab=ZN}
N 160 590 160 560 {lab=I}
N 160 560 220 560 {lab=I}
N 160 560 160 100 {lab=I}
N 160 100 160 90 {lab=I}
N 160 100 360 100 {lab=I}
N 220 560 220 770 {lab=I}
N 220 770 680 770 {lab=I}
N 360 100 360 90 {lab=I}
N 360 90 400 90 {lab=I}
N 400 90 400 60 {lab=I}
N 400 60 680 60 {lab=I}
N 720 740 720 660 {lab=net_0}
N 720 660 720 650 {lab=net_0}
N 720 660 920 660 {lab=net_0}
N 920 660 920 650 {lab=net_0}
N 720 240 920 240 {lab=net_1}
N 920 240 920 90 {lab=net_1}
N 160 650 160 740 {lab=net_2}
C {devices/ipin.sym} -60 450 0 0 {name=p17 lab=A1}
C {devices/ipin.sym} -60 490 0 0 {name=p18 lab=A2}
C {devices/opin.sym} 1300 470 0 0 {name=p19 lab=ZN}
