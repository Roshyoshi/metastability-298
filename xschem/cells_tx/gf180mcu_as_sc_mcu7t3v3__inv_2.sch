v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {gf180mcu_as_sc_mcu7t3v3__inv_2: Y = NOT A   (4 transistors, gf180mcu_as_sc_mcu7t3v3 inv_2; nfet_03v3 / pfet_03v3, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 140 60 0 0 {name=M_M0 L=0.28u W=1.38u nf=1 m=1 ad=6.072e-13 as=3.588e-13 pd=3.64e-06 ps=1.9e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 140 470 0 0 {name=M_M1 L=0.28u W=1u nf=1 m=1 ad=2.6e-13 as=4.4e-13 pd=1.52e-06 ps=2.88e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 340 60 0 0 {name=M_M2 L=0.28u W=1.38u nf=1 m=1 ad=3.588e-13 as=6.072e-13 pd=1.9e-06 ps=3.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 340 470 0 0 {name=M_M3 L=0.28u W=1u nf=1 m=1 ad=4.4e-13 as=2.6e-13 pd=2.88e-06 ps=1.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s1 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s2 lab=VDD}
N 160 500 160 520 {lab=0}
C {devices/gnd.sym} 160 520 0 0 {name=s3 lab=0}
N 160 470 190 470 {lab=0}
C {devices/gnd.sym} 190 470 0 0 {name=s4 lab=0}
N 360 30 360 10 {lab=VDD}
C {devices/vdd.sym} 360 10 0 0 {name=s5 lab=VDD}
N 360 60 390 60 {lab=VDD}
C {devices/vdd.sym} 390 60 0 0 {name=s6 lab=VDD}
N 360 500 360 520 {lab=0}
C {devices/gnd.sym} 360 520 0 0 {name=s7 lab=0}
N 360 470 390 470 {lab=0}
C {devices/gnd.sym} 390 470 0 0 {name=s8 lab=0}
N 160 90 160 100 {lab=Y}
N 160 100 160 430 {lab=Y}
N 160 100 360 100 {lab=Y}
N 360 100 360 90 {lab=Y}
N 160 430 160 440 {lab=Y}
N 160 430 360 430 {lab=Y}
N 360 430 360 320 {lab=Y}
N 360 430 360 440 {lab=Y}
N 360 320 740 320 {lab=Y}
N 120 60 110 60 {lab=A}
N 110 60 110 320 {lab=A}
N 110 60 110 0 {lab=A}
N 110 0 200 0 {lab=A}
N 200 0 200 60 {lab=A}
N 200 60 320 60 {lab=A}
N 110 320 -60 320 {lab=A}
N 110 320 110 410 {lab=A}
N 110 410 110 470 {lab=A}
N 110 410 200 410 {lab=A}
N 110 470 120 470 {lab=A}
N 200 410 200 470 {lab=A}
N 200 470 320 470 {lab=A}
C {devices/ipin.sym} -60 320 0 0 {name=p9 lab=A}
C {devices/opin.sym} 740 320 0 0 {name=p10 lab=Y}
