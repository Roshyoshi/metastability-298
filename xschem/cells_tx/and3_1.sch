v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {and3_1: Z = A1 AND A2 AND A3   (8 transistors, gf180mcu_fd_sc_mcu7t5v0 and3_1; nfet_05v0 / pfet_05v0, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 470 0 0 {name=M_i_2 L=0.6u W=0.38u nf=1 m=1 ad=1.9e-13 as=1.9e-13 pd=1.76e-06 ps=1.76e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 620 0 0 {name=M_i_3 L=0.6u W=0.38u nf=1 m=1 ad=1.9e-13 as=1.9e-13 pd=1.76e-06 ps=1.76e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 770 0 0 {name=M_i_4 L=0.6u W=0.38u nf=1 m=1 ad=1.9e-13 as=1.9e-13 pd=1.76e-06 ps=1.76e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 900 770 0 0 {name=M_i_0 L=0.6u W=0.775u nf=1 m=1 ad=3.875e-13 as=3.875e-13 pd=2.55e-06 ps=2.55e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=M_i_5 L=0.5u W=0.535u nf=1 m=1 ad=2.675e-13 as=2.675e-13 pd=2.07e-06 ps=2.07e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 340 60 0 0 {name=M_i_6 L=0.5u W=0.535u nf=1 m=1 ad=2.675e-13 as=2.675e-13 pd=2.07e-06 ps=2.07e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 540 60 0 0 {name=M_i_7 L=0.5u W=0.535u nf=1 m=1 ad=2.675e-13 as=2.675e-13 pd=2.07e-06 ps=2.07e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 900 60 0 0 {name=M_i_1 L=0.5u W=1.215u nf=1 m=1 ad=6.075e-13 as=6.075e-13 pd=3.43e-06 ps=3.43e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
N 160 470 190 470 {lab=0}
C {devices/gnd.sym} 190 470 0 0 {name=s1 lab=0}
N 160 620 190 620 {lab=0}
C {devices/gnd.sym} 190 620 0 0 {name=s2 lab=0}
N 160 800 160 820 {lab=0}
C {devices/gnd.sym} 160 820 0 0 {name=s3 lab=0}
N 160 770 190 770 {lab=0}
C {devices/gnd.sym} 190 770 0 0 {name=s4 lab=0}
N 920 800 920 820 {lab=0}
C {devices/gnd.sym} 920 820 0 0 {name=s5 lab=0}
N 920 770 950 770 {lab=0}
C {devices/gnd.sym} 950 770 0 0 {name=s6 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s7 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s8 lab=VDD}
N 360 30 360 10 {lab=VDD}
C {devices/vdd.sym} 360 10 0 0 {name=s9 lab=VDD}
N 360 60 390 60 {lab=VDD}
C {devices/vdd.sym} 390 60 0 0 {name=s10 lab=VDD}
N 560 30 560 10 {lab=VDD}
C {devices/vdd.sym} 560 10 0 0 {name=s11 lab=VDD}
N 560 60 590 60 {lab=VDD}
C {devices/vdd.sym} 590 60 0 0 {name=s12 lab=VDD}
N 920 30 920 10 {lab=VDD}
C {devices/vdd.sym} 920 10 0 0 {name=s13 lab=VDD}
N 920 60 950 60 {lab=VDD}
C {devices/vdd.sym} 950 60 0 0 {name=s14 lab=VDD}
N 120 470 110 470 {lab=A1}
N 110 470 110 430 {lab=A1}
N 110 430 -60 430 {lab=A1}
N 110 430 110 60 {lab=A1}
N 110 60 120 60 {lab=A1}
N 160 440 160 100 {lab=Z_neg}
N 160 100 160 90 {lab=Z_neg}
N 160 100 360 100 {lab=Z_neg}
N 360 100 560 100 {lab=Z_neg}
N 360 100 360 90 {lab=Z_neg}
N 560 100 560 770 {lab=Z_neg}
N 560 100 560 90 {lab=Z_neg}
N 560 90 600 90 {lab=Z_neg}
N 560 770 880 770 {lab=Z_neg}
N 600 90 600 60 {lab=Z_neg}
N 600 60 880 60 {lab=Z_neg}
N 120 770 -60 770 {lab=A3}
N -60 770 -60 510 {lab=A3}
N -60 510 400 510 {lab=A3}
N 400 510 400 60 {lab=A3}
N 400 60 520 60 {lab=A3}
N 120 620 100 620 {lab=A2}
N 100 620 100 530 {lab=A2}
N 100 530 200 530 {lab=A2}
N 100 530 100 470 {lab=A2}
N 100 470 -60 470 {lab=A2}
N 200 530 200 60 {lab=A2}
N 200 60 320 60 {lab=A2}
N 920 740 920 470 {lab=Z}
N 920 470 1300 470 {lab=Z}
N 920 470 920 90 {lab=Z}
N 160 500 160 590 {lab=net_0}
N 160 650 160 740 {lab=net_1}
C {devices/ipin.sym} -60 430 0 0 {name=p15 lab=A1}
C {devices/ipin.sym} -60 470 0 0 {name=p16 lab=A2}
C {devices/ipin.sym} -60 510 0 0 {name=p17 lab=A3}
C {devices/opin.sym} 1300 470 0 0 {name=p18 lab=Z}
