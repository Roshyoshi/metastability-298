v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {ctrl_readings: controller block "readings" at transistor level (4 cells)} 0 -230 0 0 0.45 0.45 {}
T {Later readings: l1 on b falling (50 ns), l2 on a_n rising (100 ns); event_bit = early XOR l2, bad_bit = l1 XOR l2} 0 -190 0 0 0.26 0.26 {}
T {From src/gf180/compact_control.v; every cell opened up. Stage labels are the cell instance names.} 0 -162 0 0 0.26 0.26 {}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5100 770 0 0 {name=Mbad_xor_i_6 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5300 770 0 0 {name=Mbad_xor_i_7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5660 770 0 0 {name=Mbad_xor_i_2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5660 620 0 0 {name=Mbad_xor_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5860 770 0 0 {name=Mbad_xor_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5100 210 0 0 {name=Mbad_xor_i_8 L=0.5u W=0.56u nf=1 m=1 ad=2.8e-13 as=2.8e-13 pd=2.12e-06 ps=2.12e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5100 60 0 0 {name=Mbad_xor_i_9 L=0.5u W=0.56u nf=1 m=1 ad=2.8e-13 as=2.8e-13 pd=2.12e-06 ps=2.12e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5660 60 0 0 {name=Mbad_xor_i_5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5660 210 0 0 {name=Mbad_xor_i_3 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5860 210 0 0 {name=Mbad_xor_i_4 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1580 770 0 0 {name=Mevent_xor_i_6 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1780 770 0 0 {name=Mevent_xor_i_7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2140 770 0 0 {name=Mevent_xor_i_2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2140 620 0 0 {name=Mevent_xor_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2340 770 0 0 {name=Mevent_xor_i_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1580 210 0 0 {name=Mevent_xor_i_8 L=0.5u W=0.56u nf=1 m=1 ad=2.8e-13 as=2.8e-13 pd=2.12e-06 ps=2.12e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1580 60 0 0 {name=Mevent_xor_i_9 L=0.5u W=0.56u nf=1 m=1 ad=2.8e-13 as=2.8e-13 pd=2.12e-06 ps=2.12e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2140 60 0 0 {name=Mevent_xor_i_5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2140 210 0 0 {name=Mevent_xor_i_3 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2340 210 0 0 {name=Mevent_xor_i_4 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 770 0 0 {name=Ml1_ff_tn9 L=0.6u W=0.465u nf=1 m=1 ad=2.325e-13 as=2.325e-13 pd=1.93e-06 ps=1.93e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 860 770 0 0 {name=Ml1_ff_tn16 L=0.6u W=0.465u nf=1 m=1 ad=2.325e-13 as=2.325e-13 pd=1.93e-06 ps=1.93e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2700 770 0 0 {name=Ml1_ff_tn10 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2700 620 0 0 {name=Ml1_ff_tn11 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2900 620 0 0 {name=Ml1_ff_tn0 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2900 770 0 0 {name=Ml1_ff_tn1 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3820 770 0 0 {name=Ml1_ff_tn15 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3820 620 0 0 {name=Ml1_ff_tn2 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4020 620 0 0 {name=Ml1_ff_tn3 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4020 770 0 0 {name=Ml1_ff_tn4 L=0.6u W=0.63u nf=1 m=1 ad=3.15e-13 as=3.15e-13 pd=2.26e-06 ps=2.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4380 770 0 0 {name=Ml1_ff_tn5 L=0.6u W=0.63u nf=1 m=1 ad=3.15e-13 as=3.15e-13 pd=2.26e-06 ps=2.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4740 770 0 0 {name=Ml1_ff_tn6 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=Ml1_ff_tp9 L=0.5u W=0.865u nf=1 m=1 ad=4.325e-13 as=4.325e-13 pd=2.73e-06 ps=2.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 860 60 0 0 {name=Ml1_ff_tp16 L=0.5u W=0.865u nf=1 m=1 ad=4.325e-13 as=4.325e-13 pd=2.73e-06 ps=2.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2700 60 0 0 {name=Ml1_ff_tp10 L=0.5u W=0.495u nf=1 m=1 ad=2.475e-13 as=2.475e-13 pd=1.99e-06 ps=1.99e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2700 210 0 0 {name=Ml1_ff_tp11 L=0.5u W=0.495u nf=1 m=1 ad=2.475e-13 as=2.475e-13 pd=1.99e-06 ps=1.99e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2900 210 0 0 {name=Ml1_ff_tp0 L=0.5u W=0.495u nf=1 m=1 ad=2.475e-13 as=2.475e-13 pd=1.99e-06 ps=1.99e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2900 60 0 0 {name=Ml1_ff_tp1 L=0.5u W=0.495u nf=1 m=1 ad=2.475e-13 as=2.475e-13 pd=1.99e-06 ps=1.99e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3820 60 0 0 {name=Ml1_ff_tp15 L=0.5u W=0.495u nf=1 m=1 ad=2.475e-13 as=2.475e-13 pd=1.99e-06 ps=1.99e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3820 210 0 0 {name=Ml1_ff_tp7 L=0.5u W=0.495u nf=1 m=1 ad=2.475e-13 as=2.475e-13 pd=1.99e-06 ps=1.99e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4020 210 0 0 {name=Ml1_ff_tp6 L=0.5u W=0.495u nf=1 m=1 ad=2.475e-13 as=2.475e-13 pd=1.99e-06 ps=1.99e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4020 60 0 0 {name=Ml1_ff_tp2 L=0.5u W=1.075u nf=1 m=1 ad=5.375e-13 as=5.375e-13 pd=3.15e-06 ps=3.15e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4380 60 0 0 {name=Ml1_ff_tp3 L=0.5u W=1.075u nf=1 m=1 ad=5.375e-13 as=5.375e-13 pd=3.15e-06 ps=3.15e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4740 60 0 0 {name=Ml1_ff_tp4 L=0.5u W=1.13u nf=1 m=1 ad=5.65e-13 as=5.65e-13 pd=3.26e-06 ps=3.26e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 500 770 0 0 {name=Ml2_ff_tn3 L=0.6u W=0.405u nf=1 m=1 ad=2.025e-13 as=2.025e-13 pd=1.81e-06 ps=1.81e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1220 770 0 0 {name=Ml2_ff_tn4 L=0.6u W=0.405u nf=1 m=1 ad=2.025e-13 as=2.025e-13 pd=1.81e-06 ps=1.81e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3260 770 0 0 {name=Ml2_ff_tn5 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3260 620 0 0 {name=Ml2_ff_tn8 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3460 620 0 0 {name=Ml2_ff_tn6 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3460 770 0 0 {name=Ml2_ff_tn7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6220 770 0 0 {name=Ml2_ff_tn0 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6220 620 0 0 {name=Ml2_ff_tn9 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6420 620 0 0 {name=Ml2_ff_tn11 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6420 770 0 0 {name=Ml2_ff_tn12 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6780 770 0 0 {name=Ml2_ff_tn10 L=0.6u W=0.4u nf=1 m=1 ad=2e-13 as=2e-13 pd=1.8e-06 ps=1.8e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 7140 770 0 0 {name=Ml2_ff_tn1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 500 60 0 0 {name=Ml2_ff_tp3 L=0.5u W=0.865u nf=1 m=1 ad=4.325e-13 as=4.325e-13 pd=2.73e-06 ps=2.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1220 60 0 0 {name=Ml2_ff_tp4 L=0.5u W=0.865u nf=1 m=1 ad=4.325e-13 as=4.325e-13 pd=2.73e-06 ps=2.73e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3260 60 0 0 {name=Ml2_ff_tp12 L=0.5u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3260 210 0 0 {name=Ml2_ff_tp11 L=0.5u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3460 210 0 0 {name=Ml2_ff_tp6 L=0.5u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3460 60 0 0 {name=Ml2_ff_tp5 L=0.5u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6220 60 0 0 {name=Ml2_ff_tp0 L=0.5u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6220 210 0 0 {name=Ml2_ff_tp7 L=0.5u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6420 210 0 0 {name=Ml2_ff_tp9 L=0.5u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6420 60 0 0 {name=Ml2_ff_tp10 L=0.5u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6780 60 0 0 {name=Ml2_ff_tp8 L=0.5u W=0.8u nf=1 m=1 ad=4e-13 as=4e-13 pd=2.6e-06 ps=2.6e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 7140 60 0 0 {name=Ml2_ff_tp1 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
T {bad_xor} 5070 -35 0 0 0.3 0.3 {}
T {event_xor} 1550 -35 0 0 0.3 0.3 {}
T {l1_ff} 110 -35 0 0 0.3 0.3 {}
T {l2_ff} 470 -35 0 0 0.3 0.3 {}
N 5120 800 5120 820 {lab=0}
C {devices/gnd.sym} 5120 820 0 0 {name=s1 lab=0}
N 5120 770 5150 770 {lab=0}
C {devices/gnd.sym} 5150 770 0 0 {name=s2 lab=0}
N 5320 800 5320 820 {lab=0}
C {devices/gnd.sym} 5320 820 0 0 {name=s3 lab=0}
N 5320 770 5350 770 {lab=0}
C {devices/gnd.sym} 5350 770 0 0 {name=s4 lab=0}
N 5680 800 5680 820 {lab=0}
C {devices/gnd.sym} 5680 820 0 0 {name=s5 lab=0}
N 5680 770 5710 770 {lab=0}
C {devices/gnd.sym} 5710 770 0 0 {name=s6 lab=0}
N 5680 620 5710 620 {lab=0}
C {devices/gnd.sym} 5710 620 0 0 {name=s7 lab=0}
N 5880 800 5880 820 {lab=0}
C {devices/gnd.sym} 5880 820 0 0 {name=s8 lab=0}
N 5880 770 5910 770 {lab=0}
C {devices/gnd.sym} 5910 770 0 0 {name=s9 lab=0}
N 5120 210 5150 210 {lab=VDD}
C {devices/vdd.sym} 5150 210 0 0 {name=s10 lab=VDD}
N 5120 30 5120 10 {lab=VDD}
C {devices/vdd.sym} 5120 10 0 0 {name=s11 lab=VDD}
N 5120 60 5150 60 {lab=VDD}
C {devices/vdd.sym} 5150 60 0 0 {name=s12 lab=VDD}
N 5680 30 5680 10 {lab=VDD}
C {devices/vdd.sym} 5680 10 0 0 {name=s13 lab=VDD}
N 5680 60 5710 60 {lab=VDD}
C {devices/vdd.sym} 5710 60 0 0 {name=s14 lab=VDD}
N 5680 210 5710 210 {lab=VDD}
C {devices/vdd.sym} 5710 210 0 0 {name=s15 lab=VDD}
N 5880 210 5910 210 {lab=VDD}
C {devices/vdd.sym} 5910 210 0 0 {name=s16 lab=VDD}
N 1600 800 1600 820 {lab=0}
C {devices/gnd.sym} 1600 820 0 0 {name=s17 lab=0}
N 1600 770 1630 770 {lab=0}
C {devices/gnd.sym} 1630 770 0 0 {name=s18 lab=0}
N 1800 800 1800 820 {lab=0}
C {devices/gnd.sym} 1800 820 0 0 {name=s19 lab=0}
N 1800 770 1830 770 {lab=0}
C {devices/gnd.sym} 1830 770 0 0 {name=s20 lab=0}
N 2160 800 2160 820 {lab=0}
C {devices/gnd.sym} 2160 820 0 0 {name=s21 lab=0}
N 2160 770 2190 770 {lab=0}
C {devices/gnd.sym} 2190 770 0 0 {name=s22 lab=0}
N 2160 620 2190 620 {lab=0}
C {devices/gnd.sym} 2190 620 0 0 {name=s23 lab=0}
N 2360 800 2360 820 {lab=0}
C {devices/gnd.sym} 2360 820 0 0 {name=s24 lab=0}
N 2360 770 2390 770 {lab=0}
C {devices/gnd.sym} 2390 770 0 0 {name=s25 lab=0}
N 1600 210 1630 210 {lab=VDD}
C {devices/vdd.sym} 1630 210 0 0 {name=s26 lab=VDD}
N 1600 30 1600 10 {lab=VDD}
C {devices/vdd.sym} 1600 10 0 0 {name=s27 lab=VDD}
N 1600 60 1630 60 {lab=VDD}
C {devices/vdd.sym} 1630 60 0 0 {name=s28 lab=VDD}
N 2160 30 2160 10 {lab=VDD}
C {devices/vdd.sym} 2160 10 0 0 {name=s29 lab=VDD}
N 2160 60 2190 60 {lab=VDD}
C {devices/vdd.sym} 2190 60 0 0 {name=s30 lab=VDD}
N 2160 210 2190 210 {lab=VDD}
C {devices/vdd.sym} 2190 210 0 0 {name=s31 lab=VDD}
N 2360 210 2390 210 {lab=VDD}
C {devices/vdd.sym} 2390 210 0 0 {name=s32 lab=VDD}
N 160 800 160 820 {lab=0}
C {devices/gnd.sym} 160 820 0 0 {name=s33 lab=0}
N 160 770 190 770 {lab=0}
C {devices/gnd.sym} 190 770 0 0 {name=s34 lab=0}
N 880 800 880 820 {lab=0}
C {devices/gnd.sym} 880 820 0 0 {name=s35 lab=0}
N 880 770 910 770 {lab=0}
C {devices/gnd.sym} 910 770 0 0 {name=s36 lab=0}
N 2720 800 2720 820 {lab=0}
C {devices/gnd.sym} 2720 820 0 0 {name=s37 lab=0}
N 2720 770 2750 770 {lab=0}
C {devices/gnd.sym} 2750 770 0 0 {name=s38 lab=0}
N 2720 620 2750 620 {lab=0}
C {devices/gnd.sym} 2750 620 0 0 {name=s39 lab=0}
N 2920 620 2950 620 {lab=0}
C {devices/gnd.sym} 2950 620 0 0 {name=s40 lab=0}
N 2920 800 2920 820 {lab=0}
C {devices/gnd.sym} 2920 820 0 0 {name=s41 lab=0}
N 2920 770 2950 770 {lab=0}
C {devices/gnd.sym} 2950 770 0 0 {name=s42 lab=0}
N 3840 800 3840 820 {lab=0}
C {devices/gnd.sym} 3840 820 0 0 {name=s43 lab=0}
N 3840 770 3870 770 {lab=0}
C {devices/gnd.sym} 3870 770 0 0 {name=s44 lab=0}
N 3840 620 3870 620 {lab=0}
C {devices/gnd.sym} 3870 620 0 0 {name=s45 lab=0}
N 4040 620 4070 620 {lab=0}
C {devices/gnd.sym} 4070 620 0 0 {name=s46 lab=0}
N 4040 800 4040 820 {lab=0}
C {devices/gnd.sym} 4040 820 0 0 {name=s47 lab=0}
N 4040 770 4070 770 {lab=0}
C {devices/gnd.sym} 4070 770 0 0 {name=s48 lab=0}
N 4400 800 4400 820 {lab=0}
C {devices/gnd.sym} 4400 820 0 0 {name=s49 lab=0}
N 4400 770 4430 770 {lab=0}
C {devices/gnd.sym} 4430 770 0 0 {name=s50 lab=0}
N 4760 800 4760 820 {lab=0}
C {devices/gnd.sym} 4760 820 0 0 {name=s51 lab=0}
N 4760 770 4790 770 {lab=0}
C {devices/gnd.sym} 4790 770 0 0 {name=s52 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s53 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s54 lab=VDD}
N 880 30 880 10 {lab=VDD}
C {devices/vdd.sym} 880 10 0 0 {name=s55 lab=VDD}
N 880 60 910 60 {lab=VDD}
C {devices/vdd.sym} 910 60 0 0 {name=s56 lab=VDD}
N 2720 30 2720 10 {lab=VDD}
C {devices/vdd.sym} 2720 10 0 0 {name=s57 lab=VDD}
N 2720 60 2750 60 {lab=VDD}
C {devices/vdd.sym} 2750 60 0 0 {name=s58 lab=VDD}
N 2720 210 2750 210 {lab=VDD}
C {devices/vdd.sym} 2750 210 0 0 {name=s59 lab=VDD}
N 2920 210 2950 210 {lab=VDD}
C {devices/vdd.sym} 2950 210 0 0 {name=s60 lab=VDD}
N 2920 30 2920 10 {lab=VDD}
C {devices/vdd.sym} 2920 10 0 0 {name=s61 lab=VDD}
N 2920 60 2950 60 {lab=VDD}
C {devices/vdd.sym} 2950 60 0 0 {name=s62 lab=VDD}
N 3840 30 3840 10 {lab=VDD}
C {devices/vdd.sym} 3840 10 0 0 {name=s63 lab=VDD}
N 3840 60 3870 60 {lab=VDD}
C {devices/vdd.sym} 3870 60 0 0 {name=s64 lab=VDD}
N 3840 210 3870 210 {lab=VDD}
C {devices/vdd.sym} 3870 210 0 0 {name=s65 lab=VDD}
N 4040 210 4070 210 {lab=VDD}
C {devices/vdd.sym} 4070 210 0 0 {name=s66 lab=VDD}
N 4040 30 4040 10 {lab=VDD}
C {devices/vdd.sym} 4040 10 0 0 {name=s67 lab=VDD}
N 4040 60 4070 60 {lab=VDD}
C {devices/vdd.sym} 4070 60 0 0 {name=s68 lab=VDD}
N 4400 30 4400 10 {lab=VDD}
C {devices/vdd.sym} 4400 10 0 0 {name=s69 lab=VDD}
N 4400 60 4430 60 {lab=VDD}
C {devices/vdd.sym} 4430 60 0 0 {name=s70 lab=VDD}
N 4760 30 4760 10 {lab=VDD}
C {devices/vdd.sym} 4760 10 0 0 {name=s71 lab=VDD}
N 4760 60 4790 60 {lab=VDD}
C {devices/vdd.sym} 4790 60 0 0 {name=s72 lab=VDD}
N 520 800 520 820 {lab=0}
C {devices/gnd.sym} 520 820 0 0 {name=s73 lab=0}
N 520 770 550 770 {lab=0}
C {devices/gnd.sym} 550 770 0 0 {name=s74 lab=0}
N 1240 800 1240 820 {lab=0}
C {devices/gnd.sym} 1240 820 0 0 {name=s75 lab=0}
N 1240 770 1270 770 {lab=0}
C {devices/gnd.sym} 1270 770 0 0 {name=s76 lab=0}
N 3280 800 3280 820 {lab=0}
C {devices/gnd.sym} 3280 820 0 0 {name=s77 lab=0}
N 3280 770 3310 770 {lab=0}
C {devices/gnd.sym} 3310 770 0 0 {name=s78 lab=0}
N 3280 620 3310 620 {lab=0}
C {devices/gnd.sym} 3310 620 0 0 {name=s79 lab=0}
N 3480 620 3510 620 {lab=0}
C {devices/gnd.sym} 3510 620 0 0 {name=s80 lab=0}
N 3480 800 3480 820 {lab=0}
C {devices/gnd.sym} 3480 820 0 0 {name=s81 lab=0}
N 3480 770 3510 770 {lab=0}
C {devices/gnd.sym} 3510 770 0 0 {name=s82 lab=0}
N 6240 800 6240 820 {lab=0}
C {devices/gnd.sym} 6240 820 0 0 {name=s83 lab=0}
N 6240 770 6270 770 {lab=0}
C {devices/gnd.sym} 6270 770 0 0 {name=s84 lab=0}
N 6240 620 6270 620 {lab=0}
C {devices/gnd.sym} 6270 620 0 0 {name=s85 lab=0}
N 6440 620 6470 620 {lab=0}
C {devices/gnd.sym} 6470 620 0 0 {name=s86 lab=0}
N 6440 800 6440 820 {lab=0}
C {devices/gnd.sym} 6440 820 0 0 {name=s87 lab=0}
N 6440 770 6470 770 {lab=0}
C {devices/gnd.sym} 6470 770 0 0 {name=s88 lab=0}
N 6800 800 6800 820 {lab=0}
C {devices/gnd.sym} 6800 820 0 0 {name=s89 lab=0}
N 6800 770 6830 770 {lab=0}
C {devices/gnd.sym} 6830 770 0 0 {name=s90 lab=0}
N 7160 800 7160 820 {lab=0}
C {devices/gnd.sym} 7160 820 0 0 {name=s91 lab=0}
N 7160 770 7190 770 {lab=0}
C {devices/gnd.sym} 7190 770 0 0 {name=s92 lab=0}
N 520 30 520 10 {lab=VDD}
C {devices/vdd.sym} 520 10 0 0 {name=s93 lab=VDD}
N 520 60 550 60 {lab=VDD}
C {devices/vdd.sym} 550 60 0 0 {name=s94 lab=VDD}
N 1240 30 1240 10 {lab=VDD}
C {devices/vdd.sym} 1240 10 0 0 {name=s95 lab=VDD}
N 1240 60 1270 60 {lab=VDD}
C {devices/vdd.sym} 1270 60 0 0 {name=s96 lab=VDD}
N 3280 30 3280 10 {lab=VDD}
C {devices/vdd.sym} 3280 10 0 0 {name=s97 lab=VDD}
N 3280 60 3310 60 {lab=VDD}
C {devices/vdd.sym} 3310 60 0 0 {name=s98 lab=VDD}
N 3280 210 3310 210 {lab=VDD}
C {devices/vdd.sym} 3310 210 0 0 {name=s99 lab=VDD}
N 3480 210 3510 210 {lab=VDD}
C {devices/vdd.sym} 3510 210 0 0 {name=s100 lab=VDD}
N 3480 30 3480 10 {lab=VDD}
C {devices/vdd.sym} 3480 10 0 0 {name=s101 lab=VDD}
N 3480 60 3510 60 {lab=VDD}
C {devices/vdd.sym} 3510 60 0 0 {name=s102 lab=VDD}
N 6240 30 6240 10 {lab=VDD}
C {devices/vdd.sym} 6240 10 0 0 {name=s103 lab=VDD}
N 6240 60 6270 60 {lab=VDD}
C {devices/vdd.sym} 6270 60 0 0 {name=s104 lab=VDD}
N 6240 210 6270 210 {lab=VDD}
C {devices/vdd.sym} 6270 210 0 0 {name=s105 lab=VDD}
N 6440 210 6470 210 {lab=VDD}
C {devices/vdd.sym} 6470 210 0 0 {name=s106 lab=VDD}
N 6440 30 6440 10 {lab=VDD}
C {devices/vdd.sym} 6440 10 0 0 {name=s107 lab=VDD}
N 6440 60 6470 60 {lab=VDD}
C {devices/vdd.sym} 6470 60 0 0 {name=s108 lab=VDD}
N 6800 30 6800 10 {lab=VDD}
C {devices/vdd.sym} 6800 10 0 0 {name=s109 lab=VDD}
N 6800 60 6830 60 {lab=VDD}
C {devices/vdd.sym} 6830 60 0 0 {name=s110 lab=VDD}
N 7160 30 7160 10 {lab=VDD}
C {devices/vdd.sym} 7160 10 0 0 {name=s111 lab=VDD}
N 7160 60 7190 60 {lab=VDD}
C {devices/vdd.sym} 7190 60 0 0 {name=s112 lab=VDD}
N 5080 770 5070 770 {lab=l2}
N 5070 770 5070 730 {lab=l2}
N 5070 730 2310 730 {lab=l2}
N 5070 730 5070 210 {lab=l2}
N 5070 730 5720 730 {lab=l2}
N 5070 210 5080 210 {lab=l2}
N 5720 730 5720 770 {lab=l2}
N 5720 770 5830 770 {lab=l2}
N 5830 770 5830 730 {lab=l2}
N 5830 770 5840 770 {lab=l2}
N 5830 730 5830 210 {lab=l2}
N 5830 730 7160 730 {lab=l2}
N 5830 210 5840 210 {lab=l2}
N 7160 730 7160 90 {lab=l2}
N 7160 730 7160 740 {lab=l2}
N 2310 730 2310 770 {lab=l2}
N 2310 730 1550 730 {lab=l2}
N 2310 730 2310 210 {lab=l2}
N 2310 770 2320 770 {lab=l2}
N 2310 210 2320 210 {lab=l2}
N 1550 730 1550 770 {lab=l2}
N 1550 730 1550 210 {lab=l2}
N 1550 770 1560 770 {lab=l2}
N 1550 210 1560 210 {lab=l2}
N 520 740 520 730 {lab=l2_ff.ncki}
N 520 730 920 730 {lab=l2_ff.ncki}
N 520 730 520 90 {lab=l2_ff.ncki}
N 920 730 920 770 {lab=l2_ff.ncki}
N 920 770 1190 770 {lab=l2_ff.ncki}
N 1190 770 1190 60 {lab=l2_ff.ncki}
N 1190 770 1190 830 {lab=l2_ff.ncki}
N 1190 770 1200 770 {lab=l2_ff.ncki}
N 1190 60 1200 60 {lab=l2_ff.ncki}
N 1190 830 2960 830 {lab=l2_ff.ncki}
N 2960 830 2960 770 {lab=l2_ff.ncki}
N 2960 770 3230 770 {lab=l2_ff.ncki}
N 3230 770 3230 710 {lab=l2_ff.ncki}
N 3230 770 3240 770 {lab=l2_ff.ncki}
N 3230 710 3320 710 {lab=l2_ff.ncki}
N 3320 710 3320 660 {lab=l2_ff.ncki}
N 3320 660 6190 660 {lab=l2_ff.ncki}
N 3320 660 3320 210 {lab=l2_ff.ncki}
N 3320 210 3440 210 {lab=l2_ff.ncki}
N 6190 660 6190 210 {lab=l2_ff.ncki}
N 6190 660 6280 660 {lab=l2_ff.ncki}
N 6280 660 6280 620 {lab=l2_ff.ncki}
N 6280 620 6400 620 {lab=l2_ff.ncki}
N 6190 210 6200 210 {lab=l2_ff.ncki}
N 160 740 160 710 {lab=l1_ff.ncki}
N 160 710 160 90 {lab=l1_ff.ncki}
N 160 710 560 710 {lab=l1_ff.ncki}
N 560 710 560 770 {lab=l1_ff.ncki}
N 560 770 830 770 {lab=l1_ff.ncki}
N 830 770 840 770 {lab=l1_ff.ncki}
N 830 770 830 660 {lab=l1_ff.ncki}
N 830 660 2670 660 {lab=l1_ff.ncki}
N 830 660 830 60 {lab=l1_ff.ncki}
N 830 60 840 60 {lab=l1_ff.ncki}
N 2670 660 2760 660 {lab=l1_ff.ncki}
N 2670 660 2670 210 {lab=l1_ff.ncki}
N 2760 660 2760 620 {lab=l1_ff.ncki}
N 2760 620 2870 620 {lab=l1_ff.ncki}
N 2870 620 2870 580 {lab=l1_ff.ncki}
N 2870 620 2880 620 {lab=l1_ff.ncki}
N 2670 210 2680 210 {lab=l1_ff.ncki}
N 2870 580 3520 580 {lab=l1_ff.ncki}
N 3520 580 3520 620 {lab=l1_ff.ncki}
N 3520 620 3790 620 {lab=l1_ff.ncki}
N 3790 620 3790 580 {lab=l1_ff.ncki}
N 3790 620 3800 620 {lab=l1_ff.ncki}
N 3790 580 3880 580 {lab=l1_ff.ncki}
N 3880 580 3880 210 {lab=l1_ff.ncki}
N 3880 210 4000 210 {lab=l1_ff.ncki}
N 1240 740 1240 680 {lab=l2_ff.cki}
N 1240 680 1240 90 {lab=l2_ff.cki}
N 1240 680 3230 680 {lab=l2_ff.cki}
N 3230 680 3340 680 {lab=l2_ff.cki}
N 3230 680 3230 60 {lab=l2_ff.cki}
N 3340 680 5720 680 {lab=l2_ff.cki}
N 3340 680 3340 620 {lab=l2_ff.cki}
N 3340 620 3440 620 {lab=l2_ff.cki}
N 3230 60 3240 60 {lab=l2_ff.cki}
N 5720 680 5720 620 {lab=l2_ff.cki}
N 5720 620 6170 620 {lab=l2_ff.cki}
N 6170 620 6200 620 {lab=l2_ff.cki}
N 6170 620 6170 580 {lab=l2_ff.cki}
N 6170 580 6280 580 {lab=l2_ff.cki}
N 6280 580 6280 210 {lab=l2_ff.cki}
N 6280 210 6400 210 {lab=l2_ff.cki}
N 880 740 880 580 {lab=l1_ff.cki}
N 880 580 2200 580 {lab=l1_ff.cki}
N 880 580 880 90 {lab=l1_ff.cki}
N 2200 580 2200 620 {lab=l1_ff.cki}
N 2200 620 2650 620 {lab=l1_ff.cki}
N 2650 620 2650 580 {lab=l1_ff.cki}
N 2650 620 2680 620 {lab=l1_ff.cki}
N 2650 580 2760 580 {lab=l1_ff.cki}
N 2760 580 2760 560 {lab=l1_ff.cki}
N 2760 560 2760 210 {lab=l1_ff.cki}
N 2760 560 3790 560 {lab=l1_ff.cki}
N 2760 210 2880 210 {lab=l1_ff.cki}
N 3790 560 3790 210 {lab=l1_ff.cki}
N 3790 560 3900 560 {lab=l1_ff.cki}
N 3900 560 3900 620 {lab=l1_ff.cki}
N 3900 620 4000 620 {lab=l1_ff.cki}
N 3790 210 3800 210 {lab=l1_ff.cki}
N 3280 590 3280 540 {lab=l2_ff.net4}
N 3280 540 3280 240 {lab=l2_ff.net4}
N 3280 540 3480 540 {lab=l2_ff.net4}
N 3480 540 5920 540 {lab=l2_ff.net4}
N 3480 540 3480 240 {lab=l2_ff.net4}
N 3480 540 3480 590 {lab=l2_ff.net4}
N 5920 540 5920 60 {lab=l2_ff.net4}
N 5920 540 5920 770 {lab=l2_ff.net4}
N 5920 770 6200 770 {lab=l2_ff.net4}
N 5920 60 6200 60 {lab=l2_ff.net4}
N 3440 770 3430 770 {lab=l2_ff.net0}
N 3430 770 3430 710 {lab=l2_ff.net0}
N 3430 710 6240 710 {lab=l2_ff.net0}
N 3430 710 3430 60 {lab=l2_ff.net0}
N 3430 60 3440 60 {lab=l2_ff.net0}
N 6240 710 6240 680 {lab=l2_ff.net0}
N 6240 710 6240 740 {lab=l2_ff.net0}
N 6240 680 6300 680 {lab=l2_ff.net0}
N 6240 680 6240 650 {lab=l2_ff.net0}
N 6300 680 6300 180 {lab=l2_ff.net0}
N 6300 180 6240 180 {lab=l2_ff.net0}
N 6240 180 6240 90 {lab=l2_ff.net0}
N 2720 590 2720 540 {lab=l1_ff.net5}
N 2720 540 2720 240 {lab=l1_ff.net5}
N 2720 540 2920 540 {lab=l1_ff.net5}
N 2920 540 2920 590 {lab=l1_ff.net5}
N 2920 540 2920 240 {lab=l1_ff.net5}
N 2920 590 2980 590 {lab=l1_ff.net5}
N 2980 590 2980 830 {lab=l1_ff.net5}
N 2980 830 3520 830 {lab=l1_ff.net5}
N 3520 830 3520 770 {lab=l1_ff.net5}
N 3520 770 3770 770 {lab=l1_ff.net5}
N 3770 770 3770 60 {lab=l1_ff.net5}
N 3770 770 3800 770 {lab=l1_ff.net5}
N 3770 60 3800 60 {lab=l1_ff.net5}
N 2880 770 2870 770 {lab=l1_ff.net10}
N 2870 770 2870 850 {lab=l1_ff.net10}
N 2870 770 2850 770 {lab=l1_ff.net10}
N 2850 770 2850 60 {lab=l1_ff.net10}
N 2850 60 2880 60 {lab=l1_ff.net10}
N 2870 850 3880 850 {lab=l1_ff.net10}
N 3880 850 3880 740 {lab=l1_ff.net10}
N 3880 740 3840 740 {lab=l1_ff.net10}
N 3840 740 3840 650 {lab=l1_ff.net10}
N 3840 650 3850 650 {lab=l1_ff.net10}
N 3850 650 3850 640 {lab=l1_ff.net10}
N 3850 640 3920 640 {lab=l1_ff.net10}
N 3920 640 3920 180 {lab=l1_ff.net10}
N 3920 180 3840 180 {lab=l1_ff.net10}
N 3840 180 3840 90 {lab=l1_ff.net10}
N 5280 770 5270 770 {lab=l1}
N 5270 770 5270 640 {lab=l1}
N 5270 640 5270 620 {lab=l1}
N 5270 640 5050 640 {lab=l1}
N 5270 620 5630 620 {lab=l1}
N 5630 620 5630 210 {lab=l1}
N 5630 620 5640 620 {lab=l1}
N 5050 640 5050 90 {lab=l1}
N 5050 640 4760 640 {lab=l1}
N 4760 640 4760 740 {lab=l1}
N 5050 90 4760 90 {lab=l1}
N 5050 90 5050 60 {lab=l1}
N 5050 60 5080 60 {lab=l1}
N 5630 210 5640 210 {lab=l1}
N 4000 770 3990 770 {lab=l1_ff.net1}
N 3990 770 3990 100 {lab=l1_ff.net1}
N 3990 770 3990 830 {lab=l1_ff.net1}
N 3990 830 4440 830 {lab=l1_ff.net1}
N 4440 830 4440 770 {lab=l1_ff.net1}
N 4440 770 4440 740 {lab=l1_ff.net1}
N 4440 770 4720 770 {lab=l1_ff.net1}
N 4440 740 4400 740 {lab=l1_ff.net1}
N 3990 100 3990 60 {lab=l1_ff.net1}
N 3990 100 4400 100 {lab=l1_ff.net1}
N 3990 60 4000 60 {lab=l1_ff.net1}
N 4400 100 4400 90 {lab=l1_ff.net1}
N 4400 90 4440 90 {lab=l1_ff.net1}
N 4440 90 4440 60 {lab=l1_ff.net1}
N 4440 60 4720 60 {lab=l1_ff.net1}
N 6400 770 6390 770 {lab=l2_ff.net3}
N 6390 770 6390 710 {lab=l2_ff.net3}
N 6390 710 6800 710 {lab=l2_ff.net3}
N 6390 710 6390 100 {lab=l2_ff.net3}
N 6800 710 6800 740 {lab=l2_ff.net3}
N 6800 710 6840 710 {lab=l2_ff.net3}
N 6390 100 6800 100 {lab=l2_ff.net3}
N 6390 100 6390 60 {lab=l2_ff.net3}
N 6390 60 6400 60 {lab=l2_ff.net3}
N 6840 710 6840 770 {lab=l2_ff.net3}
N 6840 770 7120 770 {lab=l2_ff.net3}
N 6800 100 6800 90 {lab=l2_ff.net3}
N 6800 90 6840 90 {lab=l2_ff.net3}
N 6840 90 6840 60 {lab=l2_ff.net3}
N 6840 60 7120 60 {lab=l2_ff.net3}
N 3840 590 3940 590 {lab=l1_ff.net0}
N 3840 590 3840 240 {lab=l1_ff.net0}
N 3940 590 3940 580 {lab=l1_ff.net0}
N 3940 580 4040 580 {lab=l1_ff.net0}
N 4040 580 4040 590 {lab=l1_ff.net0}
N 4040 580 4040 240 {lab=l1_ff.net0}
N 4040 590 4080 590 {lab=l1_ff.net0}
N 4040 240 4080 240 {lab=l1_ff.net0}
N 4080 590 4080 770 {lab=l1_ff.net0}
N 4080 770 4360 770 {lab=l1_ff.net0}
N 4080 240 4080 60 {lab=l1_ff.net0}
N 4080 60 4360 60 {lab=l1_ff.net0}
N 6240 590 6240 560 {lab=l2_ff.net2}
N 6240 560 6240 240 {lab=l2_ff.net2}
N 6240 560 6440 560 {lab=l2_ff.net2}
N 6440 560 6440 590 {lab=l2_ff.net2}
N 6440 560 6440 240 {lab=l2_ff.net2}
N 6440 590 6480 590 {lab=l2_ff.net2}
N 6440 240 6480 240 {lab=l2_ff.net2}
N 6480 590 6480 770 {lab=l2_ff.net2}
N 6480 770 6760 770 {lab=l2_ff.net2}
N 6480 240 6480 60 {lab=l2_ff.net2}
N 6480 60 6760 60 {lab=l2_ff.net2}
N 2160 740 2160 650 {lab=event_bit}
N 2160 650 2220 650 {lab=event_bit}
N 2220 650 2220 250 {lab=event_bit}
N 2220 250 2360 250 {lab=event_bit}
N 2220 250 2220 240 {lab=event_bit}
N 2220 240 2160 240 {lab=event_bit}
N 2360 250 2360 240 {lab=event_bit}
N 2360 240 2400 240 {lab=event_bit}
N 2400 240 2400 0 {lab=event_bit}
N 2400 0 7200 0 {lab=event_bit}
N 7200 0 7200 490 {lab=event_bit}
N 7200 490 7540 490 {lab=event_bit}
N 2680 770 2630 770 {lab=selected_q}
N 2630 770 2630 700 {lab=selected_q}
N 2630 700 2960 700 {lab=selected_q}
N 2630 700 2630 530 {lab=selected_q}
N 2630 530 -60 530 {lab=selected_q}
N 2630 530 2630 60 {lab=selected_q}
N 2630 60 2680 60 {lab=selected_q}
N 2960 700 2960 620 {lab=selected_q}
N 2960 620 3210 620 {lab=selected_q}
N 3210 620 3240 620 {lab=selected_q}
N 3210 620 3210 210 {lab=selected_q}
N 3210 210 3240 210 {lab=selected_q}
N 1760 770 1750 770 {lab=early_q}
N 1750 770 1750 620 {lab=early_q}
N 1750 620 1750 490 {lab=early_q}
N 1750 620 2120 620 {lab=early_q}
N 1750 490 -60 490 {lab=early_q}
N 1750 490 1750 210 {lab=early_q}
N 1750 210 2120 210 {lab=early_q}
N 1750 210 1750 170 {lab=early_q}
N 1750 170 1550 170 {lab=early_q}
N 1550 170 1550 60 {lab=early_q}
N 1550 60 1560 60 {lab=early_q}
N 5680 740 5680 650 {lab=bad_bit}
N 5680 650 5740 650 {lab=bad_bit}
N 5740 650 5740 450 {lab=bad_bit}
N 5740 450 5740 250 {lab=bad_bit}
N 5740 450 7540 450 {lab=bad_bit}
N 5740 250 5880 250 {lab=bad_bit}
N 5740 250 5740 240 {lab=bad_bit}
N 5740 240 5680 240 {lab=bad_bit}
N 5880 250 5880 240 {lab=bad_bit}
N 5120 740 5120 240 {lab=bad_xor.I}
N 5120 740 5160 740 {lab=bad_xor.I}
N 5160 740 5160 830 {lab=bad_xor.I}
N 5160 830 5360 830 {lab=bad_xor.I}
N 5360 830 5360 770 {lab=bad_xor.I}
N 5360 770 5640 770 {lab=bad_xor.I}
N 5360 770 5360 740 {lab=bad_xor.I}
N 5360 740 5320 740 {lab=bad_xor.I}
N 5120 240 5160 240 {lab=bad_xor.I}
N 5160 240 5160 60 {lab=bad_xor.I}
N 5160 60 5640 60 {lab=bad_xor.I}
N 1600 740 1600 710 {lab=event_xor.I}
N 1600 710 1800 710 {lab=event_xor.I}
N 1600 710 1600 240 {lab=event_xor.I}
N 1800 710 1840 710 {lab=event_xor.I}
N 1800 710 1800 740 {lab=event_xor.I}
N 1600 240 1640 240 {lab=event_xor.I}
N 1840 710 1840 770 {lab=event_xor.I}
N 1840 770 2120 770 {lab=event_xor.I}
N 1640 240 1640 60 {lab=event_xor.I}
N 1640 60 2120 60 {lab=event_xor.I}
N 2720 740 2720 650 {lab=l1_ff.net2}
N 2720 650 2780 650 {lab=l1_ff.net2}
N 2780 650 2780 180 {lab=l1_ff.net2}
N 2780 180 2720 180 {lab=l1_ff.net2}
N 2720 180 2720 90 {lab=l1_ff.net2}
N 4040 650 4040 740 {lab=l1_ff.net7}
N 4040 650 4100 650 {lab=l1_ff.net7}
N 4100 650 4100 180 {lab=l1_ff.net7}
N 4100 180 4040 180 {lab=l1_ff.net7}
N 4040 180 4040 90 {lab=l1_ff.net7}
N 480 770 470 770 {lab=a_n}
N 470 770 470 410 {lab=a_n}
N 470 410 -60 410 {lab=a_n}
N 470 410 470 60 {lab=a_n}
N 470 60 480 60 {lab=a_n}
N 5680 90 5680 170 {lab=bad_xor.net_1}
N 5680 170 5680 180 {lab=bad_xor.net_1}
N 5680 170 5880 170 {lab=bad_xor.net_1}
N 5880 170 5880 180 {lab=bad_xor.net_1}
N 2160 90 2160 170 {lab=event_xor.net_1}
N 2160 170 2160 180 {lab=event_xor.net_1}
N 2160 170 2360 170 {lab=event_xor.net_1}
N 2360 170 2360 180 {lab=event_xor.net_1}
N 120 770 -70 770 {lab=b}
N -70 770 -70 450 {lab=b}
N -70 450 -70 60 {lab=b}
N -70 450 -60 450 {lab=b}
N -70 60 120 60 {lab=b}
N 5680 590 5880 590 {lab=bad_xor.net_0}
N 5880 590 5880 740 {lab=bad_xor.net_0}
N 2160 590 2360 590 {lab=event_xor.net_0}
N 2360 590 2360 740 {lab=event_xor.net_0}
N 5120 180 5120 90 {lab=bad_xor.net_2}
N 1600 180 1600 90 {lab=event_xor.net_2}
N 2920 650 2920 740 {lab=l1_ff.net11}
N 2920 180 2920 90 {lab=l1_ff.net4}
N 3280 740 3280 650 {lab=l2_ff.net5}
N 3480 650 3480 740 {lab=l2_ff.net6}
N 6440 650 6440 740 {lab=l2_ff.net1}
N 3280 90 3280 180 {lab=l2_ff.net7}
N 3480 180 3480 90 {lab=l2_ff.net8}
N 6440 180 6440 90 {lab=l2_ff.net1x}
C {devices/ipin.sym} -60 410 0 0 {name=p113 lab=a_n}
C {devices/ipin.sym} -60 450 0 0 {name=p114 lab=b}
C {devices/ipin.sym} -60 490 0 0 {name=p115 lab=early_q}
C {devices/ipin.sym} -60 530 0 0 {name=p116 lab=selected_q}
C {devices/opin.sym} 7540 450 0 0 {name=p117 lab=bad_bit}
C {devices/opin.sym} 7540 490 0 0 {name=p118 lab=event_bit}
