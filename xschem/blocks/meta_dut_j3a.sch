v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {meta_dut_j3a: N2: jamb-latch flip-flop j3a, 3.3 V transistors (master NMOS 4 x 1 um, PMOS 2 x 1 um, write 2 um, data 4 um; minimum slave; L = 0.28 um)   (flow box: Bank)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 240 80 0 0 {name=Mckin_0 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 260 50 0 1 {name=l1 lab=ckb}
C {devices/lab_pin.sym} 220 80 0 0 {name=l2 lab=clk}
C {devices/lab_pin.sym} 260 110 0 1 {name=l3 lab=0}
C {devices/lab_pin.sym} 260 80 0 1 {name=l4 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 440 80 0 0 {name=Mckip_0 L=0.28u W=1.38u nf=1 m=1 ad=6.9e-13 as=6.9e-13 pd=3.76e-06 ps=3.76e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 460 50 0 1 {name=l5 lab=VDD}
C {devices/lab_pin.sym} 420 80 0 0 {name=l6 lab=clk}
C {devices/lab_pin.sym} 460 110 0 1 {name=l7 lab=ckb}
C {devices/lab_pin.sym} 460 80 0 1 {name=l8 lab=VDD}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 640 80 0 0 {name=Mdin_0 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 660 50 0 1 {name=l9 lab=db}
C {devices/lab_pin.sym} 620 80 0 0 {name=l10 lab=d}
C {devices/lab_pin.sym} 660 110 0 1 {name=l11 lab=0}
C {devices/lab_pin.sym} 660 80 0 1 {name=l12 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 840 80 0 0 {name=Mdip_0 L=0.28u W=1.38u nf=1 m=1 ad=6.9e-13 as=6.9e-13 pd=3.76e-06 ps=3.76e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 860 50 0 1 {name=l13 lab=VDD}
C {devices/lab_pin.sym} 820 80 0 0 {name=l14 lab=d}
C {devices/lab_pin.sym} 860 110 0 1 {name=l15 lab=db}
C {devices/lab_pin.sym} 860 80 0 1 {name=l16 lab=VDD}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 1040 80 0 0 {name=mn1_0 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1060 50 0 1 {name=l17 lab=x}
C {devices/lab_pin.sym} 1020 80 0 0 {name=l18 lab=y}
C {devices/lab_pin.sym} 1060 110 0 1 {name=l19 lab=0}
C {devices/lab_pin.sym} 1060 80 0 1 {name=l20 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 1240 80 0 0 {name=mn1_1 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1260 50 0 1 {name=l21 lab=x}
C {devices/lab_pin.sym} 1220 80 0 0 {name=l22 lab=y}
C {devices/lab_pin.sym} 1260 110 0 1 {name=l23 lab=0}
C {devices/lab_pin.sym} 1260 80 0 1 {name=l24 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 1440 80 0 0 {name=mn1_2 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1460 50 0 1 {name=l25 lab=x}
C {devices/lab_pin.sym} 1420 80 0 0 {name=l26 lab=y}
C {devices/lab_pin.sym} 1460 110 0 1 {name=l27 lab=0}
C {devices/lab_pin.sym} 1460 80 0 1 {name=l28 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 1640 80 0 0 {name=mn1_3 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1660 50 0 1 {name=l29 lab=x}
C {devices/lab_pin.sym} 1620 80 0 0 {name=l30 lab=y}
C {devices/lab_pin.sym} 1660 110 0 1 {name=l31 lab=0}
C {devices/lab_pin.sym} 1660 80 0 1 {name=l32 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 240 240 0 0 {name=mp1_0 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 260 210 0 1 {name=l33 lab=VDD}
C {devices/lab_pin.sym} 220 240 0 0 {name=l34 lab=y}
C {devices/lab_pin.sym} 260 270 0 1 {name=l35 lab=x}
C {devices/lab_pin.sym} 260 240 0 1 {name=l36 lab=VDD}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 440 240 0 0 {name=mp1_1 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 460 210 0 1 {name=l37 lab=VDD}
C {devices/lab_pin.sym} 420 240 0 0 {name=l38 lab=y}
C {devices/lab_pin.sym} 460 270 0 1 {name=l39 lab=x}
C {devices/lab_pin.sym} 460 240 0 1 {name=l40 lab=VDD}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 640 240 0 0 {name=mn2_0 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 660 210 0 1 {name=l41 lab=y}
C {devices/lab_pin.sym} 620 240 0 0 {name=l42 lab=x}
C {devices/lab_pin.sym} 660 270 0 1 {name=l43 lab=0}
C {devices/lab_pin.sym} 660 240 0 1 {name=l44 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 840 240 0 0 {name=mn2_1 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 860 210 0 1 {name=l45 lab=y}
C {devices/lab_pin.sym} 820 240 0 0 {name=l46 lab=x}
C {devices/lab_pin.sym} 860 270 0 1 {name=l47 lab=0}
C {devices/lab_pin.sym} 860 240 0 1 {name=l48 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 1040 240 0 0 {name=mn2_2 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1060 210 0 1 {name=l49 lab=y}
C {devices/lab_pin.sym} 1020 240 0 0 {name=l50 lab=x}
C {devices/lab_pin.sym} 1060 270 0 1 {name=l51 lab=0}
C {devices/lab_pin.sym} 1060 240 0 1 {name=l52 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 1240 240 0 0 {name=mn2_3 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1260 210 0 1 {name=l53 lab=y}
C {devices/lab_pin.sym} 1220 240 0 0 {name=l54 lab=x}
C {devices/lab_pin.sym} 1260 270 0 1 {name=l55 lab=0}
C {devices/lab_pin.sym} 1260 240 0 1 {name=l56 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 1440 240 0 0 {name=mp2_0 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1460 210 0 1 {name=l57 lab=VDD}
C {devices/lab_pin.sym} 1420 240 0 0 {name=l58 lab=x}
C {devices/lab_pin.sym} 1460 270 0 1 {name=l59 lab=y}
C {devices/lab_pin.sym} 1460 240 0 1 {name=l60 lab=VDD}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 1640 240 0 0 {name=mp2_1 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1660 210 0 1 {name=l61 lab=VDD}
C {devices/lab_pin.sym} 1620 240 0 0 {name=l62 lab=x}
C {devices/lab_pin.sym} 1660 270 0 1 {name=l63 lab=y}
C {devices/lab_pin.sym} 1660 240 0 1 {name=l64 lab=VDD}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 240 400 0 0 {name=mwx_0 L=0.28u W=2u nf=1 m=1 ad=1e-12 as=1e-12 pd=5e-06 ps=5e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 260 370 0 1 {name=l65 lab=x}
C {devices/lab_pin.sym} 220 400 0 0 {name=l66 lab=ckb}
C {devices/lab_pin.sym} 260 430 0 1 {name=l67 lab=ax}
C {devices/lab_pin.sym} 260 400 0 1 {name=l68 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 440 400 0 0 {name=mdx_0 L=0.28u W=4u nf=1 m=1 ad=2e-12 as=2e-12 pd=9e-06 ps=9e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 460 370 0 1 {name=l69 lab=ax}
C {devices/lab_pin.sym} 420 400 0 0 {name=l70 lab=db}
C {devices/lab_pin.sym} 460 430 0 1 {name=l71 lab=0}
C {devices/lab_pin.sym} 460 400 0 1 {name=l72 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 640 400 0 0 {name=mwy_0 L=0.28u W=2u nf=1 m=1 ad=1e-12 as=1e-12 pd=5e-06 ps=5e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 660 370 0 1 {name=l73 lab=y}
C {devices/lab_pin.sym} 620 400 0 0 {name=l74 lab=ckb}
C {devices/lab_pin.sym} 660 430 0 1 {name=l75 lab=ay}
C {devices/lab_pin.sym} 660 400 0 1 {name=l76 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 840 400 0 0 {name=mdy_0 L=0.28u W=4u nf=1 m=1 ad=2e-12 as=2e-12 pd=9e-06 ps=9e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 860 370 0 1 {name=l77 lab=ay}
C {devices/lab_pin.sym} 820 400 0 0 {name=l78 lab=d}
C {devices/lab_pin.sym} 860 430 0 1 {name=l79 lab=0}
C {devices/lab_pin.sym} 860 400 0 1 {name=l80 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 1040 400 0 0 {name=Msn1_0 L=0.28u W=0.5u nf=1 m=1 ad=2.5e-13 as=2.5e-13 pd=2e-06 ps=2e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1060 370 0 1 {name=l81 lab=s}
C {devices/lab_pin.sym} 1020 400 0 0 {name=l82 lab=sb}
C {devices/lab_pin.sym} 1060 430 0 1 {name=l83 lab=0}
C {devices/lab_pin.sym} 1060 400 0 1 {name=l84 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 1240 400 0 0 {name=Msp1_0 L=0.28u W=0.3u nf=1 m=1 ad=1.5e-13 as=1.5e-13 pd=1.6e-06 ps=1.6e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1260 370 0 1 {name=l85 lab=VDD}
C {devices/lab_pin.sym} 1220 400 0 0 {name=l86 lab=sb}
C {devices/lab_pin.sym} 1260 430 0 1 {name=l87 lab=s}
C {devices/lab_pin.sym} 1260 400 0 1 {name=l88 lab=VDD}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 1440 400 0 0 {name=Msn2_0 L=0.28u W=0.5u nf=1 m=1 ad=2.5e-13 as=2.5e-13 pd=2e-06 ps=2e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1460 370 0 1 {name=l89 lab=sb}
C {devices/lab_pin.sym} 1420 400 0 0 {name=l90 lab=s}
C {devices/lab_pin.sym} 1460 430 0 1 {name=l91 lab=0}
C {devices/lab_pin.sym} 1460 400 0 1 {name=l92 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 1640 400 0 0 {name=Msp2_0 L=0.28u W=0.3u nf=1 m=1 ad=1.5e-13 as=1.5e-13 pd=1.6e-06 ps=1.6e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1660 370 0 1 {name=l93 lab=VDD}
C {devices/lab_pin.sym} 1620 400 0 0 {name=l94 lab=s}
C {devices/lab_pin.sym} 1660 430 0 1 {name=l95 lab=sb}
C {devices/lab_pin.sym} 1660 400 0 1 {name=l96 lab=VDD}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 240 560 0 0 {name=Mswa_0 L=0.28u W=0.3u nf=1 m=1 ad=1.5e-13 as=1.5e-13 pd=1.6e-06 ps=1.6e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 260 530 0 1 {name=l97 lab=sb}
C {devices/lab_pin.sym} 220 560 0 0 {name=l98 lab=clk}
C {devices/lab_pin.sym} 260 590 0 1 {name=l99 lab=c1}
C {devices/lab_pin.sym} 260 560 0 1 {name=l100 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 440 560 0 0 {name=Msda_0 L=0.28u W=0.3u nf=1 m=1 ad=1.5e-13 as=1.5e-13 pd=1.6e-06 ps=1.6e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 460 530 0 1 {name=l101 lab=c1}
C {devices/lab_pin.sym} 420 560 0 0 {name=l102 lab=x}
C {devices/lab_pin.sym} 460 590 0 1 {name=l103 lab=0}
C {devices/lab_pin.sym} 460 560 0 1 {name=l104 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 640 560 0 0 {name=Mswb_0 L=0.28u W=0.3u nf=1 m=1 ad=1.5e-13 as=1.5e-13 pd=1.6e-06 ps=1.6e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 660 530 0 1 {name=l105 lab=s}
C {devices/lab_pin.sym} 620 560 0 0 {name=l106 lab=clk}
C {devices/lab_pin.sym} 660 590 0 1 {name=l107 lab=c2}
C {devices/lab_pin.sym} 660 560 0 1 {name=l108 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 840 560 0 0 {name=Msdb_0 L=0.28u W=0.3u nf=1 m=1 ad=1.5e-13 as=1.5e-13 pd=1.6e-06 ps=1.6e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 860 530 0 1 {name=l109 lab=c2}
C {devices/lab_pin.sym} 820 560 0 0 {name=l110 lab=y}
C {devices/lab_pin.sym} 860 590 0 1 {name=l111 lab=0}
C {devices/lab_pin.sym} 860 560 0 1 {name=l112 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 1040 560 0 0 {name=Mqon_0 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1060 530 0 1 {name=l113 lab=q}
C {devices/lab_pin.sym} 1020 560 0 0 {name=l114 lab=sb}
C {devices/lab_pin.sym} 1060 590 0 1 {name=l115 lab=0}
C {devices/lab_pin.sym} 1060 560 0 1 {name=l116 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 1240 560 0 0 {name=Mqop_0 L=0.28u W=1.38u nf=1 m=1 ad=6.9e-13 as=6.9e-13 pd=3.76e-06 ps=3.76e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1260 530 0 1 {name=l117 lab=VDD}
C {devices/lab_pin.sym} 1220 560 0 0 {name=l118 lab=sb}
C {devices/lab_pin.sym} 1260 590 0 1 {name=l119 lab=q}
C {devices/lab_pin.sym} 1260 560 0 1 {name=l120 lab=VDD}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_03v3.sym} 1440 560 0 0 {name=Mqdn_0 L=0.28u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1460 530 0 1 {name=l121 lab=qn}
C {devices/lab_pin.sym} 1420 560 0 0 {name=l122 lab=s}
C {devices/lab_pin.sym} 1460 590 0 1 {name=l123 lab=0}
C {devices/lab_pin.sym} 1460 560 0 1 {name=l124 lab=0}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_03v3.sym} 1640 560 0 0 {name=Mqdp_0 L=0.28u W=1.38u nf=1 m=1 ad=6.9e-13 as=6.9e-13 pd=3.76e-06 ps=3.76e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_03v3 spiceprefix=X}
C {devices/lab_pin.sym} 1660 530 0 1 {name=l125 lab=VDD}
C {devices/lab_pin.sym} 1620 560 0 0 {name=l126 lab=s}
C {devices/lab_pin.sym} 1660 590 0 1 {name=l127 lab=qn}
C {devices/lab_pin.sym} 1660 560 0 1 {name=l128 lab=VDD}
C {devices/ipin.sym} 60 0 0 0 {name=p129 lab=d}
C {devices/ipin.sym} 60 40 0 0 {name=p130 lab=clk}
C {devices/opin.sym} 1900 0 0 0 {name=p131 lab=q}
