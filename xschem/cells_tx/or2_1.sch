v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {or2_1: Z = A1 OR A2   (6 transistors, gf180mcu_fd_sc_mcu7t5v0 or2_1; nfet_05v0 / pfet_05v0, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 620 0 0 {name=M_i_2 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 340 620 0 0 {name=M_i_3 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 700 620 0 0 {name=M_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 210 0 0 {name=M_i_4 L=0.5u W=0.565u nf=1 m=1 ad=2.825e-13 as=2.825e-13 pd=2.13e-06 ps=2.13e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=M_i_5 L=0.5u W=0.565u nf=1 m=1 ad=2.825e-13 as=2.825e-13 pd=2.13e-06 ps=2.13e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 700 60 0 0 {name=M_i_1 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
N 160 650 160 670 {lab=0}
C {devices/gnd.sym} 160 670 0 0 {name=s1 lab=0}
N 160 620 190 620 {lab=0}
C {devices/gnd.sym} 190 620 0 0 {name=s2 lab=0}
N 360 650 360 670 {lab=0}
C {devices/gnd.sym} 360 670 0 0 {name=s3 lab=0}
N 360 620 390 620 {lab=0}
C {devices/gnd.sym} 390 620 0 0 {name=s4 lab=0}
N 720 650 720 670 {lab=0}
C {devices/gnd.sym} 720 670 0 0 {name=s5 lab=0}
N 720 620 750 620 {lab=0}
C {devices/gnd.sym} 750 620 0 0 {name=s6 lab=0}
N 160 210 190 210 {lab=VDD}
C {devices/vdd.sym} 190 210 0 0 {name=s7 lab=VDD}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s8 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s9 lab=VDD}
N 720 30 720 10 {lab=VDD}
C {devices/vdd.sym} 720 10 0 0 {name=s10 lab=VDD}
N 720 60 750 60 {lab=VDD}
C {devices/vdd.sym} 750 60 0 0 {name=s11 lab=VDD}
N 160 590 160 580 {lab=Z_neg}
N 160 580 360 580 {lab=Z_neg}
N 160 580 160 240 {lab=Z_neg}
N 360 580 360 590 {lab=Z_neg}
N 360 590 400 590 {lab=Z_neg}
N 400 590 400 620 {lab=Z_neg}
N 400 620 670 620 {lab=Z_neg}
N 670 620 680 620 {lab=Z_neg}
N 670 620 670 60 {lab=Z_neg}
N 670 60 680 60 {lab=Z_neg}
N 320 620 310 620 {lab=A2}
N 310 620 310 420 {lab=A2}
N 310 420 110 420 {lab=A2}
N 110 420 110 60 {lab=A2}
N 110 420 -60 420 {lab=A2}
N 110 60 120 60 {lab=A2}
N 720 590 720 400 {lab=Z}
N 720 400 1100 400 {lab=Z}
N 720 400 720 90 {lab=Z}
N 120 620 90 620 {lab=A1}
N 90 620 90 380 {lab=A1}
N 90 380 -60 380 {lab=A1}
N 90 380 90 210 {lab=A1}
N 90 210 120 210 {lab=A1}
N 160 180 160 90 {lab=net_0}
C {devices/ipin.sym} -60 380 0 0 {name=p12 lab=A1}
C {devices/ipin.sym} -60 420 0 0 {name=p13 lab=A2}
C {devices/opin.sym} 1100 400 0 0 {name=p14 lab=Z}
