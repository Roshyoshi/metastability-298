v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {ctrl_status: controller block "status" at transistor level (5 cells)} 0 -230 0 0 0.45 0.45 {}
T {Status: fault takes fault OR bad_bit on each count; done takes n_16 on b falling; busy = run AND NOT done} 0 -190 0 0 0.26 0.26 {}
T {From src/gf180/compact_control.v; every cell opened up. Stage labels are the cell instance names.} 0 -162 0 0 0.26 0.26 {}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2340 770 0 0 {name=Mbusy_and_i_2 L=0.6u W=0.365u nf=1 m=1 ad=1.825e-13 as=1.825e-13 pd=1.73e-06 ps=1.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2340 920 0 0 {name=Mbusy_and_i_3 L=0.6u W=0.365u nf=1 m=1 ad=1.825e-13 as=1.825e-13 pd=1.73e-06 ps=1.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2900 920 0 0 {name=Mbusy_and_i_0 L=0.6u W=0.815u nf=1 m=1 ad=4.075e-13 as=4.075e-13 pd=2.63e-06 ps=2.63e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2340 60 0 0 {name=Mbusy_and_i_4 L=0.5u W=0.6u nf=1 m=1 ad=3e-13 as=3e-13 pd=2.2e-06 ps=2.2e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2540 60 0 0 {name=Mbusy_and_i_5 L=0.5u W=0.6u nf=1 m=1 ad=3e-13 as=3e-13 pd=2.2e-06 ps=2.2e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2900 60 0 0 {name=Mbusy_and_i_1 L=0.5u W=1.215u nf=1 m=1 ad=6.075e-13 as=6.075e-13 pd=3.43e-06 ps=3.43e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 920 0 0 {name=Mdone_ff_tn13 L=0.6u W=0.405u nf=1 m=1 ad=2.025e-13 as=2.025e-13 pd=1.81e-06 ps=1.81e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 860 920 0 0 {name=Mdone_ff_tn10 L=0.6u W=0.405u nf=1 m=1 ad=2.025e-13 as=2.025e-13 pd=1.81e-06 ps=1.81e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1580 920 0 0 {name=Mdone_ff_tn11 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1580 770 0 0 {name=Mdone_ff_tn15 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1780 620 0 0 {name=Mdone_ff_tn14 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1780 770 0 0 {name=Mdone_ff_tn8 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1780 920 0 0 {name=Mdone_ff_tn9 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3820 920 0 0 {name=Mdone_ff_tn18 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3820 770 0 0 {name=Mdone_ff_tn0 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4020 770 0 0 {name=Mdone_ff_tn1 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4020 920 0 0 {name=Mdone_ff_tn12 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3260 920 0 0 {name=Mdone_ff_tn5 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3260 770 0 0 {name=Mdone_ff_tn4 L=0.6u W=0.4u nf=1 m=1 ad=2e-13 as=2e-13 pd=1.8e-06 ps=1.8e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4380 920 0 0 {name=Mdone_ff_tn3 L=0.6u W=0.795u nf=1 m=1 ad=3.975e-13 as=3.975e-13 pd=2.59e-06 ps=2.59e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=Mdone_ff_tp11 L=0.5u W=0.865u nf=1 m=1 ad=4.325e-13 as=4.325e-13 pd=2.73e-06 ps=2.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 860 60 0 0 {name=Mdone_ff_tp8 L=0.5u W=0.865u nf=1 m=1 ad=4.325e-13 as=4.325e-13 pd=2.73e-06 ps=2.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1580 60 0 0 {name=Mdone_ff_tp9 L=0.5u W=0.76u nf=1 m=1 ad=3.8e-13 as=3.8e-13 pd=2.52e-06 ps=2.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1580 210 0 0 {name=Mdone_ff_tp15 L=0.5u W=0.76u nf=1 m=1 ad=3.8e-13 as=3.8e-13 pd=2.52e-06 ps=2.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1980 210 0 0 {name=Mdone_ff_tp7 L=0.5u W=0.76u nf=1 m=1 ad=3.8e-13 as=3.8e-13 pd=2.52e-06 ps=2.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1780 60 0 0 {name=Mdone_ff_tp6 L=0.5u W=0.76u nf=1 m=1 ad=3.8e-13 as=3.8e-13 pd=2.52e-06 ps=2.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1980 60 0 0 {name=Mdone_ff_tp12 L=0.5u W=0.76u nf=1 m=1 ad=3.8e-13 as=3.8e-13 pd=2.52e-06 ps=2.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3820 60 0 0 {name=Mdone_ff_tp18 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3820 210 0 0 {name=Mdone_ff_tp2 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4020 210 0 0 {name=Mdone_ff_tp3 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4020 60 0 0 {name=Mdone_ff_tp10 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3260 60 0 0 {name=Mdone_ff_tp5 L=0.5u W=0.94u nf=1 m=1 ad=4.7e-13 as=4.7e-13 pd=2.88e-06 ps=2.88e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3460 60 0 0 {name=Mdone_ff_tp4 L=0.5u W=0.94u nf=1 m=1 ad=4.7e-13 as=4.7e-13 pd=2.88e-06 ps=2.88e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4380 60 0 0 {name=Mdone_ff_tp1 L=0.5u W=1.175u nf=1 m=1 ad=5.875e-13 as=5.875e-13 pd=3.35e-06 ps=3.35e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4740 920 0 0 {name=Mdone_inv_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4740 60 0 0 {name=Mdone_inv_i_1 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 500 920 0 0 {name=Mfault_ff_tn13 L=0.6u W=0.405u nf=1 m=1 ad=2.025e-13 as=2.025e-13 pd=1.81e-06 ps=1.81e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1220 920 0 0 {name=Mfault_ff_tn10 L=0.6u W=0.405u nf=1 m=1 ad=2.025e-13 as=2.025e-13 pd=1.81e-06 ps=1.81e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6940 920 0 0 {name=Mfault_ff_tn11 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6940 770 0 0 {name=Mfault_ff_tn15 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 7140 620 0 0 {name=Mfault_ff_tn14 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 7140 770 0 0 {name=Mfault_ff_tn8 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 7140 920 0 0 {name=Mfault_ff_tn9 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 7700 920 0 0 {name=Mfault_ff_tn18 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 7700 770 0 0 {name=Mfault_ff_tn0 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 7900 770 0 0 {name=Mfault_ff_tn1 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 7900 920 0 0 {name=Mfault_ff_tn12 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5100 920 0 0 {name=Mfault_ff_tn5 L=0.6u W=0.39u nf=1 m=1 ad=1.95e-13 as=1.95e-13 pd=1.78e-06 ps=1.78e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5100 770 0 0 {name=Mfault_ff_tn4 L=0.6u W=0.4u nf=1 m=1 ad=2e-13 as=2e-13 pd=1.8e-06 ps=1.8e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5660 920 0 0 {name=Mfault_ff_tn3 L=0.6u W=0.795u nf=1 m=1 ad=3.975e-13 as=3.975e-13 pd=2.59e-06 ps=2.59e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 500 60 0 0 {name=Mfault_ff_tp11 L=0.5u W=0.865u nf=1 m=1 ad=4.325e-13 as=4.325e-13 pd=2.73e-06 ps=2.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1220 60 0 0 {name=Mfault_ff_tp8 L=0.5u W=0.865u nf=1 m=1 ad=4.325e-13 as=4.325e-13 pd=2.73e-06 ps=2.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6940 60 0 0 {name=Mfault_ff_tp9 L=0.5u W=0.76u nf=1 m=1 ad=3.8e-13 as=3.8e-13 pd=2.52e-06 ps=2.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6940 210 0 0 {name=Mfault_ff_tp15 L=0.5u W=0.76u nf=1 m=1 ad=3.8e-13 as=3.8e-13 pd=2.52e-06 ps=2.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 7340 210 0 0 {name=Mfault_ff_tp7 L=0.5u W=0.76u nf=1 m=1 ad=3.8e-13 as=3.8e-13 pd=2.52e-06 ps=2.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 7140 60 0 0 {name=Mfault_ff_tp6 L=0.5u W=0.76u nf=1 m=1 ad=3.8e-13 as=3.8e-13 pd=2.52e-06 ps=2.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 7340 60 0 0 {name=Mfault_ff_tp12 L=0.5u W=0.76u nf=1 m=1 ad=3.8e-13 as=3.8e-13 pd=2.52e-06 ps=2.52e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 7700 60 0 0 {name=Mfault_ff_tp18 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 7700 210 0 0 {name=Mfault_ff_tp2 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 7900 210 0 0 {name=Mfault_ff_tp3 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 7900 60 0 0 {name=Mfault_ff_tp10 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5100 60 0 0 {name=Mfault_ff_tp5 L=0.5u W=0.94u nf=1 m=1 ad=4.7e-13 as=4.7e-13 pd=2.88e-06 ps=2.88e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5300 60 0 0 {name=Mfault_ff_tp4 L=0.5u W=0.94u nf=1 m=1 ad=4.7e-13 as=4.7e-13 pd=2.88e-06 ps=2.88e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5660 60 0 0 {name=Mfault_ff_tp1 L=0.5u W=1.175u nf=1 m=1 ad=5.875e-13 as=5.875e-13 pd=3.35e-06 ps=3.35e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6020 920 0 0 {name=Mfault_or_i_2 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6220 920 0 0 {name=Mfault_or_i_3 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6580 920 0 0 {name=Mfault_or_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6020 210 0 0 {name=Mfault_or_i_4 L=0.5u W=0.565u nf=1 m=1 ad=2.825e-13 as=2.825e-13 pd=2.13e-06 ps=2.13e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6020 60 0 0 {name=Mfault_or_i_5 L=0.5u W=0.565u nf=1 m=1 ad=2.825e-13 as=2.825e-13 pd=2.13e-06 ps=2.13e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6580 60 0 0 {name=Mfault_or_i_1 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
T {busy_and} 2310 -35 0 0 0.3 0.3 {}
T {done_ff} 110 -35 0 0 0.3 0.3 {}
T {done_inv} 4710 -35 0 0 0.3 0.3 {}
T {fault_ff} 470 -35 0 0 0.3 0.3 {}
T {fault_or} 5990 -35 0 0 0.3 0.3 {}
N 2360 770 2390 770 {lab=0}
C {devices/gnd.sym} 2390 770 0 0 {name=s1 lab=0}
N 2360 950 2360 970 {lab=0}
C {devices/gnd.sym} 2360 970 0 0 {name=s2 lab=0}
N 2360 920 2390 920 {lab=0}
C {devices/gnd.sym} 2390 920 0 0 {name=s3 lab=0}
N 2920 950 2920 970 {lab=0}
C {devices/gnd.sym} 2920 970 0 0 {name=s4 lab=0}
N 2920 920 2950 920 {lab=0}
C {devices/gnd.sym} 2950 920 0 0 {name=s5 lab=0}
N 2360 30 2360 10 {lab=VDD}
C {devices/vdd.sym} 2360 10 0 0 {name=s6 lab=VDD}
N 2360 60 2390 60 {lab=VDD}
C {devices/vdd.sym} 2390 60 0 0 {name=s7 lab=VDD}
N 2560 30 2560 10 {lab=VDD}
C {devices/vdd.sym} 2560 10 0 0 {name=s8 lab=VDD}
N 2560 60 2590 60 {lab=VDD}
C {devices/vdd.sym} 2590 60 0 0 {name=s9 lab=VDD}
N 2920 30 2920 10 {lab=VDD}
C {devices/vdd.sym} 2920 10 0 0 {name=s10 lab=VDD}
N 2920 60 2950 60 {lab=VDD}
C {devices/vdd.sym} 2950 60 0 0 {name=s11 lab=VDD}
N 160 950 160 970 {lab=0}
C {devices/gnd.sym} 160 970 0 0 {name=s12 lab=0}
N 160 920 190 920 {lab=0}
C {devices/gnd.sym} 190 920 0 0 {name=s13 lab=0}
N 880 950 880 970 {lab=0}
C {devices/gnd.sym} 880 970 0 0 {name=s14 lab=0}
N 880 920 910 920 {lab=0}
C {devices/gnd.sym} 910 920 0 0 {name=s15 lab=0}
N 1600 950 1600 970 {lab=0}
C {devices/gnd.sym} 1600 970 0 0 {name=s16 lab=0}
N 1600 920 1630 920 {lab=0}
C {devices/gnd.sym} 1630 920 0 0 {name=s17 lab=0}
N 1600 770 1630 770 {lab=0}
C {devices/gnd.sym} 1630 770 0 0 {name=s18 lab=0}
N 1800 620 1830 620 {lab=0}
C {devices/gnd.sym} 1830 620 0 0 {name=s19 lab=0}
N 1800 770 1830 770 {lab=0}
C {devices/gnd.sym} 1830 770 0 0 {name=s20 lab=0}
N 1800 950 1800 970 {lab=0}
C {devices/gnd.sym} 1800 970 0 0 {name=s21 lab=0}
N 1800 920 1830 920 {lab=0}
C {devices/gnd.sym} 1830 920 0 0 {name=s22 lab=0}
N 3840 950 3840 970 {lab=0}
C {devices/gnd.sym} 3840 970 0 0 {name=s23 lab=0}
N 3840 920 3870 920 {lab=0}
C {devices/gnd.sym} 3870 920 0 0 {name=s24 lab=0}
N 3840 770 3870 770 {lab=0}
C {devices/gnd.sym} 3870 770 0 0 {name=s25 lab=0}
N 4040 770 4070 770 {lab=0}
C {devices/gnd.sym} 4070 770 0 0 {name=s26 lab=0}
N 4040 950 4040 970 {lab=0}
C {devices/gnd.sym} 4040 970 0 0 {name=s27 lab=0}
N 4040 920 4070 920 {lab=0}
C {devices/gnd.sym} 4070 920 0 0 {name=s28 lab=0}
N 3280 950 3280 970 {lab=0}
C {devices/gnd.sym} 3280 970 0 0 {name=s29 lab=0}
N 3280 920 3310 920 {lab=0}
C {devices/gnd.sym} 3310 920 0 0 {name=s30 lab=0}
N 3280 770 3310 770 {lab=0}
C {devices/gnd.sym} 3310 770 0 0 {name=s31 lab=0}
N 4400 950 4400 970 {lab=0}
C {devices/gnd.sym} 4400 970 0 0 {name=s32 lab=0}
N 4400 920 4430 920 {lab=0}
C {devices/gnd.sym} 4430 920 0 0 {name=s33 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s34 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s35 lab=VDD}
N 880 30 880 10 {lab=VDD}
C {devices/vdd.sym} 880 10 0 0 {name=s36 lab=VDD}
N 880 60 910 60 {lab=VDD}
C {devices/vdd.sym} 910 60 0 0 {name=s37 lab=VDD}
N 1600 30 1600 10 {lab=VDD}
C {devices/vdd.sym} 1600 10 0 0 {name=s38 lab=VDD}
N 1600 60 1630 60 {lab=VDD}
C {devices/vdd.sym} 1630 60 0 0 {name=s39 lab=VDD}
N 1600 210 1630 210 {lab=VDD}
C {devices/vdd.sym} 1630 210 0 0 {name=s40 lab=VDD}
N 2000 210 2030 210 {lab=VDD}
C {devices/vdd.sym} 2030 210 0 0 {name=s41 lab=VDD}
N 1800 30 1800 10 {lab=VDD}
C {devices/vdd.sym} 1800 10 0 0 {name=s42 lab=VDD}
N 1800 60 1830 60 {lab=VDD}
C {devices/vdd.sym} 1830 60 0 0 {name=s43 lab=VDD}
N 2000 30 2000 10 {lab=VDD}
C {devices/vdd.sym} 2000 10 0 0 {name=s44 lab=VDD}
N 2000 60 2030 60 {lab=VDD}
C {devices/vdd.sym} 2030 60 0 0 {name=s45 lab=VDD}
N 3840 30 3840 10 {lab=VDD}
C {devices/vdd.sym} 3840 10 0 0 {name=s46 lab=VDD}
N 3840 60 3870 60 {lab=VDD}
C {devices/vdd.sym} 3870 60 0 0 {name=s47 lab=VDD}
N 3840 210 3870 210 {lab=VDD}
C {devices/vdd.sym} 3870 210 0 0 {name=s48 lab=VDD}
N 4040 210 4070 210 {lab=VDD}
C {devices/vdd.sym} 4070 210 0 0 {name=s49 lab=VDD}
N 4040 30 4040 10 {lab=VDD}
C {devices/vdd.sym} 4040 10 0 0 {name=s50 lab=VDD}
N 4040 60 4070 60 {lab=VDD}
C {devices/vdd.sym} 4070 60 0 0 {name=s51 lab=VDD}
N 3280 30 3280 10 {lab=VDD}
C {devices/vdd.sym} 3280 10 0 0 {name=s52 lab=VDD}
N 3280 60 3310 60 {lab=VDD}
C {devices/vdd.sym} 3310 60 0 0 {name=s53 lab=VDD}
N 3480 30 3480 10 {lab=VDD}
C {devices/vdd.sym} 3480 10 0 0 {name=s54 lab=VDD}
N 3480 60 3510 60 {lab=VDD}
C {devices/vdd.sym} 3510 60 0 0 {name=s55 lab=VDD}
N 4400 30 4400 10 {lab=VDD}
C {devices/vdd.sym} 4400 10 0 0 {name=s56 lab=VDD}
N 4400 60 4430 60 {lab=VDD}
C {devices/vdd.sym} 4430 60 0 0 {name=s57 lab=VDD}
N 4760 950 4760 970 {lab=0}
C {devices/gnd.sym} 4760 970 0 0 {name=s58 lab=0}
N 4760 920 4790 920 {lab=0}
C {devices/gnd.sym} 4790 920 0 0 {name=s59 lab=0}
N 4760 30 4760 10 {lab=VDD}
C {devices/vdd.sym} 4760 10 0 0 {name=s60 lab=VDD}
N 4760 60 4790 60 {lab=VDD}
C {devices/vdd.sym} 4790 60 0 0 {name=s61 lab=VDD}
N 520 950 520 970 {lab=0}
C {devices/gnd.sym} 520 970 0 0 {name=s62 lab=0}
N 520 920 550 920 {lab=0}
C {devices/gnd.sym} 550 920 0 0 {name=s63 lab=0}
N 1240 950 1240 970 {lab=0}
C {devices/gnd.sym} 1240 970 0 0 {name=s64 lab=0}
N 1240 920 1270 920 {lab=0}
C {devices/gnd.sym} 1270 920 0 0 {name=s65 lab=0}
N 6960 950 6960 970 {lab=0}
C {devices/gnd.sym} 6960 970 0 0 {name=s66 lab=0}
N 6960 920 6990 920 {lab=0}
C {devices/gnd.sym} 6990 920 0 0 {name=s67 lab=0}
N 6960 770 6990 770 {lab=0}
C {devices/gnd.sym} 6990 770 0 0 {name=s68 lab=0}
N 7160 620 7190 620 {lab=0}
C {devices/gnd.sym} 7190 620 0 0 {name=s69 lab=0}
N 7160 770 7190 770 {lab=0}
C {devices/gnd.sym} 7190 770 0 0 {name=s70 lab=0}
N 7160 950 7160 970 {lab=0}
C {devices/gnd.sym} 7160 970 0 0 {name=s71 lab=0}
N 7160 920 7190 920 {lab=0}
C {devices/gnd.sym} 7190 920 0 0 {name=s72 lab=0}
N 7720 950 7720 970 {lab=0}
C {devices/gnd.sym} 7720 970 0 0 {name=s73 lab=0}
N 7720 920 7750 920 {lab=0}
C {devices/gnd.sym} 7750 920 0 0 {name=s74 lab=0}
N 7720 770 7750 770 {lab=0}
C {devices/gnd.sym} 7750 770 0 0 {name=s75 lab=0}
N 7920 770 7950 770 {lab=0}
C {devices/gnd.sym} 7950 770 0 0 {name=s76 lab=0}
N 7920 950 7920 970 {lab=0}
C {devices/gnd.sym} 7920 970 0 0 {name=s77 lab=0}
N 7920 920 7950 920 {lab=0}
C {devices/gnd.sym} 7950 920 0 0 {name=s78 lab=0}
N 5120 950 5120 970 {lab=0}
C {devices/gnd.sym} 5120 970 0 0 {name=s79 lab=0}
N 5120 920 5150 920 {lab=0}
C {devices/gnd.sym} 5150 920 0 0 {name=s80 lab=0}
N 5120 770 5150 770 {lab=0}
C {devices/gnd.sym} 5150 770 0 0 {name=s81 lab=0}
N 5680 950 5680 970 {lab=0}
C {devices/gnd.sym} 5680 970 0 0 {name=s82 lab=0}
N 5680 920 5710 920 {lab=0}
C {devices/gnd.sym} 5710 920 0 0 {name=s83 lab=0}
N 520 30 520 10 {lab=VDD}
C {devices/vdd.sym} 520 10 0 0 {name=s84 lab=VDD}
N 520 60 550 60 {lab=VDD}
C {devices/vdd.sym} 550 60 0 0 {name=s85 lab=VDD}
N 1240 30 1240 10 {lab=VDD}
C {devices/vdd.sym} 1240 10 0 0 {name=s86 lab=VDD}
N 1240 60 1270 60 {lab=VDD}
C {devices/vdd.sym} 1270 60 0 0 {name=s87 lab=VDD}
N 6960 30 6960 10 {lab=VDD}
C {devices/vdd.sym} 6960 10 0 0 {name=s88 lab=VDD}
N 6960 60 6990 60 {lab=VDD}
C {devices/vdd.sym} 6990 60 0 0 {name=s89 lab=VDD}
N 6960 210 6990 210 {lab=VDD}
C {devices/vdd.sym} 6990 210 0 0 {name=s90 lab=VDD}
N 7360 210 7390 210 {lab=VDD}
C {devices/vdd.sym} 7390 210 0 0 {name=s91 lab=VDD}
N 7160 30 7160 10 {lab=VDD}
C {devices/vdd.sym} 7160 10 0 0 {name=s92 lab=VDD}
N 7160 60 7190 60 {lab=VDD}
C {devices/vdd.sym} 7190 60 0 0 {name=s93 lab=VDD}
N 7360 30 7360 10 {lab=VDD}
C {devices/vdd.sym} 7360 10 0 0 {name=s94 lab=VDD}
N 7360 60 7390 60 {lab=VDD}
C {devices/vdd.sym} 7390 60 0 0 {name=s95 lab=VDD}
N 7720 30 7720 10 {lab=VDD}
C {devices/vdd.sym} 7720 10 0 0 {name=s96 lab=VDD}
N 7720 60 7750 60 {lab=VDD}
C {devices/vdd.sym} 7750 60 0 0 {name=s97 lab=VDD}
N 7720 210 7750 210 {lab=VDD}
C {devices/vdd.sym} 7750 210 0 0 {name=s98 lab=VDD}
N 7920 210 7950 210 {lab=VDD}
C {devices/vdd.sym} 7950 210 0 0 {name=s99 lab=VDD}
N 7920 30 7920 10 {lab=VDD}
C {devices/vdd.sym} 7920 10 0 0 {name=s100 lab=VDD}
N 7920 60 7950 60 {lab=VDD}
C {devices/vdd.sym} 7950 60 0 0 {name=s101 lab=VDD}
N 5120 30 5120 10 {lab=VDD}
C {devices/vdd.sym} 5120 10 0 0 {name=s102 lab=VDD}
N 5120 60 5150 60 {lab=VDD}
C {devices/vdd.sym} 5150 60 0 0 {name=s103 lab=VDD}
N 5320 30 5320 10 {lab=VDD}
C {devices/vdd.sym} 5320 10 0 0 {name=s104 lab=VDD}
N 5320 60 5350 60 {lab=VDD}
C {devices/vdd.sym} 5350 60 0 0 {name=s105 lab=VDD}
N 5680 30 5680 10 {lab=VDD}
C {devices/vdd.sym} 5680 10 0 0 {name=s106 lab=VDD}
N 5680 60 5710 60 {lab=VDD}
C {devices/vdd.sym} 5710 60 0 0 {name=s107 lab=VDD}
N 6040 950 6040 970 {lab=0}
C {devices/gnd.sym} 6040 970 0 0 {name=s108 lab=0}
N 6040 920 6070 920 {lab=0}
C {devices/gnd.sym} 6070 920 0 0 {name=s109 lab=0}
N 6240 950 6240 970 {lab=0}
C {devices/gnd.sym} 6240 970 0 0 {name=s110 lab=0}
N 6240 920 6270 920 {lab=0}
C {devices/gnd.sym} 6270 920 0 0 {name=s111 lab=0}
N 6600 950 6600 970 {lab=0}
C {devices/gnd.sym} 6600 970 0 0 {name=s112 lab=0}
N 6600 920 6630 920 {lab=0}
C {devices/gnd.sym} 6630 920 0 0 {name=s113 lab=0}
N 6040 210 6070 210 {lab=VDD}
C {devices/vdd.sym} 6070 210 0 0 {name=s114 lab=VDD}
N 6040 30 6040 10 {lab=VDD}
C {devices/vdd.sym} 6040 10 0 0 {name=s115 lab=VDD}
N 6040 60 6070 60 {lab=VDD}
C {devices/vdd.sym} 6070 60 0 0 {name=s116 lab=VDD}
N 6600 30 6600 10 {lab=VDD}
C {devices/vdd.sym} 6600 10 0 0 {name=s117 lab=VDD}
N 6600 60 6630 60 {lab=VDD}
C {devices/vdd.sym} 6630 60 0 0 {name=s118 lab=VDD}
N 2320 770 2310 770 {lab=run}
N 2310 770 2310 730 {lab=run}
N 2310 730 1750 730 {lab=run}
N 2310 730 2310 100 {lab=run}
N 2310 730 2960 730 {lab=run}
N 2310 100 1950 100 {lab=run}
N 2310 100 2310 60 {lab=run}
N 2310 60 2320 60 {lab=run}
N 1750 730 1750 590 {lab=run}
N 1750 730 1750 920 {lab=run}
N 1750 920 1760 920 {lab=run}
N 2960 730 2960 920 {lab=run}
N 2960 920 3230 920 {lab=run}
N 3230 920 3230 880 {lab=run}
N 3230 920 3240 920 {lab=run}
N 1950 100 1950 60 {lab=run}
N 1950 60 1960 60 {lab=run}
N 3230 880 4800 880 {lab=run}
N 3230 880 3230 60 {lab=run}
N 3230 60 3240 60 {lab=run}
N 1750 590 -60 590 {lab=run}
N 4800 880 4800 920 {lab=run}
N 4800 920 5070 920 {lab=run}
N 5070 920 5080 920 {lab=run}
N 5070 920 5070 880 {lab=run}
N 5070 880 7000 880 {lab=run}
N 5070 880 5070 60 {lab=run}
N 5070 60 5080 60 {lab=run}
N 7000 880 7000 920 {lab=run}
N 7000 920 7110 920 {lab=run}
N 7110 920 7110 880 {lab=run}
N 7110 920 7120 920 {lab=run}
N 7110 880 7200 880 {lab=run}
N 7200 880 7200 60 {lab=run}
N 7200 60 7320 60 {lab=run}
N 520 890 520 880 {lab=fault_ff.ncki}
N 520 880 920 880 {lab=fault_ff.ncki}
N 520 880 520 100 {lab=fault_ff.ncki}
N 920 880 920 920 {lab=fault_ff.ncki}
N 920 920 1190 920 {lab=fault_ff.ncki}
N 1190 920 1200 920 {lab=fault_ff.ncki}
N 1190 920 1190 880 {lab=fault_ff.ncki}
N 520 100 920 100 {lab=fault_ff.ncki}
N 520 100 520 90 {lab=fault_ff.ncki}
N 920 100 920 60 {lab=fault_ff.ncki}
N 920 60 1200 60 {lab=fault_ff.ncki}
N 1190 880 2400 880 {lab=fault_ff.ncki}
N 2400 880 2400 620 {lab=fault_ff.ncki}
N 2400 620 6910 620 {lab=fault_ff.ncki}
N 6910 620 6910 210 {lab=fault_ff.ncki}
N 6910 620 7110 620 {lab=fault_ff.ncki}
N 7110 620 7120 620 {lab=fault_ff.ncki}
N 7110 620 7110 660 {lab=fault_ff.ncki}
N 6910 210 6920 210 {lab=fault_ff.ncki}
N 7110 660 7220 660 {lab=fault_ff.ncki}
N 7220 660 7220 770 {lab=fault_ff.ncki}
N 7220 770 7670 770 {lab=fault_ff.ncki}
N 7670 770 7680 770 {lab=fault_ff.ncki}
N 7670 770 7670 730 {lab=fault_ff.ncki}
N 7670 730 7760 730 {lab=fault_ff.ncki}
N 7760 730 7760 210 {lab=fault_ff.ncki}
N 7760 210 7880 210 {lab=fault_ff.ncki}
N 160 890 160 860 {lab=done_ff.ncki}
N 160 860 560 860 {lab=done_ff.ncki}
N 160 860 160 120 {lab=done_ff.ncki}
N 560 860 560 920 {lab=done_ff.ncki}
N 560 920 830 920 {lab=done_ff.ncki}
N 830 920 840 920 {lab=done_ff.ncki}
N 830 920 830 620 {lab=done_ff.ncki}
N 160 120 560 120 {lab=done_ff.ncki}
N 160 120 160 90 {lab=done_ff.ncki}
N 560 120 560 60 {lab=done_ff.ncki}
N 560 60 840 60 {lab=done_ff.ncki}
N 830 620 1550 620 {lab=done_ff.ncki}
N 1550 620 1730 620 {lab=done_ff.ncki}
N 1550 620 1550 210 {lab=done_ff.ncki}
N 1730 620 1730 660 {lab=done_ff.ncki}
N 1730 620 1760 620 {lab=done_ff.ncki}
N 1550 210 1560 210 {lab=done_ff.ncki}
N 1730 660 3320 660 {lab=done_ff.ncki}
N 3320 660 3320 770 {lab=done_ff.ncki}
N 3320 770 3790 770 {lab=done_ff.ncki}
N 3790 770 3800 770 {lab=done_ff.ncki}
N 3790 770 3790 730 {lab=done_ff.ncki}
N 3790 730 3880 730 {lab=done_ff.ncki}
N 3880 730 3880 210 {lab=done_ff.ncki}
N 3880 210 4000 210 {lab=done_ff.ncki}
N 7880 920 7870 920 {lab=fault_ff.net4}
N 7870 920 7870 860 {lab=fault_ff.net4}
N 7870 860 5630 860 {lab=fault_ff.net4}
N 7870 860 7870 60 {lab=fault_ff.net4}
N 7870 60 7880 60 {lab=fault_ff.net4}
N 5630 860 5630 740 {lab=fault_ff.net4}
N 5630 860 5630 920 {lab=fault_ff.net4}
N 5630 920 5640 920 {lab=fault_ff.net4}
N 5630 740 5120 740 {lab=fault_ff.net4}
N 5630 740 5630 90 {lab=fault_ff.net4}
N 5630 90 5320 90 {lab=fault_ff.net4}
N 5630 90 5630 60 {lab=fault_ff.net4}
N 5630 60 5640 60 {lab=fault_ff.net4}
N 5320 90 5320 100 {lab=fault_ff.net4}
N 5320 100 5120 100 {lab=fault_ff.net4}
N 5120 100 5120 90 {lab=fault_ff.net4}
N 4000 920 3990 920 {lab=done_ff.net4}
N 3990 920 3990 980 {lab=done_ff.net4}
N 3990 920 3990 710 {lab=done_ff.net4}
N 3990 980 4080 980 {lab=done_ff.net4}
N 4080 980 4080 920 {lab=done_ff.net4}
N 4080 920 4360 920 {lab=done_ff.net4}
N 3990 710 3280 710 {lab=done_ff.net4}
N 3990 710 3990 100 {lab=done_ff.net4}
N 3990 100 3480 100 {lab=done_ff.net4}
N 3990 100 3990 60 {lab=done_ff.net4}
N 3990 100 4080 100 {lab=done_ff.net4}
N 3990 60 4000 60 {lab=done_ff.net4}
N 3280 710 3280 740 {lab=done_ff.net4}
N 4080 100 4080 60 {lab=done_ff.net4}
N 4080 60 4360 60 {lab=done_ff.net4}
N 3480 100 3280 100 {lab=done_ff.net4}
N 3480 100 3480 90 {lab=done_ff.net4}
N 3280 100 3280 90 {lab=done_ff.net4}
N 1240 890 1240 810 {lab=fault_ff.cki}
N 1240 810 5160 810 {lab=fault_ff.cki}
N 1240 810 1240 90 {lab=fault_ff.cki}
N 5160 810 5160 770 {lab=fault_ff.cki}
N 5160 770 6910 770 {lab=fault_ff.cki}
N 6910 770 6910 810 {lab=fault_ff.cki}
N 6910 770 6920 770 {lab=fault_ff.cki}
N 6910 810 7310 810 {lab=fault_ff.cki}
N 7310 810 7310 250 {lab=fault_ff.cki}
N 7310 810 7760 810 {lab=fault_ff.cki}
N 7760 810 7760 770 {lab=fault_ff.cki}
N 7760 770 7880 770 {lab=fault_ff.cki}
N 7310 250 7310 210 {lab=fault_ff.cki}
N 7310 250 7400 250 {lab=fault_ff.cki}
N 7310 210 7320 210 {lab=fault_ff.cki}
N 7400 250 7400 210 {lab=fault_ff.cki}
N 7400 210 7680 210 {lab=fault_ff.cki}
N 880 890 880 770 {lab=done_ff.cki}
N 880 770 1550 770 {lab=done_ff.cki}
N 880 770 880 90 {lab=done_ff.cki}
N 1550 770 1560 770 {lab=done_ff.cki}
N 1550 770 1550 730 {lab=done_ff.cki}
N 1550 730 1640 730 {lab=done_ff.cki}
N 1640 730 1640 690 {lab=done_ff.cki}
N 1640 690 3790 690 {lab=done_ff.cki}
N 1640 690 1640 210 {lab=done_ff.cki}
N 1640 210 1960 210 {lab=done_ff.cki}
N 3790 690 3900 690 {lab=done_ff.cki}
N 3790 690 3790 210 {lab=done_ff.cki}
N 3900 690 3900 770 {lab=done_ff.cki}
N 3900 770 4000 770 {lab=done_ff.cki}
N 3790 210 3800 210 {lab=done_ff.cki}
N 7720 740 7720 710 {lab=fault_ff.net8}
N 7720 710 7920 710 {lab=fault_ff.net8}
N 7720 710 5270 710 {lab=fault_ff.net8}
N 7720 710 7720 250 {lab=fault_ff.net8}
N 7920 710 7920 740 {lab=fault_ff.net8}
N 7720 250 7920 250 {lab=fault_ff.net8}
N 7720 250 7720 240 {lab=fault_ff.net8}
N 7920 250 7920 240 {lab=fault_ff.net8}
N 5270 710 5050 710 {lab=fault_ff.net8}
N 5270 710 5270 60 {lab=fault_ff.net8}
N 5050 710 5050 770 {lab=fault_ff.net8}
N 5050 770 5080 770 {lab=fault_ff.net8}
N 5270 60 5280 60 {lab=fault_ff.net8}
N 1600 740 1600 570 {lab=done_ff.net1}
N 1600 570 1800 570 {lab=done_ff.net1}
N 1600 570 1600 250 {lab=done_ff.net1}
N 1800 570 1800 590 {lab=done_ff.net1}
N 1800 590 3340 590 {lab=done_ff.net1}
N 1600 250 1600 240 {lab=done_ff.net1}
N 1600 250 2000 250 {lab=done_ff.net1}
N 2000 250 2000 240 {lab=done_ff.net1}
N 3340 590 3340 920 {lab=done_ff.net1}
N 3340 590 3520 590 {lab=done_ff.net1}
N 3340 920 3800 920 {lab=done_ff.net1}
N 3520 590 3520 60 {lab=done_ff.net1}
N 3520 60 3800 60 {lab=done_ff.net1}
N 1760 770 1730 770 {lab=done_ff.net2}
N 1730 770 1730 830 {lab=done_ff.net2}
N 1730 770 1710 770 {lab=done_ff.net2}
N 1710 770 1710 60 {lab=done_ff.net2}
N 1710 60 1760 60 {lab=done_ff.net2}
N 1730 830 3770 830 {lab=done_ff.net2}
N 3770 830 3770 170 {lab=done_ff.net2}
N 3770 830 3840 830 {lab=done_ff.net2}
N 3840 830 3840 890 {lab=done_ff.net2}
N 3840 830 3840 800 {lab=done_ff.net2}
N 3770 170 3840 170 {lab=done_ff.net2}
N 3840 170 3840 90 {lab=done_ff.net2}
N 3840 170 3840 180 {lab=done_ff.net2}
N 3840 740 3840 640 {lab=done_ff.net8}
N 3840 740 3920 740 {lab=done_ff.net8}
N 3920 740 3920 730 {lab=done_ff.net8}
N 3920 730 4040 730 {lab=done_ff.net8}
N 4040 730 4040 740 {lab=done_ff.net8}
N 3840 640 3430 640 {lab=done_ff.net8}
N 3840 640 3840 250 {lab=done_ff.net8}
N 3840 250 4040 250 {lab=done_ff.net8}
N 3840 250 3840 240 {lab=done_ff.net8}
N 3430 640 3210 640 {lab=done_ff.net8}
N 3430 640 3430 60 {lab=done_ff.net8}
N 3210 640 3210 770 {lab=done_ff.net8}
N 3210 770 3240 770 {lab=done_ff.net8}
N 4040 250 4040 240 {lab=done_ff.net8}
N 3430 60 3440 60 {lab=done_ff.net8}
N 6960 740 6960 580 {lab=fault_ff.net1}
N 6960 580 6960 240 {lab=fault_ff.net1}
N 6960 580 7160 580 {lab=fault_ff.net1}
N 7160 580 7160 590 {lab=fault_ff.net1}
N 7160 590 7240 590 {lab=fault_ff.net1}
N 7240 590 7240 920 {lab=fault_ff.net1}
N 7240 590 7360 590 {lab=fault_ff.net1}
N 7240 920 7680 920 {lab=fault_ff.net1}
N 7360 590 7360 270 {lab=fault_ff.net1}
N 7360 270 7420 270 {lab=fault_ff.net1}
N 7360 270 7360 240 {lab=fault_ff.net1}
N 7420 270 7420 60 {lab=fault_ff.net1}
N 7420 60 7680 60 {lab=fault_ff.net1}
N 7120 770 7110 770 {lab=fault_ff.net2}
N 7110 770 7090 770 {lab=fault_ff.net2}
N 7110 770 7110 830 {lab=fault_ff.net2}
N 7110 830 7720 830 {lab=fault_ff.net2}
N 7720 830 7720 890 {lab=fault_ff.net2}
N 7720 830 7720 800 {lab=fault_ff.net2}
N 7090 770 7090 170 {lab=fault_ff.net2}
N 7090 170 7720 170 {lab=fault_ff.net2}
N 7090 170 7090 60 {lab=fault_ff.net2}
N 7090 60 7120 60 {lab=fault_ff.net2}
N 7720 170 7720 90 {lab=fault_ff.net2}
N 7720 170 7720 180 {lab=fault_ff.net2}
N 4400 890 4440 890 {lab=uio_out_2}
N 4400 890 4400 90 {lab=uio_out_2}
N 4440 890 4440 920 {lab=uio_out_2}
N 4440 920 4710 920 {lab=uio_out_2}
N 4710 920 4720 920 {lab=uio_out_2}
N 4710 920 4710 980 {lab=uio_out_2}
N 4400 90 4440 90 {lab=uio_out_2}
N 4440 90 4440 60 {lab=uio_out_2}
N 4440 60 4720 60 {lab=uio_out_2}
N 4710 980 7960 980 {lab=uio_out_2}
N 7960 980 7960 550 {lab=uio_out_2}
N 7960 550 8300 550 {lab=uio_out_2}
N 5680 890 5720 890 {lab=uio_out_3}
N 5680 890 5680 210 {lab=uio_out_3}
N 5720 890 5720 920 {lab=uio_out_3}
N 5720 920 5990 920 {lab=uio_out_3}
N 5990 920 6000 920 {lab=uio_out_3}
N 5990 920 5990 1000 {lab=uio_out_3}
N 5680 210 6000 210 {lab=uio_out_3}
N 5680 210 5680 90 {lab=uio_out_3}
N 5990 1000 8300 1000 {lab=uio_out_3}
N 8300 1000 8300 590 {lab=uio_out_3}
N 2360 740 2360 710 {lab=busy_and.Z_neg}
N 2360 710 2360 100 {lab=busy_and.Z_neg}
N 2360 710 2420 710 {lab=busy_and.Z_neg}
N 2360 100 2360 90 {lab=busy_and.Z_neg}
N 2360 100 2560 100 {lab=busy_and.Z_neg}
N 2420 710 2420 920 {lab=busy_and.Z_neg}
N 2420 920 2880 920 {lab=busy_and.Z_neg}
N 2560 100 2560 90 {lab=busy_and.Z_neg}
N 2560 90 2600 90 {lab=busy_and.Z_neg}
N 2600 90 2600 60 {lab=busy_and.Z_neg}
N 2600 60 2880 60 {lab=busy_and.Z_neg}
N 6040 890 6040 840 {lab=fault_or.Z_neg}
N 6040 840 6040 240 {lab=fault_or.Z_neg}
N 6040 840 6240 840 {lab=fault_or.Z_neg}
N 6240 840 6240 890 {lab=fault_or.Z_neg}
N 6240 890 6280 890 {lab=fault_or.Z_neg}
N 6280 890 6280 920 {lab=fault_or.Z_neg}
N 6280 920 6560 920 {lab=fault_or.Z_neg}
N 6040 240 6080 240 {lab=fault_or.Z_neg}
N 6080 240 6080 60 {lab=fault_or.Z_neg}
N 6080 60 6560 60 {lab=fault_or.Z_neg}
N 2320 920 2310 920 {lab=done_n}
N 2310 920 2310 860 {lab=done_n}
N 2310 860 2440 860 {lab=done_n}
N 2440 860 2440 60 {lab=done_n}
N 2440 860 4760 860 {lab=done_n}
N 2440 60 2520 60 {lab=done_n}
N 4760 860 4760 90 {lab=done_n}
N 4760 860 4760 890 {lab=done_n}
N 6920 920 6890 920 {lab=fault_d}
N 6890 920 6640 920 {lab=fault_d}
N 6890 920 6890 90 {lab=fault_d}
N 6640 920 6640 890 {lab=fault_d}
N 6640 890 6600 890 {lab=fault_d}
N 6890 90 6890 60 {lab=fault_d}
N 6890 90 6600 90 {lab=fault_d}
N 6890 60 6920 60 {lab=fault_d}
N 1600 890 1600 830 {lab=done_ff.net6}
N 1600 830 1530 830 {lab=done_ff.net6}
N 1600 830 1600 800 {lab=done_ff.net6}
N 1530 830 1530 170 {lab=done_ff.net6}
N 1530 170 1600 170 {lab=done_ff.net6}
N 1600 170 1600 180 {lab=done_ff.net6}
N 1600 170 1600 90 {lab=done_ff.net6}
N 4040 800 4040 830 {lab=done_ff.net11}
N 4040 830 4040 890 {lab=done_ff.net11}
N 4040 830 4080 830 {lab=done_ff.net11}
N 4080 830 4080 180 {lab=done_ff.net11}
N 4080 180 4040 180 {lab=done_ff.net11}
N 4040 180 4040 90 {lab=done_ff.net11}
N 6960 890 6960 830 {lab=fault_ff.net6}
N 6960 830 7000 830 {lab=fault_ff.net6}
N 6960 830 6960 800 {lab=fault_ff.net6}
N 7000 830 7000 180 {lab=fault_ff.net6}
N 7000 180 6960 180 {lab=fault_ff.net6}
N 6960 180 6960 90 {lab=fault_ff.net6}
N 7920 800 7980 800 {lab=fault_ff.net11}
N 7920 800 7920 890 {lab=fault_ff.net11}
N 7980 800 7980 180 {lab=fault_ff.net11}
N 7980 180 7920 180 {lab=fault_ff.net11}
N 7920 180 7920 90 {lab=fault_ff.net11}
N 6200 920 6190 920 {lab=bad_bit}
N 6190 920 6190 170 {lab=bad_bit}
N 6190 170 5990 170 {lab=bad_bit}
N 5990 170 5990 60 {lab=bad_bit}
N 5990 60 5990 0 {lab=bad_bit}
N 5990 60 6000 60 {lab=bad_bit}
N 5990 0 110 0 {lab=bad_bit}
N 110 0 110 510 {lab=bad_bit}
N 110 510 -60 510 {lab=bad_bit}
N 2920 890 2920 90 {lab=uio_out_1}
N 2920 90 2960 90 {lab=uio_out_1}
N 2960 90 2960 -20 {lab=uio_out_1}
N 2960 -20 8300 -20 {lab=uio_out_1}
N 8300 -20 8300 510 {lab=uio_out_1}
N 1560 920 1510 920 {lab=n_16}
N 1510 920 1510 550 {lab=n_16}
N 1510 550 1510 60 {lab=n_16}
N 1510 550 -60 550 {lab=n_16}
N 1510 60 1560 60 {lab=n_16}
N 480 920 470 920 {lab=tick_n}
N 470 920 470 630 {lab=tick_n}
N 470 630 -60 630 {lab=tick_n}
N 470 630 470 60 {lab=tick_n}
N 470 60 480 60 {lab=tick_n}
N 2000 180 2000 120 {lab=done_ff.net9}
N 2000 120 1800 120 {lab=done_ff.net9}
N 2000 120 2000 90 {lab=done_ff.net9}
N 1800 120 1800 90 {lab=done_ff.net9}
N 7360 180 7360 100 {lab=fault_ff.net9}
N 7360 100 7160 100 {lab=fault_ff.net9}
N 7360 100 7360 90 {lab=fault_ff.net9}
N 7160 100 7160 90 {lab=fault_ff.net9}
N 120 920 -70 920 {lab=b}
N -70 920 -70 470 {lab=b}
N -70 470 -60 470 {lab=b}
N -60 470 -60 60 {lab=b}
N -60 60 120 60 {lab=b}
N 2360 800 2360 890 {lab=busy_and.net_0}
N 1800 650 1800 740 {lab=done_ff.net15}
N 1800 800 1800 890 {lab=done_ff.net12}
N 3280 890 3280 800 {lab=done_ff.net0}
N 7160 650 7160 740 {lab=fault_ff.net15}
N 7160 800 7160 890 {lab=fault_ff.net12}
N 5120 890 5120 800 {lab=fault_ff.net0}
N 6040 180 6040 90 {lab=fault_or.net_0}
C {devices/ipin.sym} -60 470 0 0 {name=p119 lab=b}
C {devices/ipin.sym} -60 510 0 0 {name=p120 lab=bad_bit}
C {devices/ipin.sym} -60 550 0 0 {name=p121 lab=n_16}
C {devices/ipin.sym} -60 590 0 0 {name=p122 lab=run}
C {devices/ipin.sym} -60 630 0 0 {name=p123 lab=tick_n}
C {devices/opin.sym} 8300 510 0 0 {name=p124 lab=uio_out_1}
C {devices/opin.sym} 8300 550 0 0 {name=p125 lab=uio_out_2}
C {devices/opin.sym} 8300 590 0 0 {name=p126 lab=uio_out_3}
