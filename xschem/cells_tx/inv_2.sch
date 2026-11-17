v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {inv_2: ZN = NOT I   (4 transistors, gf180mcu_fd_sc_mcu7t5v0 inv_2; nfet_05v0 / pfet_05v0, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 470 0 0 {name=M_i_0_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 340 470 0 0 {name=M_i_0_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=M_i_1_0 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 340 60 0 0 {name=M_i_1_1 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
N 160 500 160 520 {lab=0}
C {devices/gnd.sym} 160 520 0 0 {name=s1 lab=0}
N 160 470 190 470 {lab=0}
C {devices/gnd.sym} 190 470 0 0 {name=s2 lab=0}
N 360 500 360 520 {lab=0}
C {devices/gnd.sym} 360 520 0 0 {name=s3 lab=0}
N 360 470 390 470 {lab=0}
C {devices/gnd.sym} 390 470 0 0 {name=s4 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s5 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s6 lab=VDD}
N 360 30 360 10 {lab=VDD}
C {devices/vdd.sym} 360 10 0 0 {name=s7 lab=VDD}
N 360 60 390 60 {lab=VDD}
C {devices/vdd.sym} 390 60 0 0 {name=s8 lab=VDD}
N 160 440 160 430 {lab=ZN}
N 160 430 160 100 {lab=ZN}
N 160 430 360 430 {lab=ZN}
N 360 430 360 320 {lab=ZN}
N 360 430 360 440 {lab=ZN}
N 160 100 160 90 {lab=ZN}
N 160 100 360 100 {lab=ZN}
N 360 100 360 90 {lab=ZN}
N 360 320 740 320 {lab=ZN}
N 120 470 110 470 {lab=I}
N 110 470 110 320 {lab=I}
N 110 470 110 530 {lab=I}
N 110 530 200 530 {lab=I}
N 200 530 200 470 {lab=I}
N 200 470 320 470 {lab=I}
N 110 320 -60 320 {lab=I}
N 110 320 110 120 {lab=I}
N 110 120 200 120 {lab=I}
N 110 120 110 60 {lab=I}
N 110 60 120 60 {lab=I}
N 200 120 200 60 {lab=I}
N 200 60 320 60 {lab=I}
C {devices/ipin.sym} -60 320 0 0 {name=p9 lab=I}
C {devices/opin.sym} 740 320 0 0 {name=p10 lab=ZN}
