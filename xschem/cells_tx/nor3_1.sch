v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {nor3_1: ZN = NOT (A1 OR A2 OR A3)   (6 transistors, gf180mcu_fd_sc_mcu7t5v0 nor3_1; nfet_05v0 / pfet_05v0, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 770 0 0 {name=M_i_2 L=0.6u W=0.465u nf=1 m=1 ad=2.325e-13 as=2.325e-13 pd=1.93e-06 ps=1.93e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 340 770 0 0 {name=M_i_1 L=0.6u W=0.465u nf=1 m=1 ad=2.325e-13 as=2.325e-13 pd=1.93e-06 ps=1.93e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 540 770 0 0 {name=M_i_0 L=0.6u W=0.465u nf=1 m=1 ad=2.325e-13 as=2.325e-13 pd=1.93e-06 ps=1.93e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=M_i_5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 210 0 0 {name=M_i_4 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 360 0 0 {name=M_i_3 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
N 160 800 160 820 {lab=0}
C {devices/gnd.sym} 160 820 0 0 {name=s1 lab=0}
N 160 770 190 770 {lab=0}
C {devices/gnd.sym} 190 770 0 0 {name=s2 lab=0}
N 360 800 360 820 {lab=0}
C {devices/gnd.sym} 360 820 0 0 {name=s3 lab=0}
N 360 770 390 770 {lab=0}
C {devices/gnd.sym} 390 770 0 0 {name=s4 lab=0}
N 560 800 560 820 {lab=0}
C {devices/gnd.sym} 560 820 0 0 {name=s5 lab=0}
N 560 770 590 770 {lab=0}
C {devices/gnd.sym} 590 770 0 0 {name=s6 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s7 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s8 lab=VDD}
N 160 210 190 210 {lab=VDD}
C {devices/vdd.sym} 190 210 0 0 {name=s9 lab=VDD}
N 160 360 190 360 {lab=VDD}
C {devices/vdd.sym} 190 360 0 0 {name=s10 lab=VDD}
N 160 740 160 730 {lab=ZN}
N 160 730 360 730 {lab=ZN}
N 160 730 160 390 {lab=ZN}
N 360 730 360 740 {lab=ZN}
N 360 730 560 730 {lab=ZN}
N 560 730 560 470 {lab=ZN}
N 560 730 560 740 {lab=ZN}
N 560 470 940 470 {lab=ZN}
N 520 770 510 770 {lab=A1}
N 510 770 510 710 {lab=A1}
N 510 710 110 710 {lab=A1}
N 110 710 110 430 {lab=A1}
N 110 430 -60 430 {lab=A1}
N 110 430 110 360 {lab=A1}
N 110 360 120 360 {lab=A1}
N 320 770 310 770 {lab=A2}
N 310 770 310 470 {lab=A2}
N 310 470 90 470 {lab=A2}
N 90 470 -60 470 {lab=A2}
N 90 470 90 210 {lab=A2}
N 90 210 120 210 {lab=A2}
N 120 770 -60 770 {lab=A3}
N -60 770 -60 510 {lab=A3}
N -60 510 -70 510 {lab=A3}
N -70 510 -70 60 {lab=A3}
N -70 60 120 60 {lab=A3}
N 160 90 160 180 {lab=net_1}
N 160 240 160 330 {lab=net_0}
C {devices/ipin.sym} -60 430 0 0 {name=p11 lab=A1}
C {devices/ipin.sym} -60 470 0 0 {name=p12 lab=A2}
C {devices/ipin.sym} -60 510 0 0 {name=p13 lab=A3}
C {devices/opin.sym} 940 470 0 0 {name=p14 lab=ZN}
