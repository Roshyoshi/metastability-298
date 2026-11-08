v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {xor2_1: Z = A1 XOR A2   (10 transistors, gf180mcu_fd_sc_mcu7t5v0 xor2_1; nfet_05v0 / pfet_05v0, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 770 0 0 {name=M_i_6 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 340 770 0 0 {name=M_i_7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 700 770 0 0 {name=M_i_2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 700 620 0 0 {name=M_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 900 770 0 0 {name=M_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 210 0 0 {name=M_i_8 L=0.5u W=0.56u nf=1 m=1 ad=2.8e-13 as=2.8e-13 pd=2.12e-06 ps=2.12e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=M_i_9 L=0.5u W=0.56u nf=1 m=1 ad=2.8e-13 as=2.8e-13 pd=2.12e-06 ps=2.12e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 700 60 0 0 {name=M_i_5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 700 210 0 0 {name=M_i_3 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 900 210 0 0 {name=M_i_4 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
N 160 800 160 820 {lab=0}
C {devices/gnd.sym} 160 820 0 0 {name=s1 lab=0}
N 160 770 190 770 {lab=0}
C {devices/gnd.sym} 190 770 0 0 {name=s2 lab=0}
N 360 800 360 820 {lab=0}
C {devices/gnd.sym} 360 820 0 0 {name=s3 lab=0}
N 360 770 390 770 {lab=0}
C {devices/gnd.sym} 390 770 0 0 {name=s4 lab=0}
N 720 800 720 820 {lab=0}
C {devices/gnd.sym} 720 820 0 0 {name=s5 lab=0}
N 720 770 750 770 {lab=0}
C {devices/gnd.sym} 750 770 0 0 {name=s6 lab=0}
N 720 620 750 620 {lab=0}
C {devices/gnd.sym} 750 620 0 0 {name=s7 lab=0}
N 920 800 920 820 {lab=0}
C {devices/gnd.sym} 920 820 0 0 {name=s8 lab=0}
N 920 770 950 770 {lab=0}
C {devices/gnd.sym} 950 770 0 0 {name=s9 lab=0}
N 160 210 190 210 {lab=VDD}
C {devices/vdd.sym} 190 210 0 0 {name=s10 lab=VDD}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s11 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s12 lab=VDD}
N 720 30 720 10 {lab=VDD}
C {devices/vdd.sym} 720 10 0 0 {name=s13 lab=VDD}
N 720 60 750 60 {lab=VDD}
C {devices/vdd.sym} 750 60 0 0 {name=s14 lab=VDD}
N 720 210 750 210 {lab=VDD}
C {devices/vdd.sym} 750 210 0 0 {name=s15 lab=VDD}
N 920 210 950 210 {lab=VDD}
C {devices/vdd.sym} 950 210 0 0 {name=s16 lab=VDD}
N 120 770 110 770 {lab=A2}
N 110 770 -60 770 {lab=A2}
N 110 770 110 730 {lab=A2}
N -60 770 -60 490 {lab=A2}
N -60 490 -50 490 {lab=A2}
N -50 490 -50 210 {lab=A2}
N -50 210 120 210 {lab=A2}
N 110 730 760 730 {lab=A2}
N 760 730 760 770 {lab=A2}
N 760 770 870 770 {lab=A2}
N 870 770 880 770 {lab=A2}
N 870 770 870 210 {lab=A2}
N 870 210 880 210 {lab=A2}
N 320 770 310 770 {lab=A1}
N 310 770 310 620 {lab=A1}
N 310 620 670 620 {lab=A1}
N 310 620 310 450 {lab=A1}
N 670 620 680 620 {lab=A1}
N 670 620 670 210 {lab=A1}
N 310 450 110 450 {lab=A1}
N 110 450 -60 450 {lab=A1}
N 110 450 110 60 {lab=A1}
N 110 60 120 60 {lab=A1}
N 670 210 680 210 {lab=A1}
N 720 740 720 650 {lab=Z}
N 720 650 760 650 {lab=Z}
N 760 650 760 470 {lab=Z}
N 760 470 760 250 {lab=Z}
N 760 470 1300 470 {lab=Z}
N 760 250 760 240 {lab=Z}
N 760 250 920 250 {lab=Z}
N 760 240 720 240 {lab=Z}
N 920 250 920 240 {lab=Z}
N 160 740 160 710 {lab=I}
N 160 710 160 240 {lab=I}
N 160 710 360 710 {lab=I}
N 360 710 400 710 {lab=I}
N 360 710 360 740 {lab=I}
N 160 240 200 240 {lab=I}
N 400 710 400 770 {lab=I}
N 400 770 680 770 {lab=I}
N 200 240 200 60 {lab=I}
N 200 60 680 60 {lab=I}
N 720 90 720 170 {lab=net_1}
N 720 170 920 170 {lab=net_1}
N 720 170 720 180 {lab=net_1}
N 920 170 920 180 {lab=net_1}
N 720 590 920 590 {lab=net_0}
N 920 590 920 740 {lab=net_0}
N 160 180 160 90 {lab=net_2}
C {devices/ipin.sym} -60 450 0 0 {name=p17 lab=A1}
C {devices/ipin.sym} -60 490 0 0 {name=p18 lab=A2}
C {devices/opin.sym} 1300 470 0 0 {name=p19 lab=Z}
