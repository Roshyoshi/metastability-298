v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {oai21_1: ZN = NOT ((A1 OR A2) AND B)   (6 transistors, gf180mcu_fd_sc_mcu7t5v0 oai21_1; nfet_05v0 / pfet_05v0, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 620 0 0 {name=M_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 340 620 0 0 {name=M_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 770 0 0 {name=M_i_2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=M_i_4 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 210 0 0 {name=M_i_3 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 340 60 0 0 {name=M_i_5 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
N 160 620 190 620 {lab=0}
C {devices/gnd.sym} 190 620 0 0 {name=s1 lab=0}
N 360 620 390 620 {lab=0}
C {devices/gnd.sym} 390 620 0 0 {name=s2 lab=0}
N 160 800 160 820 {lab=0}
C {devices/gnd.sym} 160 820 0 0 {name=s3 lab=0}
N 160 770 190 770 {lab=0}
C {devices/gnd.sym} 190 770 0 0 {name=s4 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s5 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s6 lab=VDD}
N 160 210 190 210 {lab=VDD}
C {devices/vdd.sym} 190 210 0 0 {name=s7 lab=VDD}
N 360 30 360 10 {lab=VDD}
C {devices/vdd.sym} 360 10 0 0 {name=s8 lab=VDD}
N 360 60 390 60 {lab=VDD}
C {devices/vdd.sym} 390 60 0 0 {name=s9 lab=VDD}
N 160 590 160 580 {lab=ZN}
N 160 580 360 580 {lab=ZN}
N 160 580 160 240 {lab=ZN}
N 360 580 360 470 {lab=ZN}
N 360 580 360 590 {lab=ZN}
N 160 240 360 240 {lab=ZN}
N 360 240 360 90 {lab=ZN}
N 360 470 740 470 {lab=ZN}
N 320 620 310 620 {lab=A1}
N 310 620 310 430 {lab=A1}
N 310 430 110 430 {lab=A1}
N 110 430 -60 430 {lab=A1}
N 110 430 110 210 {lab=A1}
N 110 210 120 210 {lab=A1}
N 120 770 -60 770 {lab=B}
N -60 770 -60 510 {lab=B}
N -60 510 200 510 {lab=B}
N 200 510 200 60 {lab=B}
N 200 60 320 60 {lab=B}
N 160 650 160 660 {lab=net_0}
N 160 660 160 740 {lab=net_0}
N 160 660 360 660 {lab=net_0}
N 360 660 360 650 {lab=net_0}
N 120 620 110 620 {lab=A2}
N 110 620 110 470 {lab=A2}
N 110 470 90 470 {lab=A2}
N 90 470 -60 470 {lab=A2}
N 90 470 90 60 {lab=A2}
N 90 60 120 60 {lab=A2}
N 160 90 160 180 {lab=net_1}
C {devices/ipin.sym} -60 430 0 0 {name=p10 lab=A1}
C {devices/ipin.sym} -60 470 0 0 {name=p11 lab=A2}
C {devices/ipin.sym} -60 510 0 0 {name=p12 lab=B}
C {devices/opin.sym} 740 470 0 0 {name=p13 lab=ZN}
