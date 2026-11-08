v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {oai22_1: ZN = NOT ((A1 OR A2) AND (B1 OR B2))   (8 transistors, gf180mcu_fd_sc_mcu7t5v0 oai22_1; nfet_05v0 / pfet_05v0, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 770 0 0 {name=M_i_3 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 340 770 0 0 {name=M_i_2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 340 620 0 0 {name=M_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 620 0 0 {name=M_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=M_i_7 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 210 0 0 {name=M_i_6 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 340 210 0 0 {name=M_i_4 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 340 60 0 0 {name=M_i_5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
N 160 800 160 820 {lab=0}
C {devices/gnd.sym} 160 820 0 0 {name=s1 lab=0}
N 160 770 190 770 {lab=0}
C {devices/gnd.sym} 190 770 0 0 {name=s2 lab=0}
N 360 800 360 820 {lab=0}
C {devices/gnd.sym} 360 820 0 0 {name=s3 lab=0}
N 360 770 390 770 {lab=0}
C {devices/gnd.sym} 390 770 0 0 {name=s4 lab=0}
N 360 620 390 620 {lab=0}
C {devices/gnd.sym} 390 620 0 0 {name=s5 lab=0}
N 160 620 190 620 {lab=0}
C {devices/gnd.sym} 190 620 0 0 {name=s6 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s7 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s8 lab=VDD}
N 160 210 190 210 {lab=VDD}
C {devices/vdd.sym} 190 210 0 0 {name=s9 lab=VDD}
N 360 210 390 210 {lab=VDD}
C {devices/vdd.sym} 390 210 0 0 {name=s10 lab=VDD}
N 360 30 360 10 {lab=VDD}
C {devices/vdd.sym} 360 10 0 0 {name=s11 lab=VDD}
N 360 60 390 60 {lab=VDD}
C {devices/vdd.sym} 390 60 0 0 {name=s12 lab=VDD}
N 360 590 360 580 {lab=ZN}
N 360 580 360 470 {lab=ZN}
N 360 580 160 580 {lab=ZN}
N 160 580 160 590 {lab=ZN}
N 360 470 360 250 {lab=ZN}
N 360 470 740 470 {lab=ZN}
N 360 250 160 250 {lab=ZN}
N 360 250 360 240 {lab=ZN}
N 160 250 160 240 {lab=ZN}
N 160 740 160 730 {lab=net_0}
N 160 730 360 730 {lab=net_0}
N 160 730 160 650 {lab=net_0}
N 360 730 360 740 {lab=net_0}
N 360 730 360 650 {lab=net_0}
N 320 770 310 770 {lab=B1}
N 310 770 310 490 {lab=B1}
N 310 490 110 490 {lab=B1}
N 110 490 -60 490 {lab=B1}
N 110 490 110 210 {lab=B1}
N 110 210 120 210 {lab=B1}
N 320 620 290 620 {lab=A1}
N 290 620 290 410 {lab=A1}
N 290 410 -60 410 {lab=A1}
N 290 410 290 210 {lab=A1}
N 290 210 320 210 {lab=A1}
N 120 620 -70 620 {lab=A2}
N -70 620 -70 450 {lab=A2}
N -70 450 -70 170 {lab=A2}
N -70 450 -60 450 {lab=A2}
N -70 170 200 170 {lab=A2}
N 200 170 200 60 {lab=A2}
N 200 60 320 60 {lab=A2}
N 120 770 110 770 {lab=B2}
N 110 770 110 530 {lab=B2}
N 110 530 90 530 {lab=B2}
N 90 530 -60 530 {lab=B2}
N 90 530 90 60 {lab=B2}
N 90 60 120 60 {lab=B2}
N 160 90 160 180 {lab=net_2}
N 360 180 360 90 {lab=net_1}
C {devices/ipin.sym} -60 410 0 0 {name=p13 lab=A1}
C {devices/ipin.sym} -60 450 0 0 {name=p14 lab=A2}
C {devices/ipin.sym} -60 490 0 0 {name=p15 lab=B1}
C {devices/ipin.sym} -60 530 0 0 {name=p16 lab=B2}
C {devices/opin.sym} 740 470 0 0 {name=p17 lab=ZN}
