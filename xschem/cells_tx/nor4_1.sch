v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {nor4_1: ZN = NOT (A1 OR A2 OR A3 OR A4)   (8 transistors, gf180mcu_fd_sc_mcu7t5v0 nor4_1; nfet_05v0 / pfet_05v0, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 920 0 0 {name=M_i_3 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 340 920 0 0 {name=M_i_2 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 540 920 0 0 {name=M_i_1 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 740 920 0 0 {name=M_i_0 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=M_i_7 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 210 0 0 {name=M_i_6 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 360 0 0 {name=M_i_5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 510 0 0 {name=M_i_4 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
N 160 950 160 970 {lab=0}
C {devices/gnd.sym} 160 970 0 0 {name=s1 lab=0}
N 160 920 190 920 {lab=0}
C {devices/gnd.sym} 190 920 0 0 {name=s2 lab=0}
N 360 950 360 970 {lab=0}
C {devices/gnd.sym} 360 970 0 0 {name=s3 lab=0}
N 360 920 390 920 {lab=0}
C {devices/gnd.sym} 390 920 0 0 {name=s4 lab=0}
N 560 950 560 970 {lab=0}
C {devices/gnd.sym} 560 970 0 0 {name=s5 lab=0}
N 560 920 590 920 {lab=0}
C {devices/gnd.sym} 590 920 0 0 {name=s6 lab=0}
N 760 950 760 970 {lab=0}
C {devices/gnd.sym} 760 970 0 0 {name=s7 lab=0}
N 760 920 790 920 {lab=0}
C {devices/gnd.sym} 790 920 0 0 {name=s8 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s9 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s10 lab=VDD}
N 160 210 190 210 {lab=VDD}
C {devices/vdd.sym} 190 210 0 0 {name=s11 lab=VDD}
N 160 360 190 360 {lab=VDD}
C {devices/vdd.sym} 190 360 0 0 {name=s12 lab=VDD}
N 160 510 190 510 {lab=VDD}
C {devices/vdd.sym} 190 510 0 0 {name=s13 lab=VDD}
N 160 890 160 880 {lab=ZN}
N 160 880 160 540 {lab=ZN}
N 160 880 360 880 {lab=ZN}
N 360 880 560 880 {lab=ZN}
N 360 880 360 890 {lab=ZN}
N 560 880 560 890 {lab=ZN}
N 560 880 760 880 {lab=ZN}
N 760 880 760 550 {lab=ZN}
N 760 880 760 890 {lab=ZN}
N 760 550 1140 550 {lab=ZN}
N 720 920 710 920 {lab=A1}
N 710 920 710 860 {lab=A1}
N 710 860 110 860 {lab=A1}
N 110 860 110 510 {lab=A1}
N 110 510 120 510 {lab=A1}
N 110 510 110 490 {lab=A1}
N 110 490 -60 490 {lab=A1}
N 520 920 510 920 {lab=A2}
N 510 920 510 470 {lab=A2}
N 510 470 110 470 {lab=A2}
N 110 470 110 360 {lab=A2}
N 110 470 -70 470 {lab=A2}
N 110 360 120 360 {lab=A2}
N -70 470 -70 530 {lab=A2}
N -70 530 -60 530 {lab=A2}
N 320 920 310 920 {lab=A3}
N 310 920 310 570 {lab=A3}
N 310 570 90 570 {lab=A3}
N 90 570 90 210 {lab=A3}
N 90 570 -60 570 {lab=A3}
N 90 210 120 210 {lab=A3}
N 120 920 -60 920 {lab=A4}
N -60 920 -60 610 {lab=A4}
N -60 610 -90 610 {lab=A4}
N -90 610 -90 60 {lab=A4}
N -90 60 120 60 {lab=A4}
N 160 90 160 180 {lab=net_2}
N 160 240 160 330 {lab=net_1}
N 160 390 160 480 {lab=net_0}
C {devices/ipin.sym} -60 490 0 0 {name=p14 lab=A1}
C {devices/ipin.sym} -60 530 0 0 {name=p15 lab=A2}
C {devices/ipin.sym} -60 570 0 0 {name=p16 lab=A3}
C {devices/ipin.sym} -60 610 0 0 {name=p17 lab=A4}
C {devices/opin.sym} 1140 550 0 0 {name=p18 lab=ZN}
