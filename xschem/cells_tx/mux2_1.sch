v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {mux2_1: Z = I1 if S else I0   (12 transistors, gf180mcu_fd_sc_mcu7t5v0 mux2_1; nfet_05v0 / pfet_05v0, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1060 770 0 0 {name=M_MN2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 500 770 0 0 {name=M_MN4 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 500 620 0 0 {name=M_MN8 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 700 620 0 0 {name=M_MN7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 700 770 0 0 {name=M_MN3 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 770 0 0 {name=M_MN1 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1060 60 0 0 {name=M_MP5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 500 60 0 0 {name=M_MP4 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 500 210 0 0 {name=M_MP8 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 700 210 0 0 {name=M_MP7 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 700 60 0 0 {name=M_MP3 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=M_MP1 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
N 1080 800 1080 820 {lab=0}
C {devices/gnd.sym} 1080 820 0 0 {name=s1 lab=0}
N 1080 770 1110 770 {lab=0}
C {devices/gnd.sym} 1110 770 0 0 {name=s2 lab=0}
N 520 800 520 820 {lab=0}
C {devices/gnd.sym} 520 820 0 0 {name=s3 lab=0}
N 520 770 550 770 {lab=0}
C {devices/gnd.sym} 550 770 0 0 {name=s4 lab=0}
N 520 620 550 620 {lab=0}
C {devices/gnd.sym} 550 620 0 0 {name=s5 lab=0}
N 720 620 750 620 {lab=0}
C {devices/gnd.sym} 750 620 0 0 {name=s6 lab=0}
N 720 800 720 820 {lab=0}
C {devices/gnd.sym} 720 820 0 0 {name=s7 lab=0}
N 720 770 750 770 {lab=0}
C {devices/gnd.sym} 750 770 0 0 {name=s8 lab=0}
N 160 800 160 820 {lab=0}
C {devices/gnd.sym} 160 820 0 0 {name=s9 lab=0}
N 160 770 190 770 {lab=0}
C {devices/gnd.sym} 190 770 0 0 {name=s10 lab=0}
N 1080 30 1080 10 {lab=VDD}
C {devices/vdd.sym} 1080 10 0 0 {name=s11 lab=VDD}
N 1080 60 1110 60 {lab=VDD}
C {devices/vdd.sym} 1110 60 0 0 {name=s12 lab=VDD}
N 520 30 520 10 {lab=VDD}
C {devices/vdd.sym} 520 10 0 0 {name=s13 lab=VDD}
N 520 60 550 60 {lab=VDD}
C {devices/vdd.sym} 550 60 0 0 {name=s14 lab=VDD}
N 520 210 550 210 {lab=VDD}
C {devices/vdd.sym} 550 210 0 0 {name=s15 lab=VDD}
N 720 210 750 210 {lab=VDD}
C {devices/vdd.sym} 750 210 0 0 {name=s16 lab=VDD}
N 720 30 720 10 {lab=VDD}
C {devices/vdd.sym} 720 10 0 0 {name=s17 lab=VDD}
N 720 60 750 60 {lab=VDD}
C {devices/vdd.sym} 750 60 0 0 {name=s18 lab=VDD}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s19 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s20 lab=VDD}
N 1040 770 1030 770 {lab=int04}
N 1030 770 1030 590 {lab=int04}
N 1030 590 1030 240 {lab=int04}
N 1030 590 720 590 {lab=int04}
N 720 590 720 580 {lab=int04}
N 720 580 520 580 {lab=int04}
N 520 580 520 590 {lab=int04}
N 1030 240 720 240 {lab=int04}
N 1030 240 1030 60 {lab=int04}
N 1030 60 1040 60 {lab=int04}
N 720 240 720 250 {lab=int04}
N 720 250 520 250 {lab=int04}
N 520 250 520 240 {lab=int04}
N 480 620 470 620 {lab=S}
N 470 620 470 560 {lab=S}
N 470 620 110 620 {lab=S}
N 110 620 110 770 {lab=S}
N 110 620 110 510 {lab=S}
N 110 770 120 770 {lab=S}
N 470 560 560 560 {lab=S}
N 560 560 560 210 {lab=S}
N 560 210 680 210 {lab=S}
N 110 510 -60 510 {lab=S}
N 110 510 110 60 {lab=S}
N 110 60 120 60 {lab=S}
N 680 620 670 620 {lab=sel1_n}
N 670 620 670 540 {lab=sel1_n}
N 670 540 470 540 {lab=sel1_n}
N 470 540 160 540 {lab=sel1_n}
N 470 540 470 210 {lab=sel1_n}
N 470 210 480 210 {lab=sel1_n}
N 160 540 160 90 {lab=sel1_n}
N 160 540 160 740 {lab=sel1_n}
N 680 770 650 770 {lab=I0}
N 650 770 650 430 {lab=I0}
N 650 430 650 60 {lab=I0}
N 650 430 -60 430 {lab=I0}
N 650 60 680 60 {lab=I0}
N 480 770 450 770 {lab=I1}
N 450 770 450 470 {lab=I1}
N 450 470 -60 470 {lab=I1}
N 450 470 450 60 {lab=I1}
N 450 60 480 60 {lab=I1}
N 1080 740 1080 470 {lab=Z}
N 1080 470 1460 470 {lab=Z}
N 1080 470 1080 90 {lab=Z}
N 520 740 520 650 {lab=net_1}
N 720 650 720 740 {lab=net_3}
N 520 90 520 180 {lab=net_0}
N 720 180 720 90 {lab=net_2}
C {devices/ipin.sym} -60 430 0 0 {name=p21 lab=I0}
C {devices/ipin.sym} -60 470 0 0 {name=p22 lab=I1}
C {devices/ipin.sym} -60 510 0 0 {name=p23 lab=S}
C {devices/opin.sym} 1460 470 0 0 {name=p24 lab=Z}
