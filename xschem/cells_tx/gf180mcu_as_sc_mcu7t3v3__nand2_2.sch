v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {gf180mcu_as_sc_mcu7t3v3__nand2_2: Y = NOT (A AND B)   (8 transistors, gf180mcu_as_sc_mcu7t3v3 nand2_2; nfet_03v3 / pfet_03v3, W and L in um)} 0 -140 0 0 0.4 0.4 {}
T {PMOS hang from VDD at the top, NMOS stand on ground at the bottom; stages run left to right in signal order. Crossing wires are not connected; a join has a dot.} 0 -110 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 140 60 0 0 {name=M_M0 L=0.28u W=1.38u nf=1 m=1 ad=3.588e-13 as=3.588e-13 pd=1.9e-06 ps=1.9e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 140 620 0 0 {name=M_M1 L=0.28u W=1u nf=1 m=1 ad=2.6e-13 as=4.4e-13 pd=1.52e-06 ps=2.88e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 340 60 0 0 {name=M_M2 L=0.28u W=1.38u nf=1 m=1 ad=3.588e-13 as=3.588e-13 pd=1.9e-06 ps=1.9e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 340 470 0 0 {name=M_M3 L=0.28u W=1u nf=1 m=1 ad=5.15e-13 as=2.6e-13 pd=3.03e-06 ps=1.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 540 60 0 0 {name=M_M4 L=0.28u W=1.38u nf=1 m=1 ad=7.176e-13 as=3.588e-13 pd=3.8e-06 ps=1.9e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 140 470 0 0 {name=M_M5 L=0.28u W=1u nf=1 m=1 ad=2.6e-13 as=2.6e-13 pd=1.52e-06 ps=1.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 740 60 0 0 {name=M_M6 L=0.28u W=1.38u nf=1 m=1 ad=3.588e-13 as=6.072e-13 pd=1.9e-06 ps=3.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 340 620 0 0 {name=M_M7 L=0.28u W=1u nf=1 m=1 ad=2.6e-13 as=2.6e-13 pd=1.52e-06 ps=1.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s1 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s2 lab=VDD}
N 160 650 160 670 {lab=0}
C {devices/gnd.sym} 160 670 0 0 {name=s3 lab=0}
N 160 620 190 620 {lab=0}
C {devices/gnd.sym} 190 620 0 0 {name=s4 lab=0}
N 360 30 360 10 {lab=VDD}
C {devices/vdd.sym} 360 10 0 0 {name=s5 lab=VDD}
N 360 60 390 60 {lab=VDD}
C {devices/vdd.sym} 390 60 0 0 {name=s6 lab=VDD}
N 360 470 390 470 {lab=0}
C {devices/gnd.sym} 390 470 0 0 {name=s7 lab=0}
N 560 30 560 10 {lab=VDD}
C {devices/vdd.sym} 560 10 0 0 {name=s8 lab=VDD}
N 560 60 590 60 {lab=VDD}
C {devices/vdd.sym} 590 60 0 0 {name=s9 lab=VDD}
N 160 470 190 470 {lab=0}
C {devices/gnd.sym} 190 470 0 0 {name=s10 lab=0}
N 760 30 760 10 {lab=VDD}
C {devices/vdd.sym} 760 10 0 0 {name=s11 lab=VDD}
N 760 60 790 60 {lab=VDD}
C {devices/vdd.sym} 790 60 0 0 {name=s12 lab=VDD}
N 360 650 360 670 {lab=0}
C {devices/gnd.sym} 360 670 0 0 {name=s13 lab=0}
N 360 620 390 620 {lab=0}
C {devices/gnd.sym} 390 620 0 0 {name=s14 lab=0}
N 160 90 160 100 {lab=Y}
N 160 100 160 430 {lab=Y}
N 160 100 360 100 {lab=Y}
N 360 100 560 100 {lab=Y}
N 360 100 360 90 {lab=Y}
N 160 430 160 440 {lab=Y}
N 160 430 360 430 {lab=Y}
N 560 100 760 100 {lab=Y}
N 560 100 560 90 {lab=Y}
N 360 430 360 440 {lab=Y}
N 760 100 760 90 {lab=Y}
N 760 100 760 400 {lab=Y}
N 760 400 1140 400 {lab=Y}
N 120 60 110 60 {lab=A}
N 110 60 110 120 {lab=A}
N 110 120 110 420 {lab=A}
N 110 120 600 120 {lab=A}
N 110 420 110 580 {lab=A}
N 110 420 -60 420 {lab=A}
N 110 580 110 620 {lab=A}
N 110 580 200 580 {lab=A}
N 110 620 120 620 {lab=A}
N 600 120 600 60 {lab=A}
N 600 60 720 60 {lab=A}
N 200 580 200 620 {lab=A}
N 200 620 320 620 {lab=A}
N 320 60 310 60 {lab=B}
N 310 60 310 0 {lab=B}
N 310 60 310 470 {lab=B}
N 310 0 400 0 {lab=B}
N 400 0 400 60 {lab=B}
N 400 60 520 60 {lab=B}
N 310 470 310 510 {lab=B}
N 310 470 320 470 {lab=B}
N 310 510 90 510 {lab=B}
N 90 510 90 470 {lab=B}
N 90 470 120 470 {lab=B}
N 90 470 90 380 {lab=B}
N 90 380 -60 380 {lab=B}
N 160 590 160 560 {lab=a_28_68#}
N 160 560 360 560 {lab=a_28_68#}
N 160 560 160 500 {lab=a_28_68#}
N 360 560 360 590 {lab=a_28_68#}
N 360 560 360 500 {lab=a_28_68#}
C {devices/ipin.sym} -60 380 0 0 {name=p15 lab=B}
C {devices/ipin.sym} -60 420 0 0 {name=p16 lab=A}
C {devices/opin.sym} 1140 400 0 0 {name=p17 lab=Y}
