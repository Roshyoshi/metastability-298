v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {ctrl_start: controller block "start" at transistor level (3 cells)} 0 -230 0 0 0.45 0.45 {}
T {Start: request = ena AND start, then start_meta and run, both clocked by a_n rising} 0 -190 0 0 0.26 0.26 {}
T {From src/gf180/compact_control.v; every cell opened up. Stage labels are the cell instance names.} 0 -162 0 0 0.26 0.26 {}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 770 0 0 {name=Mrequest_and_i_2 L=0.6u W=0.365u nf=1 m=1 ad=1.825e-13 as=1.825e-13 pd=1.73e-06 ps=1.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 920 0 0 {name=Mrequest_and_i_3 L=0.6u W=0.365u nf=1 m=1 ad=1.825e-13 as=1.825e-13 pd=1.73e-06 ps=1.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1420 920 0 0 {name=Mrequest_and_i_0 L=0.6u W=0.815u nf=1 m=1 ad=4.075e-13 as=4.075e-13 pd=2.63e-06 ps=2.63e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=Mrequest_and_i_4 L=0.5u W=0.6u nf=1 m=1 ad=3e-13 as=3e-13 pd=2.2e-06 ps=2.2e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 340 60 0 0 {name=Mrequest_and_i_5 L=0.5u W=0.6u nf=1 m=1 ad=3e-13 as=3e-13 pd=2.2e-06 ps=2.2e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1420 60 0 0 {name=Mrequest_and_i_1 L=0.5u W=1.215u nf=1 m=1 ad=6.075e-13 as=6.075e-13 pd=3.43e-06 ps=3.43e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 700 920 0 0 {name=Mrun_ff_tn10 L=0.6u W=0.405u nf=1 m=1 ad=2.025e-13 as=2.025e-13 pd=1.81e-06 ps=1.81e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1780 920 0 0 {name=Mrun_ff_tn13 L=0.6u W=0.405u nf=1 m=1 ad=2.025e-13 as=2.025e-13 pd=1.81e-06 ps=1.81e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5660 920 0 0 {name=Mrun_ff_tn11 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5660 770 0 0 {name=Mrun_ff_tn15 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5860 620 0 0 {name=Mrun_ff_tn14 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5860 770 0 0 {name=Mrun_ff_tn8 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5860 920 0 0 {name=Mrun_ff_tn9 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6420 920 0 0 {name=Mrun_ff_tn18 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6420 770 0 0 {name=Mrun_ff_tn0 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6620 770 0 0 {name=Mrun_ff_tn1 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6620 920 0 0 {name=Mrun_ff_tn12 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2500 920 0 0 {name=Mrun_ff_tn5 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2500 770 0 0 {name=Mrun_ff_tn4 L=0.6u W=0.4u nf=1 m=1 ad=2e-13 as=2e-13 pd=1.8e-06 ps=1.8e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3060 920 0 0 {name=Mrun_ff_tn3 L=0.6u W=0.815u nf=1 m=1 ad=4.075e-13 as=4.075e-13 pd=2.63e-06 ps=2.63e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 700 60 0 0 {name=Mrun_ff_tp8 L=0.5u W=0.865u nf=1 m=1 ad=4.325e-13 as=4.325e-13 pd=2.73e-06 ps=2.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1780 60 0 0 {name=Mrun_ff_tp11 L=0.5u W=0.865u nf=1 m=1 ad=4.325e-13 as=4.325e-13 pd=2.73e-06 ps=2.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5660 60 0 0 {name=Mrun_ff_tp9 L=0.5u W=0.78u nf=1 m=1 ad=3.9e-13 as=3.9e-13 pd=2.56e-06 ps=2.56e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5660 210 0 0 {name=Mrun_ff_tp15 L=0.5u W=0.78u nf=1 m=1 ad=3.9e-13 as=3.9e-13 pd=2.56e-06 ps=2.56e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6060 210 0 0 {name=Mrun_ff_tp7 L=0.5u W=0.78u nf=1 m=1 ad=3.9e-13 as=3.9e-13 pd=2.56e-06 ps=2.56e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5860 60 0 0 {name=Mrun_ff_tp6 L=0.5u W=0.78u nf=1 m=1 ad=3.9e-13 as=3.9e-13 pd=2.56e-06 ps=2.56e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6060 60 0 0 {name=Mrun_ff_tp12 L=0.5u W=0.78u nf=1 m=1 ad=3.9e-13 as=3.9e-13 pd=2.56e-06 ps=2.56e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6420 60 0 0 {name=Mrun_ff_tp18 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6420 210 0 0 {name=Mrun_ff_tp2 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6620 210 0 0 {name=Mrun_ff_tp3 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6620 60 0 0 {name=Mrun_ff_tp10 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2500 60 0 0 {name=Mrun_ff_tp5 L=0.5u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2700 60 0 0 {name=Mrun_ff_tp4 L=0.5u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3060 60 0 0 {name=Mrun_ff_tp1 L=0.5u W=1.215u nf=1 m=1 ad=6.075e-13 as=6.075e-13 pd=3.43e-06 ps=3.43e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1060 920 0 0 {name=Mstart_meta_ff_tn10 L=0.6u W=0.405u nf=1 m=1 ad=2.025e-13 as=2.025e-13 pd=1.81e-06 ps=1.81e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2140 920 0 0 {name=Mstart_meta_ff_tn13 L=0.6u W=0.405u nf=1 m=1 ad=2.025e-13 as=2.025e-13 pd=1.81e-06 ps=1.81e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3420 920 0 0 {name=Mstart_meta_ff_tn11 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3420 770 0 0 {name=Mstart_meta_ff_tn15 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3620 620 0 0 {name=Mstart_meta_ff_tn14 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3620 770 0 0 {name=Mstart_meta_ff_tn8 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3620 920 0 0 {name=Mstart_meta_ff_tn9 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4740 920 0 0 {name=Mstart_meta_ff_tn18 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4740 770 0 0 {name=Mstart_meta_ff_tn0 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4940 770 0 0 {name=Mstart_meta_ff_tn1 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4940 920 0 0 {name=Mstart_meta_ff_tn12 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4180 920 0 0 {name=Mstart_meta_ff_tn5 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4180 770 0 0 {name=Mstart_meta_ff_tn4 L=0.6u W=0.4u nf=1 m=1 ad=2e-13 as=2e-13 pd=1.8e-06 ps=1.8e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5300 920 0 0 {name=Mstart_meta_ff_tn3 L=0.6u W=0.815u nf=1 m=1 ad=4.075e-13 as=4.075e-13 pd=2.63e-06 ps=2.63e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1060 60 0 0 {name=Mstart_meta_ff_tp8 L=0.5u W=0.865u nf=1 m=1 ad=4.325e-13 as=4.325e-13 pd=2.73e-06 ps=2.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2140 60 0 0 {name=Mstart_meta_ff_tp11 L=0.5u W=0.865u nf=1 m=1 ad=4.325e-13 as=4.325e-13 pd=2.73e-06 ps=2.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3420 60 0 0 {name=Mstart_meta_ff_tp9 L=0.5u W=0.78u nf=1 m=1 ad=3.9e-13 as=3.9e-13 pd=2.56e-06 ps=2.56e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3420 210 0 0 {name=Mstart_meta_ff_tp15 L=0.5u W=0.78u nf=1 m=1 ad=3.9e-13 as=3.9e-13 pd=2.56e-06 ps=2.56e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3820 210 0 0 {name=Mstart_meta_ff_tp7 L=0.5u W=0.78u nf=1 m=1 ad=3.9e-13 as=3.9e-13 pd=2.56e-06 ps=2.56e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3620 60 0 0 {name=Mstart_meta_ff_tp6 L=0.5u W=0.78u nf=1 m=1 ad=3.9e-13 as=3.9e-13 pd=2.56e-06 ps=2.56e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3820 60 0 0 {name=Mstart_meta_ff_tp12 L=0.5u W=0.78u nf=1 m=1 ad=3.9e-13 as=3.9e-13 pd=2.56e-06 ps=2.56e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4740 60 0 0 {name=Mstart_meta_ff_tp18 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4740 210 0 0 {name=Mstart_meta_ff_tp2 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4940 210 0 0 {name=Mstart_meta_ff_tp3 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4940 60 0 0 {name=Mstart_meta_ff_tp10 L=0.5u W=0.505u nf=1 m=1 ad=2.525e-13 as=2.525e-13 pd=2.01e-06 ps=2.01e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4180 60 0 0 {name=Mstart_meta_ff_tp5 L=0.5u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4380 60 0 0 {name=Mstart_meta_ff_tp4 L=0.5u W=1u nf=1 m=1 ad=5e-13 as=5e-13 pd=3e-06 ps=3e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5300 60 0 0 {name=Mstart_meta_ff_tp1 L=0.5u W=1.215u nf=1 m=1 ad=6.075e-13 as=6.075e-13 pd=3.43e-06 ps=3.43e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
T {request_and} 110 -35 0 0 0.3 0.3 {}
T {run_ff} 670 -35 0 0 0.3 0.3 {}
T {start_meta_ff} 1030 -35 0 0 0.3 0.3 {}
N 160 770 190 770 {lab=0}
C {devices/gnd.sym} 190 770 0 0 {name=s1 lab=0}
N 160 950 160 970 {lab=0}
C {devices/gnd.sym} 160 970 0 0 {name=s2 lab=0}
N 160 920 190 920 {lab=0}
C {devices/gnd.sym} 190 920 0 0 {name=s3 lab=0}
N 1440 950 1440 970 {lab=0}
C {devices/gnd.sym} 1440 970 0 0 {name=s4 lab=0}
N 1440 920 1470 920 {lab=0}
C {devices/gnd.sym} 1470 920 0 0 {name=s5 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s6 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s7 lab=VDD}
N 360 30 360 10 {lab=VDD}
C {devices/vdd.sym} 360 10 0 0 {name=s8 lab=VDD}
N 360 60 390 60 {lab=VDD}
C {devices/vdd.sym} 390 60 0 0 {name=s9 lab=VDD}
N 1440 30 1440 10 {lab=VDD}
C {devices/vdd.sym} 1440 10 0 0 {name=s10 lab=VDD}
N 1440 60 1470 60 {lab=VDD}
C {devices/vdd.sym} 1470 60 0 0 {name=s11 lab=VDD}
N 720 950 720 970 {lab=0}
C {devices/gnd.sym} 720 970 0 0 {name=s12 lab=0}
N 720 920 750 920 {lab=0}
C {devices/gnd.sym} 750 920 0 0 {name=s13 lab=0}
N 1800 950 1800 970 {lab=0}
C {devices/gnd.sym} 1800 970 0 0 {name=s14 lab=0}
N 1800 920 1830 920 {lab=0}
C {devices/gnd.sym} 1830 920 0 0 {name=s15 lab=0}
N 5680 950 5680 970 {lab=0}
C {devices/gnd.sym} 5680 970 0 0 {name=s16 lab=0}
N 5680 920 5710 920 {lab=0}
C {devices/gnd.sym} 5710 920 0 0 {name=s17 lab=0}
N 5680 770 5710 770 {lab=0}
C {devices/gnd.sym} 5710 770 0 0 {name=s18 lab=0}
N 5880 620 5910 620 {lab=0}
C {devices/gnd.sym} 5910 620 0 0 {name=s19 lab=0}
N 5880 770 5910 770 {lab=0}
C {devices/gnd.sym} 5910 770 0 0 {name=s20 lab=0}
N 5880 950 5880 970 {lab=0}
C {devices/gnd.sym} 5880 970 0 0 {name=s21 lab=0}
N 5880 920 5910 920 {lab=0}
C {devices/gnd.sym} 5910 920 0 0 {name=s22 lab=0}
N 6440 950 6440 970 {lab=0}
C {devices/gnd.sym} 6440 970 0 0 {name=s23 lab=0}
N 6440 920 6470 920 {lab=0}
C {devices/gnd.sym} 6470 920 0 0 {name=s24 lab=0}
N 6440 770 6470 770 {lab=0}
C {devices/gnd.sym} 6470 770 0 0 {name=s25 lab=0}
N 6640 770 6670 770 {lab=0}
C {devices/gnd.sym} 6670 770 0 0 {name=s26 lab=0}
N 6640 950 6640 970 {lab=0}
C {devices/gnd.sym} 6640 970 0 0 {name=s27 lab=0}
N 6640 920 6670 920 {lab=0}
C {devices/gnd.sym} 6670 920 0 0 {name=s28 lab=0}
N 2520 950 2520 970 {lab=0}
C {devices/gnd.sym} 2520 970 0 0 {name=s29 lab=0}
N 2520 920 2550 920 {lab=0}
C {devices/gnd.sym} 2550 920 0 0 {name=s30 lab=0}
N 2520 770 2550 770 {lab=0}
C {devices/gnd.sym} 2550 770 0 0 {name=s31 lab=0}
N 3080 950 3080 970 {lab=0}
C {devices/gnd.sym} 3080 970 0 0 {name=s32 lab=0}
N 3080 920 3110 920 {lab=0}
C {devices/gnd.sym} 3110 920 0 0 {name=s33 lab=0}
N 720 30 720 10 {lab=VDD}
C {devices/vdd.sym} 720 10 0 0 {name=s34 lab=VDD}
N 720 60 750 60 {lab=VDD}
C {devices/vdd.sym} 750 60 0 0 {name=s35 lab=VDD}
N 1800 30 1800 10 {lab=VDD}
C {devices/vdd.sym} 1800 10 0 0 {name=s36 lab=VDD}
N 1800 60 1830 60 {lab=VDD}
C {devices/vdd.sym} 1830 60 0 0 {name=s37 lab=VDD}
N 5680 30 5680 10 {lab=VDD}
C {devices/vdd.sym} 5680 10 0 0 {name=s38 lab=VDD}
N 5680 60 5710 60 {lab=VDD}
C {devices/vdd.sym} 5710 60 0 0 {name=s39 lab=VDD}
N 5680 210 5710 210 {lab=VDD}
C {devices/vdd.sym} 5710 210 0 0 {name=s40 lab=VDD}
N 6080 210 6110 210 {lab=VDD}
C {devices/vdd.sym} 6110 210 0 0 {name=s41 lab=VDD}
N 5880 30 5880 10 {lab=VDD}
C {devices/vdd.sym} 5880 10 0 0 {name=s42 lab=VDD}
N 5880 60 5910 60 {lab=VDD}
C {devices/vdd.sym} 5910 60 0 0 {name=s43 lab=VDD}
N 6080 30 6080 10 {lab=VDD}
C {devices/vdd.sym} 6080 10 0 0 {name=s44 lab=VDD}
N 6080 60 6110 60 {lab=VDD}
C {devices/vdd.sym} 6110 60 0 0 {name=s45 lab=VDD}
N 6440 30 6440 10 {lab=VDD}
C {devices/vdd.sym} 6440 10 0 0 {name=s46 lab=VDD}
N 6440 60 6470 60 {lab=VDD}
C {devices/vdd.sym} 6470 60 0 0 {name=s47 lab=VDD}
N 6440 210 6470 210 {lab=VDD}
C {devices/vdd.sym} 6470 210 0 0 {name=s48 lab=VDD}
N 6640 210 6670 210 {lab=VDD}
C {devices/vdd.sym} 6670 210 0 0 {name=s49 lab=VDD}
N 6640 30 6640 10 {lab=VDD}
C {devices/vdd.sym} 6640 10 0 0 {name=s50 lab=VDD}
N 6640 60 6670 60 {lab=VDD}
C {devices/vdd.sym} 6670 60 0 0 {name=s51 lab=VDD}
N 2520 30 2520 10 {lab=VDD}
C {devices/vdd.sym} 2520 10 0 0 {name=s52 lab=VDD}
N 2520 60 2550 60 {lab=VDD}
C {devices/vdd.sym} 2550 60 0 0 {name=s53 lab=VDD}
N 2720 30 2720 10 {lab=VDD}
C {devices/vdd.sym} 2720 10 0 0 {name=s54 lab=VDD}
N 2720 60 2750 60 {lab=VDD}
C {devices/vdd.sym} 2750 60 0 0 {name=s55 lab=VDD}
N 3080 30 3080 10 {lab=VDD}
C {devices/vdd.sym} 3080 10 0 0 {name=s56 lab=VDD}
N 3080 60 3110 60 {lab=VDD}
C {devices/vdd.sym} 3110 60 0 0 {name=s57 lab=VDD}
N 1080 950 1080 970 {lab=0}
C {devices/gnd.sym} 1080 970 0 0 {name=s58 lab=0}
N 1080 920 1110 920 {lab=0}
C {devices/gnd.sym} 1110 920 0 0 {name=s59 lab=0}
N 2160 950 2160 970 {lab=0}
C {devices/gnd.sym} 2160 970 0 0 {name=s60 lab=0}
N 2160 920 2190 920 {lab=0}
C {devices/gnd.sym} 2190 920 0 0 {name=s61 lab=0}
N 3440 950 3440 970 {lab=0}
C {devices/gnd.sym} 3440 970 0 0 {name=s62 lab=0}
N 3440 920 3470 920 {lab=0}
C {devices/gnd.sym} 3470 920 0 0 {name=s63 lab=0}
N 3440 770 3470 770 {lab=0}
C {devices/gnd.sym} 3470 770 0 0 {name=s64 lab=0}
N 3640 620 3670 620 {lab=0}
C {devices/gnd.sym} 3670 620 0 0 {name=s65 lab=0}
N 3640 770 3670 770 {lab=0}
C {devices/gnd.sym} 3670 770 0 0 {name=s66 lab=0}
N 3640 950 3640 970 {lab=0}
C {devices/gnd.sym} 3640 970 0 0 {name=s67 lab=0}
N 3640 920 3670 920 {lab=0}
C {devices/gnd.sym} 3670 920 0 0 {name=s68 lab=0}
N 4760 950 4760 970 {lab=0}
C {devices/gnd.sym} 4760 970 0 0 {name=s69 lab=0}
N 4760 920 4790 920 {lab=0}
C {devices/gnd.sym} 4790 920 0 0 {name=s70 lab=0}
N 4760 770 4790 770 {lab=0}
C {devices/gnd.sym} 4790 770 0 0 {name=s71 lab=0}
N 4960 770 4990 770 {lab=0}
C {devices/gnd.sym} 4990 770 0 0 {name=s72 lab=0}
N 4960 950 4960 970 {lab=0}
C {devices/gnd.sym} 4960 970 0 0 {name=s73 lab=0}
N 4960 920 4990 920 {lab=0}
C {devices/gnd.sym} 4990 920 0 0 {name=s74 lab=0}
N 4200 950 4200 970 {lab=0}
C {devices/gnd.sym} 4200 970 0 0 {name=s75 lab=0}
N 4200 920 4230 920 {lab=0}
C {devices/gnd.sym} 4230 920 0 0 {name=s76 lab=0}
N 4200 770 4230 770 {lab=0}
C {devices/gnd.sym} 4230 770 0 0 {name=s77 lab=0}
N 5320 950 5320 970 {lab=0}
C {devices/gnd.sym} 5320 970 0 0 {name=s78 lab=0}
N 5320 920 5350 920 {lab=0}
C {devices/gnd.sym} 5350 920 0 0 {name=s79 lab=0}
N 1080 30 1080 10 {lab=VDD}
C {devices/vdd.sym} 1080 10 0 0 {name=s80 lab=VDD}
N 1080 60 1110 60 {lab=VDD}
C {devices/vdd.sym} 1110 60 0 0 {name=s81 lab=VDD}
N 2160 30 2160 10 {lab=VDD}
C {devices/vdd.sym} 2160 10 0 0 {name=s82 lab=VDD}
N 2160 60 2190 60 {lab=VDD}
C {devices/vdd.sym} 2190 60 0 0 {name=s83 lab=VDD}
N 3440 30 3440 10 {lab=VDD}
C {devices/vdd.sym} 3440 10 0 0 {name=s84 lab=VDD}
N 3440 60 3470 60 {lab=VDD}
C {devices/vdd.sym} 3470 60 0 0 {name=s85 lab=VDD}
N 3440 210 3470 210 {lab=VDD}
C {devices/vdd.sym} 3470 210 0 0 {name=s86 lab=VDD}
N 3840 210 3870 210 {lab=VDD}
C {devices/vdd.sym} 3870 210 0 0 {name=s87 lab=VDD}
N 3640 30 3640 10 {lab=VDD}
C {devices/vdd.sym} 3640 10 0 0 {name=s88 lab=VDD}
N 3640 60 3670 60 {lab=VDD}
C {devices/vdd.sym} 3670 60 0 0 {name=s89 lab=VDD}
N 3840 30 3840 10 {lab=VDD}
C {devices/vdd.sym} 3840 10 0 0 {name=s90 lab=VDD}
N 3840 60 3870 60 {lab=VDD}
C {devices/vdd.sym} 3870 60 0 0 {name=s91 lab=VDD}
N 4760 30 4760 10 {lab=VDD}
C {devices/vdd.sym} 4760 10 0 0 {name=s92 lab=VDD}
N 4760 60 4790 60 {lab=VDD}
C {devices/vdd.sym} 4790 60 0 0 {name=s93 lab=VDD}
N 4760 210 4790 210 {lab=VDD}
C {devices/vdd.sym} 4790 210 0 0 {name=s94 lab=VDD}
N 4960 210 4990 210 {lab=VDD}
C {devices/vdd.sym} 4990 210 0 0 {name=s95 lab=VDD}
N 4960 30 4960 10 {lab=VDD}
C {devices/vdd.sym} 4960 10 0 0 {name=s96 lab=VDD}
N 4960 60 4990 60 {lab=VDD}
C {devices/vdd.sym} 4990 60 0 0 {name=s97 lab=VDD}
N 4200 30 4200 10 {lab=VDD}
C {devices/vdd.sym} 4200 10 0 0 {name=s98 lab=VDD}
N 4200 60 4230 60 {lab=VDD}
C {devices/vdd.sym} 4230 60 0 0 {name=s99 lab=VDD}
N 4400 30 4400 10 {lab=VDD}
C {devices/vdd.sym} 4400 10 0 0 {name=s100 lab=VDD}
N 4400 60 4430 60 {lab=VDD}
C {devices/vdd.sym} 4430 60 0 0 {name=s101 lab=VDD}
N 5320 30 5320 10 {lab=VDD}
C {devices/vdd.sym} 5320 10 0 0 {name=s102 lab=VDD}
N 5320 60 5350 60 {lab=VDD}
C {devices/vdd.sym} 5350 60 0 0 {name=s103 lab=VDD}
N 5840 920 5830 920 {lab=rst_n}
N 5830 920 5830 880 {lab=rst_n}
N 5830 880 5920 880 {lab=rst_n}
N 5830 880 4150 880 {lab=rst_n}
N 5920 880 5920 60 {lab=rst_n}
N 5920 60 6040 60 {lab=rst_n}
N 4150 880 3590 880 {lab=rst_n}
N 4150 880 4150 100 {lab=rst_n}
N 4150 880 4150 920 {lab=rst_n}
N 4150 920 4160 920 {lab=rst_n}
N 3590 880 2470 880 {lab=rst_n}
N 3590 880 3590 920 {lab=rst_n}
N 3590 920 3600 920 {lab=rst_n}
N 4150 100 3790 100 {lab=rst_n}
N 4150 100 4150 60 {lab=rst_n}
N 4150 60 4160 60 {lab=rst_n}
N 3790 100 3790 60 {lab=rst_n}
N 3790 60 3800 60 {lab=rst_n}
N 2470 880 2470 570 {lab=rst_n}
N 2470 880 2470 920 {lab=rst_n}
N 2470 920 2480 920 {lab=rst_n}
N 2470 570 -60 570 {lab=rst_n}
N 2470 570 2470 60 {lab=rst_n}
N 2470 60 2480 60 {lab=rst_n}
N 720 890 720 880 {lab=run_ff.ncki}
N 720 880 1480 880 {lab=run_ff.ncki}
N 720 880 720 90 {lab=run_ff.ncki}
N 1480 880 1480 920 {lab=run_ff.ncki}
N 1480 920 1750 920 {lab=run_ff.ncki}
N 1750 920 1760 920 {lab=run_ff.ncki}
N 1750 920 1750 810 {lab=run_ff.ncki}
N 1750 810 5000 810 {lab=run_ff.ncki}
N 1750 810 1750 60 {lab=run_ff.ncki}
N 1750 60 1760 60 {lab=run_ff.ncki}
N 5000 810 5000 770 {lab=run_ff.ncki}
N 5000 770 5630 770 {lab=run_ff.ncki}
N 5630 770 5630 810 {lab=run_ff.ncki}
N 5630 770 5640 770 {lab=run_ff.ncki}
N 5630 810 6030 810 {lab=run_ff.ncki}
N 6030 810 6480 810 {lab=run_ff.ncki}
N 6030 810 6030 250 {lab=run_ff.ncki}
N 6480 810 6480 770 {lab=run_ff.ncki}
N 6480 770 6600 770 {lab=run_ff.ncki}
N 6030 250 6030 210 {lab=run_ff.ncki}
N 6030 250 6120 250 {lab=run_ff.ncki}
N 6030 210 6040 210 {lab=run_ff.ncki}
N 6120 250 6120 210 {lab=run_ff.ncki}
N 6120 210 6400 210 {lab=run_ff.ncki}
N 1080 890 1080 860 {lab=start_meta_ff.ncki}
N 1080 860 1840 860 {lab=start_meta_ff.ncki}
N 1080 860 1080 90 {lab=start_meta_ff.ncki}
N 1840 860 1840 920 {lab=start_meta_ff.ncki}
N 1840 920 2110 920 {lab=start_meta_ff.ncki}
N 2110 920 2120 920 {lab=start_meta_ff.ncki}
N 2110 920 2110 730 {lab=start_meta_ff.ncki}
N 2110 730 2110 60 {lab=start_meta_ff.ncki}
N 2110 730 2560 730 {lab=start_meta_ff.ncki}
N 2110 60 2120 60 {lab=start_meta_ff.ncki}
N 2560 730 2560 770 {lab=start_meta_ff.ncki}
N 2560 770 3390 770 {lab=start_meta_ff.ncki}
N 3390 770 3390 730 {lab=start_meta_ff.ncki}
N 3390 770 3400 770 {lab=start_meta_ff.ncki}
N 3390 730 3480 730 {lab=start_meta_ff.ncki}
N 3480 730 4710 730 {lab=start_meta_ff.ncki}
N 3480 730 3480 210 {lab=start_meta_ff.ncki}
N 3480 210 3800 210 {lab=start_meta_ff.ncki}
N 4710 730 4710 210 {lab=start_meta_ff.ncki}
N 4710 730 4800 730 {lab=start_meta_ff.ncki}
N 4800 730 4800 770 {lab=start_meta_ff.ncki}
N 4800 770 4920 770 {lab=start_meta_ff.ncki}
N 4710 210 4720 210 {lab=start_meta_ff.ncki}
N 6600 920 6590 920 {lab=run_ff.net4}
N 6590 920 6590 980 {lab=run_ff.net4}
N 6590 920 6590 60 {lab=run_ff.net4}
N 6590 60 6600 60 {lab=run_ff.net4}
N 6590 980 3030 980 {lab=run_ff.net4}
N 3030 980 3030 920 {lab=run_ff.net4}
N 3030 920 3040 920 {lab=run_ff.net4}
N 3030 920 3030 740 {lab=run_ff.net4}
N 3030 740 2520 740 {lab=run_ff.net4}
N 3030 740 3030 90 {lab=run_ff.net4}
N 3030 90 2720 90 {lab=run_ff.net4}
N 3030 90 3030 60 {lab=run_ff.net4}
N 3030 60 3040 60 {lab=run_ff.net4}
N 2720 90 2720 100 {lab=run_ff.net4}
N 2720 100 2520 100 {lab=run_ff.net4}
N 2520 100 2520 90 {lab=run_ff.net4}
N 4920 920 4910 920 {lab=start_meta_ff.net4}
N 4910 920 4910 860 {lab=start_meta_ff.net4}
N 4910 860 5000 860 {lab=start_meta_ff.net4}
N 4910 860 4910 710 {lab=start_meta_ff.net4}
N 5000 860 5000 920 {lab=start_meta_ff.net4}
N 5000 920 5280 920 {lab=start_meta_ff.net4}
N 4910 710 4200 710 {lab=start_meta_ff.net4}
N 4910 710 4910 100 {lab=start_meta_ff.net4}
N 4910 100 4400 100 {lab=start_meta_ff.net4}
N 4910 100 4910 60 {lab=start_meta_ff.net4}
N 4910 100 5000 100 {lab=start_meta_ff.net4}
N 4910 60 4920 60 {lab=start_meta_ff.net4}
N 4200 710 4200 740 {lab=start_meta_ff.net4}
N 5000 100 5000 60 {lab=start_meta_ff.net4}
N 5000 60 5280 60 {lab=start_meta_ff.net4}
N 4400 100 4200 100 {lab=start_meta_ff.net4}
N 4400 100 4400 90 {lab=start_meta_ff.net4}
N 4200 100 4200 90 {lab=start_meta_ff.net4}
N 1800 890 1800 660 {lab=run_ff.cki}
N 1800 660 3680 660 {lab=run_ff.cki}
N 1800 660 1800 90 {lab=run_ff.cki}
N 3680 660 3680 620 {lab=run_ff.cki}
N 3680 620 5630 620 {lab=run_ff.cki}
N 5630 620 5630 210 {lab=run_ff.cki}
N 5630 620 5830 620 {lab=run_ff.cki}
N 5830 620 5840 620 {lab=run_ff.cki}
N 5830 620 5830 660 {lab=run_ff.cki}
N 5630 210 5640 210 {lab=run_ff.cki}
N 5830 660 5940 660 {lab=run_ff.cki}
N 5940 660 5940 770 {lab=run_ff.cki}
N 5940 770 6390 770 {lab=run_ff.cki}
N 6390 770 6400 770 {lab=run_ff.cki}
N 6390 770 6390 730 {lab=run_ff.cki}
N 6390 730 6480 730 {lab=run_ff.cki}
N 6480 730 6480 210 {lab=run_ff.cki}
N 6480 210 6600 210 {lab=run_ff.cki}
N 6440 740 6440 710 {lab=run_ff.net8}
N 6440 710 6640 710 {lab=run_ff.net8}
N 6440 710 6440 690 {lab=run_ff.net8}
N 6640 710 6640 740 {lab=run_ff.net8}
N 6440 690 2670 690 {lab=run_ff.net8}
N 6440 690 6440 250 {lab=run_ff.net8}
N 6440 250 6640 250 {lab=run_ff.net8}
N 6440 250 6440 240 {lab=run_ff.net8}
N 6640 250 6640 240 {lab=run_ff.net8}
N 2670 690 2450 690 {lab=run_ff.net8}
N 2670 690 2670 60 {lab=run_ff.net8}
N 2450 690 2450 770 {lab=run_ff.net8}
N 2450 770 2480 770 {lab=run_ff.net8}
N 2670 60 2680 60 {lab=run_ff.net8}
N 2160 890 2160 620 {lab=start_meta_ff.cki}
N 2160 620 2160 90 {lab=start_meta_ff.cki}
N 2160 620 3390 620 {lab=start_meta_ff.cki}
N 3390 620 3590 620 {lab=start_meta_ff.cki}
N 3390 620 3390 210 {lab=start_meta_ff.cki}
N 3590 620 3600 620 {lab=start_meta_ff.cki}
N 3590 620 3590 580 {lab=start_meta_ff.cki}
N 3390 210 3400 210 {lab=start_meta_ff.cki}
N 3590 580 4240 580 {lab=start_meta_ff.cki}
N 4240 580 4240 770 {lab=start_meta_ff.cki}
N 4240 770 4690 770 {lab=start_meta_ff.cki}
N 4690 770 4690 670 {lab=start_meta_ff.cki}
N 4690 770 4720 770 {lab=start_meta_ff.cki}
N 4690 670 4800 670 {lab=start_meta_ff.cki}
N 4800 670 4800 210 {lab=start_meta_ff.cki}
N 4800 210 4920 210 {lab=start_meta_ff.cki}
N 3440 740 3440 560 {lab=start_meta_ff.net1}
N 3440 560 3440 250 {lab=start_meta_ff.net1}
N 3440 560 3640 560 {lab=start_meta_ff.net1}
N 3640 560 3640 590 {lab=start_meta_ff.net1}
N 3640 560 4260 560 {lab=start_meta_ff.net1}
N 3440 250 3840 250 {lab=start_meta_ff.net1}
N 3440 250 3440 240 {lab=start_meta_ff.net1}
N 3840 250 3840 240 {lab=start_meta_ff.net1}
N 4260 560 4440 560 {lab=start_meta_ff.net1}
N 4260 560 4260 920 {lab=start_meta_ff.net1}
N 4260 920 4720 920 {lab=start_meta_ff.net1}
N 4440 560 4440 60 {lab=start_meta_ff.net1}
N 4440 60 4720 60 {lab=start_meta_ff.net1}
N 3600 770 3590 770 {lab=start_meta_ff.net2}
N 3590 770 3570 770 {lab=start_meta_ff.net2}
N 3590 770 3590 830 {lab=start_meta_ff.net2}
N 3570 770 3570 60 {lab=start_meta_ff.net2}
N 3570 60 3600 60 {lab=start_meta_ff.net2}
N 3590 830 4670 830 {lab=start_meta_ff.net2}
N 4670 830 4760 830 {lab=start_meta_ff.net2}
N 4670 830 4670 170 {lab=start_meta_ff.net2}
N 4760 830 4760 890 {lab=start_meta_ff.net2}
N 4760 830 4760 800 {lab=start_meta_ff.net2}
N 4670 170 4760 170 {lab=start_meta_ff.net2}
N 4760 170 4760 90 {lab=start_meta_ff.net2}
N 4760 170 4760 180 {lab=start_meta_ff.net2}
N 4760 740 4760 650 {lab=start_meta_ff.net8}
N 4760 740 4820 740 {lab=start_meta_ff.net8}
N 4820 740 4820 730 {lab=start_meta_ff.net8}
N 4820 730 4960 730 {lab=start_meta_ff.net8}
N 4960 730 4960 740 {lab=start_meta_ff.net8}
N 4760 650 4350 650 {lab=start_meta_ff.net8}
N 4760 650 4760 250 {lab=start_meta_ff.net8}
N 4760 250 4960 250 {lab=start_meta_ff.net8}
N 4760 250 4760 240 {lab=start_meta_ff.net8}
N 4350 650 4130 650 {lab=start_meta_ff.net8}
N 4350 650 4350 60 {lab=start_meta_ff.net8}
N 4130 650 4130 770 {lab=start_meta_ff.net8}
N 4130 770 4160 770 {lab=start_meta_ff.net8}
N 4960 250 4960 240 {lab=start_meta_ff.net8}
N 4350 60 4360 60 {lab=start_meta_ff.net8}
N 5680 740 5680 580 {lab=run_ff.net1}
N 5680 580 5680 240 {lab=run_ff.net1}
N 5680 580 5880 580 {lab=run_ff.net1}
N 5880 580 5880 590 {lab=run_ff.net1}
N 5880 590 5960 590 {lab=run_ff.net1}
N 5960 590 5960 920 {lab=run_ff.net1}
N 5960 590 6080 590 {lab=run_ff.net1}
N 5960 920 6400 920 {lab=run_ff.net1}
N 6080 590 6080 270 {lab=run_ff.net1}
N 6080 270 6140 270 {lab=run_ff.net1}
N 6080 270 6080 240 {lab=run_ff.net1}
N 6140 270 6140 60 {lab=run_ff.net1}
N 6140 60 6400 60 {lab=run_ff.net1}
N 5840 770 5830 770 {lab=run_ff.net2}
N 5830 770 5810 770 {lab=run_ff.net2}
N 5830 770 5830 830 {lab=run_ff.net2}
N 5830 830 6440 830 {lab=run_ff.net2}
N 6440 830 6440 890 {lab=run_ff.net2}
N 6440 830 6440 800 {lab=run_ff.net2}
N 5810 770 5810 170 {lab=run_ff.net2}
N 5810 170 6440 170 {lab=run_ff.net2}
N 5810 170 5810 60 {lab=run_ff.net2}
N 5810 60 5840 60 {lab=run_ff.net2}
N 6440 170 6440 180 {lab=run_ff.net2}
N 6440 170 6440 90 {lab=run_ff.net2}
N 160 740 1120 740 {lab=request_and.Z_neg}
N 160 740 160 100 {lab=request_and.Z_neg}
N 160 100 160 90 {lab=request_and.Z_neg}
N 160 100 360 100 {lab=request_and.Z_neg}
N 360 100 360 90 {lab=request_and.Z_neg}
N 1120 740 1120 920 {lab=request_and.Z_neg}
N 1120 920 1390 920 {lab=request_and.Z_neg}
N 1390 920 1390 60 {lab=request_and.Z_neg}
N 1390 920 1400 920 {lab=request_and.Z_neg}
N 1390 60 1400 60 {lab=request_and.Z_neg}
N 680 920 670 920 {lab=a_n}
N 670 920 670 980 {lab=a_n}
N 670 920 670 490 {lab=a_n}
N 670 980 760 980 {lab=a_n}
N 760 980 760 920 {lab=a_n}
N 760 920 1040 920 {lab=a_n}
N 670 490 670 100 {lab=a_n}
N 670 490 -60 490 {lab=a_n}
N 670 100 670 60 {lab=a_n}
N 670 100 760 100 {lab=a_n}
N 670 60 680 60 {lab=a_n}
N 760 100 760 60 {lab=a_n}
N 760 60 1040 60 {lab=a_n}
N 1440 890 1440 840 {lab=request}
N 1440 840 3120 840 {lab=request}
N 1440 840 1440 90 {lab=request}
N 3120 840 3120 920 {lab=request}
N 3120 920 3370 920 {lab=request}
N 3370 920 3370 60 {lab=request}
N 3370 920 3400 920 {lab=request}
N 3370 60 3400 60 {lab=request}
N 5640 920 5610 920 {lab=start_meta}
N 5610 920 5360 920 {lab=start_meta}
N 5610 920 5610 90 {lab=start_meta}
N 5360 920 5360 890 {lab=start_meta}
N 5360 890 5320 890 {lab=start_meta}
N 5610 90 5610 60 {lab=start_meta}
N 5610 90 5320 90 {lab=start_meta}
N 5610 60 5640 60 {lab=start_meta}
N 5680 890 5680 830 {lab=run_ff.net10}
N 5680 830 5720 830 {lab=run_ff.net10}
N 5680 830 5680 800 {lab=run_ff.net10}
N 5720 830 5720 180 {lab=run_ff.net10}
N 5720 180 5680 180 {lab=run_ff.net10}
N 5680 180 5680 90 {lab=run_ff.net10}
N 6640 800 6680 800 {lab=run_ff.net11}
N 6640 800 6640 890 {lab=run_ff.net11}
N 6680 800 6680 180 {lab=run_ff.net11}
N 6680 180 6640 180 {lab=run_ff.net11}
N 6640 180 6640 90 {lab=run_ff.net11}
N 3440 890 3440 830 {lab=start_meta_ff.net10}
N 3440 830 3440 800 {lab=start_meta_ff.net10}
N 3440 830 3500 830 {lab=start_meta_ff.net10}
N 3500 830 3500 180 {lab=start_meta_ff.net10}
N 3500 180 3440 180 {lab=start_meta_ff.net10}
N 3440 180 3440 90 {lab=start_meta_ff.net10}
N 4960 800 4960 830 {lab=start_meta_ff.net11}
N 4960 830 4960 890 {lab=start_meta_ff.net11}
N 4960 830 5020 830 {lab=start_meta_ff.net11}
N 5020 830 5020 180 {lab=start_meta_ff.net11}
N 5020 180 4960 180 {lab=start_meta_ff.net11}
N 4960 180 4960 90 {lab=start_meta_ff.net11}
N 3080 890 3080 90 {lab=run}
N 3080 90 3120 90 {lab=run}
N 3120 90 3120 0 {lab=run}
N 3120 0 7020 0 {lab=run}
N 7020 0 7020 550 {lab=run}
N 120 920 -60 920 {lab=ui_in_4}
N -60 920 -60 610 {lab=ui_in_4}
N -60 610 200 610 {lab=ui_in_4}
N 200 610 200 60 {lab=ui_in_4}
N 200 60 320 60 {lab=ui_in_4}
N 6080 180 6080 100 {lab=run_ff.net9}
N 6080 100 6080 90 {lab=run_ff.net9}
N 6080 100 5880 100 {lab=run_ff.net9}
N 5880 100 5880 90 {lab=run_ff.net9}
N 3840 180 3840 120 {lab=start_meta_ff.net9}
N 3840 120 3640 120 {lab=start_meta_ff.net9}
N 3840 120 3840 90 {lab=start_meta_ff.net9}
N 3640 120 3640 90 {lab=start_meta_ff.net9}
N 120 770 110 770 {lab=ena}
N 110 770 110 530 {lab=ena}
N 110 530 110 60 {lab=ena}
N 110 530 -60 530 {lab=ena}
N 110 60 120 60 {lab=ena}
N 160 800 160 890 {lab=request_and.net_0}
N 5880 650 5880 740 {lab=run_ff.net15}
N 5880 800 5880 890 {lab=run_ff.net12}
N 2520 890 2520 800 {lab=run_ff.net0}
N 3640 650 3640 740 {lab=start_meta_ff.net15}
N 3640 800 3640 890 {lab=start_meta_ff.net12}
N 4200 890 4200 800 {lab=start_meta_ff.net0}
C {devices/ipin.sym} -60 490 0 0 {name=p104 lab=a_n}
C {devices/ipin.sym} -60 530 0 0 {name=p105 lab=ena}
C {devices/ipin.sym} -60 570 0 0 {name=p106 lab=rst_n}
C {devices/ipin.sym} -60 610 0 0 {name=p107 lab=ui_in_4}
C {devices/opin.sym} 7020 550 0 0 {name=p108 lab=run}
