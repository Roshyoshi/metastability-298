v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {dut4_forward: NAND flip-flop meta_dut_forward at transistor level} 0 -230 0 0 0.45 0.45 {}
T {Forward strengthened: u_mfw = nand2_4 (four copies in parallel), u_mkp = nand2_1.} 0 -190 0 0 0.26 0.26 {}
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
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1620 620 0 0 {name=Mu_mfw_i_1_3 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1620 470 0 0 {name=Mu_mfw_i_0_3 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1820 470 0 0 {name=Mu_mfw_i_0_2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1820 620 0 0 {name=Mu_mfw_i_1_2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2020 620 0 0 {name=Mu_mfw_i_1_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2020 470 0 0 {name=Mu_mfw_i_0_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2220 470 0 0 {name=Mu_mfw_i_0_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2220 620 0 0 {name=Mu_mfw_i_1_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1620 60 0 0 {name=Mu_mfw_i_3_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1820 60 0 0 {name=Mu_mfw_i_2_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2020 60 0 0 {name=Mu_mfw_i_2_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2220 60 0 0 {name=Mu_mfw_i_3_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2420 60 0 0 {name=Mu_mfw_i_3_1 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2620 60 0 0 {name=Mu_mfw_i_2_1 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2820 60 0 0 {name=Mu_mfw_i_2_0 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3020 60 0 0 {name=Mu_mfw_i_3_0 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3380 620 0 0 {name=Mu_mkp_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3380 470 0 0 {name=Mu_mkp_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3380 60 0 0 {name=Mu_mkp_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3580 60 0 0 {name=Mu_mkp_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3940 620 0 0 {name=Mu_sg1_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3940 470 0 0 {name=Mu_sg1_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3940 60 0 0 {name=Mu_sg1_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4140 60 0 0 {name=Mu_sg1_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4500 620 0 0 {name=Mu_sg2_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4500 470 0 0 {name=Mu_sg2_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4500 60 0 0 {name=Mu_sg2_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4700 60 0 0 {name=Mu_sg2_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5060 620 0 0 {name=Mu_sfw_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5060 470 0 0 {name=Mu_sfw_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5060 60 0 0 {name=Mu_sfw_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5260 60 0 0 {name=Mu_sfw_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5620 620 0 0 {name=Mu_skp_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5620 470 0 0 {name=Mu_skp_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5620 60 0 0 {name=Mu_skp_i_3 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5820 60 0 0 {name=Mu_skp_i_2 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
T {u_cki} 110 -35 0 0 0.3 0.3 {}
T {u_mg1} 470 -35 0 0 0.3 0.3 {}
T {u_mg2} 1030 -35 0 0 0.3 0.3 {}
T {u_mfw} 1590 -35 0 0 0.3 0.3 {}
T {u_mkp} 3350 -35 0 0 0.3 0.3 {}
T {u_sg1} 3910 -35 0 0 0.3 0.3 {}
T {u_sg2} 4470 -35 0 0 0.3 0.3 {}
T {u_sfw} 5030 -35 0 0 0.3 0.3 {}
T {u_skp} 5590 -35 0 0 0.3 0.3 {}
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
N 2040 650 2040 670 {lab=0}
C {devices/gnd.sym} 2040 670 0 0 {name=s25 lab=0}
N 2040 620 2070 620 {lab=0}
C {devices/gnd.sym} 2070 620 0 0 {name=s26 lab=0}
N 2040 470 2070 470 {lab=0}
C {devices/gnd.sym} 2070 470 0 0 {name=s27 lab=0}
N 2240 470 2270 470 {lab=0}
C {devices/gnd.sym} 2270 470 0 0 {name=s28 lab=0}
N 2240 650 2240 670 {lab=0}
C {devices/gnd.sym} 2240 670 0 0 {name=s29 lab=0}
N 2240 620 2270 620 {lab=0}
C {devices/gnd.sym} 2270 620 0 0 {name=s30 lab=0}
N 1640 30 1640 10 {lab=VDD}
C {devices/vdd.sym} 1640 10 0 0 {name=s31 lab=VDD}
N 1640 60 1670 60 {lab=VDD}
C {devices/vdd.sym} 1670 60 0 0 {name=s32 lab=VDD}
N 1840 30 1840 10 {lab=VDD}
C {devices/vdd.sym} 1840 10 0 0 {name=s33 lab=VDD}
N 1840 60 1870 60 {lab=VDD}
C {devices/vdd.sym} 1870 60 0 0 {name=s34 lab=VDD}
N 2040 30 2040 10 {lab=VDD}
C {devices/vdd.sym} 2040 10 0 0 {name=s35 lab=VDD}
N 2040 60 2070 60 {lab=VDD}
C {devices/vdd.sym} 2070 60 0 0 {name=s36 lab=VDD}
N 2240 30 2240 10 {lab=VDD}
C {devices/vdd.sym} 2240 10 0 0 {name=s37 lab=VDD}
N 2240 60 2270 60 {lab=VDD}
C {devices/vdd.sym} 2270 60 0 0 {name=s38 lab=VDD}
N 2440 30 2440 10 {lab=VDD}
C {devices/vdd.sym} 2440 10 0 0 {name=s39 lab=VDD}
N 2440 60 2470 60 {lab=VDD}
C {devices/vdd.sym} 2470 60 0 0 {name=s40 lab=VDD}
N 2640 30 2640 10 {lab=VDD}
C {devices/vdd.sym} 2640 10 0 0 {name=s41 lab=VDD}
N 2640 60 2670 60 {lab=VDD}
C {devices/vdd.sym} 2670 60 0 0 {name=s42 lab=VDD}
N 2840 30 2840 10 {lab=VDD}
C {devices/vdd.sym} 2840 10 0 0 {name=s43 lab=VDD}
N 2840 60 2870 60 {lab=VDD}
C {devices/vdd.sym} 2870 60 0 0 {name=s44 lab=VDD}
N 3040 30 3040 10 {lab=VDD}
C {devices/vdd.sym} 3040 10 0 0 {name=s45 lab=VDD}
N 3040 60 3070 60 {lab=VDD}
C {devices/vdd.sym} 3070 60 0 0 {name=s46 lab=VDD}
N 3400 650 3400 670 {lab=0}
C {devices/gnd.sym} 3400 670 0 0 {name=s47 lab=0}
N 3400 620 3430 620 {lab=0}
C {devices/gnd.sym} 3430 620 0 0 {name=s48 lab=0}
N 3400 470 3430 470 {lab=0}
C {devices/gnd.sym} 3430 470 0 0 {name=s49 lab=0}
N 3400 30 3400 10 {lab=VDD}
C {devices/vdd.sym} 3400 10 0 0 {name=s50 lab=VDD}
N 3400 60 3430 60 {lab=VDD}
C {devices/vdd.sym} 3430 60 0 0 {name=s51 lab=VDD}
N 3600 30 3600 10 {lab=VDD}
C {devices/vdd.sym} 3600 10 0 0 {name=s52 lab=VDD}
N 3600 60 3630 60 {lab=VDD}
C {devices/vdd.sym} 3630 60 0 0 {name=s53 lab=VDD}
N 3960 650 3960 670 {lab=0}
C {devices/gnd.sym} 3960 670 0 0 {name=s54 lab=0}
N 3960 620 3990 620 {lab=0}
C {devices/gnd.sym} 3990 620 0 0 {name=s55 lab=0}
N 3960 470 3990 470 {lab=0}
C {devices/gnd.sym} 3990 470 0 0 {name=s56 lab=0}
N 3960 30 3960 10 {lab=VDD}
C {devices/vdd.sym} 3960 10 0 0 {name=s57 lab=VDD}
N 3960 60 3990 60 {lab=VDD}
C {devices/vdd.sym} 3990 60 0 0 {name=s58 lab=VDD}
N 4160 30 4160 10 {lab=VDD}
C {devices/vdd.sym} 4160 10 0 0 {name=s59 lab=VDD}
N 4160 60 4190 60 {lab=VDD}
C {devices/vdd.sym} 4190 60 0 0 {name=s60 lab=VDD}
N 4520 650 4520 670 {lab=0}
C {devices/gnd.sym} 4520 670 0 0 {name=s61 lab=0}
N 4520 620 4550 620 {lab=0}
C {devices/gnd.sym} 4550 620 0 0 {name=s62 lab=0}
N 4520 470 4550 470 {lab=0}
C {devices/gnd.sym} 4550 470 0 0 {name=s63 lab=0}
N 4520 30 4520 10 {lab=VDD}
C {devices/vdd.sym} 4520 10 0 0 {name=s64 lab=VDD}
N 4520 60 4550 60 {lab=VDD}
C {devices/vdd.sym} 4550 60 0 0 {name=s65 lab=VDD}
N 4720 30 4720 10 {lab=VDD}
C {devices/vdd.sym} 4720 10 0 0 {name=s66 lab=VDD}
N 4720 60 4750 60 {lab=VDD}
C {devices/vdd.sym} 4750 60 0 0 {name=s67 lab=VDD}
N 5080 650 5080 670 {lab=0}
C {devices/gnd.sym} 5080 670 0 0 {name=s68 lab=0}
N 5080 620 5110 620 {lab=0}
C {devices/gnd.sym} 5110 620 0 0 {name=s69 lab=0}
N 5080 470 5110 470 {lab=0}
C {devices/gnd.sym} 5110 470 0 0 {name=s70 lab=0}
N 5080 30 5080 10 {lab=VDD}
C {devices/vdd.sym} 5080 10 0 0 {name=s71 lab=VDD}
N 5080 60 5110 60 {lab=VDD}
C {devices/vdd.sym} 5110 60 0 0 {name=s72 lab=VDD}
N 5280 30 5280 10 {lab=VDD}
C {devices/vdd.sym} 5280 10 0 0 {name=s73 lab=VDD}
N 5280 60 5310 60 {lab=VDD}
C {devices/vdd.sym} 5310 60 0 0 {name=s74 lab=VDD}
N 5640 650 5640 670 {lab=0}
C {devices/gnd.sym} 5640 670 0 0 {name=s75 lab=0}
N 5640 620 5670 620 {lab=0}
C {devices/gnd.sym} 5670 620 0 0 {name=s76 lab=0}
N 5640 470 5670 470 {lab=0}
C {devices/gnd.sym} 5670 470 0 0 {name=s77 lab=0}
N 5640 30 5640 10 {lab=VDD}
C {devices/vdd.sym} 5640 10 0 0 {name=s78 lab=VDD}
N 5640 60 5670 60 {lab=VDD}
C {devices/vdd.sym} 5670 60 0 0 {name=s79 lab=VDD}
N 5840 30 5840 10 {lab=VDD}
C {devices/vdd.sym} 5840 10 0 0 {name=s80 lab=VDD}
N 5840 60 5870 60 {lab=VDD}
C {devices/vdd.sym} 5870 60 0 0 {name=s81 lab=VDD}
N 1640 440 1640 430 {lab=mq}
N 1640 430 1840 430 {lab=mq}
N 1640 430 1640 100 {lab=mq}
N 1840 430 1840 440 {lab=mq}
N 1840 430 2040 430 {lab=mq}
N 1640 100 1840 100 {lab=mq}
N 1640 100 1640 90 {lab=mq}
N 2040 430 2240 430 {lab=mq}
N 2040 430 2040 440 {lab=mq}
N 1840 100 1840 90 {lab=mq}
N 1840 100 2040 100 {lab=mq}
N 2240 430 2240 440 {lab=mq}
N 2040 100 2240 100 {lab=mq}
N 2040 100 2040 90 {lab=mq}
N 2240 100 2440 100 {lab=mq}
N 2240 100 2240 90 {lab=mq}
N 2440 100 2640 100 {lab=mq}
N 2440 100 2440 90 {lab=mq}
N 2640 100 2840 100 {lab=mq}
N 2640 100 2640 90 {lab=mq}
N 2840 100 2840 90 {lab=mq}
N 2840 100 3040 100 {lab=mq}
N 3040 100 3440 100 {lab=mq}
N 3040 100 3040 90 {lab=mq}
N 3040 100 3040 470 {lab=mq}
N 3040 470 3350 470 {lab=mq}
N 3350 470 3360 470 {lab=mq}
N 3350 470 3350 510 {lab=mq}
N 3440 100 3440 60 {lab=mq}
N 3440 60 3560 60 {lab=mq}
N 3350 510 3440 510 {lab=mq}
N 3440 510 3440 470 {lab=mq}
N 3440 470 3910 470 {lab=mq}
N 3910 470 3920 470 {lab=mq}
N 3910 470 3910 430 {lab=mq}
N 3910 430 4000 430 {lab=mq}
N 4000 430 4000 60 {lab=mq}
N 4000 60 4120 60 {lab=mq}
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
N 1590 580 1590 60 {lab=g1}
N 1680 580 1680 620 {lab=g1}
N 1680 620 1790 620 {lab=g1}
N 1790 620 1800 620 {lab=g1}
N 1790 620 1790 580 {lab=g1}
N 1590 60 1600 60 {lab=g1}
N 1790 580 1880 580 {lab=g1}
N 1880 580 1880 620 {lab=g1}
N 1880 620 1990 620 {lab=g1}
N 1990 620 2000 620 {lab=g1}
N 1990 620 1990 580 {lab=g1}
N 1990 580 2080 580 {lab=g1}
N 2080 580 2080 620 {lab=g1}
N 2080 620 2190 620 {lab=g1}
N 2190 620 2190 110 {lab=g1}
N 2190 620 2200 620 {lab=g1}
N 2190 110 2190 60 {lab=g1}
N 2190 110 2280 110 {lab=g1}
N 2190 60 2200 60 {lab=g1}
N 2280 110 2280 60 {lab=g1}
N 2280 60 2390 60 {lab=g1}
N 2390 60 2400 60 {lab=g1}
N 2390 60 2390 0 {lab=g1}
N 2390 0 2880 0 {lab=g1}
N 2880 0 2880 60 {lab=g1}
N 2880 60 3000 60 {lab=g1}
N 1600 470 1580 470 {lab=mqb}
N 1580 470 1580 510 {lab=mqb}
N 1580 510 1680 510 {lab=mqb}
N 1680 510 1680 470 {lab=mqb}
N 1680 470 1790 470 {lab=mqb}
N 1790 470 1790 510 {lab=mqb}
N 1790 470 1800 470 {lab=mqb}
N 1790 470 1790 110 {lab=mqb}
N 1790 510 1880 510 {lab=mqb}
N 1880 510 1880 470 {lab=mqb}
N 1880 470 1990 470 {lab=mqb}
N 1990 470 1990 510 {lab=mqb}
N 1990 470 2000 470 {lab=mqb}
N 1990 510 2080 510 {lab=mqb}
N 2080 510 2080 470 {lab=mqb}
N 2080 470 2200 470 {lab=mqb}
N 1790 110 1880 110 {lab=mqb}
N 1790 110 1790 60 {lab=mqb}
N 1790 60 1800 60 {lab=mqb}
N 1880 110 1880 60 {lab=mqb}
N 1880 60 1990 60 {lab=mqb}
N 1990 60 2000 60 {lab=mqb}
N 1990 60 1990 -10 {lab=mqb}
N 1990 -10 2480 -10 {lab=mqb}
N 2480 -10 2480 60 {lab=mqb}
N 2480 -10 2680 -10 {lab=mqb}
N 2480 60 2600 60 {lab=mqb}
N 2680 -10 2680 60 {lab=mqb}
N 2680 60 2790 60 {lab=mqb}
N 2790 60 2800 60 {lab=mqb}
N 2790 60 2790 110 {lab=mqb}
N 2790 110 3400 110 {lab=mqb}
N 3400 110 3400 440 {lab=mqb}
N 3400 110 3400 90 {lab=mqb}
N 3400 110 3600 110 {lab=mqb}
N 3600 110 3600 90 {lab=mqb}
N 120 620 110 620 {lab=clk}
N 110 620 -60 620 {lab=clk}
N 110 620 110 570 {lab=clk}
N -60 620 -60 420 {lab=clk}
N 110 570 3440 570 {lab=clk}
N 110 570 110 60 {lab=clk}
N 110 60 120 60 {lab=clk}
N 3440 570 3440 620 {lab=clk}
N 3440 620 3900 620 {lab=clk}
N 3900 620 3900 580 {lab=clk}
N 3900 620 3920 620 {lab=clk}
N 3900 580 4000 580 {lab=clk}
N 3900 580 3900 60 {lab=clk}
N 3900 60 3920 60 {lab=clk}
N 4000 580 4000 620 {lab=clk}
N 4000 620 4470 620 {lab=clk}
N 4470 620 4480 620 {lab=clk}
N 4470 620 4470 60 {lab=clk}
N 4470 60 4480 60 {lab=clk}
N 3960 440 3960 100 {lab=s1}
N 3960 440 4000 440 {lab=s1}
N 3960 100 3960 90 {lab=s1}
N 3960 100 4160 100 {lab=s1}
N 4160 100 4560 100 {lab=s1}
N 4160 100 4160 90 {lab=s1}
N 4000 440 4000 470 {lab=s1}
N 4000 470 4460 470 {lab=s1}
N 4460 470 4460 510 {lab=s1}
N 4460 470 4480 470 {lab=s1}
N 4560 100 4560 60 {lab=s1}
N 4560 60 4670 60 {lab=s1}
N 4670 60 4670 100 {lab=s1}
N 4670 60 4680 60 {lab=s1}
N 4460 510 4560 510 {lab=s1}
N 4560 510 4560 620 {lab=s1}
N 4560 620 5040 620 {lab=s1}
N 4670 100 4760 100 {lab=s1}
N 4760 100 4760 60 {lab=s1}
N 4760 60 5040 60 {lab=s1}
N 5080 440 5120 440 {lab=q}
N 5080 440 5080 100 {lab=q}
N 5080 100 5280 100 {lab=q}
N 5080 100 5080 90 {lab=q}
N 5280 100 5280 90 {lab=q}
N 5280 100 5680 100 {lab=q}
N 5120 440 5120 470 {lab=q}
N 5120 470 5590 470 {lab=q}
N 5590 470 5600 470 {lab=q}
N 5590 470 5590 400 {lab=q}
N 5680 100 5680 60 {lab=q}
N 5680 60 5800 60 {lab=q}
N 5590 400 6220 400 {lab=q}
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
N 1080 440 1080 420 {lab=g2}
N 1080 420 2280 420 {lab=g2}
N 1080 420 1080 110 {lab=g2}
N 1080 110 1080 90 {lab=g2}
N 1080 110 1280 110 {lab=g2}
N 1280 110 1280 90 {lab=g2}
N 2280 420 2280 620 {lab=g2}
N 2280 620 3340 620 {lab=g2}
N 3340 620 3360 620 {lab=g2}
N 3340 620 3340 60 {lab=g2}
N 3340 60 3360 60 {lab=g2}
N 4520 440 4520 430 {lab=s2}
N 4520 430 5130 430 {lab=s2}
N 4520 430 4520 110 {lab=s2}
N 4520 110 4520 90 {lab=s2}
N 4520 110 4720 110 {lab=s2}
N 4720 110 4720 90 {lab=s2}
N 5130 430 5130 620 {lab=s2}
N 5130 620 5580 620 {lab=s2}
N 5580 620 5580 60 {lab=s2}
N 5580 620 5600 620 {lab=s2}
N 5580 60 5600 60 {lab=s2}
N 5040 470 5030 470 {lab=sqb}
N 5030 470 5030 420 {lab=sqb}
N 5030 420 5120 420 {lab=sqb}
N 5120 420 5640 420 {lab=sqb}
N 5120 420 5120 60 {lab=sqb}
N 5120 60 5240 60 {lab=sqb}
N 5640 420 5640 440 {lab=sqb}
N 5640 420 5640 110 {lab=sqb}
N 5640 110 5840 110 {lab=sqb}
N 5640 110 5640 90 {lab=sqb}
N 5840 110 5840 90 {lab=sqb}
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
N 2040 590 2040 500 {lab=u_mfw.net_0_2}
N 2240 500 2240 590 {lab=u_mfw.net_0_3}
N 3400 590 3400 500 {lab=u_mkp.net_0}
N 3960 590 3960 500 {lab=u_sg1.net_0}
N 4520 590 4520 500 {lab=u_sg2.net_0}
N 5080 590 5080 500 {lab=u_sfw.net_0}
N 5640 590 5640 500 {lab=u_skp.net_0}
C {devices/ipin.sym} -60 380 0 0 {name=p82 lab=d}
C {devices/ipin.sym} -60 420 0 0 {name=p83 lab=clk}
C {devices/opin.sym} 6220 400 0 0 {name=p84 lab=q}
C {devices/lab_pin.sym} 480 620 0 0 {name=l85 lab=clkn}
C {devices/lab_pin.sym} 1040 470 0 0 {name=l86 lab=g1}
C {devices/lab_pin.sym} 1600 470 0 0 {name=l87 lab=mqb}
C {devices/lab_pin.sym} 3360 620 0 0 {name=l88 lab=g2}
C {devices/lab_pin.sym} 3360 470 0 0 {name=l89 lab=mq}
C {devices/lab_pin.sym} 4480 470 0 0 {name=l90 lab=s1}
C {devices/lab_pin.sym} 5040 470 0 0 {name=l91 lab=sqb}
C {devices/lab_pin.sym} 5600 620 0 0 {name=l92 lab=s2}
