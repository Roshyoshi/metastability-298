v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {tiel: ZN = 0 (tie-low cell)   (2 transistors, gf180mcu_fd_sc_mcu7t5v0 tiel; nfet_05v0 / pfet_05v0, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 500 470 0 0 {name=M_n_tran_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=M_transistor_0 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
N 520 500 520 520 {lab=0}
C {devices/gnd.sym} 520 520 0 0 {name=s1 lab=0}
N 520 470 550 470 {lab=0}
C {devices/gnd.sym} 550 470 0 0 {name=s2 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s3 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s4 lab=VDD}
N 480 470 160 470 {lab=A}
N 160 470 160 100 {lab=A}
N 160 100 110 100 {lab=A}
N 160 100 160 90 {lab=A}
N 110 100 110 60 {lab=A}
N 110 60 120 60 {lab=A}
N 520 440 520 320 {lab=ZN}
N 520 320 900 320 {lab=ZN}
C {devices/opin.sym} 900 320 0 0 {name=p5 lab=ZN}
