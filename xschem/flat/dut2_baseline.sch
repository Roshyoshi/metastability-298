v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {dut2_baseline: NAND flip-flop meta_dut_baseline at transistor level} 0 -230 0 0 0.45 0.45 {}
T {Baseline: forward gate u_mfw = nand2_2, keeper gate u_mkp = nand2_1.} 0 -190 0 0 0.26 0.26 {}
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
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2580 620 0 0 {name=Mu_mkp_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2580 470 0 0 {name=Mu_mkp_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2580 60 0 0 {name=Mu_mkp_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2780 60 0 0 {name=Mu_mkp_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3140 620 0 0 {name=Mu_sg1_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3140 470 0 0 {name=Mu_sg1_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3140 60 0 0 {name=Mu_sg1_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3340 60 0 0 {name=Mu_sg1_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3700 620 0 0 {name=Mu_sg2_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3700 470 0 0 {name=Mu_sg2_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3700 60 0 0 {name=Mu_sg2_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3900 60 0 0 {name=Mu_sg2_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4260 620 0 0 {name=Mu_sfw_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4260 470 0 0 {name=Mu_sfw_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4260 60 0 0 {name=Mu_sfw_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4460 60 0 0 {name=Mu_sfw_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4820 620 0 0 {name=Mu_skp_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4820 470 0 0 {name=Mu_skp_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4820 60 0 0 {name=Mu_skp_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5020 60 0 0 {name=Mu_skp_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
T {u_cki} 110 -35 0 0 0.3 0.3 {}
T {u_mg1} 470 -35 0 0 0.3 0.3 {}
T {u_mg2} 1030 -35 0 0 0.3 0.3 {}
T {u_mfw} 1590 -35 0 0 0.3 0.3 {}
T {u_mkp} 2550 -35 0 0 0.3 0.3 {}
T {u_sg1} 3110 -35 0 0 0.3 0.3 {}
T {u_sg2} 3670 -35 0 0 0.3 0.3 {}
T {u_sfw} 4230 -35 0 0 0.3 0.3 {}
T {u_skp} 4790 -35 0 0 0.3 0.3 {}
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
N 2600 30 2600 10 {lab=VDD}
C {devices/vdd.sym} 2600 10 0 0 {name=s36 lab=VDD}
N 2600 60 2630 60 {lab=VDD}
C {devices/vdd.sym} 2630 60 0 0 {name=s37 lab=VDD}
N 2800 30 2800 10 {lab=VDD}
C {devices/vdd.sym} 2800 10 0 0 {name=s38 lab=VDD}
N 2800 60 2830 60 {lab=VDD}
C {devices/vdd.sym} 2830 60 0 0 {name=s39 lab=VDD}
N 3160 650 3160 670 {lab=0}
C {devices/gnd.sym} 3160 670 0 0 {name=s40 lab=0}
N 3160 620 3190 620 {lab=0}
C {devices/gnd.sym} 3190 620 0 0 {name=s41 lab=0}
N 3160 470 3190 470 {lab=0}
C {devices/gnd.sym} 3190 470 0 0 {name=s42 lab=0}
N 3160 30 3160 10 {lab=VDD}
C {devices/vdd.sym} 3160 10 0 0 {name=s43 lab=VDD}
N 3160 60 3190 60 {lab=VDD}
C {devices/vdd.sym} 3190 60 0 0 {name=s44 lab=VDD}
N 3360 30 3360 10 {lab=VDD}
C {devices/vdd.sym} 3360 10 0 0 {name=s45 lab=VDD}
N 3360 60 3390 60 {lab=VDD}
C {devices/vdd.sym} 3390 60 0 0 {name=s46 lab=VDD}
N 3720 650 3720 670 {lab=0}
C {devices/gnd.sym} 3720 670 0 0 {name=s47 lab=0}
N 3720 620 3750 620 {lab=0}
C {devices/gnd.sym} 3750 620 0 0 {name=s48 lab=0}
N 3720 470 3750 470 {lab=0}
C {devices/gnd.sym} 3750 470 0 0 {name=s49 lab=0}
N 3720 30 3720 10 {lab=VDD}
C {devices/vdd.sym} 3720 10 0 0 {name=s50 lab=VDD}
N 3720 60 3750 60 {lab=VDD}
C {devices/vdd.sym} 3750 60 0 0 {name=s51 lab=VDD}
N 3920 30 3920 10 {lab=VDD}
C {devices/vdd.sym} 3920 10 0 0 {name=s52 lab=VDD}
N 3920 60 3950 60 {lab=VDD}
C {devices/vdd.sym} 3950 60 0 0 {name=s53 lab=VDD}
N 4280 650 4280 670 {lab=0}
C {devices/gnd.sym} 4280 670 0 0 {name=s54 lab=0}
N 4280 620 4310 620 {lab=0}
C {devices/gnd.sym} 4310 620 0 0 {name=s55 lab=0}
N 4280 470 4310 470 {lab=0}
C {devices/gnd.sym} 4310 470 0 0 {name=s56 lab=0}
N 4280 30 4280 10 {lab=VDD}
C {devices/vdd.sym} 4280 10 0 0 {name=s57 lab=VDD}
N 4280 60 4310 60 {lab=VDD}
C {devices/vdd.sym} 4310 60 0 0 {name=s58 lab=VDD}
N 4480 30 4480 10 {lab=VDD}
C {devices/vdd.sym} 4480 10 0 0 {name=s59 lab=VDD}
N 4480 60 4510 60 {lab=VDD}
C {devices/vdd.sym} 4510 60 0 0 {name=s60 lab=VDD}
N 4840 650 4840 670 {lab=0}
C {devices/gnd.sym} 4840 670 0 0 {name=s61 lab=0}
N 4840 620 4870 620 {lab=0}
C {devices/gnd.sym} 4870 620 0 0 {name=s62 lab=0}
N 4840 470 4870 470 {lab=0}
C {devices/gnd.sym} 4870 470 0 0 {name=s63 lab=0}
N 4840 30 4840 10 {lab=VDD}
C {devices/vdd.sym} 4840 10 0 0 {name=s64 lab=VDD}
N 4840 60 4870 60 {lab=VDD}
C {devices/vdd.sym} 4870 60 0 0 {name=s65 lab=VDD}
N 5040 30 5040 10 {lab=VDD}
C {devices/vdd.sym} 5040 10 0 0 {name=s66 lab=VDD}
N 5040 60 5070 60 {lab=VDD}
C {devices/vdd.sym} 5070 60 0 0 {name=s67 lab=VDD}
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
N 2240 100 2640 100 {lab=mq}
N 2240 100 2240 90 {lab=mq}
N 2240 470 2550 470 {lab=mq}
N 2550 470 2550 510 {lab=mq}
N 2550 470 2560 470 {lab=mq}
N 2640 100 2640 60 {lab=mq}
N 2640 60 2760 60 {lab=mq}
N 2550 510 2640 510 {lab=mq}
N 2640 510 2640 470 {lab=mq}
N 2640 470 3110 470 {lab=mq}
N 3110 470 3120 470 {lab=mq}
N 3110 470 3110 430 {lab=mq}
N 3110 430 3200 430 {lab=mq}
N 3200 430 3200 60 {lab=mq}
N 3200 60 3320 60 {lab=mq}
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
N 1120 60 1240 60 {lab=g1}
N 1030 510 1120 510 {lab=g1}
N 1120 510 1120 620 {lab=g1}
N 1120 620 1590 620 {lab=g1}
N 1590 620 1590 580 {lab=g1}
N 1590 620 1600 620 {lab=g1}
N 1590 580 1680 580 {lab=g1}
N 1590 580 1590 110 {lab=g1}
N 1680 580 1680 620 {lab=g1}
N 1680 620 1800 620 {lab=g1}
N 1590 110 1590 60 {lab=g1}
N 1590 110 2080 110 {lab=g1}
N 1590 60 1600 60 {lab=g1}
N 2080 110 2080 60 {lab=g1}
N 2080 60 2200 60 {lab=g1}
N 120 620 110 620 {lab=clk}
N 110 620 -60 620 {lab=clk}
N 110 620 110 570 {lab=clk}
N -60 620 -60 420 {lab=clk}
N 110 570 2640 570 {lab=clk}
N 110 570 110 60 {lab=clk}
N 110 60 120 60 {lab=clk}
N 2640 570 2640 620 {lab=clk}
N 2640 620 3100 620 {lab=clk}
N 3100 620 3120 620 {lab=clk}
N 3100 620 3100 580 {lab=clk}
N 3100 580 3100 60 {lab=clk}
N 3100 580 3200 580 {lab=clk}
N 3100 60 3120 60 {lab=clk}
N 3200 580 3200 620 {lab=clk}
N 3200 620 3670 620 {lab=clk}
N 3670 620 3680 620 {lab=clk}
N 3670 620 3670 60 {lab=clk}
N 3670 60 3680 60 {lab=clk}
N 1600 470 1580 470 {lab=mqb}
N 1580 470 1580 510 {lab=mqb}
N 1580 510 1680 510 {lab=mqb}
N 1680 510 1680 470 {lab=mqb}
N 1680 470 1790 470 {lab=mqb}
N 1790 470 1800 470 {lab=mqb}
N 1790 470 1790 420 {lab=mqb}
N 1790 420 1790 120 {lab=mqb}
N 1790 420 2600 420 {lab=mqb}
N 1790 120 1880 120 {lab=mqb}
N 1790 120 1790 60 {lab=mqb}
N 1790 60 1800 60 {lab=mqb}
N 1880 120 1880 60 {lab=mqb}
N 1880 60 2000 60 {lab=mqb}
N 2600 420 2600 440 {lab=mqb}
N 2600 420 2600 110 {lab=mqb}
N 2600 110 2600 90 {lab=mqb}
N 2600 110 2800 110 {lab=mqb}
N 2800 110 2800 90 {lab=mqb}
N 3160 440 3200 440 {lab=s1}
N 3160 440 3160 100 {lab=s1}
N 3160 100 3360 100 {lab=s1}
N 3160 100 3160 90 {lab=s1}
N 3360 100 3360 90 {lab=s1}
N 3360 100 3760 100 {lab=s1}
N 3200 440 3200 470 {lab=s1}
N 3200 470 3660 470 {lab=s1}
N 3660 470 3660 510 {lab=s1}
N 3660 470 3680 470 {lab=s1}
N 3760 100 3760 60 {lab=s1}
N 3760 60 3870 60 {lab=s1}
N 3870 60 3870 100 {lab=s1}
N 3870 60 3880 60 {lab=s1}
N 3660 510 3760 510 {lab=s1}
N 3760 510 3760 620 {lab=s1}
N 3760 620 4240 620 {lab=s1}
N 3870 100 3960 100 {lab=s1}
N 3960 100 3960 60 {lab=s1}
N 3960 60 4240 60 {lab=s1}
N 4280 440 4280 100 {lab=q}
N 4280 440 4320 440 {lab=q}
N 4280 100 4280 90 {lab=q}
N 4280 100 4480 100 {lab=q}
N 4480 100 4480 90 {lab=q}
N 4480 100 4880 100 {lab=q}
N 4320 440 4320 470 {lab=q}
N 4320 470 4790 470 {lab=q}
N 4790 470 4800 470 {lab=q}
N 4790 470 4790 400 {lab=q}
N 4880 100 4880 60 {lab=q}
N 4880 60 5000 60 {lab=q}
N 4790 400 5420 400 {lab=q}
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
N 2540 620 2560 620 {lab=g2}
N 2540 60 2560 60 {lab=g2}
N 3720 440 3720 430 {lab=s2}
N 3720 430 4330 430 {lab=s2}
N 3720 430 3720 110 {lab=s2}
N 3720 110 3920 110 {lab=s2}
N 3720 110 3720 90 {lab=s2}
N 3920 110 3920 90 {lab=s2}
N 4330 430 4330 620 {lab=s2}
N 4330 620 4780 620 {lab=s2}
N 4780 620 4800 620 {lab=s2}
N 4780 620 4780 60 {lab=s2}
N 4780 60 4800 60 {lab=s2}
N 4240 470 4230 470 {lab=sqb}
N 4230 470 4230 420 {lab=sqb}
N 4230 420 4320 420 {lab=sqb}
N 4320 420 4320 60 {lab=sqb}
N 4320 420 4840 420 {lab=sqb}
N 4320 60 4440 60 {lab=sqb}
N 4840 420 4840 110 {lab=sqb}
N 4840 420 4840 440 {lab=sqb}
N 4840 110 5040 110 {lab=sqb}
N 4840 110 4840 90 {lab=sqb}
N 5040 110 5040 90 {lab=sqb}
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
N 2600 590 2600 500 {lab=u_mkp.net_0}
N 3160 590 3160 500 {lab=u_sg1.net_0}
N 3720 590 3720 500 {lab=u_sg2.net_0}
N 4280 590 4280 500 {lab=u_sfw.net_0}
N 4840 590 4840 500 {lab=u_skp.net_0}
C {devices/ipin.sym} -60 380 0 0 {name=p68 lab=d}
C {devices/ipin.sym} -60 420 0 0 {name=p69 lab=clk}
C {devices/opin.sym} 5420 400 0 0 {name=p70 lab=q}
C {devices/lab_pin.sym} 480 620 0 0 {name=l71 lab=clkn}
C {devices/lab_pin.sym} 1040 470 0 0 {name=l72 lab=g1}
C {devices/lab_pin.sym} 1600 470 0 0 {name=l73 lab=mqb}
C {devices/lab_pin.sym} 2560 620 0 0 {name=l74 lab=g2}
C {devices/lab_pin.sym} 2560 470 0 0 {name=l75 lab=mq}
C {devices/lab_pin.sym} 3680 470 0 0 {name=l76 lab=s1}
C {devices/lab_pin.sym} 4240 470 0 0 {name=l77 lab=sqb}
C {devices/lab_pin.sym} 4800 620 0 0 {name=l78 lab=s2}
