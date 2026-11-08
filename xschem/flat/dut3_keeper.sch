v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {dut3_keeper: NAND flip-flop meta_dut_keeper at transistor level} 0 -230 0 0 0.45 0.45 {}
T {Keeper strengthened: u_mfw = nand2_2, u_mkp = nand2_2 (keeper transistors twice as wide in effect, doubled).} 0 -190 0 0 0.26 0.26 {}
T {Stages left to right: clock inverter, master door (u_mg1, u_mg2), master latch (u_mfw forward, u_mkp keeper: the cross-coupled pair that goes metastable, nodes mq and mqb),} 0 -162 0 0 0.26 0.26 {}
T {slave door (u_sg1, u_sg2), slave latch (u_sfw, u_skp).} 0 -134 0 0 0.26 0.26 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 620 0 0 {name=Mu_cki_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=Mu_cki_i_1 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 500 620 0 0 {name=Mu_mg1_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 500 470 0 0 {name=Mu_mg1_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 500 60 0 0 {name=Mu_mg1_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 700 60 0 0 {name=Mu_mg1_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1060 620 0 0 {name=Mu_mg2_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1060 470 0 0 {name=Mu_mg2_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1060 60 0 0 {name=Mu_mg2_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1260 60 0 0 {name=Mu_mg2_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1620 620 0 0 {name=Mu_mfw_i_1_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1620 470 0 0 {name=Mu_mfw_i_0_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1820 470 0 0 {name=Mu_mfw_i_0_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1820 620 0 0 {name=Mu_mfw_i_1_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1620 60 0 0 {name=Mu_mfw_i_3_1 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1820 60 0 0 {name=Mu_mfw_i_2_1 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2020 60 0 0 {name=Mu_mfw_i_2_0 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2220 60 0 0 {name=Mu_mfw_i_3_0 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2580 620 0 0 {name=Mu_mkp_i_1_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2580 470 0 0 {name=Mu_mkp_i_0_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2780 470 0 0 {name=Mu_mkp_i_0_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2780 620 0 0 {name=Mu_mkp_i_1_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2580 60 0 0 {name=Mu_mkp_i_3_1 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2780 60 0 0 {name=Mu_mkp_i_2_1 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2980 60 0 0 {name=Mu_mkp_i_2_0 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3180 60 0 0 {name=Mu_mkp_i_3_0 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3540 620 0 0 {name=Mu_sg1_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3540 470 0 0 {name=Mu_sg1_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3540 60 0 0 {name=Mu_sg1_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3740 60 0 0 {name=Mu_sg1_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4100 620 0 0 {name=Mu_sg2_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4100 470 0 0 {name=Mu_sg2_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4100 60 0 0 {name=Mu_sg2_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4300 60 0 0 {name=Mu_sg2_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4660 620 0 0 {name=Mu_sfw_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4660 470 0 0 {name=Mu_sfw_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4660 60 0 0 {name=Mu_sfw_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4860 60 0 0 {name=Mu_sfw_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5220 620 0 0 {name=Mu_skp_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5220 470 0 0 {name=Mu_skp_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5220 60 0 0 {name=Mu_skp_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5420 60 0 0 {name=Mu_skp_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
T {u_cki} 110 -35 0 0 0.3 0.3 {}
T {u_mg1} 470 -35 0 0 0.3 0.3 {}
T {u_mg2} 1030 -35 0 0 0.3 0.3 {}
T {u_mfw} 1590 -35 0 0 0.3 0.3 {}
T {u_mkp} 2550 -35 0 0 0.3 0.3 {}
T {u_sg1} 3510 -35 0 0 0.3 0.3 {}
T {u_sg2} 4070 -35 0 0 0.3 0.3 {}
T {u_sfw} 4630 -35 0 0 0.3 0.3 {}
T {u_skp} 5190 -35 0 0 0.3 0.3 {}
N 160 650 160 670 {lab=0}
C {devices/gnd.sym} 160 670 0 0 {name=s1 lab=0}
N 160 620 190 620 {lab=0}
C {devices/gnd.sym} 190 620 0 0 {name=s2 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s3 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s4 lab=VDD}
N 520 650 520 670 {lab=0}
C {devices/gnd.sym} 520 670 0 0 {name=s5 lab=0}
N 520 620 550 620 {lab=0}
C {devices/gnd.sym} 550 620 0 0 {name=s6 lab=0}
N 520 470 550 470 {lab=0}
C {devices/gnd.sym} 550 470 0 0 {name=s7 lab=0}
N 520 30 520 10 {lab=VDD}
C {devices/vdd.sym} 520 10 0 0 {name=s8 lab=VDD}
N 520 60 550 60 {lab=VDD}
C {devices/vdd.sym} 550 60 0 0 {name=s9 lab=VDD}
N 720 30 720 10 {lab=VDD}
C {devices/vdd.sym} 720 10 0 0 {name=s10 lab=VDD}
N 720 60 750 60 {lab=VDD}
C {devices/vdd.sym} 750 60 0 0 {name=s11 lab=VDD}
N 1080 650 1080 670 {lab=0}
C {devices/gnd.sym} 1080 670 0 0 {name=s12 lab=0}
N 1080 620 1110 620 {lab=0}
C {devices/gnd.sym} 1110 620 0 0 {name=s13 lab=0}
N 1080 470 1110 470 {lab=0}
C {devices/gnd.sym} 1110 470 0 0 {name=s14 lab=0}
N 1080 30 1080 10 {lab=VDD}
C {devices/vdd.sym} 1080 10 0 0 {name=s15 lab=VDD}
N 1080 60 1110 60 {lab=VDD}
C {devices/vdd.sym} 1110 60 0 0 {name=s16 lab=VDD}
N 1280 30 1280 10 {lab=VDD}
C {devices/vdd.sym} 1280 10 0 0 {name=s17 lab=VDD}
N 1280 60 1310 60 {lab=VDD}
C {devices/vdd.sym} 1310 60 0 0 {name=s18 lab=VDD}
N 1640 650 1640 670 {lab=0}
C {devices/gnd.sym} 1640 670 0 0 {name=s19 lab=0}
N 1640 620 1670 620 {lab=0}
C {devices/gnd.sym} 1670 620 0 0 {name=s20 lab=0}
N 1640 470 1670 470 {lab=0}
C {devices/gnd.sym} 1670 470 0 0 {name=s21 lab=0}
N 1840 470 1870 470 {lab=0}
C {devices/gnd.sym} 1870 470 0 0 {name=s22 lab=0}
N 1840 650 1840 670 {lab=0}
C {devices/gnd.sym} 1840 670 0 0 {name=s23 lab=0}
N 1840 620 1870 620 {lab=0}
C {devices/gnd.sym} 1870 620 0 0 {name=s24 lab=0}
N 1640 30 1640 10 {lab=VDD}
C {devices/vdd.sym} 1640 10 0 0 {name=s25 lab=VDD}
N 1640 60 1670 60 {lab=VDD}
C {devices/vdd.sym} 1670 60 0 0 {name=s26 lab=VDD}
N 1840 30 1840 10 {lab=VDD}
C {devices/vdd.sym} 1840 10 0 0 {name=s27 lab=VDD}
N 1840 60 1870 60 {lab=VDD}
C {devices/vdd.sym} 1870 60 0 0 {name=s28 lab=VDD}
N 2040 30 2040 10 {lab=VDD}
C {devices/vdd.sym} 2040 10 0 0 {name=s29 lab=VDD}
N 2040 60 2070 60 {lab=VDD}
C {devices/vdd.sym} 2070 60 0 0 {name=s30 lab=VDD}
N 2240 30 2240 10 {lab=VDD}
C {devices/vdd.sym} 2240 10 0 0 {name=s31 lab=VDD}
N 2240 60 2270 60 {lab=VDD}
C {devices/vdd.sym} 2270 60 0 0 {name=s32 lab=VDD}
N 2600 650 2600 670 {lab=0}
C {devices/gnd.sym} 2600 670 0 0 {name=s33 lab=0}
N 2600 620 2630 620 {lab=0}
C {devices/gnd.sym} 2630 620 0 0 {name=s34 lab=0}
N 2600 470 2630 470 {lab=0}
C {devices/gnd.sym} 2630 470 0 0 {name=s35 lab=0}
N 2800 470 2830 470 {lab=0}
C {devices/gnd.sym} 2830 470 0 0 {name=s36 lab=0}
N 2800 650 2800 670 {lab=0}
C {devices/gnd.sym} 2800 670 0 0 {name=s37 lab=0}
N 2800 620 2830 620 {lab=0}
C {devices/gnd.sym} 2830 620 0 0 {name=s38 lab=0}
N 2600 30 2600 10 {lab=VDD}
C {devices/vdd.sym} 2600 10 0 0 {name=s39 lab=VDD}
N 2600 60 2630 60 {lab=VDD}
C {devices/vdd.sym} 2630 60 0 0 {name=s40 lab=VDD}
N 2800 30 2800 10 {lab=VDD}
C {devices/vdd.sym} 2800 10 0 0 {name=s41 lab=VDD}
N 2800 60 2830 60 {lab=VDD}
C {devices/vdd.sym} 2830 60 0 0 {name=s42 lab=VDD}
N 3000 30 3000 10 {lab=VDD}
C {devices/vdd.sym} 3000 10 0 0 {name=s43 lab=VDD}
N 3000 60 3030 60 {lab=VDD}
C {devices/vdd.sym} 3030 60 0 0 {name=s44 lab=VDD}
N 3200 30 3200 10 {lab=VDD}
C {devices/vdd.sym} 3200 10 0 0 {name=s45 lab=VDD}
N 3200 60 3230 60 {lab=VDD}
C {devices/vdd.sym} 3230 60 0 0 {name=s46 lab=VDD}
N 3560 650 3560 670 {lab=0}
C {devices/gnd.sym} 3560 670 0 0 {name=s47 lab=0}
N 3560 620 3590 620 {lab=0}
C {devices/gnd.sym} 3590 620 0 0 {name=s48 lab=0}
N 3560 470 3590 470 {lab=0}
C {devices/gnd.sym} 3590 470 0 0 {name=s49 lab=0}
N 3560 30 3560 10 {lab=VDD}
C {devices/vdd.sym} 3560 10 0 0 {name=s50 lab=VDD}
N 3560 60 3590 60 {lab=VDD}
C {devices/vdd.sym} 3590 60 0 0 {name=s51 lab=VDD}
N 3760 30 3760 10 {lab=VDD}
C {devices/vdd.sym} 3760 10 0 0 {name=s52 lab=VDD}
N 3760 60 3790 60 {lab=VDD}
C {devices/vdd.sym} 3790 60 0 0 {name=s53 lab=VDD}
N 4120 650 4120 670 {lab=0}
C {devices/gnd.sym} 4120 670 0 0 {name=s54 lab=0}
N 4120 620 4150 620 {lab=0}
C {devices/gnd.sym} 4150 620 0 0 {name=s55 lab=0}
N 4120 470 4150 470 {lab=0}
C {devices/gnd.sym} 4150 470 0 0 {name=s56 lab=0}
N 4120 30 4120 10 {lab=VDD}
C {devices/vdd.sym} 4120 10 0 0 {name=s57 lab=VDD}
N 4120 60 4150 60 {lab=VDD}
C {devices/vdd.sym} 4150 60 0 0 {name=s58 lab=VDD}
N 4320 30 4320 10 {lab=VDD}
C {devices/vdd.sym} 4320 10 0 0 {name=s59 lab=VDD}
N 4320 60 4350 60 {lab=VDD}
C {devices/vdd.sym} 4350 60 0 0 {name=s60 lab=VDD}
N 4680 650 4680 670 {lab=0}
C {devices/gnd.sym} 4680 670 0 0 {name=s61 lab=0}
N 4680 620 4710 620 {lab=0}
C {devices/gnd.sym} 4710 620 0 0 {name=s62 lab=0}
N 4680 470 4710 470 {lab=0}
C {devices/gnd.sym} 4710 470 0 0 {name=s63 lab=0}
N 4680 30 4680 10 {lab=VDD}
C {devices/vdd.sym} 4680 10 0 0 {name=s64 lab=VDD}
N 4680 60 4710 60 {lab=VDD}
C {devices/vdd.sym} 4710 60 0 0 {name=s65 lab=VDD}
N 4880 30 4880 10 {lab=VDD}
C {devices/vdd.sym} 4880 10 0 0 {name=s66 lab=VDD}
N 4880 60 4910 60 {lab=VDD}
C {devices/vdd.sym} 4910 60 0 0 {name=s67 lab=VDD}
N 5240 650 5240 670 {lab=0}
C {devices/gnd.sym} 5240 670 0 0 {name=s68 lab=0}
N 5240 620 5270 620 {lab=0}
C {devices/gnd.sym} 5270 620 0 0 {name=s69 lab=0}
N 5240 470 5270 470 {lab=0}
C {devices/gnd.sym} 5270 470 0 0 {name=s70 lab=0}
N 5240 30 5240 10 {lab=VDD}
C {devices/vdd.sym} 5240 10 0 0 {name=s71 lab=VDD}
N 5240 60 5270 60 {lab=VDD}
C {devices/vdd.sym} 5270 60 0 0 {name=s72 lab=VDD}
N 5440 30 5440 10 {lab=VDD}
C {devices/vdd.sym} 5440 10 0 0 {name=s73 lab=VDD}
N 5440 60 5470 60 {lab=VDD}
C {devices/vdd.sym} 5470 60 0 0 {name=s74 lab=VDD}
N 1640 440 1640 430 {lab=mq}
N 1640 430 1840 430 {lab=mq}
N 1640 430 1640 100 {lab=mq}
N 1840 430 1840 440 {lab=mq}
N 1640 100 1840 100 {lab=mq}
N 1640 100 1640 90 {lab=mq}
N 1840 100 1840 90 {lab=mq}
N 1840 100 2040 100 {lab=mq}
N 2040 100 2240 100 {lab=mq}
N 2040 100 2040 90 {lab=mq}
N 2240 100 2240 470 {lab=mq}
N 2240 100 2240 90 {lab=mq}
N 2240 470 2550 470 {lab=mq}
N 2550 470 2550 510 {lab=mq}
N 2550 470 2560 470 {lab=mq}
N 2550 510 2640 510 {lab=mq}
N 2640 510 2640 470 {lab=mq}
N 2640 470 2750 470 {lab=mq}
N 2750 470 2750 430 {lab=mq}
N 2750 470 2760 470 {lab=mq}
N 2750 430 2840 430 {lab=mq}
N 2750 430 2750 100 {lab=mq}
N 2750 100 2840 100 {lab=mq}
N 2750 100 2750 60 {lab=mq}
N 2750 60 2760 60 {lab=mq}
N 2840 100 2840 60 {lab=mq}
N 2840 60 2960 60 {lab=mq}
N 2840 430 2840 470 {lab=mq}
N 2840 470 3510 470 {lab=mq}
N 3510 470 3510 430 {lab=mq}
N 3510 470 3520 470 {lab=mq}
N 3510 430 3600 430 {lab=mq}
N 3600 430 3600 60 {lab=mq}
N 3600 60 3720 60 {lab=mq}
N 1600 470 1590 470 {lab=mqb}
N 1590 470 1590 510 {lab=mqb}
N 1590 510 1680 510 {lab=mqb}
N 1680 510 1680 470 {lab=mqb}
N 1680 470 1790 470 {lab=mqb}
N 1790 470 1800 470 {lab=mqb}
N 1790 470 1790 420 {lab=mqb}
N 1790 420 1790 110 {lab=mqb}
N 1790 420 2600 420 {lab=mqb}
N 1790 110 1880 110 {lab=mqb}
N 1790 110 1790 60 {lab=mqb}
N 1790 60 1800 60 {lab=mqb}
N 1880 110 1880 60 {lab=mqb}
N 1880 60 2000 60 {lab=mqb}
N 2600 420 2600 440 {lab=mqb}
N 2600 420 2800 420 {lab=mqb}
N 2600 420 2600 110 {lab=mqb}
N 2800 420 2800 440 {lab=mqb}
N 2600 110 2600 90 {lab=mqb}
N 2600 110 2800 110 {lab=mqb}
N 2800 110 3000 110 {lab=mqb}
N 2800 110 2800 90 {lab=mqb}
N 3000 110 3000 100 {lab=mqb}
N 3000 100 3200 100 {lab=mqb}
N 3000 100 3000 90 {lab=mqb}
N 3200 100 3200 90 {lab=mqb}
N 520 440 560 440 {lab=g1}
N 520 440 520 100 {lab=g1}
N 520 100 720 100 {lab=g1}
N 520 100 520 90 {lab=g1}
N 720 100 720 90 {lab=g1}
N 720 100 1120 100 {lab=g1}
N 560 440 560 470 {lab=g1}
N 560 470 1030 470 {lab=g1}
N 1030 470 1030 510 {lab=g1}
N 1030 470 1040 470 {lab=g1}
N 1120 100 1120 60 {lab=g1}
N 1120 60 1230 60 {lab=g1}
N 1230 60 1230 100 {lab=g1}
N 1230 60 1240 60 {lab=g1}
N 1030 510 1120 510 {lab=g1}
N 1120 510 1120 620 {lab=g1}
N 1120 620 1590 620 {lab=g1}
N 1590 620 1590 580 {lab=g1}
N 1590 620 1600 620 {lab=g1}
N 1590 580 1680 580 {lab=g1}
N 1680 580 1680 620 {lab=g1}
N 1680 620 1800 620 {lab=g1}
N 1230 100 1320 100 {lab=g1}
N 1320 100 1320 60 {lab=g1}
N 1320 60 1590 60 {lab=g1}
N 1590 60 1590 0 {lab=g1}
N 1590 60 1600 60 {lab=g1}
N 1590 0 2080 0 {lab=g1}
N 2080 0 2080 60 {lab=g1}
N 2080 60 2200 60 {lab=g1}
N 120 620 110 620 {lab=clk}
N 110 620 -60 620 {lab=clk}
N 110 620 110 570 {lab=clk}
N -60 620 -60 420 {lab=clk}
N 110 570 2840 570 {lab=clk}
N 110 570 110 60 {lab=clk}
N 110 60 120 60 {lab=clk}
N 2840 570 2840 620 {lab=clk}
N 2840 620 3500 620 {lab=clk}
N 3500 620 3520 620 {lab=clk}
N 3500 620 3500 580 {lab=clk}
N 3500 580 3600 580 {lab=clk}
N 3500 580 3500 60 {lab=clk}
N 3500 60 3520 60 {lab=clk}
N 3600 580 3600 620 {lab=clk}
N 3600 620 4070 620 {lab=clk}
N 4070 620 4080 620 {lab=clk}
N 4070 620 4070 60 {lab=clk}
N 4070 60 4080 60 {lab=clk}
N 1080 440 1080 110 {lab=g2}
N 1080 440 1130 440 {lab=g2}
N 1080 110 1080 90 {lab=g2}
N 1080 110 1280 110 {lab=g2}
N 1280 110 1280 90 {lab=g2}
N 1130 440 1130 520 {lab=g2}
N 1130 520 1880 520 {lab=g2}
N 1880 520 1880 620 {lab=g2}
N 1880 620 2540 620 {lab=g2}
N 2540 620 2540 60 {lab=g2}
N 2540 620 2550 620 {lab=g2}
N 2550 620 2560 620 {lab=g2}
N 2550 620 2550 580 {lab=g2}
N 2550 580 2640 580 {lab=g2}
N 2640 580 2640 620 {lab=g2}
N 2640 620 2760 620 {lab=g2}
N 2540 60 2550 60 {lab=g2}
N 2550 60 2560 60 {lab=g2}
N 2550 60 2550 0 {lab=g2}
N 2550 0 3040 0 {lab=g2}
N 3040 0 3040 60 {lab=g2}
N 3040 60 3160 60 {lab=g2}
N 3560 440 3600 440 {lab=s1}
N 3560 440 3560 100 {lab=s1}
N 3560 100 3760 100 {lab=s1}
N 3560 100 3560 90 {lab=s1}
N 3760 100 4160 100 {lab=s1}
N 3760 100 3760 90 {lab=s1}
N 3600 440 3600 470 {lab=s1}
N 3600 470 4060 470 {lab=s1}
N 4060 470 4080 470 {lab=s1}
N 4060 470 4060 510 {lab=s1}
N 4160 100 4160 60 {lab=s1}
N 4160 60 4270 60 {lab=s1}
N 4270 60 4280 60 {lab=s1}
N 4270 60 4270 100 {lab=s1}
N 4060 510 4160 510 {lab=s1}
N 4160 510 4160 620 {lab=s1}
N 4160 620 4640 620 {lab=s1}
N 4270 100 4360 100 {lab=s1}
N 4360 100 4360 60 {lab=s1}
N 4360 60 4640 60 {lab=s1}
N 4680 440 4720 440 {lab=q}
N 4680 440 4680 100 {lab=q}
N 4680 100 4880 100 {lab=q}
N 4680 100 4680 90 {lab=q}
N 4880 100 4880 90 {lab=q}
N 4880 100 5280 100 {lab=q}
N 4720 440 4720 470 {lab=q}
N 4720 470 5190 470 {lab=q}
N 5190 470 5190 400 {lab=q}
N 5190 470 5200 470 {lab=q}
N 5280 100 5280 60 {lab=q}
N 5280 60 5400 60 {lab=q}
N 5190 400 5820 400 {lab=q}
N 160 590 160 90 {lab=clkn}
N 160 590 200 590 {lab=clkn}
N 200 590 200 620 {lab=clkn}
N 200 620 470 620 {lab=clkn}
N 470 620 470 580 {lab=clkn}
N 470 620 480 620 {lab=clkn}
N 160 90 200 90 {lab=clkn}
N 200 90 200 60 {lab=clkn}
N 200 60 480 60 {lab=clkn}
N 470 580 560 580 {lab=clkn}
N 560 580 560 620 {lab=clkn}
N 560 620 1020 620 {lab=clkn}
N 1020 620 1040 620 {lab=clkn}
N 1020 620 1020 60 {lab=clkn}
N 1020 60 1040 60 {lab=clkn}
N 4120 440 4120 430 {lab=s2}
N 4120 430 4120 110 {lab=s2}
N 4120 430 4730 430 {lab=s2}
N 4120 110 4120 90 {lab=s2}
N 4120 110 4320 110 {lab=s2}
N 4320 110 4320 90 {lab=s2}
N 4730 430 4730 620 {lab=s2}
N 4730 620 5180 620 {lab=s2}
N 5180 620 5200 620 {lab=s2}
N 5180 620 5180 60 {lab=s2}
N 5180 60 5200 60 {lab=s2}
N 4640 470 4630 470 {lab=sqb}
N 4630 470 4630 420 {lab=sqb}
N 4630 420 4720 420 {lab=sqb}
N 4720 420 4720 60 {lab=sqb}
N 4720 420 5240 420 {lab=sqb}
N 4720 60 4840 60 {lab=sqb}
N 5240 420 5240 440 {lab=sqb}
N 5240 420 5240 110 {lab=sqb}
N 5240 110 5440 110 {lab=sqb}
N 5240 110 5240 90 {lab=sqb}
N 5440 110 5440 90 {lab=sqb}
N 480 470 470 470 {lab=d}
N 470 470 470 430 {lab=d}
N 470 430 560 430 {lab=d}
N 470 430 470 380 {lab=d}
N 560 430 560 60 {lab=d}
N 560 60 680 60 {lab=d}
N 470 380 -60 380 {lab=d}
N 520 590 520 500 {lab=u_mg1.net_0}
N 1080 590 1080 500 {lab=u_mg2.net_0}
N 1640 590 1640 500 {lab=u_mfw.net_0_0}
N 1840 500 1840 590 {lab=u_mfw.net_0_1}
N 2600 590 2600 500 {lab=u_mkp.net_0_0}
N 2800 500 2800 590 {lab=u_mkp.net_0_1}
N 3560 590 3560 500 {lab=u_sg1.net_0}
N 4120 590 4120 500 {lab=u_sg2.net_0}
N 4680 590 4680 500 {lab=u_sfw.net_0}
N 5240 590 5240 500 {lab=u_skp.net_0}
C {devices/ipin.sym} -60 380 0 0 {name=p75 lab=d}
C {devices/ipin.sym} -60 420 0 0 {name=p76 lab=clk}
C {devices/opin.sym} 5820 400 0 0 {name=p77 lab=q}
C {devices/lab_pin.sym} 480 620 0 0 {name=l78 lab=clkn}
C {devices/lab_pin.sym} 1040 470 0 0 {name=l79 lab=g1}
C {devices/lab_pin.sym} 1600 470 0 0 {name=l80 lab=mqb}
C {devices/lab_pin.sym} 2560 620 0 0 {name=l81 lab=g2}
C {devices/lab_pin.sym} 2560 470 0 0 {name=l82 lab=mq}
C {devices/lab_pin.sym} 4080 470 0 0 {name=l83 lab=s1}
C {devices/lab_pin.sym} 4640 470 0 0 {name=l84 lab=sqb}
C {devices/lab_pin.sym} 5200 620 0 0 {name=l85 lab=s2}
