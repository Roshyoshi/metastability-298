v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {nor2_1: ZN = NOT (A1 OR A2)   (4 transistors, gf180mcu_fd_sc_mcu7t5v0 nor2_1; nfet_05v0 / pfet_05v0, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 620 0 0 {name=M_i_1 L=0.6u W=0.565u nf=1 m=1 ad=2.825e-13 as=2.825e-13 pd=2.13e-06 ps=2.13e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 340 620 0 0 {name=M_i_0 L=0.6u W=0.565u nf=1 m=1 ad=2.825e-13 as=2.825e-13 pd=2.13e-06 ps=2.13e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=M_i_3 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 210 0 0 {name=M_i_2 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
N 160 650 160 670 {lab=0}
C {devices/gnd.sym} 160 670 0 0 {name=s1 lab=0}
N 160 620 190 620 {lab=0}
C {devices/gnd.sym} 190 620 0 0 {name=s2 lab=0}
N 360 650 360 670 {lab=0}
C {devices/gnd.sym} 360 670 0 0 {name=s3 lab=0}
N 360 620 390 620 {lab=0}
C {devices/gnd.sym} 390 620 0 0 {name=s4 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s5 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s6 lab=VDD}
N 160 210 190 210 {lab=VDD}
C {devices/vdd.sym} 190 210 0 0 {name=s7 lab=VDD}
N 160 590 160 580 {lab=ZN}
N 160 580 360 580 {lab=ZN}
N 160 580 160 400 {lab=ZN}
N 360 580 360 590 {lab=ZN}
N 160 400 740 400 {lab=ZN}
N 160 400 160 240 {lab=ZN}
N 320 620 310 620 {lab=A1}
N 310 620 310 560 {lab=A1}
N 310 560 110 560 {lab=A1}
N 110 560 110 380 {lab=A1}
N 110 380 -60 380 {lab=A1}
N 110 380 110 210 {lab=A1}
N 110 210 120 210 {lab=A1}
N 120 620 -60 620 {lab=A2}
N -60 620 -60 420 {lab=A2}
N -60 420 -70 420 {lab=A2}
N -70 420 -70 60 {lab=A2}
N -70 60 120 60 {lab=A2}
N 160 90 160 180 {lab=net_0}
C {devices/ipin.sym} -60 380 0 0 {name=p8 lab=A1}
C {devices/ipin.sym} -60 420 0 0 {name=p9 lab=A2}
C {devices/opin.sym} 740 400 0 0 {name=p10 lab=ZN}
